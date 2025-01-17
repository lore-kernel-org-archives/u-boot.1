Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F85C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 13:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22BEF8036F;
	Fri, 17 Jan 2025 14:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CQm5eV4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BBAA8069D; Fri, 17 Jan 2025 14:20:28 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::72e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B640680312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 14:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDlKXtOHD/JTGElgpmtyzYnb5+ATrSqi1A80NLCm03W+5Et1BBDIKxmGPCfq5/Gg2gKAS2XV2H8hrwX0Qe/2Mfqi5RpTvUiXnirwmkmyaWdI51wIp1NPNDIZ8rb/O4Y7ZSNnuk4/jznGCWBKqJta3O/qfq72AqB/L88PxV8nUuT5mg86i1SFlUDoZBMQhs4dswFI+OvASBDeALFR41uAc+/xGV6Dv0M7G+00EOfxsKIPen5bBuVbuQNo+ij+1YJU2a+bK65QTStG4mZajRDzYlO4QHSG3ulkvIAfLbpwKZGQreLB8hSNz415FZANFB94vPUjELBuQfga1hGLGNxmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qalvOvdSZ4pjlSqDN9zAUlgNKRbEIiDikuSc/22Ot4=;
 b=dPtO0ni3E9x4lNk/UCET09XVXzlKqi9SVPmJngads6s8qDtCIUsAK4wPHXxbgDoygtLom2TM3oKDuMZ99JuGgvL2Q66VFCmD8sawqHRDwuxlF2+ZQbBA8LQECGyrjunVhIv2Qa1eNZm62SDwpz2KCEw2O1LqPEs7Wq/n/pPeZ/C1l4mA6MaWe5ztr+ep78ZJXezVG/ntE3d20tk0bpFbYdk9Uxq9nIdrw48nR1s5XAwmhNaclLDSWpbWkVeMy6whuMf0GS0vSVE8uoekUnKEWexcLw+ecoQ0+n9cmbWyKDMQoVfm/y/shdKwYWeVRKlkkGVaGdwDRc7n7SR5do1/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qalvOvdSZ4pjlSqDN9zAUlgNKRbEIiDikuSc/22Ot4=;
 b=CQm5eV4le3zY+yk8FHM9V6bYfrvAxlrvUdvbeoWnOe1p4yE/CEKb7fSWHw/sAeXH9k00e3zR/203t6gZq+07apxwTKZntqtAkxGhwO71ZJlHVWfvnXgqIjT8RkT3KO2Tro4WNHyiJk8qxCtOF4fkVVq5UitBT7sGx3McgNPxXl+ZzFRpxK/GQlPuxKiniqK2uTS3jZrV+PvS+2ViO3ufNUTPg6HehAiXEv+3ccK3q6GwojBeMTUAHVO+h0gs60kydy52c7DtxceGjXWcAYwVi6DNptkzcm52FZMHyMX8yS8UvoZlsDl4sglE0T8fFmk6eZSY6GGTTfIYTSmRslYnvw==
Received: from DUZP191CA0045.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::12)
 by DB4P195MB1896.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:38f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 13:20:23 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::4c) by DUZP191CA0045.outlook.office365.com
 (2603:10a6:10:4f8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Fri,
 17 Jan 2025 13:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 13:20:23 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 17 Jan
 2025 14:20:22 +0100
Received: from llp-anderweit.phytec.de (172.25.32.242) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 17 Jan
 2025 14:20:22 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>,
 Benjamin Hahn <B.Hahn@phytec.de>, Leonard Anderweit <l.anderweit@phytec.de>,
 Yannic Moog <y.moog@phytec.de>, Wadim Egorov <w.egorov@phytec.de>, "Fabio
 Estevam" <festevam@gmail.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>
Subject: [PATCH] phycore-imx8mp: Enable CAAM in spl
Date: Fri, 17 Jan 2025 14:20:13 +0100
Message-ID: <20250117132013.123064-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.242]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|DB4P195MB1896:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbb5c18-5859-4f96-b203-08dd36f9b2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zeXyZ0o2qVlGm1zrElED6OCDKGsQb71IoG/ic7YtZ1MxoQwcTpmorcBPihcB?=
 =?us-ascii?Q?j65HM0FxzHdfQWgSRkp+AvAu67r6eI07QkVmSbJ0vIZ4VyIYLRakpL4a5UlV?=
 =?us-ascii?Q?t/XDI/DaMYCBzAQCDu6cUvKE25X2TKxZw8XY1yUFKBZzebp0nK1EXy6iya5w?=
 =?us-ascii?Q?TsxYCVjv6TqCc44XZBBMUZ8YQbP3AbHQL5f+vxwunVBf5W39jK2ODBO3vKbH?=
 =?us-ascii?Q?rmjghpmF7cuiLytzoAddELciioIdJN/QiKb//MKBK8KvhuahMe6IbffVHBb8?=
 =?us-ascii?Q?FvLe99Tz0oddgO+hWKzckblILq1ZE/q79b2RgHu38Lm0kalW4t1VWmsjJdni?=
 =?us-ascii?Q?v2tAOr2XnxLdfFWOBKRYYlW0CxXCVHv0pxNnr/YS+ZDcsJNEUd7dKJUZbxmQ?=
 =?us-ascii?Q?IgXS+w3iRkppE4hgjo+rDKcGE0TPsB56vBydIFPMaWAc3xVoYVf+IelFj8by?=
 =?us-ascii?Q?OJ0J2nw6dKrJWK5q+zf79IHsZPVZw8szfYryXvCbluC45VleEJ6PGZYdgMD0?=
 =?us-ascii?Q?L+e7qPU1g4Id+J5A3hE4RQNEKl+3kToqLYBBpSDbyR18f1XhuN41W01KecWS?=
 =?us-ascii?Q?Q5xUTdwUhnj1O0uzoYtlmVaAE6hQEvB6fEwATsHEshw3uGUigBBKQemkhkDI?=
 =?us-ascii?Q?htdUD3FQpDYmh4AigdFrXnEsftJAOYQOZXJq5TIyz2lYDaiXWC9eEWkIe/Eh?=
 =?us-ascii?Q?lFLMvrFD1H5SGwzfy8Y5OHR0fT72watFF6gIiyTNg46+bUTx8aY3WT2j27vS?=
 =?us-ascii?Q?KUx3L5XnMSQ/Inh4ZDvtk6HdXFJ4zBdvzjPKn3TRkRNsk3kWXM7uvA4w4iXu?=
 =?us-ascii?Q?rbuOlKg/3w8mHJh2/kwi5r93YFAFVckLTjkAm1uijn0UvP5eBuOqlBk3Cf1G?=
 =?us-ascii?Q?b5ASMKUt7VsV9U7cENZPNbHfLgeKkDgHwFt8O/2ZI3Pb7zmGdtazaxAj6KJr?=
 =?us-ascii?Q?Pvf2t0hGTvT9j6v6iuGvp/dAID2SU+VRnHztgC1qVsO5iO8JkWTRdSLYnOXQ?=
 =?us-ascii?Q?a7JDfigQXfoqoGz132v6PKOL495+cyHiVF4nkk4vL2u5jpmSkKlXHqSt5hBX?=
 =?us-ascii?Q?mKcYoG7AI62daCHpjHKofG+okhhVFH8AAHMEHLZK9c6r8B82+Q4yG/52Ozf1?=
 =?us-ascii?Q?I6mn5wjmftm/bvUowSz0FEykoqywkPc90ctsNNqIWxDcrCDC/fyrDLeYMS82?=
 =?us-ascii?Q?lop3FaBpIuu4MCxJJSctsEpr0NQiJ/QzxYpJIjfHgh3zn6dLztr0UD7FOpZs?=
 =?us-ascii?Q?fG0TWxiGHYK/1MriuCKHrltpsMQ8ewKyHlM5EmPWJrxPRf8vuk97ooDzSTMX?=
 =?us-ascii?Q?6hNR7BhpM/J/hmcxPIvVnReF3wlH5m5/DlLm8HG2mgQjPOANPfHwkTMX9vtI?=
 =?us-ascii?Q?5e/aHJtDayBK0KfWNaETkIhLmgcXebM7ZXaoc1nHLrR5yPcpqYJGtTwUj/xQ?=
 =?us-ascii?Q?888IPkj2DwN3cu/8Ti8mo0tT85kvOj94NjBJ5BUU1txRYys+/qxf8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 13:20:23.3056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbb5c18-5859-4f96-b203-08dd36f9b2f5
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P195MB1896
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

Enable CAAM in spl.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 board/phytec/phycore_imx8mp/spl.c | 2 ++
 configs/phycore-imx8mp_defconfig  | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index 0610d8bbd0b8..cb8e450b9956 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -165,6 +165,8 @@ int power_init_board(void)
 
 void spl_board_init(void)
 {
+	arch_misc_init();
+
 	/* Set GIC clock to 500Mhz for OD VDD_SOC. */
 	clock_enable(CCGR_GIC, 0);
 	clock_set_target_val(GIC_CLK_ROOT, CLK_ROOT_ON | CLK_ROOT_SOURCE_SEL(5));
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index ba716a6875b8..c0501907b2c4 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -52,7 +52,6 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
-# CONFIG_SPL_CRYPTO is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_POWER=y
@@ -180,4 +179,3 @@ CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_IMX_WATCHDOG=y
-# CONFIG_SPL_SHA_HW_ACCEL is not set
-- 
2.34.1

