Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C06CD343F
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 05:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4D98056B;
	Thu, 21 May 2026 07:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eJJAMb5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231CD805D7; Thu, 21 May 2026 07:45:47 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F3AB80433
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 07:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgbJ9QU9VrwAS4xPdG5t8BwI34wjk5pliRyi28gr54YcQ239R5/6eyDs9CrepPfHKuAiv5Fp4CAGE1GvGHxuDFw6ogs41b2mM3MAkB7Yrzb81Rn9bh8A38ft3EyJd8+WEbGbCgTkCB/D96URDksgZSyvZPczJZKyKZjvOyoJ5JjpCs4UBIsP+nW/g2goZ6yqrLj1IbArmtaV9cAaQr4ZX9xDRVCOCBbke0GqPEkea7fpZQCKfwpbKQEtgVDkkMH9n1ssd9PfzuDlIfmrH2OE2GKtdYtDeupqxIRGAhsEs8KE8BTGrwhB9dSA+gOPyLGrX0Lhyx7Ry3B8107w1xXssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oCncTPDJCWq/WmYvcZOrhzX+DNot0rSEIbOKcK/AvU=;
 b=Mf8RXL8hXOORPekcZyBO9NKMgjRWJ3q7SQQeDcDYkFOfrZLh7sLsrNb79ubUCa/9qYnArw9Zc2W6h53yyHs171DmNxQbPYFz/OGlpFnxubmGJQrhafApItdXCUCfkBNghIbxEalt7YfG6kUcwZNM72MTEVg6z7mBoHyDN7kuGI4oowSeAE2tK9Iw59U2d6AjcGj5Imz65zbRlKJMOeP6NCCf5LqjVEk40CCznHMXVBkdJ+hXDP3aUno7tJmNThptqUzmQ+ZqzV3WHG2krbOaT/5KSO4sXB1s8H9F8N9P3766xNN4o+ttLOrt1KV8pu20R6tG6bKViGG1lz8MuRletg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oCncTPDJCWq/WmYvcZOrhzX+DNot0rSEIbOKcK/AvU=;
 b=eJJAMb5gZCbMSjLXlE8Xy8OfAvL21QicNxNKsdFWGrUAydqw4kCh2xI5EAkRZkrR76oTgXnaz0xaySWkT48n6hd2Rwh1REtBHDesIJw+Eep9F33NMaaufMSdNc6t4cKFIfxX3wmaZ1/Q51t4z75oDF3gFwj9Fg1auC1Iw27XK5I=
Received: from DM6PR02CA0111.namprd02.prod.outlook.com (2603:10b6:5:1b4::13)
 by BN0PR10MB4951.namprd10.prod.outlook.com (2603:10b6:408:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 05:45:41 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::a4) by DM6PR02CA0111.outlook.office365.com
 (2603:10b6:5:1b4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 05:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 05:45:41 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 21 May
 2026 00:45:33 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 21 May
 2026 00:45:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 21 May 2026 00:45:33 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64L5jUjI2946273;
 Thu, 21 May 2026 00:45:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 7/7] doc: ti: k3: Add section for DDR configuration
From: Neha Malcom Francis <n-francis@ti.com>
To: Romain Naour <romain.naour@smile.fr>
CC: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <s-k6@ti.com>, <bb@ti.com>, <m-chawdhry@ti.com>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>, <gehariprasath@ti.com>
In-Reply-To: <92bf5ca4-10a4-40fa-a920-1408779cb181@smile.fr>
References: <20251103071035.674604-1-n-francis@ti.com>
 <20251103071035.674604-8-n-francis@ti.com>
 <92bf5ca4-10a4-40fa-a920-1408779cb181@smile.fr>
Date: Thu, 21 May 2026 11:15:29 +0530
Message-ID: <177934232976.132247.8489462215246044979.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779342330; l=2497;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=DRw8OH8w9omu9Qh9jPWg96CQHC7dJQIsuSLPqEwJiF8=;
 b=5eQO5sF9WUlvid2/Jb0kDUrqmI3HaYf7/zeZghaLJnXLpsyUMIV3lOmKzAQx78sMsCQr2dHAN
 6Dc/BhJ3UBOBPxvypxsg6XZfPAgnnfj9xriajMHXOCICtbitNXyAnCd
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|BN0PR10MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: f394db82-638d-4bf6-717a-08deb6fc318c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099003|6133799003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: n6BhAr0uS4QH3sHq7GD0UgO1spDHQr+6OFnf6sQDz8bBDcqmYkX0cMQLKv4FFjl5nsytgTeEid8LYRKoK8xFiMhq6RbCp+UEeh/BQEsnCWfME/dQtzDM2bpAQZH0lIUxriO2xHH8Wnb/Pug7RvAHtDFdaq7ETNZjBLzkVURf6PCY6H5Ila+kr8AhJCWx2vOj+4NpECu+vpjKs/UhGOm4BRStGixye96/jD+TCCj0Rl5RQGPLSrrMukA2URRJ908IBuayq1+7WDxsh1gMOUPJtL3ISkHIYMOva1H2UFN2R0Bih9AEPSDIBifsk5xcF+9uZLH7orOWysYQpbYekynRZIHLGFeOo+xogm2ySsJlCuci6QvK53XhOR2UL4UzYmv8L3xV4sptbR5GNZ+Gep8m3vb1kZxVoHTmI8wnL699KVReNF00LBKRnnbIa6JqMOHD/FeoiDmvrxkAUDduiP+0GMVKy6vUpebKYUjAxToPL72dEaFC/OjNnyahbGojIgs+GXlfvmws8o1I45ADAUFKgLGn2TTJ6pv6KBarTj7XVSebg5SazdW+srq6rz5CCVvzH5uB0/YIiAdrFsxgl2zS/y1v7QJStr/MXLAUaHAcMRJLMX09htuGt+lyMjSuYVkE17oC9vcV2AlHIq7eD0DEp3uhJyRpoMC31bNslhiKyXbBbTPT6Argm1ITP+s05+6ywEuqngh1xggtchG6IBz/EGUfRd/q26l+K2TX2ekT1Zs=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(6133799003)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7jovKazJUJrYvl9XeQ+fm8G9sqzDehxgJ+N4BQoFdUsnt9E0/vlbPMbNxZp0+xlDBcOFviR6BMiBTVDpElvD8K/55hWi0repg7B7XGmLK0F4AmjIvAcN35praV71UHgICv2OH0NvD02lpFZEJIWa3JjNWYgle0XjXLHNJ0pK3UvlaIq4FV4nabS1GFkFobst6IAU/DHWvvEfeEd5Cnaj3lb4wRmMSy0/I7+37kksYSibegGvxdtshsdftUvJHs9H4eTQnOihagNKtra5NIFSWCks82iBDfEzxSUfml6Jc9zJhWRmBemsgaB19MiK8blx7lWjIfbX8VGc86cbgrh6yrbY/2xP+Q+Loix8Ia0vtJqQLs9qW5HzuOcSz9te4mjVwRTX6KUtsHWszdbEE/WYNCNBuDcMynx7UpETbWPwmOh08e2KzhH8clvZI/EsXIC/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 05:45:41.1436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f394db82-638d-4bf6-717a-08deb6fc318c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4951
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

On 2025-11-03 15:35:30+01:00, Romain Naour wrote:
> Hello Neha, All,
> 
> Le 03/11/2025 à 08:10, Neha Malcom Francis a écrit :
> 
> > Add a concise section for DDR configuration pointing to the public tool
> > that can be used to generate the configuration DTSI.
> > 
> > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > ---
> > Changes since v1:
> > - new patch
> > 
> >  doc/board/ti/k3.rst | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> > index 01fb9411688..de66b830703 100644
> > --- a/doc/board/ti/k3.rst
> > +++ b/doc/board/ti/k3.rst
> > @@ -649,6 +649,17 @@ Refer (:ref:`U-boot ARMV8 build <k3_rst_include_start_build_steps_uboot>`)
> >     This will need to be explicitly disabled by changing the boot_targets to
> >     disallow fallback during testing.
> >  
> > +DDR Configuration
> > +-----------------
> > +
> > +The K3 DDRSS driver (drivers/ram/k3-ddrss/k3-ddrss.c) configures the DDR during
> > +the R5 SPL stage. The driver utilizes an auto-generated configuration file
> > +containing necessary settings for the DDR. It configures the frequency, timing
> > +parameters, training algorithms etc. for DDR initialization. The configuration
> > +DTSI can be generated using the `Sysconfig tool <https://dev.ti.com/sysconfig>`_
> > +and selecting the software product as "DDR Configuration for \*" as well as the
> > +required device.
> 
> Thanks for promoting the new K3 DDRSS configuration tool (v0.12.00)!
> Until recently, I was still using the old spreadsheet (K3 DDRSS v0.10.0) from
> outdated application note [1].
> 
> The FAQ post [2] is really useful for custom board DDR configuration but
> somewhat difficult to find/notice on e2e forum.
> 
> Note: The K3 DDRSS sysconfig based tool can even be used offline [3].
> 
> [1] https://www.ti.com/lit/an/spracu8b/spracu8b.pdf
> [2]
> https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1482402/faq-tda4vm-tda4x-dra8x-am68x-am69x-lpddr4-topics
> [3]
> https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1378443/processor-sdk-j784s4-tda4ah-offline-ddr-configuration-tool---latest-version/5269621
> 
> Reviewed-by: Romain Naour <romain.naour@smile.fr>


Thank you for reviewing as well as pointing to further documentation. Will take
the feedback on the e2e and have a form of it on public documentation as well!

> 
> Best regards,
> Romain


