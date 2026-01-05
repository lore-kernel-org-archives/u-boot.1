Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9474CD0402
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 21:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10A483D17;
	Mon,  5 Jan 2026 22:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="B7a7RDrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C7C183D62; Mon,  5 Jan 2026 22:22:32 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9929383A24
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 22:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dlS1c4fPVz9tRH;
 Mon,  5 Jan 2026 22:22:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767648148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffsxHHAYFpTvcyZckAXruY0WAaKny5nwI+zaRh+eAxc=;
 b=B7a7RDrRzN8ZigRVoEb0Na5r2APZXHRNjEtIGd0aLRJkrz48GlrZ0z9Db4jxoWaP1kAqpM
 U1sFQZ8duu8aZt2gkkIpT2XIGq6x0prZuNu0GDXLNRsu337k7LtxBZ4CAwM4QX2MbZJLKy
 2Ea9MWfaoMbrlsl4P05qWsNxqwF6EZei9zdqbQxt9A89l8XyD6Y7gRxdDdP8IWhBg+jkCs
 Aa7mwuq8iQKECP7ouFr7levt1zxia3PhiRnAPoQwSQW08R7iZCYX62EIhGCy52LvXs1V5b
 Nawf1QPMmhby/FXn8/QZopt2NW5dRrApXRH+awOaJpDnA77k5Zc65RTPEqQeaA==
Message-ID: <5a4ea825-3a89-4856-b9d8-d1df827f9b9c@mailbox.org>
Date: Mon, 5 Jan 2026 22:22:25 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/3] clk: stm32: Update clock management for
 STM32MP13/25
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>
References: <20251215-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v3-0-d055da246e55@foss.st.com>
 <20251215-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v3-3-d055da246e55@foss.st.com>
 <869f8843-8d43-4c1f-b6ae-0116fcf64ac4@foss.st.com>
 <f6140b6b-2dba-4bfe-bdf8-11a9793916ee@mailbox.org>
 <020df345-65df-4d5b-945c-36db65428587@foss.st.com>
 <5f0174c7-6791-4fc3-80df-62812baed40c@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <5f0174c7-6791-4fc3-80df-62812baed40c@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ad41856f0f562ad68a1
X-MBO-RS-META: qusfn1d9uni66as1jwsugdtuiyetffwt
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/5/26 3:30 PM, Patrice CHOTARD wrote:

Hello Patrice,

>>>>>        /* WWDG */
>>>>> -    STM32_GATE(CK_BUS_WWDG1, "ck_icn_p_wwdg1", "ck_icn_apb3", 0, GATE_WWDG1,
>>>>> +    STM32_GATE(CK_BUS_WWDG1, "ck_icn_p_wwdg1", IDX_ICN_APB3, 0, GATE_WWDG1,
>>>>>               SEC_RIFSC(103)),
>>>>> -    STM32_GATE(CK_BUS_WWDG2, "ck_icn_p_wwdg2", "ck_icn_ls_mcu", 0, GATE_WWDG2,
>>>>> +    STM32_GATE(CK_BUS_WWDG2, "ck_icn_p_wwdg2", IDX_ICN_LS_MCU, 0, GATE_WWDG2,
>>>>>               SEC_RIFSC(104)),
>>>>>    };
>>>>>   
>>>> Hi Marek
>>>>
>>>> Can you give this patchset a try on DHCOR board in SPL ?
>>> I have bad news, the SPL does not even start with this, no output on UART even. The problem seems to be in 3/3 , if I apply only 1/3 and 2/3 the board does boot just fine.
> 
> Hi Marek
> 
> Happy new year ;-)

Thank you, Happy New Year to you too.

> Have you tried with DEBUG_UART ?

No, that is not enabled in the DHSBC config.

You should be able to try the SPL on MP13 EV if you pick the changes 
from these three commits (a few DT changes and a few config options), it 
should be straightforward to port over and help you debug the problem:

bf53344bff8d ("ARM: dts: stm32: Add STM32MP13x SPL specific DT additions")
1143fd4c3507 ("ARM: dts: stm32: Add SPL specifics for DH STM32MP13xx 
DHCOR DHSBC")
998da69da678 ("ARM: dts: stm32: Switch defconfig to SPL for DH 
STM32MP13xx DHCOR DHSBC")

If this doesn't work quickly for you, I can try to set up the MP13 DHSBC 
with DEBUG_UART later this week.
