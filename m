Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF6BC43602
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F2A384A60;
	Fri,  3 Jul 2026 13:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="FDd7E1ax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AEEB84A4F; Fri,  3 Jul 2026 13:57:04 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14FA184A57
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqvQpIgxixlVq8qetoRQc2D57XKytcIcTszOgNyrXyJ/TbRZ+/wWumKv3ChROI5L2adqvnAnTo3nw3pe284VQT/7lro8/Ik1oNHEEvSObu4IlVQ6KmiaRqienbwK4xqyt3NcMOsyyTUA6M8vkbmd5vUv6Ob4bCCJYkstJb9YHXd2XiActaUsQZcyBZwnrZZebujPzvim05vj1ujGGu/n0rBR4yXOkKm661n78vVchum7Rr2X8jOZq8OKEK6QXAWi+7IpD3LcnpqRh5S106zK6f/PUjmpmP4EIBolv9y2JJqAbFXahe6jDEUTlysfjnqEM/r2rkSjiOJhBU5kQbHpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9oLkkvNLNznxyGSj2vXo6P+Ji9aLKD2+M7/PdgTtoI=;
 b=Vn3GBJI/QcYu6ARM6PgRU/EaWMAuXR5Wlrqmw25ns4W40C3KHCqhE0lS7SXpdOZGuneiD1vn/rntC0CBq3J9UnjC2lXQ0gG/BpTnrNfJvfwbjEPKTDahT/W1RP5yhZiOrONqZ1NklrrOuNI1OJYCXGEwwEUcyDz0wQyd/sm0nMuPtf67segqeM8crVdJbzyWGmt9iQSYxTP2eyWPp34w/a2/siMzU5PLlHz2MrRNOyhgDRnquRBPCV5wbaPh0fQPymnkTVNkaVFewsPS72sL2HX7Y/YlVPm+TBG0i2FrPg6Glj9R9mY7ywFc3Z+V3pv2GEbp7qzgt8IRbUOPJD+YcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9oLkkvNLNznxyGSj2vXo6P+Ji9aLKD2+M7/PdgTtoI=;
 b=FDd7E1axuhiXnEUUGL37TPM5QRr0Lh5pMtrZ2vbd4GH6cQD3UzUd512HIaAsfMyfWEIyGfKGphl8YsqELSabIIZCpJKDewzlE+KBo1A1/PCWvokhLSdUSe38AhMQApreWwv3BeiFx9gio0TFpV1vOjYyuYFWnIwIbUz87uH6Zvr8uTshufeJ3nwfhdmMBp7tNfiG1wYFAWAsTtu6Yjx3qBBK0cFtJboe+CQB8xMp5cf1nKLIyStQbkheP5kTrEWdYD6wRtY3HHJXtVBhdJb5cAmXRhudyR1lFAYOyhTXonV/5pe97camH8iTsRBZrJ05K91Pa2KyNq1SBxccvznCTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9448.eurprd08.prod.outlook.com (2603:10a6:102:2f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:56:55 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:56:55 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 06/24] board: renesas: gen5-cm33: #undef field_{get,
 prep}() before definition
Date: Fri,  3 Jul 2026 14:56:09 +0300
Message-ID: <20260703115627.2317120-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: d72b5304-8854-498b-fd2b-08ded8fa2da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: SiaKkqCwgc8FDdv6zt9fv6Je+uoarAHWTW1yarzLeg3ZOb1eW7Cdp/uX4zDjZxZLW98QmQboM7a2EqUbDg1LsIbGfM/V6dWcAmFIZbgpKm4K84Q4LpBgWAyzrOiOIMW8VSv/6OSpwUGDsdPVLggbCFBVO9rxUvL5WFxgLDR1lHFRN1wG0wmVdRyV9VBBTM7PEHFZ4flHY44/iwlkRFRv9aTxbNUqkdm7gBxjiPc51U10iVY/mV6YTdI4Ghu2/W7PfS4N9inLuLCtypFR7SLSWbLyB4sto7kuOk55nQ1/y523aTVQn6xTtzF/8d2ftzTFvMBjvRcKjMXzcgwZxVtian00BquO/s4h/z4MqCBKII5j9yRURPvDsgWS4Q0hOE5MnCBouEqmflR8PA7YeHzOSk3J3y5SwFWz/lqVKpAETF/S7jFlsrKX3qt8eZRoI6cCHR54wvha1I5OU22u0rg8NWwwpMaAOCr86zAjwMqCJdtUenFhuRoRc11OwoTwcsB8qDd4cFkR1NjrEEbbbH29MXkTJPgGzmDnQR7Nr435vab4oRiRkQh/1wrl8TRY5fx1YOueS39xHZf4Uy2PIdWCdf1nRK/CtzMbLlTsxhHs5hA5yKpd9HFRBYhTSLJkTipDmPt2SbUbvCbHsylNw+6DQccXnCoqcf/wk85z1zl0FIdZ9vSxK8tg4H5HRF21f6h2MJ474uSwkMzN1ivCp2+RPGX5CmmmTeWKkoVtyJ+sJnsWsogIWyGMkGAXLrmedg1d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2KQ05Ftn09IRVahpuiNnhYzfcQ8aQGwdVNUQFMCrsB/b6NuOmkt1ikW6SW24?=
 =?us-ascii?Q?sVrN0sjLuq9L3dt2Kr5LyuOS8jajZ9qHvdHRwnvvFNmVJq4ApHI6GJoIuALH?=
 =?us-ascii?Q?3kE4JlTLKDG0d6FpyGD9l15w/4UrGYBUgoPMrkE+mo2FFXM/9mFTFVJwFJQD?=
 =?us-ascii?Q?LXLfZcluFt/t/MSi+Qi93+v3NxrKFDhoJE/Fbmvx4IpgLKBTzw58Tp6Oehwd?=
 =?us-ascii?Q?SfZvGwxPRnhjsCxBVW60oVQl8EiDzRgb3hqcY3EL5CNl75Ez6ZJYdkw+ikF4?=
 =?us-ascii?Q?rm9rahllo1mFeEiEKnz9AhcvVcbFrd7OHxk/0Afse5jGmhwvxw7UQvJKhvLo?=
 =?us-ascii?Q?hip58OaNvP1ZkrB5vmnGvoqtOardv6k+p4wknsE8gDan5tfgca/Hx5zrS0kh?=
 =?us-ascii?Q?2miRgw+LSJbw4n49kU+m9haVKf36AoOl9UQbz5gZMKJTBLUMJTbXLLkI1fFd?=
 =?us-ascii?Q?L4n1bp9YOK+3EtF4YxCSM3KCfA4lSrH7x1CIguQbT26gZ+Y2CvELSRx0ym00?=
 =?us-ascii?Q?FCRMPLAj+q4XVKPiZO+wrJQWWGsC7Uw2paFgRr7jmagR2B7o+o3kVHMURXFD?=
 =?us-ascii?Q?h0GDt90549sIKw3Q1ZrD6A/uLy9HazoJpXFR4EsoqDxkrykstqJl9STDW0Au?=
 =?us-ascii?Q?ow3//2v/IGeF23MG9+d7OACdJf1m7yo2WQaxaU//Jmfg5SIvuWlzsqNYoj19?=
 =?us-ascii?Q?BQ5zZtOzXd1y9x80dZ40PMUHWYSomfPbyD5/yPTXIUYcNTreUq8RpHv6f88U?=
 =?us-ascii?Q?S+XqQrrblP0LBbMxO+0u+2N6acb0rhR7izk2DeBUXwGAiJpbqAYfnYGkYiPi?=
 =?us-ascii?Q?s7XonXm6FBfiPTQ2jBaDMKJlLpHn3qSkm5eDMqDBsmq90SAv7o8NpB1cRLVZ?=
 =?us-ascii?Q?AOSsr3lkrBznCJHjwGGYWE9Z3dU6k5PDZMQRfu63CNBeZM94fZNHqLgNhXgy?=
 =?us-ascii?Q?MwELjD5s9Sy2KVXzKGu7sBDIix9dc44qL7YqdT48K+m0Nd0dlnFUQad5p+Ra?=
 =?us-ascii?Q?fxjOMCL7ti+m9xGwGt7hZiho7bFj/5buUEbYom3OOnZYQub2wyfUaxNL7D3s?=
 =?us-ascii?Q?Q3JjldSWfkFMo7rLHmi1p/PQbQnJ0EwHFkdChlw+PtbWTY2K9y8UOYyR9lOb?=
 =?us-ascii?Q?BNLCTvRJomxFO1HFAKhZOizzjIfom8rP7St9V3K3DRcshjTaZAFt1fVn3Ysw?=
 =?us-ascii?Q?l3ePn31iwYIa/a2nInuw0aqCuRmqzL/g5HjW8VmCayt2fYFrt27l+nWgzEMR?=
 =?us-ascii?Q?OlXlY+o3wuyjpnPQHO1u5liu98P/4Piz9VxtX0vahlUJJfDpvQUOo408k4r4?=
 =?us-ascii?Q?KETAnN6ACDd5QTe15jFgnIRLi5Ab60ERGNnBBBsVq6640MKmQTn2Lqzbij7r?=
 =?us-ascii?Q?kN8y+LP2XLUiWllXhetChmaLk2PlVM7EFunYGuvfZl3i3R1RlMD6FVlMgBIy?=
 =?us-ascii?Q?FYTvqocBA2SjcQpUaQTPbu3RVN3CJz/oqDsZ7kJ1ioMm7QA+xF5B0inPQhdt?=
 =?us-ascii?Q?6FLm5dX9/vTtT7WM09iFNL8QitnLMKXVed84HaqbbXvMjZvsMON6donDtfFq?=
 =?us-ascii?Q?shppCoKi1P7Ftbsf5k3qgU5aE/aRr9O0vn6ODCwBMvM86lQdHPYV9WN3qlKQ?=
 =?us-ascii?Q?vDg7DZvNCSlQ2yKHbdSLd/W+VXMHzHfS9VXd1EQ1Mt0ttLFvmfHycfekubtS?=
 =?us-ascii?Q?1ADAaz1boItbYw00IGTYc/uUK4oMLBlICriaNdmTXT7Ygmpz+fEr12RufF7C?=
 =?us-ascii?Q?lWDuU1zYdMpbqgLyDt2iBPGFVPXvWXk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d72b5304-8854-498b-fd2b-08ded8fa2da0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:56:55.3362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbakTqIkJgPyezAhfppYnA1GMhpoX9bgL2PQBO88HaTnGoTOBs+DAPSrA9a6/epg+4iwycVLihbKWPVQiXO1n862HptYj3vRIch+k0lel5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9448
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

Prepare for the advent of globally available common field_get() and
field_prep() macros by undefining the symbols before defining local
variants.  This prevents redefinition warnings from the C preprocessor
when introducing the common macros later.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 board/renesas/common/gen5-cm33.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/renesas/common/gen5-cm33.c b/board/renesas/common/gen5-cm33.c
index f06df824019..00280c142d3 100644
--- a/board/renesas/common/gen5-cm33.c
+++ b/board/renesas/common/gen5-cm33.c
@@ -21,7 +21,9 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#undef field_get
 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#undef field_prep
 #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
 
 #define PKC_PROT_LOCK				0xa5a5a500
-- 
2.53.0

