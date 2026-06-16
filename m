Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84876CD8CA8
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 05:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D367846A4;
	Tue, 16 Jun 2026 07:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wFjvAobr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 418BF8484C; Tue, 16 Jun 2026 07:31:27 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA1DB8484C
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2qAUjbh3xwguxUDym5486udO7wpO6Xf9Ivf0p61aWRaIsmitdGZR4UKNLpY32Gh/9/55UqVNmEHDrqBzFauPVFaj/Y9tDZMPj/2FkPl3HdrTo+5EXE5SUnbqNgk90jRqaPnXZHKl8n8p/Mvg+WTJDuE/7SHMcgTIjm6uHL14TwiAg6a1h14llLwvV1egFe4W8/c7c+5iEyEMe+vpa4X/OfUHCJcRWSOsk633EWcumV8Rkw0Lhb9FICzmQybvumtGmQQ9UFtdwNQjo4+etDRDVNU9alkIqaQUENwGNY8rt2VJ/iQUBeVD4aCj1XpsrA17o4wXTERk5ntk0yU1mvaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=X5E+j2BO29rGpvj4xI2Fn0WIi1lEKUAwtZzQrdNT6Ruz85OCD6NH3RFDpBe5/7IwYwCb8r657BxVARQ4jb8HP5KnyaLkqU+lGTlkike6XKsvP9u6sFXCMrupm2yaKWISy+kAWLYKRenpS+CCXTEN63xs+f8B5wNCkGRsjBK0BUWaCQxPtkxuxU/kPEotVb5J8v7jHezANCAXOOVnBuLD7VR3tqgerHbf0z9SUQR1G2Z52V8LfVYJQT3xMqZJixKnbbVfe5HQbPtOhAak0nbyTNCjfmyl/LrNkMtopljUmzi1ibxlglzeHwk27UwOCqsaGesHEC7K+PyYaGuZjdBtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=wFjvAobrvWN5kcV3kXsLU7KdvIxwlgCeOA7aIXUfpCVe3WX5lDQ+Hmp5WhkbJ9LVctJI+S0f933bZnIPEt3tfCsrINUW9MQajsQjerVlhGxhxxLuEzic8ucDCGEQRs+Hp5H0wLJvisM05mJfN14HRDeWEG0WFxcaKkFMXnhdNeNMO8HV1nWqkTnPNUwAKcM46PQ0oWUDetb3mBM34EHthwuofIsPitvpOLwceRMIYYMS0+VkrIVXoLGwoZ4tU7tlgeDAlgVn008vE/645yVxf1kgVIr2PNr1ujdF+bnzVuGsXSSzQcT4SNSiXrM9sLnhjPwqZIuhrbs/dDPOOcgfUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB8996.eurprd08.prod.outlook.com (2603:10a6:20b:5b1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 05:31:22 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Tue, 16 Jun 2026
 05:31:22 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v12 02/12] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Tue, 16 Jun 2026 08:30:56 +0300
Message-ID: <20260616053106.2623475-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: cb40c047-0361-4723-22f0-08decb68800b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|23010399003|376014|18002099003|22082099003|38350700014|921020|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 87eBXTYd8l3ysvVDBEwLisyhdk7GrS3RNHB+8djDSaP29gk2K8Cc306Tq0HFrynz2f/0vECw4mwuIO1tPYtfoNoZcLNVXAagU/TvH/6dx9EiGMvgARbwW+u4Ak82f5sIh1xjZlZV14dvq7izIkANWZynNjnK4p5aKAtWraPlXbVh8xBxi+8Ep6WpIQATOm0aYWaILTFsipPgtOBZjb7DG0pWJqhA+0cTTRLBe2o5eAfAe68H1xWnmmSvl7BH8OrbrIDq+mOaGHYw2gVQaetimsf7Dyk+237vg+eR+7xEtthK7B3UOX2WsRWkASYzMn4/Cf4ODdo8ihVQthhYolxZn8SdDQEnuznpG9ZrYx9H2YhXlsqKdWdntwOKO+BXzwODbiuS7CQ/ykkpXc5DOKCMv1ORlKr0Riuss5HifbDMXrucAbZ835Ce8NFYixag+R5BmAvwYabshVLRmAF/IBgBSmsbFJPn11wVK3f6WZAoYf62heS9rMErq1p2ZHYKSq/hmtBjb+R0RpI1QFUdeOaSYJMqUxJmmaUJf8mMq2K6lwxOh8Zw7h5F99G0oP7LlY3+rRFSITjOO4zMr71o4a01l/2hYT3MViJY8a7G8BtzPZ9fuyvcSTFyu+hzR3CpNIi8PY4aJSRBV5STY6Ad5p5KBKCaCS0hAjoJ0dDtQuYpegLdw2c0Q++9V4XpVTZEa2gGGIDA+WW4y+NKAOxaACqOJGOMit3BDONkwiVuzT0po0Uhg/U0CTmNz7iQw2oQCrFwCezg5tx01RBtd0/TaEekRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(23010399003)(376014)(18002099003)(22082099003)(38350700014)(921020)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u4hStSrQ10M4hzK0pFk5srMZBvvBA0jyrb8N7hX2MaXuYXUdV2svd8VV0Rk+?=
 =?us-ascii?Q?eaT8xoi56hJMDLzciL8Wvoa776uYCj/eTA5CwB+KByP/WLo39BSQHhlTNQxM?=
 =?us-ascii?Q?C0/BfuVOa19iMV84jZZdsJOfh+LW8qTK2AinRzPDGyK02T2YZ/Z8lKxyz2ne?=
 =?us-ascii?Q?Nix9LF39CXPK1NUk+x0sHN7ZJPl/gkyg0EEJK9pEO850ckX3ImYjNhaYcJt0?=
 =?us-ascii?Q?xlI/Tqix1BlO5Qh685tj5uP5vV9mmD6pSbcZ3qvW0HN34+UdaQDnDLjyiKjj?=
 =?us-ascii?Q?H/9vhp7SHu58ea6jQFQLRr0FG83u2z68vXf/265LA0Tv6y9NB6iLZtwJ6GMw?=
 =?us-ascii?Q?yuakCdsyPrXx3FRFrkcYFdzHPYUvdC1c7ySo0AlHQZYJxecPmPKaj06VSWaj?=
 =?us-ascii?Q?1Y1r7JOjSLvUnuSu8zqUFNNFUKb+W6l3GjXg0P+TITcKr17uQwkgmAgTopoQ?=
 =?us-ascii?Q?81fr1U002wR0YxsVqt1p+E6W9mxvaNMlG/v25utSoSCSbvxzjwyrDztbNuU/?=
 =?us-ascii?Q?bW68/JACsMYqRKg1pdSJLaKGDiHKw43JaQIKdbuv2WWyPu/K07I4JwTq+Ur4?=
 =?us-ascii?Q?GUaAP/wXYkZyjU4cC3Yug6DCzDvmXxjJv4XeFEw69nBdP0zrRr547dZ+x7nH?=
 =?us-ascii?Q?yJFeEA/wZB4LTsOV8SpBGyicFxRddETDm256PjygE6diZ6pmDNevpNHrohOU?=
 =?us-ascii?Q?y0j36MBsS5S0oEGMAZx64yBJE7eLSiFZ5Bds/T/v08Q4K/S5UL7ofoHdxV2o?=
 =?us-ascii?Q?N3HlLUp9nGzzAbczJMilns9AC7X/WlmNvRDUTAMNlRmk3qW2sgRKC+zaJRcd?=
 =?us-ascii?Q?+NaF0hC9gA7Zu3pZi2XIUm/zLS2fhiM4MNGX1hhZ2ojEm/BPnzTglAzJOQt2?=
 =?us-ascii?Q?gReKwXM5DQLYl7eBkr31ikS5E6t1M2QnhEsVklEmD2Pi5GJS08Zs17wyj2JF?=
 =?us-ascii?Q?0ZN+yaUYWuazFdflnBNSez7pLn+OefAvrdm9TgY1jdz/LA67Hj5L5U9CxOQQ?=
 =?us-ascii?Q?UWDjakDJyOWF0kGAFB7GVl33XW/gvTZ3kusiu7V6M7kVmFxKXb67rtHCx6q7?=
 =?us-ascii?Q?DRqChhexHMfadj91EEDvA+gq+SVVHE8ZY+stPvzJzJwNqbptejPz3njxGSez?=
 =?us-ascii?Q?ZxTqbyIxZ+O7J1w6CBuT/PH2ShrAg4iaeP/xFvkDkv0K01NblD3aB2SQj5cM?=
 =?us-ascii?Q?+CTY11nxLCuE01IVspL2BrsgQBp9ovzYVeOORDYxZRcvQJRbzyRHMCGdr/6G?=
 =?us-ascii?Q?I67AQ7JxZgo6cDqyJYlloYRniH8vVAxfGvOzuFkSxtuAfUWfzQjZDGIu2iF1?=
 =?us-ascii?Q?khYzxBlLDnuQiMsqfKWPmoMwZHsH+FHlPB7WFGJGkp6ltwQ9WgugNBXtEJLd?=
 =?us-ascii?Q?W2kk5wEM0sleWOtoTwaX5Sj+cE7lxaawaMWSsxlwsBvglzYmEVgycmLEU06I?=
 =?us-ascii?Q?NeYJSwWRVm3QfgtQBPZovNoit/xoyJgzw0N/yDZc969EiL3u91o7w8b61Xs9?=
 =?us-ascii?Q?z6IhUK7LRDGeE1NHWd6WDykAQG1PVzbcOP/ZaaLJZG/zp+m5XBS/CD94dmSz?=
 =?us-ascii?Q?MiDBPdwmWRoy18/pK+9O6aBY2EvDzM3ENhrEjLbmBfpNgoINBvIfqmn1eWsa?=
 =?us-ascii?Q?bOdwrBfB0AMPvYhQDr2v6L8BgNGeEUMc99KVV7P4Tmj2WdEHK6v5Lo01ARTl?=
 =?us-ascii?Q?CE/ymp4GiAjrSsfLX+dfoqBIm8Ht8inrBaQmA548Cle+Ms42wu6iXPttwrq1?=
 =?us-ascii?Q?cxnTCwfEQ9gYbWfZrcQPBlMpYMEW6MQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb40c047-0361-4723-22f0-08decb68800b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:31:21.9524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6FKmROJ8O2FmaZHhO6YASekgN9FjjPbeIjPZklyHfre/XDxYL9XHHjCXwWQa+TmFNXU3fJJJeRllS6938su2V2RxU5xrUWbzoLiX6VBXtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8996
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

