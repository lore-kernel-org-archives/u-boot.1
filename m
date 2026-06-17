Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C62CD98E1
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 05:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 153EF848EB;
	Wed, 17 Jun 2026 07:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="D5cDnI8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76DB6846B0; Wed, 17 Jun 2026 07:30:05 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C0EE846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yp89WUeozwj6yI5I6pZM+RtYuQZNYwxrjLfG1LmR62euc8SRNlRm7L7xSQzD44HYYamelovKT9boDT7vbFCtBBt/eEGd64VoOz3s8zvQCib0OEBLzUUgcnVF5xLWbE+9mydyHvFAufG2HT8QcW3Ohd6cY8CXWCidz7XC+57lDXdRPreBdRbQGY7yeDKVTbhTSIwuS3bZYTKa8J6r2D31Ei4BpgXLNu8s/AMADFr4HDV+6hSG2TBiNFv1pCOAF4X5nOfYyCJHDDIDJI2sQYnNfCS0T8Hp6eXHDgsiW2FppT7I4TaAySWT3EJMc4R7DyV4WCnKe42nttDcOlfRrR7frA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=mbQnTTH1W9J5lnJ3R222kGaJmcrgLpimsWHFMZaoEuKYvre5ig5OVRLTL1caFPrHj0oyc/GMVuAHeJg5n/H3rd3FCDP0C7Nc1Vivtaz03L3CAfrVM1YE8pL/l+XWCzarsfbhduTVxeeW7iTgIYyTzvOFHaKorDt/YRtE+PypEshdD8IOVVjClgNDaxUcshjvMSpJ2PZ+Vm1+tOt0ibKVOkrXOH/Lv1thrvtkOUYan077AeGNr4AKpzDJKoQlCIGl1jRcWzUM1na4pWL53xvGQLLP6QxVMvrUesbdY+nChAh5nebgGwbY2t3zonJ+++9VtYAprpGCpnpZc2xFHiXhUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=D5cDnI8+ufurjB9prVyJQ68WoS5QAnsvizPIR3ul/2jZ7UxWG5gCKgNtFAJUwUGq0bacy4yiTrUmU62psGHsozhJ3VluhCdhxyacv158i89wwN9ORyZaI0U+q543hLVNYxdx+EYy8KBrWvS855SGYirMCmmgbWnTfJqeC4ezjt550hKON067HHBPA82Ir+bGE4SCunbloLB/HD9zhVNE5NhKGTxDLtQlvbosHeaibDdSrSZlIQpkqO7wmNeYGUjKu7JiQE7TjQ/sQgNqqAVqylncwBPwTNE/KbXxcK/U6AJ/HBz0Jv7vGIUse2f74ZX3ClrVxwlt/7cQuE/HRSljbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB9653.eurprd08.prod.outlook.com (2603:10a6:10:449::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 05:30:01 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Wed, 17 Jun 2026
 05:30:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v13 02/12] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Wed, 17 Jun 2026 08:29:38 +0300
Message-ID: <20260617052948.2815870-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d9b49c-d424-40dc-ebee-08decc317a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|7416014|23010399003|921020|38350700014|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: ny/qiV3gG1jksW7fmVDxUBToU3IfwXwklMIibBJEe8JH9p9lhGILqbI3tUK8vtHHiuKLj0oAL8qlOhWTpHRhg+7goQz537STKH9dWqyImckBFtVGHc5wkkn9WI2SrnZYtiDdh1Oi3NVXtYHt9NZUZqa5ef+kx6Vri46fiS/28WOdpezP+oAL6QEQqSp+HlpYSiN+ijJpaBsVRRn1WHCXSZ6DO2z0jN031oqfgn0VEAA7K4rRLOrCcfulz8Cwkj+qIKEyUjhIyL/iAg7xiC+EzwCSxDCmwZIIfHa/Cw8+b81n5BHQrfiEO/TBVt88235sXowi+1AQDzDjZCOPReEWYE05tF4JFLc+gaptzUV9kbmYLSbF/g/P1Yo2R1Oy2g+Q1H/1sWaawoGCMdGFNpfSTFVZunL5BpSh0gb3OZrcOhvO9wY4QKavzeBhMSee59etJblJc+ET1VXcj2G6Cf/Qxi9MZ9CfljhfkAFG+losp+Wjnqh8dz0uVWKklVqjREFUIvtbjaAHIfegKjb8SP+9wlKY0YoF11+l/Re9goV2G3Cys8ZS3HOfeAcgvVFgDVNas/kwKe/4aHZ7lR5aSoKjWmlk/CwgPq5U64w7MMw7Srb0MPCBuWqC48djeQn7V00beeyF1m8olr+c1D4Cvecqsaaay6veSQeIipRpE8DiU0nc4mN9F6F6c5QbORyRALgEjPfyysLSpAufgdxNQlul6a08nCteetSbNYsJ09msupPGIZr4V15DfEUl6Oxjwcsl6cfPlMN/18ilAbD3vNxXPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7416014)(23010399003)(921020)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enlovqDIVTNd3rn+2hZI5Lz9cqaKiSQ23h/x3C3X0qpicBE12S9JInz5OuKv?=
 =?us-ascii?Q?+5j5Hxaw9f+EkazEkfOKJ9H6nCVzhsyVwm40rLXBvH4GLnXoE837kiDMcSnn?=
 =?us-ascii?Q?Ku/ogxPPJuMwGd5vGs0XT2eG2ZdP6TkGiW7zqQeStuMWNxqQGMs0wvP3IV4c?=
 =?us-ascii?Q?6RQkv03clFWsNjmLJI2gAZHZtt2jilHvQL2RPaTf/0qhSa+gl194PVZVDR2W?=
 =?us-ascii?Q?GU+vT+ebFKUWPH1xPdMcCWRqJNoE3WdUiQAuAi3mI5cBNJR8EzqMbcfoTPgS?=
 =?us-ascii?Q?c1M9FpS0NM+MyGg+2jPlwbYBpa/sQ/VfdqE+zxQnv8pOCPEkkT7RknCBw3Ih?=
 =?us-ascii?Q?SgghnHGxY8ok1eETx6jwNoWSFblvhOTb8YjUI3I7AXws5Fv5w7jtClxBl7wq?=
 =?us-ascii?Q?kO7ioaXE7B99/CBtmRjg7WW3cpJ1zu+lKjepg3t7ynC+9usfMOjbhtTJile6?=
 =?us-ascii?Q?rgTOXYsgODo+WhZy69SPjECPrzsTbVj3ja/laS9/21gOB859euKMohi0tUrA?=
 =?us-ascii?Q?lFR4F3Iqfs7gYVsWhbJAak9M9nEP2TiOevO6MqDuE1+Ch593T5BvAzwNUax1?=
 =?us-ascii?Q?MqF3X9yujSEAW9HN8IknFRnETIs63GNcZeloy08/2CY8hgxisxPT7wnp8iva?=
 =?us-ascii?Q?IELza43UHZ38mZNNK81fHRdz5bGPUCmFX2rZ6H4ydyCtPQmB6mh6fybxsPz6?=
 =?us-ascii?Q?kfGUtdfEsMi17TiTPtj64tLZbosLAe8KveqqKrS3i9YelJ3INK5fIMdhtXJD?=
 =?us-ascii?Q?0zH/3GbMOxrvkmhYHOUlW22M6Y7+FrhyPlRceMCvVfpE6An3rerspxocgC++?=
 =?us-ascii?Q?12ToRCrC9R/q/b4yczoqYOH4GK4AKVDA4ZHD/H0XlI6PgYIEmRjne5XIRI75?=
 =?us-ascii?Q?RMKucasN2qGUjzULWOj0Em0yTv13Yl9vMS3NpIbH3aB0NoV+gxrNwmPR+RLO?=
 =?us-ascii?Q?OO0jF3o2T30vPY0h+nzJhhshyUtNHFo70CxmnJvF9yyDrfzD/qgEzaSTY6hI?=
 =?us-ascii?Q?uNJjFKnJRf+9/JMzNGCYrPAVdoPn1hC9Qm+awChsH22aiRKixnfkG1xXM48t?=
 =?us-ascii?Q?mxayRWmIYxV2+9wt5cGRpa/7qUXz/7hd4yai47Z3omakruHjinlyGYXnreQv?=
 =?us-ascii?Q?YdP2o5OMP9b+XOdp0ivDpVZ0zFyFNazGjod4pjKXkiIaTlXgOHxZK1Y7P2ze?=
 =?us-ascii?Q?QftJ1UUH99ivFwYYafXJe3Kr9LeDOSlCwaoc9OnHcgxCLRdLmwiNzl4c6SYm?=
 =?us-ascii?Q?whTHNNt14C2xwNOTQK/9+3LoyPvxEyogmfHlBEDRqYwrn7xiG+UXtsNL/EUm?=
 =?us-ascii?Q?Siq6SeLc0Gm/eMTJ4L5U0rfe+dziVC18Qy3sKQg6nP4nZ3Pii9skGdRm+TEs?=
 =?us-ascii?Q?mEIl57+7pp4uaJxaS+LF22nHro4+5zaTN3g591zkNG5PhLs/tCJbxfoznIyk?=
 =?us-ascii?Q?2JaEzG0Ez+CIVMPUtfVHqmUIAvV/vi5mLN72Xi9TCSJWK7WJyFN2Vg1yIUke?=
 =?us-ascii?Q?pZrmlAdWHC0rMXzlSPmTFr4vHgWu581xz3VbYv6voejQka1p3+BXijMD6zEQ?=
 =?us-ascii?Q?N+krN59pLM0BzlW7SqyZrz2wi5x4/9JZg4JsnAUmUXn5PFwkxv2Mzb5NK9vG?=
 =?us-ascii?Q?jtYooe3rY/FK1cDsx9hp/RPlgc3zMKkz5elaLQccDiP7g7kfALrOtSYeJmVi?=
 =?us-ascii?Q?DbukFUDKshoLbfDGn4nl6b0Xt3prA5UwCTe7j2pY2OOpyY6Ap2Ym6HdMZylZ?=
 =?us-ascii?Q?NBc5XZQZ14ofWuzRqD6IRcky5OmgupM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d9b49c-d424-40dc-ebee-08decc317a45
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 05:30:01.1939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjYoEaOT4B+ja6RC5SLvFL/ZvPcacjlPcjM7xWxFtMHfLzCOvraXDNj6k0SMvwtVpvzNXEpW0NGlbA8BbV1W19qNBt3EYpRGFFrU4XmRipo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9653
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

