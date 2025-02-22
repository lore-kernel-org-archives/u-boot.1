Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40A4C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 11:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 966F680F9A;
	Sat, 22 Feb 2025 12:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eoO/iDie";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7A180F88; Sat, 22 Feb 2025 12:10:20 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6DC680F3F
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 12:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpGqreNJnjsav0pRzQgsQUoSi6w8MsqAPhc6Vvrlu4OKhso/Aaxye/6LikrxbrMvYWew+weqUudUKJXY2SOJJ4RfBMWqI5VzSTzYUAV8Ein3+LPed58caK0ER5m47lrz2rR8KN7rpQYqvg5+xhLFRTLc/xX6HSXuDvghZvFDWVCFMO3hkasLnBzsO8EJjBegG/470fY/BpcX2I4Tl3WbIKDyQf3HXcCDGDZUPtMNsyLZYTKDihjxwMiMr+OqBu16hePX8kepiS9IJlou/JIAHP0vRZJ2jACwrPtlk7mNYNlkYt2XaUhVU6PyheJz4jrFBC6eApbYkQfbraI1yKFPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6MUc6XvaAaPdxgAaaEv4Omngx9YNz7b1WCgA7a+T10=;
 b=bV19GmYvfCJST95eRlx1sYSOgj5A9k9p25Dw7q8DvaMaVdw8eb7f80OTGTrNu3Nx24nbYzqLGE0UEJawvOmM3GU/XqohUjJA7s6vu95SarTyLInY9e2XWFdaqpxSQ6SD8TLFAaDXYRmUtrS1VyJSmJPZBd+Hob6A3uj+sScgBi3q79OPbHNbz4m9Z/WoA0IqIZf9JXZI+pKvJ0US3O2Fja68JVJHn767VZ3JpV3UYAfbSijIWvdXFNATxsxyshmP1KMJbdh5SDqEt9mvYPC1p/N3WYgUzHVq5CQmdfN1891v6qQVXD+ggwT5BTweK/Qm63697OOC0D5qF05kHUlT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6MUc6XvaAaPdxgAaaEv4Omngx9YNz7b1WCgA7a+T10=;
 b=eoO/iDieAJeeOLwldOn+G7k6g38VnqGwW4c6HJsuFervEOeUaD+vK3FngylW4FU6impzgkDacGmFi/3yNziQOQhRRtoABa++IV92jK4H+Rm10KfujHyqZYxyL0dTKII2QiT7HgduLJsTx9puvuosEBwrrp3RvGFnia00ZibwpRu7SaJIRmDqgei0TKgZ31EHyny+qs1lUBUTeFkGUK0go9SNs9wjdUmI/E0WvYUDYs9FQ7tIH6qWv96TTWKZBNwhsoSuZGreFj6dPLQOJP83vpGQ38pOVL3ISnnqSH/A0OLJY84XQV2CG8Ie3GXAgdW2I1WbmPG1RelSZOZyIJyHzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10906.eurprd04.prod.outlook.com (2603:10a6:800:277::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 11:10:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Sat, 22 Feb 2025
 11:10:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com,
	sbabic@denx.de
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
Date: Sat, 22 Feb 2025 20:17:11 +0800
Message-Id: <20250222121711.6697-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250222121711.6697-1-peng.fan@oss.nxp.com>
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10906:EE_
X-MS-Office365-Filtering-Correlation-Id: 93737086-a1f4-439a-6ea6-08dd53317ab4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J4TUrOgC6Z2Ojz1sDe7GlPmtqJonL7gH1+pPsg8N+IR07BvUklIrmuf4XQKv?=
 =?us-ascii?Q?mbwJpOC3ZdOfgPdphc9nQOzVX+c4LOKjfvmECFuzQpiOgPfr12iYdsqy1h6F?=
 =?us-ascii?Q?9ciLhgD2NnsvW/dV/TEFYNT+4WaYQnUQnerwhwDjMhTO4djPZ2U0Yp3WvLdP?=
 =?us-ascii?Q?/OaIahPWQm8pZm4GMybenk4WesLBOBdjmPkSr1fBtwuaspb2HvKTvnYY6gBe?=
 =?us-ascii?Q?yppG2oASBKpAyBV65jaCtEI/SI+X854M6duHIWxSq4di8xUMtIYQQLgTLYXa?=
 =?us-ascii?Q?n5GbCx8UYw+zaYsituRBS+X+C7Wp7ud+MsuVPpJfNxs3vDRgjWHod3rW1vvy?=
 =?us-ascii?Q?vihG0LBNyiU8kr+g3uvGBOHbNXEd4VT3eud031Medpnt30h6NETOXXEapg+J?=
 =?us-ascii?Q?UTXUEruVFCMuVqu24TOq0f0FybywrMkAJEqhF8dwvEaNYn9YgaU03otqB1Kq?=
 =?us-ascii?Q?y9+n5ahlMGJqFYFBGYmIb1oP2J+KPFJBFemkheZgsUubJte1/SVxPmUINJNW?=
 =?us-ascii?Q?8Bx/8XXUKvFhIc3vtYWK2P6etS6XzL79dpnFKF/csMFR5CkQsK5zLt1+grmq?=
 =?us-ascii?Q?9p45jqyitwRMA9J7UyTXFmJFZF/o6XFsdyUVHjEB9VzrnT+9t4PMlOOP+S1s?=
 =?us-ascii?Q?PjSSwjVqcRXFOtVfLpDSntKFhC5pucl0HPr+40+a5hHYrMhl2TImSsHRevYI?=
 =?us-ascii?Q?GJ77mCAa81MB0CZ/4a+gumKD1bG3mYCzXRqhu5iFj8+cWoMzghMK6z2DLyAu?=
 =?us-ascii?Q?GY92qQ0hOVwOlyVRmbFoLD5oWnqt+lFBJ7+/SY8BzLNKlFRwCbJZC7mp8r82?=
 =?us-ascii?Q?KvuiZb9NY4kq5Vpv89p7Jll1wWvX+QbAzH7TAGCYif9qjrzejuA8CHl+Mpy/?=
 =?us-ascii?Q?+fhexWsyeiIWsz9Fi8Htp54r10mO8MOLRGvsn6r2vIBNGmV2E8oZB6AK9umC?=
 =?us-ascii?Q?mr0SqQ53dj7f/mTdShGE8Ye3jU2cdssrnhxpGl+cPg+cyEux1UbJ888UNa17?=
 =?us-ascii?Q?jv8cnvoKYXuuW+oDiAGeeC1ClsbK14O88WSFfnWuziDFq8z2fMI4RPBdFwxt?=
 =?us-ascii?Q?iuA3cu1xgeaEJQx0KrqVdN4uUtZysHJUduyAOs+9Qm9+mmW88t3v1H4vgcA4?=
 =?us-ascii?Q?T+MZgNU3FoIROvwsUrhfonQL7fmX9QIcqqJBzY2Tblm8qw68GaQUwDfMs9G1?=
 =?us-ascii?Q?vKc89gyk8zKhHrRHY8cHrCtD5U9xecBRknMBHbZtdNwPgJivGkW09SykO52B?=
 =?us-ascii?Q?hSMbXKqr2d+axMZgUuNjvh2u0nGed+h5RbMdPekba75a4yLCM2ba7bNMTuhV?=
 =?us-ascii?Q?tJ90t3v/4hkXZCeOK48y8XHtTO3xr7Zrogt5WvI2MSkodcI+WaNlnv+uVr5b?=
 =?us-ascii?Q?eb69GHL63eonnizru5kySkJmR2bqgcgenjER+cUFIiKe1e51a9AGD4sv+Tyg?=
 =?us-ascii?Q?I+hoSgSdOifphL7HWs9daFKg5G8sjoYE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BHMqsSb4T1U96h/jV+8V8lZCBR/oa33/dhKJfYVh+uER/jFzLX3/nklCZ2BE?=
 =?us-ascii?Q?SBkc+9THn81WlV24Oq7H2bS7OZvjrYh9EWzzOK/KxiHQGia7YKTiu9uZbL3i?=
 =?us-ascii?Q?/8npZN1VbYk/xQH1LseFLuaZVBSYAda7JrIyDiv7Rgl7SrsyJ0tHWDSQVG03?=
 =?us-ascii?Q?JdJS1+pOhm3+i8JMpGEthLs8H9okYjXS/TB9F4OCyASSeuzRe7NLLLBxFCAc?=
 =?us-ascii?Q?A+5eJfhOYFvj/zQriAJSIhxvZhHMzExRAafvAmWb6DzU70eUALYf7CE3WsR4?=
 =?us-ascii?Q?kdlO2eUplqcxQF2MuR/v3cLV2CkM8ugbiUuff5m21Pmr8PmGvOrFJjleAGvV?=
 =?us-ascii?Q?30ANTzV+ZjgBfI8wlBPaQvlOylEJwCPQleq0PpL68m3zzDKMA15pPRYsXtmz?=
 =?us-ascii?Q?1Gl2upAsIOzC20Mjc6VeM1XBKkpElZg5eEweZE+J+QyvBLuBuw78uXvdAX+H?=
 =?us-ascii?Q?mlsHrAtLBXSz4G/eWxtxeO/0MAn16KRHMSc1iEuZ/LEW2dD2DaCgYnsYkm0s?=
 =?us-ascii?Q?mYzXg7i3uq3C6muehm8V30WrdCejWvdup1fSYrXcm6QGA81m9t9kTF6j6tRs?=
 =?us-ascii?Q?xhEWF9olkvjZ1ppJ4hkb5ihkbp0jur9DEKIRR7yMCa0Fnu9LNCvozjAKKX/t?=
 =?us-ascii?Q?EAmsx3RjQmOC0Flo0OWYLKXCE8d6ieKYTilIV7Zod1MbAwAC6dzwgMjbQJa3?=
 =?us-ascii?Q?4vQvsTv/Ddm7cZ6wH7/aFEn8wiGUPyaicbg8ejkZt06w/j3kdwttowkLvMnQ?=
 =?us-ascii?Q?HUXPWbx+Hgp0njVpRhXU2SWVj2H9cEpptLoUQA6LsgCSEOBc5yD5whep8ugL?=
 =?us-ascii?Q?ImSOjIOvy3KwDKBQNltwtmtGmpalo+k0UAux7vgMDQtTjXDLZydhkkZyKzeZ?=
 =?us-ascii?Q?wa/IrShHPY64Ob4Bf8xoybSrWaVU1vO4x9/TMRHTqdpQ0uoQg0jmVyCM9aaj?=
 =?us-ascii?Q?rZI9HrHaM1gGLjjekYxYyhMZJI8wjbe+kB88GnxaZ2JxfavJtGtjymrnzc5X?=
 =?us-ascii?Q?AidFkRi6skmdzKpoJqEhGduhyIKXnPWDwAS2ju6LpUJyXXzXzvL5/FKBWGQG?=
 =?us-ascii?Q?8GrMgV4NbXjSz9ZNOE0NzCqmkd3BGGCrTyZ4QRKqsoLqsvoLa4Jviap1MoDX?=
 =?us-ascii?Q?KhNG3rYMhKHSsAmFvHfXe7+0YdqrfFo8FSdWCns1OqjB0bpEvi60zCWzOBFC?=
 =?us-ascii?Q?Fc7mrM/xknDY6YQ7D68sUJ5UUHrldHxiEojlaaU0qU4T04hbZCkYZ02xUTWk?=
 =?us-ascii?Q?gIFK8oT3kkLp0r7Q7rPX01p/vNYYRgBL20f86544Vj2xiWHWnsnaYD1zWZg8?=
 =?us-ascii?Q?MXN2wozkbQRFNhE0fvPj9kfPNVbe0qD0bAh8mZG0H7YTdwvN+k9+YmU6Zok9?=
 =?us-ascii?Q?Tr8pW/vqSl3oQDCinMxZz3qnCtxuVrLE3Yexf/uujPyRvICPAMU8dzhlO0JG?=
 =?us-ascii?Q?SfHsS8wIbc3AdYyiaftyLG/twNzdjzsvBF57YAY4flvzWR63gRqgZQGNRn9y?=
 =?us-ascii?Q?Qlz4pRw5XBzaSkgXfFbGklzRYzlSvhKkam6fn7yEgAx7yroa1sZRdXnxBCGb?=
 =?us-ascii?Q?bdICCR0jIqHS4y26iPtI8PKJSZqQu8G8u0DMZhYE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93737086-a1f4-439a-6ea6-08dd53317ab4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 11:10:13.6739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbU8YsCa9SvE/S0ZJw1kMIqWkK28zpuUwHXYXwYa0rGnKGur3XIIMBuV+eS1P/4m+9Xvdikpuu7SA4Up8o0BDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10906
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

From: Peng Fan <peng.fan@nxp.com>

Select BOOTSTD_FULL and BOOTSTD_BOOTCOMMAND
Correct DEFAULT_FDT_FILE
Correct env file for imx8mm_evk_fspi_defconfig

Fixes: 364ba68ed1a ("imx: imx8mm_evk: Switch to BOOTSTD")
Reported-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig   | 2 ++
 configs/imx8mm_evk_defconfig      | 3 ++-
 configs/imx8mm_evk_fspi_defconfig | 4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 0fe9c46e499..89f2b50c8a2 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -92,6 +92,8 @@ config TARGET_IMX8MM_EVK
 	select FSL_CAAM
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 	imply OF_UPSTREAM
 
 config TARGET_IMX8MM_ICORE_MX8MM
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index 659fc9ec039..2048391439f 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -25,7 +25,8 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx8mm-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 4a8d4994b80..59ebdc5782f 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_ENV_SOURCE_FILE="imx8mn_evk"
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_SF_DEFAULT_MODE=0
 CONFIG_ENV_SIZE=0x1000
@@ -29,7 +28,8 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx8mm-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_LATE_INIT=y
-- 
2.35.3

