Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A3ECD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 19:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B36F2848F5;
	Mon,  1 Jun 2026 21:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="DfElJzkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F39584958; Mon,  1 Jun 2026 21:53:44 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A53C08493E
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 21:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpcCab8eoscKV7TSZkNz1vu+t3vfGM0A9MIO4z0sqqNRqChXoBhFECilkBJ76I6dyOTKZWyjnicOPmOQTffy6f62Dsc8ylM+Q1+q/i0twcj0oQb1URudgYK0Qp7dvp+wVOdLD5+bx8ndN1WI94qaM7XNHMmbc1JSyBAXWuoY29LJ4tv3W+4EC9oqMeQ/MCNVgVZmlSOQbs7+A5nhzWpY0g03YXfFE8W2D+iT2m4+fTTtBHoiX1B3GQTQVKCQbVGCivg8CJJEmq6iLShCY7fZHMfNpzjwt7YIKnertwHxJ5c4JCBVbXq0/xaJC2p/xCggx3LzFxyIJuxObeyKCvFCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=tPngBOk1C+dL6eDTIP1Jek65mW5+MTAtZre4j4s/oS7M4O/3ERqPZTfRy4oibd//LDqDflPyIy0G/wl6b4tNHF7KyhnRlWJMTqgSgCAst0Abfcf4PQHc9FeKFCoaEqH5RAn+UNCtQMs78ZN2fmW0JqcT+6zFI6NDaN4tcrLsJYLOfXFBedpwh9A3pWpUCSGAwVNkj3PrNjOGedPz5IFXBPttBMOe4/+VOuE8UcB0DESX1fYPaTzcNWwddQNIPd2OzAtBkc+wDpLmFq+x1lk6mNn8GnZzKo6UJrMedwiIv2VD0ZvnL7I0rsBF6f3DOFfjVb7UjOiybjmPEsuzjbCmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=DfElJzkbPaXvQ4OC6/0H6UH9FYhjy4QgPyvD+DHPTGNz+WipzzrIyoY+3XouswclqXd0mKrkj34lpx4CyoGZKhAj2EKHx0MBTHZisn6qE08+5E/ixdkpwJvfAWLvLsRRMbM0HFCqD/+G3BN0+BOPKpzQUwd4mLMc2VWiQqLVX/NNXAHzvB+wCKxTM+E6RcZFsZejQgV2IOO+hanDGSiDvdKYC6RJE3CTNUDVg7eIzWMURaMcTIsQ/cxw+1cncecWGaSUXOeANNRP3ZGhtjsZyRABm31qlUmIKqj3a2Ec9Du4ptGwZxIQndUNFQUZC1kwSgkxJZQkWxCotvvxgAGSQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 19:53:41 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 19:53:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Anis Chali <chalianis1@gmail.com>,
 Yao Zi <me@ziyao.cc>, Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v11 11/12] configs: airoha: en7523: enable pinctrl/gpio support
Date: Mon,  1 Jun 2026 22:53:10 +0300
Message-ID: <20260601195311.2390473-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 85847e72-48c3-4901-4caf-08dec0177ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: L/9K6QnAxBy3euFcVH2OjXMDICedHrdYaTcaF4xK6I+q59ERtO7XZLQBz0W+qxWWqtIzHpwxLceZALFUldy+klOVRjvtl1yUQvGOvT3Zqc1KALeiPs1OKwMRIByC9mkF0diNr3b3EFRG2cvdjUpcfkdJOkBUqXDydMkhw8/Xne2ZFBXXOMTHWQ7pJ4xgFjF9PaBlinqzA/1VoZpK3Dwk6PierKWiyppr9mG/fI1hoBvm+9DH3NDsAsZaFY/2haofJ6+Q6qCZjNktbeuGwR4menPBHJ4yWeeWC5YeKKz4AnVkyOLv4iVHuVHiVbkGFdHZiIBV96keNnIK8nQk7/au8TcSc986aW5w6eTdttxTPddikwYeZZLQykuAb7+K6SRIYBVkuBR8Tq4BLKlBF8H6F4TNPmqgVA02QpLiGHlJbWHRCAEPiWJZ0kvI/UiktR/2QoMzuDG6ZkfNinBMLiRyzRufCQ7eW2e7dvDxjgKHRBC87rk8Fw2NOd0rxbHdtRwwLkkmL9L8TRDgH1tW59xz6AId+8M9oLsOP1kGeM2q9nsYxGpk21Y4AtlDRzPgC4ETBH2gyBjjEkodVYqGQLZw/+3UTZP+MysESlWC/EB7/r3UARxZ4DSMd4bx8tu8OF/zQvklvkRbyq+w1zfof216vJ3gNfASjZKeHTOvk8Gv2Il5kf2i7EQ2h81FYEO03J4dyzksu8z3mKUItmnx6NXtY/IQdWfcZYbYiPyuupeqvLFk80o3GpcI1NaLrv/BIwCB8/H6urz2K19voRDQCRvISg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IptF3ggLxA1nWzdo/4UpX5Z7MLJ7VqX/90pCjuczmefKS82hhzuHJ7eOO+wX?=
 =?us-ascii?Q?K6SFHJ5z8cA2jhd5KXqBfJ6sNDwS72A3DKJbG5RIFOS3J6h2G4tArNnXtj+d?=
 =?us-ascii?Q?ibVsUmeOGbl+gvpf1RVeDyzyHrrDftNLWlz1Rr+mpqJ9iT1IUG9ZcWZ+/Jjn?=
 =?us-ascii?Q?76st8+LmoFOuFnbANGCDAUSTuuX10WlhxnrHwBWf/Ft+45TEmuXSr1sK7Rou?=
 =?us-ascii?Q?kJxrRCmFRmXXnkN5AHxtJdcweFxwPP9fOesiNwRuV9DRHMnGlTlkEDcajSdS?=
 =?us-ascii?Q?/u9dHOuuIBUYFc5SkaiKv2phd6A3GWdLBo3qmvKaYJhzNb+1V99vdAC/+DiW?=
 =?us-ascii?Q?JWE+V0kCLGTfojewnlO+Y7MyLOf1T+AJbFcM5A6S/CtNz+/t2fzBeNpZBifV?=
 =?us-ascii?Q?bQ7qfRQ8iSCyvzeEiT0zDu+HxyyWo0fl6WCxMN+lYQykzhQ40gg1g5e4Yj1g?=
 =?us-ascii?Q?JtnEyfAJHuyVhFNsHjgCY9xn6RnlHOCMHQKru0K1QINSz2ul4l6A1tRi/AzF?=
 =?us-ascii?Q?lHoGcVy7TOhnDbdsoICLJcFeFcyYTYV8v76ZnihgpncIrmuBcc8N1sLdV1fJ?=
 =?us-ascii?Q?ZkaBjGJy8Ty34/4s+YKy3EZtRRm/YEVrcZ95AYMcsTEsfiJCDDdjsu69zJ5Z?=
 =?us-ascii?Q?YQYoZRSsJX3uCi5/lc2u0FnU3cutq32D4Aa6fKDwhLuYbGx+o3vEU+btRE3g?=
 =?us-ascii?Q?XKTHGEayxlKNxp0TccHSmQzIhl2vMei6/P620EU3K6IGTnsnCmtj9xa3chKX?=
 =?us-ascii?Q?d5gsIctZajvgk5vPRztlblixrjA0vXVZUkfUJpX+fN5fyAdp9geSo1IdaJ9/?=
 =?us-ascii?Q?mvvmX4YpQqCozryximwdzcqSMsfoX+nGYPUZ07+vkw1c6Xzrf6Kg8WyVaUjz?=
 =?us-ascii?Q?PU7bmRgSqinjNTaL3EKUCX7pKdCmlVaYIegXcmd0zWBb6PD62WhE6Deh8plN?=
 =?us-ascii?Q?u0/bRYH/AwsN4oAz3wai2IT5kxc/IJfT7S+fQDqiG8TStSAGbdLkulRr+Xsw?=
 =?us-ascii?Q?G+7xQZgKTcYMz+tI+R1PiKvt49/Javd03572a1VTMsmt7rKLlpGmNephk0PH?=
 =?us-ascii?Q?QD6Vk47sQ7rMT9cafbIhE9B3eoBlRekRZo2bxvldp4HgnqZdb2360Pgm4RlW?=
 =?us-ascii?Q?YBnvvbLb17mMcI7/8HA0vRhRMSCZF70quGXMsJJJTd2DzQXI71XJ6s1//VlA?=
 =?us-ascii?Q?2EfGRoh62fg//nK2JPM8PHIwYC4JlL+slDB7lyLsi9h0j5HjT4/JP9jJnjt4?=
 =?us-ascii?Q?zGRxRzQEktcYANgaeKXzKHYdyv+8/9Tx715T2UJOORToGbL9ETFkBPm4Ogep?=
 =?us-ascii?Q?xqNX8rg7P4kv8az5ZM7btAuA6HC76StoXbny3tqMRhc8TYxGfSXUOo2YoEcb?=
 =?us-ascii?Q?gN1GOvhaBrmmKL23YG76122H/ey8kMm6yuTv2Je6zjL8/ZhPa+VCwkdswBVY?=
 =?us-ascii?Q?2cMg6nmViVa2QhpQHUR149TAznOGJXoVUX76eaCE6AETci8TX/2EX9+c43MZ?=
 =?us-ascii?Q?aobkDMBml9V8Sm6XtU3OYJYcLNqn+jLvTf63qzVFBK/hXc/wMnJF78KpwuaV?=
 =?us-ascii?Q?qQ8l18Te0MHWqFWRZ7WCMqhXWjhEP3LDCAzVJK4H/QRL1EFJ76LFY23NjRtv?=
 =?us-ascii?Q?W6RMdYJx4O1BFhbqDMVSlPlTIp/SqwhXFkLyDe9M6YNod2ye9YZmlcB8iQVT?=
 =?us-ascii?Q?dNdkfJu1MH8YhebM82INSdHGPA8k3Obv6p3+YTith20/0F/VSy/nfzJV66Nj?=
 =?us-ascii?Q?soU6c7jeSJ0Cx5xIb4JMTeLTK4B1A+Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 85847e72-48c3-4901-4caf-08dec0177ac1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 19:53:41.1534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck47ZarPxAbxe7Gmwpz1Qe2KeQfUychjUbrmWXyomW1NWmw8E4SaVzEgSSu3fHA7humPxSH/OoXiDuZEF0eeTxfXdTApe7K64FsR+6yvGLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
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

