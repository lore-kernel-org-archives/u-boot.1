Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5951BFF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7535284669;
	Tue, 28 Apr 2026 17:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="H+NnJ1l1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB1E8426E; Tue, 28 Apr 2026 17:35:10 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23D0F8460E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 17:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riEun6wCxd4u9rbjSjyqETkzkA+ZPINGibZn+YVYi/lJ5EIzwDHNSCU3BsB8QtCjDkPfYZeB7EYzM2op/gi3JobtY+6F5Vf1ZR2TNHM9QcGXooDs0iXvKtxZAB0qvlGEHHNL/vqZjeWCCrqMVg3f1NfVwCYqJPogJrtzFGFy5SXDdW862xlQOdwTza7doAGamlcfI2o7aBGl+yILUpgM6JiEeH5OMWnPJ1N7eVAIVLQY6UVz8gIoWZiOUVsjDKZrwWjfrDSRcV0kX86KrUxQt5vR9HDGjtgBt3b1AnpAxNQ4S/KKZ5e/8sigWpEoc7pt2wxg8bypmkHC0PwOUnGe/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40rnhKXkantWnYIh07eJvw/Y3b2JQQBwqgrjANzV1vA=;
 b=lju7Pk2gMnEdjZj0E+ogbo8PzDZ2w9WjPboYSDTpjgczZDIOAzn6bSxA6/eybWNVLZ7RA30Fl6Po1IvhtzIJaEQQHkq9cWD7NR+hVJWZf0Pir9bq+N1B/M4W0HbQcYjvhGQjUQw0vmKpVfvuL4NLjmFavyijafe7T5ZPNxYGo5ZLwdkeiY7TL7WvneQzkgPORNGM38oe56kNF3Kj/Y9o6wprPovBjlgOiFeZCQ8LMnkk1z9jQD5oELukZRZf0Gr/hNeA0dkFhY7JovPzOapNM6WgwHUIZ/2oN3Si2yGoZYNNjuhiN2wl+hUh92Wwxpn52wuYRh5Q4+tnTK/CQgV13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40rnhKXkantWnYIh07eJvw/Y3b2JQQBwqgrjANzV1vA=;
 b=H+NnJ1l1Twv+8swbiXNapkosg4hNAD9unBIR779IRtSLq8DlC/VTfaRcpzcdbJayjDXj2mQ5EUcUnQzhkvinw4YvKVe7ThT6p6z2EcpLPHIvHgJsfgTUOigu2XoI8HdOv/TLMdPT5TT/8kzoAgdHsIhlY22sxjPXXw3qQaHAsDOiKwKSqXvxfMMg/JrPXVLowTdT0cAMCY4B4FkhnvK5T8eYk7ZqqI0tIGE+Bcn6jJDiKE6oE0lPGzmZBBTtuaE1eGohg+JYGt3DBPSr4JsFBQUq1SeOan6RtiEvYqZmFSc/hJe91EHpd4TzNOu1M25AWBCQO7n4wqwUmLPfkOzj5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8715.eurprd08.prod.outlook.com (2603:10a6:150:85::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 15:35:05 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 15:35:05 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Anis Chali <chalianis1@gmail.com>,
 u-boot@lists.denx.de, Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 David Lechner <dlechner@baylibre.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 6/6] configs: airoha: en7523: enable pinctrl/gpio support
Date: Tue, 28 Apr 2026 18:34:48 +0300
Message-ID: <20260428153448.980150-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fccb243-eee1-4258-bcec-08dea53bb867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 0iI+iYKRiKw/zptSHdXzz/EkZqZwLNu0dC96NZiz4XbVZeWg5AUI4xf3U09Pa3DqIxv0KNvU3skUoxBc5WEuRmdFPEsBbdxl4jQN69rXtpcKXsUMemw4GrE4VC7QAtMvLPn+llSbAct7CEBexCkXmFeGyBEwJbP/fRGbCjRitjTKriE55iuFrkEo4PlO2tA3+ePYm2oN3wv99sdmP4PohR780B2wbJyheksDYWGNw2tFUn8WU+IOMBcCAJBf+yrSuCiJ2yDqJyuEdDvGWUdUrGnkrbO5K+eBsh40B8nQc1sO9A2idclF1AqQ9K/DNwejwvNaNC3HZJTI/iy6ZGcbOAP2ryp+00APgg/b08iBGo/Ea5ltbiSG+fFt0UVr6Ys4XEGTOBqAzjZNHhKYW7qnqJERCdkqOYwkjyeC0P69nkgZUkVeAV+ul2K2Kdwdr9uXSa39Gd5cHVgqNUT2u7gW6qhMAtn9xfzPw2lbehwnN9CuIXubu+/UBVva6OX+fTwEK7gvnSmU15PqrG1yYmceX7I71KKahqCNTcH+3asQmrTvQBRRE+fvXjEFIn5ysh3EJr9SXjnryxI2B6xP3k3c/lIF03jFyA30zw8C6ayXo+I9hJ1MgiwBtyt7hYn/UVREWO2O4SKMghGmP5dvKUEL34SKNm91bT7gjUuL6ktE5TlpeeyAS1Y+jkG5BNJsxHO+/58CzYynRhztMzBHZNfc9pVd0bZZpGLqRUwh4mu0Va1jXc6QSnb5IY4i5IaqiZCMOO8jC3JuWVNyhRCb1oI3nPYbcDmB5739fRVOoI3ENWgAZCGtkBqU5Rka1WfdxG11
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZO/1wPKAh3iCBmKC4ohKDDoo9lMjJdl+ok60VZlqDTcg9EbS494Ikkm9Vwgi?=
 =?us-ascii?Q?ZM/x9ENnVdIY2Z8ZZv7dKxs86OFlsgDx13cCj5aHq2PJSpQ8dlh8Yxuhywgc?=
 =?us-ascii?Q?cO959Ya3AqA4x2IxqjUaVa6sqbsCoRNRrAg33V3JPMZhpg51ckk7VI2gJZn+?=
 =?us-ascii?Q?OHHZ2bpEdKWT/9apkCfwt5xVnIkHp8j4FyH51W3WfRNTcNejeHKHqfaWKqXT?=
 =?us-ascii?Q?Ghj1QjboIkWlD0PXfZwWEJZK5RM9vpEcpOzC/9ol2lvJHM7fvjKGgmg3dRE+?=
 =?us-ascii?Q?u2IvPYkN6oRP450zAXexziUTJOAGJIxJninhEmDoQsgEVgs4Or/FhYs3Gjg9?=
 =?us-ascii?Q?6PfboNtldf7attCU600hMndwoJQJEoCCZoMlcge47QWRgsccekN8PKZrTJkB?=
 =?us-ascii?Q?4iF+wU+DvEN9z3Ox9iJECe+Pgmc/mwE783rRnaxGCRAPyjn2mM5h7JgCZxWp?=
 =?us-ascii?Q?2+8+kHUdm89xSVZx05he93Fcwx7NT8d4l04W1jRLDMonZbN+rfrSTQjf4k5j?=
 =?us-ascii?Q?BotdemmHCezYA/Ur5E2d8KICaECZVGL4Iz8up3cl882/rg242GADhBTKfnR3?=
 =?us-ascii?Q?43RpKmTXIrE5QfGuJeZGcwT7spqGsOqLMztmxXp6FFIBc+lfDQ5NPhMdgaS7?=
 =?us-ascii?Q?HRafN4kPoVSaoy6y1RYGHgBAN3RRsN3O8jHpLJc9AqPyfD5J6tHOCiGN1qpY?=
 =?us-ascii?Q?LumHvHQkicARsMcEP9abdtSS7xH/PvinjMhjHMvcrBQhFgoi+x8DHEcZ9DU8?=
 =?us-ascii?Q?Zz2tp2x+ld6U+BAACcqPYMN4phIs8KOUxyPsUSK/Fsn1p7s+IQT/fqoMAJS9?=
 =?us-ascii?Q?oseANerY3IvrJPaSkJho+wqc7nH7SIRtGyUpT0N1XkA+ArHs/j1++wOsls7S?=
 =?us-ascii?Q?IcrCVcikMeXZmAe8a1pxloUpqxQSHYSZI+Ud6E9/MInlwOFq3Fe0bx1aflwx?=
 =?us-ascii?Q?o2a6QQsqPO2NDKIr/xKoiSIYkwsFfbdP8rNfyMjZSFpKSpXkBJz2ILRpxfEv?=
 =?us-ascii?Q?xh+uyTK/yG3fFpS/McmAhLxP/8VyoIHlaZ1F/H5LxdSH3fvfBD003B9OMJB/?=
 =?us-ascii?Q?bg3NftdZSf91mGfbE49WJOxLcjfzvNUJo/atNkhVCrpDBbXclRlj8FcgfqQN?=
 =?us-ascii?Q?GczrSJELaplzodfpIZzIAbMeQGeuQsmsf7/6SZnDL0bEv0fQ3rYrb8h3Xfre?=
 =?us-ascii?Q?bNM9Y5Ho+pKGRDeAPKPifaQfzRxiQbmMCFAG0xXK1wQWDIqivkWtD+tzcRhY?=
 =?us-ascii?Q?EoGfi6BDctwkjwbsYRNw2sdW91F5nuExdEuojuoqOSsk9P66G40OLMV8cJPT?=
 =?us-ascii?Q?HpCWwGIXL//1xQwasslVHLagjhoCfk0NT7eV3mfiXxRMuyqoHDhq+iBvGSzP?=
 =?us-ascii?Q?N9lJvvf/QxyuebYdCTtFQlNfN8c+AIyeh4f/ha2MVEREu47HpsuGdZ2LjUjz?=
 =?us-ascii?Q?+DOu08uv5bUMr95u07rZdoakRpmGe3EhmmF2D407Qm6T3nbTk4DW2dkUmaua?=
 =?us-ascii?Q?BcpMZPqUGnPj7WiEEMuBriFebyM26yzL2D+Pjfcf9JZMttN2wix46xlgdJbe?=
 =?us-ascii?Q?ux05mcdTiVfjesvKIrLYpp+eg/TtPN291kr7cq5wKSdjSH1JL9Jea/cO/ZGD?=
 =?us-ascii?Q?nqGmKnyE3tsSpU/ScxLbDsGuQlR9JNCwWHbYgVs1W3N+kptWQ4GO0sS7Ss9N?=
 =?us-ascii?Q?nSmtGceHDV4cmceHj6Bsgb4s5koBqPmj//ZR/hyhkDTMdFd3E620yWbrQwv4?=
 =?us-ascii?Q?I4MNDvICucihT6d0bRgpQbK9FJrSxz0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fccb243-eee1-4258-bcec-08dea53bb867
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 15:35:05.0503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5K5gaZldaz9wrtPgAD+OEixphD/Gty6iUxyNCJg2+Gu1+fzg2lD23pmx84LrTJuDhia06fZ36NALuTgZCPZAdPYanGRRn5NdYAGt3mi4IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8715
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

This enables EN7523 pin controller and gpio driver.

This patch also removes existing gpio nodes and replaces them
with pinctrl node. It should not be very dangerous, because:
 * No official EN7523 gpio support present in U-Boot
 * The same driver is planned for upstream linux/openwrt

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/en7523-u-boot.dtsi | 21 +++++++++++++++++++++
 configs/en7523_evb_defconfig    |  1 +
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index 62d1a724678..3bd78b373a3 100644
--- a/arch/arm/dts/en7523-u-boot.dtsi
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -2,6 +2,9 @@
 
 #include <dt-bindings/reset/airoha,en7523-reset.h>
 
+/delete-node/ &gpio0;
+/delete-node/ &gpio1;
+
 / {
 	reserved-memory {
 		#address-cells = <1>;
@@ -22,6 +25,24 @@
 		#reset-cells = <1>;
 	};
 
+	system-controller@1fbf0200 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x1fbf0200 0xc0>;
+
+		en7523_pinctrl: pinctrl {
+			compatible = "airoha,en7523-pinctrl", "airoha,airoha-pinctrl";
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	eth: ethernet@1fb50000 {
 		compatible = "airoha,en7523-eth";
 		reg = <0x1fb50000 0x2600>,
diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index 381d5d05616..e8433c7da12 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -56,6 +56,7 @@ CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_EN7523=y
 CONFIG_RAM=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
-- 
2.53.0

