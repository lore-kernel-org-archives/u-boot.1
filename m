Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1722BC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599FE84A3A;
	Fri,  3 Jul 2026 13:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="2sWhOnLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 536D184A0F; Fri,  3 Jul 2026 13:56:48 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26150849F3
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YS5TaHpMUkrph57HlFVZEWXmlt8OaSVTm9WzrAzonVVtcDVOUgntGoDJN0EoNEiKjhOzkseBb64tFYRlrhSKwi5avvsj56en9L1m2V9qnhzhET0rbfRCFQDTMAyAvFko8ANuWsNrMMKfEHtJcPXHf98a8KdZNi0/yOSGnHQltxY+9l9bxKwaRqfYM7vDVo24yUK2Oey7Q60pioTKirxhnZJvkuLcmGOE7JmONzdvLLVFYjuI7O4ZZyri7ir0aOvkksOfkSEgYByycAUY0ZFmPNy/fx7uEq0X151sM4CQMZ6cdRpxrPVI1lyu4VT3bAEHAl/i3NNvLMqrUP6QZiOnpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpqCdsB15+5pZvdDE71Wyob+0zs7ROZ4/MbplLg0bdk=;
 b=hYBRl1kOfp064nFRtie04CDYLUdyXb2oCwj6ke34QFhhLL0aZpSbyGXn/gazjkxr+iJLMfPPZRHIQoft+StXQmmxxJcKo1SvFKcaqaETHROyaORED5+zg+HQY767Nw7HN/TlZf1DdyVPgsJjbBRgADuJ/KS4NjaF2xf0boMS/S5wK+nffdWWlqIsCPDnGGsaLuyLioaNTUbsZK5L7LxEdvdrcwRpxRwIZyfMXiprcMb/7txwpaR/USQYb7x1gn7e995HM5+eXCY+rkyDJAw6M9yAjLDD9ExSL4LsA6m3RHmRFVxEM1e118lTlyS3bIKKuQA9RPbC5Xk5XtsJs+XnOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpqCdsB15+5pZvdDE71Wyob+0zs7ROZ4/MbplLg0bdk=;
 b=2sWhOnLxvU761xBNi+YohOf5/WA5FYruyY4PEdncEnhu5PQYfUYWrIt9e49EgKse7FAihlIDkO1t3cVN5MelKb9eJd8an6qIxA8pFTGalDEul5Hut5GzVWkruIeHd3apoBgTb5dNtTLT/bahqlyK1zUQlE0J4iWXRFjVyibX0jiiHxghsxfUTPK5daX85hcUj2NenkcpwzGVn3Qzu7iIIv2AZ9TlLQaLukGc5V45DbT/Gh4AgzxQeFCQMlf6HhrmOv0FWPk6Kq0dmrw6f1CysFBIn2PZx6IPSdVoBHk0XCKX+HgzTVK0F9Z0pwtE+mMVPrECEbIOS8XD8YaUIDUBNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9448.eurprd08.prod.outlook.com (2603:10a6:102:2f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:56:43 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:56:43 +0000
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
Subject: [PATCH v15 02/24] power: domain: renesas-r8a78000: #undef field_{get,
 prep}() before definition
Date: Fri,  3 Jul 2026 14:56:05 +0300
Message-ID: <20260703115627.2317120-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: f535faa9-5656-4ef6-8f94-08ded8fa269d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: k9t7WXclhLFJDxZe59ciNPIvZqlEj/p+HOFT7ymwZmIDeGQnM5iqVek1PANQSTz1Y7jN5mmrWsahyp3j9O7oDlaAYxpWD/5x5M0KgmSuEMo9dcLSoI+pnQqYXsr2lf/Hz+maCvXDTeHA8lnvn1rqdtvyduFN08RW+W8Wx/dqfD3xRGvJwOf3Myhnd5wSzPTh4L16fTemOJ8coK88IHgM0NDVDyd+Hys28LzvKb5YqZbFosyicTbf6hvEn31jVpC7dd6Jp0rocvTyoi5s7GUbkdybN9D3CMnagbYI4VA2vbKwjejczYwVFJMfQMKJKG+4e95aV6jvaDxh7AMmxzQu17JUpQvIsfbKEloAAT8fhz6K/hRUqjocZf93waHpY15DtdEbsXFRXvU2sto171SzjUc8+7WxDll3Ns/UbLYJfg/jqeXbENkHCzIzkzSn7mCR4d061VHsiz15s9TxSoRdJ7Pg5YVWCYef4TbdL18Kzsu3iqtB04qj+KJvld5A1kCEjWuhj+TZgjDO8nEamo0EUn7t3SbJapVGAUFy+sjHBZom2PmuI/nMkAkb4O94M11HucNuwBSPrqeuNNr3v56GIz/aIpkh4fZSsmD8dXnI7C/JKAq2vchXLc1+EDjTqVo9mYzSwOeuX/Ar/A/4hN2B215BJz/oFRwR5LWIPc0b97lH2tJ+7uuFzlbykRMx6l6z+JcXC0+Ze2wX+e10Y/IEaWRypDYxMVK3nt5Q1eH/+2rsf9F41h202oiAlpQvDYWn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iSeMojQtVXG3AhkErmJL4y/VeoDO9bp7aSJMWJK7zUEAQ+EZ5QOKLxsIZ+cu?=
 =?us-ascii?Q?rklZzrX9M+1SLkyEUfHaAYKEvbL7n/FR6wM8uAD6m29WHLqmg7p17+f986G9?=
 =?us-ascii?Q?psk02cUB4AD1WySGhg62nBl/N6U1wtSEzAo3ATEjgQzh/YnsUMymzXLBpwj9?=
 =?us-ascii?Q?waSyM16h5+iVsKKawkHr/qvLw9LrgkyBByCS++xf0Q+d7fIUlqWxna5DdewF?=
 =?us-ascii?Q?KOSlD2ilfuexYoIad5gYeKm+DlckbhDBmMxK1T4c5MOCWYFSL0QEHDmjgRyy?=
 =?us-ascii?Q?QOplN3j87IQuEbjzN9qakZ3bRNrJ4rGJpZ/ySibYo8jNQWrd6AqgmdqpYRa3?=
 =?us-ascii?Q?rY01AKo0hMIY0ETVJ1CA7AoHkuy6WmfagOTAwTRBlGNW0yUtr3r4U6FSJ8Gn?=
 =?us-ascii?Q?/2UAnsgda3tRh4fNIR7h00i6FQ2aXcEzT7MvFU4Cxx1cUPXSwVqXniAO0J/7?=
 =?us-ascii?Q?g1ViV7Q0STOPQ+qBxZKoWeOSmr+L5uo0ZHYnK6L36bSlDdvoQ/D+In119Aw5?=
 =?us-ascii?Q?Hm0auIenlbAdcENNS6cTjsiJMeTeOsmJiRsjI95sszjbZzrhT3l5MKjH7Ugv?=
 =?us-ascii?Q?lD40veZLTB7PA0OT1fGTkB1DrWyCGA2GKcD3ED+MhMgPMuha9trlSy2zQ3M4?=
 =?us-ascii?Q?7TFa0tOVtdMCBogvYPGuXOYI+AyPdFQa6TspR/I5+3lZe3IPzKEgCMNkBK+Z?=
 =?us-ascii?Q?oq67UhbWiH9sbYqKnz2B9+Qy4HL3TXIQhtjRWvMadef+YMoJjgWkZouvNxIt?=
 =?us-ascii?Q?8CIl+jWk2+tvpmToTh66dS8zeaN/6uRhyO6IlYvzMyZLfcdzrYOs3VclzZsx?=
 =?us-ascii?Q?bZq7z49d3Acc3Yj9xhq27d0rxDBcg9/GYB/ekxCQrIfn+CpoTPk0JrsDkbJ3?=
 =?us-ascii?Q?aXqEnyXduwOo298JhfmC/l34R0RQd+3YcMmcb1pnk+8fZfDLMKtA9DdZlyH3?=
 =?us-ascii?Q?SUrHt/347jyihDSac9sT6AfwJtzPEVcU8ZPJQ3cFHeTrsBjqRhjZf0z5QF7V?=
 =?us-ascii?Q?DJhkNFF2uJTv791aETzGWPCCe72BVpkwSeAVRnYhUxdyMRtTWpyYvZJsCLoE?=
 =?us-ascii?Q?9aV7aN6GL1p5Y1tC2arH89acy56Knxb83r0nRv6DyGWzOm/v6KN40eKFCUqw?=
 =?us-ascii?Q?JKfnpbaRMUPrQMwYLYiRGzEdJ2FzV18XyNjE7Lt9M7iYq0rI50PFqCvfHhG+?=
 =?us-ascii?Q?AtathJ2TflIao0D1j19/cy5OCpoxkncNPDZCRvOMWdn8Sz13U/xDNYXaaLCC?=
 =?us-ascii?Q?J026Dgpy9YCKNe6/pZCDGR8tb5ufR6nSWVdxZIEHNHALqBzLAkidkbHxMall?=
 =?us-ascii?Q?cbsk15BCEN4J4ioPWZmYW0xz54ScBXANhSnlxPotp/LQauQo33NhfZ8NqXHR?=
 =?us-ascii?Q?1jvAw4KCx6438ZSmtSKHVB3nGA6H5XA9xeXLub9zLsqk24Te/FB2S+LjM1lQ?=
 =?us-ascii?Q?4wYcZifzmo8YO8MCJJUf1BdmAgy+lZSadut7yBbYUByNFAp8pMWNxjHy8tEg?=
 =?us-ascii?Q?vQaEjNzu66TBxa+A/eqqMpNnpSQvwuzKANQ5bzmNMqnZb+0vVl+E8dBzspW+?=
 =?us-ascii?Q?0EaXr2ih7UdLC2SG7FbmGQf5vGaS8Iat3gjEr9Tqlg2aurg32tFKiX3U8tAz?=
 =?us-ascii?Q?E6TB46yLh8VlsC1ymb0XsKboI3Q+a1vS+UTHvijF822r8OETyZBxr0cZwK03?=
 =?us-ascii?Q?jg1tibABx6rx9LA0ffXkTXYqMLTlFuDqMmNkWPJimFQbPn8AtMnO8Lj2YShG?=
 =?us-ascii?Q?+54vbKQ88H4h17qXrgQimFt+POjD7Ig=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f535faa9-5656-4ef6-8f94-08ded8fa269d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:56:43.5760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLlk5WK/qozUbYgKWiGlsHVq/iKlZtOZj63y5Pwew7p5jY/38nPp3QC0EwBCafrhHyd10oyfyuAJMmaIrVKwi7lyFFdeZEekhIGvIOwoanU=
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
 drivers/power/domain/renesas-r8a78000-power-domain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/domain/renesas-r8a78000-power-domain.c b/drivers/power/domain/renesas-r8a78000-power-domain.c
index d621373f90d..23fd35cd7f3 100644
--- a/drivers/power/domain/renesas-r8a78000-power-domain.c
+++ b/drivers/power/domain/renesas-r8a78000-power-domain.c
@@ -21,7 +21,9 @@
 #include <dt-bindings/power/r8a78000-power-scmi.h>
 #include <dt-bindings/reset/r8a78000-reset-scmi.h>
 
+#undef field_get
 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#undef field_prep
 #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
 
 #define PKC_PROT_LOCK			0xa5a5a500
-- 
2.53.0

