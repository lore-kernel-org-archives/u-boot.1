Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289E5CCF9EE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 04:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 246C2838AE;
	Fri, 31 Oct 2025 05:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bhmLxZ3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88FC38331F; Fri, 31 Oct 2025 05:10:51 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D7CA836F0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 05:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cySFg2lfSz9sss;
 Fri, 31 Oct 2025 05:10:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761883847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EgwMnbw7dvag5fW+TNAsUTu9H92eYPuaVZ96pF8hGj0=;
 b=bhmLxZ3HeTh9leJR7qcrWc5Qipo6xpBT5a98f0IHSLboaz7afj8TdicEc0W8Gmmcjte1tF
 zvnGm+mCuE3OGWgB26wJVp16wDh/Dfe6/32030CiZimovcsShP3N2FeUO84oaIEkdbt6Gm
 rJZAGnsnkKmFYP+n7S/RxlVMvSnM/S7wrF8ZNHWmMVGvZkgLV1Lw8NDPOFNyEWB+CFMPGF
 hlC6eAt/OiGZHomk16xepTZhgtahFrn4JPk+RJv+8qtBTtGm6845CZO/FxeYjPkNEpW/LL
 601mzeiw5TRb/dA2m8vqYsE8rMI5TRyni3xN6Q2yrZ4EEdcmBpW6od/HhjmABQ==
Message-ID: <ad762bb5-fb1d-47db-94ca-b8115f077e6f@mailbox.org>
Date: Fri, 31 Oct 2025 05:10:44 +0100
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gZmlybXdh?=
 =?UTF-8?Q?re=3A_scmi=3A_Drop_mmu=5Fset=5Fregion=5Fdcache=5Fbehaviour=28=29_?=
 =?UTF-8?Q?misuse?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Alice Guo <alice.guo@nxp.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB9644A04B5499EA2BDC3130A7E2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <e7063153-036d-4079-b9c0-252a5d1eb364@mailbox.org>
 <PAXPR04MB964488C508F283B14E8B9B11E2FBA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <eca51372-3bcd-4873-ba47-c06781d18466@mailbox.org>
 <PAXPR04MB964436F50D41BF186019598FE2F8A@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB964436F50D41BF186019598FE2F8A@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: s3766gds6zcwbi6apu5ib65hk1rzx71g
X-MBO-RS-ID: 72a0379134ddde88b3c
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

On 10/31/25 4:36 AM, Alice Guo (OSS) wrote:

Hello Alice,

>> Would it be possible to fix up the SRAM mapping in:
>>
>> arch/arm/mach-imx/imx8ulp/soc.c:static struct mm_region
>> imx8ulp_arm64_mem_map[] = {
>>
>> ?
>>
>> --
>> Best regards,
>> Marek Vasut
> 
> Hi Marek,
> 
> Configuring the memory region for SCMI communication as MT_DEVICE_NGNRNE resolves the issue. With this change, SCMI works correctly and the i.MX8ULP boots successfully.
> 
>                  /* SRAM0 (align with 2M) */
>                  .virt = 0x22000000UL,
>                  .phys = 0x22000000UL,
> -               .size = 0x200000UL,
> +               .size = 0x1f000UL,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +                        PTE_BLOCK_OUTER_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               .virt = 0x2201f000UL,
> +               .phys = 0x2201f000UL,
> +               .size = 0x1000UL,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               .virt = 0x22020000UL,
> +               .phys = 0x22020000UL,
> +               .size = 0x1e0000UL,
>                  .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>                           PTE_BLOCK_OUTER_SHARE |
>                           PTE_BLOCK_PXN | PTE_BLOCK_UXN
> 
Excellent !

Can you please submit a fix like this upstream ?
