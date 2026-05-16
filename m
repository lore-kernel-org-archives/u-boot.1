Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772BBCD4851
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD64848C0;
	Sat, 16 May 2026 03:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="DFCwjdrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1585D84713; Sat, 16 May 2026 03:01:16 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F23AE848A2
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 03:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1pGfG1oZtBXI5yGtjFAFGVswz+V3Kxbkk0sZ5MljBQb23kClisemsRq3fU5eh0Mlzb1MGlw+yXJRFzOIcSNTSAAGP0PRNGE1jsNqkz5ZTZCvVCpTczpbPnag2gmH5HaIH679cm87ta2U768bfHsMzilLYv2wS7w0KvT7lxT8EBuz/L9an8TQUX4kc706cJWEI6eRxMD2RmZxlroPXkfFIczuDc38SL8UnG03nQ6TO8ijULDAa3IBle/yxbJqDB2QEBpruBodYmrSsUUmj+lyUFk0OgM+BV7REWK48vOhCjAN5HCc4umvjP8XujX8aYx5pif8OBmxVSNFawkOFybTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d17r6s6qsR5Bbb33P/jl/0kV7bTJvPQZfaODTKjwprA=;
 b=B2eqa+VsAKQ9nEKkNxvXpCMZVIWEbMpuGZDNZjSJY+QXF4Mm6jnqsnlYivbd3HTK6blR5JsjTKOzCMJ6O0Q34Ca0/C4zfxdAgK6OHIelqyICvKi+Zp6xnPQgxIyT0/XSEwZwn/A7dw2MdHOUIucn9zSFhL/u/GZYuGIzEkI6pkgW3ccjcqQC2mMLejMaxcPNTiTjMOKGqmQ5++E/+DN7S49rnhAM1pPtIMulvLknOmV2Lh73NXV0hudqmNrlFhf2Oln3lHqIWRSLZTtPob6oS0OgV50u8bNM6zkpWuqF67VbhTr1GWx0VJlaE6GR8KRtAQOC2SmB8NsjqScbDOW4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d17r6s6qsR5Bbb33P/jl/0kV7bTJvPQZfaODTKjwprA=;
 b=DFCwjdrFeeptl9FNyXwa0GeQ68xci3/CbLDulz+rg2jcOUDlP8tgGY58aaayf+ndRu/8/AXSaTTuwuNtTWL7QDKx35EnXvE+WXf/nNlQFVV+McmkqYjnOH2oZwI7Jk52kObVzBMtJFdfGM2TOcVL1oijzWrLYGQFP5OC5GkoTQ5CyGCOLmekackSU8MIYEEhHLiwykyAxLbXBPX0Z8Hgd9b9OSM18BwuRPNahZ7/x18jVEixVOBf08cTgeifXvDlmwjtDzdzkxNiCmbrulUcy4+Hf84/9Rf3B6d16oWX24/j0imtBmMDEVdD0Vwzflw/awUVdZBjuXXMiysst+PBeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB7917.eurprd08.prod.outlook.com (2603:10a6:20b:538::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 01:01:10 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.016; Sat, 16 May 2026
 01:01:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v7 10/12] configs: airoha: an7581: enable pinctrl/gpio support
Date: Sat, 16 May 2026 04:00:33 +0300
Message-ID: <20260516010036.1034352-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DBD3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6a5) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: fc20abcd-d60a-4660-4ba6-08deb2e69e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|56012099003|921020|11063799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: KIMk9t3WuBd/I2EeWmc6j69jXz7KBv/wjm0ylTvXfnPKYVIJxJtnSqetjqoSj6M17noJ55DQuRz0miX73mjXLMp1mtWQNlnsB1DiT24iH7JF56b2XcVA1H+ZNKGJdGP/KRUr6uFqJyE/GnO3MSmaNBGjP3WPSCvLjtI2dGFdZ8aaA0f8nsK4GUqdutOG5RdNLnsCMrToB87DP7rf+xZwDn6gzDoVbxnlRyhuLPAs3wLPKXdvzJE3KnICqE5lfWhjc/GPjzBnPe+DilSsKkbuPkwMAWYRyNQ3Tqyp1rGZ4Flth+TfZmMUlf1oBbfyZFSMJT84bl1dJqqKlIC4nzv7XucwflgPbFx6SwxA9fCnlaqnovYIL6E84nkS/XfzEpQB3hdwHI3hTWwdnW1Dgsin25GgCvBpg+TWVOy0EKPA0FXdMHS+kFHfg5BtxCH92SQ2XQmYT6E1hjkUGuKONKij8+jFA43ZZxSLVMlLm3ifbiixaD6jCcQZThC+XN4hfEBDcMdydqtnlUl9k+KqKMoWN9eZgjddjLv8VCzHmYmSbtvjwNoS0tSLw5cbR4DQCMYLkGXdYikjDmKWLukKk6/mC+7a1dB6zatyV4sCNII9YtiPiIhYFYfCc3Jr/IWpYzptZY/hgwc2wsw0zAXouv8KWOor6esEumIzIcPlZ8w6VDe3ESk1zi2KvG8mdYWgU1tfs/xNR0LOv/rLFy7hdvrt3agAK+aH2HTTrqDnps3bCj3nys6/Lp1fdmy0D5lp0OK3xChkhMVrxh/0uP7S6nsQYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(56012099003)(921020)(11063799003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qyvvFme4VxMSDb+Ac4eCexSEH7RgD9b+cI7vIDt/X74sfWRNeslSc9rfaid7?=
 =?us-ascii?Q?F1t2dxNnvOPpS9ygN3AJbR9zAMck121OR4qRwpZi1eEeD+TknCNpCBda6hNG?=
 =?us-ascii?Q?DiPsfNMdc1AXQJQtlVEDyRFdkun2cAOV74bazEMJRyGlqve59cCIguMFDji4?=
 =?us-ascii?Q?QDL5oXcd1Aj7kQRIhJkuN01PavPGu9sqXKLRGDCwYcmf/j2oZoEcqk96dFTE?=
 =?us-ascii?Q?0PijzDD65YTA5l8DP9xfnSy3qEhQ508MtOkos8wRk2vQSMK0sOBwiRGfku9a?=
 =?us-ascii?Q?kwhdiqmMQiJAA90yjMwEOJ8xczYWCHojcPsV27LGtbLGRYsdfO253WNGaYr8?=
 =?us-ascii?Q?dRZZkmGsIwnq2xBTm46JUiMnPEt3f56xl2hSHTAvBJ11aa9o6ZF8NZH7QuFb?=
 =?us-ascii?Q?0AFCJHHgihEV4tOas0K3XXHKEz2IQ+Rc4vr7KkrAW70GVJ+faIFDgm4ukiuK?=
 =?us-ascii?Q?9IM4WhJY29V4HsOTBF9vwSdYH7Fn0KihsmzG3BAqW+yL7RKUnFfldZ18vWaS?=
 =?us-ascii?Q?fPbk2AXjZOPi5tRn25JNmvSEcgfWVEZr7MNrb+Z9j5Eua7ijnNltsP1x6hMH?=
 =?us-ascii?Q?tPmqqXgZsbizPq6DnOs0S+Ba0TUfslVeAjpCxCKEXKeM/q560fkjj3OdkpDq?=
 =?us-ascii?Q?pP9iczzDFv23B32uQrXSHxRF9Rp7FXf3rllMe84ccI7RAQTyZr/CNVVaMpgw?=
 =?us-ascii?Q?leUJ6p4DAXC6yxupSpyvpzSsZLnqLkg4MVOznUSs6weM2kC3NHT+YJS0sbl/?=
 =?us-ascii?Q?WWqV7bfwqrLohBMYBDNhKBQ20L7W/BrSyJlVvBoUVTDr1ygT7IC/J5yo3kV3?=
 =?us-ascii?Q?u+EtWylKn96RLH1XfPee1HbVrPmYakr/LM//UkUKk7EDsil0rWF0Jz8lVWaj?=
 =?us-ascii?Q?uRe6PYRGpx6DlnY+cvpDDJAMKVDCDv3OlAIbZvt5nuU3cksUDUQbe2+z0Xsg?=
 =?us-ascii?Q?NTeW6/kh6aZ01cM8osHXSETTuBK8ipwzqt/v6+ynmUXPhlXZuv7zW1d3qvYK?=
 =?us-ascii?Q?ZXC4NxO7rhoeRMam6WETgy33hOZq2BnqW6W3aEshKrBBdJuVnJbZKES8VUQN?=
 =?us-ascii?Q?Jxw69M8qFx68Qv2XELf0j2tsqj36qwBBtPXioGkfoagbjVPQAl7L5j0hlO6q?=
 =?us-ascii?Q?xbklI7rpM4Z7nupwNLDT/Wso3GZESwzxQIGCdyq13CBedvDmUwme7OdV14fj?=
 =?us-ascii?Q?TEVr4oDiJHuni2ak8+XHM2Kb4oc+OX9pLYsv/QP1ZiHECTIHZrlcmcfzl3hz?=
 =?us-ascii?Q?BfmHN/0sHAycJhBy/U32/oxtcAjubvG+8AGHGubUFbf68RzEaBqtkRwPserM?=
 =?us-ascii?Q?40mWlmDObAWQfyXLqMf5q3wltk5VVQ4T8nKi4VgEHNgxz/tfxVCYRyzrBLye?=
 =?us-ascii?Q?xMtEYe94GaqbiMVLekJKyb93SG50B7B0OvvR75BDX4GSbdPRa7ZDlVTDfdIf?=
 =?us-ascii?Q?GzoCtFyufkC4wwdilQHv8YzmKWDdZKiWO0gnkhxewNnqqf61NQGXOLrzMEsB?=
 =?us-ascii?Q?vl4WlZ/+QWfrxX/wbvCqXPstcRk6JE5QweBQDt0ja6iM7buV2NGQw+djlMaW?=
 =?us-ascii?Q?fnO9zisD7yGJVcP/CSmb9HJl5xttA4w9xcQShdGOZpa2N6UzJry2COnAEOaf?=
 =?us-ascii?Q?vkVuahiHQ8PJgbi61FF6ZXj47xJO7bIOTJgY6WEhjofYC0MVCi271/B2zsF9?=
 =?us-ascii?Q?7OKujvE07xoG9xOppocCf0LFAvjczBfkgF3tV65i42apD234d8qZTH3timt1?=
 =?us-ascii?Q?yNU2i1/aOHGNtIHvpNZZ6vZt8/jVz5U=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fc20abcd-d60a-4660-4ba6-08deb2e69e40
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 01:01:10.2602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /328t6DS8DWEtvuquqYyKvPLDUbC+qg51BcX8HxUWDuVR8EJcww2CDhcNjVlbFbe9BXoF7Ayy8k56jhun53wFf3CO1lZa8dvrXkRYOWsApk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7917
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

