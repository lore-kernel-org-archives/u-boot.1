Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B9DCD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 21:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5DF87FCD;
	Sun, 31 Mar 2024 23:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AixyhEa8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CED187C82; Sun, 31 Mar 2024 22:03:35 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C89287F77
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugeneuriev@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-513e134f73aso4461653e87.2
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711915411; x=1712520211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sB9B0D4hQ6ACojBU0L8lgwfz1dkWz1YxNlq2ZZ++7M=;
 b=AixyhEa8lACpwOjQY9uca7PbAoc2t45DzsgvNQjYgeqnuk3Nj/VpGgbm82cTVIYm3E
 6LxuYSUI3rFc0KFhqohRZdy4XLng2ILEzVcil90Gb1dAkH9H3Y3rS+3o7LtfaE0nJmd0
 OxTHA79xSrkZj5ru+i1jXWQuqzSD2BGeM1nEQNGfUj2meCcSMuCUAsj17eplA+CAwSKZ
 aswXsCdIMFHVCnEDZSJv2Sf6kAyiuTZICga16DrYTCXLFfrUmUoOwKYEzGi+p+o3rCYv
 w8nK4JGzIQH/8EISlkFragQyfuEe7IejS2+776oIrLg2/Pr5IR/0pujmfiAGAbfmzA3f
 kJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711915411; x=1712520211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9sB9B0D4hQ6ACojBU0L8lgwfz1dkWz1YxNlq2ZZ++7M=;
 b=Us+hc68iGWKHT1mRp5GaOREmgmBfbaCuwnuwUMlKVPwtdHPXTTLy73Km6bptu6K7mX
 Js4ZkHUeKN+Yh/7JM8XQpPyfsjVYYu5ZhjqtM5GFL3IvIX9XvP7IDEUh4HEHvIqN5LDT
 KgW45vv64V7l02jZv+FHiITCdrPfddIluJKI9zCp9uyArqG8xXRs9t7WzwfpbvGbNhI8
 cRjz5l9ykvVw1zjEdZje3JvG4uW+5dkyHbR+tfIB2IoynzCnJgEY+PA7IzTLbcEmTn7z
 ZYemux9ELfj8obh4LwjKj/zA5aC+yOtJTmp1cVGZ7I4Q3LtPvf0dDpIlcEtpSOKyfvdE
 G0Cg==
X-Gm-Message-State: AOJu0YwXv5uWuCGq6tl7YIVrmFtvIUK49vFfrIC1SD8ur5ueAD+jbe8x
 EUR7Nn6jiJF/7Y1QT+BRUeyVfRv9FOsSO+YqnSF4yJQWEhVXVxDhFM9B9iRk
X-Google-Smtp-Source: AGHT+IGthQpSO4hmW+aquAiQmGibWgpS0o/Fn33UvPwsQfra71+bw8OKFmA/EaGA+4yduA/k5/izQA==
X-Received: by 2002:a05:6512:2145:b0:515:9dcd:22ae with SMTP id
 s5-20020a056512214500b005159dcd22aemr5386688lfr.66.1711915411298; 
 Sun, 31 Mar 2024 13:03:31 -0700 (PDT)
Received: from BlackProtonRN.clients.gtk.su ([185.16.100.35])
 by smtp.gmail.com with ESMTPSA id
 l5-20020ac25545000000b00516a08ce8f8sm425000lfk.269.2024.03.31.13.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 13:03:30 -0700 (PDT)
From: Eugene Uriev <eugeneuriev@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Eugene Uriev <eugeneuriev@gmail.com>
Subject: [PATCH 1/9] mcheck: prepare +1 tier for mcheck-wrappers,
 in dl-*alloc commands
Date: Sun, 31 Mar 2024 23:03:19 +0300
Message-Id: <20240331200327.29141-2-eugeneuriev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240331200327.29141-1-eugeneuriev@gmail.com>
References: <20240331200327.29141-1-eugeneuriev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 Mar 2024 23:00:15 +0200
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

Signed-off-by: Eugene Uriev <eugeneuriev@gmail.com>

---
The file contradicts U-Boot code style a lot; so I preserve
original style, according to recommendations.

 common/dlmalloc.c | 66 +++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index de3f04225f..40acd3dfa5 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -32,6 +32,17 @@ void malloc_stats();
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#ifdef MCHECK_HEAP_PROTECTION
+ #define STATIC_IF_MCHECK static
+#else
+ #define STATIC_IF_MCHECK
+ #define mALLOc_impl mALLOc
+ #define fREe_impl fREe
+ #define rEALLOc_impl rEALLOc
+ #define mEMALIGn_impl mEMALIGn
+ #define cALLOc_impl cALLOc
+#endif
+
 /*
   Emulation of sbrk for WIN32
   All code within the ifdef WIN32 is untested by me.
@@ -1270,10 +1281,11 @@ static void malloc_extend_top(nb) INTERNAL_SIZE_T nb;
 
 */
 
+STATIC_IF_MCHECK
 #if __STD_C
-Void_t* mALLOc(size_t bytes)
+Void_t* mALLOc_impl(size_t bytes)
 #else
-Void_t* mALLOc(bytes) size_t bytes;
+Void_t* mALLOc_impl(bytes) size_t bytes;
 #endif
 {
   mchunkptr victim;                  /* inspected/selected chunk */
@@ -1555,10 +1567,11 @@ Void_t* mALLOc(bytes) size_t bytes;
 */
 
 
+STATIC_IF_MCHECK
 #if __STD_C
-void fREe(Void_t* mem)
+void fREe_impl(Void_t* mem)
 #else
-void fREe(mem) Void_t* mem;
+void fREe_impl(mem) Void_t* mem;
 #endif
 {
   mchunkptr p;         /* chunk corresponding to mem */
@@ -1696,10 +1709,11 @@ void fREe(mem) Void_t* mem;
 */
 
 
+STATIC_IF_MCHECK
 #if __STD_C
-Void_t* rEALLOc(Void_t* oldmem, size_t bytes)
+Void_t* rEALLOc_impl(Void_t* oldmem, size_t bytes)
 #else
-Void_t* rEALLOc(oldmem, bytes) Void_t* oldmem; size_t bytes;
+Void_t* rEALLOc_impl(oldmem, bytes) Void_t* oldmem; size_t bytes;
 #endif
 {
   INTERNAL_SIZE_T    nb;      /* padded request size */
@@ -1725,7 +1739,7 @@ Void_t* rEALLOc(oldmem, bytes) Void_t* oldmem; size_t bytes;
 
 #ifdef REALLOC_ZERO_BYTES_FREES
   if (!bytes) {
-	fREe(oldmem);
+	fREe_impl(oldmem);
 	return NULL;
   }
 #endif
@@ -1733,7 +1747,7 @@ Void_t* rEALLOc(oldmem, bytes) Void_t* oldmem; size_t bytes;
   if ((long)bytes < 0) return NULL;
 
   /* realloc of null is supposed to be same as malloc */
-  if (oldmem == NULL) return mALLOc(bytes);
+  if (oldmem == NULL) return mALLOc_impl(bytes);
 
 #if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	if (!(gd->flags & GD_FLG_FULL_MALLOC_INIT)) {
@@ -1758,7 +1772,7 @@ Void_t* rEALLOc(oldmem, bytes) Void_t* oldmem; size_t bytes;
     /* Note the extra SIZE_SZ overhead. */
     if(oldsize - SIZE_SZ >= nb) return oldmem; /* do nothing */
     /* Must alloc, copy, free. */
-    newmem = mALLOc(bytes);
+    newmem = mALLOc_impl(bytes);
     if (!newmem)
 	return NULL; /* propagate failure */
     MALLOC_COPY(newmem, oldmem, oldsize - 2*SIZE_SZ);
@@ -1869,7 +1883,7 @@ Void_t* rEALLOc(oldmem, bytes) Void_t* oldmem; size_t bytes;
 
     /* Must allocate */
 
-    newmem = mALLOc (bytes);
+    newmem = mALLOc_impl (bytes);
 
     if (newmem == NULL)  /* propagate failure */
       return NULL;
@@ -1886,7 +1900,7 @@ Void_t* rEALLOc(oldmem, bytes) Void_t* oldmem; size_t bytes;
 
     /* Otherwise copy, free, and exit */
     MALLOC_COPY(newmem, oldmem, oldsize - SIZE_SZ);
-    fREe(oldmem);
+    fREe_impl(oldmem);
     return newmem;
   } else {
     VALGRIND_RESIZEINPLACE_BLOCK(oldmem, 0, bytes, SIZE_SZ);
@@ -1905,7 +1919,7 @@ Void_t* rEALLOc(oldmem, bytes) Void_t* oldmem; size_t bytes;
     set_inuse_bit_at_offset(remainder, remainder_size);
     VALGRIND_MALLOCLIKE_BLOCK(chunk2mem(remainder), remainder_size, SIZE_SZ,
 			      false);
-    fREe(chunk2mem(remainder)); /* let free() deal with it */
+    fREe_impl(chunk2mem(remainder)); /* let free() deal with it */
   }
   else
   {
@@ -1939,10 +1953,11 @@ Void_t* rEALLOc(oldmem, bytes) Void_t* oldmem; size_t bytes;
 */
 
 
+STATIC_IF_MCHECK
 #if __STD_C
-Void_t* mEMALIGn(size_t alignment, size_t bytes)
+Void_t* mEMALIGn_impl(size_t alignment, size_t bytes)
 #else
-Void_t* mEMALIGn(alignment, bytes) size_t alignment; size_t bytes;
+Void_t* mEMALIGn_impl(alignment, bytes) size_t alignment; size_t bytes;
 #endif
 {
   INTERNAL_SIZE_T    nb;      /* padded  request size */
@@ -1965,7 +1980,7 @@ Void_t* mEMALIGn(alignment, bytes) size_t alignment; size_t bytes;
 
   /* If need less alignment than we give anyway, just relay to malloc */
 
-  if (alignment <= MALLOC_ALIGNMENT) return mALLOc(bytes);
+  if (alignment <= MALLOC_ALIGNMENT) return mALLOc_impl(bytes);
 
   /* Otherwise, ensure that it is at least a minimum chunk size */
 
@@ -1974,7 +1989,7 @@ Void_t* mEMALIGn(alignment, bytes) size_t alignment; size_t bytes;
   /* Call malloc with worst case padding to hit alignment. */
 
   nb = request2size(bytes);
-  m  = (char*)(mALLOc(nb + alignment + MINSIZE));
+  m  = (char*)(mALLOc_impl(nb + alignment + MINSIZE));
 
   /*
   * The attempt to over-allocate (with a size large enough to guarantee the
@@ -1990,7 +2005,7 @@ Void_t* mEMALIGn(alignment, bytes) size_t alignment; size_t bytes;
      * Use bytes not nb, since mALLOc internally calls request2size too, and
      * each call increases the size to allocate, to account for the header.
      */
-    m  = (char*)(mALLOc(bytes));
+    m  = (char*)(mALLOc_impl(bytes));
     /* Aligned -> return it */
     if ((((unsigned long)(m)) % alignment) == 0)
       return m;
@@ -1998,10 +2013,10 @@ Void_t* mEMALIGn(alignment, bytes) size_t alignment; size_t bytes;
      * Otherwise, try again, requesting enough extra space to be able to
      * acquire alignment.
      */
-    fREe(m);
+    fREe_impl(m);
     /* Add in extra bytes to match misalignment of unexpanded allocation */
     extra = alignment - (((unsigned long)(m)) % alignment);
-    m  = (char*)(mALLOc(bytes + extra));
+    m  = (char*)(mALLOc_impl(bytes + extra));
     /*
      * m might not be the same as before. Validate that the previous value of
      * extra still works for the current value of m.
@@ -2010,7 +2025,7 @@ Void_t* mEMALIGn(alignment, bytes) size_t alignment; size_t bytes;
     if (m) {
       extra2 = alignment - (((unsigned long)(m)) % alignment);
       if (extra2 > extra) {
-        fREe(m);
+        fREe_impl(m);
         m = NULL;
       }
     }
@@ -2060,7 +2075,7 @@ Void_t* mEMALIGn(alignment, bytes) size_t alignment; size_t bytes;
     set_head(newp, newsize | PREV_INUSE);
     set_inuse_bit_at_offset(newp, newsize);
     set_head_size(p, leadsize);
-    fREe(chunk2mem(p));
+    fREe_impl(chunk2mem(p));
     p = newp;
     VALGRIND_MALLOCLIKE_BLOCK(chunk2mem(p), bytes, SIZE_SZ, false);
 
@@ -2078,7 +2093,7 @@ Void_t* mEMALIGn(alignment, bytes) size_t alignment; size_t bytes;
     set_head_size(p, nb);
     VALGRIND_MALLOCLIKE_BLOCK(chunk2mem(remainder), remainder_size, SIZE_SZ,
 			      false);
-    fREe(chunk2mem(remainder));
+    fREe_impl(chunk2mem(remainder));
   }
 
   check_inuse_chunk(p);
@@ -2126,10 +2141,11 @@ Void_t* pvALLOc(bytes) size_t bytes;
 
 */
 
+STATIC_IF_MCHECK
 #if __STD_C
-Void_t* cALLOc(size_t n, size_t elem_size)
+Void_t* cALLOc_impl(size_t n, size_t elem_size)
 #else
-Void_t* cALLOc(n, elem_size) size_t n; size_t elem_size;
+Void_t* cALLOc_impl(n, elem_size) size_t n; size_t elem_size;
 #endif
 {
   mchunkptr p;
@@ -2145,7 +2161,7 @@ Void_t* cALLOc(n, elem_size) size_t n; size_t elem_size;
   INTERNAL_SIZE_T oldtopsize = chunksize(top);
 #endif
 #endif
-  Void_t* mem = mALLOc (sz);
+  Void_t* mem = mALLOc_impl (sz);
 
   if ((long)n < 0) return NULL;
 
-- 
2.25.1

