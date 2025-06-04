Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E441DC5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FCD482AAF;
	Wed,  4 Jun 2025 21:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="RpmiDQ1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C15820EB; Wed,  4 Jun 2025 21:56:24 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E87781E72
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAX9s3sv7xQzmt7eM6dpyGIEzB69LbFkRpG59wP6rK+vOITzvMKa7RNCwO3zCe4is1SFohj6pJmZNpjfS5G/Y/iNNVQ8tDNn7Z0fCCFd0awQr3bxfi1SSmO1qpG24PgqkeYbuFpSU4VFN3e+s6YYFdas2KWKmPnJ5mFutIg4Ot/BNX87yvw41azJVQGdcMwmfnDpICc14VdjcC8M9p4WrIZvVLukFQ0ZZYbbRdfEXGr+7rX5HCHLGBjOWhMZKuC0cRgVv9aYufKfpKATZENiQFEEKK7LO3ZAvNBTbr1wDYw2Tp/sSW818icHHtoX9ypUMf/cmeD2cYQ/p7MmClSVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZERRkdSU/avD5sPOwI3YEpiAm/BlUE42TYrECklFnEQ=;
 b=RigFlC+02BkzqcAHLedkxtDOyyCCIqVpUx4TBo4eaypErABsv9MaUu131J9YWymg3hEKrblV+k58mi+IqD0PnermN5ZWXBLMfSundA97qCa1qTVbJqrkq3BPFDPSuAeKe+t1mHJuxBNWTxPsYmPsG86EwDGIOy8PrYEFWdUF9sBBMJI7Q0sopbedZQtLjMLKRAI+xVIXGQBH7+S/H2vS9rPlMHfuk/ym85Gr0N0WnrCSzaAnt3GgynXmasI2gP9by4otRb2IfZxj467i8JQaIma1Lhiu9Iw0iQ8y7RG/HPcGZ1GBR5aOGT/8jeVOl4KwLC78vhZ1P9qVtyPVWnj9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZERRkdSU/avD5sPOwI3YEpiAm/BlUE42TYrECklFnEQ=;
 b=RpmiDQ1RmHxEn407ntNQsoVtgdRCQV0re0FCzgavc45sSS3Gp/sMhW5UvTkoDBYqV3ZIzwK0cQ81ST7fXY/ix5lrCB7H95LAryXsL64OH6BZ+tBABH3kCLZPHXGLOP69fkiaJpPKnYQrnMYD1UnYnlVmab6jgbQ5yyB+xUL6S2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 19:56:16 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 19:56:16 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 01/12] arm: drop volatile qualifier from gd pointer
Date: Wed,  4 Jun 2025 21:56:01 +0200
Message-ID: <20250604195612.2312979-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0041.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::16) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc4265d-2444-433c-403a-08dda3a1ddbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f0z8RgK92yYE8XPHThgsY9B0o3km6mD5VM7nXn4OCtoDhpTfWmW2r/gZIZhp?=
 =?us-ascii?Q?f55U62Vlrjq+QXdrBXODJtz44xEL5Ao7PbWJlsZEokkZFIVO3aZWy2F3ii6V?=
 =?us-ascii?Q?C2/N58TjCHE7xXirA6rXIdBwYU14OT61aHmM2v4NEMVO5Y4FHArdI0U1EJnX?=
 =?us-ascii?Q?0ewn+ZFT47so0uzr+oZH+F6sL4NVAXL3yX579Udadg9cnXLMBLwrf0GtWvjI?=
 =?us-ascii?Q?tX9FsZGTrHyaDnjXtjAI6YHqWWfBEJFxTKERV0/Z1Xp08grYhbjVswt+M4US?=
 =?us-ascii?Q?NG0XLA3rPhIASwpNiFY4LbWYAaxbUyToIHLts3Onb1Ks+Ao8AI2zqcPugGAN?=
 =?us-ascii?Q?rLDIoTrM5GUxk5nHL5TXOtT7RCU7sgetRGDHh3P2wGjHdumPK41J3oGg5qNm?=
 =?us-ascii?Q?0wlPjHqGNCZabU5Ike14c9b6XPkHzpWvD63pgtScV1KQ8qBnIW3fBjpXWhSN?=
 =?us-ascii?Q?MgmpswFCvG1Ewg9fO5D/hX2tnukaiDv3IqdfxfsQcMcJQ0jUX9dV3JR6PyJ2?=
 =?us-ascii?Q?vLSVs56IU/wwzuxvxw5L8iRPmEvIJsa+oADkpBSTxE6bnQ+1YOmFJOY4DpD/?=
 =?us-ascii?Q?q5hc/3mhofZbm+LqSYLSyCj7nYUmO48Z2nB6cLQ8as8Y11aU8P062vlzItEc?=
 =?us-ascii?Q?qIEs7aqAFQRlxQQVU4MkMwBTvX2dUxTiZiaEGEvSZJaNK00vdyOwUfQT+A6a?=
 =?us-ascii?Q?1f3iimaVruvUUZDqQ2OJy7Wvjn4GNdjVxHlXSDCYpzhI4f1jVOPba60YgwsH?=
 =?us-ascii?Q?ozWRQzDgqR3Evw9xbCpUHuwBaRn56MkD2Rx+gWgpftpWuu1MWTl0Hvaefx0A?=
 =?us-ascii?Q?ds02WnfPDGSKo8jGT1AvKd87fRvRKoZtS+A6wGWrWZ04HKrWia6UdaC9sprz?=
 =?us-ascii?Q?O628F52REptJDTw7nLoCcpNIzAzHHoKgHQRkZX5TLOj9z/+ZJ4XKcKmMusCw?=
 =?us-ascii?Q?h7FdFkWw0y0k0M5jUf4y+70+vd2BNgo7TMQ7DTQVf/4y9wXZ8QEYqtovKDw6?=
 =?us-ascii?Q?rX8ZHH2h8NXK7SRBoyvd0W5pgWrL82HIo03kpW18uPc5FC29zAWSlkzcHvI4?=
 =?us-ascii?Q?Fkia0j6NTTVI2eMLnmzJ7EmK2rosBi+nzCEejpDyQIcZYWGVsiqJXJab4NNI?=
 =?us-ascii?Q?odiMLv7N61kwl2h1HMqlC4PtP8PQL5qYQpuveI3P09b3rqB0CbNuBGEnOnKC?=
 =?us-ascii?Q?LZyFav8XkBISli7daGmQSHDz03xjn86osafspc3bzYkzslaMCwTOlTgKHtvX?=
 =?us-ascii?Q?Hx5Pom3TFv12xdpn1IaUK98/qcPZuHmZq1NVSOXpge7ggm5iXkxrzIsNDqlA?=
 =?us-ascii?Q?HTUrPO5rLXIQFzyBLOqutgvvWihBAXZ5fMZj9Du+KKjqteaSSPxF6UX/JWU1?=
 =?us-ascii?Q?FC03S1DBeVWr20YCajRJAC+j2wmIFUGY4fHZfzbzlZfGvnbaptHPSGYeilPG?=
 =?us-ascii?Q?1dOKVE4MPok0EcFUBdZYwdI/k6bKdnQJNzELDjM3itrOW5BJwHdu0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R8QBpYiEErsTbjKmaC9dTlLOhODOmQ6mbJBbtXAIFxHwYiPbHVj6rqZcl6xS?=
 =?us-ascii?Q?JPJr3QsKW6kpubYGJxEGhDMFdBjNvej+hF8lIn4x5OEfo8DEh86x8bb20Fu5?=
 =?us-ascii?Q?A4ZTs4R9izfzUVE+qVQJJ1wdaCYODKUQ2BcAOfJqHaPZAq84ztSCizO4QNwq?=
 =?us-ascii?Q?z4DyCRTJFJjyRAjBTVSjr32K8+dANNpomTz9ZCjT9QQtOH+BEnw+S7MFhuUV?=
 =?us-ascii?Q?t4+QSyIWTFiU+3Wsi1COFiRzv4S4sCEOpf/CPv2Caxq/6JfKZT6/n5QdzO1B?=
 =?us-ascii?Q?aXImlgoeCOO9uRch79lCVYWjVH2n/3LwnLpbMCqFqsrc0IVvjz8QRfo5kUgh?=
 =?us-ascii?Q?k5XqUIMtgxr1Q1bnOJB/OiHwiM+6/YZPy+Ity5X0SUB3ODcB//Q1C84f2Rh2?=
 =?us-ascii?Q?Sol8eBD5eW22h/tHt3P5+t2ZnXtHqFzuZPg/d5DBebJ+VJt7dybL7DMWxV3e?=
 =?us-ascii?Q?l30T1dPYMgW5S8KrpePlLrZ9BixymgN10cFAB5ssO3QojE7Vn8RtyX238Y9s?=
 =?us-ascii?Q?fzGTBS5UD5bbsedSUU7rHTcReLRyfxIMC9TFgBFCTy2l3jL++wtYKJ5BelrI?=
 =?us-ascii?Q?DgeGLJMCjiBmxqju8L4QT0Y1HZWNNrMsjMNcBRZr0OQ3KbtizsisrzNhv4RG?=
 =?us-ascii?Q?D+WTKY93x4qpNFu4jnGrsRZ8Y5jjwWjDiuKDm1WlO4/bQp9U/ZuDuarSCMSU?=
 =?us-ascii?Q?9Oq99Jqi5g3YMfvsAO73gjszpk2ZkuXoB+eKagftFTp0CKGo+JlMnG5Pyzqu?=
 =?us-ascii?Q?7o2T/1e+/b0UOgVG3YdgXa1LMwrDxQ7bO+M3v2mYA9BjKW+1PIHTLaP0cUKN?=
 =?us-ascii?Q?JwjRhDMF7nfy0mqxgxFNYidwZBymFlbz6+cQmH7MjW9uqOXs6dAHPg9rrJw1?=
 =?us-ascii?Q?Sfcm/yLnsF7mYhksExf4xrakbiu+vLGZWqtT3A9Tf3CBSoQHS0fEG6RIvPNW?=
 =?us-ascii?Q?u8uyD8ly2FTgQfvTDl4o1g/wRrBhN1YVIDaz7w2B7cItsBGjLBGuQpJd1SBd?=
 =?us-ascii?Q?QuSK4BPMbBZx64H8PYZx/9hC+9A1B89K1hL5H1SBYBmIXyEL/xhcnA6uaC0P?=
 =?us-ascii?Q?IuRIuVt+0uJ+d33IoKGVcbA7KjCuI8MVqIigfMiEmJFXK0nUDdw86IVX1Kd+?=
 =?us-ascii?Q?1cBDVwqkdBVmFBDbTTC5IcSOHLIrtmulh+YMS965QsFMq+yhLUBphBR9pqfu?=
 =?us-ascii?Q?klDzlZGX1Riw1nKIUkFwUcF6fbjrEIqfNpT5qufnB8D74RBVtRMA0wAAFY0J?=
 =?us-ascii?Q?f8xU6X4kwDg3n5APOHWB+HHPecM3ZU3YShUVCKF9lzQRVS1nPGq/3Is55Ovv?=
 =?us-ascii?Q?1+R8jpO5DvYmTb49MLAoz9IVSLmIuO/cejjqE6bCyWXPXLRp+m+/yuWnnHm4?=
 =?us-ascii?Q?LUUXr/Bjx5JD1QzDtxK4vnoFzg3A9VupV/KBoH1lMVn3ViVmFk0I2t8dv1XY?=
 =?us-ascii?Q?XmUNXmZuLq47WDL7TI0TxZnRTdD67OEp6Xwnp4FbgIsRm8YgXSSgZl8Jefh+?=
 =?us-ascii?Q?eZMsgrFL0Qhhc+rTVMtfKni3wL/e23g/uJ4TEQ5C0u33VpKidsikX6Q17Eph?=
 =?us-ascii?Q?7QVb0YCVoyKEtDniBQwOy9RgDvvPu9vEdQkPDADaLZewfwBQTL3BPb+tbLR9?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc4265d-2444-433c-403a-08dda3a1ddbc
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:16.2705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lm7F13BRI2hMi3AspQI18NHrLhPwWgkF51nanoIrwqHkGh4Yo/X3VUrF0GAOLpycyY1fLdOi0gi/dd6czXQtK9kODQSChCQlShMqGMxprw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
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

There's a bunch of other places where this qualifier should be
dropped, e.g. in the set_gd() prototype and for various variables used
for stashing the value in the mach-imx/ directory and elsewhere. But
that will be done in follow-up patches.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/include/asm/global_data.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 45401d5e3c8..f7a47204b7c 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -133,9 +133,9 @@ static inline gd_t *get_gd(void)
 #else
 
 #ifdef CONFIG_ARM64
-#define DECLARE_GLOBAL_DATA_PTR		register volatile gd_t *gd asm ("x18")
+#define DECLARE_GLOBAL_DATA_PTR		register gd_t *gd asm ("x18")
 #else
-#define DECLARE_GLOBAL_DATA_PTR		register volatile gd_t *gd asm ("r9")
+#define DECLARE_GLOBAL_DATA_PTR		register gd_t *gd asm ("r9")
 #endif
 #endif
 
-- 
2.49.0

