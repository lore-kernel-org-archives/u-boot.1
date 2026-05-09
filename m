Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD0DCD343F
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 11:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA85184CFE;
	Sat,  9 May 2026 13:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="6cU/+N4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B35884CF4; Sat,  9 May 2026 13:12:17 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10E7D84CEC
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 13:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPLl9t9arlL5/bkf9lStzrR0R1fHqsqnfKKgnJRDvCrqWLhPd6Qh1DI6LzqnABbTpS+yCuUTjDNQuTeZhhpjcB/qT60izAA92s+/4ATZ0G9HWRap15SPMChUr88rZ7NNPFk/1oHCmr+3MurEMgjcxNzDaajHyK8eAzr587Iu+e2OfoH5UIwDTfL+aX3MwoZNLihdZecwTIBg1FF72kiuL8bFlLBLLztcFGTxigQ/l4YhFfywEgjziNopaGcTI0nTECn5e916PM6SgM9p46P+pUKEhtMRuc/DkUdKy+JmxOszhjEIWjIpHzjd1BKb+7QQo9mxzEPZ006l8zQ2FZZ/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OcJClFa6mc4jYuWCCmE/FAuTthxPmKMGN+UPGbUIQ8=;
 b=ofm/WXW8Xp5CRSU6LNjW6cUGphY7aKkd5jEUeTi97sfT2DzZmO9vFYDQtzjdsMxbYa3IeOXIEfbTcHVQ1bo5XpYdOHceMXLzIPFQGv2qAJ1jAh+IehMz5ZhSBX3+4r2KDO8KOtrgm1GHuiZzUu0LgFyuJ+oyv0hGuHWRchwE6AeNON0b1RoqMTI+QKMIGV9Nv1D8Qj/ZE1JkkblvAl85qUHyjG9ZX6vYL3iQmcYQJaS0tXQ23scxhEyyWSIQzM0fq8ecl8t2RLLK19p//aArU4UwyZVky1+2apFut7fejA976+x2Adad/2zpGnNF1ZbLgQEJau6OkYPX8eowSRvcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OcJClFa6mc4jYuWCCmE/FAuTthxPmKMGN+UPGbUIQ8=;
 b=6cU/+N4wdFrTwRpDu7UbFcB04a42DNNsDqhtNJ63xYXlcCp4WbGJ6bgBUOsZjW2YI9LJva8qY5KrLzwRfrLnrIFGeFT4tJeDibMEZQjiBPH6m8frEyVrOokYcmC5DOytvQw0CYSt4a1js2wBSiR9kRpp9jmirOSm0O4j8NXvOaAgIPPQlsD7kgukNl6OhogqDpMK01/ZWLufvWCIwlcyDCT3UorqOgrJseURz50FgAOVsDVhSk++QZYHuuURXc1u/3++UAvW0EfY9rPhCTYZoZ/tyCE0NzuS/fguuX6Ka6cntEsaHUvOdoCcRr+iwii9BDn4nGYeT1M4xZW25HdNrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8617.eurprd08.prod.outlook.com (2603:10a6:150:81::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 11:12:12 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 11:12:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 02/11] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Sat,  9 May 2026 14:11:48 +0300
Message-ID: <20260509111157.4039434-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::9) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: d571e680-3659-44ef-3e8b-08deadbbd1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bEp7Tm+U2rUJ9g1fyv5LYyjfqOC2kaoskr3LSU8i45xINW6XH5cSGHzDM+UyAM8QzLRcZhSbP155zCRGloBlrvesiU3SAh7TgC1WmUxtBPbXDmv8y4RLZR2h8yIuyFLQbscNQFoHH8CBGo+seTS464ZaZAK7W6VCro/7e6436q7M3ZL2k/d/l5885DhuSFmuz3Smfc3azYDJnaqrJwl2umsbAlgfFaed2TdKSB6O3dinbJpbpFwqHlHJLiJrx7Rah3cnwW3eCEUVHQQyko805eE/XqVaOD+3p11orlotkmtk42bzk7LgS6sZdMwWg4j7Z9pTjPFmU0ntqyiF+ORTaY9Rl8Nf/Zl13Jko8gEZGQOVCQa/kkMlqDxxpzRmi5JwtDBRRCNAqxEX8nFK+3Bo10LX2o1/oRGKPJws9tQxXTODp7oYlIJbybMuqHVbdI2T5CICS0HFzq8s28sMwxjZKqu6G+rJ4mtW1D0R9foompgH02R680Akwt1IvoerVqwn26oYZfGosWMc8qekB+dbKyrIzi1tP3f/h+Kcvnmh4VkiGo77Wz5+ev+yS5Iz0GQ6EN8Uotvyban+fTiXpfh6E/JB1BeeSakCfawlVRArFY4NGWAv2/yp2BCnk8CvlUFj8QR/w5Tv32mLwiCBurDkJeVxeg20iT9jRLqau/xIZ9W0hIVV0GDSCTfcqy+5BO5oDt0qRxccQuelzQZv6XA2xvOOmatBrRdPCmPoO9GrN0F6AeI2Be8INy18oDjF7FG21b17trqcYTEdt8o1yBf0Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?opUpwaMsnJsjWwHl5Zc+vzUzjvQQpzMAgstYmbnfw8FG+jlY5RBnxPM57ylI?=
 =?us-ascii?Q?dmCf7MY9ZbKTbbjLUcblijM1Nzf8xp4l11sCeSq0IItFSCp9YgTds4qTiDeE?=
 =?us-ascii?Q?ijpkbIvcx1qkGYHo6s4JAGHIjJ7SZ1i297B0ExBq6LLJ2ZoTp/kwgOR9X06t?=
 =?us-ascii?Q?Vplc+5n27RNJ9FZwZFCZKnDX16MNprd3M6anK7UN/WxtaEUoMaixa0DHRscD?=
 =?us-ascii?Q?2PXH7veLdWeCh6VTqzZQQ4maT4eKzPCJFKfdpABWtfrjQk0yxN7HNof/NXB3?=
 =?us-ascii?Q?DuZsXso2P2nRWR64Az/Oo5U5q/NhQ6ExAmIAwnk9HqWSDyN1KPm9248t1SmS?=
 =?us-ascii?Q?yjBbTPxazO5uXvt4mSQGW60w8oMy7WZLdVzwrXgSEekbJuY6fKW7zk0jMfmG?=
 =?us-ascii?Q?StmOS9UMKns9kDCHdZBQLDttE8IXMebZMnoqlgfB/z15LQxtef/gFS2kAV59?=
 =?us-ascii?Q?dKQjKqv5rpV+xVnxMqSsH736kxPRuFBg7+eM6+gxU4+EIguwrwnIlm3UTmiI?=
 =?us-ascii?Q?CmVLcqFgOGZ5XEqBNPw+ql3Fou2MSQHVIcb7gGhf2QxIvOy5XmMoIBpKXdVG?=
 =?us-ascii?Q?jfgngYAkjr2JzQOpCIk/jvMqxapTmz8HyoWtalvNxZY59m5x6EjxAwUzxOwT?=
 =?us-ascii?Q?j6x7MmzsFqCL2dcVMEV/nGpXXmLjOrvqg1cWW8elsWrSIXzykxIT0cnz9xDB?=
 =?us-ascii?Q?nm/9vKHp+DVA7woWUh3NOrVF6KskTDtTnllazFm7fWyIgn4GuVZXBC/Z86bs?=
 =?us-ascii?Q?fAS/8h9UyZDfsJegjBLMYGpRvaGg8bwsQOwLuu8UDTeqFEXS3q+oNAqJi9Wu?=
 =?us-ascii?Q?X5pAn9P4NxmjbwpmC+OX2z4Hite2kzaQW5gy4fqCkmVC44ptedeDfvxV9+Tl?=
 =?us-ascii?Q?z3s/oF7iXXziuI9ULLzfIPE5/rJ8wnWqUOs+ZZcHcGxBB184scI8qR2x6xjt?=
 =?us-ascii?Q?+Q2x3oMhhP6QTomtaAeL4FRg+iw35FVgPAtSm/sl9ZFTLRXZyTfY8XgTWBsI?=
 =?us-ascii?Q?1GMfXE8TVJN+PTflyg8l2PCmZUKQoN1hqgrPItGydrMouhnSaWM33X7CLOL5?=
 =?us-ascii?Q?wjKXhk6V91C0sr36L5tApHW1Z2ungxx7emagpv6Rdb4pmPpOqd6fliSodeMe?=
 =?us-ascii?Q?Q8SxSlZIa9W/kqXxcwQ4AV9VORizbN1hmBM7tl8Nf1nSZT5hrmYMk60jOr9J?=
 =?us-ascii?Q?569wYV94ymWAv2qeKl/JDoVoOn/9YZoWC1yfEDBlbSSo28mJTH+A8v4fqIst?=
 =?us-ascii?Q?qQXQpiwsjsu+/WpsJKnko9RWa3hagLgapco0PAOKjLqG1NMwzie1P+rgRtr1?=
 =?us-ascii?Q?ltR6cVXfcSL4DgyOWpT/x1Oui4CcSbbMOY5Hv1qcY0o/uCxwBpgZ5U9+s5BU?=
 =?us-ascii?Q?+Zzmf1+OtFQkUnWKOJ+JwZS5NgPCm6jOBODXVElTrLVGon8zWp2fgjoMYww7?=
 =?us-ascii?Q?NVIGkW/oMrhp+jywgKVLerrmXjhtHJ2L3VtKb9KgrwejNp3L/LkPutFdLJn9?=
 =?us-ascii?Q?7fNhpQ5vQ4vketzlYSFiQgLlyOgylFgstrwnL8nLR36/795puKbhIDxQlMvI?=
 =?us-ascii?Q?LkLiCGAxHzNFAmr1X/09eTgHHvVNw/QY5qsIq01TYekEvgfIXRAhyhq1T+Fz?=
 =?us-ascii?Q?4oViwd7ioPoiAlfI7YDVdc4KbQUhiaAEDBFk7dlKPoDjy3r380A4RIPMnL+y?=
 =?us-ascii?Q?GWB0KDo5hjNWSDcslxEKIaNqeLd77/1n44glLjyBSJskbdRsIAgV5z3IFDRa?=
 =?us-ascii?Q?LQrvGXDLnKvQDrNqCQ8OPpKQMjw9HU8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d571e680-3659-44ef-3e8b-08deadbbd1a7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 11:12:12.2759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYTaFbRMCHldEXVwSqlfvIVWGPQa1qY1ZubnTW5hk46QLU0HbtIOas1h/5hpF7m2I7xfvXctIciwgZd8riVLMAvj7MkkB8hyCEJ02/93kg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8617
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

