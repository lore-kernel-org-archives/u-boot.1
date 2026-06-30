Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA85FC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76EFC84AFD;
	Tue, 30 Jun 2026 14:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="qHvdGzaq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C677684A48; Tue, 30 Jun 2026 08:57:16 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DEA284979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdljlOX6MAToBBfgbVGieal5RyewGB6B5/IgTtDiD0SKCd+FXQO8s6yjXfGeM89PIUiPJX13phRvL0Zns92n2rqCkKCxVhPVmH8hiv2DlYzhP6GhjZJwLnt96GD71bj8pVxFBXTSvRl5xqf0Zew06sMhNLE8yXvbouGC/vieFi5NzcL5PqY54zVBohpxLLOXf7hAJ0V5ebof3y45Bs4xKF410Zm6wyjVE1bserPABxU+SAZpTMzibQ+tBvnCmvmWVd0mCyiifbdlGW20b+NoPhy9KjiIWQit+uSbYrApMpGG+JHghIduHxIZxgcoS6AydQbbM3vA3V2AcLlgNe32YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvVqy0aFc2pseHB1MF0Z+GyzGkwBy2svlA7jFtF460A=;
 b=f5DtWjNbuGM+azB7h/vcAsGOOZkKSMAnBRC/bXPtAmySq+O0/KkNfGC+XF1BnRGoc0UmFKgHVSE7sEXjYAhnn6q+CQve0gh7g02aVgAsjdOLlfqcHchFiKwGJHRqTvT0BGwfwhgdKL90i6B7/CpZ5Jk0U0lygArS/tJuT8X73+NOCm9p2PzZPQ4Wkwre+xBL4CdHh5l6NQzBVCdVmfGTu8nHbx82WP+dmndpLnSdOjn0DwNN3sEIUj9qtwinS2eQufdOaXTRrvebf+NMRjLD2O8tGmIAGrWzTurMx1ijxUDvyUdEbFtK3GZ5x+LlUVc43SVc9afKSAD7v+oMi7HBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvVqy0aFc2pseHB1MF0Z+GyzGkwBy2svlA7jFtF460A=;
 b=qHvdGzaqHt83NVcSCSy1C79J53dF0VSAjplKH4GGwMfwSTFNVlaCPdVEH+f811JfPIMdR+OE6yFHeXDfp4JoFJh8h4xTd9JJcaqj7kuhq1GNPqfHJjmc8TFoVlHzfwI88Pv4URcMh9FV2VvQbs6zjVWjI3pF6E90PhTgYzhQHYrtOgKj+TsKUsoQToph5+ERdAx7+xFOvGBXkXLLDfH4s/12zbP3rB5+SOKMj/tXzzNpK9ulUNKGzZRLMOz4n9MGlZbsQgFu8uYHpYLs4bdod55Iw9c5OxaoX2PB04tQ8NFRARF5E4FT5ZzRrzATGGBxsZEZSV0P8p2iEnd1+qRzLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by MN2PR03MB5085.namprd03.prod.outlook.com (2603:10b6:208:1ab::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:57:11 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:57:11 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Chee Hong Ang <chee.hong.ang@intel.com>,
 Chee Tien Fong <tien.fong.chee@intel.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Jit Loon Lim <jit.loon.lim@intel.com>,
 Ley Foon Tan <ley.foon.tan@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Fabio Estevam <festevam@gmail.com>, E Shattow <e@freeshell.de>,
 briansune <briansune@gmail.com>
Subject: [PATCH 8/8] arm: dts: socfpga: rsu: Label boot partition for
 label-based lookup
Date: Tue, 30 Jun 2026 14:55:24 +0800
Message-Id: <20260630065524.27680-9-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260630065524.27680-1-dinesh.maniyam@altera.com>
References: <20260630065524.27680-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|MN2PR03MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f975dc-da3c-4897-6774-08ded674cec2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|11063799006|3023799007|22082099003|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info: NJVguuKJU3pa3YCcct8/PsDVV8sMLawQ3DCiR2uGhsJxvnHvK6i019EzCBWadoyzx2fZOJ+Y1ng84PP5S8b1OHSaQyrvQCYcpgifKXBtv4X//v2u1E2KRxdaxW5RvWRcNtcMxmM6647Q9GaIg+8d15VLIYqzZ/O9Il9vl4xmKuEKvFlCVHlnIjS5YAbY5Ajtgd6iXJK4TZBpvsAPBJI7DvaRqIBZ7b/dVtAcqv+d/LeEenm4U9jtI9ZmdGMUJpPANXBpyQUiYHyyGada1RYb7ei+zEwxvjYoZM+iBKUi3MDJOAeUSujXlYLmTjMqeRnauu9x+7+CZi8pAYx/Q8y3OEJwI2Cdtg89Il+s2E5JQmp1qNGZ8ehRqwJ2Drq1rwtL9QCzqhufX42lWlZ/RRPWrUHTs3Irv6gcQT2vNbVs/aEWCwDI79a8Gn4FRxe+dw80hiL3DfOuArvCYKM6aIAjYQ/MJcw4y5vTEvquiBg0LjM2NvoH2tS7GKIw+Soj1OeXC/Pzza8t8jl4ZzlewjVMdAW4yjaiXos+t2V+OivGmBDg/D908JamGeMRgURukkYh48+Lbd31MJCSxuDuV157KF49CNaYh9IPYxUzMf/2zHeVOMki+LvTxAbnXfR5EJu5ICOqe//v9wl3p8PNB2XuQY/VaDOJ1Bh6DNsycUsaNUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(11063799006)(3023799007)(22082099003)(56012099006)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vLhjzYqHy33ssCHEWTMGHOwnRnQ3gOmXOF6eDVC11NsomnYmDNoQocOgZfuP?=
 =?us-ascii?Q?4+2VVayTzPwYSwnrUFUHnBBaO3XVobqDet+Y/kjVXJu0TXRYZxDf0i+CaYJs?=
 =?us-ascii?Q?llXDshfWU7b2xsxJM63+Yv5gX86lSWV108Hz3mUQG6RBW3AzJE5M6YmPuQ+P?=
 =?us-ascii?Q?x9pfnPGhcTGgekoog7KRWLrAS11czTPn4sDzPgGgHKtbSFr9e4ZhJkT7K235?=
 =?us-ascii?Q?HD3hjNR9rz1Ey/SX+EL1/ROvTGsB0Kiarg/8+4/qoMoctaESlXfXcrtMmu/x?=
 =?us-ascii?Q?WhkPIdjqyRLQKwaZ6/OjgBt9Q5Fz1W9LqueoRNUbuddiBHuHoOxUb6XaXwEZ?=
 =?us-ascii?Q?YKe4+ExXWnaXKE/VB42h7NglseN1kTIp4ziZvemecnn71UjzKIPOGjv/76Zt?=
 =?us-ascii?Q?BJ4Khj81Yp7uEZHap7bQAqPBlhwo5lLoBrjejZu2/fN/aHGlNtZwIaEJO/T+?=
 =?us-ascii?Q?KsdSFeaw1bpr4a/YVp3csSprSb5Up/WN9Bhi4G6kWnhIKF+1z0bxXGmmnJd0?=
 =?us-ascii?Q?JeMu577QTon2YDThKJq84Dg0GFcn4Puktrk1ENP6yOjalAQPvA6DJWxZzSLN?=
 =?us-ascii?Q?RqmRRTHySGhsRUn1i8rUvEMAG35dQ6wZcuA6QqOA1cEZVXx7yZacfv8wmtT0?=
 =?us-ascii?Q?dmvuY2TxYTMeQC1AaJWBPP233IKVFMD11kTomXnq94HDC9zWGWN9lnJWalXw?=
 =?us-ascii?Q?eBEXcFHQDWW61wMH0a1GEH6cUJYfd/vBSOUtN6iF4fY0aYZWRuD4jFuepsRs?=
 =?us-ascii?Q?gPJ6hoZVWmiaHeHKk/nmKdDHL/7tAqNSDPSRzbi+3JtaWj2vnNwXWEJgLSKc?=
 =?us-ascii?Q?y8idBj/ZNnoZ+p9laA1pasRralK8NXk3gKr7Xg6SNTXe7sddvVLCTw4u7Ql2?=
 =?us-ascii?Q?zdLgjOW0G5HEDq5fy1oEmb3N7oJxBMTVaC5Nt+DTcOinKS3W4Xx4soh0j3j0?=
 =?us-ascii?Q?jka/YCa5c2WMcVJgZfyIryT0rFc8r9VbrVbcqExog414NpBs0ZXbG4pCk5XS?=
 =?us-ascii?Q?4mkevYVYhFsB3nAUMP8jvAKYxfuEGU4JnbitQbwfX6TycQ3+kD0Dmoe7cIi9?=
 =?us-ascii?Q?BIGs9HVCfIekulliNWB2eE0YElcNDzaCguldjMFy6D6yb0N9BnWXDwqkWHy6?=
 =?us-ascii?Q?RpsA7FN0K1DAnb+huN9BDqcwwnZKd4vZ6T9chS2ccpHOExQc+ELIefEHT+S1?=
 =?us-ascii?Q?OyVVy2KXAAWymcC67xsBIPGFAj04rpTyFNP3cpVNQX8+JEYVIV3j4dutyQ31?=
 =?us-ascii?Q?5oMSJ+oTlvsU7wtGmfHRD+qcLmVUDliHuLoUpJ6OJZsl7h5pwpiFuuKMTPuj?=
 =?us-ascii?Q?SpaTkuOcNmg60tfjToxY0qzQzPpcaJGGE9TwGWWpyT8aftofrLOcuOcT4d3v?=
 =?us-ascii?Q?ZEbQJNlYvl+Qsxu8kbASWWAcodY72UqbaMtgauPLdmewV2PsCWkzAlLK5+iP?=
 =?us-ascii?Q?Zh5POIpiIRx/zCDntuJFeKfVa28G9jF5jBep8rCNyg1U2spmEt1Yk9hv+Lij?=
 =?us-ascii?Q?L6Rgbw2h97gd0L2kXqViDAV6xR2dUQmIpZ14hwxDpR20kEPhwkGJOc7lTr/Y?=
 =?us-ascii?Q?XXGuLRaC2RB9QLbSj/RvYiwP3cJRtieVOwHFLQ1WCRIXueeHs5aefVVja9jR?=
 =?us-ascii?Q?Ss59Zk4rFzzZTUdhO2IJgmkON01rzupKXj5kJpCV20VLCxNlZfqrD0t5lpl3?=
 =?us-ascii?Q?RCDc4e3WB0dpmEKhm8NH+5G1Pm9r86pqxXy/v7gGjp9osrg0UP7THXD6KjiB?=
 =?us-ascii?Q?zgI17cdS1Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f975dc-da3c-4897-6774-08ded674cec2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:57:10.9913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KK+zKiwh0ba/4J/1KZkwMeEQCy/2xvpNhkU0XqoSqykwel1Xp1ExOxp5hi/WQO8MiB5UeLt1uZ7LVdlaxZN4mIIMuJVG40oEV/StCLpg/14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5085
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:28 +0200
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

rsu_dtb() locates the RSU-managed boot partition by scanning every
fixed-partitions node for the "Boot and fpga data" label, falling back
to the legacy rsu-handle phandle only when no label matches.

Relabel the Agilex5 SoCDK qspi_boot partition from "u-boot" to
"Boot and fpga data" so the primary label scan resolves on the local
DTB. The unrelated NAND "u-boot" partition is left untouched.
Stratix10 already carries the matching label (aligned with the upstream
Linux DTS), and the other SoC64 SoCDKs are not in mainline yet.

While here, drop the redundant fixed-partitions override from
socfpga_agilex_socdk-u-boot.dtsi: the Agilex SoCDK consumes its
devicetree from the upstream source tree, which already defines the
QSPI partitions, so the U-Boot overlay copy only risked drift.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk.dts        |  2 +-
 arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 16 ----------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts b/arch/arm/dts/socfpga_agilex5_socdk.dts
index 886cc89fdb6..483760b6763 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
@@ -158,7 +158,7 @@
 			#size-cells = <1>;
 
 			qspi_boot: partition@0 {
-				label = "u-boot";
+				label = "Boot and fpga data";
 				reg = <0x0 0x04200000>;
 			};
 
diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
index f2150b7eb7b..75d3aa08267 100644
--- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
@@ -164,22 +164,6 @@
 	cdns,tchsh-ns = <4>;
 	cdns,tslch-ns = <4>;
 	/delete-property/ cdns,read-delay;
-
-	partitions {
-		compatible = "fixed-partitions";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		qspi_boot: partition@0 {
-			label = "u-boot";
-			reg = <0x0 0x04200000>;
-		};
-
-		root: partition@4200000 {
-			label = "root";
-			reg = <0x04200000 0x0BE00000>;
-		};
-	};
 };
 
 #if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
-- 
2.43.7

