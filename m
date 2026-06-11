Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C05BCD98D5
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640B4849A1;
	Thu, 11 Jun 2026 14:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADED6846D3; Thu, 11 Jun 2026 14:28:30 +0200 (CEST)
Received: from SY2PR01CU004.outbound.protection.outlook.com
 (mail-australiaeastazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40d::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8645F839A8
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 14:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=heitbaum.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rudi@heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuZvj/Z4RSAULAd+bWPx0huxSs+NDz615JPOUlAzNl9I/ynRT2rppBo4MgpAwpaGYUE3RagEe3NoJWPcI5ZAPfwljfe2UnOhb1NoAVXi3EsMNDAKPiLs1iPWhRPXcTjUBWAZG4GTACHLdwBjZCoNnyApflM+gr9fMLJoVvnJzTB6NXgafG6eTIxEt1tm+Mwzr1wGCmlLmSGewhZIFWhPOfpYdBIYvSnGPisrY1AYatH7eBua+VuFyYdpvMtSsxhjYuY7iBDCGTLqdkXWl+8/QDwegwM3Kzc0QG8nYo1rlxUrBK0NYDqgk/Z+/7ei8vmEH8X6ILpxf3kenbf3GZ/iAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CTgWRiK3Fm8qwMjShbZnah9c9ccnjItFBAWZwxhzfo=;
 b=NhQWzK4kARND2kr/duahP0p8mPgQQOq9QqqPiJYykaNhGKEvvIikH7BhO+wEvjEdTZwY+lYGKmJJ8mlE720tD1g6VD7CVR4lclWgxIDYrhM7ryuC/hDrJOE7rbwSkKwGw/xUm2I/zjkCNUVj4XQYkbgto8WWKyD288+RkYsV9gyyE6ZDrZE3WekgVJEJaKwTcx3JdhMVDbNfqjyFbG0+W5o8LWJXK95sqLvPs3+tMvdUmGIEHmpVKnQtGgNU22WjEEltx9tXs47g09sszKu8sF5vzfGDnPYvBTo0rbWHULTIeurEkFsVZTdpZU4u0g2bSsM5aQLO2R2rBCuS8X1xLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SY8P282MB4907.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:25c::10)
 by SY7P282MB4012.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 12:28:22 +0000
Received: from SY8P282MB4907.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f1b5:3901:d12c:e9ae]) by SY8P282MB4907.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f1b5:3901:d12c:e9ae%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 12:28:21 +0000
Date: Thu, 11 Jun 2026 12:28:08 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, rudi@heitbaum.com
Subject: [PATCH] rockchip: rk3288: syscon: use per-driver of_match tables
Message-ID: <aiqp2My_Hd-bHR01@e9030ceee902>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MEWP282CA0026.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1e2::15) To SY8P282MB4907.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:25c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY8P282MB4907:EE_|SY7P282MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: bf572a95-37b9-48ed-88ab-08dec7b4ed08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: dLHkzu1CTo19tDqTtRuZW8VtDwa8IZjUIjYHQfJrpo9u/QEA703RFhBkQalHLIuiTVm+nYYZDy62hY4MX/4zfdMnzEVrDq8uBWeapMeWmmiRYglb5Sg4oBI6+kZsCUR2CjydIxREFRuq2r+uuk3Xi4T78hgQ2iPB004T73RQHiphcs9xHEuzZKoS+MX/oI2y6JEw97aR8kV5RQRAfy7X+d5BZlzB2jxAKdWlaz51G3FPl9ZEovR3UCFQ6kP49+pbS+wHvgo0lMpSg6Gmc0YJWq57Bi1N0l3cRNNc0Ja0Q0YxIut6+SCIc4eeGw0Os658vm5qRvYjUgJjFqMlolH+Dl66vy8A71vFmib++6tCHTf07dZU2APT5Jpp3xYM2BRsgWkuW2bXFsyFtVDZ5Jd0OC77S4ahmRlDKUjbvi4u1vaOl12BWc0jqSEoHDZ9cXXAuSa6h43ldd4UVYOLqAc/f1D8GuXLVjZxWbs/38sS/hQE3HKlo8lah4jPcWe3enC1WsonSqWlL80mn/OPmn1nN+Ad5te7plMquzFx7PGbxGSo8L93AZAfBc2nDlFPaNVwOfza//+pJLm7GyoQCxPOWFnkmY1IiGXHuOVN4giGm3YEkYfMUq/F63Y30gOqlLz7xmOFpuLLmrcctCZCX5RDvjXqF0intFw9Q8sXItYfzc97xM5n8OVIFgpFw5VNCJpn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SY8P282MB4907.AUSP282.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WGVls3+N7YbCR99fp4EDR34cgXlohOTURkOr8YwTZF+15WedcSGSLCJ7MA/J?=
 =?us-ascii?Q?NsWCdhoTzMrlBa4XspGZh31WYEOW/Te4JBLJy+s56ErURR+dlZsKZrOzFcLt?=
 =?us-ascii?Q?jlqULHuqbHN9HJbN2DtvsorWcyLfMOaA1n0dUYm+7CYwzAysLbV1kmUVXGYE?=
 =?us-ascii?Q?5Jt7xvl8IMp/d+qJNqJefbGW1MlhWjTyBQsHDSgnTlpoKw0SGIcvnqzeBhQg?=
 =?us-ascii?Q?h+ECUVRAj+/VXaysJms9dx/BLXzeZl4yhOvNYQGnH93q1aXvlm9M82rPIuX8?=
 =?us-ascii?Q?iRq1kw+fjMxeQ3MlOJHXATWCYheeRPe/EqxD9U4h907oH0cgekbkdHzVyj/i?=
 =?us-ascii?Q?40LngCfsVxOM8SEFCHRlG8VccfAlGFK4E+wg7fklTNkSr22Z+6/0WIBG2Nu1?=
 =?us-ascii?Q?WedXITTBi56VOqkwQOt1T/F1t3P/7p6llavdX0zT1J+dQzOD3BSGvL9Rw8mK?=
 =?us-ascii?Q?QbxatopKMb47rDXZ1jw3djIrGEO6k0Jaeq3AnOaDPWOYXzR/YEZmJv96aeDg?=
 =?us-ascii?Q?OqoSp/Q+QiOD98qTPANVX7Q6osFmt9aUIxMcjdQraqtUddKsH3+Z/mkh9vSF?=
 =?us-ascii?Q?Ap+cOHrcIFzm7CrSU6KSNr24lWFRqsTR+RNEe2cmr//GRKUqO3w0N3fU9NJv?=
 =?us-ascii?Q?Gb25GvpPxMpoUhwyDYrYGprmrpFIMfnPJS4yMrrzcN1C851e0aE/XkbCcw2K?=
 =?us-ascii?Q?hUZynNyoPea83+cySeohoTVNE9qNojHrSw4jM/N4udG5AgP5fDSLgH5hVjzr?=
 =?us-ascii?Q?ARvRXawr09znF0IGPoXNldFSqTVnk96fdkiOHtijBG4vYcmj4bcrtofNk0hN?=
 =?us-ascii?Q?S1akKtuBMa8Q+46huKiKajFTsoV0OMnu0ee0g7W7itCeSC5hnTK2LIYG3pm9?=
 =?us-ascii?Q?4uSZzaCzJ3i5pk/CTFWPv2gweFVQGB0XVjtSPVkwG6bDJuzhyxjXLStNv/zN?=
 =?us-ascii?Q?95FowWx5Ig1I/XN2Y5z8TDZofQr1RQJmoZl9TmryOoXhws4uy7V024yxvlb5?=
 =?us-ascii?Q?jBeIuMkahtz0c/tvMJtaV7DmLIyxqO3IAEgaD6o7qsMUh5seFKDJoBmNP4VF?=
 =?us-ascii?Q?ppN474jTW3vumoS1YdPzwQDGKZMSHJ2KcMIZoKvZIcnPNIlO8K3BFSAgr8m0?=
 =?us-ascii?Q?nOmGNtNf0hRTtyiY07WHHswymPJqFmcYRVOklfv+wzrP49+/aDiaeuOQeXQz?=
 =?us-ascii?Q?dR7ACmUtt4iWjIs0Grk+XUfyCemNfpQ6TOQSqJhN3KPGPLex1WBoLHl4RQuk?=
 =?us-ascii?Q?orFdwHld/CrGedreuWixO0KDz15dWwaeAza9gHZU9lhdWlfgh0GMQk8ug7xg?=
 =?us-ascii?Q?Bt7bB5/nTZW0zSqFmu0Hg9y6LfUsADEfcxiq17YufKP7ZxnBaWBID3kc8xXj?=
 =?us-ascii?Q?7/duyhDwQ089cUPaMryB29OK7hCpKbQJ7Wd1Ic/pdXBhMNjRyNQS+yzXFwjR?=
 =?us-ascii?Q?5fi04iYQqpcZFjKu90iF5BcKPSrcMk2csqLDQLm6OKNIGO7GcoqXfohyTMBn?=
 =?us-ascii?Q?Uz+h+9JKORVplh3Y2USQoGcqJ+suQCRyg6EPsOox0gyOhRpELlqPxLYVtN/t?=
 =?us-ascii?Q?f/g2CXgAR8EIGCiqJi9AoRcR6OxGJhol+/eTl9ZRfV7k0C0aQSx33qN5A3Ip?=
 =?us-ascii?Q?xTf/D69Weh8GPBXSZyrQY4gjvzudMJkqp15y58fN5ZxNyXBsWVUn4X5bW4PZ?=
 =?us-ascii?Q?QpuUv8QOwGvvLHm/R2399PBJmha68vg0bbuVI4Od1RJYi6kQ?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf572a95-37b9-48ed-88ab-08dec7b4ed08
X-MS-Exchange-CrossTenant-AuthSource: SY8P282MB4907.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:28:21.9029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbQ8cGrANou4vbsDmea8KDXsdF6AUTRA+1i8pULokEttzhxG0OrKN2BxeuCbZi9UJYK9Ty1te7crkbDgS1fhIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4012
X-Mailman-Approved-At: Thu, 11 Jun 2026 14:44:23 +0200
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

The OF_PLATDATA section shares a single rk3288_syscon_ids[] table across
four drivers, pointing each driver at its entry via pointer arithmetic:

  .of_match = rk3288_syscon_ids + 1,  /* grf  */
  .of_match = rk3288_syscon_ids + 2,  /* sgrf */
  .of_match = rk3288_syscon_ids + 3,  /* pmu  */

dtoc's src_scan.py parses driver source files to build of-platdata but
does not evaluate pointer arithmetic, so each suffix triggers:

  Warning: unexpected suffix ' + N' on .of_match line for compat
  'rk3288_syscon_ids'

Replace the shared-table-with-offset pattern with small per-driver
tables, eliminating the three build warnings.

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 arch/arm/mach-rockchip/rk3288/syscon_rk3288.c | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
index 6413d0a88a1..6f974d175b1 100644
--- a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
@@ -133,6 +133,21 @@ static int rk3288_syscon_bind_of_plat(struct udevice *dev)
 }
 #endif
 
+static const struct udevice_id rk3288_grf_ids[] = {
+	{ .compatible = "rockchip,rk3288-grf", .data = ROCKCHIP_SYSCON_GRF },
+	{ }
+};
+
+static const struct udevice_id rk3288_sgrf_ids[] = {
+	{ .compatible = "rockchip,rk3288-sgrf", .data = ROCKCHIP_SYSCON_SGRF },
+	{ }
+};
+
+static const struct udevice_id rk3288_pmu_ids[] = {
+	{ .compatible = "rockchip,rk3288-pmu", .data = ROCKCHIP_SYSCON_PMU },
+	{ }
+};
+
 U_BOOT_DRIVER(rockchip_rk3288_noc) = {
 	.name = "rockchip_rk3288_noc",
 	.id = UCLASS_SYSCON,
@@ -148,7 +163,7 @@ U_BOOT_DRIVER(rockchip_rk3288_noc) = {
 U_BOOT_DRIVER(rockchip_rk3288_grf) = {
 	.name = "rockchip_rk3288_grf",
 	.id = UCLASS_SYSCON,
-	.of_match = rk3288_syscon_ids + 1,
+	.of_match = rk3288_grf_ids,
 #if IS_ENABLED(CONFIG_FDT_64BIT)
 	.bind = rk3288_grf_bind_of_plat,
 	.plat_auto = sizeof(struct rockchip_rk3288_grf_plat),
@@ -160,7 +175,7 @@ U_BOOT_DRIVER(rockchip_rk3288_grf) = {
 U_BOOT_DRIVER(rockchip_rk3288_sgrf) = {
 	.name = "rockchip_rk3288_sgrf",
 	.id = UCLASS_SYSCON,
-	.of_match = rk3288_syscon_ids + 2,
+	.of_match = rk3288_sgrf_ids,
 #if IS_ENABLED(CONFIG_FDT_64BIT)
 	.bind = rk3288_sgrf_bind_of_plat,
 	.plat_auto = sizeof(struct rockchip_rk3288_sgrf_plat),
@@ -172,7 +187,7 @@ U_BOOT_DRIVER(rockchip_rk3288_sgrf) = {
 U_BOOT_DRIVER(rockchip_rk3288_pmu) = {
 	.name = "rockchip_rk3288_pmu",
 	.id = UCLASS_SYSCON,
-	.of_match = rk3288_syscon_ids + 3,
+	.of_match = rk3288_pmu_ids,
 #if IS_ENABLED(CONFIG_FDT_64BIT)
 	.bind = rk3288_pmu_bind_of_plat,
 	.plat_auto = sizeof(struct rockchip_rk3288_pmu_plat),
-- 
2.53.0

