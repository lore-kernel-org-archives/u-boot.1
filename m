Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE80C87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0A9983EA4;
	Mon,  4 Aug 2025 03:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QeU21pMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45C4483E76; Mon,  4 Aug 2025 03:25:33 +0200 (CEST)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D46D483D77
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+OsviaV2mRhgvZu1r/30Du6GhyeO4+qXbhJNPoCX4p1qnS9qEbp60f2MlXc8uGyaTf0IRmwCF7seZWiBUZFpvHXqXVpVbHqRcw9WTeTvzuL50NDknMpo34tbUVBZV0kD02tE1PguKiNlLIcTn4biZ7Nz2HpXBKkTFbDG4ilDjhNygQTWf94gXXeID/Yl+o77v+Ihida3mROsJqrtnzKms0FIlntd0GnS35HaHTX/+Pb3ysoQDbKlGM+DatLcIPVAB6bib8Km7aUAcE+2O6iXyXgPTrENRWroQJqMiOoC9jNk5g92Alnt3NiFAwvRHjdijdRyrYTM+OQ7xoVUySZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWIxWu/ACwaR9c2JEuKL7cjMD+ZgEsxMwnugpbRcsPA=;
 b=nWFxp772quSAKEyhZs2+QkyFv+VV5oEMR5LRP5cumlORDU7c3vxW3QccuIlPTyAQ6T2RHmG0DW/7Iz1B+pWZNS8NEulk68YpREbsCmZV9uMJcL57FhH3udJSBgTSpYcChS9Zf+BFhzGlJfdtivb/6GtFQJ1C87ntJDK3fIVlyTCTYnF7BEyyzMG5QEL+trY0iVO5zJ49vyBMLBtrX3fNC2xmeR0NvHnhH2+koXXnw8lwvDyZCJ2NMqWkOcMpO9h5TAhPaiO3LvhkKgvVv4mGKofuGfXdK4mCSqtlqewnKklWtT1C95D58DSCB6L7SrkDdSxli3vSS/P7XsIz103+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWIxWu/ACwaR9c2JEuKL7cjMD+ZgEsxMwnugpbRcsPA=;
 b=QeU21pMOMppfNX+BY0Bc/EWvI7hZI+W/e4DCkdWDTeijtOpO4m0f2eobWPEkMqyXu+SPlWHv2LOequN5qubCQ1jk4EEkMQ91k7GJwbzInNlpi9REg/g5qYTFIsV9jlc6V7YHWFsUCLeqC33pgzr08NzMjiInTZbIex8QmzeYbAWxpKvQmOEzkFrV2FoOMx7dXnMq2e2lA03lsqRcWROievWRWE/3EAwjVerWvHHaeS1ZVLv3y9U/sUvM//c5q5ZOwHnnHYeFU7Dwnq5eMv4EnjKjBQTlTI9HA2FHUSR/phCF74Q8epDRuN0yJRDymv/MRHBDCsV7B3/Qt7eGhLea/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:29 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:29 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 21/34] arch: arm: dts: Basic device tree support added for
 Agilex7 M-series
Date: Sun,  3 Aug 2025 18:24:48 -0700
Message-Id: <20250804012501.21811-22-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 8078f42c-84b1-4e26-1898-08ddd2f5cc1f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iK8D1P/AlCIW8RwXloQK5dKzw9eRNgMhoICzbhupNApow9OaPaJzOOZxZDMb?=
 =?us-ascii?Q?xNrDfTj4m3r1iuOODMD8X9g1wxnKDWaYcWA12gq8FLtx4LbIL3surwhFEAUM?=
 =?us-ascii?Q?XxbvuFAjakPQ+xWhOPcHBdWMqwa8/5+DFpR39psS9xo7t4fjfQGCM9yzCjLH?=
 =?us-ascii?Q?azgWdKasF179N8jXDOf1qF8hjjpZtyXkPy4z1ak4dnFbWhupqtJAJ+nMPVHU?=
 =?us-ascii?Q?EzM1CzYFsDAF1a/GhMrnYO4zwqpkztZYrJmn+1Kx20XO8LQpWgTIFfvT1Nwk?=
 =?us-ascii?Q?JRXttSTPhdKD0d1H6K7bp5I965ukaxgXdBzOJLAS7i/8AWa2CoufQhZbtyWO?=
 =?us-ascii?Q?VOz/4CKrCNLaH7ih0NLNIDPFupDJBnlkc/kJHfC6f16ZMNlnE8fqSxxZbTBt?=
 =?us-ascii?Q?XLJk5B1x0afz+jJYeN9mMeKc/ojF6KTnR30Ca8Y/JLwuw4zHnuSP/x6fxpTF?=
 =?us-ascii?Q?vHJhZo9pWdIx7/oHfCP+QDFX7ZEaDaPwA9q4DM4sL2a7r7LriM0tJ3C4X40E?=
 =?us-ascii?Q?GmOtZTElyV4Gh+aqDBmCy6uSESSljeilRVTYXfXtuNvikcqGZsah055UnRwY?=
 =?us-ascii?Q?F9tkxAXmMYBgkfdb3MGGLbTiIVM7RRGInIIPIcJ43/OQtpT9vXFgSt5bJE6p?=
 =?us-ascii?Q?zop04KVJarENdZXTnNuxM4e5zfp2Q50C8JN39sPydCqUEDatH4bqtGcStAAF?=
 =?us-ascii?Q?1d5Q0fuRCFd3kgvBf/vioJkc2zo4y2D6/5S83X/idLcmMhGGmmZOX0y5noXJ?=
 =?us-ascii?Q?+iVLB5Bdz9jXpvmj2M74Ufx70ANGxwaWgsdnnvl159YvmjXRJzDHq7jx8ySi?=
 =?us-ascii?Q?mz6PDqh+/TVM4wdckqnXRbAw1G7pfxkMHMGkqO2BPUL7BS0XF9cg+62Hsqdc?=
 =?us-ascii?Q?GNaF0t08BKuXdW9KwJDYddMJQMmgmXeKVCHmLYAFksyekskXTQW8u3IvQsjL?=
 =?us-ascii?Q?wDzst16LMK6AX3x3Zwl6ehNc/TliXJpB5JaztAyYXicUBXYWWhL08eZcEssY?=
 =?us-ascii?Q?W1HDVO6RYBEfwUIYYVQ0lnaEVfm/k4DLoWD/XWsdWYDAwMVugauRStEiR7d1?=
 =?us-ascii?Q?ygTJknX/p5vMyk5MhY7iA7S8YZhuIqA3IsWgFhkZy5ZwUbJgVCu47Yb1lvtI?=
 =?us-ascii?Q?z54XzoIXXLmy+GNGyTJS9Qyq1CL6cGZw2xyP0fDoe96e5JXS1AL4cJm43PMZ?=
 =?us-ascii?Q?ySMSDSqDt1wS2GX5OME26dLbvdODmeTOxFhrC2r+hAWCDmqxlroCVd6MfP2q?=
 =?us-ascii?Q?z1hX4xUVGw3u3B577eh2osmtnSVGlJ9HfQR0B6vIbOEuETS4k0Pq3a7XHIUk?=
 =?us-ascii?Q?5G0Ha7gYngvtqCC02c8AALaN++AJRusYGTZGMY5cLO5GaiIHIOH7o99fJcH6?=
 =?us-ascii?Q?VF/oaZa9juIoFp/iJBuhlYDMLoR2hntFuafXRONmBQNHCqdEbCBhkoq+eqHg?=
 =?us-ascii?Q?V/OhtlMGu1k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c9fhwdE7xwpdBjMnFk3zaHOvZAZM7mBsbGAdWFuHUX/NMNE0glrzHxCzefkY?=
 =?us-ascii?Q?Ibdxm2YRI+r8hOqhsQ5wYx2dtaj0e5GghF7dcKRfjLxMZX6bF7fqrQVZiPCh?=
 =?us-ascii?Q?XD9E3O7U/8iCCQdTIq49+aPGu6xtDAbWnriIiqCWuAtZegXGnnRMGO7rSgnK?=
 =?us-ascii?Q?AfrY6SmIPKg5nC7op2qRV7cXoScG59wngYvMRGBM2T4N47PbfL1QKMaJlwh0?=
 =?us-ascii?Q?setzmZhbzGI6JNqfATigecAftWhMvY8DckMEZPvn7nqJy7G0X9pMfXRbk8X2?=
 =?us-ascii?Q?Fgi6k4hSaTUyUCNIBkeQFgpQvawGdkpr4XM+RovOWkzkloeK473QkQrkKliV?=
 =?us-ascii?Q?ZbXpoBnJWYN2UZnXrHJLUMZudyYnS/gnnIBsfgsKvSXRWcDjmjzRnhI7DfYE?=
 =?us-ascii?Q?dKALRd9T/SvRYKrmKOx+RT6/wakim0njDoovTIzDiCjGCtMX2x8iTygRVt/H?=
 =?us-ascii?Q?hf6LiE7iLidTcJ4Pbk0iAZCaipx9HX1VUhJhhvSNodBSWtL52LDbUos0ZGbY?=
 =?us-ascii?Q?Cmsy7vBlRljWVEFMgeMb366FO3Wiae/2dOPe0gMFS1MMpHI6uBfAdCEz2XPI?=
 =?us-ascii?Q?rr7YBTvFXp8YzQyN/2Ov631Gc7JcLk7R3tu3qZBAOv3D1JHd6Xz8kwU0lFAV?=
 =?us-ascii?Q?tO3FkAos8DOTTL2GbDeJQ4XI43NTU5k4gxgbMDl0YAlv+xx7wXBh+A7tLlyv?=
 =?us-ascii?Q?VqfmkVMtmNYUjpgKVXIaOaIhKJZgsItLitHcKiESiHJbKJekpGJFBvTV/uDM?=
 =?us-ascii?Q?e7L9fB4GBDOwo/AVA8cLpHu2zoqdL3ereRZfT56S5vp8kD9ge4aTsF+yOjZ3?=
 =?us-ascii?Q?Ef1tqhkjTWK/AHRLgRhVOdESf9wW69DGs8ls4HCFykHFk0oeMYD/E/PDaQMt?=
 =?us-ascii?Q?6zVsRuImmKW+wsnIjlufd4A8hRJrMfZY6OjZkE9o2FdocdvDhYLraAYvrUKf?=
 =?us-ascii?Q?nQKK1s0Ioy7toVzH9cLavRGL5f9Eft1WRSbuwjSYpNNujPvvD/5dPjZdijIY?=
 =?us-ascii?Q?V0+lTBmcoioWku4jHa1dVL85MpnfTfM3/I6iUAWt8G7P79xK2IBUa8xsp/RP?=
 =?us-ascii?Q?s99jEwemHFgMiYH9RR8L2bdkXjZaiNTojeRgPLI370lTizbKXd5hYInYdWmL?=
 =?us-ascii?Q?aTHtb3KqT0okmZl7wxhL8clHgcq6wVFAjLxFYOMspKGdgp6k4XTvX7IHB6io?=
 =?us-ascii?Q?fmlcs6KfByfDDQ9+LrYaLmudN8gQf46WNXN9hGgXMKJ+fYxwpC0fXV4TPof2?=
 =?us-ascii?Q?hXffma5+7JfLI3K+F7gXmOoHe2N7YgLly7VD28+E8I/Itg82lMtb1YvA0VVN?=
 =?us-ascii?Q?Ub8t0TwQaCIpdMs0p7T6OEBcNJOwBhS5YLDX5TZQCe4uQqZMbkZfmaT0n9s3?=
 =?us-ascii?Q?XuyHCEdGlE6/Nq397kqSIbG5hIe3gAO/hDnnuIPNnx0BSloGCzyt577x5w11?=
 =?us-ascii?Q?xgHynbotIYfVDgJIuALugm2TtnCDarC7roQA4dC/wKoieOGtzqShaWRFKd/t?=
 =?us-ascii?Q?JdF/SxoYXhaRScP8U2S22pIX2eWEMTeRGWpFVRPZ/BYCqH7lX31nUj7bOCet?=
 =?us-ascii?Q?Q4ZiL+mRJq32g6659wUG1P5/7cSK7uo4FmpILNySIbhwuAJUOE2pCvqJSlHa?=
 =?us-ascii?Q?i3I98OHPDMS0boo+5LVnpgQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8078f42c-84b1-4e26-1898-08ddd2f5cc1f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:29.1425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bAL+PjP9RcHAvJpD+FrjebWVZDZxdLAxZVSMPZ1Dffbxos/4XDZrCnRyFOR0eIlzyVXm1Gg4K3vfiffJJEYANf2qw2UHmbhNZLI8O+beHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

From: Tingting Meng <tingting.meng@altera.com>

Agilex7 M-series support has been added using upstream Linux DTS.

socfpga_agilex_socdk-u-boot.dtsi was updated to support both Agilex and
Agilex7 M-series platforms.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/socfpga_agilex-u-boot.dtsi       |  7 ++
 arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 92 ++++++++++++++++++-
 board/intel/agilex7m-socdk/MAINTAINERS        |  9 ++
 3 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 board/intel/agilex7m-socdk/MAINTAINERS

diff --git a/arch/arm/dts/socfpga_agilex-u-boot.dtsi b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
index 8c9bdf610ae..770f6cad292 100644
--- a/arch/arm/dts/socfpga_agilex-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
@@ -263,3 +263,10 @@
 	/delete-node/ kernel;
 };
 #endif
+
+#ifdef CONFIG_TARGET_SOCFPGA_AGILEX7M
+&sdr {
+	compatible = "intel,sdr-ctl-agilex7m";
+	reg = <0xf8020000 0x100>;
+};
+#endif
diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
index 369d9585174..6f2fe7bf746 100644
--- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
@@ -8,6 +8,7 @@
 
 #include "socfpga_agilex-u-boot.dtsi"
 
+#ifdef CONFIG_TARGET_SOCFPGA_AGILEX
 /{
 	chosen {
 		stdout-path = "serial0:115200n8";
@@ -21,6 +22,96 @@
 	};
 };
 
+&qspi {
+	status = "okay";
+};
+#endif
+
+#ifdef CONFIG_TARGET_SOCFPGA_AGILEX7M
+/{
+	model = "SoCFPGA Agilex7-M SoCDK";
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc;
+	};
+
+	memory@0 {
+		/*
+		 * When LPDDR ECC is enabled, the last 1/8 of the memory region must
+		 * be reserved for the Inline ECC buffer.
+		 *
+		 * Example for memory size with 2GB:
+		 * memory {
+		 *	reg = <0x0 0x00000000 0x0 0x80000000>;
+		 * };
+		 *
+		 * Example for memory size with 8GB:
+		 * memory {
+		 *	reg = <0x0 0x00000000 0x0 0x80000000>,
+		 *	      <0x1 0x00000000 0x1 0x80000000>;
+		 * };
+		 *
+		 *
+		 * Example for memory size with 2GB with LPDDR Inline ECC ON:
+		 * memory {
+		 *	reg = <0x0 0x00000000 0x0 0x70000000>;
+		 * };
+		 *
+		 * Example for memory size with 8GB with LPDDR Inline ECC ON:
+		 * memory {
+		 *	reg = <0x0 0x00000000 0x0 0x80000000>,
+		 *	      <0x1 0x00000000 0x1 0x40000000>;
+		 * };
+		 */
+
+		/* Default memory size is 2GB */
+		reg = <0x0 0x00000000 0x0 0x80000000>;
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&phy0>;
+
+	max-frame-size = <3800>;
+
+	mdio2 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy2: ethernet-phy@2 {
+			reg = <4>;
+
+			txd0-skew-ps = <0>; /* -420ps */
+			txd1-skew-ps = <0>; /* -420ps */
+			txd2-skew-ps = <0>; /* -420ps */
+			txd3-skew-ps = <0>; /* -420ps */
+			rxd0-skew-ps = <420>; /* 0ps */
+			rxd1-skew-ps = <420>; /* 0ps */
+			rxd2-skew-ps = <420>; /* 0ps */
+			rxd3-skew-ps = <420>; /* 0ps */
+			txen-skew-ps = <0>; /* -420ps */
+			txc-skew-ps = <1860>; /* 960ps */
+			rxdv-skew-ps = <420>; /* 0ps */
+			rxc-skew-ps = <1680>; /* 780ps */
+		};
+	};
+};
+
+&qspi {
+	status = "disabled";
+};
+
+&socfpga_l3interconnect_firewall {
+	soc_noc_fw_mpfe_csr_inst_0_mpfe_scr@f8020000 {
+		intel,offset-settings =
+			/* Disable MPFE firewall for SMMU */
+			<0x00000000 0x00010101 0x00010101>;
+	};
+};
+#endif
+
 &gmac0 {
 	mdio0 {
 		ethernet_phy0: ethernet-phy@0 {
@@ -54,7 +145,6 @@
 };
 
 &qspi {
-	status = "okay";
 	/delete-property/ clocks;
 };
 
diff --git a/board/intel/agilex7m-socdk/MAINTAINERS b/board/intel/agilex7m-socdk/MAINTAINERS
new file mode 100644
index 00000000000..d69e614a0be
--- /dev/null
+++ b/board/intel/agilex7m-socdk/MAINTAINERS
@@ -0,0 +1,9 @@
+SOCFPGA BOARD
+M:	Tien Fong Chee <tien.fong.chee@altera.com>
+M:	Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
+S:	Maintained
+F:	arch/arm/dts/socfpga_soc64_u-boot.dtsi
+F:	arch/arm/dts/socfpga_agilex7m*
+F:	board/intel/agilex7m-socdk/
+F:	include/configs/socfpga_agilex7m_socdk.h
+F:	configs/socfpga_agilex7m_sdmmc_defconfig
-- 
2.35.3

