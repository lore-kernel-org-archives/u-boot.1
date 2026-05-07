Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBC1CD3436
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 00:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BBDB849F6;
	Thu,  7 May 2026 02:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nt+j24L9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B63C84A09; Thu,  7 May 2026 02:56:15 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89C0B84903
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 02:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFj8UXTw+zS2u56y4NNOmJCoTTWdyeB7mZ62IhE+uk7rigL7pFkv+cOZme1RD9rlfgeT1CR3bHNgkFibJK8pQZd537qIJ8n5cyoEGvjC9VUBheOg3GBwP//tuQtHFD/oGVJe8+SEHTgugjyv5uMxcQ5OuQtmyXIx21CBwGNUNwk6ccnhLlwBP3iTbcVhe0YP86Td2iAbfP4gRNmjv5O+WMdMNmjhNzczqkMdWTxqQI6+NS8TUPTQhwaObIjs0jG2dijIbOQOtzZ4xt2Nd8YvA/fHUtavR4+IwPu0gBFIMH+oHJkskatI2dFsh5JHUCfe0Ia78LobgGXGIgdYLUpyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCzvBAJ+cozotPTg8cabSV7UdpFN2o9SKKJLo1aCorg=;
 b=fyYPO4e8tq6YDclAs3gNMjdHj+cWXlI80/UqxUXl3S0F6W6qVa42fXR4vZ34xCiopa3lHhGvb7iMlSzrUmyaF+kmq+aYq2y/T6bqiaXplx/nAhApATgq4VMmweG5ieYHsO1MzNqHL3wTsgW9L9r/kySN/TySsqSIod83RwAJzzMsFa6Lr0kAdppGk3G8YaK+wYuGHIb9Kp8yerNDLVy4p9XAA5vczIH3Jf9Nm0sxKx9ZPwqskHh27Ko/1JkQXf7N2+S3dcgMT8OdnrsGV6Bt7Bnb3L/xyubMPNna8TJvQgfltXHxgD+Ko38kW17nn9zgmi3DDuvtrz+S0psGSGHbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCzvBAJ+cozotPTg8cabSV7UdpFN2o9SKKJLo1aCorg=;
 b=nt+j24L9VSMN0v/ZSCfS8MFMmA735lF0ChHUNv13jCUaxNlNLyib6wgq1GGOgSSZjohW48cSshGZTZbGuD01s4er6CBa2ldX8+Q5jroYo3oQH3el6d+cqL79KE/NZW5+NhfIcwnN1S5Gm34p9KZEFx+jyxx4PIXzlFelhwQpyg3PI9hWtK1jwtzNusHVv9+wDcVvHESDmjKiH5C0PZOdP4pk6gftEIW651N+aBUCCPS/DIxjavB0csLZarBaelP17CARRPW6/P141kbMxOVkatfUqlQ6keTNIGWggeFiE0VlAs5mkT/89C02g70gFebcHx7niKuFtOzozUNnfqU4Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SJ0PR03MB6221.namprd03.prod.outlook.com (2603:10b6:a03:3ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 00:56:10 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 00:56:10 +0000
From: dinesh.maniyam@altera.com
To: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: [PATCH] arm: dts: agilex: add U-Boot DT for socdk_nand
Date: Thu,  7 May 2026 08:55:59 +0800
Message-ID: <20260507005559.8391-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::16) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SJ0PR03MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e63577-22f5-4d01-8cb2-08deabd36d55
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|55112099003|3023799003;
X-Microsoft-Antispam-Message-Info: 5WHOUTRTahfhK7UqS5/Sb/X6WdM9FHMZgtGy5CMldZOFZWqr/SKjkpQvgfnIIvjZ+uBmWIh9bvJlF6mlG8JSH9zwguqaEcLRyktVwuqK82YPaDJ3xV/2i47iBOhH66v/gRPRdqQKAiQmraAdgVboA5l/FZOMCEevAXfIcm//Qru7CdLYo7h/silnbzu8i7N7cOoXsyx+SS8u0fbCWDuxOu9LvFT2L5Kprgec15lroKiAd+JKLFVl6dvU4t2KplU97xdGXRQuBW71MWhkEHKzlY0zaC0mIQ/iq3axkHGZT3QBBMDbodHskAH5nhovjaK6FND5B3CtHh0NIdYb4whRDOvueZlwGMqLcWGO0c67mKsA7qCv1uyVyw2Hvgf4Du+gDK/AQBHGVbLiUMs05jRfpVZhbeAnqhhOd49CfECc9IfHXL7haOG2+PfOraLl9mhbZgIUZ1Ke+Ww2A+Cq5N1GNm3EA2rXEFpf9hZPCZfZ9KSxfuIiSKWnb7SEtLLqv+S26ZXl8JOD8lLf6n0xtyYxqB2uMWVBAyivVjdLQbetxZoccP5bTCNsLse2q0OtmmngGV9brPsWu/1nFd57a3bMuorhPGctRmufXd0F5j7C3k873e1Kt2jKMn/WWnJMoNu+s/zb1M8nJLP7djqb2rKXUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(55112099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JXuF+ps63SqFhqyHDEpxhWguHwA/3oDnw6yNQD59GTI7M6PDSHm6+XZZl7MX?=
 =?us-ascii?Q?633jJam9bD86h2Iku/kWH+U1c7Ky62vRLNCIN+FMG3gneBdYeCtdtnVMTrkU?=
 =?us-ascii?Q?0N2iFGJEqDDzUwUUmxD5pbA951Z+j52F0o3wcOJKqLregTloZr53EvYukJgP?=
 =?us-ascii?Q?ZAaqVpeiE4FABVc5EkXMRKp9WNZTDY54R+ptyTzwggcGpS3CFW5+BUWDexJG?=
 =?us-ascii?Q?/sqjZ/KXt8FXxTZ1Q5iktpeFaVOMmgBjD67eRrmUs9gKKhbr5AXzsQwji/S8?=
 =?us-ascii?Q?AOyB+JI1xRLOy/TUX1moGj9kfVIQW1m4fF0voDqUbVWSj39YcB5gOCpNQTBz?=
 =?us-ascii?Q?Bur8vFSrfcQcydPut4T9TAMO6pSekNeTGzwV3ewtVrGoxcqIEkVERGYHxshl?=
 =?us-ascii?Q?x3ZWaKQk/Alcnk5l6DJKMpJ09HNmEI0H0tpezfaoMwqb40sBcvIoSJYSM4i/?=
 =?us-ascii?Q?8pNhyC43Y0pcLogmV+YELdhuGSCh8dLRDDttAhNrQcgPaYpRr0KKoBI+vPfp?=
 =?us-ascii?Q?dr/tQR1D1TJTIVK5PdfyqYLOkuTG6RD30Y3ljJzihUUcgDItpvLTX4HpZcO3?=
 =?us-ascii?Q?kgfmmVMwDf0N4i2uDpfrGKZcls04hLOwi0EYSVXRqj2d0i4KSwgkBShCykwg?=
 =?us-ascii?Q?rI+zQgZ+KZADjz9LAlUW9t4COOGL+A5WKoFeJYk0s25wzhGF4iGat56jFYgQ?=
 =?us-ascii?Q?v94V2aUbWC4TzJjotjpkOA6whoSKcE/9D7ezPIzgRtH0ZhOQxXjgmNjVvdg7?=
 =?us-ascii?Q?2mSEzvAQSHD9Htc6RurJJSyBwdmQQipp7LXtD2FUl0C1Gx0Tfl7LFhuss6Oi?=
 =?us-ascii?Q?KFcZiPgLOq8bWV4xw5pnb5MF1Pz+z/n8CD5CBztj18LSvHSYvIy7VbQbzLom?=
 =?us-ascii?Q?KbkQ0IrJo95uF86H5mYWDOH+aU3dr9GtH4f3/jLeNV7J2j9WCexdAQHMSePT?=
 =?us-ascii?Q?91+RVrZD5aowFTVrKJtu25ue22cB1RFBwI1m9va5de4xVGgS/97HqvhtquTO?=
 =?us-ascii?Q?rLvFmWfPgvY4CljqCtWU8dp1Sn2PiKVQ1Pa9+tAQWlEVYtvin+ghUbKwq6Wp?=
 =?us-ascii?Q?rx0PN9VoMUn74S2v5vbJk1Xxemi5PtTHbC6PNZ/hGcU3jYuNIdEhXC6z05oE?=
 =?us-ascii?Q?xXWPr8yVPwcw5jdLOHX9lA4xNBNIzK3mev6OhX+U+X0X/kHcD82qb4DoCyAR?=
 =?us-ascii?Q?VOtz9FvqGIoQl7di3uAlJUV9XnrZ0/ra0fXh0i9LVjOBQ0eeDpvFU2lvReux?=
 =?us-ascii?Q?4YONWA6/GqNAaTslGTw3a6b1yZ8zYia8EY5hT+FK8DmShU05dbCKewYXUpsy?=
 =?us-ascii?Q?5DpHJZRwAWbKixHihPav67hKpBVaBnjp30KtCitpmQCntcPwVkeSgpmiU90d?=
 =?us-ascii?Q?kMIiXa5JgtOnGKRZ7U9JCiJ5U5vhjaVR5kk2I2ldnagGieBl92zsqveAP9LD?=
 =?us-ascii?Q?Ywh0pSqBsQw/cvEcUA8uEtSF9lB+OeqJ1diZLkWpIJ39PekPE45SIiK3AO3c?=
 =?us-ascii?Q?OgXXkJWpYvS2yc3bLTwGLXVU1IV6rTc5gXgxSt9CbEUoy7jzJhB9H+HsnKx3?=
 =?us-ascii?Q?cFugjCfM72ClHHrJp7IWBE6wG6IdKx1kGtvnfKmiBVboHvjL+YE4tLmVX+Qu?=
 =?us-ascii?Q?+8OoNyfC1G8Cmbvr1r84OYrY9+zYUe/9xGnK6Z6cWXIlyoosbUVrzRERho1/?=
 =?us-ascii?Q?C/lA80akSNKui+iKhXQdTS7OEQnrzRJ7YWQVpZlDUdbgPKwCoSBiZb8H1O82?=
 =?us-ascii?Q?BPf7r8iBYSkLKDEN1eYcK42lnhyawac=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e63577-22f5-4d01-8cb2-08deabd36d55
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 00:56:09.9980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpqECTCB/6krDiX5uTRxSLYF0YQ9LMyVGO5TlbJPF5rKzIWk9QwAKQnGackjJa4Zm8MZX9CfMT9EmStSAFX9brTRrokL9tdD/jiZq3iaN44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6221
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

The intel/socfpga_agilex_socdk_nand device tree was added to
CONFIG_OF_LIST by
commit 044d6a800edd ("arm: socfpga: agilex: restore Multi-DTB support for NAND boot")
but the corresponding U-Boot overrides DTSI was missing.

The included socfpga_agilex-u-boot.dtsi unconditionally disables
gmac2 and enables gmac0; the NAND board variant has the opposite
wiring, so re-enable gmac2 and disable gmac0. Also clamp
max-frame-size on gmac2 to 3800, matching what the U-Boot
stmmac driver expects on this board.

Without this file, the NAND DTB packaged into the FIT image keeps
gmac2 disabled and Ethernet is unavailable on the NAND boot path.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 .../dts/socfpga_agilex_socdk_nand-u-boot.dtsi   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_agilex_socdk_nand-u-boot.dtsi

diff --git a/arch/arm/dts/socfpga_agilex_socdk_nand-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk_nand-u-boot.dtsi
new file mode 100644
index 00000000000..a31a26fcffb
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex_socdk_nand-u-boot.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex_socdk-u-boot.dtsi"
+
+&gmac0 {
+	status = "disabled";
+};
+
+&gmac2 {
+	status = "okay";
+	max-frame-size = <3800>;
+};
-- 
2.43.7

