Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AD3C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 14:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79169880BB;
	Wed, 27 Mar 2024 15:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QbRA0cQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4020C880EB; Wed, 27 Mar 2024 15:15:22 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94189880B9
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 15:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQ8OYnmgGDQe0xA1ABKJkCDecn1tndKrr0pXiuMccghx6lIe9c288NDYQnbI8BN2x96d77jgRyjZHooOtK07q85Gt8DCQFdib/FZANJkDrikZ0mM9NasLF66+6YtCQLFdvK/19bTZ18oPnUFPNxZb0V64XiTnJNPFAU8PxbdWjpv0kISDT+OXklrgfg1ky86OW0PBU/nN6LRsHrOarMFC3nbA0sWIQfb+XXOKjZ7+6PnF/RGX9Zio1KaZC26FmGxrdY5jvQ8CdXfcRpsUP4suUX2xuOUPDk1A4bILEgftuwPkdpuh2mlVmJ9Yx3PaNcSZZDRqLcbLq15az2vPRe6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VABfEmQ1cxu+KiTUn1YHCFAUiiNDZEAGL4Le+gxEgs=;
 b=HaHVUHfa9sxKlBOg/0C+FqqiJUE46fEoOIuLnvbYoFE5guuAG8gYxBBtN50VJ8bT+DCAjK5hEQtE0FMuilfBNzfggkNDVTzLf6Y9eUxgInYkhTnnjjcmjGMhn2rZi5+uyx6Dghuf9/yvEP2NTYDeoE2gTTSGs4d9cy7xhilcN0VfT6NowbdQSju4qHk9OKrKlAjxY7KanRnF6B7f7stGk0h0k8TpvGh+LepCqYL3sDdsDgJ0SrHSZmfrM9XBVZT193KruMN08TeCFGC0F6uW3L0FKVXxdRAU11OCrNDGSMKVDJ7SogRNRJj2nTTLaokamnj0dd6AyEnyeCU4rQ6x/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VABfEmQ1cxu+KiTUn1YHCFAUiiNDZEAGL4Le+gxEgs=;
 b=QbRA0cQCRMCSRWW4Jq6NSET93TqlCzkVXCKdQ4gQkmE+xxozmvYlfgzAgrL9bnKaGkxS4C9MEJH2NEnQyhnnA1wCES2S/x0ApY6qxv48v9AkOPPPcAh8LZ9fkvH5j0AwB3JophUSqJSDyCYJ5pn7SWJi9SmGWojrlXkpnCdU/RY=
Received: from BL1P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::22)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 14:15:14 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::89) by BL1P221CA0006.outlook.office365.com
 (2603:10b6:208:2c5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 14:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 14:15:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 09:15:12 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] zlib: Remove incorrect ZLIB_VERSION
Date: Wed, 27 Mar 2024 15:14:53 +0100
Message-ID: <5fd7c5b4c0b7d15e42cc9fbc69666853ee27eb0a.1711548887.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711548887.git.michal.simek@amd.com>
References: <cover.1711548887.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8155; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=7OMIRWctZ6NvYHiquJvE2zUxV7g8Si3Z4GlZk66pNeA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjQWzQd7+wqZT1o1S+UGp044/DGq1UD9soarlqLmAX3ND
 +6mL553xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIlcD2aYzbq2ddG0Jae/3p01
 rS/z6bQ09gvmKxnmO4vVqLzOWXP6xNdNyvulpt6yKPBxAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ac447f-bc27-4c32-8661-08dc4e6851d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8q6PMBf5XMJwnEdlsXBmQO25TIfWBWCpG+eznz+ZtpSl3iXmZ8iCZVb/sA0sq9YL6T/RAATuVVRX1CwOFZdFPvNoddpvGJ3HDWYpG+Yn0PobhlBep3izRt35pdtzZugX5kxJKI9bOlkI87nOS0UDKw0Bo0Y7OzoWB2XgFmLCxUv0miLYjh06axF5BiGO2vgT0VP0TvCDGpXggJlQnj9nxShxkrlTfslA6pmv5wHj9CnsM2Zv9nE0tkCPTIDsIJzKnOrX/qyFtReDxWNY+T04eHb1FqmVSAzJj81SYP2QopJw1tkW4TX5Bqy2vRD7eOFfjqWG2noSg7Fx0DDFDeQf9t+XqTx8G7TcRLSoC0hIeGRL8ocCB0gapCCkAcux491WAuYULt3YxDGwLJP+Mb415RZ2nfXn4sNBvM+LcN8xA7yAdUneTu7GG+sZhoDNwxeHGeVVjJbksw/ioQ40+VBVjxKv16V5uFjeeeOwN5WNLuG0Yr2eHMy3cW7jUglMpGRqK3fMc2/ZmWu4k1M3EacocY4SPvj+DeI1yhiAckKSDz6V4OIib/vaNrqsbDckDFHFYZ1HcHzCSEoN3hMq9KbKWorNARA2Xk7qUhLivZIm302WbOL4MH+CNJU02ohriH126VhnZnyIpA0sOKmWP/X3SMHPLRB4weiPZ+1+QP5o1wGceW8dV/qL2+DZeNJ137xDGfGXm4R5AhVGU//UzUt1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 14:15:13.5746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ac447f-bc27-4c32-8661-08dc4e6851d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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

Get rid of zlib version which is not correct because of U-Boot related
changes and various CVE backports.

The change in inspired by Linux kernel commit 4f3865fb57a0 ("[PATCH]
zlib_inflate: Upgrade library code to a recent version") which described
ZLIB_VERSION removal as

"This patch also removes ZLIB_VERSION as it no longer has a correct value.
We don't need version checks anyway as the kernel's module handling will
take care of that for us.  This removal is also more in keeping with the
zlib author's wishes (http://www.zlib.net/zlib_faq.html#faq24) and I've
added something to the zlib.h header to note its a modified version."

Author describes wish to follow this guidance at
https://www.zlib.net/zlib_faq.html#faq24:
"The license says that altered source versions must be "plainly marked". So
what exactly do I need to do to meet that requirement?

You need to change the ZLIB_VERSION and ZLIB_VERNUM #defines in zlib.h. In
particular, the final version number needs to be changed to f, and an
identification string should be appended to ZLIB_VERSION. Version numbers
x.x.x.f are reserved for modifications to zlib by others than the zlib
maintainers. For example, if the version of the base zlib you are altering
is 1.2.3.4, then in zlib.h you should change ZLIB_VERNUM to 0x123f, and
ZLIB_VERSION to something like 1.2.3.f-zachary-mods-v3. You can also update
the version strings in deflate.c and inftrees.c."

But U-Boot is not exact version that's why following the same style which
has been used by Linux kernel where ZLIB_VERSION is completely removed.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

---
 include/u-boot/zlib.h | 16 ++++++----------
 lib/gzip.c            |  2 +-
 lib/zlib/deflate.c    | 13 +++----------
 lib/zlib/inflate.c    |  9 +++------
 lib/zlib/zutil.c      |  1 -
 5 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/include/u-boot/zlib.h b/include/u-boot/zlib.h
index a33cc8780d33..ee19f4609588 100644
--- a/include/u-boot/zlib.h
+++ b/include/u-boot/zlib.h
@@ -49,9 +49,6 @@
 extern "C" {
 #endif
 
-#define ZLIB_VERSION "1.2.3"
-#define ZLIB_VERNUM 0x1230
-
 /* #include "zconf.h" */        /* included directly here */
 /* zconf.h -- configuration of the zlib compression library
  * Copyright (C) 1995-2005 Jean-loup Gailly.
@@ -484,7 +481,6 @@ typedef gz_header FAR *gz_headerp;
 #define Z_DATA_ERROR   (-3)
 #define Z_MEM_ERROR    (-4)
 #define Z_BUF_ERROR    (-5)
-#define Z_VERSION_ERROR (-6)
 /* Return codes for the compression/decompression functions. Negative
  * values are errors, positive values are used for special but normal events.
  */
@@ -523,11 +519,11 @@ typedef gz_header FAR *gz_headerp;
 
 ZEXTERN int ZEXPORT deflate OF((z_streamp strm, int flush));
 ZEXTERN int ZEXPORT deflateInit_ OF((z_streamp strm, int level,
-			const char *version, int stream_size));
+			int stream_size));
 ZEXTERN int ZEXPORT deflateEnd OF((z_streamp strm));
 ZEXTERN int ZEXPORT deflateInit2_ OF((z_streamp strm, int  level, int  method,
 			int windowBits, int memLevel,
-			int strategy, const char *version,
+			int strategy,
 			int stream_size));
 ZEXTERN int ZEXPORT deflateReset OF((z_streamp strm));
 ZEXTERN int ZEXPORT deflateSetDictionary OF((z_streamp strm,
@@ -553,7 +549,7 @@ ZEXTERN int ZEXPORT deflateCopy OF((z_streamp dest,
 
 
 ZEXTERN int ZEXPORT inflateInit_ OF((z_streamp strm,
-			const char *version, int stream_size));
+			int stream_size));
 ZEXTERN int ZEXPORT inflate OF((z_streamp strm, int flush));
 /*
     inflate decompresses as much data as possible, and stops when the input
@@ -743,11 +739,11 @@ ZEXTERN int ZEXPORT uncompress2 OF((Bytef *dest, uLongf *destLen,
 */
 
 ZEXTERN int ZEXPORT inflateInit2_ OF((z_streamp strm, int  windowBits,
-                                      const char *version, int stream_size));
+                                      int stream_size));
 #define inflateInit(strm) \
-	inflateInit_((strm), ZLIB_VERSION, sizeof(z_stream))
+	inflateInit_((strm), sizeof(z_stream))
 #define inflateInit2(strm, windowBits) \
-	inflateInit2_((strm), (windowBits), ZLIB_VERSION, sizeof(z_stream))
+	inflateInit2_((strm), (windowBits), sizeof(z_stream))
 
 #if !defined(ZUTIL_H) && !defined(NO_DUMMY_DECL)
 	struct internal_state {int dummy;}; /* hack for buggy compilers */
diff --git a/lib/gzip.c b/lib/gzip.c
index 5d9c19598d5e..a9a3df524de1 100644
--- a/lib/gzip.c
+++ b/lib/gzip.c
@@ -67,7 +67,7 @@ int zzip(void *dst, unsigned long *lenp, unsigned char *src,
 
 	r = deflateInit2_(&s, Z_BEST_SPEED, Z_DEFLATED,	window,
 			DEF_MEM_LEVEL, Z_DEFAULT_STRATEGY,
-			ZLIB_VERSION, sizeof(z_stream));
+			sizeof(z_stream));
 	if (r != Z_OK) {
 		printf ("Error: deflateInit2_() returned %d\n", r);
 		return -1;
diff --git a/lib/zlib/deflate.c b/lib/zlib/deflate.c
index 4549f4dc12a0..7e1ed4f9b20a 100644
--- a/lib/zlib/deflate.c
+++ b/lib/zlib/deflate.c
@@ -196,37 +196,30 @@ struct static_tree_desc_s {int dummy;}; /* for buggy compilers */
     zmemzero((Bytef *)s->head, (unsigned)(s->hash_size-1)*sizeof(*s->head));
 
 /* ========================================================================= */
-int ZEXPORT deflateInit_(strm, level, version, stream_size)
+int ZEXPORT deflateInit_(strm, level, stream_size)
     z_streamp strm;
     int level;
-    const char *version;
     int stream_size;
 {
     return deflateInit2_(strm, level, Z_DEFLATED, MAX_WBITS, DEF_MEM_LEVEL,
-                         Z_DEFAULT_STRATEGY, version, stream_size);
+                         Z_DEFAULT_STRATEGY, stream_size);
     /* To do: ignore strm->next_in if we use it as window */
 }
 
 /* ========================================================================= */
 int ZEXPORT deflateInit2_(strm, level, method, windowBits, memLevel, strategy,
-                  version, stream_size)
+                  stream_size)
     z_streamp strm;
     int  level;
     int  method;
     int  windowBits;
     int  memLevel;
     int  strategy;
-    const char *version;
     int stream_size;
 {
     deflate_state *s;
     int wrap = 1;
-    static const char my_version[] = ZLIB_VERSION;
 
-    if (version == Z_NULL || version[0] != my_version[0] ||
-        stream_size != sizeof(z_stream)) {
-        return Z_VERSION_ERROR;
-    }
     if (strm == Z_NULL) return Z_STREAM_ERROR;
 
     strm->msg = Z_NULL;
diff --git a/lib/zlib/inflate.c b/lib/zlib/inflate.c
index 79c9e991aa33..f7e81fc8b2a0 100644
--- a/lib/zlib/inflate.c
+++ b/lib/zlib/inflate.c
@@ -30,14 +30,11 @@ int ZEXPORT inflateReset(z_streamp strm)
     return Z_OK;
 }
 
-int ZEXPORT inflateInit2_(z_streamp strm, int windowBits, const char *version,
+int ZEXPORT inflateInit2_(z_streamp strm, int windowBits,
 			  int stream_size)
 {
     struct inflate_state FAR *state;
 
-    if (version == Z_NULL || version[0] != ZLIB_VERSION[0] ||
-        stream_size != (int)(sizeof(z_stream)))
-        return Z_VERSION_ERROR;
     if (strm == Z_NULL) return Z_STREAM_ERROR;
     strm->msg = Z_NULL;                 /* in case we return an error */
     if (strm->zalloc == (alloc_func)0) {
@@ -70,9 +67,9 @@ int ZEXPORT inflateInit2_(z_streamp strm, int windowBits, const char *version,
     return inflateReset(strm);
 }
 
-int ZEXPORT inflateInit_(z_streamp strm, const char *version, int stream_size)
+int ZEXPORT inflateInit_(z_streamp strm, int stream_size)
 {
-    return inflateInit2_(strm, DEF_WBITS, version, stream_size);
+    return inflateInit2_(strm, DEF_WBITS, stream_size);
 }
 
 local void fixedtables(struct inflate_state FAR *state)
diff --git a/lib/zlib/zutil.c b/lib/zlib/zutil.c
index 609aac55ce11..ec21b458fcce 100644
--- a/lib/zlib/zutil.c
+++ b/lib/zlib/zutil.c
@@ -21,7 +21,6 @@ const char * const z_errmsg[10] = {
 "data error",          /* Z_DATA_ERROR    (-3) */
 "insufficient memory", /* Z_MEM_ERROR     (-4) */
 "buffer error",        /* Z_BUF_ERROR     (-5) */
-"incompatible version",/* Z_VERSION_ERROR (-6) */
 ""};
 
 #ifdef DEBUG
-- 
2.44.0

