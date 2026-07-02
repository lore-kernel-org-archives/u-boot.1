Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C79C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 05:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4603084C7E;
	Thu,  2 Jul 2026 07:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="yUfJYRYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD3D784C6D; Thu,  2 Jul 2026 07:58:04 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E97E84C71
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k103CzkWOS/fVRN4kuoniWs1U7eb8COi7pviCr1KQzL294YyxaokyWjYDEu51uq2+mGmGqo28cbBDf5fJRyD3u6/W5UaeMh/Epd2WWIe7z9oNeEoLIFP0lNDKXKobv8S9N9mwEUfRToAZ854kNjGnmoqv1Ir5PxBUOJFuj8hlos0VDzAgvk0i8UJxRkcQUXog3rs+PCSefYgB0xAofFa6zEwLBGBfHiyI+YdknPhP6qsjHt3DaKbUljhqFKnCd/gGkWsYnEzZgeZsTPgc+CPjRYOhkaw+UywSHWoI2l2BeG3d9OofeAWlV3GbbqgCefF7gHEfiUXMBLpAim9jqRKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=Pl1m21UOd1PkPCdCInHVSoKBX7P0jjveMt6DddJGIJQTl+PuCo+Xjcdex+KSPYbc6iwv26AoLGhTnMBU3fkwh/d+kqFOU/iGTEp1IIyvrvzqBFlufO3pZFAmnt79BT9JNjKi8QPDkhfP1OKvOdfK7ae/Z6gdHNrTPW5qXKRO1KAOR9ZuZuS5E7c7o8AY7+yD5Kz+52dTNfULJUfmHqUN1jRBTLrf8rjZh3trDKb2PmYG//jv8Pxcu8zjhsDbxBDnCPhotrraYP8FJLr6MPkUCWsTVQa9TRXIq6FyCwiDNGFGuCB6JQGJsPFvRp65Q8CZ7jsNG16fXodqj2aGb844jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=yUfJYRYkmGh5VcdoKnAnfE2CK/KRkO87ty+h9T3IJ8+mNopTvfwip3vUmsHx6fKPR8HPHlK8P7eS1d/AVG3WW058kKEG0BkeA0zPTs8YGxZVgPF0rCLBZHAzIYfKGfv2tMjspod6Ua22sWgpmv6Nlk1dTTT9y9Wgb+0Xa4fsgYbEHTKgjvJbFbLwc/k+iKWohsF9s02mdJqxhEI8JaMchMj3Qho0PrnPkCfC1CNwZtQk43VbINfMNAGa1QymlBC1A+zCHhH28IKqLSioAPt8rc1tJEOnqursJtjjSI2bdJ2RwnTClf+uVZKJczORCXVN2S+NoQbLINEcRrUEwUwKNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10435.eurprd08.prod.outlook.com (2603:10a6:10:52a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 05:58:00 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:00 +0000
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
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 02/18] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Thu,  2 Jul 2026 08:57:28 +0300
Message-ID: <20260702055744.2164975-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10435:EE_
X-MS-Office365-Filtering-Correlation-Id: 778197b2-8f55-42d8-374f-08ded7fedefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|52116014|23010399003|6133799003|11063799006|56012099006|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: 6nm5FfDfDwt2d+i0/RdTN+vS7qT6VcZVYroLTouvM/AMln69F6GiVLKRrMiq9pdABuzjovFZ1OZZgtUkQttgb/aAchT0N139fdl4qHBuFd3hGDCsZBxuzzGbrfVoJhv6BzjULdTfY08e1g+UspKTp46/ooF1dex6ZU5uaIDFlKC3jhd1Bh0oLDv5JH9+TFTcxLOeeL6rwsaJBu7K2/AqkpQ9m2ZehdA2ASlugVsDXW/PkguVt7xtTBPY3sX9FPMeKqdctvdCV43m2LMaDoHz2KzGZLvlGuhkTi8vDxxC7007l5lD7OnY0Cl7M2qqkPs6QwmePxr1b7MahMMA1whCe48iQi2JJja+wC1AwSA/+FsqmU5IDFa+xou7YZ5gvb1VliSvVv78QsuqTJfUXOOzkWJt/Dtb2DixSQFe733bSMUrDPM9pr4Ibn/AYRcykgOhs/0HZua6sVZ50sCst75hpIUkYVVH9Ywzn2dIBMCHyDmcyc3y9heajIs6/66RWknhPTM1Bhxi+zHB0incnOVxI3LgxTU4FiT950gKISjlNEiwpetO4FzUwqiS3Mn32ZFMkKp6wRNrbz/wYAVy0YCE0PLbrthah2o8ONEm2wnmh94ZM9lp5JUbtTNupC3Qo2y+vbLdOJwS6m/eny3zCXZ7sLqBhmjnWDYFJq5Tf2PC0UMs8QWZ83uLRtRJn9AvXj3zgn1QFc7h5HoKDosMBSFQcayM09WL9rxntomOdmvSEEyTB3K47VZn9XV4YmtNfO0Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(23010399003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fuOKYTjJE/gmEIbADVa4IaaBpm2ffZqN0TecxgMoE2YtQWTCwfWwN6pTnAxF?=
 =?us-ascii?Q?OomXmcqtaNvWWJq/4cQ4efsRm3OiwO0QNPaBA5K7+thY6EP4tCM3LCC1tzVR?=
 =?us-ascii?Q?hWhFLgl+2L2wZiQ0oBUgw8Y41V1F4MC1AuzTBrDIcO/c01vvmZhYtTBOhMEs?=
 =?us-ascii?Q?VQdSg0j1CAHVj6HPZd5ITcXkxo/uAh8GSsXYCVOLG9V6LCwiAWay/8ZJSYau?=
 =?us-ascii?Q?Omtr1SkdkPYnq9ZmPQhWiVHEgBNfrvW0WyCPrr14P0xrBRRKTtpVCwZli4dP?=
 =?us-ascii?Q?+lyqqUowkU+d5wrcnyyN21XfU9VfY/+DNJcuXeTS8TsrZdHIZhBXEaymXv/3?=
 =?us-ascii?Q?N1x50VmRrQtsWYkiJbAY0g10M9sxoCTDL2J8AzYXS5ol+9dh5lWbehko1rLB?=
 =?us-ascii?Q?l5rvTwy0+UCBui4clfUnC7Nbjas9QbWl7wVGaUAYIxmNYhXThw5+5r2iP4zg?=
 =?us-ascii?Q?hZTq8Al/mO6pqr1Lx/ljjgSRLtt4uFRhegDZcJk3aA1vlULXtJs76FiNvvj5?=
 =?us-ascii?Q?ov9789uT/luVtVPSUSeK4APmQpzTQjVN8Gt2Cz8zoikMQr/2jowwKTs/+uAK?=
 =?us-ascii?Q?VnWt9u5j7UNFi7iTY1As0dXkRnwN5l6Hfox0gxxxKe/7bErKyD0xgVwCjHOz?=
 =?us-ascii?Q?JGjARHrj4rhYqnjmnxSgGWHXS0TxxSEepgThnoIOkUsq0SWCaayvmHVa895w?=
 =?us-ascii?Q?+uMin9m1vNtcAEkrvReDMqeFjguhh9HIC6ufvtOKImXcxHjQrMD7GDrnqx7L?=
 =?us-ascii?Q?mpzQHhMCJejTzAphyRR2aXwOYBflHSin5KSoC89BOlLK5zedy9ZLScElcqsk?=
 =?us-ascii?Q?tq+ZbLYtOjFu6U7CVizGhIfvj1DyHDWlkBAjAxE6rksYOiQR+TCS7DetLKio?=
 =?us-ascii?Q?FUUDjgUgXEXQgpYrL7DwYXNmMrdj3kvvwg8xdKtybXHvr5C4dV68cM+gDSv3?=
 =?us-ascii?Q?NNfOx7nTATJjx/ROvTwewofreRaGcx0RCftcLowR/kWMVkUz7PPlhzWpC90t?=
 =?us-ascii?Q?6XmAoG5rhAfhb+PuH4KhpwCNb4LpdrfQZ5BqI41BxpyUO2np8dLuyez4VtT7?=
 =?us-ascii?Q?plVAqpF/0ZipajQxlzOO5oweLf6rGA3NWiQqk4UEaF2QRNWC/3k/3EOlGHUT?=
 =?us-ascii?Q?d2yipdbORi/042UbqiDsLF9+LffCBKtslG1RKSimzAsMb/N1YWrHU3RZizDA?=
 =?us-ascii?Q?Zd+uNG7dgQf1Ox8IYwXNVrlko9J97fkismVBvGt/a6LHD270Yz+VnFTYnN7U?=
 =?us-ascii?Q?+OGCyNO0tb7XzILVG0qLA+vCnYgLEtIPu1m+gbRIVnUHZI+hnuViMurGgUA4?=
 =?us-ascii?Q?yOx0bwLQKg1x4h8qB9VUuUkl13kre5qRovJcH3l+14puhjSdJiJ6S19/06hs?=
 =?us-ascii?Q?cXEieBhZymEhRWk2HqKyKFEZyjd++OCxulwdwHkq0kWXWBCl+97/RRWomi3o?=
 =?us-ascii?Q?JoZoA40FSQ9L7u4wr1tUPdyt7zHIBtwWh2WuR1WKr42+9Kp60m3YKKf0N92v?=
 =?us-ascii?Q?4RgyihgkA9Nez2QL5vFTxsLEnIPWpdW/AKvARLc1zanNxbhhXnhydwF9Fn2l?=
 =?us-ascii?Q?5Ndp6+t6pX+lLFdaTT3ip45VlnmdujlOOUrbhTDGM/dAVtLUTtZqy9uUjdfC?=
 =?us-ascii?Q?amnq181/EOCiRgT/N4X+VjOyXP3SJC+/9KHPvxpf077lVlTXUayqRhOvlVY6?=
 =?us-ascii?Q?ARhWO+qqQpD7oJhS33lWWzGzSqBKmYaI37G8etGKe5ddRAAfJ928kD97gipM?=
 =?us-ascii?Q?k9AwH4+5ambgUnk4EB5rz3Ap0JSbyzE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 778197b2-8f55-42d8-374f-08ded7fedefc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:57:59.8973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N/nEdFki0Mz88VkPeUrEdpau04zzW+zSn3QTQHIM+5Z5yCN5ncWBEoX19AZ0Jl90JErJpx7+CXUOKFTRNeNbiocs3xFPhBXZeEmlXzPsFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10435
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

