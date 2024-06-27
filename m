Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CEFC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 15:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 584F587FCD;
	Thu, 27 Jun 2024 17:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vk6ndaFZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55246880A5; Thu, 27 Jun 2024 17:49:16 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBCA487D1A
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 17:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-700d1f442e1so1128184a34.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719503352; x=1720108152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vSbsMjufq5j3PRA65VblQAbj/KNrHZbfLao9dInYNm8=;
 b=Vk6ndaFZPEijiW71KMduQYXDHkdzkHdriTfkj13kAzxvLrB46hc8QmxDVaqQ+lINcY
 0ds1TJ4jTPEQ4INRVS+xtvjIdpWXK28qvTXFRYv/6zmhiwOdXFXH8TldD94vmQXtk0Mh
 xs2FcxbkO+AzSQCkaTSJAp1kL/mmNspF8WCbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719503352; x=1720108152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vSbsMjufq5j3PRA65VblQAbj/KNrHZbfLao9dInYNm8=;
 b=TlejjoOA6he4kmi3lsQOSOTvTPhDNoBC7lIZ0J6l1MoG0I3+zSW7nsqCB272yo6TNi
 ZnDEWgB3Ese2MFSIXUI3WfDwH1eMDLiIICJM6Id+ZhEXnWuFrzJSPTk/ZbDwfvlYaqCG
 uoWSqeXiiNJzXNiynRykapunFxYNzPbskP3Qh1gClqCoQJL7J/C5eg4jSnn/kJHe+z14
 oscHfaEwJFy6yFTcdGn6M5mGd8M/K6roDgArX+z02omzUKrqTgDg1DAWP5DzDYIfc8fp
 7ruY0n0ROmB8/XGzOmZCn8l+5a2UySlEJVj81FXGS3YtbmqJUhw0tN8iT9JPrTsJRSVR
 4ecA==
X-Gm-Message-State: AOJu0YxmvMa7Id/7Nmnker2BN5kawHvjMDVh7VA/zQHzaxIv832CUaDg
 p4mFvpzxwqhgPEm0T1WUYpOM26cYlCCQ0awu52WKSYwGF8cefoRls0z8zQPaXBOhEuFXNrQ6PvZ
 0w7g+zA==
X-Google-Smtp-Source: AGHT+IGyyN5X+D3AiOB22zkwsqo6aQgsaQ4LUyIFpRaxmTj9B+rB65ETTW/uPv6o4jly9U0gCd8oLw==
X-Received: by 2002:a05:6870:4412:b0:24f:cabc:4f6b with SMTP id
 586e51a60fabf-25d06b79405mr13470843fac.8.1719503352604; 
 Thu, 27 Jun 2024 08:49:12 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-197-45.totalplay.net. [187.190.197.45])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d72bf1318sm402252fac.34.2024.06.27.08.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 08:49:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH] Revert "zlib: Port fix for CVE-2016-9841 to U-Boot"
Date: Thu, 27 Jun 2024 09:49:09 -0600
Message-Id: <20240627154909.3536095-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
Michal brings in (correctly) the upstream fix for CVE-2016-9841.
However, when upstream was fixing this issue they also removed a
necessary optimization for some CPU classes as part of simplifying the
code. This in turn leads to boot failures on the platforms as they now
take too long to decompress images and so the watchdog sees the system
as stuck.

The long term fix here is as Christophe has posted, which is to restore
the optimization. Given the nearness of the release, what I do here is
very similar, result wise, but less so, code wise. This is a revert of
Michal's commit _except_ we only allow for post-increment in the code,
thus keeping the CVE resolved. For the next release this commit shall be
reverted and then Christophe's patch applied.

This largely reverts commit 340fdf1303dce7e5f53ddd981471836058ff23ef.

Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Tom Rini <trini@konsulko.com>
--
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michal Simek <michal.simek@amd.com>
---
 lib/zlib/inffast.c | 117 +++++++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 42 deletions(-)

diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
index 5e2a65ad4d27..c271d85ea191 100644
--- a/lib/zlib/inffast.c
+++ b/lib/zlib/inffast.c
@@ -1,5 +1,5 @@
 /* inffast.c -- fast decoding
- * Copyright (C) 1995-2008, 2010, 2013 Mark Adler
+ * Copyright (C) 1995-2004 Mark Adler
  * For conditions of distribution and use, see copyright notice in zlib.h
  */
 
@@ -12,6 +12,12 @@
 
 #ifndef ASMINF
 
+/*
+ * Only allow post-increment in order to resolve CVE-2016-9841
+ */
+#  define OFF 0
+#  define PUP(a) *(a)++
+
 /*
    Decode literal, length, and distance codes and write out the resulting
    literal and match bytes until either not enough input or output is
@@ -47,13 +53,12 @@
       requires strm->avail_out >= 258 for each loop to avoid checking for
       output space.
  */
-void ZLIB_INTERNAL inflate_fast(strm, start)
-z_streamp strm;
-unsigned start;         /* inflate()'s starting value for strm->avail_out */
+void inflate_fast(z_streamp strm, unsigned start)
+/* start: inflate()'s starting value for strm->avail_out */
 {
     struct inflate_state FAR *state;
-    z_const unsigned char FAR *in;      /* local strm->next_in */
-    z_const unsigned char FAR *last;    /* have enough input while in < last */
+    unsigned char FAR *in;      /* local strm->next_in */
+    unsigned char FAR *last;    /* while in < last, enough input available */
     unsigned char FAR *out;     /* local strm->next_out */
     unsigned char FAR *beg;     /* inflate()'s initial strm->next_out */
     unsigned char FAR *end;     /* while out < end, enough space available */
@@ -79,7 +84,7 @@ unsigned start;         /* inflate()'s starting value for strm->avail_out */
 
     /* copy state to local variables */
     state = (struct inflate_state FAR *)strm->state;
-    in = strm->next_in;
+    in = strm->next_in - OFF;
     last = in + (strm->avail_in - 5);
     if (in > last && strm->avail_in > 5) {
         /*
@@ -89,7 +94,7 @@ unsigned start;         /* inflate()'s starting value for strm->avail_out */
 	strm->avail_in = 0xffffffff - (uintptr_t)in;
         last = in + (strm->avail_in - 5);
     }
-    out = strm->next_out;
+    out = strm->next_out - OFF;
     beg = out - (start - strm->avail_out);
     end = out + (strm->avail_out - 257);
 #ifdef INFLATE_STRICT
@@ -110,9 +115,9 @@ unsigned start;         /* inflate()'s starting value for strm->avail_out */
        input data or output space */
     do {
         if (bits < 15) {
-            hold += (unsigned long)(*in++) << bits;
+            hold += (unsigned long)(PUP(in)) << bits;
             bits += 8;
-            hold += (unsigned long)(*in++) << bits;
+            hold += (unsigned long)(PUP(in)) << bits;
             bits += 8;
         }
         here = lcode[hold & lmask];
@@ -125,14 +130,14 @@ unsigned start;         /* inflate()'s starting value for strm->avail_out */
             Tracevv((stderr, here.val >= 0x20 && here.val < 0x7f ?
                     "inflate:         literal '%c'\n" :
                     "inflate:         literal 0x%02x\n", here.val));
-            *out++ = (unsigned char)(here.val);
+            PUP(out) = (unsigned char)(here.val);
         }
         else if (op & 16) {                     /* length base */
             len = (unsigned)(here.val);
             op &= 15;                           /* number of extra bits */
             if (op) {
                 if (bits < op) {
-                    hold += (unsigned long)(*in++) << bits;
+                    hold += (unsigned long)(PUP(in)) << bits;
                     bits += 8;
                 }
                 len += (unsigned)hold & ((1U << op) - 1);
@@ -141,9 +146,9 @@ unsigned start;         /* inflate()'s starting value for strm->avail_out */
             }
             Tracevv((stderr, "inflate:         length %u\n", len));
             if (bits < 15) {
-                hold += (unsigned long)(*in++) << bits;
+                hold += (unsigned long)(PUP(in)) << bits;
                 bits += 8;
-                hold += (unsigned long)(*in++) << bits;
+                hold += (unsigned long)(PUP(in)) << bits;
                 bits += 8;
             }
             here = dcode[hold & dmask];
@@ -156,10 +161,10 @@ unsigned start;         /* inflate()'s starting value for strm->avail_out */
                 dist = (unsigned)(here.val);
                 op &= 15;                       /* number of extra bits */
                 if (bits < op) {
-                    hold += (unsigned long)(*in++) << bits;
+                    hold += (unsigned long)(PUP(in)) << bits;
                     bits += 8;
                     if (bits < op) {
-                        hold += (unsigned long)(*in++) << bits;
+                        hold += (unsigned long)(PUP(in)) << bits;
                         bits += 8;
                     }
                 }
@@ -178,18 +183,17 @@ unsigned start;         /* inflate()'s starting value for strm->avail_out */
                 if (dist > op) {                /* see if copy from window */
                     op = dist - op;             /* distance back in window */
                     if (op > whave) {
-                        strm->msg =
-                            (char *)"invalid distance too far back";
+                        strm->msg = (char *)"invalid distance too far back";
                         state->mode = BAD;
                         break;
                     }
-                    from = window;
+                    from = window - OFF;
                     if (wnext == 0) {           /* very common case */
                         from += wsize - op;
                         if (op < len) {         /* some from window */
                             len -= op;
                             do {
-                                *out++ = *from++;
+                                PUP(out) = PUP(from);
                             } while (--op);
                             from = out - dist;  /* rest from output */
                         }
@@ -200,14 +204,14 @@ unsigned start;         /* inflate()'s starting value for strm->avail_out */
                         if (op < len) {         /* some from end of window */
                             len -= op;
                             do {
-                                *out++ = *from++;
+                                PUP(out) = PUP(from);
                             } while (--op);
-                            from = window;
+                            from = window - OFF;
                             if (wnext < len) {  /* some from start of window */
                                 op = wnext;
                                 len -= op;
                                 do {
-                                    *out++ = *from++;
+                                    PUP(out) = PUP(from);
                                 } while (--op);
                                 from = out - dist;      /* rest from output */
                             }
@@ -218,36 +222,65 @@ unsigned start;         /* inflate()'s starting value for strm->avail_out */
                         if (op < len) {         /* some from window */
                             len -= op;
                             do {
-                                *out++ = *from++;
+                                PUP(out) = PUP(from);
                             } while (--op);
                             from = out - dist;  /* rest from output */
                         }
                     }
                     while (len > 2) {
-                        *out++ = *from++;
-                        *out++ = *from++;
-                        *out++ = *from++;
+                        PUP(out) = PUP(from);
+                        PUP(out) = PUP(from);
+                        PUP(out) = PUP(from);
                         len -= 3;
                     }
                     if (len) {
-                        *out++ = *from++;
+                        PUP(out) = PUP(from);
                         if (len > 1)
-                            *out++ = *from++;
+                            PUP(out) = PUP(from);
                     }
                 }
                 else {
+		    unsigned short *sout;
+		    unsigned long loops;
+
                     from = out - dist;          /* copy direct from output */
-                    do {                        /* minimum length is three */
-                        *out++ = *from++;
-                        *out++ = *from++;
-                        *out++ = *from++;
-                        len -= 3;
-                    } while (len > 2);
-                    if (len) {
-                        *out++ = *from++;
-                        if (len > 1)
-                            *out++ = *from++;
-                    }
+                    /* minimum length is three */
+		    /* Align out addr */
+		    if (!((long)(out - 1 + OFF) & 1)) {
+			PUP(out) = PUP(from);
+			len--;
+		    }
+		    sout = (unsigned short *)(out - OFF);
+		    if (dist > 2 ) {
+			unsigned short *sfrom;
+
+			sfrom = (unsigned short *)(from - OFF);
+			loops = len >> 1;
+			do
+			    PUP(sout) = get_unaligned(++sfrom);
+			while (--loops);
+			out = (unsigned char *)sout + OFF;
+			from = (unsigned char *)sfrom + OFF;
+		    } else { /* dist == 1 or dist == 2 */
+			unsigned short pat16;
+
+			pat16 = *(sout-2+2*OFF);
+			if (dist == 1)
+#if defined(__BIG_ENDIAN)
+			    pat16 = (pat16 & 0xff) | ((pat16 & 0xff ) << 8);
+#elif defined(__LITTLE_ENDIAN)
+			    pat16 = (pat16 & 0xff00) | ((pat16 & 0xff00 ) >> 8);
+#else
+#error __BIG_ENDIAN nor __LITTLE_ENDIAN is defined
+#endif
+			loops = len >> 1;
+			do
+			    PUP(sout) = pat16;
+			while (--loops);
+			out = (unsigned char *)sout + OFF;
+		    }
+		    if (len & 1)
+			PUP(out) = PUP(from);
                 }
             }
             else if ((op & 64) == 0) {          /* 2nd level distance code */
@@ -283,8 +316,8 @@ unsigned start;         /* inflate()'s starting value for strm->avail_out */
     hold &= (1U << bits) - 1;
 
     /* update state and return */
-    strm->next_in = in;
-    strm->next_out = out;
+    strm->next_in = in + OFF;
+    strm->next_out = out + OFF;
     strm->avail_in = (unsigned)(in < last ? 5 + (last - in) : 5 - (in - last));
     strm->avail_out = (unsigned)(out < end ?
                                  257 + (end - out) : 257 - (out - end));
-- 
2.34.1

