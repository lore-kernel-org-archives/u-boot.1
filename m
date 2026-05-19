Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD63CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 14:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD938485A;
	Tue, 19 May 2026 16:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xOgSHRQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 391768485A; Tue, 19 May 2026 16:17:55 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41A728484D
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waa0QQLRhx+toc2rRsvZ44TLVWIvxD2YMWkmwGHDUrm+O2wK/Qbu6nvbxWx76UrcRFT+P9PGKQPUUsbVoyHHrm6Gy613yBze0UBkag4BDfw3RLCKZvCcLoMeXBxQtWgD/1nddWZj5+Sw3hf/icRIMki5RPvEndFI8a2yAPISIox4Qmr0QAR/UxaqCO0aYUKKIJz4Nmgnn8gKoDR8Zh1LGvgS/8g2NkUn9jCVIff2UniLU5Y+OEv8hFH/LFvdpjEoSFdaYJyYtVXPURcCuNTikvIbboq41LJ11v126QlPp5BEYFr45rLrqiVHyLkFXo+9ckKpUjsdf37dFmLXvDG67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx+8k7RrtTxXrE/h8IhsMe85PlL8QtEthlKMrb6sW6Q=;
 b=qUBxFWdtePuvSxnxPIuhssYuCh8j92C9LCAKsT2kPpZMJSI8EXNKolnNJ+NFNfCAopGE4uqgNDgZhATzWf3p5Qri5Jwb5IWmio9955e6vbPORSSJrKl4g2vqvdTDPtqd0cqW/SkXXd/j80QrDOdlCNjYQybY4wti1kqQRbfulZNenpWKDFKKRFmeRlRa4FCtQ9K38Af6p9T75+49ToCNzVaYp8rtfUY/gF0kJIRlhF17H7o2k7sAR6TEELPSEUwpir05+tr5p+L8iIANvsxU5pupPG4y4JpyirVD6nBRVeh2M80HkE9M1VufCdGuiVjwL0hqMwrqLHs8z5bN5ZQybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx+8k7RrtTxXrE/h8IhsMe85PlL8QtEthlKMrb6sW6Q=;
 b=xOgSHRQdhn3QQ4A7fPBgBw3stwph50wOPucUOcCLWOdCMpEuZ7vvkr6Eb9Q9uZIsYjBsvgLNXm4wDhwvhkacDVHUyODgXR4Z50+8asy2T094TTUg40pRwb0Nb8GhXNOBZBv7yyJSC4W+MnDeLCv1jQU5yLxmboE+SP9Q9RXe+PQ=
Received: from SJ0PR05CA0147.namprd05.prod.outlook.com (2603:10b6:a03:33d::32)
 by IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 14:17:50 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::53) by SJ0PR05CA0147.outlook.office365.com
 (2603:10b6:a03:33d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 14:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 14:17:48 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:17:23 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:17:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 19 May 2026 09:17:23 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64JEHH0R3643846;
 Tue, 19 May 2026 09:17:20 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <bb@ti.com>, <trini@konsulko.com>
CC: <devarsht@ti.com>, <anshuld@ti.com>, <praneeth@ti.com>,
 <n-francis@ti.com>, <s-jain1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 1/4] configs: am62x: Add splashscreen config fragment
Date: Tue, 19 May 2026 19:47:13 +0530
Message-ID: <20260519141716.1346635-2-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519141716.1346635-1-s-jain1@ti.com>
References: <20260519141716.1346635-1-s-jain1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|IA1PR10MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b69d17-4255-4937-d058-08deb5b16778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Iwed52nzdF/xxZruuklOguMGLi5bzApKCs2UOOBcAFN/OvQKPWEp2xC671PAQ46l/Nk5tBn22rPe3V4zAs0GsyHOpZwHrh36zUBim76ebg360FQplrdGFY0/VfwTwO1RzlMUvD4/9EiX9LklkzOyV5NSKbnrKP4F55NRJW4KdxAh/NDNzGyYL3s5xSLaQYbu9SIFQaSjRi8CsQqHgx74w5EXB1hMqiq3bPFV2mnlmjT0VGkfGbj8sBNLTOB2U5NhJSfmCJMJzbuf/Uy2e2FMQ4yc+vd9J8k1AeukKtb1WEUI5MNobqaQa2AN4opypvJ/37nKIawnpHrJLAwtqL2S9vjNcQqGvK4pdfLKxZdYc8PVdrz2YT5mJdM0m+InIH/s1Ai7MfTtUK7ykNiYaaXNIFFfYhK8n66K7kdbfh31/DsTVUJsTFZXrmrymPZRngY90xbO3nDni+/gkhpho50ZiMRP8bycceEbW2idEEDNvUC2qKG6MRc4DfOuIRnKdI0HrM1VDOO8YW0eiv57r+dOYO4gMHFFaRdfEaRGdxP0Vt/azkd4uCh9+M+KhG3KdjqynBqiQE3+YQcvY9+HvfN5Tp8GdewqrNKBE+RSIJNAIc6E+ZV62Eh/e5KfQGZ9eimMmDRE1KJEDdyeu3Zv9YAgUDXJK+DuMw8lFUes90rQ5O/Rzr3GvCV2fIa8/gXob2Cg5ROLVvCzMxyBYvrBGaULjxPpua6OmHp0kyCecYyHHtE=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PRXi6A/77b9H/dl4zmOmXlIYgeqbEyEFnOzvi9xwhmAmyHPDeM1MJr0ircmDIp23liJu+aMw01/hNnqoEnZgWxX4ESpFZ/tEHvXyRczSuXS09pZ3u6riuOVuZMfAYYfCvBcdBOKa5mEzwmOanIzQw8EpoJWKf31ZzCvuFKokV0zVohuCRVvW6xCmCemL38gcypJC4Bhfh3bmlFzq620Cu2/kh9V1NoBtgAYh38t+6KxrnHCKgDAg15lewS/v4M3VqVwYVykbd3ZODM7hGLEjH3u8MT8BkGRHX3RoDNbdejDU+Ux4q6utAvBN4AWGGOfRNaYXBIxmM/zCUc9fgOfsbRPhJqS3Yjoj97neTHHBRXIaDr9MKsjgQvkOK07HdUu+BWrpIJxCHB/wUJSDOlYBsp94xqjo45yHcohKDg3TWTO6y3jsgmxaJ+jwLtaNOjnP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:17:48.1619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b69d17-4255-4937-d058-08deb5b16778
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8212
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

From: Devarsh Thakkar <devarsht@ti.com>

Add config fragment to enable splashscreen functionality for AM62x
platforms. This fragment can be included by defconfigs that require
splashscreen support.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 configs/am62x_a53_splashscreen.config | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 configs/am62x_a53_splashscreen.config

diff --git a/configs/am62x_a53_splashscreen.config b/configs/am62x_a53_splashscreen.config
new file mode 100644
index 00000000000..fc8b1f43f53
--- /dev/null
+++ b/configs/am62x_a53_splashscreen.config
@@ -0,0 +1,16 @@
+CONFIG_FDT_SIMPLEFB=y
+CONFIG_VIDEO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_SPL_VIDEO_TIDSS=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
+CONFIG_SPL_VIDEO=y
+CONFIG_SPL_SPLASH_SCREEN=y
+CONFIG_SPL_SYS_WHITE_ON_BLACK=y
+CONFIG_SPL_SPLASH_SCREEN_ALIGN=y
+CONFIG_SPL_SPLASH_SOURCE=y
+CONFIG_SPL_BMP=y
+CONFIG_SPL_VIDEO_BMP_GZIP=y
+CONFIG_SPL_BMP_24BPP=y
+CONFIG_SPL_BMP_32BPP=y
+CONFIG_SPL_HIDE_LOGO_VERSION=y
\ No newline at end of file
