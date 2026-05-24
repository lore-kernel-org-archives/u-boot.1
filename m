Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E3ACD5BAB
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 20:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25EE484944;
	Sun, 24 May 2026 22:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="MWtF5Gv4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58CC5848BB; Sun, 24 May 2026 22:01:08 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B0984942
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 22:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mu/aI0GAZy0vRVK5HUu1tdM2+cNHqF0EO/0qyd6WGxwxUyv17kQjPTKRuJ3y3svG/iW/lVFHFLuW6bVZ5CFiV1E0FWljiKGNm1vuRML5d0fSDm/TB4Wfu0PDk/uVx6QUUhTb5b9fTDECIdafHuZbWE/kMZ5ic1uCa628gUwYOG099+XrvjNp52kevzQMfgVpYou7cklv4f1GP2BiZ1hOCJA2yHmrI5MCFwqCu1A2FYF2SujsHJiWCTeI5Qnx23srgCJpFtmTMZnlA3G/8KIzDVUufOJMyc94txc44yVvo7DQgQfMAJjc22JIC4lQcVy9JhVJYf7wOWWa4Y/D6q/xRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=aeOcEwRnOXd1BZEu8ndW8T8IUXYhhFqVsD54b862k2DbNbPc7yeJ9yOGM+HukMHP40iPCATN+FAT/3k0KYgOLq7KJeudRA+3YKy0rPolJfKwlAI3/TmM8DVp3KjH6em27D76KMroju08kKwsckosij57+rUlstQq32ctam/I5Gnemtn7ThWMDRq4ewQ3pS5f/oZjR0MGodcrzlRIiuDJCzUnpweYGasAHygGLRrXtWLXbMWZfgq4IGzRWSRgXskoBaJoWBED8ph3NL80rrEgt3Y6g6Hy31O34VWPwh8a9oOA3OeSELtmb2OK9wWczRkByWJnTJY/RrSktxMewz6ouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=MWtF5Gv4vEq23bwm7+MlT6p2ViarcqJ7WQL/5rlByDbFTGkbpZem9+7e9lsKGUNtUuoxRi4GBYXoXsdaMM83l8RW7fxoMr34iBJO5poWBjQZAgxP6HXJHOqV0qfXl4rji6+za9r+8BoMMVEEf+EboZVqlX3Ktl6PFYpBVp7UtoyoNJ1ZPL4L0bBQGKgXo2gHVDe5r2taPv/yBZr7yNbX+YizsPc2shGe/ZG3Z8l01oldAI+obostMJmQcAHQVkVNTLEHzYiBQ4o7EhrQwN5KB5NE1G4ulwrx/4RcLGgj/EnzNABD0TAhnH4NQVq9CBxmnVDawyWrWINXn2HQ5WEUcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS2PR08MB10266.eurprd08.prod.outlook.com (2603:10a6:20b:62f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 20:01:03 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 20:01:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v9 9/9] configs: airoha: an7581: enable pinctrl/gpio support
Date: Sun, 24 May 2026 23:00:38 +0300
Message-ID: <20260524200038.47826-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524200038.47826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260524200038.47826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS2PR08MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: ed38d19d-4cc3-4c14-c097-08deb9cf2f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003|38350700014|921020|11063799006;
X-Microsoft-Antispam-Message-Info: qJzs23lZ+/U8KacJ1YLuwDaao3O0pWN+T/gZ+gg7yh9itOCSp9DHSwxCWksamcKpix/valVxaq6J/C+0fSgcSdUt+VvrnaurA24UAgmTFNjrGRX+0UcmroA37rJgXF2mY4Qq/aAJQgMNhxZ9wq/gX29hOMrd/VcRD0vxev6atLBHdbQu64a60bRjbRpRR5gmpoh+oJ0uygEYODJSiJ202SHrPsZ1otvPtfJvpqxzvYYMEZVUmfDtyOOI5lTmaEMT2wy1P2zCgVxWLVsIlrocjceJeJpsy8aEgyiIPz5AC2ylj/V6f4F+yVOseRHYpXmWM3rGniI1hPEzJHhIHvSirWt1KhBpZpFmkOIb+xGHImTm4clieV5EHJa7xvDawqcBwCFn9fT1s51SAf3Vurj/ed4TTt8SkxHuJeabi/j335tk4qbi2Vzjq7MDkmX6xz6hKMl01uk6xeb19e3YSl6a+fs79Z8zGxdKa8MOmAUuWXkvADA8JPniKNw+RX2Jw0LY3McNWw/x7GnEWL2ZIWa8DKiGSXboJdcIPk5eruSH+JrkjMmaVgIb2G+p56WD9thkLK0ZYAgdga2nAt8gXG9KBBBpSMx6GgpugG7mZtx+DqJMzP4aPnc9/Kv3HN2B3zvZap0Ygsd/s9R3uKTJWjpL4D1BWej9QTyXUjHjZDpGsdZF5D6vhsjd5fzH7P9Dwdy0PTB6uLDMjCsO05LlNXm67GaQI2d4wLbb4nzCNZlaNN44AffYvWDLYSKCIzQMkWzdsSMQ7/THn2qnfZz0wABzUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014)(921020)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ebPT9vNJXNeqk/SWMbb64WzONVpFQeXboaqcZUFQ7VOOG5ton0vaeOtG38b3?=
 =?us-ascii?Q?DhKtXABHWA/LpFDwVJ+ZG0YJApNiY2cG3BY9Z46jHwRIQFJW/x6XvpXJIvRR?=
 =?us-ascii?Q?Yw1alt4kAqZYkCo7o5b2RETtJdmdlOmCVz5Hj6pCybzCJoBAqZT82IdPL94f?=
 =?us-ascii?Q?6eFvSLaeTUTpEWG5AIL3LzYGfpmCAQ3DBe75vhJBgmF0sGHQx8LY1k5yZKce?=
 =?us-ascii?Q?tqoDpF0uczU7ZE9v4jbaPV2XHGn1Kbr7S9bPwhL/o4ZnjFDYu+PJ7enQUo+O?=
 =?us-ascii?Q?zQMsLai5yeFTNw90KR0L4yfvVXa1d8FQDEEkFYIzjUShpjlkqmJJPCWf2CqF?=
 =?us-ascii?Q?ATTFhRfWKvhNQaf6Cb4N1jR9xNEzMhtelHaW5bx4+GimjQD+yy79s0kIKyyA?=
 =?us-ascii?Q?LK6xP0s0t29A1gsbQ9CZ6BtVHH3ZdPZ1IuQYQh0aW3kw2GSKAk6Lvu+J3bcx?=
 =?us-ascii?Q?9EeHGCy5MusMXvE78rYDh7HG/odY1ilMo7C8vn5L09K5xE5keULALjPSpD/m?=
 =?us-ascii?Q?GP4DmVbDZEmBDNawfCVng2C2EE5Zh5+PUKlPoMdFLcuIdb5mktVGT6U/ncxX?=
 =?us-ascii?Q?/8kd1DFN9MdTMslP8NB/El2ByR2qova2e/L5pM6KIeKf36o7olBgf35ONxZh?=
 =?us-ascii?Q?Q8xcCZTDy6aFsTI8Nuwmzt/twTeJJtOkcLMt72ewcn9q6xOa5QRh+GTar6HK?=
 =?us-ascii?Q?9ta6vEpB9Pm+mveGnpAwRxpAqZyasU8UaFVmlGgQIvGGM72vjcibAlhpq80H?=
 =?us-ascii?Q?fKC4AIv6eO45KaHsEJyLBqhD3uYWegNtEPwj1eaN3O4Xsy3RtJM9BBcnKhcD?=
 =?us-ascii?Q?y3YJH4ACl1Hct+U53EIJSNFybDd5oR6OAbibXAUzmhhlmBeXVAUSYhMcd/Ds?=
 =?us-ascii?Q?aU0xj94KkxYlFQUhW10oYJ1msi52EHTuizqCvt6OazsmHk9wRh+Cpm9/ul30?=
 =?us-ascii?Q?mtYdO26bls693J+b48U+zI+FNCbYwzJ+V4CJ2+iFWyxAyaztg4qk1zlOAEWU?=
 =?us-ascii?Q?O5kxBwEi7lQ3aK3wmz7FSXl7+kjlVspt1dgmXPtm3uUiL3Cmfj01PVWQSXBY?=
 =?us-ascii?Q?GeyxNBpyef81gIeQAiRgKfCzhcPK/ssIe7QbJ7aJ19vwHI1hwh0xOEM2yTRj?=
 =?us-ascii?Q?wXqhcZE+KK6xMMK/MgWVjf9fFk+Qux1d2ah10Jbi+2/vPY/UkERJhtoq0I0E?=
 =?us-ascii?Q?cMeFw1xohqMrs7wuOW3Rp4MjHCgyQ9y4Vlw1b061Uk5TNFKZ2349s9FohhpU?=
 =?us-ascii?Q?H37hqao6fGBVclC9xGW0VZ2L3FgHAJNzbz7aQOkFguGgpSgHRnZAsx29CAu1?=
 =?us-ascii?Q?cJh8a8IaRpqamB2fKl6zODu1Y8mJFICqY0uhCNAS0oHBVCVYoTstJ0UG7sGT?=
 =?us-ascii?Q?5XWVX8ufO0QEQhdxZyHd4coPtchoR14IWOuQTT0e4VH5rqRGxojnfgJiRfzr?=
 =?us-ascii?Q?1uUmjpxC0pdYHaeim7GPz7aK6g6QrD3KAA+GFCXwawFFcgys4NCDZq4GfJci?=
 =?us-ascii?Q?h/iF5Tr2909HAcFzyYTXh9it3fylo++2uy7qzeyzx97xMlAQWxKd+QYV5hY/?=
 =?us-ascii?Q?jUIPRs53Kb308sE0uxbb3IysKc34lDbMmVjEd89pZgPtg5Gz6jRpnuCcBtLU?=
 =?us-ascii?Q?Wc2pTmWFEiTQzR8DLkUVC69dtLsjlGmLH7bksufz8p/dty0FAkJK6ctMdq9q?=
 =?us-ascii?Q?zoX3liiloqIqhRKgQqEv6xJ1VvmoOzoh46SdoO56tPZRthYzl4Tsm+3KG1vv?=
 =?us-ascii?Q?uToAu6s7g/q84kXdKkslLVOyCdtDaQw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ed38d19d-4cc3-4c14-c097-08deb9cf2f12
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 20:01:03.3571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXrwE20X17WHra9wyF6Kxyuu6FOk6+L6CV/OSZ50rANBtwz+EXEKWoYEngbEtBSvKYKJfr68C+Y7hPp16hb4crtWvaTHshgux0vTVT7iDII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10266
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

