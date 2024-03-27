Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD162CD11DD
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 14:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 163A58803A;
	Wed, 27 Mar 2024 15:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yBYjqRpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C5F3879F6; Wed, 27 Mar 2024 15:15:16 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B906880B9
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 15:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2231bG0uSsGnh3Yjtry0P55sHv9FQ4MEEGktX207Ty/DI/lhNReFx4U8qtZnysOiF+1q1sKmmtbZnHPHz8MFdioYioTLeqi0pNVBslEeoFzwR4G1UFImSgdlthRgW1aw5eXlTiUmAQBF1gPhZE73dreyxoPeCeV3x0jiRDtnjPzX+jntnMJs6kKrAiEJ4Fd5IX2zLEPuc8Brm/MPzW+/PTjDvg/ICeNfc0sByZdfkzzMWpECNzBQVzIA/4C0Vdd/9G4/0XmKbzGeu4+s9T0nQkXLF+FRJz21er35zsHuBgYPkX454AD4NNQZ0Q5SR257JhQIYtYFzwsFeJAxE8R/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xyyMfMTcJQgcQtPej4L/1Lf9WvcKWUL9Hvc/P5ZRH4=;
 b=I/q8SZfK5Sq5Zj01kJtvq9gVJEPkDLqd0wxR7MiI5fkVmYV4tim8MXt3HH9r+8xMGYmow6s4MzgyiQpO05W0lwmivXDQUKeJ+4wma79SVcb4kF0aQVtCx08HPo0FFEL/syZr1rhbGQ3eeer/BgFTmwcp6KmSw6aQmTlkBkIiexMLWd8+tYySxK4vo9rlJ3i2Q/TW1Zu0WeUI3iISPwOrEcptmEfcDVfBrFyFvgxZjgC1xY75CkEzVPA02u/MWdQwFP7rNfL67XmbkL2i70LWDJ9gInJkDrHO7lORoXtriVS1YIEvYzNbIWX0kYoDh4kxBi1uQ15Zy7/GIzAVs7hYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xyyMfMTcJQgcQtPej4L/1Lf9WvcKWUL9Hvc/P5ZRH4=;
 b=yBYjqRpCb5GTLYRF9SaFHjmcdQ8peuh0Q3RENY/BMxdSHRnWotFDFiZcqRB8IlAIvV2Aw4ivif+WaVp+iqt/ajtsUACCCj+Ximc6qSuK3JJ8Nl50s7a75X9CYCqPyB5jE8azMB3ixBQSNGZB00ikKtJ2P+/x45cZRTs3W8bha8g=
Received: from BL1P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::18)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 14:15:10 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::2e) by BL1P221CA0028.outlook.office365.com
 (2603:10b6:208:2c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 14:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 14:15:09 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 09:15:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] zlib: Port fix for CVE-2016-9841 to U-Boot
Date: Wed, 27 Mar 2024 15:14:52 +0100
Message-ID: <b456422bcfc6b1e5e23c4784438c4e75c4ed9e00.1711548887.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711548887.git.michal.simek@amd.com>
References: <cover.1711548887.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12224; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=frUFg9rGCqA/FP/ncVrYuVQ1lAnsmdxT41R8TlMkxT4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjQWzfsn+1zSj/je10rdF7FY5G8SQ5+Wm3O0i/72ZbumL
 mU5ki7YEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACZy+yXDPNWlqUeifE/wd89c
 qnHyXs2l+Sv7DzPMr+jbV+6n+uO50/QJZk/TxcLMvryMBgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 9021fcef-6c29-4fbb-b552-08dc4e684f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HrUNIJVxOYAx71a1MdYAvQ+tQdpinhjTUNNV3Pdo5wz9cqCOOHuR3m6LtRs/upYpu26zf7YCF5qySXxSGWqj7Xjr/upiFMK2qaENcEdn6csOJ95KOAwowiwlLj3yi1tqeqPUegV/uqRHy506InFhVff0zP3kaaMDHLafTu0ZPGjoqXf3nOH/EcFUER1llrazqL608YzBE8w5qkDQmYawITB2QqZGUca0CERm1G8s7dQ+8Izn3bEKNoqELcWcgoPHgxfCZeE7tB73nRSJ+EJzD6CHlbwvkCYinDiAd9+fkcnWyhUpg1VEpzmldluvz2ntE225usOtrek6KML23D+xT/TV3ja15EMUdmXb9kehjgoIZCM8CziGQAQfvjxWfFC8tFwmBUDlt14wCGZI5MTlUoMBOglWuSzBlrjKcSwEt53iXG3MdTVj8HL8JvqHSB+FR9m7yKQab3geTwQqmXn8rY15QIBB9qu2L0bKRgpCGPaD334CYUzbf0ty/L1R7Fh9kLq13+kcCMJyStP/VywFsnVilm9qjseRz7JXUTld+/1q8pRzSiVxcdX+wSZb6y6RTdLZmd0zgrJkenLUVaKc6gTe7AnB55GpF1r5qDCv0cRMqFH6hkZIaowzW4sUDcmibWTA3IQy+7/G/WbaNmcgiYdqSlt25jWIm08C4ApYJz1ImenDmhUcJTKvdQ1M+iQMmpJTHNhsvoht9VPPtLPOBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 14:15:09.6371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9021fcef-6c29-4fbb-b552-08dc4e684f7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690
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

The patch corresponds to zlib commit at
https://github.com/madler/zlib/commit/9aaec95e82117c1cb0f9624264c3618fc380cecb
which declares that it is fixing CVE-2016-9841.
Here is c&p description from zlib:
"Use post-increment only in inffast.c.

An old inffast.c optimization turns out to not be optimal anymore
with modern compilers, and furthermore was not compliant with the
C standard, for which decrementing a pointer before its allocated
memory is undefined. Per the recommendation of a security audit of
the zlib code by Trail of Bits and TrustInSoft, in support of the
Mozilla Foundation, this "optimization" was removed, in order to
avoid the possibility of undefined behavior."

Origin patch also updates the code when
INFLATE_ALLOW_INVALID_DISTANCE_TOOFAR_ARRR is present but this code is not
the part of U-Boot hence it is ignored.
Also do not deal with state->sane variable which requires other changes
which are also not the part of zlib.

Commit 92faa8b10918 ("zlib: handle overflow while calculating available
stream input size") is kept in inffast.c too not to break described case.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

The first attempt to fix this is here.
https://patchwork.ozlabs.org/project/uboot/patch/20220911084637.21513-1-jit.loon.lim@intel.com/
---
 lib/zlib/inffast.c | 130 +++++++++++++++------------------------------
 1 file changed, 42 insertions(+), 88 deletions(-)

diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
index bdaa6d0dc51f..5e2a65ad4d27 100644
--- a/lib/zlib/inffast.c
+++ b/lib/zlib/inffast.c
@@ -1,5 +1,5 @@
 /* inffast.c -- fast decoding
- * Copyright (C) 1995-2004 Mark Adler
+ * Copyright (C) 1995-2008, 2010, 2013 Mark Adler
  * For conditions of distribution and use, see copyright notice in zlib.h
  */
 
@@ -12,25 +12,6 @@
 
 #ifndef ASMINF
 
-/* Allow machine dependent optimization for post-increment or pre-increment.
-   Based on testing to date,
-   Pre-increment preferred for:
-   - PowerPC G3 (Adler)
-   - MIPS R5000 (Randers-Pehrson)
-   Post-increment preferred for:
-   - none
-   No measurable difference:
-   - Pentium III (Anderson)
-   - M68060 (Nikl)
- */
-#ifdef POSTINC
-#  define OFF 0
-#  define PUP(a) *(a)++
-#else
-#  define OFF 1
-#  define PUP(a) *++(a)
-#endif
-
 /*
    Decode literal, length, and distance codes and write out the resulting
    literal and match bytes until either not enough input or output is
@@ -66,12 +47,13 @@
       requires strm->avail_out >= 258 for each loop to avoid checking for
       output space.
  */
-void inflate_fast(z_streamp strm, unsigned start)
-/* start: inflate()'s starting value for strm->avail_out */
+void ZLIB_INTERNAL inflate_fast(strm, start)
+z_streamp strm;
+unsigned start;         /* inflate()'s starting value for strm->avail_out */
 {
     struct inflate_state FAR *state;
-    unsigned char FAR *in;      /* local strm->next_in */
-    unsigned char FAR *last;    /* while in < last, enough input available */
+    z_const unsigned char FAR *in;      /* local strm->next_in */
+    z_const unsigned char FAR *last;    /* have enough input while in < last */
     unsigned char FAR *out;     /* local strm->next_out */
     unsigned char FAR *beg;     /* inflate()'s initial strm->next_out */
     unsigned char FAR *end;     /* while out < end, enough space available */
@@ -97,7 +79,7 @@ void inflate_fast(z_streamp strm, unsigned start)
 
     /* copy state to local variables */
     state = (struct inflate_state FAR *)strm->state;
-    in = strm->next_in - OFF;
+    in = strm->next_in;
     last = in + (strm->avail_in - 5);
     if (in > last && strm->avail_in > 5) {
         /*
@@ -107,7 +89,7 @@ void inflate_fast(z_streamp strm, unsigned start)
 	strm->avail_in = 0xffffffff - (uintptr_t)in;
         last = in + (strm->avail_in - 5);
     }
-    out = strm->next_out - OFF;
+    out = strm->next_out;
     beg = out - (start - strm->avail_out);
     end = out + (strm->avail_out - 257);
 #ifdef INFLATE_STRICT
@@ -128,9 +110,9 @@ void inflate_fast(z_streamp strm, unsigned start)
        input data or output space */
     do {
         if (bits < 15) {
-            hold += (unsigned long)(PUP(in)) << bits;
+            hold += (unsigned long)(*in++) << bits;
             bits += 8;
-            hold += (unsigned long)(PUP(in)) << bits;
+            hold += (unsigned long)(*in++) << bits;
             bits += 8;
         }
         here = lcode[hold & lmask];
@@ -143,14 +125,14 @@ void inflate_fast(z_streamp strm, unsigned start)
             Tracevv((stderr, here.val >= 0x20 && here.val < 0x7f ?
                     "inflate:         literal '%c'\n" :
                     "inflate:         literal 0x%02x\n", here.val));
-            PUP(out) = (unsigned char)(here.val);
+            *out++ = (unsigned char)(here.val);
         }
         else if (op & 16) {                     /* length base */
             len = (unsigned)(here.val);
             op &= 15;                           /* number of extra bits */
             if (op) {
                 if (bits < op) {
-                    hold += (unsigned long)(PUP(in)) << bits;
+                    hold += (unsigned long)(*in++) << bits;
                     bits += 8;
                 }
                 len += (unsigned)hold & ((1U << op) - 1);
@@ -159,9 +141,9 @@ void inflate_fast(z_streamp strm, unsigned start)
             }
             Tracevv((stderr, "inflate:         length %u\n", len));
             if (bits < 15) {
-                hold += (unsigned long)(PUP(in)) << bits;
+                hold += (unsigned long)(*in++) << bits;
                 bits += 8;
-                hold += (unsigned long)(PUP(in)) << bits;
+                hold += (unsigned long)(*in++) << bits;
                 bits += 8;
             }
             here = dcode[hold & dmask];
@@ -174,10 +156,10 @@ void inflate_fast(z_streamp strm, unsigned start)
                 dist = (unsigned)(here.val);
                 op &= 15;                       /* number of extra bits */
                 if (bits < op) {
-                    hold += (unsigned long)(PUP(in)) << bits;
+                    hold += (unsigned long)(*in++) << bits;
                     bits += 8;
                     if (bits < op) {
-                        hold += (unsigned long)(PUP(in)) << bits;
+                        hold += (unsigned long)(*in++) << bits;
                         bits += 8;
                     }
                 }
@@ -196,17 +178,18 @@ void inflate_fast(z_streamp strm, unsigned start)
                 if (dist > op) {                /* see if copy from window */
                     op = dist - op;             /* distance back in window */
                     if (op > whave) {
-                        strm->msg = (char *)"invalid distance too far back";
+                        strm->msg =
+                            (char *)"invalid distance too far back";
                         state->mode = BAD;
                         break;
                     }
-                    from = window - OFF;
+                    from = window;
                     if (wnext == 0) {           /* very common case */
                         from += wsize - op;
                         if (op < len) {         /* some from window */
                             len -= op;
                             do {
-                                PUP(out) = PUP(from);
+                                *out++ = *from++;
                             } while (--op);
                             from = out - dist;  /* rest from output */
                         }
@@ -217,14 +200,14 @@ void inflate_fast(z_streamp strm, unsigned start)
                         if (op < len) {         /* some from end of window */
                             len -= op;
                             do {
-                                PUP(out) = PUP(from);
+                                *out++ = *from++;
                             } while (--op);
-                            from = window - OFF;
+                            from = window;
                             if (wnext < len) {  /* some from start of window */
                                 op = wnext;
                                 len -= op;
                                 do {
-                                    PUP(out) = PUP(from);
+                                    *out++ = *from++;
                                 } while (--op);
                                 from = out - dist;      /* rest from output */
                             }
@@ -235,65 +218,36 @@ void inflate_fast(z_streamp strm, unsigned start)
                         if (op < len) {         /* some from window */
                             len -= op;
                             do {
-                                PUP(out) = PUP(from);
+                                *out++ = *from++;
                             } while (--op);
                             from = out - dist;  /* rest from output */
                         }
                     }
                     while (len > 2) {
-                        PUP(out) = PUP(from);
-                        PUP(out) = PUP(from);
-                        PUP(out) = PUP(from);
+                        *out++ = *from++;
+                        *out++ = *from++;
+                        *out++ = *from++;
                         len -= 3;
                     }
                     if (len) {
-                        PUP(out) = PUP(from);
+                        *out++ = *from++;
                         if (len > 1)
-                            PUP(out) = PUP(from);
+                            *out++ = *from++;
                     }
                 }
                 else {
-		    unsigned short *sout;
-		    unsigned long loops;
-
                     from = out - dist;          /* copy direct from output */
-                    /* minimum length is three */
-		    /* Align out addr */
-		    if (!((long)(out - 1 + OFF) & 1)) {
-			PUP(out) = PUP(from);
-			len--;
-		    }
-		    sout = (unsigned short *)(out - OFF);
-		    if (dist > 2 ) {
-			unsigned short *sfrom;
-
-			sfrom = (unsigned short *)(from - OFF);
-			loops = len >> 1;
-			do
-			    PUP(sout) = get_unaligned(++sfrom);
-			while (--loops);
-			out = (unsigned char *)sout + OFF;
-			from = (unsigned char *)sfrom + OFF;
-		    } else { /* dist == 1 or dist == 2 */
-			unsigned short pat16;
-
-			pat16 = *(sout-2+2*OFF);
-			if (dist == 1)
-#if defined(__BIG_ENDIAN)
-			    pat16 = (pat16 & 0xff) | ((pat16 & 0xff ) << 8);
-#elif defined(__LITTLE_ENDIAN)
-			    pat16 = (pat16 & 0xff00) | ((pat16 & 0xff00 ) >> 8);
-#else
-#error __BIG_ENDIAN nor __LITTLE_ENDIAN is defined
-#endif
-			loops = len >> 1;
-			do
-			    PUP(sout) = pat16;
-			while (--loops);
-			out = (unsigned char *)sout + OFF;
-		    }
-		    if (len & 1)
-			PUP(out) = PUP(from);
+                    do {                        /* minimum length is three */
+                        *out++ = *from++;
+                        *out++ = *from++;
+                        *out++ = *from++;
+                        len -= 3;
+                    } while (len > 2);
+                    if (len) {
+                        *out++ = *from++;
+                        if (len > 1)
+                            *out++ = *from++;
+                    }
                 }
             }
             else if ((op & 64) == 0) {          /* 2nd level distance code */
@@ -329,8 +283,8 @@ void inflate_fast(z_streamp strm, unsigned start)
     hold &= (1U << bits) - 1;
 
     /* update state and return */
-    strm->next_in = in + OFF;
-    strm->next_out = out + OFF;
+    strm->next_in = in;
+    strm->next_out = out;
     strm->avail_in = (unsigned)(in < last ? 5 + (last - in) : 5 - (in - last));
     strm->avail_out = (unsigned)(out < end ?
                                  257 + (end - out) : 257 - (out - end));
-- 
2.44.0

