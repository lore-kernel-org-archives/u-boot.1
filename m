Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8D5CD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 05:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D598491C;
	Tue, 16 Jun 2026 07:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="5uXlDvaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA7908494B; Tue, 16 Jun 2026 07:31:39 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BF98493A
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGKpPklcBLnLCTCZ4Mmo5/JDKjwa84naArHWyPkn6Vamwsgn6qg3CnKwp005MTTgVSK7rsrjWpqpKqkmNzD09wUwIMwHyod9lwrN2gq6Erbo2Efb60n8hD5C/EfAB0uuzXXavVyVaYeaXdk9/TzYSKaARngwIst8oeJllV9MfC4jLuUNPNo0bC2Gp3SNMMmu2ndTg4adeesuduaqAWjRoGbz7D5vzKHczWyYAsvI2wY4gqeQro+Pq0BjDPvv3eRnwoZSHTWRhpyXGE5AbCoEhz035g00IfJNMqTpd7H3t8LBCUz+P56PjskZCk+yFHk0Q3tXl3gfoWx3MFFCfrGJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=V0p5JFA3ZV30yjywzl0CHByzuzfzo+eMPOKM2nGLBXNFqoYAmYIn0QhUMh/mUMpszV6rlk4KFcZP0GRp/teaUMbrOdacpyruDpuYdCs35dkZQ7l7Y8GOvQzM6CI8eQ9oPjIQff/0/I5724qmZHxzEJb8S7qhKPUYAfBqKDz26a1uHfa2rEX3nQ6v8Kl6ytSk6/IhlVl4c0qx0O4IFeztyKOsAD5Zv28DajUKdCGUs6PtSJuxFM+p1nAt/ryDHEZrWgdFaYMdwgsrBXYcXKOWu0W70GvbyYPRSMPxng37aBK4v1EY+Jrm9uSBCauIx5butsBMSdrO3501O0YGWOEvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=5uXlDvaaZAg5tFWIk9bnLGfRPsEuLhJnItqZNwVTOn/f53D+MxNmKJW+vDppnfJc0D3cnsyGRAMhmfSPmTHeKwIWHv7IfCw66vgSObwMZ7XqRIhhv0RLr3vZ8TMBA9K0L7EvTextcyBUGjmWe9Uviz1Op5fmxwF0fq7ne9YRE0ywY3pCgdHYzEEq1YEHvrC9dsk3dfhPx9XJluX/sXon0NGsv+74tWBy/uRAmU8vQ+oDhjtOIH6ol9H3nzszlMQw9Bm2aaZDhiRlsy/446tEJIkPbNxbcCOxx6gSzD3RoRhdLuJcKwIUa0rtO8CKETVOAiLFwh/BKkNZNIxvLwM4mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU2PR08MB10160.eurprd08.prod.outlook.com (2603:10a6:10:496::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Tue, 16 Jun
 2026 05:31:35 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Tue, 16 Jun 2026
 05:31:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v12 10/12] configs: airoha: an7581: enable pinctrl/gpio support
Date: Tue, 16 Jun 2026 08:31:04 +0300
Message-ID: <20260616053106.2623475-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU2PR08MB10160:EE_
X-MS-Office365-Filtering-Correlation-Id: e210251b-e8a0-47fa-869c-08decb688775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|7416014|52116014|22082099003|18002099003|38350700014|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 9D3vhfv7lM0B5Wm9ok0NVXoMzDktclarLrhZ6o29Axme7cekm5DHmQzDC9UKUQvcKhNX7rKdmrRh1JfkOvfLkolGi6lNFEqiCrJp2/5Z2nN2EN/H2mr7wcTC/vYH+FPs8lJbpNXg3Xf/W/EGGpqb+B1EmNH6VBGcguNfbG6964RMDIzz8e9wR0rQrx+XlefgOHon6oEhTRwhSzf6sj5c0d92IjEtLzRUjUl523j6Rvs3p2JCNU0fhXOEkcP0AAGydDiSPFRezjWMeX0aV1Cs+pp0np/RK/UWnhupYQ54kkNW8oSzk29RRDFzhy+c3yJc9amOTdQypdCHyFRUJcqmjcJZuIzFUdFe8KNnkItpGhbDO5EDA1LxSBZ4bWrxqfre+uvgnNbLDtxAzuhQfePYNDqYbnY+Q65aFN1Htjpl7CJ8tSfFfxOMk2le5ZLWt95Fge0oeuzHijjSlXshH0w28blwwkYbU8tK98jCiVfq2kKTcDI5Hal0D5Ar22p797cQuSbt4QA/KRZu9koG8sG1Q3J1+wlmXgpjdruaw72jUQ8z7TObrcdJ1NoziUi6b0nlwNq+v2WQlYVSGdJQ1xzPTfIFtlno+3WN+ioNd/Z05LYfxo7gUppaulT8b4C5lt/ncKx6vHfO74m+e6LWBwc2yQWBMda4a365kAEBYkBf9OvicoQNbSJfnWe0yi5RvwcAIuxUiwTjBgL6XD1bAfe86VFaXlNsOAqj71ulCggjBt5n46CA9gk4Bz3dUZYhAlv88Su77tv+hlVOYM1MBArPog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(52116014)(22082099003)(18002099003)(38350700014)(921020)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oIXegVNzfBt1da3o34HDYAM6cVOzTncVExwhDKxk9qKR0N43AuT0Ksxk5oJ3?=
 =?us-ascii?Q?1k/CsySdqE7LivthSf8XdE8Pg2retKg/pF/Gq+wat/p2QlY6zhdbj1rwRMTM?=
 =?us-ascii?Q?BbtjXZNIEln7YOYbyhwym/V94C/75ciXvb2UbRdOjJnn5OVjRAqHIPWfGJIl?=
 =?us-ascii?Q?fG8pIQC/QQW5kNuv+ws8e48yB1I+V4pC/E75pclg2FAjIa2nb1H9KT2vkWHu?=
 =?us-ascii?Q?OJQHQQb1A2LEJcvqSzWols2QHhRS46/+nPT/9yUXKJh4l7KyDSwQ+RzGo8WS?=
 =?us-ascii?Q?wVmFEN11FFtP6sROhvjVuxSttlBMeH5KjA6qEbwr/8QPVrFxUkw6uYdYEphL?=
 =?us-ascii?Q?Sit15zsJiVl3FHWN7z7EBGUO25jMm3tBzEIIDa3X/NKFDkMkglDkOSMEG+P6?=
 =?us-ascii?Q?tMELSFLqN62TRitutuvgGZqGwhDyAZLEv2gEvj4Rl659soYioIqpWiqqxZXm?=
 =?us-ascii?Q?Q+L3CoozxUUQ5vGwRQtSv2vhCjISEQ+lYnNy+Kd5IYZiE+43CHpz1ANrCCV6?=
 =?us-ascii?Q?/UePaS+seqzdBLWuFIoHS5guzY4qFJYF8HknG9JiGlJIob/UkaDPPoOmxh2D?=
 =?us-ascii?Q?BvMClwh/8AHIOCo+UV+qrrMqpMu48k6kiugb6icw/4tYvz/oE0Gsus5D7NZV?=
 =?us-ascii?Q?aGiBEWdLNfDpKCpD8kSGefaNlfwJIfmIwcoi5pl/7Pb1T+Qj2fraZuSbIwwi?=
 =?us-ascii?Q?/Ycm5jRlfEyBAi67tPCdeKHAYhcJiJukERFKiX1Bhz/3vua1EM/Q3QJb/Ftp?=
 =?us-ascii?Q?asFUjBcTvuu8iXFEg2vO31XFKELWuXDzDkGcTqPcrtvggXjd9Wtp2REHj5/n?=
 =?us-ascii?Q?uWdiIoW9A/EV0RdMYIKtxDepXF9QdG52Lgq94e68kszHaOEZhtgntnQ0vjhY?=
 =?us-ascii?Q?aqwMaXeg2zBK5HZsA2l1sH6tgyK8zhWGOw+W9WtD9NGqAnl9Qagf0/8Ker/W?=
 =?us-ascii?Q?3NmJs1P+YdpnLc0oO6ag39oBrIGN0LVmokgCOZlc7RhTnGdI2tX94mnxSruO?=
 =?us-ascii?Q?7uVQt9rH1p1APJqufKtl77kEC5wW9IDHviVNETJOEGXOvTR3yQ3p/FpegqrE?=
 =?us-ascii?Q?ww589tziqiAgd1YoE3gc47ff+njE0Xinbij54SE0UWDiVEJvtBj7w4kMD0lb?=
 =?us-ascii?Q?/qSMmJfrfSCS+YGzTPGIVnp99xbn65pVQuKvX0B4fsh7PrW2w6npzXLggUNG?=
 =?us-ascii?Q?ZCuESBp0LAuAxZlz8uKi/nYv+qyA6gmZsuUMx92j+H38KNnGo3Lbgy7ypWVV?=
 =?us-ascii?Q?74MBxhRAh0kExHObK9xzyma30u0SJI4WqYa0QPqxqFa85kDt+NmT8xnPBc5m?=
 =?us-ascii?Q?/LHsd8ZWJ2IWYq5GSiLK0dT0D9Udi3lH0NrqZqN7Vfwju5mrnFtVDgAp90jV?=
 =?us-ascii?Q?I47y0PzxZy+nLYdN4VIY71EJ7KpYOzSqBhAyTegOeiHU8m9RDp1IdYf5s4ol?=
 =?us-ascii?Q?A4UrwKnEuLDg5XX0goZ1HoKrHCi6KtvmoUG+2QFc3OBRnYcCBWbOE9l82lbS?=
 =?us-ascii?Q?K7S9rvk6WB/rLzmu7rOgMkSrsV1WFEu0Mr2P+BnYfGY9yLuAq77lPOCPBnwX?=
 =?us-ascii?Q?S6+82Eav6q0TAwB18sPOktojg+Ybh3/9w0b63r92/jqTeBwXBRLYw3YNTTe9?=
 =?us-ascii?Q?5Q0Z8NJ+cNYmW70bxvfPkzbQvyoMYhuF9nvjv/ou36pyKyZUxBjJ7HwP5LAJ?=
 =?us-ascii?Q?HMLDMkI3tCBb37YRRO/m25R10sl1V0pSLAoA5sQg8swChTY1enoLf8dYf+ye?=
 =?us-ascii?Q?D1zFA5jp8tuw1tge/NdcaOdhpNYwlCM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e210251b-e8a0-47fa-869c-08decb688775
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:31:34.5497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+/pPQkUjuIXlSMEIVK2KatqmWR43ipKUc/Br6fEahYIo9CSXh7hx1Rwa2piW09xCobg8t+/lb/FFLiaWqfn5TRBZLAYfcBq03hju468QVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10160
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

This enables AN7581 pin controller and gpio driver.
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 configs/an7581_evb_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index 07569fa0a4e..a615994cc76 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -72,7 +72,7 @@ CONFIG_PCS_AIROHA_AN7581=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_AN7581=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
-- 
2.53.0

