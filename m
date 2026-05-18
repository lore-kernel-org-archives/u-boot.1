Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1562BCD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 23:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942F5847F6;
	Tue, 19 May 2026 01:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="igorgUMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB825847C8; Tue, 19 May 2026 01:51:47 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C88847E8
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 01:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0IohZsuiyNLDOhhNkqGqKMspFFWQxi6bTxcrNClXy1GtLkuRFvlz7UJ93yBhLnRuznyj5QWXkcuuFSiHPbJp1F6A6WKWUfji7GiDTxm3sdVGeB/q3KpxKiTIgS8Ex4Y8WC70pbvbkyXqglBFQ1XpSLHFgZONZGuK6aLu8noYjvAk2ePNs8URPX/VpVcmykiYUCpUzrvmwdwHxZGJhAChA0hTsqrUZMfSeNxR9SSn/bgM0BW2d2bJN2ryFmoMnByle2MEjsW9MAltJdOT47oBxykuAdmTtAaKTcZNizlByqnBh1WjmGsOpR+GYyNskBvmhh6Yge+eLAMOhUJP0px9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=L1oP24xmdOgUOj680niUIkowNXWidFbC/v0ln3XNikLpU31tFl6gEFQDpbFRrpMJWRlQLm0tDY5LcxQQvGKm85rESM21jGFP5IlIM1CQBwpGQGNnoSwBpAj/CH4pndcsOMuhFnpydsel7RNr5pCnSxR81ZM3THgNww3YK8uCqHmftuGfoR8CC5Qi0wTXl61Fb+gxoCn0Y/Eqm5pMQWW1Ft3MER4GGUyjaYLXbIA4LA8TaBgFqFKZXkl7vRiVG04Ikz1xbflwXYiEPwqeG2tfsUboePfkBsB4fmNoIvyD7UPfD8FqnXKPKJiEWGXneMcaO32/2ODXnTJZXVzwusOvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=igorgUMZw15SgRV7b2lXBrNwX4EEs7QW1vGDLHsPOBhOuSmIeROdb+S67AicCFbMpiV8zA9JF2Eq4wmmYYCPLlk2Kp0sUWaDsYdJ75k9jfJnVd9EQ81v4USocw0H7MkfjfsXY4nvERKyPOM1/V5OPZ+CCZSdGYxsNt3ARa2Hm4d50lHlsSaPjX9cRGkX24u6JHGkgoX5iuHCBv8xWuAmVyd65qYtdLxxj1Go558iPr7vLEs63ptTFfFb2qnEhtKSu85BnSNZ8LKvwzZn9/q+6mUXnv3hbhg2jIMy4xjNlgZiFI/TSdYZk62dOSr3jcDbOxpOWGi60Ts0L+FzQ7+tMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PR3PR08MB5802.eurprd08.prod.outlook.com (2603:10a6:102:8a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 23:51:43 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 23:51:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Dan Carpenter <dan.carpenter@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v8 11/12] configs: airoha: en7523: enable pinctrl/gpio support
Date: Tue, 19 May 2026 02:51:14 +0300
Message-ID: <20260518235116.2664557-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PR3PR08MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: f7390401-e322-4cb5-bbb4-08deb53869b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|18002099003|22082099003|56012099003|38350700014|921020|11063799003;
X-Microsoft-Antispam-Message-Info: P3vj7LO1t3sFWLvl+lVHqXtmz2GslgPDbajDyfK3qgzZ6vFl/CS3pWxyeKFsxCUsWYjDBymF286G5bAMQ0Vf/irxkUx+ttNnGQaqdW6cL8Or9D99PljjVwcOFLPSVzrke5aprtA+Wbi6R7Ps7Gg141Me7wDzFPaUAK4sCHXwN0dArvk2wiu6cyedtY7360avosKqo9ZHXEam3U7qUxsHewfg6CdrShHq5vJs88Hp3rD57w6v8rraxBrG++OkAIkOUKsyEV1bKtA7KV9GR7yex+2wDUZyxynOcFh0uL4WYDYnJscM1GQqFvk9ea/y7kGLVJ3BPtOmKzbXFgD19cG5t4ZCrGrclfwKGWQL6iqK/wd7vRkiIYBGzt4TpfLrQLmMNI3qoUyB/gfJ3wa/Mh3sg77+F+GgPxcwNpMw+vKBNw1EEBbM0IV1+1H4yRT9lGlk5F70XxmcEVBHUbEhQuBT9tCU6ff80KFo5UQra6TuFR9pOIN40fhR2f4efYMCAjLeVXVrWzcH8E51A1U/k5ISw2vxfNY/1xvHxa+QFYG+Ki0PTm+ihuvNkCajq6mkLXAA1ZyIQYtul+bXBdz3rYr4Vt9rEvqlKGOGzdumIXMrn/gXYQHe1OB6AFBjm7J0odh520XxX8Tnu8Y4Lj+qsuMWDsRpcjY8shvqF5Jo6RnnorI17nqFqqqV6OquTRrx8ukguXrq3spPE+0mcmneBs4ntoVxVLCooyVBn98emv1c9UNI/5NYzh6wDoDEhUW2c66tyyOHLgKsaW/t8SIdOssLAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(18002099003)(22082099003)(56012099003)(38350700014)(921020)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zD8457Jao9mV1AqGuV6ehQEEOfvM9VygHBvajcMYfPCmzaK3zEJYi1nNqgFi?=
 =?us-ascii?Q?KJGYEFWahGHPJtyps4JLN2XP7THOJVBeZyLu90mUtMi1L9gJ8qu1ebAZK0kp?=
 =?us-ascii?Q?+G8T3MjVnLvdpplfh06pLsdd3C9ig+IPih+vseyf69GZM0gvD0u0b3rqbFDP?=
 =?us-ascii?Q?9znOUVNaBsxoQSkKTSfHA4yVim2Ffee6sltUNEAfFok/3/aj9h/D6KrDXIsq?=
 =?us-ascii?Q?6nv7iwEb1vecmFhTauJmmm5+4rG/C/gdygHiOtyir4pBxZ5HMi5LD7o16cX6?=
 =?us-ascii?Q?CeRuoF+b5nYfL07NUn+dJl8IFcrpzKXkJVVcj3V4qH3IpCQ5ng/3oVgyPBQd?=
 =?us-ascii?Q?AFWZVxbC4W+mk3AVlxR3WE5+5LM9XmLZWvkN9K2FVAQmcZVC/QUVoofWpGuw?=
 =?us-ascii?Q?M+Kf+vFbJSMEcpuLmEIdGHnB5pGoVXUB1XwvIAk44a33jBYtfMwsSSUJsc7V?=
 =?us-ascii?Q?aYQ53EbBruX8XVic1kYSJfttD3Wa3Sfk1go3egUPTpvMBhPxO8igDYlr4kxi?=
 =?us-ascii?Q?cGfZCuejDXaqkE6fMJUs1EbledcNTE8gTeDlph3F3JbrKLwlZc7dEjuU+a0t?=
 =?us-ascii?Q?FUgTLsneLRvwghzEJpFD8gUfwmmJ7xR5QjzlBMqyYWDM5kZJYRbpQM4fiBnJ?=
 =?us-ascii?Q?9wyHwokwohIyDMSGS/bKeSqWdZuhqrRbjeTLHnjqinO0rFwVnM4mNkUelDli?=
 =?us-ascii?Q?LcgOgIlXPxeACLB+4MvPVNH1G798c5j6pZBvZB+FrZx5MjXaoxJSq7vlZjEr?=
 =?us-ascii?Q?19zfI3PkyeyZuRBDyr2AQtscvM20wsYYT8zRMXoxWR/W+CUUbbLHQiN9wygA?=
 =?us-ascii?Q?BuJpGCykLci2nhQ3bG/sjO09wwVSDnul8Qvg7BJPF5AMF3srwXw65XbwtuMA?=
 =?us-ascii?Q?dLwJS/AiXBGhZAK+SlkxfLlvcPVz1JICvxl7gy4xQuPYrsPyGkedHquoADJp?=
 =?us-ascii?Q?fBzoUseqVeeEsXpfkeexHSgWiNoQf1Jpf2hPrwbkw2y413xxwx/bjkG+y0pP?=
 =?us-ascii?Q?5zaORU+eZYS24jsYVzCa3kCihNibF8lrkCQc9DSExbDyw3yLSjoQB5weyrVu?=
 =?us-ascii?Q?0Pc8813AvQNPvKyF1WXdx9/nQiKIIyfcBDjQjAHyRRQx5ddrEZzKPcTzcR9s?=
 =?us-ascii?Q?SW1wgw6oR5oL3HqHpMJLZsrXFKflVlw295Euj4xgVQkmcp3UbKfGAk01ELc/?=
 =?us-ascii?Q?C6KlystByZ/BuN672P7GcpQj2N83y3eiYwS8Y5Jhr6ogLYOY1dvSpb+AOwsE?=
 =?us-ascii?Q?FRCp809OHdqhCSbb67Q9GWskIYWB9IvAOm+N4NTCtEoDslZ3RCJe+sZEe2uh?=
 =?us-ascii?Q?tOAxb8y8kJ4K6ziIe4oKn0lx9NvqSyIE5YBeENyWjbGst8fZe7nliu06/t9o?=
 =?us-ascii?Q?YE8QkAo2ayrwj62guWK62zrNVRnt476k/fCoG8uwJDEI6Ve9AJC4pzS8P0Ek?=
 =?us-ascii?Q?DvaQeUv/KgIroqTHj2iwnezC9yJxftA4CBC2j1BhhwQ4faYuLLmu6L3mbpI1?=
 =?us-ascii?Q?D9UUPit4gyGwspGT8yumOzpSkjQsq9vZlJVtUahiTuAWV4dLC1AZVdsptSmn?=
 =?us-ascii?Q?01LnQe8DQtLX6OSFfWPIN9OE+ssyjaFmXww6D1ad0fk7yYyDwrustmSQqVCu?=
 =?us-ascii?Q?KQ1XevbGXsCaCVwaEVXLjNXCkeDcw15g3xSguKRufxqmvCwSmoQp5kBiAkvq?=
 =?us-ascii?Q?Y8ZNEgpDQC3CrW5Jt/c+1p2X88g6DdZwTWAaG6s89YXnhMjSXun3wPyIv5q+?=
 =?us-ascii?Q?zVAV2ZsJFobJbGMI1BOYrYawsRXDxtI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f7390401-e322-4cb5-bbb4-08deb53869b9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 23:51:43.0683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cio2+sb2Rd5duXBxV5agxqWhm2VX6KlN7vzKLqeJPanb3bn6HvaBOjKoKK18sx99miONpEC9DeTKhI4xASSr35cQkJDiKfRmrs5ArC9kIak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5802
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
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 configs/en7523_evb_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index d3137a0ae44..8b1f3c71e9b 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -54,7 +54,7 @@ CONFIG_DM_MDIO=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_EN7523=y
 CONFIG_RAM=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
-- 
2.53.0

