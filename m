Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6325CD5BC9
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 00:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08EA84976;
	Tue, 26 May 2026 02:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="c2QKr9EO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97B8D8498B; Tue, 26 May 2026 02:26:27 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D22484958
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6/3EYFz8UDhVcsAYn5Hosi2lq8JLD00ILeRSltwvswhVj4TcRWF51mEAxLc3oA78GY9493mdmiJNJO6rbohGlaOETXdVZbIqSS2IUzUOy3dj3D7HjGGyGOQWm+spdI04VVzh4/O9npnoPWKUaajWch5JM8Dv2WZ4/lQ6x9G/XX6BkcbYYC9MeJrUltrnKfKfnZmXcFe4kkvbENgSoxvuXSAaBhaHC6IW1CFVoBaZCgJxzB+oEgO6wiNuAcBLBIE4fXj6AnRdOKWdKkK41AWqUBAwBeUROnQLIuDaXzgJL+kGsQipdORRT0SI4u96CHwUnwjNYOh+QSm3xMlc2sc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=eY5Xy+dkM8Z2anVtUtYT583UiwK1ABRcUK+ok+fqN/DHdGtZQBRhV9H2vlQkqgD1jMZK5fV3VHdurGSTUTPeeIRcbIa2sPIN6Oa7UDvRqAIKXFcpu3U8bieDZM8beaHrvlN6nEzK49VPMu+PchWnwU7sbPsGRrXasW0TuP+gFLnMmGyX5dei53e5q6mxpwNbUnPypB/LD6xysfleDnK06AK3cUZFxskca2XTCahz/hNdrUtAkJ5lTBBf13MEtobkK/R4R4DtMYroB3+QiTcCvv0nZOXqj6Fy3/IoTX8GBD4t1KdUJ4QXSOQgFNasf2bYe0deec1FoQ1rLtDP4zpXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=c2QKr9EOkk6WrgpAJXgdyCCcMQqOBV9ieDI2vTDPO1fhuMq4k7k13xfvUR5ntnvxeYOMdNeoRIGZID4H/67nSn6ViBO8ePWsQpQiVu+iUULSBWw7JcZZyIewAISHo10E5mKbcKh7MxvcYTQKyhrZfjAkW7hEbdfMZZFx7fhMblvda9009bv7dTyVTZ4PToPK4RuieJGlDbs0mR4sUCxim8dWJlJ2/noldaCQ7GUGEj9D+rft4+w9HvcUJhstknsymFiIiHuvwNLGcG1Rh7RhAkd68SQodKCIQiiafhKe2lAYcSlAODkDfOFdGYg01GLlEv5NQLaRj8WV7R1/xFN4bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB7682.eurprd08.prod.outlook.com (2603:10a6:150:61::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 00:26:23 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 00:26:23 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v10 11/12] configs: airoha: en7523: enable pinctrl/gpio support
Date: Tue, 26 May 2026 03:25:33 +0300
Message-ID: <20260526002534.898340-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb2fa32-7f8e-423f-5dec-08debabd6a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|11063799006|18002099003|22082099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: ecFt5eyeucrZKPualpkW/kOLV6w+SBPzuDkHY5nuKarZ/aYimRWQI9epYIm4CTtQToLxlF5d86HnKSxBVOo0UrgMONogTJ0CIlA+Fl2bxuu59FdITE8Z/0YbXgBQT9zqdwWdAxRo6lCa8BWQn6qGUvR/KZE4Cd8IynFc0erzpKZARSFIqU+TOpe7zRw29csZ+WRFqIaVlSwqPqZj6/qmz8hirWvUoCuQESxpQ2VoAZinBs5FtKdiplPSPwC9FTd7kOmtsiXtBxBqD1+4OwZD0RAZM8Ouets7fHh9enuzNheC3Ovsh6/n0H7bYpAryF2JYJGcXPZifKirJbqoFXl6ERpmFZskhEw5UujWSJZtkNoHluHlheIrPhyyzDrmwP/+xRQ5Q/YaAwW3q2l+YC3jFq1e+YD7NKzLwz3q4jFCIdxoykV2rK43X1R0CiiX9oFjfaJhGYN+Mxvw5osrjZdTNidTbJ2dv/4ogc90RvyLJ6wD9IL4vdHVyJy5E2X1kp+EdoWH86wBUEDZVCgt5I0NnpmmB9Oe/vaP14NAvutUZeZJ0gzt5bRjxFh/tZH1MYHsU9DN9DxSCE6MrIE/skeH2Awv+dsUSqSuTgCv92FlHWq+poq/Tac9IwBAPasF0wCTdJ8RkHM8jNGWIb4HM7hhYNOvBMT3aNtlzP5uuiUOZTBG8MQd3/Dma2n2fkVqIwj+b1M4CWNaTAuszC6rAEDLJAabe8msmrxK01CIlwHKDw6cIsm4uzNaGtZ0Rq2hcQoPRLxlZk5b6DEWPd7o/wZZAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Od2osn9h0ybNqRbpWPD0bc8YDBCK4cj15m7pNaAc0kl2axAB/V2NPLfHOYZn?=
 =?us-ascii?Q?Owkd66UoRTpMCzv3Darpvx0ST9jI2L2nRJVI1kwxOAp6K7ztR9SHNeVCVcXe?=
 =?us-ascii?Q?hwUIYwaNyU1u7O2vkyFqAPHeIlGboj+syCQU81itDV3z73QUJABH/9v3qIH0?=
 =?us-ascii?Q?T/gVdjq965lyQEdJCNUQndBPJASVWImt9TW8YsOAsr1d0+RQrtjrmJcXhKu9?=
 =?us-ascii?Q?EpuITDCOT6yMh+iLeut0FHKXu8Ydp/WS7B0x+sirBgUFu0FNeXFttCp5KGW2?=
 =?us-ascii?Q?bVyXuBj5Icx91Fxo40ZpVj31+hfqMl782LVARveijx9u2fH930uSxPmM6Ey0?=
 =?us-ascii?Q?aE/EwQfji3MHoG9otuay2Sf++ECaMbAHgNvHqAdzo8bHB2JWY/xNExQ4pla9?=
 =?us-ascii?Q?wSwIEylxcsEyFYLM6lvVpQ6WqzqRWRX+4B5OsL7m9kVTgFQgxROuuTnIqMvL?=
 =?us-ascii?Q?QUAdXkWF5yzLbuUF04NeNoCIKSTJRXU+YrwbHSpZ7+nwny8yJeuwXLtBbtiy?=
 =?us-ascii?Q?cGhTxouvgFqYMUzPPL04eWEtAHqm3eeH2Q8sy2CGp2V3v+pTRwDqJdrKcGz8?=
 =?us-ascii?Q?f0EyXhTG+v0ng6oJtzxXOPnOer0JTR0yHDdx0byCBqYIm3PzrpiCF0Ld2+Dy?=
 =?us-ascii?Q?BGaVzEEKVFhxRZ9GevhIdzmGm/jKjxFCA2o67wBNJ6kKhb3vy5iJaezagiGB?=
 =?us-ascii?Q?8x9vn3kvG2lfsxNv347tXnWaSL9FF/Qc/RjUuON93mtIjA3zoodwbXmk+Geo?=
 =?us-ascii?Q?Ol5yJqUWp/d35TQF0ezIEM+0qGiLKq+Ni/4UHYY51ypWETyOM04Ttkl3JMNE?=
 =?us-ascii?Q?KWW42Uif+dIROsAavHAODM6vDi3SDInVUKNSTKFkgAEMYTfcGLXaOZv0ijVW?=
 =?us-ascii?Q?oxI71gddo13bP9/wm9Jo1oQ2PTQ14ZanrXvvenvKRFj/ut3rXRXnEZZdPRqx?=
 =?us-ascii?Q?Xt0PoValn8w8v4oPAfrPImZKXY/DkU4M2baL5XlNgqL9KcndA2I/ghIheM62?=
 =?us-ascii?Q?QNfGl0bT8n8jc220xu18UH1zUOHTMwUdVAOHBg7BOAvy3pTwbhG+swDTZ0QH?=
 =?us-ascii?Q?YiQ0BW+5thAlQWR3uvVLyc2S2gYUjOuxN8P9XCxsreklezZa4ZrMMN5Fr1Bk?=
 =?us-ascii?Q?kLaEgApDYSPpIP5XmPC2eLaMJP1mgZR9OqxhjRFM39MjhG+WQWKVmbppZi7l?=
 =?us-ascii?Q?15CGdzdNiHPKMMSi9FkJQiaRhdjt3qr94t+qBcsGY7iX1s7eH4sNaUb6xhbA?=
 =?us-ascii?Q?5DTSQ08rIupw+7j+T9QoUDrQEc1DubNrxeYwJuhF2bd/NG+nHyiWEN3+sfCf?=
 =?us-ascii?Q?fj3MVSg0kQ0mIll1I2Bu7ZQhcm30JZacx0y8ItIPI/TAaMDXeC2sWJglH6Mw?=
 =?us-ascii?Q?X1Rlt6mdcDl4muCI2cK5sHuD+sBbKBcLhkpEBrMwVxM9nl7E7pWXCG6VpJeQ?=
 =?us-ascii?Q?udSFhghetYVMs5XtXBsDgTAmAw4T/4cbHP2JCZA4YWqIlkL42fd3P+/8UzLF?=
 =?us-ascii?Q?24n0KhZSc3/KqTOByDHkDg1waBo4lUrhf3GMDnUU2YAbwjGJg6C7Y08A4tTX?=
 =?us-ascii?Q?oPE1hXNA0zxEyqg0yJ7plvudzldhX+J5FWoRopxfxMbCe1bYZ1if+1IwoAYH?=
 =?us-ascii?Q?OcLNBngzLjFJoEhyWW/wZ2zoLlkp6MBx5rINJJXFTdDDw9vfeqDIphoJkM+w?=
 =?us-ascii?Q?fjACSeMZzI0ObTkwcAib/U5Y56dCQs4/w7Py6faClkdvI6zKhyDwLvP9BKZU?=
 =?us-ascii?Q?SOJBC4yh6DpskzbX9ixSPUFSsKt3aMw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb2fa32-7f8e-423f-5dec-08debabd6a53
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 00:26:23.0321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eo4oiJF6C1Doyj/QB7ByXqSATT4YlwLoJLuj3XGFEItetOde5mHwpQr1yu3fJas5MuZ5yBkivwRnUYlKlPve3hUOTyje2AU7ZrwHI6Mhq14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7682
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

