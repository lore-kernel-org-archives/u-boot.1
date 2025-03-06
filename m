Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4ACCC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 06:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB265814B6;
	Thu,  6 Mar 2025 07:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2547B80805; Thu,  6 Mar 2025 07:21:09 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6BAE8144A
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 07:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mexBJFHp+6iVkOETEvAIFKO9A8sPnuOxA0VFK8QIAi1BEAlLnbIZDvTyccyH+/gJ77tfgxTM69Fs3ku6hoESHNgk3J73UeIVzesreVaKDODfCMd7iPl/sZf4Bpz5nI8oaeIKEtRRFZA8HFl1Bts0UJYrk+uIwi18mHnZtSsKq1Px4wknZ6Ig6a9SH9vuP3TuMwbscIib/7SRWTrq52fXaSCtIFeT/gWdBm3fawuA8Ih2h6kLRTWvHQrYg9rftPaOf/s2oH5hLCNy585hgqKaTr5Y5LJFw4765PF2rPVMJxAfLM6fGnd+JfvEHxUiCxTEeHcSFIaSMU1cmyYAm21UsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBbY04AM2fpxDBKDKIk+bYB3siZwaaUSrfxXQT7cJyQ=;
 b=OkFy7rgmbTkypO3wxac9La1KGuFfV+xOlbbJ2Z5yRJpQIIAEBV7YBiIeW+gDVNEVgo3GSSX2dkRjLn6EouUhpqK/5oRmwR+zgzadHp4Xec7jDGtpl7BH8sSKgy0cOYFfJfpjuTvVcrT30iH6Sqn3siiRBbqn/1r9rqPv70D2kTOvhHnpwz5lxQaCGQH9WKmiys5eeMmOq6QNSEMPTBrkdco8DiHSOFG4w2nAevCuQqBEQy1MfnZYqDNFGh/MJTi5EpzsI/CK6kZqXSqIZLJGHrppKzy/95Mx6AiBNttuWLA1ysx+TjekOtBvWdgSzjP87TDnoHXcaM2Pk56CxXWQNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.30; Thu, 6 Mar
 2025 06:20:59 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 6 Mar 2025 06:20:59 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v7 8/8] MAINTAINERS: Update Starfive visionfive2 maintain
 files.
Date: Thu,  6 Mar 2025 14:20:32 +0800
Message-Id: <20250306062032.50314-9-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250306062032.50314-1-minda.chen@starfivetech.com>
References: <20250306062032.50314-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::35) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ae5b72-a4d6-4084-c4b7-08dd5c770b59
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|41320700013|7416014|52116014|38350700014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: 8NzRlHFgLwGMY4KTY9mCXOYAWqHjXMwHVVRy3llbQbojBsa4HZM0ayPlIxuErvy4g1YKw+Y1qGLphk/O/3lXpJt3u4BIgz1tr34OyJw5ro9lGr7Sf0wUMzHV3rl2J4D9B5FYQf3+bL6LiyZ5Mnow/wWkuB5Si3DtAm8l1HfHRcXHMDQFvFQYSeL0LLSj5z7NkS5HZ3LvXWl0Re7UJ+MUtGlyiSkx3p9N9vfZ1eB2003dASh37CpPRWT0mYIvT9G4XW/aFXXtloTCoOPVTNyau83H9vdQ8D5Vwo4m/382mjPJC15JO6ZO5DbShLlXRoyO3FuG4sXKWJ75lfMwtiw6d1lxnTg8PPOY1sjkhzaKYR6cTqNSTgxw/nm36ptWt93uK+2ZM2n4b0Qbl47R9Sd0k0aVTiZY6UDeGikiWt/1qTrJ+iH5vKWNL3e1gGtO/FAJBIUNTtsBiipeKZpgszUe+VnhveZOBgBoAt2gnBuFBdDfOMcu0yHZZzBQxf4xylVNIkinYlcwMRZCTvJ13S53KbAM9Ihx6cKVUU7s6Z8LzGfjBFN6a0ugxALANWJTd9engLdvqro1LEni0Bcvu4S5p/sfAwQwKCyCrGtLcugIy9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(41320700013)(7416014)(52116014)(38350700014)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JjX+KQxBSqLdBnnkR1t1usc93y5mEKHsQJZ8qX4x3wOxIwRcbdflvpsjnewy?=
 =?us-ascii?Q?6N3XDlDacptS3yRm3zyWf+v9MZTJ1hOyvuL6AkhYzbCIfM655VWBfpFrnMwO?=
 =?us-ascii?Q?vxpOMWnMlw5ze/Yk49fZkQsHy/ku4V0Ftg+HU7AITAvZmiC92boIEZYZZqf+?=
 =?us-ascii?Q?1cB78IR0U3i3Hs+yrg6WjdE3NBGnuvfrIDwyRWtUTpixcMDrJg7Z4xLuQmuG?=
 =?us-ascii?Q?amKz+wYe5vy/PkjiS+fYfroRXCaqt38txPy+uEVkHE6Sj7KkmaeAgxMJb2vt?=
 =?us-ascii?Q?HxuGKsqvChrrKPub2DPif9KK9XomD/zXPEan5YczfhCxVTMKa/dMh48deB2/?=
 =?us-ascii?Q?4Bx1tupNwyk501wR9JURbOEQbD0prr+iVU6n6nkFzbfnHjUko17MQPNMctlK?=
 =?us-ascii?Q?pCLVHGFdNFHemtoCFK4pvBpD3kzL4dgyHpC4AsixRDdEjCCRG0jyXf5E86u1?=
 =?us-ascii?Q?Y1tZ/smGdiuM92XRKg2eQGh/TarZ++YkrQyzsX/hdkvAMCMvD/xG+3IhupEF?=
 =?us-ascii?Q?QSsU3xSPwoEx3c/my50JNzZr49rc644EYPV2EJ30MwIBBLSD/IuJAkvnChsd?=
 =?us-ascii?Q?oPTmUuPFovK/Nt8eRBHw0+o5tXsGAwDlo1JBeWQOYo/+AjFRmijrbmOdw9jq?=
 =?us-ascii?Q?5OcgWAjAxsCFR4iKrEXcGAufMJOPa5Sjx8qeLlT7c7TvLXVYUG36Pn/OPiEl?=
 =?us-ascii?Q?XHPH9NoRIjTRk2pwVhgnUziYmohiep3r9yNp+dkb01XneY4qQ+aLGE3NWc9u?=
 =?us-ascii?Q?4ivs06ZvdyTPEU9dcEAk6n68c+ZnvB7VFqCtYAAFYwLo/KrYyRIte4ySoEaH?=
 =?us-ascii?Q?nuqPpDzRMPZTLGye23mV77oO9uDRq3eDpWwb+f+YyBppvWiuOeivl1NyhFst?=
 =?us-ascii?Q?n8v38B7wduIli5NAd82szx4fDlFvEHeMJactC9hLJxxHbiEy+/hSYoEuJ6RD?=
 =?us-ascii?Q?xt+RaDwtYEIdLL46pOqrzoOsVg6BUr60umg2pgRkiXOHyB5JVJDcCrBfRGhb?=
 =?us-ascii?Q?z4X0I8cET81Ssgwc5OBFWCEtBy4epO0bCXL6O7IUK+oDEOR87gdbWW8ubeZN?=
 =?us-ascii?Q?/C4JUaHq3qtVI5CxxBaPXHkxBgKSID1MtHeoSH2x9FaUdhoRytdfZPnB7+aa?=
 =?us-ascii?Q?3Jmm4jarnwnCy/OMg2G6Zz1r0ITX2Q4idtVxMYPCX1je0/h6VTSKHD6ksQEP?=
 =?us-ascii?Q?O5WxoLJL0HL5pveW8V2TsELWlzWumHTmGaIIFHieAJlDtj7golIjetLwqRRu?=
 =?us-ascii?Q?6bhK+akAPcSVFuc5Hwk6B1Q51iWcMazqBVH/D0a+O6BFAFn0aNXVHVa/wI9P?=
 =?us-ascii?Q?ygg/GYqWFj7/yKaiCM3yaBuy9MwJNx2VmoD7zqb2iI4w+G1964tPPaAONP0O?=
 =?us-ascii?Q?jQJoLCqJETpJ5TVaqmqq7H3JLg3OWjKpgYMlT3DrX2G4UcwO2geR5VMsOKmZ?=
 =?us-ascii?Q?2vTKKx2JUhqvgg2a7KcJwY/OurWILZCB15WGiS9KpP9gEw03ZA3Pj9Oi3led?=
 =?us-ascii?Q?6DvFG/f4RoW9T0AhbVxsRatW18ytPfKDm9yCqtB6x/uEjPj9+80NKNIHU1Hg?=
 =?us-ascii?Q?7ZF5yX2JvdCVKvhzsnytj7S2Czw916fLtg4iXcpGWbIbtute3zvH1wfdxaq0?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ae5b72-a4d6-4084-c4b7-08dd5c770b59
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:20:51.9311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSrQXAAdYlKy/rudlVobetWY6KdjAIN7+3VkgXthH5/wsVBFagLWyZVJIf3XicFzg1n5twqH8NGNhcEawyvPRk+begBnxlUcer62iDYvuhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496
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

Add USB related files to Starfive visionfive2 MAINTAINERS.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 board/starfive/visionfive2/MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index d7f638f9b41..1faf83f581c 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -6,3 +6,5 @@ F:	board/starfive/visionfive2/
 F:	include/configs/starfive-visionfive2.h
 F:	configs/starfive_visionfive2_defconfig
 F:	drivers/pci/pcie_starfive_jh7110.c
+F:	drivers/phy/starfive/
+F:	drivers/usb/cdns3/cdns3-starfive.c
-- 
2.17.1

