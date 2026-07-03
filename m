Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8107CC44500
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F9584AA3;
	Fri,  3 Jul 2026 13:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1uXTzUd8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2870884AB3; Fri,  3 Jul 2026 13:57:10 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA50E84A4F
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdfIBQ53TPTVdLLXE3Ti0GMxnPulu65GGCjrxgygWcCbYlR3DxlLgy/nDjZxH6NIRBOsJ139Tb25UXZW9lSwMzIcLNRGqjvwJZQFihymFwalPdwfZkEMYWUz6WHwboCzVLXZLHHVBq1IIb4NxHQQwNgOMFk+rayBCu2lUgHfo1mtammBqC98mCRxTsERl/5vWL+kvs/Qn/ATp/tComjR58QqjERnwOb5LwOUUqeCG5RWbauZs9Zo2+h/Gcio4DAFpLQiluQZO1/Sc6E3EtDee3vrsMlExGgBRIB4TY4XA7jDSTZ1Yb3CQI+QQtRZhaiUCaqQUN8MThco8m99K7Uxew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVzaTsFMg5yPhtRqh3cN7W18rS0JOFMx/YbGp2N4u3E=;
 b=azi9BmhkXsZWocGa26XtTEC4BhR/2EemaHuseLjmgbYcRUVJiGyp5U0OrVvBHTZrOeE1wRBSkIR/6agkS9fv9uFZ/VHxqyt8MoKuHMOWyXVVLBp4xWia+5MLBJRAGWFR774pJJ5FXVdUgl+/7cbT+rkFworT+g3DJr9jMAsz8ulX8DbvsuR4HeDIBBM13kdqIDCJIZTcuHDk1ULtnaWiCPzzaqeysKt4Hf1pdCK78UL2mL0SuxW5FkGIYzjyaJHbowA7tSd20k0BaAueeJwXS7QJA1ZDr+kUM2iqlELdudI081qB73Zw3fA4gQt3qZPKJhqOhSCbIUJXbOsxCBiR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVzaTsFMg5yPhtRqh3cN7W18rS0JOFMx/YbGp2N4u3E=;
 b=1uXTzUd8sxWT65TOdxQ/BY3PYOHj6gu/0E9JMQ52tWFm+/YuyKCoqJfPEK3790R6bz8/uUG6H0aYl6XobxZBiEkeKZ0+L9bva/4NCgVv0gK3Ft2XroVf397/iNGCy6/E5c56U/EhCKgUkFAwSxn4/ADy7sGo0t8jaWHFHGv/AyD03Q7p9DegdwPDbyJirNblyn+nzDPDVfrwt9IQqqVQ68Tm5PY3gHcBZSEpoVYNwBVa1OA+431E7scg/ZZd2KCukeKCxC3fi1orqzhW+4ocAJDWijtNPvbN4rPZYLmvnSUm4LkMzsYwMtQe+MeJ7jHWRo7F+KfZenluWsUAZBwFDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9448.eurprd08.prod.outlook.com (2603:10a6:102:2f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:57:00 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:57:00 +0000
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
Subject: [PATCH v15 08/24] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Fri,  3 Jul 2026 14:56:11 +0300
Message-ID: <20260703115627.2317120-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: ef146bbd-5adf-4537-3ad2-08ded8fa30e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 2w3nWc+KGiisVkqKQvyE6NmEGWycU0ZOr2GLK8mWQbHcbEdSYlWY+Rob4l8HVhb8IGqVACrdUkgCO5rYxelsW2aOLaEEHb6AIK7+fd4vK1+FiZRpvf4zGeGL22ct7i3JmdAQkPHnptAEz19crSSPmch6yp+GgNCbXO4Y9od8DE31HirDUXVshSZ5/BYsKwOGXDkKVgyUiKR/CvPvJXyedXy20Aw1+yr4ix1nJmUfEGwt/cMevtLr7g3gOrEFVxLKzNICuW08wCiuekvRUffc2pbz3Yn6I0r3sEQZuEbMMZvpAS1rq9TmaMfbkwjyffkGF4B8ZPEM+pC6nqWKnjQHgAVU5qf1Jajj+DG9DhnJ+rY881hVrlu0O1bcUNAXRpBmdAwPzasvozJtY1WnlFo7AeJZa3U0SbVDeoqHlxNsheOiHWwQTBmIOMTi6oQa57Yj0b1Vq755aC0UywCyd64EMEcJALMOOQMM4VqwdRE6Zkz5VvPldbqxuDUEGXQ+4Zt3dYY3mNqYKwH01e0m+qJ0oaRqO0CTuG5kh0gPppxnCztoMykd4yTEZxzUiqUNx1x+6AbNSZTr0UYMF70+nsHTRE4YYTwMtxjWKBfwSL6kN9/FVEuZGRiyEySXRuECBKS/qb2ZtiQMpNV89xXIh6Lu57SW6JAa2Ou5l6umLowg5hmufYDrQccr/r3d+xrDpzBt/fOJFa3klPgqmclKkN/sYb9iKy1/dypFvXTnVzPyKs9Gm5DV/2Oxi3DFQN/tTGtc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PJoJm1vU4U6rRV60hVuegAJxLBmDSZSwGovQPW/PkjvoS1TC6+qRHtEEfoV8?=
 =?us-ascii?Q?2C8FPEoSuehv4MgJjICRt95XHRylxiGA9pNfwnhzCzERYSTMZFrT10+8vREf?=
 =?us-ascii?Q?96wtCMhqDM3VmUKfea1c8lzKXCI7yGa+nA6POlkUVD72T5E1rwVFyiEi6BVt?=
 =?us-ascii?Q?6bHp86zT/3JrfKcy1NtpuyLD1/+TtgCpGq1ZdIdWXtJULi9XVVPwwHrIR2rO?=
 =?us-ascii?Q?0Jm8vCLqVPuJKfJeloAk7fRXHwFESEDW7DUp8yz91JtNVrFjAP9C12ez81rO?=
 =?us-ascii?Q?+6Sh9RcBF/3QeDQMMCM8d86Wnh4Tv1UOw0Zh2wRkdk52pkivT3BJUHVmk+3c?=
 =?us-ascii?Q?ul5OaJ/NEq7sxIiFjWXPtCU2f15WZjF/9o5FnFteGRulGWvgY4xFnWVLdwFt?=
 =?us-ascii?Q?keXooITE1ou/adkgI9lGBYOBPtngO50XEtVKVmMW6tYovHDhooJCw8UVS0Ns?=
 =?us-ascii?Q?T6mjk0bWwWyRqqLKMeiw5n41OfTL8JugnbYfhd6+RKbSUOTxxP3/p8p9DQun?=
 =?us-ascii?Q?OFLFwiIhq2KVCpmqkXC2JT1fLihvjXdwbL4mSDtuePXL6aVHuQ0r06gtHfGG?=
 =?us-ascii?Q?mTN7ge+JLSVGKIdA2TMkWhCiV7HyG3rJ+0yITGKUqMHY+0X/gBe0xln/MHmj?=
 =?us-ascii?Q?mFs2b5FdZfDagkwwdPEiEmwvs4z17ShgP5IP1WXoYb3eXyAJikr8eHIIMWHp?=
 =?us-ascii?Q?SRx7NN2YKW2a5fAOF1QtpEMv4j4UbKQHypYO5OgL4Ysx5Liu7OwuGuss7Ncn?=
 =?us-ascii?Q?dAOUWtSNsIXj4n7pXL9Aew1AiK+Gvd9dFrYFNhGIEo5HOIaf2z1RUmzCj/2K?=
 =?us-ascii?Q?v+/dwY9up8U4taz8BIi21BUqccV3/QT4jfHTg1YcqcGW2hLqCNE7uVRk5lE2?=
 =?us-ascii?Q?/wrDypdifJFmMl/1N1A54MggUUFH2gFftmcLhVnB6TzUqiyTwRnsHSAJ1Foa?=
 =?us-ascii?Q?vJK1AhVbAm232E/ApB8jazULMKz99W3OcArlhac4lxmd8BM3DFM/zWyDh160?=
 =?us-ascii?Q?DGRAk3UmcyaUsTtqjJZdeBzqWgpqKVnETuzPCWsrXFR6RcLS54fG9ub+QVMV?=
 =?us-ascii?Q?m4ej+20xbO2H8mHaH+QUf2X4WlZuF6j4/k7z2gAsOLMNmSOMm5Cz6T6SrE44?=
 =?us-ascii?Q?gfvRjZpbS00eQ4apET3qCMI7La0vkcrIzBkZGLSJhOesWilEZrF5b5iwQr0M?=
 =?us-ascii?Q?0G6DoeTYkS05s6xf/yEsIioyiuQn3Cin2MZ6BXPVV8BbUI5l+S3xBkcsz/en?=
 =?us-ascii?Q?WzPPBNbXS4SPhshOsU34EUfTBcb7TcfOn1nc6Q/S8W6e42qQbiAyFXokHMJF?=
 =?us-ascii?Q?4wSnNvj6QpX+tUgoGsz3U8lHWBfpQORY3ccsb8o0wbpmICsqsOAwj5XUitpU?=
 =?us-ascii?Q?mNGDJtLfZkmf1ztA9u+t0opSyWPvNioZJn7KntPkhC2TSnQF2+EU37QePoEn?=
 =?us-ascii?Q?XOyIdUvlc0npP9DHLNdPyZ7oGwcV3PGa8xTGDML6KTB9USboPyyE3vNRZogx?=
 =?us-ascii?Q?Jzs/awdaN+6iSvycfQYEqJFVfC0VQK1ItH8fGKpZ0hqWHuO7AiRAp6IMvrqV?=
 =?us-ascii?Q?ptubmonF/FDUSD3ArOyHMBPuIWTP08Ms1JAIv3Lp9Nz6ZHyyE5FjKL8m9G8C?=
 =?us-ascii?Q?oihRRbiEg2q6NuvSEQfGEDP5ZjBdtyqHx60InulaOBwsfocS24goQRe42ocD?=
 =?us-ascii?Q?BI5R4KPXzJBH9AyI8lyqy8x8yrBMwNJfLy5337gvBPmOAn5iKOXSP9wgmy8w?=
 =?us-ascii?Q?G9dWHkkcDgpTGGviLlEiSoQ2ejnTP6I=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ef146bbd-5adf-4537-3ad2-08ded8fa30e4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:00.8743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqYFrny53ZNgg66Kwhl8SZ4iftDv+idpbmsxFMzZLKsOK5OhrB1pU+AISwT+65g+wPuTYD0eFRExau/nF60R36GRD217CJAtGvb0y+HTBpE=
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
(long) long" _mask types.  For constant masks, that condition is usually
met, as GENMASK() yields an UL value.  The few places where the
constant mask is stored in an intermediate variable were fixed by
changing the variable type to u64.

However, for non-constant masks, smaller unsigned types should be valid,
too, but currently lead to "result of comparison of constant
18446744073709551615 with expression of type ... is always
false"-warnings with clang and W=1.

Hence refactor the __BF_FIELD_CHECK() helper, and factor out
__FIELD_{GET,PREP}().  The later lack the single problematic check, but
are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
used in the fully non-const variants later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
[Linux commit: 2a6c045640c38a407a39cd40c3c4d8dd2fd89aa8]
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/linux/bitfield.h | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 63928f17322..ef81901bc41 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -60,7 +60,7 @@
 
 #define __bf_cast_unsigned(type, x)	((__unsigned_scalar_typeof(type))(x))
 
-#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
+#define __BF_FIELD_CHECK_MASK(_mask, _val, _pfx)			\
 	({								\
 		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
 				 _pfx "mask is not constant");		\
@@ -69,13 +69,33 @@
 				 ~((_mask) >> __bf_shf(_mask)) &	\
 					(0 + (_val)) : 0,		\
 				 _pfx "value too large for the field"); \
-		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
-				 __bf_cast_unsigned(_reg, ~0ull),	\
-				 _pfx "type of reg too small for mask"); \
 		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
 					      (1ULL << __bf_shf(_mask))); \
 	})
 
+#define __BF_FIELD_CHECK_REG(mask, reg, pfx)				\
+	BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >		\
+			 __bf_cast_unsigned(reg, ~0ull),		\
+			 pfx "type of reg too small for mask")
+
+#define __BF_FIELD_CHECK(mask, reg, val, pfx)				\
+	({								\
+		__BF_FIELD_CHECK_MASK(mask, val, pfx);			\
+		__BF_FIELD_CHECK_REG(mask, reg, pfx);			\
+	})
+
+#define __FIELD_PREP(mask, val, pfx)					\
+	({								\
+		__BF_FIELD_CHECK_MASK(mask, val, pfx);			\
+		((typeof(mask))(val) << __bf_shf(mask)) & (mask);	\
+	})
+
+#define __FIELD_GET(mask, reg, pfx)					\
+	({								\
+		__BF_FIELD_CHECK_MASK(mask, 0U, pfx);			\
+		(typeof(mask))(((reg) & (mask)) >> __bf_shf(mask));	\
+	})
+
 /**
  * FIELD_MAX() - produce the maximum value representable by a field
  * @_mask: shifted mask defining the field's length and position
@@ -112,8 +132,8 @@
  */
 #define FIELD_PREP(_mask, _val)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");	\
-		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
+		__BF_FIELD_CHECK_REG(_mask, 0ULL, "FIELD_PREP: ");	\
+		__FIELD_PREP(_mask, _val, "FIELD_PREP: ");		\
 	})
 
 #define __BF_CHECK_POW2(n)	BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
@@ -152,8 +172,8 @@
  */
 #define FIELD_GET(_mask, _reg)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");	\
-		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
+		__BF_FIELD_CHECK_REG(_mask, _reg, "FIELD_GET: ");	\
+		__FIELD_GET(_mask, _reg, "FIELD_GET: ");		\
 	})
 
 extern void __compiletime_error("value doesn't fit into mask")
-- 
2.53.0

