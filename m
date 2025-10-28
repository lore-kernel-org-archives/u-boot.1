Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E73CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 15:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA5FE82A9E;
	Tue, 28 Oct 2025 16:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ygkdd8Gn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33BC3832AD; Tue, 28 Oct 2025 16:16:30 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5600F80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwv963lGrz9tRH;
 Tue, 28 Oct 2025 16:16:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761664586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rNRHKBp+MPZicuyVZ8cdd6zwFHX1y+Lq2+AFESoBgC4=;
 b=ygkdd8GneAUEctk7REXH2idyJNQX9EnXqgeUbXyDOd2LB2zIKwYIVHatPpZHSvQpGqzcGO
 7WeuIJiZQsFoyD+9TaDIukqAxeRcQ/ob/0errh//IGjbt3LcnpLduupJbfMEMuWwOeenbN
 y5hQofLqFTBCTCLgFfhjRSZBEkVnZ2Ih0PjSZmQ7j7zM2vBkHE90Aay6BaKGZ3fkShRuKs
 CcbEpb3DkyH0Dr+Un7y+HQMtPX25i81M0iwDPfgG3jm4BfcXEQEEHDi7ephxPKVwhCH91L
 5eHIcCxLXxwfyAn55IfqUguZmuWdp2ivDhdyoAn2gsH4nkLXAiWeTiuWNSyxUQ==
Message-ID: <2a3421c8-b7af-4c6e-91c5-cbd08c9f3dd5@mailbox.org>
Date: Tue, 28 Oct 2025 16:16:23 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] firmware: scmi: Drop mmu_set_region_dcache_behaviour()
 misuse
From: Marek Vasut <marek.vasut@mailbox.org>
To: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>
Cc: Alice Guo <alice.guo@nxp.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB84593511CF2B43470CDD8ABD88FDA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <68e5af37-1511-4720-9172-751d5b788c39@mailbox.org>
Content-Language: en-US
In-Reply-To: <68e5af37-1511-4720-9172-751d5b788c39@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d76de3509870c2a19f0
X-MBO-RS-META: fgtrg8y4qbui8pcwoj5sgcmby4j4kpkd
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

On 10/28/25 3:37 PM, Marek Vasut wrote:
> On 10/28/25 9:25 AM, Peng Fan wrote:
> 
> Hello Peng,
> 
>>> Subject: [PATCH] firmware: scmi: Drop
>>> mmu_set_region_dcache_behaviour() misuse
>>>
>>> MMU region cache behavior configuration for SCMI/SMT mailboxes is
>>> platform specific. Even on ARM systems, the mailbox memory may not
>>> even be located in any cacheable MMU region and may instead reside
>>> in some SRAM. Remove this non-generic cache behavior configuration
>>> code from generic code path.
>>>
>>> It is unlikely that any platform is affected by this change if it did
>>> configure its MMU regions correctly on start up. Platforms which might
>>> be affected are i.MX94/95 and STM32MP.
>>>
>>
>> If the memory is mapped before running SCMI stuff, it is ok.
>> But if memory is dynamic mapped at run time, there might be issue.
> 
> I wonder ... should ARM/ARM64 define CONFIG_HAVE_ARCH_IOREMAP and 
> implement actual ioremap() function which changes these cacheable 
> properties accordingly ?
> 
>> I saw TI platforms has some changes to use dynamic mappings,
>> I have not read the details, TBH.
> 
> Can we put the TI people on CC here ?

+CC Anshul

-- 
Best regards,
Marek Vasut

