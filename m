Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF9AE9A742
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 09:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 647E2839A8;
	Tue, 24 Mar 2026 10:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ucj730SD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D0083981; Tue, 24 Mar 2026 10:15:03 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D15838FA
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ST+nkD+a5WMi3G22+ZNqhD10sbbdG6DEYyLYaXkag26jCfnp1N0Clsj5gvDu/gVYbdN+w4L1LFNTYei9Gj7/0ggLO+flhW9rQD64jMOKVrkFeBPijb71CbQh4eIy8KLXuPOsTruEElCvSkZgW2ndf3A6PrE35ETyr/v+876+lnN9htsRdOjDHVxquUuXuisd8dtDHzG/n/4uGmfO6ZPJnp+5jFw3IQ8SIccDFBDX8FD70iwsME00XbUlvKc8xHLylQVNVYN0QILmkfCX3SUp5XneUulzXPUstZR2ROMMYYrDMbjGfCW6KYJixQXJq8WFPpV8cwYSDkQTMk3oZa/Q3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JAhFgKA83woJvS4NvLDu7RiBODuV3yApoH1cn2zG38=;
 b=RFMpPAgxuEJ2yyNS1gGTxwTJMA//m6avWTh5VlGaZgGcpiYeaJVN52Mi0VOXTO3ddQB4Z58fsFQKJxUMnqS9Z3CgPRp031H1jjty25yMwTXYyRogM+SLh9VnBgWzxAOsJaAabFt+dD2th9H53Lhg027T7DNYh7bIyBk01jG9DrCqy0L7WBO6Wu4TUkES0flO5GayxZlsFRQWlzk/hcu+cQdIrW6FUhcA8TZ5joSSponl1Ew0Dv9SCeCpE/YN9h7hD2qT9oxOHiVX/6cZRBZTeLG0MwVd9QNceIE5cOW8Wy6SWVvcztuGP1rkO0k5Gq7oQ0bdPJD4nqqnJluoYxk0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JAhFgKA83woJvS4NvLDu7RiBODuV3yApoH1cn2zG38=;
 b=Ucj730SDIxdcjQcjEq7NrtJmGVAG9X/FaYYJH87IKs9cEqHkHKDks4+Vh8jfula7S70LTlHVfTQyxAIm3iqWPj2IvEPb7IR38dEk599SwZrTq0iGcgRuvVA10kcqKdwRVQ8BuoapjI8STBtfRElRxmtTO/80lI596aseR81Zu3vXeIHtGmFUhL0tmHdh8lVSaVH+baXiSlr+9TLlqClBl0LeEuSscxMqcjVlUkFxdLOdbrr5IQdWbPn0sEETlUSuujhmWDdXScm/yizYOD3mVYPqoUSDTdfXaKqhLutdv6PqDq880frFk9vpdP0Fg7GAsTUT7eqVPxLaUlgYenXrrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 09:14:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 09:14:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 24 Mar 2026 18:30:32 +0800
Subject: [PATCH 2/4] imx8mp: verdin: Convert to DM_PMIC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-power-legacy-v1-2-ed432367817c@nxp.com>
References: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
In-Reply-To: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Teresa Remmet <t.remmet@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>, Yannic Moog <y.moog@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: bffdc859-b698-44c8-4d44-08de8985c52e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: F0QhVS8Te77Gb9sWf944PNBLn5D31o+v98fs/bFGnOaeEgxYGn+/9ZiZ5q11ZxSDVJ/Uw3CcQGV9fPaotvaVxJ4CqdoZdkhsKLOYAz/WCAu/O40cu4X50vh6tFKB19YscsX15Cimaq+eV1p54tV+6Wlh5y5uOQ7tK8DAVH0r8T2qccKPYnjmecG59mdiJRhJfj7TxpKP1wlEzStp+40t+M7FpYGdlapcqJCo2apOXXf6vChuz6JAwFeyOnFnWcroPUwfTpplQyY8zT1zuQBeoP1BTK+JQpno0gyw11DgSNBrjksuSrPjD1xtTjfnAWnocR++n061GKjPF2ZfRwryOMPI93qoFco0CA9EhaR0vyLgjfnnJEfdkR0O+yhVl2SvbrIK23EDQ74SucNnDNCAhkYXB9yA6sJlZFSGApdlUbMi8wqdFLCedPlVF0pdllMrcuVFoWrKt6h/Bx8m/RSP/HwhAyq6PWgEnFbmPXRG0R/Iqi/BosBbiJoY7nVShyIyqwpmHC4JT4RJHDePLDtRrO3qaH/dZL62VRYvGRyZ6SNCA/GyHYgdow94faaD3BplNpOUBsyWpEsJygujLAG9ojtR47hoD3AJaRfutEkcYKNlDh5VFpiZSx+U+f4ZdZnNFKiq5kYM3mXuwhS4l5lvGlUU1+OqYI9P/mHdRXIH/o15KYgzDGnLKBwgdPpIxpgx5s+AwvPUSQR6RiBjUgK9Oa6x7CycTbiRlTh7h/4WHZRmL1NoJVUZt1MiXyWF4K1LRLGqrsACeXiUiAl4s6BiS2PanngP2O+x+ZB13MxGn1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anl0YlJicVZtWlVsd3dmVk0remhvMDBFWVRQMDBUL1I2Tlo4RUZjeTlkREpn?=
 =?utf-8?B?Z2o2L0EwdmxjM0t4TWJORWszT3prM3RTMGFCM2l6Zks2ek13L2JVRjl5cWJY?=
 =?utf-8?B?YSs1QUtoY2tnNUc4cjZ0bDJZQTNTNjlmK3c2ekJWZXRvaWtneExRZFY1NE9Q?=
 =?utf-8?B?WERLWVo0aVJaRTI5eTZPb1JXeVA2REJnR3JuYlowUW5MNGxJdEhKWHpJc0lI?=
 =?utf-8?B?cXRBdzRnbmwwa2x0UFAwa3YwSStBZi9ETXIvYkg4am9weFhVU3FaSmRFUHVa?=
 =?utf-8?B?WWRtakJDSFQrUjVLMlRHM3loTm5JblJpNzRiUm9FTkRYWDdoRldQZmJtWXYy?=
 =?utf-8?B?K1NTRTFRZThPZFdMdkNudmdHM0NhSWJ1RUNnWXdqNGxidFE0RkZLSktvWFYx?=
 =?utf-8?B?ajExT2d1bENuR0FLTHlhS1k3R2tXRHpJeXZBWExycEUvT3gxbnUwOThuSVdE?=
 =?utf-8?B?SVdNbE1NemhLVU9rZHBqSmMrTWlSR2FqeEY3QmdCZmJydnI5NGR2Lzh0ZkF6?=
 =?utf-8?B?VFY2dlliUlNCM0h5Yk5sVkRmeUVrYVVWbE95SWpxWnZMd1NLL1RDQXJZMDQz?=
 =?utf-8?B?L21pTVRMdmVjNU9ZR3E3TmVqZ2tFMlpmN2ZPUlJOaXNBdzdxdWt4K1VXSHZi?=
 =?utf-8?B?Z3ZYcGdDYi9KeFJyb0F5eStWejJYT3QrUE1vYXp1ditXZFR4eGJ1eTRzaUJV?=
 =?utf-8?B?aXdyeXNab3J0d2w3dWpUOWdpMmxyLzhQQ1BvL3NLdTJMc3JVR0FkVFNUcy8w?=
 =?utf-8?B?ZmVrZEVtMUJCNVdRaURpcEdtYnRvZVh3YzFpcjhCZTNpWkZZNFlxVTlZci9D?=
 =?utf-8?B?NnI1aHVVSm40Nk05U2RkMFIrV0VTSmxxOVUxRTl6WWdNWG9zOUY0Q3lJVEFV?=
 =?utf-8?B?WGp5bk5YSkwzb2N5c3J6TXhpU1J4ODBNVkZrN0NsdHByZklqak1CbGFsQ3Jl?=
 =?utf-8?B?cVhOSzIvR1NnMWxqYWRYdUtvR3JONC8yZUFmTitOOW5uVmpsckJtdEFMT3VK?=
 =?utf-8?B?anZYK28rK0E4bDJrS2pMT2Z0MHVXdlNYS005eUt2YmRQTnZZZzdyV2JiUHh3?=
 =?utf-8?B?V1FMRzdyQnYzU2Y1d3lkZUp3SnkzbHZWSXJIREp1WUVMbjZkZ2U0ZFhGUWVL?=
 =?utf-8?B?K0phRHlvV0tjRnArNnBENjJzVmFtVlV1alQrWDd3ems0MjMvUjBiSlZYYmJQ?=
 =?utf-8?B?ZHdmeExSUHJSTGNGTThLVk1aZzhyd043Ui9yYnFqUHZVdjhkTXR3QzlaV1Bw?=
 =?utf-8?B?R2hTL3FKbUxvM0Fub3Z0cDdZWHo5NUVWMytwV2c1Qnl4cGwwYjNidWtxMXJw?=
 =?utf-8?B?bSs0SkZUZHZkdVBqaHB4VUpaZkpFcWloZE5xclE3SUtUNHFORExJTGloUUdx?=
 =?utf-8?B?dmJybXN3VlBWNDFZT3lDNDZ4Rmk2SmE1VmlDM0l3am9sQmRFd3RZbzlHS0VE?=
 =?utf-8?B?VmxUcTQ0Q2ZWblVmcjcrOTBublVMV0RlaE1EaEUxMnhZR1BTV1U0bUQ3VEJL?=
 =?utf-8?B?ZUNnL0dlTDdibDJrVXdTZy9PYWZrejZTS3VqQ0ZvWjB1aXhPcmt4QndEK0Vx?=
 =?utf-8?B?eE1nY3lJWERMemd0eGJHS2hOdWlUNGppUjJSa3pQUUEvTUNBUWxjdVBEanZ4?=
 =?utf-8?B?azB0NTBFbVd2U3BNd1ZLdGJFcjFuNHV0VTIrNXpId3AvbkNKZ3hvYWNubnpr?=
 =?utf-8?B?MEJhT0FNU0dVckRqZW8weDRQL0Z1aXpPRGZsb3FNOWNGek5IellFVkRjVVpU?=
 =?utf-8?B?MFFITS9JeW9FMWhxSkV3U3g1cjNqTkcxSVY0RmVoVzNqWTVTdjJNWk5yTG9m?=
 =?utf-8?B?dXVwdVQ5Vk8yaW00Q1hhUEUzMkk3emg1SWo4a3pBMU1OYkNkNTFWaVRXbURR?=
 =?utf-8?B?bkxiWVNiRUdDL1VueXlVcVJFSCt1c2dISzVVV253QmZCOGh6WHV2QlFoSDUv?=
 =?utf-8?B?UFlNOFYvV05SOXFZOVlEdlE4NzBScFBucFR4aUNJazh1RW5DOEZNeFBlRGpZ?=
 =?utf-8?B?TXplYjFXSGxwQ1E0cTNpNEFFdEkxcXNLa1hOODZ3S1Qyc1BzTFUwY2FQS3VW?=
 =?utf-8?B?N0hlakN5NFdwaWNKRm9ja1FXRU5jZmxZejlPdUhLNy93NUpjM2N0RkxnZ3pj?=
 =?utf-8?B?NmFHeWxiVmJiZUZBeWhic1UvcVplRUtiTHFXMEJRc0JkVnRoaFVydGIveXZN?=
 =?utf-8?B?dmpQNnlTYUNUTDJFaHFRYkpwMjh3RndFeVRlODBMNERnQWJUMWFiUEE4ZW9l?=
 =?utf-8?B?bHA0RnQ3OW1iZ3BQUHBTdU0xTmJSSENiNTJIdXo2SzVaTDFXMkpyUlJXTHVs?=
 =?utf-8?B?U050THNHVkVWZUxsTnUvbWplbVZldGdBWUl4UWtaU29hdHdnM2pFdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffdc859-b698-44c8-4d44-08de8985c52e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:14:36.7870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JM3tAmO2hpCd4aXG+8dfpmUBinDFlftMd6GJiYrCyOvlzVVtK4xMEjaPT4iuUgHnvjH1itsGvZyP2D2e9RwcyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885
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

Convert the board to use DM_PMIC instead of the legacy SPL I2C/PMIC
handling.

Changes include:
- Enable DM_PMIC, DM_PMIC_PCA9450, and SPL_DM_PMIC_PCA9450 in defconfig.
- Drop legacy SPL I2C and PMIC options.
- Remove manual I2C1 pad setup and legacy power_pca9450_init() usage.
- Use DM-based pmic_get() with the DT node "pmic@25".
- Update PMIC register programming to use struct udevice API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi | 14 +++++--
 board/toradex/verdin-imx8mp/spl.c               | 55 +++++++------------------
 configs/verdin-imx8mp_defconfig                 | 13 ++----
 3 files changed, 31 insertions(+), 51 deletions(-)

diff --git a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
index 7b45a87450b..9d2e12682ca 100644
--- a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
@@ -70,7 +70,7 @@
 };
 
 &i2c1 {
-	bootph-pre-ram;
+	bootph-all;
 
 	eeprom_module: eeprom@50 {
 		compatible = "i2c-eeprom";
@@ -104,7 +104,7 @@
 };
 
 &pca9450 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pinctrl_ctrl_sleep_moci {
@@ -112,7 +112,11 @@
 };
 
 &pinctrl_i2c1 {
-	bootph-pre-ram;
+	bootph-all;
+};
+
+&pinctrl_pmic {
+	bootph-all;
 };
 
 &pinctrl_usdhc2_pwr_en {
@@ -173,3 +177,7 @@
 &wdog1 {
 	bootph-pre-ram;
 };
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@25/regulators} {
+	bootph-all;
+};
diff --git a/board/toradex/verdin-imx8mp/spl.c b/board/toradex/verdin-imx8mp/spl.c
index b39058b1b5d..44678a976ca 100644
--- a/board/toradex/verdin-imx8mp/spl.c
+++ b/board/toradex/verdin-imx8mp/spl.c
@@ -8,12 +8,8 @@
 #include <log.h>
 #include <spl.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/mach-imx/mxc_i2c.h>
 #include <asm/arch/ddr.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
@@ -68,36 +64,21 @@ void spl_board_init(void)
 	puts("Normal Boot\n");
 }
 
-#define I2C_PAD_CTRL (PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PE)
-#define PC MUX_PAD_CTRL(I2C_PAD_CTRL)
-struct i2c_pads_info i2c_pad_info1 = {
-	.scl = {
-		.i2c_mode = MX8MP_PAD_I2C1_SCL__I2C1_SCL | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SCL__GPIO5_IO14 | PC,
-		.gp = IMX_GPIO_NR(5, 14),
-	},
-	.sda = {
-		.i2c_mode = MX8MP_PAD_I2C1_SDA__I2C1_SDA | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SDA__GPIO5_IO15 | PC,
-		.gp = IMX_GPIO_NR(5, 15),
-	},
-};
-
-#if CONFIG_IS_ENABLED(POWER_LEGACY)
-#define I2C_PMIC	0
 int power_init_board(void)
 {
-	struct pmic *p;
+	struct udevice *dev;
 	int ret;
 
-	ret = power_pca9450_init(I2C_PMIC, 0x25);
-	if (ret)
-		printf("power init failed\n");
-	p = pmic_get("PCA9450");
-	pmic_probe(p);
+	ret = pmic_get("pmic@25", &dev);
+	if (ret == -ENODEV) {
+		puts("No pmic@25\n");
+		return 0;
+	}
+	if (ret < 0)
+		return ret;
 
 	/* BUCKxOUT_DVS0/1 control BUCK123 output */
-	pmic_reg_write(p, PCA9450_BUCK123_DVS, 0x29);
+	pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
 
 	/*
 	 * increase VDD_SOC to typical value 0.95V before first
@@ -107,23 +88,22 @@ int power_init_board(void)
 	 */
 	if (IS_ENABLED(CONFIG_IMX8M_VDD_SOC_850MV))
 		/* set DVS0 to 0.85v for special case */
-		pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x14);
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x14);
 	else
-		pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x1c);
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS1, 0x14);
-	pmic_reg_write(p, PCA9450_BUCK1CTRL, 0x59);
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x1c);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x14);
+	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
 	/* Kernel uses OD/OD freq for SoC */
 	/* To avoid timing risk from SoC to ARM, increase VDD_ARM to OD voltage 0.95v */
-	pmic_reg_write(p, PCA9450_BUCK2OUT_DVS0, 0x1c);
+	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1c);
 
 	/* set LDO4 and CONFIG2 to enable the I2C level translator */
-	pmic_reg_write(p, PCA9450_LDO4CTRL, 0x59);
-	pmic_reg_write(p, PCA9450_CONFIG2, 0x1);
+	pmic_reg_write(dev, PCA9450_LDO4CTRL, 0x59);
+	pmic_reg_write(dev, PCA9450_CONFIG2, 0x1);
 
 	return 0;
 }
-#endif
 
 #if IS_ENABLED(CONFIG_SPL_LOAD_FIT)
 int board_fit_config_name_match(const char *name)
@@ -156,9 +136,6 @@ void board_init_f(ulong dummy)
 
 	enable_tzc380();
 
-	/* Adjust PMIC voltage to 1.0V for 800 MHz */
-	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
-
 	/* PMIC initialization */
 	power_init_board();
 
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 99749c50194..455a601b07d 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -7,10 +7,6 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
-CONFIG_SYS_I2C_MXC_I2C4=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-verdin-wifi-dev"
 CONFIG_TARGET_VERDIN_IMX8MP=y
@@ -119,8 +115,6 @@ CONFIG_SPL_GPIO_HOG=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
-# CONFIG_SPL_DM_I2C is not set
-CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_I2C_EEPROM=y
@@ -152,14 +146,15 @@ CONFIG_PHY_IMX8M_PCIE=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_SPL_POWER_LEGACY=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
-CONFIG_POWER_PCA9450=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
+CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y

-- 
2.51.0

