Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780C5CD4851
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 214BE8489D;
	Sat, 16 May 2026 03:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="G+v9seC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59F38488F; Sat, 16 May 2026 03:00:54 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95CD684713
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 03:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAOGoid2rFf3ZHAnEVGtKngZHZjKTVEpKXKUL1P0ueLMun1hmk9Q7PwEO9+vec3hMzSHOCS6x/xPWZu5WDkr7HRtWsGRm+ICuvcISuvrwbdzwZ/3IRzH5uXdF//36NcFu3HEayjLXTdcAVehoJKj/TtAMxaHqjcgtx0Tf1uzzngZ5FIq9H5qOsHOqaF77QUVIIqiMwT0oZupFjQu/ERP0VLP06AW1Rg/sMsuTqcgqxLS34IJP8Zj+h1AnfW1iVZUXzy6i6AL5fg4GhV6Q9gRlM8yaK5JGpjyANHYdf/SHGkL6ej9MxNOP7pe4GQcS6sg+2GYroT9nAJXhErFhGC89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=RgAfrOfgRbimZt3mL+RUuzb0rmmRKXLSHHXGowQVOyUoQwGqvA3a2mMPjGR0hFgPcABZ0FRSUZLm1oSccV+YIPqZPSBjPKfoVd+FHouyf0XJsO9psVuVkuvTnfaB7ozWdvcJ7yE4vVgkCyo3JufdWPAEkAAMUv1tFO9B4zayfSI1WuJ7GqX0vbBd1DH8NuKtB0Zov5wJYiT8YtXqBp90BmkGKEE9HtMtdlW06DUFRS9AljeGAQzxGvjn4OHPICSc/9KRtNqpf4LY86NAhc14S5gBgqA1SSHsl/0sIlqvvUvfWtKSSWaSDSm7jzuunx4kaCdxjOwvcm3TGolzcgNzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=G+v9seC7S9etClzrkYi9BJDC5I/cvNshbBCRyuhtmaMQExoZ0Sr9zcJrYvlwsaprjyGOKgNIOtfD3tPQ87R7bR06Yl5S+UD14e3ihzEQieEycaU+CSxfxgVgZYOKSWBDW/qAgPOjCj9WiZHEMs0RLrgpUf4Br+cYJBMjDvWwO0v4MaqKFBBZaZHjS+Adw0kD9kU0MSXtl85TaaDBvr9nAlwdLw/jXeu4/G/h6ZjE5Bolbn/S+iZQz33q/LTBUX2f8I2vFXKa50rdxmBcaVeyFaMurGo3OtMUwkB5Pv2cxucY/U+ATrhB85D8Vl/b5puZRslgJ9ai8zusaiSXTcKI/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB7917.eurprd08.prod.outlook.com (2603:10a6:20b:538::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 01:00:50 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.016; Sat, 16 May 2026
 01:00:50 +0000
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
Subject: [PATCH v7 02/12] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Sat, 16 May 2026 04:00:25 +0300
Message-ID: <20260516010036.1034352-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 6b90b129-6c17-427b-8138-08deb2e69284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|56012099003|921020|11063799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: rO6GqerkBsVGDPFtyEJ5Mp3UfbP634IxpXZZBS5sfbeAGeN1cpIAaSy6aIvm0R1HTT7KFkE0MowLUPum8dWU4vZ7xmLeHlwVI+XOwJFp6Tkt44ekpQI44o0ONYNeSWpSDIy7L6QRzX85Og4NqoLKDW/LLExxc0WuIhSB6OaQbYEvWOuOI4fntHkZbXX10msjnZTwqepxmK18ZFWDBfILjJqRIGTI51x/IF1Oc/RpjaISVdyDPKWgzI6rNK6LWsMHp38Q3wPxNNXpBWdLMYw4ParhJX6cKWAjpoW8fL3fg2SBha/PMU5kRRqjHbExc7UO8Osz2A9g9GxrEtIX4Id1l/NIdkbVIP9OSdk+1HbqC42u3o2Qp1yRMtP5YiGvZQrrTpV8MqJLiV8EGB+7SLjtnSPqrfLzmIfngBBW4B/xZ08UnZFVvgs3zOdmmkepGOO8I8pC/DyYy5RDaJWI3+F20SW6sOmx0ny8Ae+YtCBeaPrvsBszP+yag6w9DhUKTOdV3YmBPwlJtb1pIbzI2mczPp/uoMTZC36qqbYjRnV9XcjXo/uVWNhcccIRZYWQp8km1ExJZhryD+6LMd5D25ZSNhh3zE7TxMTz8fJ+gQPQrcgkVX9/NJ5eFQD5HqyghxLiUjoms6Zou7miNLbUkzmZnuXoslwjNQPUUKk5Q5FWTSx7w+6nximm6OxS+RHwB76oF61YoP45aEhi9vtHZZ5iGS/XsOJFpCbJtfkw4JBhnMPTNSscXbrPVPwLHrDkeG6CUsaQ0tiRcYRjOyjPBrqgkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(56012099003)(921020)(11063799003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/UYfNvvtC0mIfdW7ghJGbqa0aNIwV9sOoXxaxdTsV/ObA5emwttTSM8mQ5vH?=
 =?us-ascii?Q?rzWj2XMoQSrhCkub/chdr71McSdGbpT3BDgowZoj24Y9/muQJRqRbS/a+tau?=
 =?us-ascii?Q?lBFtaq0+IZ6qyzTe2YPn21D8UBQzDc2WbrxOKtrtxh0hPnAPS5o/q4ho37yx?=
 =?us-ascii?Q?E8tfJfFgVK5nST5PedbNa1SY3eM9+zIxvpTVHJtbORu+3obHLXIK3mydj7SG?=
 =?us-ascii?Q?nGkYH2TraXrAfB0AwuzU1i/iU2SgnfEBpsESfog7EQ1DRlxb7Gg7wR41Z2ib?=
 =?us-ascii?Q?2YueuxFehDMvgwdCdz/5OFxwUiQCFOtMY+hKukYMRRaumu8sfDH/iiiqgmnh?=
 =?us-ascii?Q?cgun6/OTRWslU3aiDFqC6/QJtxjsugjjxbic+W4aF8RY1IchfXRSRkitWNA6?=
 =?us-ascii?Q?+wNfvSArnvu9Y0drr0vsEaJc2Ur4K+cfi8VaNo2jeqVkcLDkxJqebVOIx2w4?=
 =?us-ascii?Q?L2gPkF6EV3jXc7qRYwhC9FQKF1U0XEibjw1D+nFhMBQ7LTyH7JsSJFv1P3DB?=
 =?us-ascii?Q?UZy0z1xDjHujjJ7x51ZhqIdxUKWLQudFJcifrYt2Uae0fXgKk2rIPn+Mc0v9?=
 =?us-ascii?Q?SukKKTTflk9+I8ygRtm0eDTpXcf0kVmjazijvgfH4CcOASbaG50uNEebPWoq?=
 =?us-ascii?Q?TZNoeBOPEV27jq1Z3QXHa0v1QCiR8Dp0/ZRbdKJJZp1dmT3EJqPZkwU+BnYF?=
 =?us-ascii?Q?na2IUoNR+SZNI2Y1Pqp9I46Dsm1VQA8Gu5W05QqhM6NMQaMrfyHDhvlE6pbn?=
 =?us-ascii?Q?bec+JzNAJz/C98bj9usTnzaFX1K2CwDfJVYtbDjm80QfS/8N/YsCms09Iwp9?=
 =?us-ascii?Q?wEVN22fubZbSha0fCwvPHClbRw7OpKmSyA0aaf5e5ZhsRQRlCqERBrx8Ibvk?=
 =?us-ascii?Q?wm9EDQa/DipfmvwwtOuFzBzy/VhTQ/l4NJbzRd+/Yg7nLemBqguCeXlBTr7k?=
 =?us-ascii?Q?hsOwpljfBNn4G37MXbLzAlpeLCNtGnw/F3YCK347yApNyZZd3T8O54fxcekf?=
 =?us-ascii?Q?rFvqHYKjgISxUooD8WkPc883BwKRlbJdPhVZ8TxswVn02JMGgjzaU0C8+1d/?=
 =?us-ascii?Q?rBnL99DVUP8MRxCCPbuQyq1053wAtzsAzlHUTvW+QEPsTATwjbVSFinDQpot?=
 =?us-ascii?Q?3bQFzoeagWvLRfxs1b0tCPLKIz/YwHN59iXbpWceWwk1CdCE6v6B9Uz1mwY1?=
 =?us-ascii?Q?58RmT4UEFRWY+4QJpVS76Ou2eg0NzU7oCbDT019qZSRdr9/Gtozh185loTnU?=
 =?us-ascii?Q?VygC3pFCjKOXopEskywXxG3O+Laii1iMb31Yc8u0MskyOc0cl7TL/DdxlnL9?=
 =?us-ascii?Q?mH8rwTQtt0FkJqjUbtreM6pLDJnQZGcqzyeEftgTu5XldveaKq9883IQCPI9?=
 =?us-ascii?Q?NgwazZaDh5lFLMeDO+UQWoqJKohhFqZXpXaCo95vVSF1AISX/nltITK5drj5?=
 =?us-ascii?Q?gXNH5eyc9yuj+RzcHEvm3A08yMVoQrB7/YiMAyfTiTi4tKpjMcl6kjGLgQTg?=
 =?us-ascii?Q?QAokx3V2TQiHcnev6nqzddk+TgnnJ0VRqHJoOzXER19ZxUCC2/tdASBMwJFj?=
 =?us-ascii?Q?uGDJvrb0oB77FfpnDF/XQw6OA6KizdHuvEQsLNszqzOGRAbwLxkEELyip1d9?=
 =?us-ascii?Q?azjbVbXX5pS9rLwe7aSUakrJ8Cc9jWeyBFSVTeBnKnpYoUfSZhcaY+aspA2j?=
 =?us-ascii?Q?xTY0oK+0cq35UNG+D6FiBIaTRFYFicwPZIh0SKEGT1SXz1F7CP1ZRTVwgAuf?=
 =?us-ascii?Q?vTPOUquQ6Les1Jh8JvDPD1IAGt5zOXQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b90b129-6c17-427b-8138-08deb2e69284
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 01:00:50.5108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swTby5Ya2p6mxMpU9JtXTOo/QiAMU3LlJBqEnWbjsejjf/IksCLFB/xnKxHO3B4ylokWPV4ZQSj0NfpXbhmX3CQ3KyqLxHyryBwpMCX4fAg=
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

