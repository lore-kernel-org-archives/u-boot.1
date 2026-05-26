Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E12CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 00:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 466BE8493E;
	Tue, 26 May 2026 02:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wdqsqJPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A816C84946; Tue, 26 May 2026 02:25:56 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA1184926
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcgjYAVmzMmRzfshgp2A8vRb6atlHeaMCGDW+3Je3kg3tSTkHJqaK+eXYY4z+xI6ug684k/pj6COWiCaqHMzU9iEXvpt9BfXgnOy5PG/6bbaRjZjeFwze3GI1aznFeef5YXBQ5SrTH0WYdCz0DKAmVuWQgPz/zyCb2bYWGm9SDH+noHckqypOL40QxcUkyQrPQaWQ9RcDjN4pfvyfN4c8idOUJTtrbhEDjw3r1nE6ESvyNlDwxB7pXezuym4vIy+s9XayhQHXO47/4u4fyVRGRCCcWSy+wTMNtNZWB74gp3lnSQ7IIn9dJXpY0w7Vprp9i3I1kvhZuy5+Q/b3ZiKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=eGMceu8VhD9x0HltIAybpbGbM/X2idHGjjuULB4lTaQgtCnBo8bz0kV1+gPyVa/q49oyBnRi9Zp87je0pvoVpzVFI8jRnmmaOd7BDp7+6PStv/GWm/GUxCvYcDFxktSfTN3SSRhzNh9fZbSM5aOCvJEYpVIVIsf426y/uVmCvGLB39xIxiTIKEDc+3vowxSt4aauNHQAMnq7vTlrlC8BPp3xvPfkAozKS2+iJowyBAB0kp7E+st4QEJh09LMqCH8ljCLV4q/a9LWVnUisImqUloHrHxfYltjvBNNRoW7Jdb5rO9rZt/0SmVU0U890OALzzKKyfBQna212juE07fHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=wdqsqJPjEgtcii7ZW7W6UgeL4heJeYSwVH4Fe2gZfPiHgTIqTnm0MrcIcbWpibHY8OUctnh3fwIq99WkTgjwtnw0hB//GC7jycKMiyowRpXlCGyWg/MK8EeKiJCQKjZWKXwPwfdIndK+uHxj9ucN86m2Ntq5jZMgW63I3BeuWihO2zogkiBK/YQf1Ew6SxHEDCBIIsv2C1UI3XyBdyIHuGaYeNpeKffhpEdejj8NliCbNb/75MppuM1/pcnFhN34VKznXAqjGK5IIEr1L+iIMlmALrZgcLslE8D7KsKj4J7BVQ/nl1nqKALI6R4dRIXAaBI7gS8hhijEBIK6J/xgyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB7682.eurprd08.prod.outlook.com (2603:10a6:150:61::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 00:25:51 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 00:25:51 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v10 02/12] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Tue, 26 May 2026 03:25:24 +0300
Message-ID: <20260526002534.898340-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af7f972-7620-4fc6-8768-08debabd5794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|11063799006|6133799003|18002099003|22082099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: gauKl41ayOI7ckOfHr16aTq0LGIq8VYg16Gke4toos/NNvCa6azteqAC/+mK6Uh4sGauT5b2ZaCzeJqnmtVXsFrzHP+yAhI0c5bJCF6sK13ajWANaK2ie4YHo0NVF+0VWVKJFFNh9GPlSJ6i9gkK+QSNOjEHAJWeIuT0mbL5xbXodglZ7iFy7MMdOp9nDkkpWGapss0wTUgfHgxU+LiinWVOIQN843KZChKtnyDxE/Hu7Md9SGtt+Stg6uGVYlAqrnoPVBSZbBY9/RNNUkEw6UiDAOGnAl6uDgmytVZI+/X4cyXubypRGRrSYhSLly2BL5CcdjpPSB5qnxcg7xTlDFRgPpnuuGItXueV6yDEuyZjgP+t72j2m397z3BZEC2IS0vWD2fmjXEiUI+NCCG6wkjOdlwrfwAUGTJl0lm2nCYo2HxBLKYmzTjkUA4WaY44fl6OETuuAXQUmxe3WgG19hfjijC7KMe17lm1tLMbaNykKFB8nvNzUqmaYGyXZLcdd1e14S7bBR2cdk+8PHwoZ2wTf8IgeVuNt0qdWmhYX9dv0BO4nCOPHs+ANF8Gpjnmxa4CCz0W66OgaC9ADtzzj3MZbycpVKS7YKLWaI47jPiTYK7n3u3cjlgHdhiItT6n5Ikgva1GyDFnApcDuGch02AxPby6eq7xR8dO7R8iJ6FDBfa5HiNHHRsFYJ3Jcf5xxCw4y60d8r26hvfMkRZOYydSv63lTnE6oEN98yHd9r5Ow1UYEE14zlBW3IpUxY0DaNBDLsDy+d3zU7eI4/hSYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(11063799006)(6133799003)(18002099003)(22082099003)(56012099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nhZ/1+sDtX/p1f/Jm2UKtQ9UUdA2Qq5EZ6jqiZeXvwi7bYMNh2hoZwWy/ruX?=
 =?us-ascii?Q?rgIWTJsuAaghWToMIBmqKCBscJ4pcBtENqu1Hz+39WVx7O2Bv2dIF+VNN92M?=
 =?us-ascii?Q?jjFMa6tpotbi0xrVB0ObFh3qBDNzxoQBsy+F+LFugHWyiQoW7Cb7PPA4IPmm?=
 =?us-ascii?Q?KY/qXArmznps7Ix5DvZXyqH1wIxjR/65OssiYd0h1nqlVWKDGYUbV/+Ko+NP?=
 =?us-ascii?Q?+03HKetH8chFWm/ZHxeSGyV+QTq4lkCvwOmy06M+KD7dvOXz8gwX9q3alqH5?=
 =?us-ascii?Q?qH8jFLYPTkExofhRCAX42iwP9Dwiw4tUGscxQ/CGZojxIhgYsRgnN4MhWW6w?=
 =?us-ascii?Q?QC8jNt1MZat27ybsItMXigl2Zx/7SGKsp8yw4kNW5NZ8X0M+dU9iWY3GZQJX?=
 =?us-ascii?Q?+CJgkywKfmP4nwC0Z3k8FDcqHj16sgkhbzHrRdmtkoFRGWOfCfq5sBfaEWPv?=
 =?us-ascii?Q?ymaFk120XXPGPKw2q4BNMz0/zKpnxBTGAMvaZ2Hkc/46L18foM7ai4xLY/Pq?=
 =?us-ascii?Q?sWoRgSLC0twK2Mw1jlhjHpuKocV43NK707TLPFPajYLb9aFblXn0J6xxdbx8?=
 =?us-ascii?Q?z0+PZix2d/Y4YpfWjCfvpJ/ciboy+Ljj3SDYklcyx99XCFnGW0Uwbpyysvi+?=
 =?us-ascii?Q?rXnLJEYsWbmCFhoxgHZA/NY5M64EiCc07Lw2JbsHvF6RfmKJVu8+sCUPoI03?=
 =?us-ascii?Q?gEsBrsYUP91ZFbIgOOihnrd2AIRDrbHw27Zu8H+BvtmuuVv1/Sc1D1b4rckO?=
 =?us-ascii?Q?S/isokZhf7f33dkvPMZ0QvgY1QsMD6DwLh07z+Cmdu7e4E0aEhGZoV4fmuDy?=
 =?us-ascii?Q?Jj9g+4DpNUTZW58Cg8Iy4fPmKqBr/IyVStzByeaaJjfSE/q4Uv18iBEdGY73?=
 =?us-ascii?Q?Q/6YoTM3ni8RN1YC1xMZc4Ty2+lJIWaZSGKxulTJYAqiqlu2XLxPQXfwb1bf?=
 =?us-ascii?Q?P1iSKDN0f0lfPwPWf8RMXuZ/f96P0lc05kI3KFa6gIVHbwj6TVwctU/HyHbH?=
 =?us-ascii?Q?gr/6LmrRQS4T//HgNzUAgpsBlAwyKO/yBL9wjV2zgsGclYvD/Qdce8bJ8C02?=
 =?us-ascii?Q?9hX2mdzD6gEHxxhVkO34DmIBVeYJ6Bf2GLc8CTcYzoAaUyn7mot7YdWEq3p8?=
 =?us-ascii?Q?R+N/r8Ip9TqfMI+84HOoH9mdQO3VOoxhUy2Oj6zMqVj0bYCO10uo8gfdDkLK?=
 =?us-ascii?Q?dNtTqAd1j+m8p2y2pC4dUjn3rqUN4HHoEQfOOlLIgqk4xCm5DniYvj3ND7wS?=
 =?us-ascii?Q?XGd9UhsKNDFBONCFc5Cvb+fwmMIbnE22lmpCtGDhqtKgX1HRA6lE7bD2EVIX?=
 =?us-ascii?Q?VvkSk6L8XWDAxMkGH50aUj0lcCcYW2VidFrT7jbMiteK4UGAD6WEZDp9Q+A7?=
 =?us-ascii?Q?RLqqtHKEBovR9kX1Rz5mTJM4wxKeeOGnHZJbBMy7rw0bTfXsBl9BGqoQSBGq?=
 =?us-ascii?Q?wO1RiDl0uSJ/QONoQDhU68vKApQowVJZAM8H4qqXFumQwmmTMXnB8LgwK3qv?=
 =?us-ascii?Q?s//kbSDgNMxvOb5ACSNTUMwagsDiZHsG2jugzu0RcH55GM1JDnQgaZ5hrDdL?=
 =?us-ascii?Q?uFsckAKugzbzwzXw409QCgGXyV6Sz3pqKqPpdxqk/BFTVca2Oh8aFBix+r2N?=
 =?us-ascii?Q?cp71YgEXqAie1TOZin4IyFdug+0sDkA5dPrDLsU1qaaFmNExTcuAAuLXuygH?=
 =?us-ascii?Q?4VlIfhJU/cAiBAOzCGuQRv9vsCPkcQZMYgR34v+GcZ+DCJuJcspcCA/zJ3XQ?=
 =?us-ascii?Q?cQIsuk1VzbKKDDMM8w8Zf5S2PDhOD/s=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af7f972-7620-4fc6-8768-08debabd5794
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 00:25:51.6036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: np6VrSYptWaBEWrqUHh4DcC4z1udnFM3SjE3fIDSIV3uwwAtnVAqWskiKKtqkXax8NUQMhLOn3VLLkVFa7dVXwqftruW8XoNJZMT0dLJRVg=
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

