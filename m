Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3A3CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 836DF82A9E;
	Tue, 28 Oct 2025 15:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pCKTMpUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A733B836C8; Tue, 28 Oct 2025 15:37:54 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C73CA80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 15:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwtJZ6BThz9t13;
 Tue, 28 Oct 2025 15:37:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761662270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awk8m1BFx7LaoXVW3+FBe2c1gklnOFl6jTCWRrM2cdo=;
 b=pCKTMpUJohl9Sc/eVYUxTh/eBeso4QyM1h8ctgflRvDronpHOV2nc8Ahh1ftj3DwwQRP0i
 CqHG10PFjO8TFeCbID/Xt6vYWT17Y5qZJE/ODMfpTlHQ9tVTb8xX6lI8ZLQtL4D/mjmNV7
 vS6zZc4W0C7fqR9ICUnAyoQsJ4jTk/6gi8KbgqbJokCK9kdgO6XXtbXFvD8pFFI/x4SDWY
 OVI+ILqo74k3c5EYQoQKCT2pFAmK4P3d5LFWqAz1r1g4UyX3QOGUd7WBAbj09eHEJM3StU
 vKSb4PCIMUTbg/6Y0VFJTf0BliEbPc4iaksXgp4zsD8Pw6zN6bBm/2GLszduDQ==
Message-ID: <68e5af37-1511-4720-9172-751d5b788c39@mailbox.org>
Date: Tue, 28 Oct 2025 15:37:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] firmware: scmi: Drop mmu_set_region_dcache_behaviour()
 misuse
To: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Alice Guo <alice.guo@nxp.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB84593511CF2B43470CDD8ABD88FDA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB84593511CF2B43470CDD8ABD88FDA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: zt9ie4cche8ziefts541hzd93kxt7eoc
X-MBO-RS-ID: cc5c3c2acd608102644
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

On 10/28/25 9:25 AM, Peng Fan wrote:

Hello Peng,

>> Subject: [PATCH] firmware: scmi: Drop
>> mmu_set_region_dcache_behaviour() misuse
>>
>> MMU region cache behavior configuration for SCMI/SMT mailboxes is
>> platform specific. Even on ARM systems, the mailbox memory may not
>> even be located in any cacheable MMU region and may instead reside
>> in some SRAM. Remove this non-generic cache behavior configuration
>> code from generic code path.
>>
>> It is unlikely that any platform is affected by this change if it did
>> configure its MMU regions correctly on start up. Platforms which might
>> be affected are i.MX94/95 and STM32MP.
>>
> 
> If the memory is mapped before running SCMI stuff, it is ok.
> But if memory is dynamic mapped at run time, there might be issue.

I wonder ... should ARM/ARM64 define CONFIG_HAVE_ARCH_IOREMAP and 
implement actual ioremap() function which changes these cacheable 
properties accordingly ?

> I saw TI platforms has some changes to use dynamic mappings,
> I have not read the details, TBH.

Can we put the TI people on CC here ?

-- 
Best regards,
Marek Vasut
