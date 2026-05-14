Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91011CD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E3B184099;
	Thu, 14 May 2026 04:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="GkCU4Cm6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37AD1846B1; Thu, 14 May 2026 04:56:01 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E38DC8469F
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgdGOC6pUTVytqXvGLRHYg3R1yiQ0vjP+r671q+bgX0u4ghiNYQqg7+h+huRWk3cQATaoFG4+tHVp+U1EcjV30mDElmP0s2cqsXrl0isTYKh6Kt4CMytTiofNP05BFjoVyrQ2FjkCOG+MhCEIR+9SVNWlsMxRLDQHtBItPzYEC9IYRn9qrRg0jIgvo76/onsqdCUapFZZgoufHiayVdJtZErulhHNqJz6/WTClbSBzf7mB3fWniHc5eF4n72RqWWPuhOpqDwKBxyYjrTzrUJoeBkEGQ8PuHkGlBL0fBa6+2VcL2dBeVkT8pR8hagrSG4oj+LCv/U7StItc/1dI7Fjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=BfCIa20Q77oyMAFFlhGkJdySZ1zlo1mC8sMM3kMAgU2Y6Y2mg1Eqf0qNjitRwKVzrU4ZpuIOaM7c/LSulxD9wSLe9WghsUHHe7bFLTS1z6wqNGs3IFpKFcPN9dmeJFnlST5B8Ca7rW/l4a6NzGUabFO2Fa61/ZMbVCwzPE57O7fNrvC+Tx2yOJVbwjbc5pQBF2Sirw/rQ7V/aXn/w7qsT8VqOOYhzGRn4yOUNhTkTqa+TDlvBqk+sSAW5MNoyNwZ9PySVOMVTRCvVJPbO9uRHynZZpm9prHTDm5AozeYgkRNJcum8sBmxBYuoIyA2dytUFnY9zQPUmk3F+BtRNqGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=GkCU4Cm6gg+2yxXF0tzllUAbkvtaJZbEMS+syPXow1uscT/l38z2BIou2CtnixF41n8KxH9iM2UeO7f+dAKK4FM5WVcSeOB/ACAT4qXHAJcoWcFNNR6R81RiKQ9W9PJ8ovt3UMlrndok8o1ETP3A0zyccmMZNINocRYjkYfglTJhNsA4x0c+mCZAsQwcQ/jHDwXt36ttBssQn7cGKMUgblIGcI5fjfKwcBG9/d8rD09BwGgsqZcophaEAyEgbVPfP5fpAey5q55DEV2Vf47p/wr7Tl9KbjKzOGPKocN39esC3ZYoc+2kKzYSwYG0HYaZULGeTyW3awtyVCdv3SxqNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PR3PR08MB5786.eurprd08.prod.outlook.com (2603:10a6:102:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 14 May
 2026 02:55:57 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:55:57 +0000
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
Subject: [PATCH v6 02/12] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Thu, 14 May 2026 05:55:32 +0300
Message-ID: <20260514025542.398469-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 809aec91-ffb7-46ba-4878-08deb1645241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: jqmB7ITkBzgyE9AZVs0xSVFPnKFC9c+FtqBVnHUlN/MPWvM/ozlyOKY/shKCpwKikk6GgYuTy33CcitX/8MGs8nKRB0u0sLcp1rkCBLV7w+i/D9WNsVvCv5jht3+AmF7h7zNzeiY1aYW62iH6OguxIL4A0fPU2jTuJdiZTnK6Hl3/8F26JtbuFkiR782d7iqh/0lvs8ob4YchML7f+A2+TY9F/ZUDqC4ctImUR8UyZIqxdZWYOdMXkfm5nbeNMsvxxuOR/QSv0LUK+KWZErO4d2TYPlLaYczvClKkZc2DUx/rgmJaP+X2xp0qMRbfXnfcoL2OAwtJ4/AJX/LlwueWiCcRzT8io5PV78tA2WToHVp7yk/hOEtLF3o3ATlztpZ8WcR8s7t3aEr/q38dQqPEgVH4yurMVTvo2J7VE8P1QjH0aZw9EELFk4CMlDXuVaAN2psdnq4K28qHOzUli3A0K+0UGIblurjCIJYLaaUfhGNeKH5F1lgGGxM9ZGHAnpq/Fmg7+ZXOo64bWrvhNhk4PUp/MNUUn9Eh9Uqk+OR9UvtcJtruuTcZ9zar9b13m5NmWt/KrT3PEuTLW4sjI+cYpJRRcPZF0mfEE4VX+L1C8Kg8A0oEvjxbKjfwqR3gWK4yEaomz1XYQEsTp7ycSkGi/E8ZYGqKC1wV1Qkh7D8rxpZ8LDCsHxU8KYMZ2kKCVVqC6SoHJ8/3kW76KYB0B0QTilf23mcfzAx0E62AgM+Rhjxo28hXR1QSaHSGHxOg8R7peDvJdaTpSXv2vOypxSMVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dy9soj2SCT01Vn5MqNrcKdAnwP5HYktB+xRYdqmPOfHbTb1s0e6L4QZHV9El?=
 =?us-ascii?Q?FW8CdAMCcGZjJ7a/AQg77ypwvwtF44G+Zj7a/R6Sk2vh68ba9uF3yzRioKMn?=
 =?us-ascii?Q?MxsKJpUt0akLgCnTeKOAXEh3CtG5Yd6/hcsaOPd2i6G33VSkSoJd/8tkdJmx?=
 =?us-ascii?Q?7BzG5vjkqVDRu/BYsqWP07mK5yUdFKMkaX/geySrL1BYsc64jwa2/1mJ86cd?=
 =?us-ascii?Q?qvnylBi9rWc5yfEpX0Riw3pGH7LJvG8Va97TmCpl7gjTwv9al/s/IGb5ts3i?=
 =?us-ascii?Q?BZRH5xy5W/RLjfLCfXnYRNLv7rtJJqnlMwR+4xy3gK8LRS6qYG8D03U/FOGj?=
 =?us-ascii?Q?y3YsSlGUgVyDtXe9p9RHQguH7ifJ8AqNN/AXg3VNkNsPMSOMMCqFGuHdv8IS?=
 =?us-ascii?Q?PhgD3KsD7UdZgDMPhAegNLElDwq5TpAEPd+1ZCwZCVER7YLI0vswwEZf6xVE?=
 =?us-ascii?Q?ZX+PcQeAUQgui3bRRQNbaTQAPLa6OR74X4+/ZFEUpSI/Ph5uiu5fVd3sKaHw?=
 =?us-ascii?Q?CFmpSLioBmtrmcg4jBdqXB5MNK6kU9JX22YglQfLgftVnXhV8xRQArxcvxHr?=
 =?us-ascii?Q?r5tVQjetyoMeRFOsjISvCLV0EZFJrUysWVrpc4iSrZzMryA6ek+3pabVz9hL?=
 =?us-ascii?Q?oCJePsgnsioYMAupk5TI9GDI6meNsU/j7Od3gO41PNeN1/QqRzwZKYaFpQew?=
 =?us-ascii?Q?wEifPDggeuZebJcMV9LnNJiXnwQHXQS8aDnO/scP6yy/qHR6v+bh5p9PleUs?=
 =?us-ascii?Q?Y9cX60U6Fqf56QTLkvz4oJ1mhOw0R2XeWD80DLvJUlZeWE9lMSCGwYzaXzM6?=
 =?us-ascii?Q?1hOvMKz1mZeR/zcwo57REEI3u5Y+LL2x7Ir1h5czteZ84W0EJWiU7+IvJbDF?=
 =?us-ascii?Q?7TdH9Sjy8VyA7U7Qcotc43eDqD6hjo1K3gjGR5X4Ka0d/LZ/jHbA6Y2jbjV/?=
 =?us-ascii?Q?ktewNhZrTR9bojR2hcTcyhFCR7wJ3TRHARWAUGyRgf0yQoStyvwu1i+E7mbn?=
 =?us-ascii?Q?PHDl/mJi3Y7pLG4K9c3WOTXr2xVvxtrzebKfpdZwaWamK/3jWlteiB3rpmN/?=
 =?us-ascii?Q?s2dBExlVOZCuxPXDnyBDN8gaMHydlwSJdkQYgp0U/zECWatDItmcPcj7W765?=
 =?us-ascii?Q?PssAoIHAeiFmSvn4QAdVn9AGVMyGWJ2ejIs2z4fTBJiT9yhxzYAtrTUJ2qpT?=
 =?us-ascii?Q?5tmHrjkIKFbtw9XHNkdlC2SKbOkKtGl18YZTeTAD9wLmbFZbzA685Zad3Rk6?=
 =?us-ascii?Q?oJ/6ZIFsBYb8IILMb19hHiZttG1NmODmqfD/3EWs9u5usLymBnHW0J6EKyPi?=
 =?us-ascii?Q?v8CgxoXmnSVKKSP50fJZxIQw5SATOKZYudNabCngkIOtaz6p7dgE/LQbtfo2?=
 =?us-ascii?Q?1+9k3Qs55Ln61xPjADFdC6p/eUjHmEcV7TdaB3n2GsSB/IzwD0cELvsXDQ1W?=
 =?us-ascii?Q?ziIFP4QlMPTQ2zcD0kEciFgtWDpd+uxSKME0P6MPt+0jHOOQPTx448DVL5pl?=
 =?us-ascii?Q?uAbn57z5nKpN1T01z14fZ+nOD/pM+LupscQXZZ8QYQdHUfm32OLerqKoXAPf?=
 =?us-ascii?Q?WAdPA8kK+bweIhSCxAD15npmsZBNmmpL0LAHPV18QvJEHsla05LFrDVoDH/V?=
 =?us-ascii?Q?NZu7PeVIptuTe4NUk+YKguSxwwHJfilegCNfzUiArHGO4tUj932nVtluPeO/?=
 =?us-ascii?Q?XNHZkjwrQjNeReB6G8esr4NKBpFmwNJaImyNN5IqLwPZkZlf4W4wy9+Yp1sg?=
 =?us-ascii?Q?GSzpAS7rlnlRZ/ssxAahlpwBwU52Qco=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 809aec91-ffb7-46ba-4878-08deb1645241
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 02:55:56.9277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhFZiOywBUnfl3hJ/zx3gSp0wTcNVYdGHafJqDlHo0zJgVewUMB7shFEcYsS/HW/4r3P3A5hbmx+fTOwspiTZDrACmX5AlLGJ0iGhVFktlY=
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
(long) long" _mask types.  For constant masks, that condition is usually
met, as GENMASK() yields an UL value.  The few places where the
constant mask is stored in an intermediate variable were fixed by
changing the variable type to u64 (see e.g. [1] and [2]).

However, for non-constant masks, smaller unsigned types should be valid,
too, but currently lead to "result of comparison of constant
18446744073709551615 with expression of type ... is always
false"-warnings with clang and W=1.

Hence refactor the __BF_FIELD_CHECK() helper, and factor out
__FIELD_{GET,PREP}().  The later lack the single problematic check, but
are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
used in the fully non-const variants later.

[1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
    HWM_FIELD_PREP()")
[2] commit cfd6fb45cfaf46fa ("crypto: ccree - avoid out-of-range
    warnings from clang")

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
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

