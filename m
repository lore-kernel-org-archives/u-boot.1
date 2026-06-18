Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499F0CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 01:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A7884908;
	Thu, 18 Jun 2026 03:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v48Sd5jj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A3E08495C; Thu, 18 Jun 2026 03:14:50 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A964847C3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 03:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVohQyx5YfjBIFmo8FjJ9YmEt2qRBGuO2Z7pAXTSaPFFAvLfjqL50+uUyPZknfC85iFMGHwo8E9ZhpACgBucRnywrNGm6IvuDj4G4IfweSqcM4ttHywVCRJ+lm0OwlsIYL9d18aTXKE6CblyRev+buSCbLa1q61OTenqXMFvDydCPCEan4gDEWg6XbYzTz1TizixCKP8d0bVtCWyaUGTyCgA/FsvxdvE42i0kJiC4m4XkFIvtliI/VP1YEOUZraYNaSYAgTRnmoE213iZfwNRCPAyFtUC6V59HxXxWmB6wUlWUTTA9RdlnvIHKnsMdz+spTgN7kJw8Ihg0FNAE8J6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNGQyVpvvk7C2rquJK3j8M+kDWqHu+RbS8iLEepg/eM=;
 b=ceWDRHe7glwEqwTD33iAfuVNviqT7y9/RcyZpVoJBcfoyB2qlG5PV+XYBSIOpn8DeT3xtn5mhDORu6W4r/BW/iCA2M0kWAp5OylGfLbULOjhLZe0kdS9Ejg1Cj4ttwSGKkEYWDMpgcUhczcK3z+t5ZiziA99/zeN2/alWTj+6Arvjg4F9MXxABH87QwxkVYImlG26S3pRAgTlhkYwRQ5Vs4rrXzNY5/sMihGG5OmdgOHxgCoYyyvYacOwz2uR/iTmWP71hoUD0COobGAv4NkogM9lDTLoGQ7qHCxi1e33a7WpjrAK3cYUcLYIkhTdh3dsp4Z+haZBHxI2neN39OqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNGQyVpvvk7C2rquJK3j8M+kDWqHu+RbS8iLEepg/eM=;
 b=v48Sd5jjVknK0/rEF/G7bcWE6ROe6Jtzomc+UmOawk2Q2Grtzfpi3R433Z6c7OOU1SSrxz5e3Rw79dJFl8fbzGjUUrAN69gVvHlX+x7s5j9an5/o2RDRuHb/aZaAZE5wKpR25f6P+Ravw4WdUtAbc8pMFjK/zuhZaZ3VCSC+3tssSJqAEgGIo0QGhWHByRpGFiLIHZnCbSpwQSmwJBlO1KVXcSOsYOZkbW7nrY5u+eN5fXkhS+RirbHsewHO0sCq7rmiNVU4hVx9Y++DK3nSOs+cFGhz9UT0LxfFoPwy6mj+0JOOAX1VUyy3D5gV4pY0989Xf5ZHJQ6/0lkFmcH7Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 01:14:45 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 01:14:45 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.denx.de
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com,
	alice.guo@nxp.com,
	ye.li@nxp.com
Subject: [PATCH 1/3] imx9: scmi: Fix SPL trampoline buffer for 1GB DDR
Date: Thu, 18 Jun 2026 09:17:47 +0800
Message-Id: <20260618011749.2871269-1-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 75bf2fa3-e109-4ef8-e5aa-08deccd6fb6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: gEz4p4Gwfk05hGIvcGKpB06hCSeP0P0lQB3J9TUQmjeZkFLTiJUhpfs+lyFJp21EyhFhL+Bm7gAcrpAXed/XjQ0JWzvNfLVdMQnluLrgBuwgxi6qf+zdfMks7AIDcG3sYNwjHVxi2KPRhBNoCFOYwwnrf8gNFfEO2isWUFmPa29DktBhN2XWK6VdRQ95zf5KYJDhtIRT9YUhb0lLJVJthlop0s18+wLsSC3Hjkl0CLXg/+Ib3KAE3jieb/NwqPEn3fLLU0QzFZzxy0xa8VYFt8ac9wtzYgqG6tYBc9IiXNQemSo/wrx/W5PdEw40Vfsrbw0uWQCTzR61Wz3+FEbn41mCbhOdwLLLv2uEGYha4dw2C+p0vQsRgaFo5rwQMdFW4HAD01OIDwq8Ev09B6IHGN32G3Miba2o2q25XIEuo2deasaK0H1OY0SAG9MoDTumj8bmJxIpNUXj7bpO1vmg8FrxC6eJZjwge4K8NVnhIhro6gAbEUDuoguBtKZSpSccZ0LjhKNuoSziOOn+dP2Pgo7VyLHwD+OCn+pvFy/Xo9LdP1eYyZA7esEO/pGtZjMUPkUS3rR+z8ZdjBiSi4KWBGRWAc+gCEi8/OCkUdrXViAZ7kuXst+BYlSnqSYXP9uCA68l+RMql8zOlsd7yHlMlrRJyoS/J4f2zheeVIidi9RlygzdMC9wDT+4a+heYwOt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cBTN/URqbittVSYvPHXSjxry7ycY76U6sQunl76O9Kqm4+TOKXj1m/WcSvyy?=
 =?us-ascii?Q?TXbDx/3cpSYumpv3IxUWi9D8V8EdRgYVopQFsM8JBKLYex5tN0aK4Of8JQJO?=
 =?us-ascii?Q?KFnxizPdHNL+leCQBrV9DUeoLpb/GEol+NfmOHD/xZbkXnvWo/USkdufsU2i?=
 =?us-ascii?Q?LmO24Q92GOOl3nqj2DQMIvl830IkQ/QKGFs18+cTaA4E27tqaQQ0PFxp7val?=
 =?us-ascii?Q?QFLGYc//zTxRiJE5VkqLx5aPT8J1Y63GAhyixHaEratHVm2/8vipzbnkBXTH?=
 =?us-ascii?Q?sZTCf6w9R/5aQjVGXp9i7AfQoKDIdu8QLlnORbxxji3yEgbwSPZSpJ+0PZcW?=
 =?us-ascii?Q?I4IxLOkgRfoXEJLN+VWxdrtIS05GCyEifI4Qj1KbIxHkiKNpTKR+MUQNE7t+?=
 =?us-ascii?Q?FvpMty2yamKMHwolmQdr8lKZmbBQRKoltxgEd87sURLGwEY5zJ5Xyt7GdyQU?=
 =?us-ascii?Q?RXZT4mWO2PByZL8Ous1QrMfkwYAFwssinvx6Oy9CiBGHmleXiB3Snjf211tF?=
 =?us-ascii?Q?LAUuhu124DxQhNc8SAqFRgp9n9AafcZVHByz3i3cypnp/MCwfaZS2ixAGH1A?=
 =?us-ascii?Q?xzrKkTOXIW1iOhzsGiVwn7vB2uMBXYVB4x/3K8sOjKTg1ELqCLwLPfeMl34X?=
 =?us-ascii?Q?a5CzBYVZfzQLkUAuhTrDKONEiLmUAQxU6Uwd5liIzknfZwokYrA3nBeixGPB?=
 =?us-ascii?Q?zmF+KJYh9K25QUdgT7zPYz6ODe1eAoy3b4yJieJsyQ1hx4tWOlLady0dHP1Z?=
 =?us-ascii?Q?k03XCcz/epVRcoxjXDF0jVwE00xilukiypRlHIXcbqM0V2m10XV5wbqpyoH8?=
 =?us-ascii?Q?+pj37uuP0AAPKUXHe2WBKJ71tDNDbSbuPmPMK8fXP3WqBPsyPVh9DPN1y8BY?=
 =?us-ascii?Q?tuiUx5X2LT3p0AKMC9DZgLtL53BhOc6ldjLqbnfipX+3Jsbn8V8QaihJPjEB?=
 =?us-ascii?Q?P4+uClpr+NHuKj7oFlpjsV7eQxaU7YGEI7ZDQmOaGsAcqpuSmADut3fEKCov?=
 =?us-ascii?Q?UFEMVwuM8CySwMqUlGr7j5alhvI0GOb1OrB0PKXyOMnP94IJluTa70gaVTvm?=
 =?us-ascii?Q?W8msaUrKk3zI3IYtmIaKxOVtvboIVDcIz1Ee9PNjZYsNZ1aQ/2jhVFKPf7I0?=
 =?us-ascii?Q?ibsXgx0xHQzK74hCiUKVYinl1EsetpRa6t1IpIzw6ZDv0DcXiKB8uPpHlXSB?=
 =?us-ascii?Q?6/a8jpL1yH1sybJ9J1gNORhvcyb30NwoMvS+6OsAOT0c36u56kZx9fNvaw+H?=
 =?us-ascii?Q?lyd1tJqEkFXr76UnsDKR5y7NFwZJYP5ybHE2BXJvPwN9dlYC95g1FbXEOaK3?=
 =?us-ascii?Q?IV+gv9QK/MIrKK44h9Yr3zWayVtUjQr6fK+ld/YZOxakAlx5aViruilZ99TO?=
 =?us-ascii?Q?rnh5Tk1DjdB4HmEcaVhWi0BXOl/qtmFYh3MaUsep0A6p0p7EPDjrYjI2L2F2?=
 =?us-ascii?Q?9TsfBc+dFUZhbzAoHOyb9VZVJFx6TRVx11bpnuDlQjwdKQOPtSynB1E+rErt?=
 =?us-ascii?Q?FCo/P8U58eOn21KnQUr+F1u/LtFBujac0za0aPIrokvUepFB/61dgtYSYu5t?=
 =?us-ascii?Q?6y7H1Dn8BAosRHnhnH9lslstinIMAOGPj/8ovTzmTi1kYJxScurikWn4IlIx?=
 =?us-ascii?Q?/F7DQ/t5KruMdDOO3kQKbDUrVoRX6m4nkDUULYRNof29kXq+ToUaSeiyG7h+?=
 =?us-ascii?Q?XDWg8R6cjzCQIzxRoqbyiAcAnj0wRAwi0tLM2wKlUnGEA2QDH04QcrCu4mqm?=
 =?us-ascii?Q?YXqXLDy6ZUuhkie160AJXhrl4d7I9N4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bf2fa3-e109-4ef8-e5aa-08deccd6fb6c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 01:14:45.0499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJ5n4sXEWpnlYi1xQhF6sHzMer9xn0fcXVRNJISFD/JH8Ms2sKgGop7gI1Ux9OCcxe6E0/Dju69UNNttZXZ1TGeKY251I927jNvgWRC2FeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174
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

From: Ye Li <ye.li@nxp.com>

After supporting get DRAM size from SM, the trampoline buffer address
still depends on PHYS_SDRAM_SIZE. If the real DDR size is less than
PHYS_SDRAM_SIZE, the trampoline buffer address is invalid and SPL will
crash. So use board_phys_sdram_size to get real DDR size to calculate
correct address.

Fixes: e1cc7117b630 ("imx9: scmi: Get DDR size through SM SCMI API")
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 00b8693fbe0..ce86cdf8574 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -1177,10 +1177,11 @@ enum boot_device get_boot_device(void)
 
 bool arch_check_dst_in_secure(void *start, ulong size)
 {
-	ulong ns_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
-#ifdef PHYS_SDRAM_2_SIZE
-	ns_end += PHYS_SDRAM_2_SIZE;
-#endif
+	ulong ns_end;
+	phys_size_t dram_size;
+
+	board_phys_sdram_size(&dram_size);
+	ns_end = CFG_SYS_SDRAM_BASE + dram_size;
 
 	if ((ulong)start < CFG_SYS_SDRAM_BASE || (ulong)start + size > ns_end)
 		return true;
@@ -1190,5 +1191,10 @@ bool arch_check_dst_in_secure(void *start, ulong size)
 
 void *arch_get_container_trampoline(void)
 {
-	return (void *)((ulong)CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE - SZ_16M);
+	phys_size_t size;
+
+	board_phys_sdram_size(&size);
+	size = (size > PHYS_SDRAM_SIZE) ? PHYS_SDRAM_SIZE : size;
+
+	return (void *)((ulong)CFG_SYS_SDRAM_BASE + size - SZ_16M);
 }
-- 
2.34.1

