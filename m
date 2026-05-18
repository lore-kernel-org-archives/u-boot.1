Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD681CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 23:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F4A3846BD;
	Tue, 19 May 2026 01:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="YLtaVkCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E05D846E6; Tue, 19 May 2026 01:51:32 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55C8F846CE
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 01:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKTJTGasp75iVVXIeOs5J3etM42IoWD1Rjf/Q3QUzL0lGv2L6qLP6pZMmZWJPWldmMC1Ndx7JsYItNu2GUqRKgM9LmmMx3jHctbpijacBdMTSlLed6J7bDoM//o1sYZrrrK5e3CT4r/dKUsMeXlIUZHk5yzjj7+jGB71YJuT7xRe9/E9Vfg9mM+RcHF7/qN8bY/dWWh1+P8gIdyfpblNk47x9AhZpnHuz7knlRKgUpqilP6hRZMti13ST0nF0LeeFexbFtWaegxM2Og2wre2A+6psmMoARY5c8r8fZK2FYUUu8oI2ytPFrHCFrixDFgrul2AJLquRxE4aLhFUn3ZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=td2/PaWDSLGnXKTyPXHPMj8XUQC2fuHnfXi4+1Tb0JMaeVJI+H53NkaazcK8XFXUbr8oJh6J9SrmKnbSNKi8G6zFDV+3gbyduWKYkSiGDgG+ZEhigj9rYMie9vhjpKVoLCcdEyIRYZSFLUnmuLINvSMdWtv/HxvVbtknRx28Ej4FK9J2Lc6o9Q/SRWNDwb33awc8aLhqHBGf+Vey96gG7JJmSlqcSIl2dPQJPbDZqDHt0QZRay//67TJWQtRxSvgAFADtmsu3XFyUcjthjO1dqbqVjUUf1LNWXNSchzHtX4lpp/lOjnR67v5hqdufrIJ0EnnQCiOUWn+H8PHoOXb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=YLtaVkCDBxy1hHYSK2UXDy+L4JW1mGf8ZvXZ/jWuOCndq5glItPLk7SvTIbNhhK0DwlE0v0JXRylkFadjdvHHZhhDvM87aCyrqV8IlrTqeE1UgCI91mKEK2T7SOjwKqS4u/qH6EQbLWoUOhj8kEwSHNfU1F9TYlaeSspa7eKvYuinu91QqsHyk9c2nmfKtKOLD5TpgbR9wU7vnaS1d76AJO2inBAsX1eI3I5ILfzaqmKvHZJWPsFcpKVkqKbFo0LHhn9ySZmn/AU7CQRk643hlEX0Vo86gJ8Q6d16r05Tdg7RPgwRt6XJClF6DYEgqqU78R44hBFsnjJtoG1Tn+1og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB9PR08MB7794.eurprd08.prod.outlook.com (2603:10a6:10:399::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 23:51:27 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 23:51:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Dan Carpenter <dan.carpenter@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v8 02/12] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Tue, 19 May 2026 02:51:05 +0300
Message-ID: <20260518235116.2664557-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DB9PR08MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 494852e3-626e-40f5-97de-08deb5386061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|52116014|22082099003|18002099003|56012099003|38350700014|921020|11063799003;
X-Microsoft-Antispam-Message-Info: MQndaq4noZ3uOYN88Gn1+vFJi/h+wkieO3s1VztE3IobxC9A0TQMJzQZhVSXA0lzossM1viZjIMVMKx26Uqszj/KoXdNDS/YgO3moATzDQc6gFVOjZwmWQ2NTpBuglKI6tA65FivOBYj2l5W97lmk0GWeX7qK02Vl6Zwdp2FxoDdojAmOixxQIFh/PIq2pKxbkfVYxH6rorK+J7uIrEo9HudiL3Hn8QiNY7gzCtwkgOL1fIs+E5PEujUXMEwKIB8ENvr0xeddi52z29CQy+7Uu25ohVzO7mB3Imz2MxzR4thlBhhlVW1tqqZXrsLxx1Kc7PBfEBKV0iS8OliFzcy0Iqm+ZqzS4bv3HZ4gMEDHkSbWKXXO9+Nscv0fUc+srmIKFnrVOvazs4YSmC8KmPR1GpSXzcMfBd6jVK3LlV41QofAPNqJsGGKeuN52lgIA/Zp6EHQmZl6/SlpO55hamOp+RJsPQVdftPMmOgdrfenWxLJvke7XBgmGE8lRcr/EUPrR1h6q8UmQUqRTCWU1y5PPyc+n3C85sR1LFawn7SF6kzzNGuO6pqMuyul04f94HMEY/XcmM1cMz+OD5vNouAbcGVq2kLZQz2IsdjYIaEO8QUouefOL/IG7GbeQz0qH2rZOEIdN8371XN4Uuvg7BvnQQMvcaQXIkurCIltqIpCGEHOI858pPu497Cj3ENkLLE8Wlb6i19M5FuhOh3ei0qmSaimO3TMYZcTHLrtl6TpHCAuThjUxIBkwiKk9+UsxZ1P9hKGCkTmd0F9ri/GK+BVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014)(921020)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zJwBo5EfIzl2Ytr330fCtXMceZZ5FvayzQUaEPZ5PevnpI2yEBFiFM8Yr1dT?=
 =?us-ascii?Q?98H4ip86bckl2IoU/DhkwPgvmlkZAcGiESZ22CK1NlbA9tYc85NFMclNxKbb?=
 =?us-ascii?Q?rqio8CaZnfiOvSAGwjpRwz3yrBMxw/djnbr+DW+OtsHxpohIBTOnUFSqy8sE?=
 =?us-ascii?Q?TLtcoqxsELarYJ+Le1WFW+l9u08wwfN2gfBXSLm3+qN49fdNqQ6agEHnCOSJ?=
 =?us-ascii?Q?uR32fiC2NPWldXFKNIUihkznunoCTar/aeUNp+Tm2EInP70ETmVOoXbm3YK+?=
 =?us-ascii?Q?2AbFtSiPb8k6J7+ItrRtyHAitapU2CiV2FYUOnA0ncqoas8XdqenWSgIk8kJ?=
 =?us-ascii?Q?1z8l2Zlo6R9wAJ1cDtkv8mQEKQl5OsFv/8lrmLnsVaT9uaPRT1L7WxywDoRA?=
 =?us-ascii?Q?IHUXnC6VjChJD+c37UtWDKJmy4zgJtKQ70C6wL7uo78MTJzh1UKSLtsgN2Y4?=
 =?us-ascii?Q?ufwtuqScpcLEsdP6X5bcr1sX/za2IIB1rKC+UQaA93SclAP/33RQFXtQvmiu?=
 =?us-ascii?Q?nxP8QmRrnmoIG6q6oR6dhX6sPe1eOZ6Kmeu6IE7gVIMDGA7R9u4Lq9XEISwy?=
 =?us-ascii?Q?HlQlK5vEDVuCbqS/155mFgYqwrRRYy2S7jwsBKXLZFlQxImtESKT249cWaF/?=
 =?us-ascii?Q?m3kjHeyPqt+piVY3qEkL9TGG+6W4v6wjwlg7y6BQ6NfUVnIbfR+7yZu9/9eT?=
 =?us-ascii?Q?RnCN52ZTCdPMrbP+9TVf/gGRN5IW1h/udu+yzmG94yndreVhWZkeryopPBhS?=
 =?us-ascii?Q?cICNQjl+XRNTzJC4yu2QUBtuV3zm5e979v/hMWty+7Ar4wAT/ZmQL6hwW5dy?=
 =?us-ascii?Q?9zwLuaFM6wP4Cgt11TywaNPTJuxk7oIVFhcGPDjxmIiSV+t9kJE6xod/oBC8?=
 =?us-ascii?Q?t+H3nNq+MCEhXB/xx6HJ0PZhA1N2d4JMAKrJWth1ds7cWrWHTCe9zEAzAgeK?=
 =?us-ascii?Q?iBmMn0TYgfQtSxWxIavxtxiUASsw6z9rnXYhrNKceIOSacpaup/fcumcR+xm?=
 =?us-ascii?Q?lGzw6AeNjtY4A2ZDFIZ9/vBEiZMu5fJY4q2cBEO8e5ulAR5asOfbK0+/S9qS?=
 =?us-ascii?Q?X6RbCl1b3eMy4tRfiW/0xaVg6l+O4z7dUGdAqwTKBky/RNb8DOnDq7upQVKb?=
 =?us-ascii?Q?YFC/qtZo96Xw3DpwfBqzABXViPqwmlZm+mZc7zo8ZNyeQcAIHsDTOnkwfd52?=
 =?us-ascii?Q?4Qx2U+QOkYCU6Vvj78qfoRmRzklFVduoSCrrEC2DZEM4L5pEWRb/qJkFhm1b?=
 =?us-ascii?Q?P+YQwOuHT8iUa3tLBYepj+gv7Yeq0uc5B1hHcBs4hAmO4XxgtnZX3XtZOq8N?=
 =?us-ascii?Q?ha1LII1WUHMVmUY1JQ/FlkMCpyWPd55tC/jrPgEPL4vDEaphTYLcQyED+oBw?=
 =?us-ascii?Q?V/sMIeFqeyJhd/BfsOSqRFAsxrTgL5jQEUj1SvjFBSpoKNxRu8mV9Im+0SRk?=
 =?us-ascii?Q?E1prtujloJsINQECfO+WpKBrkD/cwTD928h6MOxlQdsEvDm5q1MG5bdvM/91?=
 =?us-ascii?Q?kgi7tXGmSlx8PEEdO8Dr9J7qWclk8OBsYhMFqyap+4QEXaD66HFZ+WYP8iQl?=
 =?us-ascii?Q?MbFGDH4tVECbdS6sJWOPF1WCYMW+Eyo6pRlUkjGS1RxnsOHEc/eBMcOWxgNS?=
 =?us-ascii?Q?y1GwrDrGW4Ne2XrB26aRAXJdD5Lh/EGA0HJ1EOZvY5uZFIsux7djrtjz12fr?=
 =?us-ascii?Q?TbR8CiJSYJ6CYqCyFOplX47IPBaNKQGATRbZTaAgqQM9b/JMiM2SRCkqa+yy?=
 =?us-ascii?Q?tL+zq2Kq2fTeeebgP9YcAKOEou4ZzaA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 494852e3-626e-40f5-97de-08deb5386061
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 23:51:27.4354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vxa4Ihuso72UlCK0eoEz32kmuUa+OSpRsB2jC9GiO00uw7f9t8FNnd68oXEVeAI+3xs25daB37JuANMPkh0TejZHbY9mOeQVpF9/jzT1HT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7794
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

