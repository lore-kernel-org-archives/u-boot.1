Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F825CD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9097E846F2;
	Thu, 14 May 2026 04:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="bM3HT+io";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56BED846D3; Thu, 14 May 2026 04:56:19 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C1F3846D5
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqGPkeyyBilQUyKv2O4mlVQCVv8lX9ZB2jk+PXe8sV9HBVJFv0pfz28DbMZOBjyfq98AAUrgPZV/wZqq4Z5hG7szFopPZWPG+3LxKnRNgNQ+d+0cDm9nss+lQFYi+6Asdx8zfyeTM3hQRx3cN1Y1b59vxn8CAc6/PPoB6g6EASFxfgUG25azfFKuqR7ByJxyhZGNrJ0nUP7/QjqyDEglGlhDtNsUUrnVJSlGBOlY0RPSgLHLm/pC8GG7vb8gK9gT2YBzs+O/lJjqR+uhhnNer4w3NIB1EnByD8E5bn2lGO+CI2eX96eODPPjIkkDc9a1CGdCweWhpCFAqxiKHIHdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d17r6s6qsR5Bbb33P/jl/0kV7bTJvPQZfaODTKjwprA=;
 b=qL5aSQH8eu5I8Qd+HcD9cWfZ9UC8pk1rbVMvZxsIh05WgeQ8pdoL4Y7rfSeasA4BV/EwfFt+BhYPFepqXnbCChQi9yq+VgNN4PfeXe4zHmlZxYLb+Rh0nDB8eLcVoszn7GLsD3ucuh2BSTAlcBQV+KgDwU5Ps/pTHStNcHW6twkCBhRSvwonsSb1IY/fFkMIOuN60F0BqnzVwglchSqa4FxjY/lPfaowacwcK4lmxZTpa2fUvgpplK2Y65F1MIvLIq44aFLHc3Nvyn8Y6eY4+QwND07QemJ+sHtE4zQpjPALe7TooqGHs8vVxpjm1g4gLYMckJk++PmFEpb6rfG0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d17r6s6qsR5Bbb33P/jl/0kV7bTJvPQZfaODTKjwprA=;
 b=bM3HT+io53oW8ORNuTS8j5SWkei3OPHFHQGknjvmV4nRU+s8CalosilBQVzoRaACmI3BrF9vnmKl1B4MAJwGaSPArm2G0/5NAjCFZ/gxHmXJRt+2xsljPJE2jLu+Yydlqt4bzn/098h8Z8hqbw8q6ShqNs1OApz2jz9kcX+V20JsRgc5FkWeQ9Iw8rUSM9/78UGjm2oW67bvGPrIzW8sP/AjBgcghzU2Fc5wzXUJIR44oJGtSUiCJYm5VbUCP6X9an/kn4VVpUJgfgwh47xUDzF6lyRwi7y+Niuiu7nqAk66N6ZgrOg5PoatMsWUeEGZSwnkTfwGkvRJ9Q9QjB9Xqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PR3PR08MB5786.eurprd08.prod.outlook.com (2603:10a6:102:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 14 May
 2026 02:56:15 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:56:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Yao Zi <me@ziyao.cc>,
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
Subject: [PATCH v6 10/12] configs: airoha: an7581: enable pinctrl/gpio support
Date: Thu, 14 May 2026 05:55:40 +0300
Message-ID: <20260514025542.398469-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514025542.398469-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260514025542.398469-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B7B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::411) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PR3PR08MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f02211-4994-4338-2b1c-08deb1645d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: F9ebRowVVUXUwJirnmDTgoAkVWICdkT6+Y+m1DElrkBQr7LG85FAQ8LE1uWX4AWjspW1CoSmTN4baJtDzdHsGsdLTiKorGvFaJ7fRAwwLIHKj1LZ22w+FgYgco6V3efUHfU/Z6CFYjQ7mzErBRubohew2NjyldGYJsYGJm2UuU5PbesAgf887M7lK+p1dXLXhigTCMjc0lWrx2pxOim1mHV/QWqqcQtBeT9SnUeeFItjrLVQQ9Jdezbuzvqf7nvbgsohYk5hlQ0sBoWvBphhkKdMXcwpUVJcdhGNWZuVzEzbtCIRZk3s4JC1GgiloaCngIZZQyvzXGxfE3SUuO2ODIYbycQ7BcbTDvA3xeBaH4GIvhlHCm159UUxBz4OA45p77cDnoR8ecxgj9ZM+H5ZzUtS2l9OOXb4D+Tf+a4rE5kss5+xVM4klBKCqfNzJ1BupOGo4URz/Zlzmrvktry84b3vDureG1FI8ulLGXt7/Mbvi0VxBLaiTfy5ZEqPJ6sEGKWtF0qnLn44+/1nfLvx2OaUtbGjJwmEXPCcsLo+7IW1iZl0tXzO3WMl3idFuqBinCt+pbyM5WwQrXgTySaTrsHfWe4t/3hyg+kDHNkK+GiiKncOBiKX3FwLaOzk7GUpPaLMlmAkDSwIVeL1wPrmtS6tUjZ1ceBo5Zu8YAFXpdFvzxqm+GJWEiynm0CPd/zBioqrt0VDx9YwhWp/UPNCta9z9ux0bHQMf03FKlZBXFOBhLRxbPCMMOvEavNg513LB+ic7KkCr7458cHEsyHb6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7cukxgaX6iPzTwvfNRJh5KVIe7MHprQjtn0ox68DLPksPocGQSjREvvVKSmy?=
 =?us-ascii?Q?I+2ji/Wi8LDCeRzEnFzIHQJlD0bWM9RWUOfEUx7DH2c6KFYqSaNQ+6oJ1+JN?=
 =?us-ascii?Q?ewVLsEitx+Nb24LnticXrs/9E4Irb8eezdoN4lhghpyTAe8U4tKksrQ3kv9L?=
 =?us-ascii?Q?6BBky2iPViuAY1ZNlsbN66bJDpPzd18hfNn6jbo3z+hqfEKyCcTAVVbh20zc?=
 =?us-ascii?Q?Mjoce1ge8Ausluspapd2ZMWSLb3qyfpz/HNMf47gGOGmGnJNo2ctco0/T3qL?=
 =?us-ascii?Q?5+4w5qIZqA22CXho5hmTBGrPSgYoctWiLfdBtZesVXJigw1GyJF7ZOIERONi?=
 =?us-ascii?Q?TuYkrnH0grlqfvM7zqTzFD5yo7NJSsFLxH9cxQEUjNh0vAk+ifM0gVuCSlWm?=
 =?us-ascii?Q?UvzGQgeg2hRXgvpnCQrsAb2rvrPy8ewXRqKKRWhL56HjDLQLZ6BR3pdAtHKZ?=
 =?us-ascii?Q?jHBy3yml9hlWBWgHLVffBoia23kt0u/pApV1p0u+4KwWqbOn+MFL+xMwltII?=
 =?us-ascii?Q?HRY7Br0lrDSnF3arKCrPYQrU5+YRrE32dAO/E+WHykUOhj8KkOow/nkAR0og?=
 =?us-ascii?Q?eflINTLoakR8tjkSCpw4V6HyVdbBOUh085+Wleiw8uptMEgtl2W8WYYkhLZu?=
 =?us-ascii?Q?7dW1EUAoTU7dxgG99yQUbqVLByxzs72AgTugEicCgBK2i3AZyQwZ0exLi5N9?=
 =?us-ascii?Q?c55li8mX6Rovvp5QmCBVoz2GsnmBKddhYYo9nA73HR0jpizCq6aubfSkTnV+?=
 =?us-ascii?Q?vJ56ACmxCFXdfti8rXLRcxMRJdYc57bBg5Ut7Jc/k67xWTP7n+4YcOxzNOzX?=
 =?us-ascii?Q?bf+i5f6ABuQTM1BEY+NDnkMXYK0qj3eyMVYNY5qlHM93bSnJrPnnbxIJitBN?=
 =?us-ascii?Q?YrhSZuGJWVgXzB2C1UnqzNv0NaIjCEisVxKjGGZmlIHHc+0/Si/cv/sxRgns?=
 =?us-ascii?Q?fGv84JnBR3/cYqMEE+dFcPt/VtTCASVL3fKqlyoJF6ZUPpqeKiI1ygHmYWrl?=
 =?us-ascii?Q?iCMXf1L/j/jqnYaHkn13DxXRSaZs3UtYQ9PjHDjH+DqUNpswnzLm+BdfOzA0?=
 =?us-ascii?Q?LhST2khRqX+h9drk3Fx+kvXziyFa3bfHfxg7WUSuk0QzRoC1ftCc6vTp6Via?=
 =?us-ascii?Q?i3cFwKyyfTLuGk3eTdsfA523FxutWhI5NYUY/5NftFcvtm+td00GVHnVvMtW?=
 =?us-ascii?Q?wolvsM6sEQKMMciLAloAUYvFJELXvD+qNE0JHBnbwEGMh3N9r11vT79L4OG3?=
 =?us-ascii?Q?4JWTS2yx+RESDNZbaFoVkJVvC663BK5ulDPozf4eDW4gXla+aw69IMzxYLoM?=
 =?us-ascii?Q?KW623NOUmk1Xi6dlcLtiem/NBFbDaXKZy0qHtVYXPxazn22Fm39kvcyaG8tw?=
 =?us-ascii?Q?EXhv7PJU3T6NuSG+GY16TTzcVJJKV/G/1wVuWkCo0gkWqLMU16/nNKDJRM/c?=
 =?us-ascii?Q?psbmJzdEfsVkhQYNtoYJRK5E2IhI2vgsQA30JFL64+L5xIEuX0/D2FcexMY1?=
 =?us-ascii?Q?frmt7KvNKKHtaXcqcRX75lWBz/RAyviHzqrtv4/VvGAT+0BSUEm6LO7cZhjd?=
 =?us-ascii?Q?af+vrZFxQnL+qwuapyCAXfZD7p7jDY5x9FK4uDvZRjF9AsfoAg9F5IvtTCXW?=
 =?us-ascii?Q?38pD3a2oodNI1CNlLaKNDAPbPaZYaUGKtCiALGGFDT7jVq/iODArhPTC2cg/?=
 =?us-ascii?Q?lZ4YjlP7tFww6Jg0cxUyfixfTFIWyoRvfxSKUUZtWuoy/5dOsLPzkz4+v6nK?=
 =?us-ascii?Q?FlGsEO/WDivvNlTmRVJ2lIMwnO+8Chw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f02211-4994-4338-2b1c-08deb1645d82
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 02:56:15.7844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtUAIPKYO5mvTTTg1VWu0LA7zFVIl6XgmnqTq0FghZP/76hyVXnrUSE/5II0yoR98hqUZQbiEDpT2o8k3T/xAPcnj05YtrynF9yYJ1pJ44M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5786
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
index ddef8bd1b9f..55d7bb29664 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -70,7 +70,7 @@ CONFIG_PCS_AIROHA_AN7581=y
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

