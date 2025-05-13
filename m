Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF469C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A4D82A46;
	Tue, 13 May 2025 10:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="jCkQX+v7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF66681FAB; Tue, 13 May 2025 10:40:47 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 340828294C
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCkz3+0GxTncLa5/jfbCa79PtCNbhys3iQvPDqkcSkHy75c+MODVHZXWrJuynXDh27LRwbrinXW+bZfD6jkvh59/k1hYyU9OM6iG+MBPea1J80Bto1SS4dydRZjZwKRuwwQN5mK2FyAUe3seNdw4jBgy8U18zkSTd6TOfFSzO3eYydsYkrIHbNe45u/Vbd26RuYU9ijouxDPFY2mjw23J+7gBboVaGVtPY6ZDLpMBK71x7lEhMo6tHy8LrgmCViqoZYCFTbgFwe6Jaq+ok+LkO2M8BtZGApw3om7b/oRcqAFI9Pbzs8NB5e6Dq633TUwaneiHWQWpzpQikzbaz8Bng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKge8mGe5BL6sVOma75BdmjLo9YEkTFN3OTlbGvtKOM=;
 b=e4cy8N7PNBvEc8v8/Q7rUN3ccNCZfwWDNyXJu4UXCC6Y6XDtpwWkmgCY6KtTXgKLjGndiLXReq2dvCUrk1qR6v2M66cYeLUrtHnX6u6vGB+uda3WVOBn1WQoffIKNZPjZEl5EnohG3ZyDp+xs88AD/VUbYZZACtsbjDzoYuzktnhRn7YXk3JT78TLLdhhhnUZYOU8G/9KcaMr4994RKMl1bo2nQA4YS9ol637eomrduOiVBKN6lCinFWJFsUU/A6pj/joBRqvny6Q3nNrEpxr+XMYykYFmGZ/+BK5czJJEqUoKeHdSSK10lQ5s1Nb8qBduXpbYabfiMH7cP4yJwQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKge8mGe5BL6sVOma75BdmjLo9YEkTFN3OTlbGvtKOM=;
 b=jCkQX+v78K2rpaiKPi9E/o70foboWMJJ9134JusVJW2I+29kmnOMbeQpvu2fKRdDIeip4MpF27tOdNq6Pi+rMLLb3V34v0hfCEg+Q7FOcFlbvGUMZzdyipZgFhV2IGMvIewh5r3vk7MuUPMmaI+8Cew95RHn42BcZ9KSBRPeBmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Tue, 13 May
 2025 08:40:41 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:40:41 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 03/12] test: slre: add tests for regex library
Date: Tue, 13 May 2025 10:40:25 +0200
Message-ID: <20250513084034.654865-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513084034.654865-1-ravi@prevas.dk>
References: <20250513084034.654865-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0019.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::11) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d239bd-6472-408c-2025-08dd91f9d822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iIaHBoNySKjmHscC4KMGLW2S1G2W/bDY4tVAjUdvHsv8Pr3VuGnA9IUlnuzj?=
 =?us-ascii?Q?HKdYlE5U6bsx5JZvpg1E9nYlS6EszOWUCuNICYbTi+9ARD6XwrB75phlxEKu?=
 =?us-ascii?Q?swDZwm4BVHHEJZHw7DmMShvzH5DW/KjmVek7KX92aOeWkoxvYfZ3xzImtvVp?=
 =?us-ascii?Q?lbutuKvbLz3PHR15dlWCGSPYt83M5eXlyA8kF23b74BsMUCzZkoIw3wHp+pH?=
 =?us-ascii?Q?0NP39uYD3CAUwVTdAFPDlU/H5shIKhMeHD2r+de2cB1QmlzP+w5AVRNSGct9?=
 =?us-ascii?Q?J46Bu6wexqleAkP+LA291a2HIocW2wvik8oe1i46fu0ez4AUMIDBZTXjcvWC?=
 =?us-ascii?Q?k6/LY6v37LjPa/SHArwld4GXb2ig9qHl+9SVwyGNreSEf2vW1Zl2xwaAU8L1?=
 =?us-ascii?Q?U7xdzcuQb1T9lAVwxTtuPkCiQjH63CaOSAzgjGfOMe5fuLjUDlTNBS+erNj+?=
 =?us-ascii?Q?ji5+DFAZT62axxaeACY1rkO3swQ+weersFZT0RkU6a/T/EpgzvBfLvhXdIfc?=
 =?us-ascii?Q?FBQPhe82e65Ah+ylKfQX2hjoXOOS5t3cexw5jeJAxZenPgKdBwN70p5KjyR9?=
 =?us-ascii?Q?jCG/qavPMA7JKknTpEDBrjSEqmpAvPBR90wT5RvCcCFRnLgYuTRv6RL4fUbW?=
 =?us-ascii?Q?PB7tB/N3+oGZziFdlYq197Pg/b0VJbWE7klohy3EwyyFVoSOskvWorlhUc8J?=
 =?us-ascii?Q?YJBDGG4dZ9ljA2kBE7az7pc6F8pddEM8ktEnbZc06P4ZoW+NM2Ovwka1C/Z4?=
 =?us-ascii?Q?yG+t0fbrw3pTJg+PYoEfZ01HjujxZ1NTrGql7pqYsxw60hl0LjbEwF0VZTaN?=
 =?us-ascii?Q?FjrQTIFCP2yr6Z+rxUo2uyn11KZ5NieAQSVtKwKmHD7Br23jP6exWKIhR8tW?=
 =?us-ascii?Q?7GFK8bmg83kUM8czKfT+gQ7S4/SUtJeR5/UBRSqIMsGaEb1o9NOkWo7jldyR?=
 =?us-ascii?Q?F7OXEF2PaS85KmVFEML9xpi7rs3RCOirE7Y2rElsbPStqRR/r35mrZBbRGIG?=
 =?us-ascii?Q?FDH0M8WNH5G9UsaQuZzRyqJdG1Hky3MOf7DepMwcxXvBxTf2EMUXPiyajXPi?=
 =?us-ascii?Q?XpgtSDH44/yU1osZC4FUompusYW76UkYIimNHw0Nq0TPhVMa22cyB9OY+xVU?=
 =?us-ascii?Q?I/tEC4fEIo8G7roNwf5sj0EtP6mT3gMGQBj14RpYJSZtLpZauGcfVQZuLLCI?=
 =?us-ascii?Q?vPIcqXsUxS9peMlMeF1ebZwrC4fRK7BE0EZi0XvwNIbuSZwVF8dNRedGzab8?=
 =?us-ascii?Q?cALj9Y3c5IgrJH5X24ApUaX+1PQa17u+aLwRHI1/id/rfQ1UPsbLVdemh9Z9?=
 =?us-ascii?Q?Zzu4uLmUbLOlUktA5wTVroWNzvGbDh5zud35fVVYPe5J4FRb7Dyz5fYqjaA5?=
 =?us-ascii?Q?ZDYu58GxY41X3Uy+9njgBICm8/d1pic+OqecGj0VLnT26DrcsEW+WPzJox5b?=
 =?us-ascii?Q?JqwzpXpeoVhkvz13jQq2A7YovwOyuyNxQE8T9bpxkPFVCrZJMaUD9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7PMfCzbEf2M9zwxianvrz7VF3vz49Vp9TS5YadP8HAwuhd0mbU8Pjrm3yhZA?=
 =?us-ascii?Q?6TTRmSCcbBz5Jghs7l0GF/oOqOe8IqU5x/YuBolN6x7k1A7Bq6HH2Ltb7JNZ?=
 =?us-ascii?Q?Dx+S0yJUX8Jfpnf89cZ7xt+ifhsZY2CKrqeNnjJ/q6Ix8smJJU9k2xsq6bwl?=
 =?us-ascii?Q?jP1ToriCgYaMnPASlmrP+RQxroh5l3PPyCjb/rPIXE4dhBRV3bhXP5w4b6+v?=
 =?us-ascii?Q?5Q9gvVLXtRZ1D7YVi7pPa+cuX29JaS56rN25wcw1Vi8Rt7ZS1lrpG3LB4eJz?=
 =?us-ascii?Q?OvDJWma4IVqcTlhZK2/Pf2lvTQpGCT7WAJYeqhgi7VtJdwy/wGMV43hihA71?=
 =?us-ascii?Q?tBMI09oGbYQtQh1g+ag1H/ZuqSK8mPWt6T+ksGaWKUrhlEgdPBAsjoDjPW8X?=
 =?us-ascii?Q?c9wbdjxmIxIu9phWulk454mH286GcakKchzeNul90Qh1rRptLdnIkYhFJYHK?=
 =?us-ascii?Q?NMcON0QOaCAvPeDH7eSo3FlG2W3XXO64pGjde24bSnF89XiYXqNd8cjWRdsP?=
 =?us-ascii?Q?pcUAPzL4+C6XSSNvGG4K3ulfsuVvzd0Zj5aGJ3Xa4gWvkVQa19plB9lBRAS/?=
 =?us-ascii?Q?SSFoPh6PVcKj0jxEoW0zNTqUoVfkncZqhl6fcAku5E4LaaGzkt6ICrVZ7woz?=
 =?us-ascii?Q?htXVIbgdpwWNZiEoxYCHTFzwjUlRZUcBPrTgGtoi4MTqg/Z11TADoCpUKND0?=
 =?us-ascii?Q?w0R8Kl0VLt9IB4xxilTQX+ulMqc/Hc3UxhJ2bXgGUOVEPFLJ+zXHJ7pCy3lD?=
 =?us-ascii?Q?i7axW4sk8jIjoRcYwx73Add7t5BPHWuLz7c9EAN49qRKd5ErLrq7egySPJAR?=
 =?us-ascii?Q?IxMd8kjhiyvpUKvtHdz35Ca+t/qOk/ORiFxh6hYGJpwjkxptooZfjQY8B/iX?=
 =?us-ascii?Q?SLXNM8W/dSFwJR1y48gIIcvkRvLLvXtqpkLUOJhWXjaWWGliAh2lswj3Osvv?=
 =?us-ascii?Q?BhOEAkpznrAbA51od3xrrhVbTsF6b+GsPjH+BOGXdR1Tlk4KnXREOkYAVsT9?=
 =?us-ascii?Q?4lynMQbmE0SbkfgA//vNQ2fw5Dwd/EtcZBde+ktGgPWwWChekGv3HF5q+2jN?=
 =?us-ascii?Q?zTHHW9YixTovl16ak1V58bLchqTdfgFnXnnGSf6O5C0t6+8waHoK3hvyYQ+E?=
 =?us-ascii?Q?J/ZMP/0bNqDnwnutCx+WEeHRZMG9HVl4ZAZBrwqP9+LGy05BLMr811vcV3O0?=
 =?us-ascii?Q?h64vyCMl3dLoqOyPpmJpBbgskPW24BcS0Bq2wROuemkhEzNoZSWLFoRN7cny?=
 =?us-ascii?Q?wRNgfTdDniOcThzoIrc7CiI4xR6MG/4VHnUEmuEiZkGRhStnkpxzXlj5dMPV?=
 =?us-ascii?Q?5gJUn9QSS5lJ2Hm+fvA16Z9KI361/oINQy0hrusimlMjWF1UXDNw3JwGcw8h?=
 =?us-ascii?Q?kqjeZBlje6hrKBSzB98sr/uOYRbD2rXex9AICALGLEVaOE+Mg+mjkghZlIRP?=
 =?us-ascii?Q?PUlDVWSER8CUYlnZd3TAnaJ3bXtQXYXkF64DglGyRDF4Oz9VSh4xM8/ujsbv?=
 =?us-ascii?Q?kZSxoQWvfkm30GMNWSCklmveV1oR9VTx6IT+q0Y2uIptnbkPH0iwczRv/bFv?=
 =?us-ascii?Q?da7wm+ysNIrM5Anldwi3bUWjg02qLFcVerpOT4ooBq1ZFQG+mIxCChmk6hsT?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d239bd-6472-408c-2025-08dd91f9d822
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:40:41.7025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8khUtynriMjm4Q9YCvcg/K502ymOKyMD7K+TIMrIn0HbpMRBA0Vp+5+Dpc8ZWpgSmqN1m0XZNgkXCA00g0iHhznmLJblnddV2YFDoLf4Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756
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

Inspecting the slre.c code reveals a few bugs; those are easy to
demonstrate with the new '=~' test operator. Before fixing them, let's
add a place to add test cases.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 MAINTAINERS       |  1 +
 test/lib/Makefile |  1 +
 test/lib/slre.c   | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 test/lib/slre.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 94c62daf834..111e2767917 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1633,6 +1633,7 @@ M:	Rasmus Villemoes <ravi@prevas.dk>
 S:	Maintained
 F:	include/slre.h
 F:	lib/slre.c
+F:	test/lib/slre.c
 
 SMCCC TRNG
 M:	Etienne Carriere <etienne.carriere@linaro.org>
diff --git a/test/lib/Makefile b/test/lib/Makefile
index d620510f998..ff4ff63270d 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_SHA256) += test_sha256_hmac.o
 obj-$(CONFIG_HKDF_MBEDTLS) += test_sha256_hkdf.o
 obj-$(CONFIG_GETOPT) += getopt.o
 obj-$(CONFIG_CRC8) += test_crc8.o
+obj-$(CONFIG_REGEX) += slre.o
 obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
 obj-$(CONFIG_UT_TIME) += time.o
 obj-$(CONFIG_$(PHASE_)UT_UNICODE) += unicode.o
diff --git a/test/lib/slre.c b/test/lib/slre.c
new file mode 100644
index 00000000000..51a50b269aa
--- /dev/null
+++ b/test/lib/slre.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+#include <test/lib.h>
+#include <test/ut.h>
+#include <slre.h>
+
+struct re_test {
+	const char *str;
+	const char *re;
+	int match;
+};
+
+static const struct re_test re_test[] = {
+	{ "123", "^\\d+$", 1},
+	{ "x23", "^\\d+$", 0},
+	{ "banana", "^([bn]a)*$", 1},
+	{ "panama", "^([bn]a)*$", 0},
+	{}
+};
+
+static int lib_slre(struct unit_test_state *uts)
+{
+	const struct re_test *t;
+
+	for (t = re_test; t->str; t++) {
+		struct slre slre;
+
+		ut_assert(slre_compile(&slre, t->re));
+		ut_assertf(!!slre_match(&slre, t->str, strlen(t->str), NULL) == t->match,
+			   "'%s' unexpectedly %s '%s'\n", t->str,
+			   t->match ? "didn't match" : "matched", t->re);
+	}
+
+	return 0;
+}
+LIB_TEST(lib_slre, 0);
-- 
2.49.0

