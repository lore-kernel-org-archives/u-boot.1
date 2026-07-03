Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BACCC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1376284A0A;
	Fri,  3 Jul 2026 13:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="4Va5T8PS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0574784A4A; Fri,  3 Jul 2026 13:56:51 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FFFF849F6
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbKuMuShuRGkChwXbDfsMvuYjsFFO9NkFqZSmDFc64preLadGRRam6wzTfMylQTKXN5xAA/SBWYu5+ILl+Nq//XyPRLzBpfQRYgqoQhqankAAvIH2y4fCeJhq+in573ZAtLBvu9+j8Ygj5/ws7K28hmfXp7LzZVhdQ8siDeaqdX/qOh7ePp6Zcb4Rpopb/XC/6scZSx6gVd2UNTJsWGKFuQUWbCirNHnMVohLXw/trgjW9LDF/JwUuKB4a9Am1IDQ/zz63/JsxzrLN+BB7DG9tUtItXf9L1AaNmJJd3ca8RmAINmyd+/c8L84fos9ZJKDrCb3Zrprt4NJ9ChlCHSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0tueNc3UFauJ9PMpl4YiV+lduYkEOeFk4DIhDFSEv0=;
 b=J6ViDgKqXvQIOO+hpmzaZCLl61NPOuXDNIHiY6JdoYWrwcxNknWxZqpu/YjpCiRDEh/rxQjvVYvI6IYHtaNzNha/JbU1M9TEGYUO02iFejIjf4lkAftHWPlTUt5pnT92fSyhLzEg6QFQ7BjV6ORbsmuBnS6U3/7PQpjiaiWac0qsnB28/yYexFMRcd9BOSxRYrISeSYnmoyYvCcch/uYDiG15MGKz0shPjoxO2YhrEqURJ6Bwy//UsUgpDjWtMCognW6oiVUTv9Pi9SSgtu7a/jQVS23B4KxUEfwJNdRB1YtyhrXD5GroKeCSPpNS0LODhZ1f9M45oF/a/Fc/MoklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0tueNc3UFauJ9PMpl4YiV+lduYkEOeFk4DIhDFSEv0=;
 b=4Va5T8PSHBX6mB+IJC8mt2/j/BZaV/Gj/rDfpK3ch0Pttokom7R3Ih976bWnO3QBruKzwmHUNV+D2qpL5qJCvqF9vshZZRQOJ9lkXhxu0WLbAyxm55q4D+x3WCMB9Gzw7FDltdrmKoON/XhsTuVLZq0TPD/Qcqr7PCH9bm5zI3aVvpF6Sl+Wu7bPpaZWkvJba7uHjlGGQl93WnusfzTkez/iBQJ9V7Yr9PDu9X7EmtbGQ0eMpXBapX4cus05EKmhPccOIGRwfJHA8xlGnRLa1YiKJnkl56MCotdvgsL/e7VJinDsN6RXdWbd0iRnzBZmt+VsaNtSDlIaM79sY4Tk2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9448.eurprd08.prod.outlook.com (2603:10a6:102:2f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:56:46 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:56:46 +0000
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
Subject: [PATCH v15 03/24] net: hifemac: #undef field_{get,
 prep}() before definition
Date: Fri,  3 Jul 2026 14:56:06 +0300
Message-ID: <20260703115627.2317120-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 55bf5404-2d52-4c21-00f7-08ded8fa2844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: uKMwiH8q4sJIHbMl9uHbfK8cXpRlqvhoPZci2DdA/ZMxcRd/+0Pf+sPKE3+irv74oudXhd+1kNdTVVKR8F0tcfq7xuSaQa8f2eyyf4h6FnVzUj/bp6VFx06VUJoKiidlrLvV5+FpfpGcLjnu0xnJWWvrxlnzbTXW01VrwVSNk9F4NaH1g5eQ/0heVs0UgopOIOSBf/j3E1FRm9oWl8RPcLKUJV8Xwpro4sgVrRrMS3zLTJlInE9BFHsU4Zuz6/HKLwwnsbUWV6Rw+VyrBEn/dJOj+Yu28U7giz9pzmbi16jkX3V8PcyN4bqWIgFS6STUB5kvkXSUbAeQQ5iJJeyC2CcSO06WzewcKIFXI5dXPRdv1Fev05c1Hu1bkmPwP7wkcBJ/vTwsLGNeJzHiE3MWfTmJpMzajaZaClwfmb44H5wBjfTbabK6fcav75bMesjjWOcQTMNvz2Erv0VMRUt1pSOlFYVG5HXfmVhzxDzLZqnCdd97+jvgCjLhCbGSwF7nNNW2lIgCyEI7r65hvkP8SQ1AlHLokeKl1v/zCVNb7h7H/yDxv/y4nFJ6r9mHtDXYCxb2fvu8apcAYtIAUoGo4prWq8/URwafg1q12OMVht4kp/EaksVJuLyqvN3edO6s7A13Q8NaqqSl2P0hkjVsB6310uKLKuNl8mWEGlCoCX3NxuAvKGifSEQUjLYq/aYQ8FkFG5+NRvpRTMBAVVr2lUWSHP3qLO2H7xrvCN7wfvyhVvX4K4db3A1+0xthFSiD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7IA0Sq1/RblXAFvDvNqvNZpn/XkrA3x4L4/k/7+n13W2+xByfSxPkf1RE6FB?=
 =?us-ascii?Q?GXu7kPO1ZlmtkyNmgJGb7OtlElPRx0l17rHGJ6YtFcowpdAAudu3x6135jtQ?=
 =?us-ascii?Q?HfQrZV/pH6DhLh+8VbsnHyQXEaSIat2rw5okPKi5Rc4BQHQ4S/WCU970rJsj?=
 =?us-ascii?Q?mLJMTDH9+vHpBrzi5bat5HOYuDS/eu6bagp3BVOXg6tIJ6o6UU3bCC5EfhTj?=
 =?us-ascii?Q?OJOQxDwV2atVMI3h/UlV0q5Gumar9Sq3GFgvr2TIIhCbOuaj3YmzEAn1alFh?=
 =?us-ascii?Q?TKuw0FymM2hJkPWzDpLFT4UGBfzJU0Y19zq04yQHEZLbhAlyId+5uG33u7P3?=
 =?us-ascii?Q?N4st5NHAAwbgM6jWdVcBygUwzxP0Kp9V4ZqwqZTkD3Hl0xrl/Zukiqie/jBO?=
 =?us-ascii?Q?9aaIZQX59yVIuJaudNAZ+DenVHS6K9Ld1sxCgTotQ8GpZ0LOVgyxDzP5Qw2A?=
 =?us-ascii?Q?+hG1bBAbMFxgL1W8mhbakVDJIUsiVRagY2iNJHZ4UUGGyy9UvQLmD7YXUklV?=
 =?us-ascii?Q?fFLkUgs1fwV1eFdrvojvUBYsEaLOA5AlX2WT5crg+/bL3NhRySv9GSiFAh8z?=
 =?us-ascii?Q?ZF95fcH7SwUCogSf7X73Ty6LJjT8TGv4O8nAB3gqqMzsnr25M8CukVfp5qqC?=
 =?us-ascii?Q?PTjwaFPp3OeVOyLQqsP8jqoB5fhcd9MfpqaSkQ7mB0pIfLXFLeM/FMzIWYgR?=
 =?us-ascii?Q?RXyJM8wDriWgmdS3q52o0evt+mzJE9NK1zs7ywPJki7ylQfB+7mrXiB62Y5w?=
 =?us-ascii?Q?f4PNhNBxdLW8ifg0CNVZGJ337hDE435VbVTbdwYfaSQTgMUsXTQXWRXWhN2S?=
 =?us-ascii?Q?J5uu/VS5QwdD8yAgaNOlouepqg9T9s1XPmWjiYawJbxV/3kWZfdxyaz0U3xh?=
 =?us-ascii?Q?+OdFj4OnvCRfntQ8vz3TEA9wX2G3sN4n8VvAXY7NuTdlfxIAQ/U3Ag/lHDdL?=
 =?us-ascii?Q?vSXx8Cx2Z9A+z9L44hAGzo398Nm29V3wT3exkdl6/IVA0LUP78o+2WbR+6ou?=
 =?us-ascii?Q?0U9awWqpE//xW4eiNTbNQ+p4QUtqhPTwfE1uv0RnD7x4D81CGm/VHzLWJww2?=
 =?us-ascii?Q?htyJtv1s1taM/ma4qRunNOx2OwTFtjcmqogETjMHqk3jqlDCoSKKq+FHEY8Z?=
 =?us-ascii?Q?K8OMY8jbnA4i/ybm8JD3D3a3KvuLa3fatOJuN8cbupmdxmI55Bf/HkZLWAQk?=
 =?us-ascii?Q?c4iQMqlUpj7EEgc6Tvavb1em7fTOosfnYTspnd+xUurZOdhZFAfPU5Wd6iM9?=
 =?us-ascii?Q?Wwa/iHzpJKx0xdOeL53ql41PGn0sm+m6lKL9oiKneICsxdm0d54poRbRKmSD?=
 =?us-ascii?Q?3gr3xH8knD1WOoPJfoK3+qjoAw4GhZmZzZjuPftQCWHTdgZK7DGly1AvA57a?=
 =?us-ascii?Q?4tT9Anjj0zmJuYDduye4Fdjdegeurx8o6jujX6QIC985temrKt5h9oaPhOhw?=
 =?us-ascii?Q?jtbER+aJ6grESmj0K8hx5Y8Zm2k7k+NZGrLaGxN7mU2bXh4WlsqmIsn1Pil6?=
 =?us-ascii?Q?UCm7o6V0/yoeGMAA5wg0q4VoaI2a9YgeYKzDRgfMUuycEoEpr5q6UQSqHwAo?=
 =?us-ascii?Q?b4cYnjUZp6L9udv2mbzCaO4d7yC5/Xpe7uGj6Jy4XkwP7b17DZ1ZhYRkGif1?=
 =?us-ascii?Q?d9h1c7jLn1FWac56kW9d/9QBUYkggfeOwUyMIFJNJdv8g4hirGC09hiKmSJA?=
 =?us-ascii?Q?MtxSAaHDZSFGLMhrGuHuwk0qmQvOHAZ/OzFBRMqsy5vIBhzUSCDmvZ81RWXJ?=
 =?us-ascii?Q?ookcFo8zzi06Xi4Yt4vUC2fpPROI6cw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bf5404-2d52-4c21-00f7-08ded8fa2844
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:56:46.4552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCo6ZWHwX7CNop+CBecqsQiOLVnGEPgVDovd3LXusTlb8bSORmXOPasq94jBc8CUyzXq4Guwif0b62Ue8Ne0irCHuWm/oYbAosxRifWn0wQ=
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
 drivers/net/hifemac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/hifemac.c b/drivers/net/hifemac.c
index 62182f922f8..a64665c4023 100644
--- a/drivers/net/hifemac.c
+++ b/drivers/net/hifemac.c
@@ -402,6 +402,7 @@ static void hisi_femac_get_strings(struct udevice *dev, u8 *data)
 }
 
 /* Non-constant mask variant of FIELD_GET/FIELD_PREP */
+#undef field_get
 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
 
 static void hisi_femac_get_stats(struct udevice *dev, u64 *data)
-- 
2.53.0

