Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98D2F55450
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 05:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC65783AA9;
	Thu, 26 Feb 2026 06:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Uk9JTCVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7681A83E63; Thu, 26 Feb 2026 06:48:23 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5FB583642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 06:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SM3FQb1nrvRbAZX/bp2iqNwjNilrYHQF3RJXP64AEciGhwVfpUQkIldcp9B/qoQuuOOpJlgG23el5WSTIvF3xmEeZ0Yl9o9p17QBF+K7SSFvowfwXirqL5xS67vhxg9s/ldAAry4OfYz7hOqq5Xv0XTJudz2FeosiGau9QfFdRabo+4st4oaVx9a0ZpJ1e4s85aRKDEKc6dNgJbPeYQC7ZdEXnZcD3qlenBp/xB5fj0A/DaKIKAOlp8GVg1jGtQwUyn3TK0tbtyLTec2BbVwpVT+8mgHgeI20URbGBcttMby/qi/IK/sPppSybXgcEnaTTfCUMmOw5b6QFSwrNhr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HoZ1SyM656wjixBG0uQ1JQYJUUVULIn5J3fesR60VU=;
 b=buUrftD3Mx2m/6c/yt0jgXeWvj3HfTKKy+2eY2iTtHOQqxHtYTHztmFxsXeBjw+e6+tyHiL3NtrwrpTqvvqd4YNMpMIeDdJ5bGF6ERbK6nQZYnAZSoL51L9eFfudPLheip9d7MkGaRyAKA2hybWW/OkW52OD9OwzQQhYzdcnQv9gvTRcdcyJ3JJ0Ebz1djb3zUUkQ1gK7iSY+ccx/ueANZCmkxn9EYNbL6Zg7L80H92PIiIg10pnoJfreyZkJJpDG2c8Gdt1jYBRZH4bW43uANtQvKTyBy5NI768xd37wdR+EMywWXcGs6JMh2J+2h5bwAnLVeQY/aU2IkB3ricEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HoZ1SyM656wjixBG0uQ1JQYJUUVULIn5J3fesR60VU=;
 b=Uk9JTCVEYjHBOwWLbSnqU5Q3oakF/I2aa+mWLYv3Occh9L4Ty7uJRaGhQf1KucwyT0K60L0Qa0JfChKjzFzZKu2TyaWlogsVh9yfgqPJNGJw3fdMdJlwrCdixQNjUi41+k0sjoSi5ljcVCAny1S2X4Cx1bPjKz4KddJKH1M2LHc=
Received: from BYAPR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:c0::35)
 by CY8PR10MB7291.namprd10.prod.outlook.com (2603:10b6:930:7e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 05:48:16 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:c0:cafe::30) by BYAPR05CA0022.outlook.office365.com
 (2603:10b6:a03:c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Thu,
 26 Feb 2026 05:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 05:48:16 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 23:48:15 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 23:48:15 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 23:48:15 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61Q5mEu91310979;
 Wed, 25 Feb 2026 23:48:14 -0600
From: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH 0/4] Minor fixes for the k3_fuse driver
Date: Thu, 26 Feb 2026 11:18:11 +0530
Message-ID: <20260226-k3_fuse_fixes-v1-0-86c81c298bc5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJven2kC/x3LQQqAIBBA0avErBNsEomuEiGlYw1BhUMRhHdPW
 j4+/wWhxCTQVy8kuln42AuaugK/TvtCikMxoEarEa3aWhcvIRf5IVHeNAG9j52ZA5TnTPSHsgx
 jzh/Z6oBrXwAAAA==
X-Change-ID: 20260226-k3_fuse_fixes-c41d2ccf84bd
To: Harsha Vardhan V M <h-vm@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772084893; l=666;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=67MltppgL5SIGHyxpn65jkXT6/QQ8mVhftT9KkVY5kQ=;
 b=1U6PkwmaSICacIa/9pxj1hRWC1u+LVjRfUSTbOXzf8u9xewBD53TBZC+aIx3h6orgJGvlIMrz
 DgixqS1DoTjBOmv29HfMTM48jFFOMw8kM1TrYVv//WyOJud3xSepemK
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|CY8PR10MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 63da69fb-9a6f-49a6-e544-08de74faa338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: qbuGoaHEmKJeZ6k9mUrVhgNKbnjQaq3Mof1OmVfMth8kWCPsw6Ngef79Ks2Au8KYXk9lNrhlE4/qAVUKexg47Z02hVBaqtduu/WCqWr3eVNGTbkyFqV3y2URePfuXt10JFpdZ/lSJL11C76Jm2o65zWQnZvzQdMJg3nD+khETjbGhik/vQ+fXwWIXs6wv+7V6TKvEuEaIP5G47qtEq+ot5zzTifxNfcoGs57ll0zRjuX9oAYOLRtfK+cnWF6zJknFqfaZ/EUKqZQCfv20cYf9o6KFkzdwpaSsyDre46r51WzfokoVWhvTFlLfagmMYLBiHBQIjP2hgasd+zqpg95W4xc5YUexJZcIErQQ5nbtrx8G95tIOJV20q7vDbLC8VFjJlsW8QHV56a9vQKWPxQaNywdi/P4Br+A0wDXnRdgDpSEM7/zoHZg5pW0dUoME3lF5jpTqGn+fQP1DycetqWI0NZrcPoOfN8Ya36YWTqHEbsMiOVkDLB6tHSohpb/VZZTKfwC52OIS3NLCucMiLUTrAvx8rcFhE7fGv8CQGahOyG8Tj2MoY8vLJVXLuLBLyypRRvwow53DTSk1IItXHzaAJFibbu2Wmrhn2vgI2ofM/etMt0mWl1cRarQLGPE5S39whCIHTjRLkChugD9evvCOc9NBWOUHnrmhJnEDn32jQgQzPzdUTQtURvmkI4IAgMNqeXMHeYOLNFcTD5pQMM0vAzAY1yGXe5JSBwkpi++yxB3JNolmrKXGjtC2+xyCVGhtM2Sb49lXCaVWwAKtuvZsrxjX9ebJjKn0H1Ty2iwRk6tPjevHVQqcIHZ+yC7E0061DB6DhJYZQuEI1flfBF1Q==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CcYhW9RGSYEP7d6U30uTP2GMj4Tr7M/B5fS7h9dkduv921ADMYTW16xecYibdRNEcI2sR2BEUuvqEToRL9RlgkajUWxgHl6/o/GtXmkYHMiX6acP5MKZ5H829gol8hQDMm2y2k610rpig+KcJDkm0j6sFNg5SnshsxYlvHQ96vJRM4cVDieyiMwEaCo+WCOVLbYHEBHEY19MRsQNMarDmfOb4qXi83W5mE8UqVwNp4WP2tzrWbj7cRe5uJL8UajU6ZQ9BNvENsQDy53XYR80ayBBHYF4yf1NXL+aTU4eR1H8dyG23u0+7oMgx+R3Iach85DEOQjVY9zyooRdiEQZyeDSfICVFIH5J/KtV0dERv9RzSMWcTY/fmVUoj20uvssdShAY0dDkgnjM3sA08WGblPo31vCOtSTpJTPXuezbn9J+kDC3jb5SFl2+7w/dyfd
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 05:48:16.0942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63da69fb-9a6f-49a6-e544-08de74faa338
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7291
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

Hi all,

This series adds some minor *non-critical* fixes to the k3_fuse misc
driver in U-Boot.

Regards,
Anshul

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Vignesh Raghavendra (4):
      misc: k3_fuse: Fix printing of error codes
      misc: k3_fuse: Check readback on fuse prog
      misc: k3_fuse: Enable fuse Sense support
      misc: k3_fuse: Limit writes to 25bit values

 drivers/misc/k3_fuse.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)
---
base-commit: 7995bf8dea2d5b3eb7fcb836636f4773924ec35d
change-id: 20260226-k3_fuse_fixes-c41d2ccf84bd

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

