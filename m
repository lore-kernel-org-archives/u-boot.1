Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FBDCD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 07:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 935158460E;
	Tue, 19 May 2026 09:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pjV2xYj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC9C68465A; Tue, 19 May 2026 09:52:32 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B2E584119;
 Tue, 19 May 2026 09:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Auq9MyLbBgk0as1dffxQy2QOFHtPI3AcvZRwrJSg4GAujntI2C/WdQTz2G65eyRlLZ1bNvPx2JF4oO+2+IdczJYNiT/ItKSu0/6Ltm+s9heHDqIfFx5BoW18LEDxzCiIqa5f53AKKh826SMConSlVje99H7JQsqfy8hvi7Gy9ZZ+8KdQfp/P5j3DI9p5lVdCDB9tMn9vbAf5FPKe6sRcKd3DydpuBrtGKHSYONM8fXnHMbeWziLUQPaKPMxVplpgifjd3F+Ib1XWVLFPzgxMrX+x+iX342ksMxFo+2fi1EGCzBdomzTKkHUy+DCf6RudsgRGHwsCRufscOO4U4ZWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYeGvkedgprjLsDMkuIKt8LdNwCxyOiYydG4vnm5PXw=;
 b=CO+oR86txUpHMw0yAiFGRE2UC3iykOnBR0VHvR09uSe/fZZinZllvqxKqR8YL7YuYrn3STMm0wb1NRee/uF7G+A4RU1x2x+mYZ6O5e0cBdIR9dMx30fkm7BgrVoNSrIqvacOO8O6JNstNMMGotNJHuXldL/LE+atX+snNMPPggCuZLd2Qe3H+lC92q6+zHiE/o0khR61QzYw+8Oi1bw7VElCTnsgFdsYJplZkunSCNKXFK53Jj5IVYwIG5D2t3vUOmhYgdvsf+jXBCpl25qAqhSgKAt2Y2Tvp1iOgPXznz1wUjUJ3ELpjbu9QPjd2tjUTjlSYBNlwyXmg2SWqdyIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYeGvkedgprjLsDMkuIKt8LdNwCxyOiYydG4vnm5PXw=;
 b=pjV2xYj239cDrLXFBt8t52XmAJCcQprgaSxQtOsDTcEf/ECwbH6QNwDJ3RPcI1orvMlEACHkvMO9Sjsxd+GxztKLiio6e9r+HROh92UGq711/NMfjOz69FL5VVDtLolw5OgO7Zetpul0nFSS2ArhTms8urUQh0QLvlGJmAOv0Wo=
Received: from BN9PR03CA0850.namprd03.prod.outlook.com (2603:10b6:408:13d::15)
 by CH3PR10MB7529.namprd10.prod.outlook.com (2603:10b6:610:154::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 07:52:25 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::1b) by BN9PR03CA0850.outlook.office365.com
 (2603:10b6:408:13d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Tue, 19
 May 2026 07:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 07:52:24 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 02:52:21 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 02:52:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 19 May 2026 02:52:20 -0500
Received: from [10.24.50.71]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64J7qId43588531;
 Tue, 19 May 2026 02:52:19 -0500
Message-ID: <f697d6c6-3cf9-41eb-a833-880a892643c1@ti.com>
Date: Tue, 19 May 2026 13:22:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: In-tree Python tools (patman, buildman, binman, etc.)
To: Greg Malysa <malysagreg@gmail.com>, Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
References: <CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com>
 <CAFLszTgbu6Q3r5D4-ijH5Vqhwp6p1j3PMLZhi0QnYxyuUzcRmQ@mail.gmail.com>
 <CABdDSeVq_R9KSFf2dydzNmCgrsCQfEneDCAgR-h=ieAx3vWQLQ@mail.gmail.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <CABdDSeVq_R9KSFf2dydzNmCgrsCQfEneDCAgR-h=ieAx3vWQLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|CH3PR10MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0df3f0-8c6c-4ff6-c735-08deb57b90d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|4143699003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: cLfNsE3ZR1yJt6vRa6xqg37/+xASyL4eF1mINdWX0Y+fb3LHkBPuUqmrqwEMPm5bXiuprhwtU0SphdESEa1axAIvDtqe2LUbdpTftooxmObndk9CRo4kPohIL68yQZFoJPWh65U8iu6jDLf2/rB1uW5hen0VnjwmrdEp2UAy6pIjtpk6ESsSwpFelda7auPD8L3B7C0tQkriJWgqZtdgNg6GX2Mk2xR0vznVkxw/hiI2AVphz2EwmUrMZb6XGk/DrZ0VU4EnvvgS8i/NANzvLKMwTO9EoP2RKpyyL+qcNbU8u5+xdvgZB8yHuMD/TWRFlT9uEyV1Y1nK1CYtzEdNRUzp8VtIoycABw/ihsiaZdZFLGk6VOj/qwUtqnCjJYWxGiVUK6/92MMnHCqydWp1imoYvxN2zLkwnI9rS9qlSoVe9ZDZeQL3uFh84WqQybHiMgLkpuUBaKDjpXZvhDm3GFPqHEyJowkXMEdKq83TvlaKn+wHGLVsnsH2Q8DCs4jOLOR2gjkjOITY8y1Fe4Anuz7COtyWY8KlngNKpwwXOoBYjrSQo1zKkztqUBq3BghEq6BMeZfHkkAOjn/qYr8jGg7c/CHTeT18RVXEz0aY96DH1MlS79XpfZuePieFsSiGI7e2me8XoGbIW3GtgaJh7lwBU21A9+cSEfnLpHxPP7ndonW3zZbh1wZY7fw9oDvC
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(4143699003)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 38v1I5yULgmAaRiDE9x2wvYpVJVkH4y2DaJ/jeTake4FT1llMOU0BJjuVRNkFcK9BWXbwcKwsEyD9NM66qlcHpG+TzEuT/yQw1npXD4gEZ6TBxYqBzakouFXn0q1E3CxiGFQWUjNljhWehUSgZIQkmzxN835cuYHwwPitinKnFN3v8Q9+C+oq4h+Z1j8k+0vPHUwPyLFSCOroJ/45wEA6Ql2Riqp/W4MrsQa3PnRFgZSAD8OQjQB7ifCPWS1z08LtciBBcVuxy4Bq68QYC54PfVr6/HjAH/Dts9samwFn26V7q0OXdjSp4Uc9aaJPoC0BbiN8mCWQgH3uIVCbfc3g3+cwt2oQ4IUCXZ70YRCQ3m1eGig2A7GNZp7a9vbsUt7+1eZKJ9OVfDZUTJXiotdeqp4LbAB5d/0YBifxWO2nm1rw+udQha5LkkRRP+LCRdI
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 07:52:24.7143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0df3f0-8c6c-4ff6-c735-08deb57b90d0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7529
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

On 16/05/26 03:24, Greg Malysa wrote:
> 
> I'm not sure if this is the place for this discussion, but I don't
> really understand the placement of binman. It seems like a meta build
> tool that combines multiple build artifacts into one, but integrating
> it as a build step in uboot is strange, since we might rely on TFA or
> even a kernel image that is built externally (which is what we tried
> to do originally for the ADI SoCs when we thought binman was a
> necessary part of getting the boards into mainline).
> 
> My ideal usage would be something like: in my yocto recipes I maintain
> configuration settings that are passed to uboot for any hardcoded
> addresses or offset, and I also fill in an image layout dts with those
> details (both happen programmatically from the single config), then I
> use binman instead of wic to create an image for my entire boot
> device, or just a FIT image for kernel+initramfs, and ideally I can
> integrate code signing or dm-verity immediately at this point, rather
> than some of the hacks I've had for it in the past. We tried to link
> some of the offsets and image details to Kconfigs at first to
> propagate from a single point of configuration, but binman is not
> selectable as part of a defconfig normally (I think?), so having
> dependencies and configuring the details in a normal way didn't really
> work and our result was pretty messy (and is being removed for that
> reason).
> 
> If my understanding is correct then it is a kind of competitor for the
> wic tool we use in our yocto builds. To be frank I don't like the wic
> input format and a device tree-based solution, especially with more
> options, would be a great alternative, but I think binman would need
> to be outside the tree for this to be the most useful. I don't know
> what buildroot uses by default but surely it could benefit from this
> kind of a tool for image assembly as well, especially if it emerges
> with the most robust set of capabilities.

I agree with binman having use cases that is not limited to U-Boot and
we are gatekeeping the tool by keeping it within U-Boot. There is
considerable signing use cases with HSMs [0] that can be extended to
non-U-Boot firmware packaging. But considering a huge chunk of U-Boot
currently depend on the in-tree tool for the build, this may be a longer
effort but I do think it should happen eventually.

[0]
https://osselcna2026.sched.com/event/2JQrn/leveraging-u-boot-binman-with-hardware-security-modules-hsm-for-secure-boot-riya-aysola-judith-mendez-texas-instruments

-- 
Thanking You
Neha Malcom Francis

