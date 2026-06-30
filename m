Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03982C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 02:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4794B84AC8;
	Tue, 30 Jun 2026 04:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vFv/OOVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5755384ACE; Tue, 30 Jun 2026 04:53:03 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25419849F3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 04:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/H81+WVLJO/gpm8mkinm6K8+oU3IfFTsxFt7HX6T7F6gv5QeMr00a/Znm7S0qS2UIm2i3lUIHHU04t6Uu9CuIquWkWE+bpRTts5Rc5Ml72qcuZwoxV957iJTvT6h14Q8SQ4Kl+SYISkqmK1YIfnFhaBYcEeUGXc64i3e0luNtveBFD3yfBjkMR7EPqKeRggooAc23PvyM8jmCNgSDqo5g4aSbcuDFHU4OckC5vdSpIVw2mhNynJrAE3E7Q7KBm/OFCcyC9erItWf77K8TFOptO/Avwbv/h3ZsSnQJbIVCrirEUXQCFBAARJ0Bg5fdbfIGrKu8tHpRW2tAhbpNxotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptvL2f/9xZBttxz1BqmVWTsRkNo79MAtNuqUpCrUvsI=;
 b=eiV/IMtt4r5QSlUh7xviaRg8RT8QMO3iqQl3AgHPav4UgI1I0gsSu5bjZfEcv9ru0QvtOeMYZB6STot7DQv9YDRrkf4wOUmK4DDpi0nk5icpXp2q+qPnuAgZS0Z4F7r4u/5bwebQx9MUtViqsiqJfvpPnc8cm9eNXmBqdDbbNKG4HRNECvZuC+C637HfPv1xQCsssytNfYFNIRAtxsyE/zIO+HIB9lMwlEb8TA3VMRrx/bJ4hz2iwqm6IcSlWR7voSMGX32d+ZBPUe+BrUlf7Znad/Gurxs9rMrKMYSTjyxHYyutZTp2eiCgL7B5KCZIzHfGjQYHcDHrVXtgsjb/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptvL2f/9xZBttxz1BqmVWTsRkNo79MAtNuqUpCrUvsI=;
 b=vFv/OOVp3NH9UTrK2/GM5nznnQ6Ms0FQFLqlQDl4QkHurgtgMSIch7yqYbANuRInAObLHrnw8/TgNaoxwBayV6TqYsCFTCtL74gKv9UQZDOhoMlXRahcnqsj0BTTDBesjmDSkfbHwsxvpxlGzcouFmorzh3SU+bgD12swYkJ2jtN0tWkDoO6AuNjIVtCs59kVINjL06oUeCY5cZIo6jrKlfNOyQCnrfxHuNmDBLWIvuk7WSHjx2+5Kb5DoxJ+7MAUuKSKRwj/HoEq1e3vMpqRALbrEFUy0W98NDWmI3xYnCnawSeAMTHEbIUhReVN68t3hD6NmtIMCK3yU5E4HU5NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VE1PR04MB7373.eurprd04.prod.outlook.com (2603:10a6:800:1ab::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 02:52:58 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Tue, 30 Jun 2026
 02:52:58 +0000
Date: Tue, 30 Jun 2026 10:56:22 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>
Subject: Re: [PATCH v2 v2 4/8] dts: k1: add SD card support in u-boot overlay
Message-ID: <akMwVgFWHS4GjChv@shlinux89>
References: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
 <20260629-m4-v2-4-cbc91c6b83d8@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-m4-v2-4-cbc91c6b83d8@riscstar.com>
X-ClientProxiedBy: SI3PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:295::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VE1PR04MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec2a14a-b32e-45b0-23ed-08ded652b163
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|19092799006|7416014|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: Ndz2X01NGpFQp5x1prLuV5bYHoAhekeUvCoYloWZpSXm1Lq4xpTxVczf8qWdI1KfVZHgMwDffYsL4n44OTt10BXug8HdnixjS0+UMJ3gDDNOwsczVYhd7ilPzWL6VGkQSahm2E3QnLCxasRmIa27xzBS/R5kjWcxjJEPoZ2tXqxuX/AYRIawdUX/n97Gk2UB7h59BYP6+W5a9V5vrJbV8CZex8UyIToH9ie5XWFhELyKseV0WLCUCUDpE5No8JkFahVLFjI/HRHcTbbRpWi7cQVe+ZIOcj2/u0PcptX7WP5yLzPxQPubYT5eh2gdQM3p0yUFMfpbC2cb1h4VzI75iOVy2ox2cK9qEbt0SaVsRfJuWgSA0fxsxiQjpg76ZeQiB82pDms+sryqjTciK1OVk4ZNB15fanWsbmJHUuKoUlOmBPaETBVHsDR+LhjMDAkeQq62L/w23xVau/mKCC/bUqyA2wWzvS199WpF5rgyr7zVQWauJxX24QKhck5h9CH1JyVSwUNhrVZ2cwkNM4UNXCWnrWgGPRa2z5hKJaZ0V2aPnkwuHuf+4BXJSbs8pRGdI/j0yrpS/SZvUatFd8J9bIJkXLGPIC9dKwgayJGOMKKBnCK1TwtjP7GtHUYRNDHC1x6QyDaULxyqwh+UNjvw16oyy2mrLfYhLpq7mLrcB3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(19092799006)(7416014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?38RPSgkPBughb77yc4vzf9tyoZjErJdn9l2vyc0J91E+ZIgYMmsmN7TJBair?=
 =?us-ascii?Q?i2IJULTETtwwNvQvVHMnghS9hxayYU4tj7vwkIEzyWPl8aeq7HPtad85Znla?=
 =?us-ascii?Q?cx33nKwDE5LHwdIPGS0OU8408VqOboc12ku1OCsCmZAIQT7sbYkU6ipUkz+6?=
 =?us-ascii?Q?/miz6r7fKe7D11tptpMNgD9PZ3VZ6WZOxBkDXpNtxJU5vGfOMze6f0H3mdS1?=
 =?us-ascii?Q?eKuBcsSNjv0yeLxohTLbKc8QWX0sPYXMBflqg4iuw/phqRJ8a/BWN4FpKAZv?=
 =?us-ascii?Q?6dAECXRemVD4CaX9c8h/5NNNiNqXxEY7ynm+OsYiq/DKuvSCDbfw1gU76zm+?=
 =?us-ascii?Q?b7BsbSklHcNqAfnxw/iXzPWNvTdcLp72z0NtwJgEsPJQ12K66SAvqQisIo6D?=
 =?us-ascii?Q?NyWxWDZvMcE0y+DLsq9tzup2gzf3qwilXvh2dOGAFZ3OPcPJKT+Y37UZmAOl?=
 =?us-ascii?Q?UIu9iGABlo2chaUvdwqVeAnGR2VDs+t+fDvPMSue4LwOR1GYYK2D5srpk80p?=
 =?us-ascii?Q?RmB5cyaIHsemLEw3xcZdUVCKj1SGMGZkcCOu6EMQNNTt6B/HGiS+f/r5Fv1r?=
 =?us-ascii?Q?Jj3TNMk7oswo20nQXBUAp3LYrxthglgcb5G7oSm7iVLp5FA0vju9fnWwsklx?=
 =?us-ascii?Q?haSacf9DHRUiBztY0qMoHL2V/r9B0YRNcOdvPQLQbzs3Utw7nvkyWxOhwOAX?=
 =?us-ascii?Q?E1Gan27XYrDE3nbiHxTBxpnEHBmQ1l3ehMFKkTWCOt8whlXnuYU8G+1/zwke?=
 =?us-ascii?Q?Rt/p4Ax+5ZnMAXwauxGLr7NR+1Es0FnIfVjnmiKjNNpY1Q+zU0QJ8NTmRL0l?=
 =?us-ascii?Q?UePpyZHSBq6JhZ7NKOq2W9GdaXGIJhD4u+pM1NXtTNmWgKp7mscWKz6XhEIW?=
 =?us-ascii?Q?Qiollj7x3dPO4Vw5NT53TGjsfZnnTWhCSZbSwN645KSTMUcODuBGv3HEPS9A?=
 =?us-ascii?Q?KztsYrwacuFMV0ifi4pyjuBjPBdMi+FHSbVWsdzm9K/QVUAdjoLzExRJZ6Xp?=
 =?us-ascii?Q?X/f2ia5phhq7XArtrwsdLXeFj7rMPxo4mhqiaD36LH7pAQ7+sOcpJbjTRhW1?=
 =?us-ascii?Q?bMKRdIML5l+RdYwCAnSSr1aEYxOBt8H//TeQR0uuDkid8VzsCfJjIrXnUMzf?=
 =?us-ascii?Q?/l95Hc2o3gBr3n4Y5Q7kCHmlEQF8iHQ0cR1LNj6gVCgAWae4c32Rv4+B7rzk?=
 =?us-ascii?Q?u369YB1pV1Wb1pIUj1Q8oiICaFJJXKnXEAy2kCarRzhA53PqZn1p2W9VhQsu?=
 =?us-ascii?Q?oxWBrQXf38l8A1AptX1H49OTHmF2X192T8SI8iteH9qidpnPGLN7tslMm9zg?=
 =?us-ascii?Q?pIdwVcpECntktjbR8st7sCw/tEYhu0vXJ5gRewRG5CDKfDvKaT6fuxMkms3x?=
 =?us-ascii?Q?a5sLRxn6OGzhYBVZ7r9VBdb4flGKgll3KX/qnrS33qU3fsp3slTTKbh9sS5c?=
 =?us-ascii?Q?Fio2ViXhYCZcX4xxwOfQjIkktxeyKa9SFodZeybJHgPyIms9Gqu5My1pUxPK?=
 =?us-ascii?Q?AeJEjfq60+sWi3BqMzPqHmFqO+zETGRPFl4Ak7jXCNVv8UTDLP+gubiXx5l+?=
 =?us-ascii?Q?hi3cuLJ+Y/f7T5Brt1x60jGyuYz5jJKBOGmSExWOy+EKgCOFmKZZVN0bZlE4?=
 =?us-ascii?Q?Xdwdm6eFYayJ23SEQJ0tmqN2lmcH02zSCqf3xtLvxGsyHpFrEKZqPTiRFrDY?=
 =?us-ascii?Q?Fw9yfB/SImsMzEW3/eDCAWTgD/nR3hTf1NDhz9mOCnE2p28kwusrI2/nm0qg?=
 =?us-ascii?Q?joKJ+fNLDeLaQqyDE1uSCEFZbjyZg7qnIYXiVPA2EBSwmBzqZk8w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec2a14a-b32e-45b0-23ed-08ded652b163
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:52:58.7810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdJXjXoby8ZsLjlHtpA5OMzJ4n8xWHu4Hu0KTenOOmoPHSS6TQaOrRsygaJ4GXA3DlDlzRvO90r4aKTiWjlLauqKJlI0WdzKG/vRIA7WPHDRSavTJVCq5vkaeybR9UT/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7373
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

On Mon, Jun 29, 2026 at 11:51:18PM +0800, Eric Chung wrote:
>Add the SDH0 controller node and its pinctrl groups to the u-boot
>overlay. The upstream DTS only contains the eMMC node; the SD card
>controller (sdhci@d4280000) and its MMC1 pinctrl configuration are
>missing. Place the new node inside the storage-bus via path-based
>merge so it inherits the dma-ranges from the parent bus.
>
>Signed-off-by: Eric Chung <eric.chung@riscstar.com>
>
>---
>v2:
>- Use vmmc-supply as vqmmc-supply on SD node.
>- Add alias of mmc0 and mmc1.
>---
> arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 87 ++++++++++++++++++++++++++++++-
> arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 82 ++++++++++++++++++++++++++++-
> 2 files changed, 165 insertions(+), 4 deletions(-)
>
>diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
>index 7f9443d6951..463952dc047 100644
>--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
>+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
>@@ -6,6 +6,11 @@
> #include "binman.dtsi"
> 
> / {
>+	aliases {
>+		mmc0 = &emmc;
>+		mmc1 = &sdhci0;
>+	};
>+
> 	memory@0 {
> 		device_type = "memory";
> 		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
>@@ -76,12 +81,14 @@
> 				bootph-pre-ram;
> 			};
> 
>-			buck3 {
>+			buck3_1v8: buck3 {
> 				regulator-name = "vdd_1v8";
> 				bootph-pre-ram;
> 			};
> 
>-			aldo1 {
>+			buck4_3v3: buck4 { };
>+
>+			aldo1: aldo1 {
> 				regulator-name = "vdd_1v8_mmc";
> 				bootph-pre-ram;
> 			};
>@@ -89,6 +96,82 @@
> 	};
> };
> 
>+/ {
>+	soc {
>+		storage-bus {
>+			sdhci0: mmc@d4280000 {
>+				bootph-pre-ram;
>+				compatible = "spacemit,k1-sdhci";
>+				reg = <0x0 0xd4280000 0x0 0x200>;
>+				clocks = <&syscon_apmu CLK_SDH_AXI>,
>+					 <&syscon_apmu CLK_SDH0>;
>+				clock-names = "core", "io";
>+				interrupts = <99>;
>+				resets = <&syscon_apmu RESET_SDH_AXI>,
>+					 <&syscon_apmu RESET_SDH0>;
>+				reset-names = "sdh_axi", "sdh0";
>+				bus-width = <4>;
>+				max-frequency = <204800000>;
>+				cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_LOW>;
>+				pinctrl-names = "default", "fast";

Still fast, while your driver and changelog says uhs.

>+				pinctrl-0 = <&sdhci0_0_cfg>;
