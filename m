Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F8ED12D60
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6047C892E8;
	Mon, 11 Nov 2024 03:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B07D589318; Mon, 11 Nov 2024 03:09:47 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20730.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4312B892E5
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7ZUuNam7jmStY1c34H04G4RS3Aejq5gb2GZabgs7zgX0IdwlFVCFO1onj0I005yosSnELLlalq+OWUU4kmSR+o2otj4ibiwklnuIbEWjndOmaqgfFxgbCo3CXx5iVh/il+lDBt+lWRlprmFuugzgOuUGfLjTzpWhdVsSsLQiwXLiuq/SiWTS7Wy+bO9/gD0MNGoszDZOIj2XIW1cPiClfwz9YbJaTePXBb5TTUxAu729/FyEXDuwl171mOUPZ/QbEFzYHXUksjFeotNd+QVhFG5Gbl/T6Whm/ITeMbiCZsRt83TfLRE1EF26Qq0zJtj0OrH0/sGq9ctQLTwUta/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KJA8s/8W4yuZj9uS9rwhUOoI3arUBUsv9mlM3Te3g8=;
 b=hyQ1f8DsvRsJkvNYT4dOTpJLdlJ0lbv8MTIMkvCJ+EzUssc71v8NbNrtiyyYYeCYOd8AWtpH8x6vPO8fvhFXNvU3GyN/MPyDxbosSjx5RADTNYgN52FMlJSeuk+sVpJHdm+Jt9AQPtczpS7qshK1hDhDdod+6wiH9+4PzCK8WtS3PlOcwNFjAmGkHa51lDAXwEKCooAxdo+LH8EUPt9NpgtQMOs/e7szdKK1SFpVPqzt3j6o1eVl1dSM2bR/2/4/FbwcHjQ4O5nqwdGnVMpAMtjCoKkp4MJlF8QpX/GJfZ1m6UXnaQal0d/Is2AM4EBcTgMWyy3xu0DAmzOM66YHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 02:09:50 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.035; Mon, 11 Nov 2024
 02:09:50 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v4 09/13] board: starfive: spl: Drop the unneeded DT
 modification code
Date: Mon, 11 Nov 2024 10:08:04 +0800
Message-ID: <20241111020808.38974-10-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241111020808.38974-1-hal.feng@starfivetech.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1178:EE_
X-MS-Office365-Filtering-Correlation-Id: 35164fc0-19a7-489d-7c4d-08dd01f5ec9b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: jyfb1ylRUFaMMBUvsVt73p3Bgh7zBuYwk9fkYMFX4yNPxEb+r4s1v8QFMg4LQfil83T+2lTlrxpvWuO3dPl1umRduMHdbIr9gOWpDg5ljenvIq8HDxW8fI4tIo2Xo2ZMw75BYJcrNtyyRNK/DJ/2TC303zhnTsG1JNVDPmPhi246pRFaNQyCs+mVVxw7vkEhJsANDyyJxOJ1NORBzqURKoA5gfasFhYDiSBjRdnXb2/n7aqJypQ+OMoxZHCzvWvVGBgGSLCJplgxQr4y7yU5NNOove6cguLMVVMGoQhRxRkDPrm0zUYLxSHaSHrM89bQ8zc5PLGuQY3gQCs2xtOp1Pam73xR8UJpjKQOnzwam2uCd/w/RQfpC+xuhWxr/rKRV6sNlpFCwBGlJcTEe7WUuWsnfM7RpST8uv0s7sUP0MMgOW4iq+S6gzUanNVSemUHF39Gym45JL6mPNRBG7YdnYLJUhIYEz8JhOvi29a7Ce9dPAsOsFyWil+YF+HMhW+MuaMixU1xMkAVAYL67LnJvdmC4Q38iLjyPoggijHDTGB8YnROxujU5cTKlTI+hP+tGbDLsUoL1lJvv9g5JayiWQBMAS8cBBucpMFdDDuyYX5ay3hrlYw39XAegzKrqOtkiiOwQ+ZpxiRi7ebEVU5umQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TcRzlyOIeEiS+qS7ySDTf0/6KWevJMZcCarW3c22U5iW6lcBSpB36K1gv4HI?=
 =?us-ascii?Q?ySUeRLTDkzI4KqYb7ARP5H2wYTb3+zMFgDOmABSmWpfIG3/pibNPTE34Su0M?=
 =?us-ascii?Q?j6/qzlSctsk99B8OiPah4JQY0W2XQPv6jx5RYPLznHfPY+R/T46OzGGf+LD7?=
 =?us-ascii?Q?bmpMYUKo6qiiDFMJ+TBRh4mWidCSjswi98HWhpyCizi3BCOxNzRYUIqO5ovP?=
 =?us-ascii?Q?giBxfrlFnst2nbWK3EoZ0cEA31EZzGuUIIe0NTpEtsvecfo2uzbBLu36mAuo?=
 =?us-ascii?Q?3H71MX/paKg49GnPW0IvIk/CaT+ZcRYTb/qSc7TqXXnwkj3DhD6lDh9ZcojJ?=
 =?us-ascii?Q?+tAQ2HIElMCE2uJILAP3ZSnB2FVAwDNGnZZO0OED/6WCjZWgYgviQth3AMlH?=
 =?us-ascii?Q?oiXsmVvD7RMWVpFpk8yyYv+cy/GVLwc4GPnDKMm48Kamhl690pBQwr+Ppc8K?=
 =?us-ascii?Q?1kAkceU3kI0pwvpDi3gXIJZKYodnPdrCxPRA5J+pnSChT59ldSfpGNf8/Dii?=
 =?us-ascii?Q?YJxB4XI04yVjr0N1CF1Oo7uAtNqkO77lR7jKqczXHCWlKk09TFh2jL5SQPqV?=
 =?us-ascii?Q?b2xuKO/tKUI+xunLPva4uprxMLsaVMUWE9hzxlYf2TWrlKjDXYsygkWUD6GM?=
 =?us-ascii?Q?1YXJv2QM/47b4w0WseNloLEbjVSX4zL2G/ueA/mbhziTj28lFeM6NRYPKStw?=
 =?us-ascii?Q?TDiYFY3S+u06IestTq5IffiAjZD+pAFEP1Qybdal+K4VAMCsLsmEseJMgAPj?=
 =?us-ascii?Q?kWdCEbqsW8E5BIAJp2F4ZC9h3smo1vPAB5cwEI8oZ6gI705fc1AeGam6b9CV?=
 =?us-ascii?Q?OeKAUGQlBXaoQ5sO3GZHHkai6mAyMM0Jusq469YT87APozOM3FCV9ZTwXcw6?=
 =?us-ascii?Q?EEKUTfil1IdpC800tYUoOF0uID3pNqujKP/POPyE5YSUqbKfwWXDDOPUDQG6?=
 =?us-ascii?Q?RSDH9COtm9b/4ZoBzJ5XrID1k8nXUjqp4prZSlXR8rFs0z4QT81BeMn0gj+V?=
 =?us-ascii?Q?DLjqLseQvz2Ms8yTpww8qh92JRVXUqDAs6M4T9fXa7NSti+38/i8sKUmmvQz?=
 =?us-ascii?Q?5MKTgk6I5by9mHX/Vsay7eBp75PJD1f914pcjGttGvPWQnCA0uXSdqQbk4WQ?=
 =?us-ascii?Q?zA/NXR1RE5AFTKX9uJ8HpUHeYfasbOpChRq4qxcrlO+g0/9xgWEls9aydumb?=
 =?us-ascii?Q?WOrIJI4FKFtw16vtnuyaKUC1KrxcPaaMeqa6IsHvl3orejAX44olasdkB3Tv?=
 =?us-ascii?Q?srj6WQNVlOVzzIzVPX5zvWS1QOK0qCU0cyupxDUKJWMccdlqBn+K6WDExF/G?=
 =?us-ascii?Q?TXCxmIDh8xj6Ebzi4/kK8k6wzp61BtaAk9CcaEtVVM8GyU0/w8NkB9Bp4is3?=
 =?us-ascii?Q?agngQ7IPGLaOJ6wVqhcPcZf19flpflvAE7fm1FRpwkf/idMt0YECWUNvSEf4?=
 =?us-ascii?Q?QzpxW7DYJ3RXQjelvmpN0HfUxCQKT/XJpOkO9Z/jRaf7AgJ0OzSokuNLLyBj?=
 =?us-ascii?Q?Gxxdp2gr+6rJ9QjMMagxnX6h7+gPrvrrfc4dTmKpyDid4h9uKc9vaLzUM2Gx?=
 =?us-ascii?Q?Z3+qyjpPx9micb2e6mn8SXywyBSOlAvnCNh20ElP02gEjCuefAhUGLqYolRH?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35164fc0-19a7-489d-7c4d-08dd01f5ec9b
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:09:50.5660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iANsMx4FIDOGGjPROpcZ5vUHiPMe/CXnCTEcW1uDzxxDVYcoe2WQ++Wuh25LFogK8R6OpYB44JDhcZQEOLMhmgQDopIpzugjcRknWR7oPmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178
X-Mailman-Approved-At: Mon, 11 Nov 2024 03:23:18 +0100
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

