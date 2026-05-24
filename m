Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA46ACD5BAB
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 20:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A2B5848FC;
	Sun, 24 May 2026 22:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="EEUK4y7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79462848DF; Sun, 24 May 2026 22:00:55 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D2518489D
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 22:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fjx0nSEzeeAf7P7PquDVlexgcM4O/oxv62mJyxTw0rsTWHnpY330x+E0xXzNzOxxlGyA76DYc2F6S717sMYn7N4j/EoAiDSkRNQLME4ezH213Q9K/EAlbPXAPwVbn5r4aIgETx3pRWkKidftgld7aNGjD37rbUnKhv6g3ZLpMcX0hXw4ii9CAD88omYZh7on2Z+BQtWXvI514Tqx73VGuv8ASByGTf4RnXUNIP2ONNzAxFF2fRlphHAhdvltA8Ig5VjTdbVqHdt8HHI+AUjTJbKOCZYvbRnP6PauqQyl/J1sMLaQRMFAPdqC+yNkx5qkP1j5st3wXJI6K4EvWl9DJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=dHd/VLWod3NmXfNtg3av1oUiv7mSIwHpAMm3n8mn0MS1Mn70OD8LgkU4Bo1V14dmN77Lu2sPAtYmGn0Deb24MC/446jZWfSeSiXtI+kjSArFZBeFtdh69EW9Ub6gh5uNYFdVZztCnkVXRITx31fXT8CmOu9Y9bOCzf26KH4q2qIt2h1HAFqYHtT+SN4GMSIf9QTqf+XoMebnuIu0LFp929ErJ5lW41A5SmBzg1O+JyadVSNGZqZEify4056Q0U0wXsncltGDrpVYx2efUY9Hgs0NVa1dwK/3s8/fMlis3IHRkmoQVyuAV7kcftaSVwHrTlr+JlKS7Sm+bjgURwsGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=EEUK4y7cg4kXmqB+r4gdaDHdN1D34SKqRktNWgabzRS4MAIGiMwoi+0wonbXKU7pcyLCnkwQGyNCx9k39Bazcc41noSrPdIiuDztCw97DX8s0/tYORG5UDrCPOvP149AqMewxYcuIEmP+eOX30ZbS0kYks4CGYz9rYqx4P7iDO489Ayxq/Yk8MDF2BubJPmOFeHsPeJ9t532lCgK5U//BbkETsKZOqUx/UywvLPX2HhjieG+9dA8R0myMfVR7UfWKlBE0SGOe53ai7PreQf1A8e46xI0NvV4XSMxO5/ts0ymFc0cxIso9Scj3+eaV+sBaaM/x0hdZ4kjM3T6fYpexg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS2PR08MB10266.eurprd08.prod.outlook.com (2603:10a6:20b:62f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 20:00:51 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 20:00:51 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
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
Subject: [PATCH v9 2/9] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Sun, 24 May 2026 23:00:31 +0300
Message-ID: <20260524200038.47826-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524200038.47826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260524200038.47826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS2PR08MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3d2367-d845-4955-e2c3-08deb9cf27b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003|38350700014|921020|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: PEAnsEMae+MeALA2gfxPHd9+BnGEyaOR5nzdrnkt0+40Qd5PFc3+5WO7aR1sz9e9hvNTHbdSO8omBuKHnw8ynwHQoHCExY/tc2jv0gunqMEaoX0OeCODmnQ+Y8pM6oppjxJ5zgjsS0y2lUONihoJ3fBLeSdkcWMeH+lMJbcA8eUdTI5qvgtml1ghBLG1aYGNy0PjstXWbdkqMqak7qLIkAK5Phcm1huIF6b0LYiV5jBo7yC9IxFCUDbC4GflmqCgVegicJ0nNWvmoBuvpxeHPGNKKzVpOxt5Apv7vWQrcVu9eOvhha0FnZ1pDsGNwn9GmLodRBFRlmkXoOfbue2St3SM3VV8D4DS+Jr34A8nQYvFtoNp9wEmohx5SIqbZxnK9gc84EeIUhnCp9iO9WksL7UogPv6uw9GAxyWOtgNptWGj/5B5kONyvzl7pq7X2AJi2v3dzD/n1W2Ndi9HVMSZNyujMl60id+H6A2ebNymlw0pvB7d48h5mpstRMufqsE+P9/HQNYoceNkBYR6kwj9scBbrO80Tw4JMfzvk+MwsKCjmUzhfDY3o9J85hdMLINROFRMUsci3Q3tKdyDnHqIApa8GcKAbAow5XHTtznEerGzCXeYKpLw6KMFSwW/0xIVdfJU7YHmLgS7yddv1pdTP1W542UvHLPhbcu3/oeAzjuTB5CE0lMIunAZBAxQOLsY4oCLPiiBvdCHdGS8iuzA4lPLkt/Stfb6dGte7qHVZg3zAmFrHPnRIPdZUBgYNDYFVstm2NXAJbjInZ0lRnA1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014)(921020)(6133799003)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JSlCyw1DQM0L95CkyOFs0zWRpPplLtwmsqu+eEfyykRWzAdh2Vo2wVyz6tbJ?=
 =?us-ascii?Q?nJyVvMy1yjvQC417DBjT9w4e6WlmER93tmISvpvIED8cVNczJeGSj6smbNxd?=
 =?us-ascii?Q?PAiqe39cokk2WptnKbmHPh1S7ber3dEu+wFCIyMSo3eTnED0/rA52ojJePzi?=
 =?us-ascii?Q?kIuNYH9rPOlhorMeszIMhcOV7X5Un27W5XCpZbbcNv6D/jv3FbMsGUEl1qOO?=
 =?us-ascii?Q?Ygqsbxv+7p+jRKvxAgHXW2N/eKYITvwGD4FXr/gzWjeXXk7y3WLLG4LuWZqy?=
 =?us-ascii?Q?IxFc/uIpT5IAwqN4HPclRgGZ9xA6VTQNkr1hRDn9xessuyWZWCrs6RKnYl1z?=
 =?us-ascii?Q?UTcWQhUeCg6sWOPhEVKEiMYLdH9Kg7UTJ6UMARwf6S6/5cud8m52kkwijEMb?=
 =?us-ascii?Q?rnjiUPsum36O5xaPp3MQoH3Hp4BQLYTN/BB/1S5Zmc4E9ciUukAjyPgaXo2R?=
 =?us-ascii?Q?6eO0w/nUqqjByotTVZnhLMlTv5EpcQbROnjFcJjSuZNn6Jc0kdws9UG8llPv?=
 =?us-ascii?Q?M9kRI8gcITTBmE7conjIj0GcMdOBr8+kPMwa2ClZSsAIi+xVtlSnf4N78rv7?=
 =?us-ascii?Q?2wxhQWXTEtlVBrm2BlBqEMzZOeKTJxtQx0TsWjgUnvLGfEeTkb/jFn/33oYG?=
 =?us-ascii?Q?00KWBZW6qs7azx08GvvG9xCADfIju7rXiRbpMh+c5EwtIzLqUb/zSPFAyqjW?=
 =?us-ascii?Q?c9GTMtjCZEpK1YLYYlIUJbKr0AeHZzBC6Nn+EGgnc/2pYrxVVpV68HAm5qGu?=
 =?us-ascii?Q?GMXfeMePKuHISJGRArnpGgoEk8w8+qTveko13ST0yjG8jzHxb2iN+EG3l2CJ?=
 =?us-ascii?Q?X3rdN7uLxRz3WsE4ab24ALZtDX4/toWFPNL5C9OaweZ9teXCbqiojnr2FW43?=
 =?us-ascii?Q?1N/T3Hy8dIO0VaQHBtYUTNxxQlXWtgbc+bXBd60C/oVIzPW25IQGsAzy4vo2?=
 =?us-ascii?Q?Oqq8bJ7dM3w0nvyZ5QhV1cNxQCN/hZ/IQzesFXbZgvW7jtu2gyWk3ly21A1D?=
 =?us-ascii?Q?+oZuteBC82L1N5W6XLfxGKNEC3GWYo0zCjmGsD5YFWCJ484m3I79abZRQ6/M?=
 =?us-ascii?Q?R3FP1SXsGJfEYwDWHgYiMvuBiawRdYqoYdWdGXDMjgKCMcbBx3S3rne3H81g?=
 =?us-ascii?Q?+lQs8qLUgoCDZ++Pdc0tiIWRgE64Y5hoXMzJa+fY+U1/saD9JgjEmoUWgdKx?=
 =?us-ascii?Q?0MTraICXL4U10qfCSaEofgk60GJ5mQQQDg6bdYKtzyU3BJ/fjOMKQOpznhHj?=
 =?us-ascii?Q?FWe1xPBLAfC0HBM0M8PgUeGwu9lBK4yXUdpFbYE+YHFRdD4IRzYjdDwaWW2p?=
 =?us-ascii?Q?cMtpY7cFpP5IfQo+8uGwhkHh6G7WgYn/qOv8v2QsGmyQ7a8NjC1/Kt4SoRX6?=
 =?us-ascii?Q?oz6oaWwuGMoEsSHgIy3GvbkNuOT3sdABEmPV4YpB/K+GKplodJpQ1caC7gHD?=
 =?us-ascii?Q?bwOAKJszsQPISad4Rg/wsQVKPVGKKkJ4oWpjOfFIbFWcsotb1Qz3gA2pSWwQ?=
 =?us-ascii?Q?lvE6AotQS67d/nlaoo62TPY5Bz32O2A/MceRTzh7hDGpvW5UwKkfTFka79oq?=
 =?us-ascii?Q?ncQh7728ms+npJy62ekrtLZ4CX5IVRCBLsYxg6Rfz66BvgODb6dQYPswGDiy?=
 =?us-ascii?Q?lxRBVBCkKVIkJsV/kIN1hPKfokR9HXJILliNbSCcw+hITQQo1CZRjrcORyhY?=
 =?us-ascii?Q?roEK/0YAEz82Dr/LA0lbzV8c+3BvdyFAAu7KQWFrPiZAE8FZushUzUXg7Eit?=
 =?us-ascii?Q?Ekbdn1I0FU7tcclL0HiF0QJ2pGSLDmo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3d2367-d845-4955-e2c3-08deb9cf27b8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 20:00:51.0131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wL8KJJW5exmupSuJJn1VMZPB/KTGh0nRtPSnNrknjwKBBjJy+VFP37S05Hnw2RhDDJITTtdgCXPtEsqd2qhsbqkROWhEhn7Q0KPY5uwK768=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10266
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

