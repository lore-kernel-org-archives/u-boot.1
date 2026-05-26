Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A0ECD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 00:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0A4F8494D;
	Tue, 26 May 2026 02:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="POREhx+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E606A848E7; Tue, 26 May 2026 02:26:03 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1494F848E7
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLmf9gWR16MwPVmjDw724Qimb7aZ55uvWVvmWpjbVW5Xp9HX1bLU5TZLqnDZsT1XLgDGE3gHuGl5mlKfnat2rTvWGc3gD6RZy8d+GG7gx2T6O2SBGsKpVSpzRppS34EkbXRGL3+9Vfl1vlJh8wNwbXGj13PYq9n8n10nl9s1Sb2W4+ReMkTdELM0PN8y5exEgsEm051Koz9iFcmvy6DPWmRlV0BKeHiFrdWd+8W07IZElm65PbWgsM8P/WWCYV4rDXJLWSUoUolAoEy8wtlY+D60iGLtIOrcDriobr82X2RevxMJ8js4/i8NBK15jPEUuHAt9tUO4IlMOdJmB+pk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=guj8HGJTQmAv7xuEQHi6Am6ORSIrBtYqLV8aX5ZWu1WPbCkDCwtOCUuj2BM07x7Vpu9tWWy9mUMOBSXW8qtGq2rBze6VTp5tbfhhPhTAHoREd4AHq2nOlUu521lxXt3B+a6oouLGkbuqYX/RINr4ST3dhSGXtOfNSiIfUxFsW/9xinpy7+ijVJXGThY0VS4WNaCXRHsGx5CDiJI0HtjB4gkRkMQI67wFdsOQFGCEg09SuwRyZmILHp+iGVin0cGJhACQ6APmSDdImSzwJxevTlp1kvu0xZqflkX+SoeinhReeaDIfZU+6CTahGXrsArieTDG6p6yZjpgTBfGDaDlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=POREhx+65w594X7IvXXNN+9V7EL5XXPNLUdgkL24Q5w2SuTsKbm+xCqI3rCRRloZPIkAGO4+28jVadB5rlr9Q+Fa2/4hqvjwbYjbc8qmQC0qWBlsS9VpIOD6Xk29l+HeDPXMvxLifqzHGeO4S2eYiZ/FhGNRci2R7LM9erNQGCXmw7CBnnNSrqVci8Rxdxiea44IbAGnieHERU4iiiqWp6h3xa/bEEULZnfS5aeLmpbR+syj7tuaNowj/nE408MUqIPyN1S04QXGL0bKn2f3KoGWLJfj/aiHeHWx6FLcmHicrA3HKhpdvIJtqHtQBQsc9c0GNJupevUDk7YiObHFNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB7682.eurprd08.prod.outlook.com (2603:10a6:150:61::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 00:25:55 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 00:25:55 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Crt Mori <cmo@melexis.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v10 03/12] bitfield: Add non-constant field_{prep,
 get}() helpers
Date: Tue, 26 May 2026 03:25:25 +0300
Message-ID: <20260526002534.898340-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 4008fd7b-4c63-45c4-b1c8-08debabd59e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|11063799006|3023799007|6133799003|18002099003|22082099003|56012099003|38350700014|921020|9063799003;
X-Microsoft-Antispam-Message-Info: CJbzY4Y3xDEih9cmNgBKHHK4+Y65u/RgxUNH2NFbmxlO/qmuuDmfGzltmtePhkth8QQY731F7BGEnPkUW96aPvxbVA85UoCMTK89qR9FfSE7Pk12wsZuBz+TuqIbiyizbDxCehU/NTbjh2u1V0wFQKa2gDujNXQEmYsCNREYoClf79loqFDbPNJDH6g/POidCeT9eKYkWYWlfaNRmWAK8XWbYHtufHP83AQnAChHZPiq8sIT1XIag7k3afTdJGZkmHCYC40ctVGIkjv9OUozH+z+IjjtTDYI9zlDaHe6AMVKM51n/I7xe0HdkE/SGS3lvgyOarxBrJ9aNP0pt2A2TzJkacK/RHNbmilWyK0F/OS8SRX9GlLJHzBNFRuYhjrt10dmgwfisERVK0u7nnzqkiW7w6yNW5gL+UK/vCiK2J2CTuzvI9WtdeYs7an700olyLKZdjrJXDcxe0DrxC6KfnbP6iq+ulrXe5pgGAq+RzQp2OR64F4VwkVuCHmRz30Cr1kWjPDpnz8rUPKtm3Dmt5FdyOvRtdnOt40ajHzSJ/jD+N2cRQ/xPp2U7fMeOZntGvm6uH/2Rc8lyPyDNLgCi5tz02wWlmNjES9XehmI6JBbyqMMXVIaV3GXO4jOecuAjNRnqf9vP03fOY3wPTlRENn2Ch3AhwI3AGqyWINnvS2bBNyysP1HmMdQ5T6JIUyQuLTwNoi363Q2YH7LngJi6Z2n5njnhXfwwx19Kif8FCpOQjoAaooswFWkphbBHNTfOCBZgfnbjE5AWjhCtY7Btw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003)(56012099003)(38350700014)(921020)(9063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmtQbEhOSisxU1dHRHRpSittL2RwTlZ5dHFFSWFJR1JZWVhQUjdzSGNOK1Zo?=
 =?utf-8?B?T2tOWVJlM0IvR2F4aURWanhsRFZzTTFFMVp4bkg3L0hxcjdIUW1rOUtGQ09H?=
 =?utf-8?B?RWRlUnE4NmlFTGZuTHZ4elUyY1dZc1hpKzVjWVc0dm9RQVluZml6UVJNL2Zl?=
 =?utf-8?B?OXdzbGU3MkxKNnFsc2xNRW01a054dHZaZUlPYUpGWm5qTjRKN21GazhPMVZ5?=
 =?utf-8?B?K3RYOS96VXF5TFJTRms5L0g4eDgxOWFJczNsbmcybXIvdXg3enlqb1E0YjZs?=
 =?utf-8?B?WTBoalNib1dWTVNXZkxWdENuRHErSUtxTDhNc3ZkUDJQMG5QRXdBS2paWHJD?=
 =?utf-8?B?TVM4NXVZR1BacDBYZ0c4V1ZoaWpTUDFPNGJpRld0QkpmTVYzSjhlMy9zcE9G?=
 =?utf-8?B?ZVNGSk5uMlE1L0pFSytnc3B2Zzh3cnVLdnNuVEdFcmRkVGVaTWYvdGsvQTFa?=
 =?utf-8?B?djRWYjdpWkVhYWlDdXRJL3IxS3pMdVFlbm8yeGtFeTZXVDRSRlRpR3JQQUFZ?=
 =?utf-8?B?VVJhTHVCUXcvckZoa0wrZ05FejQxVmF3SW1DU1k4OTJ1RlhMOTNuNmMvNkhX?=
 =?utf-8?B?Z0I5ZVFzbkVDUXUwMTlYODNBeFI2WVhZSDhacDFDMm1HU2FTRG5CUE9qVHpT?=
 =?utf-8?B?c1ZyOUFLUmlFWUYvY0piQkhIblBOZnI0NDBuamRXV29GbG1BOHhYSHdBTlhh?=
 =?utf-8?B?WXJvSTBkWUlUZW5zWitHNEVpWnpQaFdKU0c3WSs0Z1Q3dXZ4UGJuQTd6Z2o1?=
 =?utf-8?B?WHRkS3V0Y0k5YVJLS1hHVWNuUzJHeHZpdGVPdXg0ZTJnWndUM1ExaDk3RHdJ?=
 =?utf-8?B?Q1hnbzQ4a2c0Y3o1VkR1Y0lBMEU3T2FnaUxsU1N1NUNNN0IwbzZJMWFpb0dU?=
 =?utf-8?B?SVlDNjNoWGJkeFBMdW5wQUEzSGVoM3dtNndYOXZQZ3BYVkR0OHFrbktJYTBT?=
 =?utf-8?B?RGxKbmszSUlPWUZvZzZIeWQ1SDFZS0E3UWhGbXlFQld5WGhWY3llQU9reXl3?=
 =?utf-8?B?L0czenF5WEh4RUMrM2FVVlljdkpiRzkxSnNPdEp4V0VKaDFHOFFPM1JJaUJJ?=
 =?utf-8?B?Vyt1RW1DK0lpYlRnbnc4U0xBK1BpSTFFdVFyZ0xodzJNTWtmTXI3MXM2U20r?=
 =?utf-8?B?Z25TVTROcGFnMnkvM3pTYkpweWtIVHlIelhMS3Z6MnZRdTZsU3dVQ3ZMU2M2?=
 =?utf-8?B?eW5DMEUrZjR1R1N1dmVCTHZKamkxRE1Bekxid0NSMGMzdFhYdGs4WmJBVGsy?=
 =?utf-8?B?a1kyVFQ0V2VKdXdwS3k3VEg2cVNFRjlkTjBzYk52dktGUXBtL2NhRU9WUGNO?=
 =?utf-8?B?SURoWHRNazZlOFJvSXluZDBBRVBiVWFFSUJ6YTZ2WXMyTmNhZU9XNlF1dGFC?=
 =?utf-8?B?UGNWYS9yTHlNcWhnSTQvYmVnVE00TUtMR0J2VVAybDZ4a1F3VVdTbGVvc3dk?=
 =?utf-8?B?bytJRE0wSkNBM05xTmdqMSt4RGpJUGdoOG9FdTkvSnVzZWttR2x4MjdIUXRy?=
 =?utf-8?B?RmxxNDhmeVMxQXVmVGh1ZWkrbHhFMnc3bDBEOVdBS0tMVytNVVZlSW4yZkpV?=
 =?utf-8?B?WkRrbkV2bXJHSHVpeUJtK2txcFc3R1grK3NPbU9NcFZNay9OVGNjbkUvMnVy?=
 =?utf-8?B?dkZ6MUR6TTcvMzF0cktHYzdvZ2Y4ekMwQ0xNank2RTJzRXg2RFVCU3dteXZI?=
 =?utf-8?B?YWd4NDBrSnRFOVljcUliUFkxazJEMXVFdldqdi95a3hCVmp0STJ0cWwrV2w1?=
 =?utf-8?B?UC8rV1k4Z1ZNS3l6czBiRG9YM2JnTjI2Q29kSnQrNW0xWGhVSmxFeDJJRHUz?=
 =?utf-8?B?NmpEaFVYY1I0Tk9OMVQ5Q3oxL2ZadE5LMHl3M2djV1ZDejA5N05hRCs5S2hS?=
 =?utf-8?B?STQydC9tWWZvREg4YkdrMUVaQm5HMUdycDdIWkUxM1NDZWUya21GVlZaaU9S?=
 =?utf-8?B?cDR5anIzWnQ0VkpETVJQTDdxZmVlTlk1RlY3WnFCN0ljWTJ5Y2tTZUF4ajB3?=
 =?utf-8?B?UUt5U2pNNjdrVzdmc2RlWEJWQ3JSK3NGYzFXUkVtY0VoS1VTYUU0cHMzQ2lL?=
 =?utf-8?B?VU5nc3g0MTZyTGwrQUIxeWpzS2hVNUY2MDJNazlCZXE4WTVhMjB3ZnB6UWVT?=
 =?utf-8?B?QTRjWUQ0YUs3Sy9BU05iK3AxZ0dzOWthTHNsclQ3VUNxVG9ob01qRWdnampp?=
 =?utf-8?B?N1phTC83cG9rbllWQTJ5c1I3WTdaYVYrNXBqbVgvMFNlVWh0K01tK0N3WSt3?=
 =?utf-8?B?V1g2a2IwR3VFWWZrZ2V6OEZmMUNoY29wTTlFenMrOGd4aTl0MWRvSEJIdVFW?=
 =?utf-8?B?VmNHc1NrYk1mZ08zeXMvK1FlZW5TSUFGc3RkRXBUOEJiZFNVMGxFUmlXVzNG?=
 =?utf-8?Q?7zwMTm7l4w+6YVz0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4008fd7b-4c63-45c4-b1c8-08debabd59e1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 00:25:55.4704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKFM0k3oJvWqWlA5BxMkiuXojxzHNZftUGNSRI45/TFbj0q1Vn62DJiaW8vjV23snMJvQR4tUnLTlvg1Bf98LGy3ch6q0G2lunQQz/rsG0k=
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

The existing FIELD_{GET,PREP}() macros are limited to compile-time
constants.  However, it is very common to prepare or extract bitfield
elements where the bitfield mask is not a compile-time constant.

To avoid this limitation, the AT91 clock driver and several other
drivers already have their own non-const field_{prep,get}() macros.
Make them available for general use by adding them to
<linux/bitfield.h>, and improve them slightly:
  1. Avoid evaluating macro parameters more than once,
  2. Replace "ffs() - 1" by "__ffs()",
  3. Support 64-bit use on 32-bit architectures,
  4. Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
     actually constant.

This is deliberately not merged into the existing FIELD_{GET,PREP}()
macros, as people expressed the desire to keep stricter variants for
increased safety, or for performance critical paths.

Yury: use __mask within new macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Crt Mori <cmo@melexis.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Richard Genoud <richard.genoud@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/bitfield.h | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index ef81901bc41..18cf57aeb2c 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -16,6 +16,7 @@
  * FIELD_{GET,PREP} macros take as first parameter shifted mask
  * from which they extract the base mask and shift amount.
  * Mask must be a compilation time constant.
+ * field_{get,prep} are variants that take a non-const mask.
  *
  * Example:
  *
@@ -223,4 +224,62 @@ __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
 
+#define __field_prep(mask, val)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(__mask) __val = (val);				\
+		unsigned int __shift = BITS_PER_TYPE(__mask) <= 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__val << __shift) & __mask;				\
+	})
+
+#define __field_get(mask, reg)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(__mask) __reg =  (reg);				\
+		unsigned int __shift = BITS_PER_TYPE(__mask) <= 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__reg & __mask) >> __shift;				\
+	})
+
+/**
+ * field_prep() - prepare a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @val:  value to put in the field
+ *
+ * Return: field value masked and shifted to its final destination
+ *
+ * field_prep() masks and shifts up the value.  The result should be
+ * combined with other fields of the bitfield using logical OR.
+ * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_PREP() directly instead.
+ */
+#define field_prep(mask, val)						\
+	(__builtin_constant_p(mask) ? __FIELD_PREP(mask, val, "field_prep: ") \
+				    : __field_prep(mask, val))
+
+/**
+ * field_get() - extract a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @reg:  value of entire bitfield
+ *
+ * Return: extracted field value
+ *
+ * field_get() extracts the field specified by @mask from the
+ * bitfield passed in as @reg by masking and shifting it down.
+ * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_GET() directly instead.
+ */
+#define field_get(mask, reg)						\
+	(__builtin_constant_p(mask) ? __FIELD_GET(mask, reg, "field_get: ") \
+				    : __field_get(mask, reg))
+
 #endif
-- 
2.53.0

