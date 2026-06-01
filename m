Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078A5CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 19:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500FD848B0;
	Mon,  1 Jun 2026 21:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="mPgajqgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7F1848C5; Mon,  1 Jun 2026 21:53:29 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FAB1848A6
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 21:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBkhHUo3OMCRDHupDK/ARGyLqxKEFejNyvdeAe8V00dwGP2iMs+rxYlg38XX/23hVlsSbLJ5n9ksn3t/mrA9Tu3pbC8qNFPIO1+im7Z6uqF9rMEBIgnT39Wo12WfmOppGhYAzlQmLuU5lWWhBPnydo1gSOgQ7s8jOx3FSGKRzdw8sMmQI6OmBOh9MWMFLvGOqBUOigNFP2i0iweIEFxtVOQs2i2jAnFZOrPxF5pRrskSNcISZqqA5V1MpNxqe4OdXSAW5hdO9NfvqsFviR+CgyPhZXKv/m0OvnhvyhnYb7uudrzIt5LJeCDWFsyEvzpMYcwW4Kj9xzH3QgaLP/nGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=E7jBvXpm4qrKzXqx5hQZyPhFndLXAo/PLBJOxm4Qvx1u+XSdg+nE/cJKjzSqcGcLzQRcl1j6ep2qyevqNriXZMQXE0gmlNlW3FY57A5+hkCIzNSnUN17StV83nR6Pg+2YGgkozDN4/lGFbqdrAESWgXmgdGIcfn55IW/qy5R3HR12JSzlZwP06FduyammIVQzJLd8qb/VcKzKYH/48/KsNZTVYUA25SRzcIzRUI0Np+jx9YdPee4OsunCYXYAVKmEfMW9o31ZrTglFdeLuzxN6KMwc1avTjQ0aVLG5C988t9PXW1FwmyEEg6XJ9EYpzSwZyicgzgQr4yCnrEQ4Jc2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9bsESbOgnG5/Ssiv5Xg0vJKyPumO2ALYL9yKZb5cjg=;
 b=mPgajqgXLc81Csj6s8q1nsFmXVE1jPKE2wVXR6bTpx9yhsSTDC/+f4l2UG1XNJLLhU6ydhrFHwJgwB0ak4C5mtqHvvfrsJnlmkQkKpiyz+OLC7VU4QPITUQi3wJ22uFp2Nc0DitZGNwpbDA5YMJ26gMpFgnuRX74j2wNxxJDEwt549AMC3WSOQSTfjsTjuddTCiABRfT1WwkPjiWnpbOdniM1RRaaXiviOWlzuRG7/MwtcnsdNx7Rpv5SCw2gij++T1Dk9DTxUUVpCNHg6umVBt5vRFhxKPP/EcBEh1kPfzY9iuMcf6/+WbcgQxMBTOdrK/YhzreydaRekQy6uQP6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 19:53:23 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 19:53:23 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Anis Chali <chalianis1@gmail.com>,
 Yao Zi <me@ziyao.cc>, Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v11 02/12] bitfield: Add less-checking __FIELD_{GET,PREP}()
Date: Mon,  1 Jun 2026 22:53:01 +0300
Message-ID: <20260601195311.2390473-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1d4ff4-7787-4be7-e035-08dec0177073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Rn/BhEeO2svXW/99U5yCSIPP6onku86hNVG3pxCm5XDkh0EKK5bIqcfCJ11XyxbOKWCNM3PqqE7ScjtAD3MFtwKept/QODmiVmvZ8rIKTVMJTzJCPv/dvFc8hpcGVuV+68x5xIpiFFrDEc5yXVReXWHWPplw8h6vk8d5ZAWjDV148ermRG2yCc742xdlo7iAlUN47dAtrQjGu0RYHCRUOr2DaDm+MGOWpMSwQBhJL26oZgTKABb47VO0aWP9qIeSfUYZvI4h439Ck9BbEN1ry1M7T5yedG8RVegTjieXdIEQ38C1rDGpA9zRCSqk6DD1Zj3Ugbcsds4outb/qj+zoCnGtxqtT/m2zU/0hn33bA3cML4/sXTvsn2rrEWBkuUiZGCukafRTJQ351G5HS3xMn9dcj+6DfLw4NU9WkhrgJUXOUmgwvOQv2+F4GdH53ice/qX7X24wQJdMoT2dDeQbClGOmmSZI751i68KDe8NPDeEWUc2zYiOsOKoYwT13KipSvhRHlkn/NfBLFGvHB7F6ptY+bpniQx9ciTrBWL4v3n4fVhMWCllzdWLd22A8Cn/W0dg7kc26nKue/BGnpmOTC2v/7nMCPYUwjClXzXOzDhwBXRNMWn/iAzXnTptxo/KEPut6nFnAKl7OoQnFynqUoIdklbbM34es/9s2qOVte8NqaXFW8V7oDH6vvBo9EuAwXtEeuy27GXx9s5lW1t9/aqDeNK3d3LKV9cnUXlxYzRIfuBJ8Ki2cXTd9hGqrYJeZ5rUCooA/1T1mXw+BU3aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t0Zazm2ZTmf+mhMdBC2HHmzBz+0eVz4gqhsphKSbbYaTczmDQtmx1bqggU9L?=
 =?us-ascii?Q?v2P5tGH2/IPpek17ucklgXx6qcsdkBq+rO1EAJNmEasmV/jsLiffcQekbpEB?=
 =?us-ascii?Q?gCB+l8+ut62ta7vAf+uAzi7LS3JPiyMogi6+gLQfdGM1e71c86orl+8X5wQB?=
 =?us-ascii?Q?N9jptbDX1zG7VQA5mZqNhi7DzLUTMU2vflUajR1KPXNR+ZLfZ1HtRUhia6tZ?=
 =?us-ascii?Q?BiLmIRIPgGHR5eIVgfp5fwXYUonXT6eWFYdvy5O5Gmx/jAsRs8jiWrAFUzMg?=
 =?us-ascii?Q?JpBmPh0Grf8PczTQs6Dfr/px/dG0F1RUl9KWjlVDCPcQAFPHy2VgtXCWjlBB?=
 =?us-ascii?Q?2qV5mIOfp3eO4yeB1CnGf2Jo55Cw3rGHK9iI4y4/SIi+QnuUGqqDyjBiBoA6?=
 =?us-ascii?Q?vKWe0j0kZnPHsg22m6dw4C85g26UipmXxff968aIkNConEBwZw11Jnoq9tBe?=
 =?us-ascii?Q?NZMeegqOu+sREv6Rk8VbZLMqEB/O+EcXCGMHftIqCfxlzhH1lZPDX/L2vaPN?=
 =?us-ascii?Q?usprn2yrHsW9RUZhra92/5roy5H7SVC65taqZvv4WDru3PQfys+4bvXm1+IM?=
 =?us-ascii?Q?XNMHFykIUap/oJC87U2jdmByvVI0RXZkQD6SrsRA5XQMurH4ol+a6ALPqvrL?=
 =?us-ascii?Q?wSM9Bo+mGPa18yILay5+A8PUZD3FOJJmDnA0trFgxCLKkZsnHYdxLdxuOE8D?=
 =?us-ascii?Q?18K9xaBW4+EKssK7ythShsrZ3rkNhe4EIOttYAe/ybBgRZ58d0GFjmJVbFrh?=
 =?us-ascii?Q?dPBHCd2Bfaepkd+MbcyNqPCyehzhYh6N307uCpdCAQj6oeV38fMZyw2JMig0?=
 =?us-ascii?Q?VDYuTKACY2yvpVsmoSkiGZADfgzldtvtJIIGGdyw3ikfRbaAzyXtoQyqN4yZ?=
 =?us-ascii?Q?EqKh2PUkkaN41Xw1/Wq8EACjvjDM3AhP9G4rL3/ha+Ti2TcFQcGOEZDhbWc8?=
 =?us-ascii?Q?C8h/7n4kX23wcAsiTogDkqyJGpBj5kqAEMvAOjryLpQOagssf8IGr45NuF/8?=
 =?us-ascii?Q?fxGbbUgBD8+wHS2oebthk6c7q9LDkAxanXqDd3DmrCKA7205OGOaYFEMb45/?=
 =?us-ascii?Q?WuxozkmR10Q32tQNwxMIU+CmmbMbJCEk0br1TOlSazsqBMLy6lp7v700zQ2R?=
 =?us-ascii?Q?EOzbm6PZsaD9W6QHs7F6LSmYB1eBbAg+6nAAlVnNKztno2izU3kZvMAot29R?=
 =?us-ascii?Q?lUKAcWE/dDse5cscpvq5rv1x89FFg9ULEzftvB+fC7ntwlG+ef9piFds4xFM?=
 =?us-ascii?Q?dl8w6ChgaeJWUfi/J9GapRr3nORy4Bs9gyefGqBitC0BTimLf9aRQWq7F3AD?=
 =?us-ascii?Q?k8JKjssupLbUhloP8kJysAQu1/LcyUh4qW6DQmQBxmBYaIwmdcDno2RyO2ZW?=
 =?us-ascii?Q?rVGzSB/bEXBjKe9zuyR+kIxeLcE4d9VtbbstIME3afRexShcKpVtsvtqelFZ?=
 =?us-ascii?Q?W1vOS8fR1zgVX51k3tbJjL48ACqr+orWkBswNgWcy7tn7bWiGRrJpcPEzAzT?=
 =?us-ascii?Q?XdLNX87RcxMmDXPEIknkD9uBJipV2HR2i3YNif8mrTDT94nHy9bk3MNTq7QM?=
 =?us-ascii?Q?MNhGddNGlgp10cTGl1j2OGqmG4xaclykg/C8BZuXNnMRg98fIMrpvU7jx/Of?=
 =?us-ascii?Q?LMBY/3I/ta1/7qlRZXP/KkULnLNVkYJ8jZmPbcVF4J3nGVhhqrEWQJCz5zZH?=
 =?us-ascii?Q?5gIFPiaEkKDJf919wSP8Gb1I5WFveVhvB6zxyUPupyWgIp1Aj2vkTLtqc/rZ?=
 =?us-ascii?Q?nGEF7tgYvyvkcd5RBgfZFX4jzE89aqw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1d4ff4-7787-4be7-e035-08dec0177073
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 19:53:23.8195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKLQ4JmtjtrWLsCZOnegzyv5jFA4FYfeBzxpiLWqmDxzdPOKFB44WYf3zC5uRYR041mHt/FQKMgii4e7fs6Q+8oVQiynUaemwjmZVMs9Z+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
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

