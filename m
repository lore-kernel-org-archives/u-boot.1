Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11EBC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29EFF82A8D;
	Tue,  6 May 2025 16:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ewLCoegA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A09382A36; Tue,  6 May 2025 16:15:22 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C44CB829EF
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/p4BYigAhDB+ySEsjuR3S9EJD38Jf/798m/bEUA0eDF7jYNWsosAfwyfOnBLjnOph2N94BCfWcx58f0MoZfPdkBGItFtyEVrqZWXdSyty0gGJy7F2cauZhtm3eZ62Stdm0GLrla6QQjc6l1dp+yw705UZmK2H584nesMzpqKqAhCm6F2vFNhGdpbT39EodFt7qNkNNPJfQ903S7pcYBDi2yW1CYyYmgAYYs77BFtYFUesRUGCL3ur0tyZYgABjDpbOCVjlAYNutKoD7YPzAOLC9YkyMnpIJ3J2Hx2vsK1H75qzhmGdaBiTGYO7DNIhGDWSXzHWTzK1PGuoa2WUBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfDdmsvnRr9lLuht36645lw9GIbFqQOPyxuoVq5hxUs=;
 b=cIZwFToU1sdgctyqgurSsW50UBEwGQKd+7SPj9+qkQYBtIEvmSekJ6MCJUA4hrk7IqYjH/pqLZp8roQwYY70di5HIXgMV/iyAW8xd4NRcbXfZusA4Fxt2vS/VVqagbJ2dNdDVeiTw/l0CBoXWBlDYnj9NQUD9bqfWsoUT2tJg/hxvBUETlB1OltJnwdP1v+e0Q7GETee+6OuxyWdpTjN3Dju3sHqbYkZirUP1Yxm/E2lyqEu0dsSmhFt+zkRWZ91/cVP21PX1tKTKuZdCqVAlUKWGnjvyUsp1D/9aafI7hm8OoUwXgP09VZKMPtDVkHVVb9nrfc+bfM9qxJuO2B58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfDdmsvnRr9lLuht36645lw9GIbFqQOPyxuoVq5hxUs=;
 b=ewLCoegApxUWuJ9YaDKbQtzvvpddvPcZ3JqXQcqQQ4m2c/G1/iHysA80KUx8+mCW0L5lD88gQQSKZLU68l1f4gnBiEu8t4RxEyJWbsS1eVKnog6UcoHGr5/ZFMy7HhBuXFf/3TGaddZNwRLmx1CiF977ogMWkIIKwo/73ElHCtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by VI1PR10MB8208.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 14:15:17 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 14:15:17 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 03/11] test: slre: add tests for regex library
Date: Tue,  6 May 2025 16:10:27 +0200
Message-ID: <20250506141035.385756-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506141035.385756-1-ravi@prevas.dk>
References: <20250506141035.385756-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0080.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::22) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|VI1PR10MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c8884f-3396-464e-7bf1-08dd8ca86d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TT2M5rrwTjVjcgtvQu2uPXvxWqXFrG0JCP2GWD3Hm+WOpZ2LupmDbFY+eKEz?=
 =?us-ascii?Q?8syBwiQeYMI1RiPRBsOoMhNyvOaohTyPkM1ZjEqRLlog95db6sdFg+Y4XFYV?=
 =?us-ascii?Q?7oOFcWfBl89D6uEtrbtel+7tS5rNUWXi/1Kxm2Y6hLGgSO+79IZaiKkNUcW1?=
 =?us-ascii?Q?rjDBQK4Ek9tlU9/gx7XGzl45peU6MbPWpkoQi3bOFOGp39fg46C6GY47Mh2n?=
 =?us-ascii?Q?TGlhufSfnpkSfNrJ9hG9ZQ1ypVtz87otOXKomxkKWdoTaFUI1PSBQb8ms7Ah?=
 =?us-ascii?Q?GsuoyqLtzBvIqKb64Rp1OW2jUqWKQocNCgZ6YKEfLXj6LfRJNaGwjUZehJ9K?=
 =?us-ascii?Q?N0+l2dGBrBnkiG8VFI1NvUWllqZqDrcg8Dri69X7zChRdKRupUeUwePNjpFb?=
 =?us-ascii?Q?Gx/iHUzOglNp26y76qWTT4+gWZ8a2Nd3o6ZXwPDtDuoo/bwEKfuayd7os1uC?=
 =?us-ascii?Q?gwwbwQ06bqAxFetioL+RjPmUsDuOQ7EbK9IKLVBYUhQ/5dEUrlweZB0vkck3?=
 =?us-ascii?Q?449U3rztH0FO78/O3cumt/TD9kzJQeDy2a9LkAqb+dH1b39hY8XLdOPFw16W?=
 =?us-ascii?Q?N0uRF7IXFB3xVW29t1ijCI4i1iC0NCaUWfPg1XfsZy+2YZsitKvcbk19pkK4?=
 =?us-ascii?Q?m7DUVdyd+0+l1eSa3Gg0Y/jfhlIzafOFeGJKEY/o1S5KMEvOqpKRQgvHWO2C?=
 =?us-ascii?Q?qAnkOerkIPFjghHNRQDIK9TQZz2K+KRNIbxyIdyBGC83nOkZqw5WzzJATLS9?=
 =?us-ascii?Q?ZQ6Va6ORmXQeAzYb8OceCfZiE7kR5IZeirASFitc6LmsqarqRAY6pSFomJf0?=
 =?us-ascii?Q?vkHphNDzpV2G107lc3lppfCI2fB6C01lE4TMKoaJXQc9n/acvowV5BK6AiWb?=
 =?us-ascii?Q?zHCPL+B9DUBmgQP2lQRYJuMU1RGPvb/OBB3zOIPt9Ke9ABCdt+qMsTNRZCbI?=
 =?us-ascii?Q?lXUDIbOgNZEafi0aKQszx1Ibt3qN4YOAta65rC115Lq2mzpNr4Zkt7Dt+P9Q?=
 =?us-ascii?Q?14WA7yM5bMIzTz/hq1LPtQiJn5doGWrUCTpZv/KNOIvW4ydqTOHpN096+q3m?=
 =?us-ascii?Q?iPoeh+40hI/9F74JqEjNO0l27Z2Tx/2/VnQVPvz0n1Ct5ajZG8a8Gw69ITEr?=
 =?us-ascii?Q?ifEda3qoogd04Wpyji48bgy0VohMl7MH0fT+ygMA/+OlmmsJfGspCCMkgr2N?=
 =?us-ascii?Q?7aQtlV6BjYJbLdXy5vAl3UVgFDXvJxzzpHIJOggBn0ggRSexy1C76qB4AIk9?=
 =?us-ascii?Q?YYWFc/jxAiIBHLCJTqpw3J2HTn7PtY8rzwHkUK6TvMN5N15oMl3fzwa68cX4?=
 =?us-ascii?Q?eB/+mar7vsdqyjmZ3JFeINyuc/oGkhXpZ5n9hMxTzbKwbdj8q+phwNCoeTS5?=
 =?us-ascii?Q?4hEdIOhzkqpolG0/h2xIMd+EJNUzdE3gpK7Q/wNflOZRKiVJiLy/Tk9Fo/q+?=
 =?us-ascii?Q?/5c62AoHxjuSZicGc0FisVxokawbk9mX2rfZZMxnOQB6ARTVRGJfdg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3G0tJPUZ6hD5G8rIYgBCwofumOIGF1Lu6yK0xDHn+iRsYbAHHVaH7KYDQpBT?=
 =?us-ascii?Q?tmW3mcEQPZRifYhD7vZM+wT5BVbp6w/1gsGGP7gXXnpYFExmqRod3scpgoWQ?=
 =?us-ascii?Q?h11VeBP2eXa/VfHeu6HyUap2btJswtw1amxeFzwYYbWlB7Ug9zF9hOUCcCr+?=
 =?us-ascii?Q?+r3eW+LeAWpoaRQ8NbTRFEuhkhiECJcPCI5cBFXKe9t79vxXGUvBenmf9dHO?=
 =?us-ascii?Q?d1tMwFWiOkDT+yE31PjPcSnWx9dQLMcAgFQStYhPAbQEfhD5r3OV3n06CiPM?=
 =?us-ascii?Q?xSAQ5Jkp2ssdUvQd2meAC2iTOKN4I92/21S7FLeZiQ46DmpuMlvDoE38pteT?=
 =?us-ascii?Q?mJwtuYywgizlAh6svMaZ2Wheb9PILEiiAIkV/o88FAqWf225JsfPCIXfdPg5?=
 =?us-ascii?Q?5WxCQzxAdq+Uycn6/aDv3EoTTptolD9a4oK+JucFT/tUgjmP60lJo/L6EL0W?=
 =?us-ascii?Q?WqkFLQK4uFg5sk0vzSMzzolB6R3XPKmlPaq2H3Rjt3t++fYrxLNQof+EjHLE?=
 =?us-ascii?Q?fRrunsIUBJBQ0Oy/egFXHWaJvsTn6cSkFWIbyeqqz8HmaYnlkH316CIYNntd?=
 =?us-ascii?Q?mEmCj91mxiIz4l4ht+V75o/fyhF0MUGmQ58QqsU/MD01WSzX0e34vW+fphwg?=
 =?us-ascii?Q?Ftk9+DtPqTbIfq+CHbjAuiSCnYmvG+Q3WRwB6FDGt/JEnkebyeYHqme1FbPt?=
 =?us-ascii?Q?iGyEbiAdnNgXQVs/Ze3Omc9oWxwWr8noTED1vZP5XyC6zDAy9QBXBizey9/z?=
 =?us-ascii?Q?5b/x6tlKXXAoHkf0ShYAHrByMDeefNrGn4LR3CXtRDKpYSJ6lsaMEb5sXunU?=
 =?us-ascii?Q?MTdFJUVp6rZktFQGnpmL2c65yWC7oZIVIeY+EPE1M5GJVg9ZqQPMViSQAhPw?=
 =?us-ascii?Q?CKpZoiIV2USnoUPWJFMm6PHhtQNgi0pHrW1ZijTj9ap8W4820KNCtAkYyDo5?=
 =?us-ascii?Q?PAYArBxdhZx+Mzl3ggxJ8TDm3J1UpqOHOZRfFmLLnWp/hJQY228Deo8lgi0K?=
 =?us-ascii?Q?ey9IAHWIlJv5vC3H79Eh7edI0zoxHzgQqzhfZr9DoELaKAn3jlFAPu1HyZqc?=
 =?us-ascii?Q?liKZB+Ue88LRp9hGYFtYzFhOcLKggKk+eJ1IHzW+MsuXkp+0E284ncWJ9Fwz?=
 =?us-ascii?Q?xkg8/+kar5eKN0amqSS7KEfey8iU5XlcbcTIyd8PT4j/tBOcO67PvvNBVntj?=
 =?us-ascii?Q?+FmDI+hNLkanW9krqY+lK5hVqJx2FCu56Wxn+zDb5qjQnJ6wjeBJ7nUC+SEu?=
 =?us-ascii?Q?S91BvaFXX/XmRONYzRXKfjH4bL6gXQiY+MFzFEaHJMw+lWHP2FhkPeGd12Jh?=
 =?us-ascii?Q?Lo/xQHu/OxQBZfYBYo8BCAISFg/DEKpbkNdAuECEFwUvoPi1eK/DfZE2ovF/?=
 =?us-ascii?Q?HzU0NuiMeC+5CFreQxws1QFj7grgxYo4G9rDX4S7oWFfRUlDNNaUzMqhlcVl?=
 =?us-ascii?Q?ErPiKvWN+O7vr5eaVp0FJ/AXZyf+MwnGiwNQt92s7ZMSlaH1CxULjfLPVCNd?=
 =?us-ascii?Q?vtQUrk0bpXfpS8Ii6xbNQ7YtjOf63TT6OwzJW9UFsw+vY6I5kwItod5LPvuL?=
 =?us-ascii?Q?rbMJSzu/ja5Hat6wyTF/S96nCnoWCG0JOEQBEpAs6amcBI21gScS9iI7z5eG?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c8884f-3396-464e-7bf1-08dd8ca86d06
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:15:16.9642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4VzC+R2ipXIZfX84MEu/nUJ7LKigK7rbyqLhmYejVxfvf6NoDZiqItIfUCCBAxnQ0RjJqOhWuYf45zR7jDDf10ixADVwCDYAiOcZq65KDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8208
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

