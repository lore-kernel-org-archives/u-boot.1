Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E593CD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 21:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63D54848E2;
	Fri, 22 May 2026 23:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="GoMKTAor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E522A846DE; Fri, 22 May 2026 23:28:13 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD35D848F5
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 23:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVFFFo8q/JFbkDAhl7/CxmEOWqkzTPm++6wW/xR75Sy/MuDmPI4918LKWxniLrsGwVRFxuHTiDLqxaLOoBIw5kZ+8NApc+Tm2xgKremdE+jf/b746XX0gpY87NLbnTqK8i0qxxhjgqMGaHRUODaCq6et4NteFPCscie64EK0XZXR6yi7zVhxvWHmKhsrL5TnHiQkdGpX7R+JFqoimGQeHKPAQLyM0xuWndJZKkp29bC+O9m2RoDKvwXt68/En/o6JaVIiU+f+wEQdlpj6agmqD6AwM2Unlzrd/+b7M9Gfb8trEqwwhI8e5+AJeMxtN+cLw5Fu/x2gqknDHQx0gAqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7XHT8ima7VufSNxTGij1c1LDeLlBHd/ieOsQyhMS/U=;
 b=ZCJX3YzGM+sFvNlxBG4bsoTGRZ7sT7PlHWwRn4zEIdUsNGHNL8WYr82vFFh4UDfbxb9ITu4EcCatuoNMRtpT0m6QL8xeNNcggu/b+LWAhc/hjMKFZTMyqcKyIFMsv/5rkq5pSw8T5EQZikNLmHsg5SqhIVcjVLi+yzFGtKily7gOrSEfmFL9i6xuJMghZ2WktZu51lUQGWN4rympJXTtpRM4itZJpmVfa23r+393vO4Cxjayu6HyhGtRScgcOPX4n6Sov7fY95FRa6DS7fb3+KBmO88N5+2fLwU9Mi9V82Muplp0Xsa/Mp4BWjiKotrghyhtK3OllUttP/lwZnWrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7XHT8ima7VufSNxTGij1c1LDeLlBHd/ieOsQyhMS/U=;
 b=GoMKTAorQ0jtnvz6nAentP156pn6qiz45GL57ZOYu7bXrWG28oRcqvD69EePnKyDXKbxcMKRSBT0QXt0QSCH/VVuy0UyslXnjix37rSA/jsc4fYhRxoqosayasLxmkyfmedeGZZ3eYbuS2KzE5CLr8NJNaCmDLFgvnpPS94gyVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 21:28:09 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 21:28:09 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [RFC PATCH 8/9] linker_lists.h: emit lots of meta-data for debugging
 and sanity checking
Date: Fri, 22 May 2026 23:27:55 +0200
Message-ID: <20260522212756.3169222-9-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522212756.3169222-1-ravi@prevas.dk>
References: <20260522212756.3169222-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR04CA0098.eurprd04.prod.outlook.com
 (2603:10a6:20b:50e::29) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: b68b50f1-3e11-4f58-e157-08deb8490558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|5023799004|6133799003|3023799007|11063799006|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: XV6PXh9pSrzDu/VYAW1Gp2Vz3HJo+kBErvY9aHvCv3fGw090ExSo6yZi3/nU3r6XCjQIm1x7KAU7i9FyatekJWQJ+LoFmFI2mZQG9imq4FZMibqhT8lPZHpM9Ylqb/VO5S2D1EoB9tWiBs1Routlh0CrFrQcP+5yE+L7s4x55hnXLa5tOrBqzL2ZqyQbMHKa8XTK+5XVE31/0FSQZhTS6SayThaUa82YXCq0bzbwsiH4FU+ex8zlrMpCOK2Mr99vVwyW6Pw9rLdYVancnyDIG5edH4idIS908PVggFXOSjYe15NMQIR8Bf6CxGBp1mBYf460GWCdAUGd4c/uNkQUAsZkQj/yVNv1tXEAAZli5vzXfQuvfaX3USkK2eRPn9ooIGsEl2BBD3XnmxAur9gykTgrxm2ZBVPyrSLc/KOL1jYpN39pmx2ZXuOxsDeV7/Hpxm4Gv4xsIQmsWKfdYIT6tBn5h/8nnv9pPLH2S5S/YkyfMN+HM9H//yzUo//z0/VJLjJuct2l6f4ZE4b8JcoQfTqseMqjmuob1B9DHH/yxAKoK7sqTD+K65CtZI+oHiYG2CncxUeaLNyUg1UozAkkrlYB7FXTt+aws8mYar2lTGwfiIRpWe30AO8wdKpDS7JqCYd1cSgGm377sd35fVEZAM30/mNDeKt45WfbKSOXI2HjJhXqujuorvKo1uIaxZfSksAnIjBPLAMhGGvZTZGKF3qJKvVgshSRQpAg+TK/wGHl9XyYgIx3LHTBVwp9b1rH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(5023799004)(6133799003)(3023799007)(11063799006)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CL+4zTqcL0TyZF0OpNF8l7/uer9DfsH7ctS+ou/CoR1ZLPr7YLRW/8QQMZdI?=
 =?us-ascii?Q?LvdaFdD78RrztoVoccOmWfkxjPNGd0kBeARX5W8Rj7y6kvv6zEaW2/eaLi5J?=
 =?us-ascii?Q?gPpPSxsxRoR8VMrpjuW2Hnycy7WanTWMWDyjBMz/U5/NvD0Cau0f5MgK8Gpy?=
 =?us-ascii?Q?AfHCgl/SEYqk+Sr8QU5eWr+/c4niSc2zTuubJpFMF5To/QQbWbgRWMPxDavF?=
 =?us-ascii?Q?wqp7s9lOxcRyHSE9++twcTOzfprU+GZiBR8Gv3QdpQJ1E8e+aHvqbOu/lPM2?=
 =?us-ascii?Q?P47NpvnNLJpos51Wjyv7xvCDfVxcFJSCe6mjFQp022xTuoJTk2yN/Qu4vuoL?=
 =?us-ascii?Q?vDk6VX8ZIlEsX//GlulEbNkLdDkk9YoXh8WpCtTGROYZNo2v41suDUQBh52b?=
 =?us-ascii?Q?nSD+xiaAXlllM7Oqij5MxfH0fMH+XyJj64Lk+uuGZ+dbSBHHWarI/B6TX1fo?=
 =?us-ascii?Q?/FfvM7GZrAO8KN2Fpu2J67DSDX8ztC4z4TQwYukQ92i8ryM3h5qPAnr5C/Av?=
 =?us-ascii?Q?leEAWlcrMow9kGDq2YCTKpC5+E9Rdoa9B7mk3GFbliy3aD5VapMk+2S0bvTH?=
 =?us-ascii?Q?OedIuoMMgaGfVsxGGGjgSazD5S2XbHRfYsKc5+tyqBkcpreVX5GnfK88y9EU?=
 =?us-ascii?Q?Y8Rnm+NRG34koFOrWsfKSVOmbM6i0hhts/ZUI+A9n/1DiCNGfuzFLmUXPI6i?=
 =?us-ascii?Q?a6RvKG/HWMh2pCFA2iy2VwnJGaL1W74xR5KWUkDy5XZvZYa002WYJsmcihwd?=
 =?us-ascii?Q?qU0+iuZIoKRuoUrIbKR+EVX8luhxjPY2UxfJGeE/X43Eledotr0N8Y2MpB83?=
 =?us-ascii?Q?MZBPGmsN4prJloC10wJz6I61VFo3DR4/Zc7f8T+R4ot+Y6bmAo2gGfmP3qfu?=
 =?us-ascii?Q?D8J4bHf1ZoLiIeVt96XIudcmFtnZh0j+m8Fg8sXgY+u/V1kYEo5C3/ePWRqr?=
 =?us-ascii?Q?Y9YmVmvfo/rODg3ZuxXOfsmwE0k2mmLpB4o9sYTsGR+od4sjY1bXTerTphRc?=
 =?us-ascii?Q?c3zIsKAxzaf7TC1hVtPMJe/c3JbMQd7MLzleGKfjVzrnhIDLei775r75NEuj?=
 =?us-ascii?Q?k4LIjvyw6Al2o1m7AeA9Rxt4a2T5W9KGSnPWcO5gVhELNcN+ePeDIyrE8dE5?=
 =?us-ascii?Q?nlS69vKraMpPh33mDW/67bs6Empb7kfrO92Fih9BvR5opIV+Ye7Xyp8eSU+5?=
 =?us-ascii?Q?W8tD3B2eDAtB3Wlv6tEsNR1N60PeNCxC5vimzya/MvPEyF91ljDGI1iSfGoK?=
 =?us-ascii?Q?LAMQ43/3fNc1wP1Q0RrwNgT93EfC98K7r9o/WdThfOhj+Ivc5GDg2i/iN4hH?=
 =?us-ascii?Q?WlxhpeZk8/vhXSqoq8x070vqb2laynHOWAgQI6HvDkedTLbOj0sOPr/USZmJ?=
 =?us-ascii?Q?wT85K38OAxfDAPabUJfo3GrC2pxHcBTgI0OaYJuDX7QMwYjUtOsYtJFZUC/C?=
 =?us-ascii?Q?Y0nlvVnwIURWarEd8PqHBzsSr2pTR4+qHOHsNkHgjWvvIVI86LWCUJ1y9tNT?=
 =?us-ascii?Q?n7FKS3SXH09b8JrWj0a8US0OLEVTfmu9aWPOYYRa2JCOS0kn09WUwmR0zwlW?=
 =?us-ascii?Q?g37ROUNgrpphXhqpZ+0U8oz/depKKn2vRuSdAK01SWsnjf/ebePWi0pi+QoX?=
 =?us-ascii?Q?jLDGMh6477mdHdPiaCbGtX28BSxqcDYxUASoeRJ4/ibb9iP5FzwSp46Mw34Z?=
 =?us-ascii?Q?VDFJwzUfaiAutJPHK9dmgbTJdnAqts81w3vX84H6HvoeSZP678lK+O5ZNRUc?=
 =?us-ascii?Q?RjqWKzJcSQOqe7DIiMPo3hhGt07Z8IY=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b68b50f1-3e11-4f58-e157-08deb8490558
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 21:28:09.6349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9POVr5jFYqbOv6sZPZdfbKo+S9Ga4RYoefHMc7rkL3hL38UOODLk6NNq6twUWr9aDw3dgHu/Abl0SohTL+AvJl5JLn852R9vQIl6bQ5qX8=
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

This is an attempt at to make it possible to catch various problems
with linker lists at build time, without affecting the size of the
final binary. Also, I did not want to have to modify all the linker
scripts in order to not get all this meta-data thrown away by garbage
collection.

The basic trick is that one can use the .size assembly directive so
set the st_size of an ELF symbol, without that symbol actually
occupying that amount of space in any section or the final binary. And
all of the .size, .type, .{push,pop}section directives are completely
generic, so this should work for all architecture.

So whenever we declare a start or end symbol for use by C code, also
emit information about the size and alignment of the type that the
list is supposed to be made of.

A relatively straight-forward script (next patch) can then parse the
ELF file and report on any inconsistencies. For example, suppose two
different translation units happen to use the same identifier for
their list names, with different types. I.e. we have

// abc.c
struct abc { int abc; };
...
ll_entry_start(struct abc, letters);

// xyz.c
struct xyz { long x, y, z; };
...
ll_entry_start(struct xyz, letters);

This is currently not caught at build-time, but will definitely not
work well at run-time.

Similarly, if the compiler or linker ends up doing unexpected things
with respect to aligning either the start/end symbols or one of the
items in the list, we do not catch at build-time that there is a
non-integer number of elements between start and end.

I do not yet know how this behaves wrt LTO, nor do I know how
expensive it would be to always run the sanity checker script at
build-time - if it's too time-consuming or not robust enough, it will
have to be behind a CONFIG option. But I do hope that this should
provide a way to give us some confidence in dropping some of the magic
alignment attributes and the whole CONFIG_LINKER_LIST_ALIGN.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/linker_lists.h | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index b94e3a359f3..2475ac3deaf 100644
--- a/include/linker_lists.h
+++ b/include/linker_lists.h
@@ -11,6 +11,7 @@
 #define __LINKER_LISTS_H__
 
 #include <linux/compiler.h>
+#include <linux/stringify.h>
 
 /*
  * There is no use in including this from ASM files.
@@ -23,7 +24,45 @@
 #define ll_entry_section_name(_list, _name) "__u_boot_list_"#_list"_2_"#_name
 #define ll_end_section_name(_list)          "__u_boot_list_"#_list"_3"
 
+#define ll_start_symbol_name(_list)        _u_boot_list_##_list##_1_start
 #define ll_entry_symbol_name(_list, _name) _u_boot_list_##_list##_2_##_name
+#define ll_end_symbol_name(_list)          _u_boot_list_##_list##_3_end
+
+#define ll_info_section_name(_list)         "__u_boot_list_"#_list"_0"
+#define ll_size_symbol_name(_list)          "_u_boot_list_"#_list"_0_item_size"
+#define ll_align_symbol_name(_list)         "_u_boot_list_"#_list"_0_item_align"
+
+#define ll_emit_type_info(_list, _type) \
+	__asm__(						\
+		".pushsection "ll_info_section_name(_list)",\"aw\"\n"	\
+		".type "ll_size_symbol_name(_list)", STT_OBJECT\n"	\
+		".size "ll_size_symbol_name(_list)", %c0\n"		\
+		".type "ll_align_symbol_name(_list)", STT_OBJECT\n"	\
+		".size "ll_align_symbol_name(_list)", %c1\n"		\
+		ll_size_symbol_name(_list)":\n"				\
+		ll_align_symbol_name(_list)":\n"			\
+		".popsection\n"						\
+		: : "i"(sizeof(_type)), "i"(__alignof__(_type)))
+
+#define ll_emit_start_symbol(_list, _type)				\
+	ll_emit_type_info(_list, _type);				\
+	__asm__(							\
+		".pushsection "ll_start_section_name(_list)",\"aw\"\n"	\
+		".type "__stringify(ll_start_symbol_name(_list))", STT_OBJECT\n" \
+		".size "__stringify(ll_start_symbol_name(_list))", 0\n"	\
+		__stringify(ll_start_symbol_name(_list))":\n"		\
+		".popsection\n"						\
+		)
+
+#define ll_emit_end_symbol(_list, _type)				\
+	ll_emit_type_info(_list, _type);				\
+	__asm__(							\
+		".pushsection "ll_end_section_name(_list)",\"aw\"\n"	\
+		".type "__stringify(ll_end_symbol_name(_list))", STT_OBJECT\n" \
+		".size "__stringify(ll_end_symbol_name(_list))", 0\n"	\
+		__stringify(ll_end_symbol_name(_list))":\n"		\
+		".popsection\n"						\
+		)
 
 /**
  * llsym() - Access a linker-generated array entry
@@ -128,6 +167,7 @@
  */
 #define ll_entry_start(_type, _list)					\
 ({									\
+	ll_emit_start_symbol(_list, _type);				\
 	static char start[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
 		__section(ll_start_section_name(_list));		\
 	_type * tmp = (_type *)&start;					\
@@ -170,6 +210,7 @@
  */
 #define ll_entry_end(_type, _list)					\
 ({									\
+	ll_emit_end_symbol(_list, _type);				\
 	static char end[0] __aligned(1)					\
 		__section(ll_end_section_name(_list));			\
 	_type * tmp = (_type *)&end;					\
@@ -253,6 +294,7 @@
  * start of the bob sub-commands. It is then used in my_list[]
  */
 #define ll_start_decl(_sym, _type, _list)					\
+	ll_emit_start_symbol(_list, _type);				\
 	static _type _sym[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
 		__section(ll_start_section_name(_list))
 
@@ -261,6 +303,7 @@
  * See the comment for ll_entry_end() for a full explanation.
  */
 #define ll_end_decl(_sym, _type, _list)					\
+	ll_emit_end_symbol(_list, _type);				\
 	static _type _sym[0] __aligned(1)				\
 		__section(ll_end_section_name(_list))
 
-- 
2.54.0

