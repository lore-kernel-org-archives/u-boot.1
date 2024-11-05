Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586DFD1CA19
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B15B389116;
	Tue,  5 Nov 2024 04:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F39888F73; Tue,  5 Nov 2024 04:45:06 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D458A88F77
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IatPkjzpY0CdI8gV9ULhDB4vzFqrDg09uCwaAK8CvHwmN9ewddT5jy/csDU3cmsEsxAg+bkF4GtZHeSVwRGuxHIIP18L9zS5TQLsKaJfIylidjOV0MhSy8nFiEZo5a5poXCgfnwcGyAy2I2a7nkSTFE8mZy7Zxu3bL5srW8jtGj3qKmb2+OUtiG8VOlQkPBUGjE+Dx7Qeb5nzwstg/mzgnNBt1MfU3PuwzkkQNfoLoVooXAqDG+DtVh4S8aytL5rohts0/u7I4sHPG05TXBDa6UYVk0uOrDKVsxvBpSLe0JmoK1yVMKwFnao76maN4EQk3K/8RYMJvj1mSuWZZc77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KJA8s/8W4yuZj9uS9rwhUOoI3arUBUsv9mlM3Te3g8=;
 b=MHFgorlGsrNnhwIEJOmh6kL1sRKIwNw+y+ehkYTee+pb8woPoz4v7VddrOeAFBMNt+9exPMJ6rM+7x/4Gbiv6w0SMiZgx4WN6I8xOzzGlu+YEL+oDwXUCeCWEttINWrTDYgRjFyblZLL7t1z9hoDFnD87IYtaGo8IQXpQ0kBCuWLNj8z7rR5m1HhLWpJyCCjpooyZII4l+pDl7sSXd+F6TCvmi9jIg+pSrNrjqof/4TSfmikCevTSFd/7iB752dzmw0QmWnV2mQTA98Vd57aOX69gMDkE/0STdRSbJYx+nIr7bUA7yjxvMC5YjHtT74NdBjD4wGGjExt1bTK5ltBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:45:12 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 03:45:12 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3 09/13] board: starfive: spl: Drop the unneeded DT
 modification code
Date: Tue,  5 Nov 2024 11:43:24 +0800
Message-ID: <20241105034328.56439-10-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241105034328.56439-1-hal.feng@starfivetech.com>
References: <20241105034328.56439-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: f889ad54-b58c-4bbb-d2b9-08dcfd4c40d0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|41320700013|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: WOiUQO9XQ6vcOWbFi6HkTMcqBMmlZ90e4y2WBrk4fIB5RtUZo2gq0T9COvTXveq5ddhPNXNWocsLS3rMSGFdFxzXYE4Y1Sze0aHt7reh7ULiLLJw4+UGAw5rvpE6linzPgikgMfG3D0QC1ze60Hdp5sS+1l3SDmP0GxyPC4jlCNhJNvtON82nWvd2WyL7wgn5x+IOUNaxF/x4MaU4ij8Lm8iOeOsRsxI+pq+hsqxlXVXqWqPRkryAB/RRHCY+NYYJiWEgcw2h+JHY7WUdvgahVCVJeS6BOWlRqMxWgRM77lJ3hJE8GQXNoyAM0Qhg/lMZkHmqFSE7epB8NuxB1IFjkCwOYDhybGWmu/BRP8xiWjK9glGzyv/2/aOcyHNdJReJN5yhuDUsKig2BcI7yvRYedah9oA+qtyAHFnIqqf8ik94Jk1X1Bj2L90emfJAuBOOqySu8rh4XbkSkBKb8kXS5+meoBiFqkRtwYjSI5AYT5NdwQ44Zd7ZD/+ndmP/SUZ0DK5TfjHrO4e4mUq+opLl4eQFnG99ep/N3SzQOCbFfIQQU4t96Bg+Kbkk/7KhIP2RlFzdGBZlGJQtenzY/oVhblerC/BVrQRlwDoRfGtRd6TRCPX+LP+keQSjIQT/9YrpaqVS1OF7og8dv/l+SG0pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(41320700013)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M7CSB75Jw4qeWvLCnUiSmBTm8kMtqDyBR4Y4+UHP80M8GBdj7+QJUrQZJ60/?=
 =?us-ascii?Q?phvhlixK4CLTlID2j5ZzK98VEiV9DlRgjB5Oqe3dyaJPbbQwnY+LfobeJdg+?=
 =?us-ascii?Q?+nYlGD0pnhGVDD7qAZ93vDZ3hEVef4MuwhmFR/WWsYkJCnoaZ2hLIaitrZRC?=
 =?us-ascii?Q?kDzEurJh64/GXnKDDoaNxz3kweAIdz9QMWoVIWUtWPHHuEghtdgb6imABz85?=
 =?us-ascii?Q?LVvJJ9gB1sc/kwRRmhXD7v7BqxLewsgosj6njgxSprDhFfixnTIYwmxTaCPe?=
 =?us-ascii?Q?z9iCpr9YRXAxCS1KxLzFZwiuhcLkmwPMNVvZPm7PQFadwge1QZv6qJkFCNEA?=
 =?us-ascii?Q?VttfCZ8bbxECx1Mo+Ot3xKDTlxpOq0Lyvq8TJ9gIP+2tJwlcEfsbbQgULZdP?=
 =?us-ascii?Q?ukuWsnaCysciB1FTkKvQFjrVGzEB+qJ+eBmJoGpu2yajY3oFsXzrwTgvd1lm?=
 =?us-ascii?Q?xuWB9W4k7wNSD2g9NqsTIL4+gs4VoSj83zXEpWGmkZfeO4CIq7SORJgcXb8z?=
 =?us-ascii?Q?HzX9CySenK6NfEmzKUssFh9jJMutMZlKgUvnV1ggzrPWeAEvWGUt+kjFa0Ix?=
 =?us-ascii?Q?o88vIh2tQEyHJGqMGGeFPgk0i87zBzCHDXGWniN2HTlxqtu2OSurJjwox91Q?=
 =?us-ascii?Q?MldiXDh8Cduo/NOHQALm4AMC8BCpAEMVTJcrf8P4ZcUcsMSA4XOlf3D2ltiP?=
 =?us-ascii?Q?VZ3RKEojs0qX+/+K1BC/LxyoYJOn3mbWLJgqvf6feAQBgqOoDQ+V5ctOQnTT?=
 =?us-ascii?Q?6bcswtLZRKqZU3clzyb/aasSsM3tQ+5u9OOuqfDta0LpLHNKMQOtReEHn326?=
 =?us-ascii?Q?6wdfBo7YYrUwCj2JcxKZnicaujbnoLLW7ivaMbL3wPOFmyUELrJzyrYNlG7F?=
 =?us-ascii?Q?0pNNqLAta/owgYGnTXAlH1ea1psFkiEki4r7eX7qv/XqKp3fG7vUasDQRRjG?=
 =?us-ascii?Q?N5j4VpXWqXbJ8kGvzyCIs3hw44eq3VIf23UaTfPEgb+NdZhss4pA90r8SwHL?=
 =?us-ascii?Q?DqsYEXS52uUE4Ubx4XI1LzD8Pct/bdNCY/a9kk7dWsFA7J/zXNP8lmiZJtVS?=
 =?us-ascii?Q?grevyRyoCeCcA0gTgJt+WyL43cn/+aJDxzwK7HYufpgMGqrCJaq5Z3uOKT+I?=
 =?us-ascii?Q?EFNj3WoQcHa3wKPotS9SUHOp8jh36zG7kX8Gy+nrmgmdMYLOAIiofOmhk7ET?=
 =?us-ascii?Q?Y0WECwlrP32uAT/drpFJ77TuQBybW8w5QVj1cS3yez3eUo1Dv2L+5LZ4Uf8j?=
 =?us-ascii?Q?eq2B5ID4KZ44mKPxKGgf+VSgy9s7RuqHAmv+QPMze3A9GlsipqmOlTyc8grB?=
 =?us-ascii?Q?9f4blIprn0mZREycAeNFOFWdXFv9Zw3j3FNL678YThthtOzN9pWt781jnaKZ?=
 =?us-ascii?Q?ofdmlzYIq94u8FIC7my7b/t+2hRdtoIR4YayOZceJ0VWSPE4VkdKbvAkzK+q?=
 =?us-ascii?Q?23e7ALmnC2geztxW9gf9EGf7d5fP6VdQvGQMT+2ljscNG9Hh3DYfRgjxxF+Q?=
 =?us-ascii?Q?VvWnJlFE27/RUzd06RLidLcS02rStuYgzpFGliCvXbIJSkCLxCBa1SvB31eX?=
 =?us-ascii?Q?fUibJTpPgmpBl77DWqHnVJXYNz0bsN6D+g1cmfqyM9ohe0iFI++hgDgEXdh/?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f889ad54-b58c-4bbb-d2b9-08dcfd4c40d0
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:45:12.7485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29cShoe9TKYFLmrn+3IImcXv7FVNyXjr7tEaGkF8t+takoc4v870W2To2PcZYU/4JAnVG9lvfCUVwj7qjyIrIKp6WaMs0lPSqw9iEBwabYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145
X-Mailman-Approved-At: Tue, 05 Nov 2024 04:45:33 +0100
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

As OF_UPSTREAM is implemented, these code are redundant.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 356 -------------------------------
 1 file changed, 356 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 3fd535e7cf..38132ecccd 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -20,364 +20,8 @@ DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_CLK_CPU_ROOT_SHIFT		24
 #define JH7110_CLK_CPU_ROOT_MASK		GENMASK(29, 24)
 
-struct starfive_vf2_pro {
-	const char *path;
-	const char *name;
-	const char *value;
-};
-
-static const struct starfive_vf2_pro milk_v_mars[] = {
-	{"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
-	{"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
-
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-1000-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-clk-drv-microamp", "3970"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"rx-internal-delay-ps", "1500"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"tx-internal-delay-ps", "1500"},
-};
-
-static const struct starfive_vf2_pro starfive_vera[] = {
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0", "rx-internal-delay-ps",
-		"1900"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0", "tx-internal-delay-ps",
-		"1350"}
-};
-
-static const struct starfive_vf2_pro starfive_verb[] = {
-	{"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
-	{"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
-
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-1000-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-clk-drv-microamp", "3970"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"rx-internal-delay-ps", "1500"},
-
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{ "/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,rx-clk-drv-microamp", "3970"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"rx-internal-delay-ps", "0"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"tx-internal-delay-ps", "0"},
-};
-
-static const struct starfive_vf2_pro star64_pine64[] = {
-	{"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
-	{"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
-
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-10-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-1000-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-clk-drv-microamp", "2910"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"rx-internal-delay-ps", "1900"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"tx-internal-delay-ps", "1500"},
-
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-10-inverted", NULL},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,rx-clk-drv-microamp", "2910"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"rx-internal-delay-ps", "0"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"tx-internal-delay-ps", "300"},
-};
-
-void spl_fdt_fixup_mars(void *fdt)
-{
-	static const char compat[] = "milkv,mars\0starfive,jh7110";
-	u32 phandle;
-	u8 i;
-	int offset;
-	int ret;
-
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
-			   "Milk-V Mars");
-
-	/* gmac0 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@17000000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16030000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_GMAC0_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_AONCLK_GMAC0_RMII_RTX);
-
-	/* gmac1 */
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/soc/ethernet@16040000"),
-			   "status", "disabled");
-
-	for (i = 0; i < ARRAY_SIZE(milk_v_mars); i++) {
-		offset = fdt_path_offset(fdt, milk_v_mars[i].path);
-
-		if (milk_v_mars[i].value)
-			ret = fdt_setprop_u32(fdt, offset, milk_v_mars[i].name,
-					      dectoul(milk_v_mars[i].value, NULL));
-		else
-			ret = fdt_setprop_empty(fdt, offset, milk_v_mars[i].name);
-
-		if (ret) {
-			pr_err("%s set prop %s fail.\n", __func__, milk_v_mars[i].name);
-				break;
-		}
-	}
-}
-
-void spl_fdt_fixup_mars_cm(void *fdt)
-{
-	const char *compat;
-	const char *model;
-	int compat_size;
-
-	spl_fdt_fixup_mars(fdt);
-
-	if (!get_mmc_size_from_eeprom()) {
-		int offset;
-		static const char
-		compat_cm_lite[] = "milkv,mars-cm-lite\0starfive,jh7110";
-
-		model = "Milk-V Mars CM Lite";
-		compat = compat_cm_lite;
-		compat_size = sizeof(compat_cm_lite);
-
-		offset = fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
-		/* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_NONE) */
-		fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
-	} else {
-		static const char
-		compat_cm[] = "milkv,mars-cm\0starfive,jh7110";
-
-		model = "Milk-V Mars CM";
-		compat = compat_cm;
-		compat_size = sizeof(compat_cm);
-	}
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"),
-		    "compatible", compat, compat_size);
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model);
-}
-
-void spl_fdt_fixup_version_a(void *fdt)
-{
-	static const char compat[] = "starfive,visionfive-2-v1.2a\0starfive,jh7110";
-	u32 phandle;
-	u8 i;
-	int offset;
-	int ret;
-
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
-			   "StarFive VisionFive 2 v1.2A");
-
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@13020000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16040000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_GMAC1_TX);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_GMAC1_RX);
-
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_SYSCLK_GMAC1_RMII_RTX);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_SYSCLK_GMAC1_RMII_RTX);
-
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/soc/ethernet@16040000"),
-			   "phy-mode", "rmii");
-
-	for (i = 0; i < ARRAY_SIZE(starfive_vera); i++) {
-		offset = fdt_path_offset(fdt, starfive_vera[i].path);
-
-		if (starfive_vera[i].value)
-			ret = fdt_setprop_u32(fdt, offset,  starfive_vera[i].name,
-					      dectoul(starfive_vera[i].value, NULL));
-		else
-			ret = fdt_setprop_empty(fdt, offset, starfive_vera[i].name);
-
-		if (ret) {
-			pr_err("%s set prop %s fail.\n", __func__, starfive_vera[i].name);
-				break;
-		}
-	}
-}
-
-void spl_fdt_fixup_version_b(void *fdt)
-{
-	static const char compat[] = "starfive,visionfive-2-v1.3b\0starfive,jh7110";
-	u32 phandle;
-	u8 i;
-	int offset;
-	int ret;
-
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
-			   "StarFive VisionFive 2 v1.3B");
-
-	/* gmac0 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@17000000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16030000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_GMAC0_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_AONCLK_GMAC0_RMII_RTX);
-
-	/* gmac1 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@13020000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16040000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_GMAC1_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_SYSCLK_GMAC1_RMII_RTX);
-
-	for (i = 0; i < ARRAY_SIZE(starfive_verb); i++) {
-		offset = fdt_path_offset(fdt, starfive_verb[i].path);
-
-		if (starfive_verb[i].value)
-			ret = fdt_setprop_u32(fdt, offset,  starfive_verb[i].name,
-					      dectoul(starfive_verb[i].value, NULL));
-		else
-			ret = fdt_setprop_empty(fdt, offset, starfive_verb[i].name);
-
-		if (ret) {
-			pr_err("%s set prop %s fail.\n", __func__, starfive_verb[i].name);
-				break;
-		}
-	}
-}
-
-void spl_fdt_fixup_star64(void *fdt)
-{
-	static const char compat[] = "pine64,star64\0starfive,jh7110";
-	u32 phandle;
-	u8 i;
-	int offset;
-	int ret;
-
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
-			   "Pine64 Star64");
-
-	/* gmac0 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@17000000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16030000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_GMAC0_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_AONCLK_GMAC0_RMII_RTX);
-
-	/* gmac1 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@13020000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16040000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_GMAC1_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_SYSCLK_GMAC1_RMII_RTX);
-
-	for (i = 0; i < ARRAY_SIZE(star64_pine64); i++) {
-		offset = fdt_path_offset(fdt, star64_pine64[i].path);
-
-		if (star64_pine64[i].value)
-			ret = fdt_setprop_u32(fdt, offset,  star64_pine64[i].name,
-					      dectoul(star64_pine64[i].value, NULL));
-		else
-			ret = fdt_setprop_empty(fdt, offset, star64_pine64[i].name);
-
-		if (ret) {
-			pr_err("%s set prop %s fail.\n", __func__, star64_pine64[i].name);
-				break;
-		}
-	}
-}
-
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
-	u8 version;
-	const char *product_id;
-
-	product_id = get_product_id_from_eeprom();
-	if (!product_id) {
-		pr_err("Can't read EEPROM\n");
-		return;
-	}
-	if (!strncmp(product_id, "MARC", 4)) {
-		spl_fdt_fixup_mars_cm(spl_image->fdt_addr);
-	} else if (!strncmp(product_id, "MARS", 4)) {
-		spl_fdt_fixup_mars(spl_image->fdt_addr);
-	} else if (!strncmp(product_id, "VF7110", 6)) {
-		version = get_pcb_revision_from_eeprom();
-		switch (version) {
-		case 'a':
-		case 'A':
-			spl_fdt_fixup_version_a(spl_image->fdt_addr);
-			break;
-
-		case 'b':
-		case 'B':
-		default:
-			spl_fdt_fixup_version_b(spl_image->fdt_addr);
-		break;
-		};
-	} else if (!strncmp(product_id, "STAR64", 6)) {
-		spl_fdt_fixup_star64(spl_image->fdt_addr);
-	} else {
-		pr_err("Unknown product %s\n", product_id);
-	};
-
 	/* Update the memory size which read from eeprom or DT */
 	fdt_fixup_memory(spl_image->fdt_addr, 0x40000000, gd->ram_size);
 }
-- 
2.43.2

