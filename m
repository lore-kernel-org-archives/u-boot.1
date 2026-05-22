Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60D1CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 21:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0081E84901;
	Fri, 22 May 2026 23:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="eU4MYO3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69971848C6; Fri, 22 May 2026 23:28:09 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69428846DF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 23:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/9wh+gUcAZkSOE8nroXq6tvAUAB6tpvhLLSC/YBPXz2M5WJzEXKxLCdC4dtsZOCo/8keTQMpTKrELXJXxvjZOw6Zs31ueXbDmj88SsiVv2AVyI9q9RVkU3vjZVEp7iYZeQz+sOQs2ccRVSbShutByMtDAgoDsdrI8N7U0pzVspJHVOLbOR2qcyKlBxG/4KHvnFvkBwbcIi0Ieg30OfpagzFZDc1G4cNoGMfRqi8/3oyNhqMdnQyIvEKuzLrMietrNbf7mITbbQP17DBdu0XR30MxxsXYgr4yhKYBz0aMcNgA9xImB8JZwL3F7cRmuwl+r0d0WV85W2hqUT8100BjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj0D8DtQxMh1RU7htnT5lR5e2IrQJ7wmChT9GCwg7Zw=;
 b=nh/xWJPjPjfRrAiFedEwWAi2taxCQ60kbzLBRhG4VGrLxj2knJfE3ionKn0mkZ/6/FrK0QstjScGIS78L6wGAqkQdipNobSKD/ucirQXyEoUMaNXgZ4/XUxb3vJdm7ePL91ohS+r8Bp2tPx/PqDCDNaUDC16GNJoX1d8ph50uj49kTTNlLNym1uo/j4/hah1Pp039ho68HxyRECXMLFC4RJwqrZ6WaM5Olx4j2CFKXACYW5nkr7IkNpss2Z8YCqHvz+Bib7jFndF7eWeZwgYFrimug3UFimWLCwcj1YLXyrYsjSDgfC5JN0IWnd72SaRJCYAMDJ0JKtb/sBaT+rgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj0D8DtQxMh1RU7htnT5lR5e2IrQJ7wmChT9GCwg7Zw=;
 b=eU4MYO3HR26RPRpSVGVcEKeMNwniiGk/4e64jBuEo8ZQhCwdkguomrO8QC/tmL/sq7ZX8mYrKzxReuVlfKMm2FYKhIe5k7rseNqyKNGTND3p1EqF3LI0o2cpf/YFyE1FRCotewnsVfL9DwyPM5WxbYDREVONI1xYwINBo2OHL4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 21:28:05 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 21:28:05 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [RFC PATCH 4/9] linker_lists.h: add ll_*_name() helper macros
Date: Fri, 22 May 2026 23:27:51 +0200
Message-ID: <20260522212756.3169222-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522212756.3169222-1-ravi@prevas.dk>
References: <20260522212756.3169222-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR04CA0104.eurprd04.prod.outlook.com
 (2603:10a6:20b:50e::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f3ad0e-1dfb-441b-5886-08deb84902e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|11063799006|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: GtYuzaK6BPaAgeDEthjGZaTSOKL7tme2TXVHhZAXwDkAgyj6dOq6uBSPE8uFdD/1n1U14XwsvPelVbGK5tTi0ZO6mD0xyOxaJ8/qFPVG805dpkNETwnih5dcLMBl3MzPyjAQKkDR3e9eS+E87ylkbkR9spdGsgkkSRvAu+TILcylo7OSgePmwxvDPvUTS9gDlHvoTlOdtaRpSufrynTLPYqWAS6Xrkvy89FhLVvBhliK2rKHIYV9RSVdT5A75weB3qi5YuewvR5JdE4FCm2/gM6KjSOyKQ3GAa300wZShElD+QqHAYgvCkW0Acsd27cOjHM6u3MKZdRGSK7+hhOmI4INEVjb30y2ingQe4tMaTm2jW8kZ3/fTJJVK5sGo5sSRUa4Depi/7S0BlurnUh0P61g7/SuOCjIa8+gx1x4pGN3GdAM6HkEzaRmrd870F1wVog82NSDby1mYVgdFxAB+FVjeKG9IyUVNuCZQs3LQ44GKlq96340IBtDEmwftOtybr5liyWGIWDrjS6DayGV8yPzxOWtUjz46mvSGssL5B52yhsRFgmNNHSq723IcoCr+fgE2WsGUTVL4Y4pCPgDl8dVIF/w8tvpKCO5bZZPuuw2o0TfsEuN0kYLnXHZcRcnVsVu3+JP7mNq5keH7pEtvWXvyJVIExlctmh0QcvW4lCXK4JzpFK82GdxeFYaZ5lMhrmRC8/VRzjEV3N6OB1murqbLhVBG1L2SyNt+iI6yP7HBl9LK1aKoGkZo8UHUABW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(11063799006)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/keB8t0skanJWg9KyUZ+UnM6w2IK7TanWKyNYw+oPUVnD1b+YCCAwplOhVjX?=
 =?us-ascii?Q?uk4iupWAQ0BfQ/X0uUVVJQanY1Y8CHUP6Xah3ckt++PkOw7qtIS+iAhXHYVR?=
 =?us-ascii?Q?s2dNoWBZClrSn7YRUeYYGmMkxCCeloYDyf5oAdmzNzaSHd8BPoSIq4oX7azs?=
 =?us-ascii?Q?txe1JsG+dmDF/e/xD3BLSABcfB4pJVTst836khAUY/3FwysTyPYUBEreyRsr?=
 =?us-ascii?Q?n3wZer9cTAuSEY1CwPBMiRj2zy8rZrzigX6VY2HYAl/Ctu2YDeWF6RTRld2V?=
 =?us-ascii?Q?e/pL91JMVBzaKN+M9QR56s6pe4Yk93p7k/52bYYN3DNYrM/pCQs221+l+Nso?=
 =?us-ascii?Q?ohF2d3skruzG2Gd+g0DVYtb1jnzvxETqQQC9Q5vz1OErdhroFDmxu+LWPmz1?=
 =?us-ascii?Q?K32SaOgEIRuhKa8lxO0i7uNMQrMP9M2EZKHfR21lwrFVOiKwQ43Y7cbEQ2uw?=
 =?us-ascii?Q?oEJyjqLeSlCiwBnB2yC7s8yHTKyn4lQaJX2ABbgqsNjMOMBu1iRxy2Cojcl2?=
 =?us-ascii?Q?a8gk558fKQYUrTyx/H2QZFnTWPQuN+Jnkoeyk5BCxVbSpCFSIQ/EV+NQcIlu?=
 =?us-ascii?Q?WLGY6pXW3XFbqR3b0Sa7DmlEHKXoW6Fp95DFLjXoo7xwwaF5pnIhrP01ZhpA?=
 =?us-ascii?Q?c/RHCoh7iislw6I6CsnITyMKcFa8vcmn8BpbuQwkwi6Ek36PvISoBB1CRBV0?=
 =?us-ascii?Q?5skG7BsMLl8SEGRhEwxfB28WOkB3rZqLuhdED90TxCjzeBVUPSONvcYSgzzm?=
 =?us-ascii?Q?1A/lheDR4Iiyc4U6GGuuZsfJmtiD6i+3ZLXR1Hbu0ht30ta1iA0bHDXG4qx3?=
 =?us-ascii?Q?VR6TK9RSDxY8p3ePjfQ2Mc9Agy7tRQan56Jww1oL43DciaZpf126xx0oZsGr?=
 =?us-ascii?Q?Mrz24mKrG+q8ZEeU44idRVRx2zgZSp3GoaGo7KzHL3p8RnH8W/omc7tleJsQ?=
 =?us-ascii?Q?e5R1X5AnszGYhxCpVpgPAIRA5IjsjbLl2UizLiP3yDxlx57ZtBgbLZIly5XX?=
 =?us-ascii?Q?CmSZ6lNm9SYDU+Kov5BX6WXKMpW6pAyAtNeVXkXJztjB12I+1Rhn8xQpigdd?=
 =?us-ascii?Q?riOBxzQE/at7NuyyT8RWbSUdC7segswJIdfA0GizQdQSq5ZSCWrrIzrkKuvu?=
 =?us-ascii?Q?QoXsgzkPsLAGsqaleTB0bkDEDnR8MKaPCfRTKpgZcq5e9E5TR5BPKiE6kIFI?=
 =?us-ascii?Q?TeersWLBG1CF1/wW9YrN0+mvQb9AHpNrr9UF48ITYjAsJfn5Lkxe1pa4nJ1R?=
 =?us-ascii?Q?TT6QhCaymAL5KlvkL0DEH5QEC8KCxj7utof/dVhFzvxQziiCGqDvuA5wfQLN?=
 =?us-ascii?Q?e5fFEjCuh3HX6xWJZfpd9/sOnF+XwmIfSAU48k2L5g84iwV0xP90EWszE6Q/?=
 =?us-ascii?Q?4W8nvOXwwKEgnCC2AeR7JXq2fAvWanvkgba7EdDaCaAgIU2IPk8vVejj/1Kw?=
 =?us-ascii?Q?/+OLBf5h94qE9KsGGcEGHXaiBvozjWIVkwm4AU9HehJN0UxsoSyYsfb5MclG?=
 =?us-ascii?Q?ts3iU+EegCgYmFGbUhvubUCFABU8vsvx0pN9GgdF6ZOMvsfy06RZxj0KTCzt?=
 =?us-ascii?Q?zHdP03CkUXCI9VEPENX7mlUvmEUgSArnGJoyL9/3Ffdctk2XkleXOcq+tDIU?=
 =?us-ascii?Q?uhd2eMn51dDdRpL/AFE6ZeWjUiEcLlayWLOv6/r2xf5vRXSBcw8wcC7r1Pz6?=
 =?us-ascii?Q?QdsabMwURApLA6E3w6HuNnTsxFzhycrcGPIgHP/CLWfmZxNf9wuxLhiKA6nL?=
 =?us-ascii?Q?XurclULm9totkxdPP4zasLrmxkhc0ww=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f3ad0e-1dfb-441b-5886-08deb84902e4
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 21:28:05.5564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEWDjShGww0BCqG4uKeTBADgvS1cgsqTzgEA+n+aR0xdDD6ub516eHGskXEAMkZHgrUw0D1X1ZupS3INcKo+dRjbrm8FRo/KAv8iTBaBGpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5385
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

Instead of open-coding the same section and symbol naming scheme over
and over, add helper macros that take the list name (and, for entries,
the name of the entry/entries) and construct a suitable string
literal.

This will be particularly important when the followup patches add even
more uses of those names.

No functional change.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/linker_lists.h | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index a8b7e2c9f2b..b6437ad6462 100644
--- a/include/linker_lists.h
+++ b/include/linker_lists.h
@@ -19,6 +19,12 @@
 
 #if !defined(__ASSEMBLY__)
 
+#define ll_start_section_name(_list)        "__u_boot_list_2_"#_list"_1"
+#define ll_entry_section_name(_list, _name) "__u_boot_list_2_"#_list"_2_"#_name
+#define ll_end_section_name(_list)          "__u_boot_list_2_"#_list"_3"
+
+#define ll_entry_symbol_name(_list, _name) _u_boot_list_2_##_list##_2_##_name
+
 /**
  * llsym() - Access a linker-generated array entry
  * @_type:	Data type of the entry
@@ -27,7 +33,7 @@
  *		in a C variable name!
  */
 #define llsym(_type, _name, _list) \
-		((_type *)&_u_boot_list_2_##_list##_2_##_name)
+		((_type *)&ll_entry_symbol_name(_list, _name))
 
 /**
  * ll_entry_declare() - Declare linker-generated array entry
@@ -68,8 +74,8 @@
  *   };
  */
 #define ll_entry_declare(_type, _name, _list)				\
-	_type _u_boot_list_2_##_list##_2_##_name __aligned(4)		\
-			__section("__u_boot_list_2_"#_list"_2_"#_name)
+	_type ll_entry_symbol_name(_list, _name) __aligned(4)		\
+			__section(ll_entry_section_name(_list, _name))
 
 /**
  * ll_entry_declare_list() - Declare a list of link-generated array entries
@@ -90,8 +96,8 @@
  *   };
  */
 #define ll_entry_declare_list(_type, _name, _list)			\
-	_type _u_boot_list_2_##_list##_2_##_name[] __aligned(4)		\
-			__section("__u_boot_list_2_"#_list"_2_"#_name)
+	_type ll_entry_symbol_name(_list, _name)[] __aligned(4)		\
+			__section(ll_entry_section_name(_list, _name))
 
 /*
  * We need a 0-byte-size type for iterator symbols, and the compiler
@@ -123,7 +129,7 @@
 #define ll_entry_start(_type, _list)					\
 ({									\
 	static char start[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
-		__section("__u_boot_list_2_"#_list"_1");			\
+		__section(ll_start_section_name(_list));		\
 	_type * tmp = (_type *)&start;					\
 	asm("":"+r"(tmp));						\
 	tmp;								\
@@ -165,7 +171,7 @@
 #define ll_entry_end(_type, _list)					\
 ({									\
 	static char end[0] __aligned(1)					\
-		__section("__u_boot_list_2_"#_list"_3");			\
+		__section(ll_end_section_name(_list));			\
 	_type * tmp = (_type *)&end;					\
 	asm("":"+r"(tmp));						\
 	tmp;								\
@@ -248,7 +254,7 @@
  */
 #define ll_start_decl(_sym, _type, _list)					\
 	static _type _sym[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
-		__section("__u_boot_list_2_" #_list "_1")
+		__section(ll_start_section_name(_list))
 
 /*
  * ll_end_decl uses __aligned(1) to avoid padding before the end marker.
@@ -256,7 +262,7 @@
  */
 #define ll_end_decl(_sym, _type, _list)					\
 	static _type _sym[0] __aligned(1)				\
-		__section("__u_boot_list_2_" #_list "_3")
+		__section(ll_end_section_name(_list))
 
 /**
  * ll_entry_get() - Retrieve entry from linker-generated array by name
@@ -281,10 +287,10 @@
  */
 #define ll_entry_get(_type, _name, _list)				\
 	({								\
-		extern _type _u_boot_list_2_##_list##_2_##_name		\
+		extern _type ll_entry_symbol_name(_list, _name)		\
 			__aligned(4);					\
 		_type *_ll_result =					\
-			&_u_boot_list_2_##_list##_2_##_name;		\
+			&ll_entry_symbol_name(_list, _name);		\
 		_ll_result;						\
 	})
 
@@ -302,7 +308,7 @@
  * @_list: name of the list
  */
 #define ll_entry_ref(_type, _name, _list)				\
-	((_type *)&_u_boot_list_2_##_list##_2_##_name)
+	((_type *)&ll_entry_symbol_name(_list, _name))
 
 #endif /* __ASSEMBLY__ */
 
-- 
2.54.0

