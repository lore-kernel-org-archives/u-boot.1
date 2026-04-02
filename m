Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA26D6AB14
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 20:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B079D839DF;
	Thu,  2 Apr 2026 22:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pYw6wbzV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0CF483D8A; Thu,  2 Apr 2026 22:51:09 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C60380212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 22:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=op8l8KSmNkar+BCSD1HX4ebh069LTgkOZj1qfIu9wXp0CMfcM0DpntUE+nZRlRogb0oz8pj8UC3HfPWZItUeJ6QjIFUvnm3Bulpn8ok1Pkxsib4u6xH0Su2xqozBCsZZx36//3Oc39mhhlXAKQr9kw5G3zXL5mYWK3y1+OJvXRkcoZv6KxVZ5K6ebClvO+0uu6tOTxtp8/7qhCFBY6r5bzJAgaQk2TP/qqTFgOXdOmqxu1xbMbf7IWdiMRGGbHTOBT07YzEgD/R1cnk/qWbkiZiEaVjuUj2ce/Szdp9dEQ2tBHiv2/scZJW2J+qc0+FvOBSqJ+mviuR78qHhGlHhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPcdR6OSWBwSx+ineRTuwyCiZ31zPl1luX9VYddn5w8=;
 b=zO2arXZQeBd+OHJoscjXIx7ooPTEscuv4YKkaHML6JJcjIt3pIBS/kGSe76F/va/Ok9PH25AEKpifIUTohfXxCLGX433hWTNBjmg5a9JaKztcCx769t+veFWgQjbZGdTm7saP5bYvq/FHAHR92DF+q6WsB/zJFJvm+CvADk8D+bk7jGKgtFdM9nyCiVosdwHobqDND7EErG9ykp0PIRedkGQ2zB1Kuz/SKmG/HRk4hmi3jPPnfmYF9/aH5ZvnbObkOKO4q9wwdcHlV7aw9S6T6b+mKTKK2Tzs1C7f4MWIJABSUQk0LVChH41SBm0N49gMBfo15tsutKnw+MCYlCM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPcdR6OSWBwSx+ineRTuwyCiZ31zPl1luX9VYddn5w8=;
 b=pYw6wbzVuO72D3DcL+O/N0Os+nI30aejiMQoOvQ1mBSCmeq6mPAaC8+qJBnlgwiHhpQSpe/vNjLKHatvR4fNPMSW+pjd4LzI+hCt8dVY5r+GckRwwUb66yGdLVjT+YYER+/468vXLlyGgnOUGS3IbgXl4yjR1XY+mki+DdoAqUM=
Received: from SJ0PR03CA0149.namprd03.prod.outlook.com (2603:10b6:a03:33c::34)
 by IA1PR10MB7216.namprd10.prod.outlook.com (2603:10b6:208:3f0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 20:51:01 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::66) by SJ0PR03CA0149.outlook.office365.com
 (2603:10b6:a03:33c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Thu,
 2 Apr 2026 20:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 20:51:00 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 15:51:00 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 15:51:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 15:51:00 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 632Kp0bN2708543;
 Thu, 2 Apr 2026 15:51:00 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv2 0/5] various memory related fixups
Date: Thu, 2 Apr 2026 15:50:33 -0500
Message-ID: <20260402205038.4005350-1-rs@ti.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|IA1PR10MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: bb388cab-c32b-49c8-35f4-08de90f98c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: rwwmOqQJssmN6z+5sb5BKdQG6KIyq2ka/rGI+YMcRQS9Gt6C4qW7C8fMdQ55O5ofJfVENSqArnXiuyltKUoYgqJPwnXIUFKdkmdA6lDHVVO++h4eNKo/eBo52nJ06Da4gkdxsgd+L+99CmSIyfSYpnQZ5BFpNHBYeN3I6KlsjTAuK20N2ypHoRoiawp+fWUrcOWsxDd3rNhtZV6YT+Rp6xvxBjjKif/cGBbvCmInpg/8MtDkgTqVGPBRlEh7QWdgEHWCtZMnkfJvhAREnyB/vbakJabnVE7E+4PrRVwndLzqwk55qgto39Lg9ij4VLhxyPkltSljEiuEl+W+oPLO+grsiNtNa3oZ79j4LvgWAOGyl8glKUAC+bIcIGBf/sO+MJQ4sHBWoemZu2hhKpG1KAEuykkXMZIdBrJXcgXVjhNv/3VoIY3LzRikk1pH7wVoLfh0Rofcv2Nrz0mFYS2zOzifvZXhHE1n7yiQrBLvI8fuHJ8YY6X5dMEu+5v4TXeF3RWkhp2SHEhvYs8wfmGawoserx5Y9zWUCjpvwHDIkTDv+LfWWr6+yXc4CPNaVDXZx7e4DrZHJlJisqzHorqQ2mfwzZu51hdC+laYEyha/YAClABxfQ6f2O+TwvGPRhqBBv0s7aYvs5oFoVVDMQJCizvg4mgcRXhhze/WPed4asU57//eG8MjOt/pTR+izl7HmeBkBblJb/IQe7CB5RoBXqMkpoijdM+LfPbovPo+zH+75r837jqd6WmSni8DzcG62VB6jGrXFuLKgsSwrFZqY67sSqTeRYHxL72aJCJOTqs=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g384IzTfC18/Yel6InVGzemAcjivAZr8Lzy6/iGlFzLPAjjrN451Ec97a/GeSCZDA4bnEAIBp1AM/uvdLWCVY8MqzZrxBIea1gpXSBme9tx34SAl6liy2uKJ+/k7Q3pR2Lz84SKMtrvGsXq4Qr/MdetxtaufDYf8ieKWd9sCTHtb97u3Fb2VLczeTSOfd9KXisOmN9wo810W55QjuO9G72K5NPOKSpVvo8WyDA67KgJ8iNf5tCEM4Gflsz143cLpQW4B7Jfbs6QjEEsXpEiA4TE0JhgLg1oatg/8QQGuDD8ziTuHHOQrW/VRaVGXHKf7rFBXUMAwM1WXhia4QSdMbOb+ADU9KCIK2Vpu1qr3sHRqHWdGaMwlpQdtaPYAIYaykc2ctQktez9LgWO4LGmVrNjHt8kM3dZIkEqLejiq3FFHGu6SemuKa/O1Xj0QnugB
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:51:00.9325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb388cab-c32b-49c8-35f4-08de90f98c6f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7216
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

From: Randolph Sapp <rs@ti.com>

Nitpicks and fixes from the discovery thread on adding PocketBeagle2 support
[1]. This does a lot of general setup required for the device, but these
modifications themselves aren't device specific. For those specifically
interested in PocketBeagle2 support and don't care about these details, my
development branch is public [2].

That first patch may provoke some opinions, but honestly if that warning was
still present I wouldn't have spent a week poking holes in both the EFI and LMB
allocations systems. Please let me know if there is a specific usecase that it
breaks though.

[1] https://lore.kernel.org/all/DHHC66BBMD27.YHGIH43C6XBK@ti.com/
[2] https://github.com/StaticRocket/u-boot/tree/feature/pocketbeagle2

v2:
	- Remove additional increment and decrement in lmb_free_fdt_regions
	- Drop the patch to backfill EFI_CONVENTIONAL_MEMORY
	- Adjust the removal loop nitpick patch description
	- Change the reserve memory patch to use new end_addr_sp

Randolph Sapp (5):
  lmb: add LMB_FDT for fdt reserved regions
  efi_dt_fixup: use fdtdec_get_bool
  efi_selftest_memory: check for duplicates first
  efi_mem_sort: skip unnecessary compare
  memory: reserve from start_addr_sp to end_addr_sp

 boot/image-fdt.c                       |  5 +-
 common/board_f.c                       |  9 +++-
 include/asm-generic/global_data.h      |  6 +++
 include/lmb.h                          |  7 +++
 lib/efi_loader/efi_dt_fixup.c          |  3 +-
 lib/efi_loader/efi_memory.c            |  6 +--
 lib/efi_selftest/efi_selftest_memory.c | 21 ++++----
 lib/lmb.c                              | 66 +++++++++++++-------------
 8 files changed, 71 insertions(+), 52 deletions(-)

-- 
2.53.0

