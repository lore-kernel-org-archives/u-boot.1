Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A6FCD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 11:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1938284CD5;
	Sat,  9 May 2026 13:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="r1jTWrZN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35C2384CEE; Sat,  9 May 2026 13:12:15 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03E7584CE4
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 13:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHmSrErQvHoplNJ+Oh+TYGoVctNXtFVvrh7DhzisZKs3zf6EJ3T0qxMY1cCa4AXHjENYgoKRmzMUi6vYSDEbCRqiuRt3UBab7YjoA8hlfMkc5Md/H7eR40ZDc30IKuOKyjIkvBD+P18fXV+XJTiFAmPRpaDAxxe8cyHenoFYQBw9N+RPEcxC5RcVcBseHjSyvvAJDWKMSdLToDO7XdWEGw1gfTf2uXW6zgFkW516CNFvu/DPZ0PAL+blgS3AKW8+i/kAnjVZDRRYignPHdrM/bnVpr+RZ2Wt+1jJgJgMV8HXo3jZM0ZU8FNIw3HCTGaGo0D0TfGWF99MFlrqB/SGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZ2BqyhV9L/Hr+D0Iw5aoIkme4X/285U2W6q/xqpgmA=;
 b=bdqcm7Fqs+UL/gm3ji+qiLownh7VcujZ/RIiTziKQeQQ40CJjQWflhangbN/ddt2Hzxa5pH0h0aIKbWlcwlQvrxWFKpurPRqDfRCMmVUVFcxaVlq4r/clbzIXh8KsActdZeM88sscJXWs2zA+sUmfcKNAHhkSXmyQDBBGo7cWj+qW5aCNSXmfqAmj3NEnZRIwI3kpWo1RpQXw9HQtmmXksKvLVnzBCmmbCfxB3bGI92sNBAQ8jSAziSuSN7hNjDQGpVi67xPzOfV+v+S9w9ROmlbkggw19R10Q2TZHJqaM0Eb8YS8W0hg1LKO7w1o5Lq4S3PSwedsUkwUi1lXd4tjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZ2BqyhV9L/Hr+D0Iw5aoIkme4X/285U2W6q/xqpgmA=;
 b=r1jTWrZNwumqQoHuFNrqivKXx4kqka9RaTc0/4dQUDV8PhPKJcEBqImKaYqbe1qIfYpSPiS1fR/K1Js0aUK+isMbzRwnv38RrfKR54Pb2Fouf32p+kUZ3z8QcsQQ5nDi+ZSPfC1aJfw4INsjUACueHQkhcaKedTlkfXtMt/rUW5f3CCDimNipArRDLoeGSUMc1l4obF8kNoGW7R/k1V4PsvcIG9A0g9edlUeAmI1E9JXJK2BKVGD8KRJQp/iWVoeY2hsGOHm427S4jAkzI29MBPRdcQrLFzw4Kn/GR5ZhQi8r4w1baLkPlZdYMC/OfXDr6hWapKxnP4y70HpHTW5og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8617.eurprd08.prod.outlook.com (2603:10a6:150:81::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 11:12:09 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 11:12:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 01/11] bitops: import BITS_PER_TYPE() macro from linux
Date: Sat,  9 May 2026 14:11:47 +0300
Message-ID: <20260509111157.4039434-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::9) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4e7e35-99e5-44cc-881c-08deadbbd024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 518g/dhQGPhypwQ7YkM4WyiAtLLMom8iBNods3HyH+acencKklO+jUP4e7HIyjCq98msBKQtuyokbB/7LkEojUYAD9VpKIKiVpEG1eYuXgvrwid3yD0H32upZUJ6atjTqyuSRJPdXTNLoJfoJJrDSPaSj6B2h0fdC+L9AAV4S8KEeJBrdPtph/hxVI4gbzThVp9XvtoWNpeLdbtvpCcGXdM9XMx/8lqJwhyCrT8ngtAT9LXS5Y4uqoIjVO/Kc9uh0zdadxxjkrBcQi0E0reCjQruiqaUZ//hkEqnHCnwUtaqwUABZstdxTgHvPxk7hmrSQfGsnbrq432mFxuWfi+lV6YkYWXKUqchPSMP8o/0+Ak+xomg5jXQHo5V5+YxGYZrSdx6aBVl5yCksZRpxCOVzls+/2Lm7hFYxCoQ8sRoNhcLSQTAQg2Tbz902LRHc/fJT3p6iLJNqUo5Iww6ltMrNC6AeecvDNFVT7xqEandm9f22vY+vnPOI7DkT1RmK15ogNZVXB/Pzve2GZCM2i3Wt8UlENAoRQnLT/hOmRLZQ/woY73bb8QtHLi0E5SqeoN+cv/Sv4pFJYYJOIdxIcIDCvpKWrZm2vMJHcaf1lADRumSWX18Wo6APnQCMWmpeqs5L/sqb7Q/lpmZc5rkv39sRCtCY20zQm8YTz99psXunB3m79+8voW5Npaz0FjHB8h0DXpvUFbQWwr5FAG9M5uL4tzecFTxk16FpuGoS2+x4Bx+QMy1kg0nn2ruU8et0UwAW4JsANj9qk8a/Eh0by9LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WmlorS8l47LxK7NPP+4DoJR1y4X7zirk/9I4DVa1PNdOgkql5TCygyzH/NHu?=
 =?us-ascii?Q?3FyvhvTd8sd2D9KtPj7XWGpPozUbaXNe/X1koJly+HIBO5xHeNSrDdHyRynF?=
 =?us-ascii?Q?9O9vRCruyD7Dotdsjnu6xNnsi07uaKFJ4F8jKAlFRToiPpwvdcy2H97Oqooe?=
 =?us-ascii?Q?PcdX0kgwzN1br/Yy7zLDopxad6rwnEHG+NfPN1FB6dU5YYI9mFFZPLyZas2+?=
 =?us-ascii?Q?9GnwcnKKGSlwtL7urk4TuBmQKzwzUPivSiO8bQdznWNbBXgzmFmoERraH3ps?=
 =?us-ascii?Q?W9z10BGrZOLE8p+U0YmX/Gc3oZbJbdfOtb0uyyD4f/qKxFe697VsZLiOblJI?=
 =?us-ascii?Q?wijI4yAECNdIQZpH+h04pe29CY4Dy0WCvhQBmhvUiUyL00HMn6cm1hvPjIUj?=
 =?us-ascii?Q?/UhZmVMBEEs+BUfrDJPQE4Z3CHwRMNmQz1qeFImkEqdiIiEUoBZWb6Di2DFh?=
 =?us-ascii?Q?INOZQ7Zx40bvyaAdOIwMN/BlvdVv2YY4+D4Ib4w7VpQCjOP8wmPOJVASbsB5?=
 =?us-ascii?Q?rZO0WbXeXPQr3ShqU8poxOSKUkO4Lzm/PlzQd3ILZnAXVOEnwYcmwilaFCPz?=
 =?us-ascii?Q?SBhNWLuulYsUbajOTl0oaauEG4eQJ15YYv6MxSY2S3/BbduWf7gsQeyep3Zw?=
 =?us-ascii?Q?d2NhFBAw+pjAWJ+kz1KYZlPdnUuiiXnsVK2BhSzfh/LQDl8Cj+O4BdEqRjWj?=
 =?us-ascii?Q?sCqFMUkc6GjSF2+HtAUGeiCF/9LFj3hgib4bztURTpQhuwZdAOWXXC+szSct?=
 =?us-ascii?Q?uNFK5Z0vKwfjQ/w6S1kJvlAOUgYZzj1ot8BsxyP+Mjkn47WiLXtvQsCdHl0y?=
 =?us-ascii?Q?e9rBOF/KglOi7pMRjVi8PxbZSNj2Ek1Dx2eexXDJEOOKIOB47njXxFMedubw?=
 =?us-ascii?Q?FC16ymNRIHGjDMrdSOoD7RUUP5kJwKQLJ7Uao8yp3Vd4pVnnqYqM2cf4e5jZ?=
 =?us-ascii?Q?TebSE7A+oFsw62KKx8ixI+HqtXDVZNeCh9pf+vQXNa7C08lB3KR/y3P0lmC5?=
 =?us-ascii?Q?XjMhBQj2N2TJvMvmV5io/8hqXkanYuC4mBlzGCaJsmqvPtKQIiSaH7rOrzp2?=
 =?us-ascii?Q?rmrWMBXfDBf+IaNYVcThjQJSL6UcSihjTV/l38L3QDv1tIMb6JnGMefxg9KQ?=
 =?us-ascii?Q?CbwxPBOfVYoReadO5r0JrYWvAWNT6CnLjKnuTP1qw0v681VdrBganULJTgTw?=
 =?us-ascii?Q?ZcWQslaDkaUIs+E8mY+QjVNMRvv0sQdKtR0eOEVzLZ1mEfDwfiXYBHZgZfin?=
 =?us-ascii?Q?hT2YVJgxos2FZIc947/gDepVnRedJSqdFmKFPswDXuTT5qYY94YQuSrjSPcR?=
 =?us-ascii?Q?qBHxoaixwVJZzfdzja5dYQkOI8jC0yhlkxMF3lpg3Y9pGqDMCFTYMCKKbHyw?=
 =?us-ascii?Q?OYrzCE3aFrjhj4yCuXM5gICToCpPRRbBRhSfsvUnzY8TXJclOh8YSnSIUtfo?=
 =?us-ascii?Q?1jaO5ysEqO1ERHTGP+Q2PxS0HIcv690ggKvUb/hFh+omhD2iDq9n2AXWmAPe?=
 =?us-ascii?Q?MVDBBLTQDLfv22c+iEdE8ezZHO4jg/D51F6zM3Es0c1yaOaBuScA/97DTaOs?=
 =?us-ascii?Q?RHTGTyoWsuAb/2Pg9+Iu1ya8OmOovySo4iOtt52hlbRuUPJf0vTJMRTiMx1h?=
 =?us-ascii?Q?GBNRJ/MwAcsi0SXvZbUVyWKSPOJJrRK89pyA9vJq4ZDVOHAD4KJFw9KkVGW7?=
 =?us-ascii?Q?lHXT7DwnyZ/DcZ57gdUyweLnA6DbPoCx1aSB6YsGRFUJqOC7WxTfXNdvR/vM?=
 =?us-ascii?Q?ilKSwpLKLuNvdBCmeuub939WorCVbvk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4e7e35-99e5-44cc-881c-08deadbbd024
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 11:12:09.7208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/myHFCliauT4+pdG/4ppGf0NBj6dNLY3CVCaTW6y/VM9OlYgYk+ceH//+mxpRC73sTjBvvysoO0L7UAB+rF0yixEj1AOAVsGcodoaJytSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8617
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

This macro will be used by include/linux/bitfield.h header.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 29e0da48de8..52eea4f8380 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,6 +15,7 @@
 #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
 
-- 
2.53.0

