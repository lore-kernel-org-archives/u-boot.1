Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED39C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E2E283E9F;
	Mon,  4 Aug 2025 03:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="mp3ZLPsk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36DC783E46; Mon,  4 Aug 2025 03:25:32 +0200 (CEST)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AFCD83E57
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hk0+OmCZlewVOxI/5gWxkJ0y1HWusB8PUa8aEZkgxMy0ZW5KRaeCQOVjfH+Wy8D8wgxOtwqPcfMBHnDS52u3z2LeZfQ2sOIF768m6Mvh91VOig2UheRazPfQOX4n6BPSrm1lQLAXhM9MEeHYnye9QQMHoObzdcLFrirJZ2inlCWHYvWHZSTfYqgL3O6i/oieQknn4dlRbbq8+7zXpPW5tjD58/WfPD1+YReUecIzl0/4+kVCptddwoB50gov7lV5M6A1jrBpoj6uFIroiag0RqyAicUsVHUwBmDLOSMtr+h5kg3btkelNtxxAGKKJE+JE5chww2Bx0QBQKOWrY9ZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ts3rQBGcahmNibrCtfWp3ML5E5LAYKr9c6RhrdCLYNs=;
 b=jyRDQdN5MCxDxC80oqbnsy8FYhs4VNVnstCLQvqVEkU5efHHXw6GysunVWyqPQDvUD7qxzYggoDX8Lnsf6YdTYnjr4E3wY3zboLlPetf+eljT3uERGyhoiA3I9ts0UKLRCfp+P6P4eRH4MoIYmc13UU4F/Yr7teeXzJwPegwNBhD1uVZ2IJN19qBsePijywcyZjd0ksTbRucZIAcqK32l+iPzU7L4IvrsmmcmELAqcdwZzO0a4Qq3iCn5tHsW9TV8xwbMrrliziDZD6M0usS9fhKQL7Kt75zcK0MmgU2k+rTQxZMG+x82ZhACeOffN9B3ZXBEW8h32aO9+O7lzU6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts3rQBGcahmNibrCtfWp3ML5E5LAYKr9c6RhrdCLYNs=;
 b=mp3ZLPskeBgcIC8ZraFiLYfxGhIHYLUme9swGoyJvAm5eik/swM9RdIKnVQHP4Tc7HP/hypXh+P5d1wV6Ty0m7MvhlVXWwVct2SBh3wOHHuVgYBDdGDjOYhMPL45wjbuMMMEClI0MRu7oYMyYK2WfD9tohFLrVsA6GukekqAvLr90Yom6UHShL46z4nY+dT+/0LFF2ZMJBG3MiqpWsDgzX7d5W9CBXImrreDFQODVlRy3cfAQOCKlpFwoKBtnHf5yQZo9yYR23qVQuo0dUvyr6JZsrWRqjUkrENL1xsQJnl1bckNzGYPB2XqiO2Y41ONo16wJ9bwMLCZk2czg4T2Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:27 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:27 +0000
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
Subject: [PATCH v1 19/34] arch: arm: agilex: Clean up DT settings in U-Boot
 dtsi files
Date: Sun,  3 Aug 2025 18:24:46 -0700
Message-Id: <20250804012501.21811-20-alif.zakuan.yuslaimi@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 54a817b7-bce7-4e57-69df-08ddd2f5cb43
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2wGwhbRHsjvExM36fTltX9hFwYmkfdSSYs+SOktfkUyLsKKpXLe50lQbOJJu?=
 =?us-ascii?Q?OSWqY6zDrXOVTLa+v+27PN+o9JQ8rB3aX4Q7B3iGFdbMwTw+i5xZ1k1xsY3z?=
 =?us-ascii?Q?gaLvTg47hXBdvhmwPtt2HclcAhW404kgAWGvj4K2fx0SFdR0Dk+QVWf6Gt7W?=
 =?us-ascii?Q?ikwYmSeMVke2BeVpgxhbsyLZ3kMtU6xwCF4QriihsTwORq/PRXFkGlUAM0ti?=
 =?us-ascii?Q?VqMEG1qmDjjz/tLmWSqGzny2bjH8I9vDTJhZZiqU5oNat7EeI2Q2CIXOZtHy?=
 =?us-ascii?Q?zHmXO2kSQ4J0k+3ox6Ttd7rEfoGBqnKD6EigbdJHYkzSgVgkJo6vMf5CwmtR?=
 =?us-ascii?Q?FWR3293wCvr8sMaSuoIArroUajMdo+CDPkQ3BljTWVgFnH0pXX2LRUipB+dO?=
 =?us-ascii?Q?T6hWtful9bLdYTjqpf0aj9IqG8iJwhm72DC9lc9JINRqlyaewai2+i/CKB8Z?=
 =?us-ascii?Q?H7+KPjrDnIIwCaPH8klP11JlDDZ0BeJjldiZPcBfkxcZEtKGRs/8z+PwCJM9?=
 =?us-ascii?Q?ypsfGo9tDrLCxVbcoxKVWubhnJPWHuAgDsT12tG/cqqmgmgJcNa3NSmq3Nvk?=
 =?us-ascii?Q?BiAku3LRa/6NEOS9Qu9p8ET87tiaI/FrV4mu8Cf0oSaR8CoZNd398ZLbAB1i?=
 =?us-ascii?Q?FNFQVB2MvVh18s++LUrAjbX7lWMT2QAlEg9XKidT78qShC3AmllNVv9e07Jh?=
 =?us-ascii?Q?KqPZs82OnR+GodDLayWR3TFn4R3v6G+t8HRswl/yND2tEdPJVcmd6AYemNGW?=
 =?us-ascii?Q?jaFyjTAy7IUiR6eUGPfkKAzdHEv4hAb8kI+IYXb3csKgH4WD2m5iJFXOUzY4?=
 =?us-ascii?Q?LA2ynPk+GntxBUjfg9qGMWVaRiKouSxTIFSb8RvQQfCxsIFS+OKPFATA1Mep?=
 =?us-ascii?Q?Vy739aO+BK7bc0Z5ovQDb3A5cZR227b7NOGoIBLuzqMbi62o0RrjuP/dh7zf?=
 =?us-ascii?Q?RxLZKcSxMtxVlfheBTpXy63R0a1TrBW1HSbKX8oRNizyFkVqGN/G6QnfGOSN?=
 =?us-ascii?Q?2/fcNQg1cwiBQENveQAciDYPmEArVy9Tj+1AzmQTPM4thOcn2y+QFcJYDEu+?=
 =?us-ascii?Q?USXk4uPQ1bS2PqXB9cOOom4VG7lb0+CdXDurZ+FhWHS+KJefVzL8DpEDzjF2?=
 =?us-ascii?Q?7/HK1z159pEcXQdAbo7Pl2QFZIoN14jHUfBcY18At7O2nm6xAaGufzErjpxt?=
 =?us-ascii?Q?LfAThgqUqv2Nu5805KnZGa9EifGxB3S7IO8yIfgrrz45alhk+EVsXPODDxG+?=
 =?us-ascii?Q?b3In75kdNOSKnRi/3qyUk1BBEWV1t1YtpLWTxcm0mqdpFqi4jhcvvuZqHnwk?=
 =?us-ascii?Q?0FN0FgtWPgHGLslsR1ACXJNnHaL9USempRAHEYj8vV7j2GbH+OkS6mHiwvBL?=
 =?us-ascii?Q?29uvWXTZt0LQOSANXJ2GOgetaD1UCrPL8sz7PVM7vXl+rG0lbOj7c/Mg7tHL?=
 =?us-ascii?Q?frVppFUr6x4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3/qFXHE26UIvq2jMYuXXZJgbZ6LvdAZY9RN/i5DkzQ+yTg8LRcGFLOGeXyHE?=
 =?us-ascii?Q?gJFp3XF7lMuWGvy4I6z9c+VRNJ6yWU1QEpcmcvU2LMK5rTVcWNARIdM/K2nl?=
 =?us-ascii?Q?4rZHJpXtNQ6/nxx/HNEObetDubcAJlCySJ0bhe7BwK1IoGJ5Z9uB4CgeT9wa?=
 =?us-ascii?Q?wOaYZ7/TTu9748Zr52xXc5ugk/L24uAXVTF/wr/7u4bQXdJvnrdAJQLzj/bn?=
 =?us-ascii?Q?FsvHhiZR3hc243ZOdHukm+iwwDZBBPt0UOVZqv0yAoZ2psVLqca4GJBrLBkf?=
 =?us-ascii?Q?C/5/r+WFV3SJINWhEW/A44sgTDvZV/6xGhbEmLjhJQ0REGS83iBI4WIjaOeP?=
 =?us-ascii?Q?uGqMkNKrgfdbB0xGvnqpaFalHhma4TDLmhMV+RIe7WchKqjjNRijtii8WkKF?=
 =?us-ascii?Q?DhkCbsgfkIwkRYrOLAHqtZniVbPcl8e9iuIrBFcbj6tQSBMiVKPT0PL13Kj7?=
 =?us-ascii?Q?g6HkZPN28hbjETiaMSaPsPeCTGELJEmxiZr6yn4OiyhOKKQRljn0LzOX+pAy?=
 =?us-ascii?Q?Cr0U2H7pJO8xoBtS1Vm6JC9t5Q5SzDEs08ff5okRiGLeXloWG6K1+nHyn42j?=
 =?us-ascii?Q?vQaaZteZYgaGpzdl/+8fED/rL8CaT+7bQ2kl8whPpfagfbl0VBZYTUoMnMbq?=
 =?us-ascii?Q?lW3Q+ua3/MnBwG2d7Zbx18/eM+eWnmvE6IJviNqqVOL7bPj1F3EfZpBwNqs1?=
 =?us-ascii?Q?AQjVrUR+um8qLZLATxaseM4KZUOGxkpsv3yNTZwuUX9sMXaqRMhPLxoXHADR?=
 =?us-ascii?Q?pMhgxOse2b4JX+wL7sJUIqf6VF8vGlFl8l9/XjtsZGXL+QGd8sYu0KO+JJS9?=
 =?us-ascii?Q?fYwfui9cyYUBpy9SPeUCBcm7jVb06xwJjbCPg4wdZDnAgF6vijk732KvYk6Y?=
 =?us-ascii?Q?sQ8dB/4lDXFcNqgDEbkEE5isqDLSupaQe9SFcQHOeErQo+shpr+B5dhi0UPa?=
 =?us-ascii?Q?kLPNXquxMra2+HNgzTLbQ8AV6fVmJVD0niJte5ASTk0xRzWtQnyHdsBplMUN?=
 =?us-ascii?Q?3DONboKlKFi55BPZzOOUrYk06wArLctiR7P56hxjhLwXepdBQIEk/Jzc+m6D?=
 =?us-ascii?Q?YquEQR21PCOZZnvPWPEYdLp3Wq1zk6d0GGjD5F+jMZaA7ts409iNHjicN9i3?=
 =?us-ascii?Q?hMzqD+3l+AA9ETa7nzhOKsC6EJvujhZr0r/P78h1mfAyeMD4H8Zetyep9A7L?=
 =?us-ascii?Q?+f8jhbbBDpdbmx6jOgD9KDPKFuQj2v/CeYcoxJR7B9922pJaGno/PubYs9Eq?=
 =?us-ascii?Q?KS3lmEoifUX4gJ+UgxU3t4/3fXQ7J8Zmubh34DU9Oa3llKjE+vYKLJbTbtor?=
 =?us-ascii?Q?uArO3P4bx5NHuiq5qBh7HoZ67HeR6xBj2emI2Apm2GRn8f7t/KDsKl1Uxap3?=
 =?us-ascii?Q?QhZP5jJVEpadVVz1aDDg7OjqR9+o1VXZkU3iLsf3s9N9G19CZ4+g6Xab37Zw?=
 =?us-ascii?Q?AeKZSEcFDiV0yEE8nc+rOzUq/CHxiuj4/xJVvhG+nYJZM5tYghZg9XOc8Lty?=
 =?us-ascii?Q?QebWfFWESnBk5HYXdrYaLb5mUbOgJMHbBkcwFLIgq9XWvporILEGQAu9i1Ag?=
 =?us-ascii?Q?wrIlFTI9EdSz/p6oFLZLr/FmKDWPuwQlRRvLa9CKwavW4yIouJGOPu5HT+SZ?=
 =?us-ascii?Q?PJug549uPJ0wWN6aJiT8QjA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a817b7-bce7-4e57-69df-08ddd2f5cb43
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:27.7350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSoYpebqNf4Mu1dYJMM7JXwcBNG27iv+beHbZUCwPq1pN4f+eS5LkUMYM5z9RlNcXOyaAhKxlKAxTAzr7l6C0m+eno1eLcPlTlkC83kB+sg=
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

Reorganize misplaced properties by moving board-common settings from
socfpga_agilex_socdk-u-boot.dtsi to socfpga_agilex-u-boot.dtsi to maintain
proper separation between common and board-level configurations.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/socfpga_agilex-u-boot.dtsi       | 20 +++++++++++++
 arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 28 -------------------
 2 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex-u-boot.dtsi b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
index 890ffc5f7c9..91674669886 100644
--- a/arch/arm/dts/socfpga_agilex-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
@@ -10,6 +10,13 @@
 #include "socfpga_soc64_fit-u-boot.dtsi"
 
 /{
+	aliases {
+		spi0 = &qspi;
+		i2c0 = &i2c1;
+		sysmgr = &sysmgr;
+		freeze_br0 = &freeze_controller;
+	};
+
 	memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -19,6 +26,12 @@
 	soc {
 		bootph-all;
 
+		freeze_controller: freeze_controller@f9000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0xf9000450 0x00000010>;
+			status = "disabled";
+		};
+
 		ccu: cache-controller@f7000000 {
 			compatible = "arteris,ncore-ccu";
 			reg = <0xf7000000 0x100900>;
@@ -45,6 +58,7 @@
 
 &i2c1 {
 	reset-names = "i2c";
+	status = "okay";
 };
 
 &i2c2 {
@@ -171,3 +185,9 @@
 &watchdog0 {
 	bootph-all;
 };
+
+#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
+&binman {
+	/delete-node/ kernel;
+};
+#endif
diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
index f9491d57068..c2770424d9c 100644
--- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
@@ -14,20 +14,6 @@
 		u-boot,spl-boot-order = &mmc,&flash0,&nand;
 	};
 
-	aliases {
-		spi0 = &qspi;
-		i2c0 = &i2c1;
-		freeze_br0 = &freeze_controller;
-	};
-
-	soc {
-		freeze_controller: freeze_controller@f9000450 {
-			compatible = "altr,freeze-bridge-controller";
-			reg = <0xf9000450 0x00000010>;
-			status = "disabled";
-		};
-	};
-
 	memory {
 		/* 8GB */
 		reg = <0 0x00000000 0 0x80000000>,
@@ -43,10 +29,6 @@
 	/delete-property/ cdns,read-delay;
 };
 
-&i2c1 {
-	status = "okay";
-};
-
 &nand {
 	status = "okay";
 	nand-bus-width = <16>;
@@ -62,13 +44,3 @@
 &qspi {
 	status = "okay";
 };
-
-&watchdog0 {
-	bootph-all;
-};
-
-#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
-&binman {
-	/delete-node/ kernel;
-};
-#endif
-- 
2.35.3

