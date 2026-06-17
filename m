Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9077ACD98F3
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 05:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93CC98499C;
	Wed, 17 Jun 2026 07:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="izh9KQAG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E21C8499A; Wed, 17 Jun 2026 07:30:26 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50CDC84704
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwfmYA0Tmb5VXcXBERJZnYz6qzVb9FF24oBsIAiNq/GW487FpKIVmBVEgL6e2D2c70W/do56TKvuvC78F5xgxadpE+vJxNbjBmzJ2w+eIZll32fJrjWKV2DLWFlB2JAkD20/YAwzyckqKbq4e5ggGheCow8X4fBd2Z4cJ2z68I0qz7YhBEgRX4+0HqW3bp/9G9oPB61MXkh7N9PUdo6MDlkmQTXXMhyQzb20OpsKNb7wHrJSEb5kUs0o9XL8f/xFnJMwW1KyWZr1MGXujgbzYkD1j9N9d041Wyms/88HV1mOxPS+EEHSgpeSYayWKHT2iuBa+wNvQtAKImRzU62bKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=CavRS6MAMf1R5Qyvr4SMnKOQPYPr0htHPPmPbd4kvR5caaDlnlFk3MHquRcgV+jXNBdvKzzFqtyyVeyWEOnkRsYIFIOxQMO9xoUmBY3JkTv58VlhW15rCOMKf0ly9j/bGi3oANpkn1BCjOae44W7XyK36xhRlxNfArujkup2PxU2mvLA8JHHKNPo9Dn2d4pbg6UPilhFZP73yRooMjTtFegaXiaNH+4AvYnkrox4WAoPDTeWMcscVUNH+6knBra57LSxj4Vh3C6FmIUAMtPRmkNJBPPi1HxWiJ0VxolQpJixUg0IGk2Q+88UblU3jtc2HNPNVQAqd5spCJHztVD3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=izh9KQAGQIG8gGAPERQ1pn6715YkvP/ODSvx7zCxLP/0kEpogmmd9noxgUr8j1X0XDsDCQYxrDsuLR3S8a1yQGuN68i4ppfOJZmpqccltll7N8jEva+o4AppA4y5sorUK3dmj1RCtGxIvUocO/HGhkZSWdtTQkIpgFoRZd3sqtGlxD5P+0qvH11XXWo5L+fCACOpLbEPkfVAxWBXKUDfmz+A31mS1PxF5asI85X1fBSp2zBz3Iud4sVZxceEj4Ejj4wVddvZr4pruRATZ79QYgl2cMf2KWZBVxPI6XW1riJjZ+eUIIwrJxFLMd8xEA8d8TqQJk1J61rqtF23tjIwEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB10692.eurprd08.prod.outlook.com (2603:10a6:150:160::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 05:30:21 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Wed, 17 Jun 2026
 05:30:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v13 11/12] configs: airoha: en7523: enable pinctrl/gpio support
Date: Wed, 17 Jun 2026 08:29:47 +0300
Message-ID: <20260617052948.2815870-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB10692:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0f5fba-8ee8-4b02-5453-08decc318667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|52116014|1800799024|11063799006|56012099006|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: UbxW3H0DFqzpzGlwZOmido4839wQZhrIUu7+2xodlg8XZpn8M2Lwu9dDaEuo5xe+7+HkC9n0eX8hG1YFwfEz90C6pAea+P8OqEQ9yLKnpwMd3/4IOzt+ReOiZnQDgLMgS6qmAEc3Jo9HvIAfjKhao5Ia+16AhsZLo9NnLr1XvMQiHfsnvFQ911BjYgyP1JetwcXCzm4/MaxMo9Y3zl6VrIXxJz1WEr7NI1xKeW1+lhETI9kJ34R8eeUOtSepXsdHdj8hkF33K4Gz0f6hjP0j+L34NQKcyEw5kSO6rjxUHJ3tKscL4dokv4AiXqCWtWTdY0Vyv2FtQSNa4kwWTfecxvg01GQEmcw8YweXbP468JtRQNiluQRHW31rjCb7OAF+9hrxuJXDgTwu4KqaVz1P2TOv1ZY83/LR8YuNLKqsHyg9l2gG/hs+IacKDkitM31Z/wa+iC3YYmUGgCC68WaExLfG+mgyqIJVacILd1oGdMs4vJWopJtDV6zJfuAShjDz/2ZVhsXvBJd+SU6Frfk8AW0UHO22muJeWrGadhlrQIFearRUcOmeKdBrlOx2suMy94EDbC+UvrysXnGD85sufCv6sN+//rY9p9Hzi6XP3sSv8+GNEW645IpmhHwzkHvfkxRmmVhzOnYBJJdL0ZGtBgdwnkAe4D/iTDdk8ZOjr6xrp3xOl4gdNET8whpncc1m/MDt1Jz0ASB9PkuDZX87KKvE8zmmzJgyoA1dLvsznP/ycF6UlaTHqJDRw/qwxWQ8b333Is/YIVfy9u1qNSMChg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(52116014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7fEgu/L9kv/rZkJB0elLJUmrual5WdItbYdw7ezcgk7gnurtQtQngufM/WJj?=
 =?us-ascii?Q?K0hBKgD4+8aT404VfXcMmlSQs3Dn31+iOKyoVKMUBR0Ys3mSziJ1GA1RcpZ7?=
 =?us-ascii?Q?2Z7pt2Z8e294BprgmTIJ6Zp1rbuxFslYZCZ5lFE3qio1Z7BDL8H0orMcsDfP?=
 =?us-ascii?Q?msY1cdCrNKBYv+NJTFogfrvXfwXfqnq9B49KBSlxgS8uUV76BktzVsUHHcsE?=
 =?us-ascii?Q?PzZJyu7bUUXAVrk26IjivBspduYFeLDS+sptTF+elfSqtEajXe9aoXgUmtLE?=
 =?us-ascii?Q?c1+m6Zn4UI5s92ccA51VLh+g5Qk0z9xjaCLEasIv//+kk/kFYAmx600Id2bg?=
 =?us-ascii?Q?CtUEeF7nhYr6R3sX1CTEBjE9ohgM++8TikxFBGbeklfmWk6bk5SUU0Iz78+J?=
 =?us-ascii?Q?6/RdQThNHMmTzqJiehEdT4+kSdd8ftl9YgPbK5GIDSIhjaiCKl3nHGIuUzS3?=
 =?us-ascii?Q?P4Fhs1wAZ1GhWtCZWPOMdpd7m4HqfzyeqlAXcBUKAUSkyEF0FsO+LdTjGmEC?=
 =?us-ascii?Q?nuCTt1RiC/SoqMJt0v40Se6FHfLKYyp0WuWuPRDeWRbSrbf3K2mMhJB9mm1x?=
 =?us-ascii?Q?DbKzAlqSKn0KhZUDzmzTIo+ppGHE0kgRQhaaBLUxLbn39oGN+3GD+bJL+myF?=
 =?us-ascii?Q?jR7YWZjeQ4h2lasOEFyQau7z4ABseOfbSy+T7fcR7VQr1FrWLeZLahMzkWeq?=
 =?us-ascii?Q?Xgmmf5BoznL4xqfUgiUSoSjLoc5uD3r6ibLN46INaurdjAlnGNUpGXjXhYR4?=
 =?us-ascii?Q?D5+ejLueMU4XCtG5QVjqO+De57sSTPl3A9FknB4fXscZpwVEmxHdSQWAOCje?=
 =?us-ascii?Q?qv/W/P2/ji9vo9kiduDeCbhJlzcu2/bFNv82nohYeisW8hGRsvpNMTFlIoAS?=
 =?us-ascii?Q?w6r+GjLNOWJnpkthZzUA8w4ChFtr0q0k/2JkA3J5X3P+e2y+a3nx3uN9qgLm?=
 =?us-ascii?Q?WlWZFySiz0UDKL86RZcsKTBLB5VSfBmqnh8KmxNLD+qhAJqTDQmfWjKZvoJl?=
 =?us-ascii?Q?UmPRpxEpY0KXIq46BmpOTL1SAzFm7vfHVf2oOv5q393pJrSj/NSC+pU/1y9U?=
 =?us-ascii?Q?q7VbPXih6zn0cY2tx8iGN17vybIInZ0R8A7sfz0nP7H4LfOF7YFBKheGhkKw?=
 =?us-ascii?Q?QMROxixuLGt2m1MuU4DwO3dOQeyJTJDMNq0uiLITJhOn0s4li8sk2xAr9RGk?=
 =?us-ascii?Q?zCGY7mVBXI6kKULAqC65bfDGlsCJfx0JSWCooTWR2QJ482asmuADZnXyr+ma?=
 =?us-ascii?Q?nDuPYQr3YYCYad/u1cLM8hM0n5aToH7guFS0imw0wXiSqCnXYIkTo07NWeiS?=
 =?us-ascii?Q?5XZsOHZvWR38eOLR+PVlS5wXqjc2YDV+mUbWuHhaETCy0wZTnFzPTqpKQqOg?=
 =?us-ascii?Q?3ybZmU6sqOaN6PrB9xnX109P5Qxq3JxN3hKnDLHl0MPFElktPingMyexash2?=
 =?us-ascii?Q?1y0reWQ4M8kq7f0npGpIDZG0YVtTgxF2dTrgpSB/UCvib0jY5PVe7L/UnPTY?=
 =?us-ascii?Q?pb8lqzY/a15c/cQUrLYOTa/Xuo5ODf+tYCoYOC6nGa+JBXJAOq4Sxxenk7yk?=
 =?us-ascii?Q?Q+AOP2nFakPPBr0cc4LvEdYknNZ8Gf9YdTFvrK2TeLkuUO+QWkk2UZyhBA/X?=
 =?us-ascii?Q?TMEAyOXSELWSS3O+s93JQQ0OAX+lgSFQhrujoeth2UpGJ3nuAUblFDGmxIGk?=
 =?us-ascii?Q?aIzKfLnoHSoDpEkq6hLQOdA/bT+CrCbZMEAkAYD6+Q6TG4MK/l3sde/CYDmP?=
 =?us-ascii?Q?cc2t5sHB75xNPXtmGP+rBH3fcZJVx4U=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0f5fba-8ee8-4b02-5453-08decc318667
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 05:30:21.5905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKxac5Knjv+UZa1rgo5d/HhDxwX6uoPXH2oFonsPxgHDd6i3k7g6TUoZyEuuQcSyJM2rUbjOBEA6xpFpnlbGRv0dcWXGEFf1N8kvm1lv2Bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10692
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

