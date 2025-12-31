Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D293EE6428
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 15:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCEA083F36;
	Wed, 31 Dec 2025 16:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N4m7MNGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D0084027; Wed, 31 Dec 2025 16:53:30 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B8E083B82
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 16:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dhDyG1Fn2z9sv9;
 Wed, 31 Dec 2025 16:53:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767196406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLlHHTuk/48kvrACvzFPo2peP+gHjeGf/tZgamez0EE=;
 b=N4m7MNGTixi1CEj2Mbc6Ug5sZey08dy82uH+yD39mh+InxnFUATLzzXzTUkCtHrzSRzf6w
 cbUsJS/L2PbxONFObsaFY9hYWyU1Yop4Qm6Z497+nQfaNvYMfHAktwm44gBKp9Yprbxl5x
 DNx0HiQq/m90m7a8+sUohg5/iHETwRM8z/XYGdpzAwonYNdxnQvMMaYgZYsMuWkv3ShoGG
 Fmpc+WaYL5O/L52wwSpyncH/GcTzHRc0Oq3ZTxprJF0aMqAD87jpKs20Q3nHjZsOnQtLDI
 Y4CG7enXYU3Pp+EUZ/Ld+RSKr4LCsvsEneMKo8FvvUTsnwzTmhI+Hu8tL6JZ7Q==
Message-ID: <f6140b6b-2dba-4bfe-bdf8-11a9793916ee@mailbox.org>
Date: Wed, 31 Dec 2025 16:53:23 +0100
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <869f8843-8d43-4c1f-b6ae-0116fcf64ac4@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: tn5wpc4nfgksna7i85yj4aqwgmdoxxej
X-MBO-RS-ID: f38837e11efdf9c06a3
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

On 12/16/25 4:35 PM, Patrice CHOTARD wrote:

Hello Patrice,

sorry for the late reply.

>>   	/* WWDG */
>> -	STM32_GATE(CK_BUS_WWDG1, "ck_icn_p_wwdg1", "ck_icn_apb3", 0, GATE_WWDG1,
>> +	STM32_GATE(CK_BUS_WWDG1, "ck_icn_p_wwdg1", IDX_ICN_APB3, 0, GATE_WWDG1,
>>   		   SEC_RIFSC(103)),
>> -	STM32_GATE(CK_BUS_WWDG2, "ck_icn_p_wwdg2", "ck_icn_ls_mcu", 0, GATE_WWDG2,
>> +	STM32_GATE(CK_BUS_WWDG2, "ck_icn_p_wwdg2", IDX_ICN_LS_MCU, 0, GATE_WWDG2,
>>   		   SEC_RIFSC(104)),
>>   };
>>   
>>
> Hi Marek
> 
> Can you give this patchset a try on DHCOR board in SPL ?
I have bad news, the SPL does not even start with this, no output on 
UART even. The problem seems to be in 3/3 , if I apply only 1/3 and 2/3 
the board does boot just fine.
