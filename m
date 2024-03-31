Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE40CD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 21:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 144E6882C4;
	Sun, 31 Mar 2024 23:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gin49LeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF94087F8B; Sun, 31 Mar 2024 22:03:40 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D40B987DF1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugeneuriev@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-516a01c8490so797932e87.1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711915418; x=1712520218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CykDrKhEY3XMdGlZOyT5MTTTgwvqdMBuZvQx6VAYeN8=;
 b=gin49LeBdBiUyD8DqrpdKnJfi3rfKl12ID1gqLNXxLMw/IVuLm1Zdr4FWX+CQk0j9P
 Ch8Zp8T+ql07f8datXvfz3mrFwwGETlHuvhaPasUUVQLzVGI4Dr3dEYgJqoVgZhgOcp4
 fOQzKWRAM1VHjL07TMJ4D3k2bmPTQ/aUiWobsKl1Mi9H2/9sujsfkcNxVT9HVEZZ8o6V
 npZUqhmbemamKE0LA8C1WcQfkNW97B7X1hxJSlq7J7GTvdU+bOeMT4qcC+L6zuWJX5oy
 DTkkHq5WR5mlsXAAFEbBbVhhJwgATo8yb9PSM2zBhuxJGmoecOKAS/opEplGs0FQ+iwq
 wqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711915418; x=1712520218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CykDrKhEY3XMdGlZOyT5MTTTgwvqdMBuZvQx6VAYeN8=;
 b=nQGce14V+yBdC/hwSVVPc/EnIyVPU8Xt7aiK9RheVDQi3cu9ywRCcvAoDQGaU55lMK
 lPpGYC4mCNJnHRX/EcajEp7c5CQpLePlxnVZct+LEBOt+EiIqYP0Lwm8Zbke/ThRpFhQ
 xcLDNwX7ik21C4jX/AVlcSnIDBV8SALSrQX7TB/LNUEOCPiKB9M+nKd5Pr89cwj94ulP
 oPOzGaqkRWS79SmLFs3irkK5phNDYAf4YBUc8G3T0VWxcI8ZobdO524mZ6GMJZyyJyOA
 Cpo+umUtUxzWjT+AzBNdE1Q8QrYlDgF+6KKTi4BISP52hnJcQjKuToc9S3zPsjtOCLDp
 NAag==
X-Gm-Message-State: AOJu0Yx7T5HNVfyNCDoNekLko7xneHolDJc8CFXt2T5JYiSDMHbJKvJW
 ThbtE2kYtkuZC16yIlIOLnq3imU0dGEyvIImMj3jyuCuYGTite4H
X-Google-Smtp-Source: AGHT+IFyIqqDQLVnWNfKi5FrSGBwVhyef1EHpgitd1keSlF8nEl/saU7tBmiWGLgphIDhCM7IAg7wg==
X-Received: by 2002:ac2:532d:0:b0:515:89cc:26ab with SMTP id
 f13-20020ac2532d000000b0051589cc26abmr2564694lfh.9.1711915418051; 
 Sun, 31 Mar 2024 13:03:38 -0700 (PDT)
Received: from BlackProtonRN.clients.gtk.su ([185.16.100.35])
 by smtp.gmail.com with ESMTPSA id
 l5-20020ac25545000000b00516a08ce8f8sm425000lfk.269.2024.03.31.13.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 13:03:37 -0700 (PDT)
From: Eugene Uriev <eugeneuriev@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Eugene Uriev <eugeneuriev@gmail.com>
Subject: [PATCH 6/9] mcheck: add pedantic mode support
Date: Sun, 31 Mar 2024 23:03:24 +0300
Message-Id: <20240331200327.29141-7-eugeneuriev@gmail.com>
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

The pedantic mode is run-time contolled, so
appropriate registry take place everytime.

Maybe it's worth to use compile-time control only.
So, the registry could be optimized out by an #ifdef.

Signed-off-by: Eugene Uriev <eugeneuriev@gmail.com>
---

 common/dlmalloc.c        | 12 ++++++++++++
 common/mcheck_core.inc.h | 41 ++++++++++++++++++++++++++++++++++++++++
 include/mcheck.h         |  9 +++++++++
 3 files changed, 62 insertions(+)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 73c04af2a3..a0616217d4 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -2233,6 +2233,7 @@ void cfree(mem) Void_t *mem;
 
 Void_t *mALLOc(size_t bytes)
 {
+	mcheck_pedantic_prehook();
 	size_t fullsz = mcheck_alloc_prehook(bytes);
 	void *p = mALLOc_impl(fullsz);
 
@@ -2245,6 +2246,7 @@ void fREe(Void_t *mem) { fREe_impl(mcheck_free_prehook(mem)); }
 
 Void_t *rEALLOc(Void_t *oldmem, size_t bytes)
 {
+	mcheck_pedantic_prehook();
 	if (bytes == 0) {
 		if (oldmem)
 			fREe(oldmem);
@@ -2265,6 +2267,7 @@ Void_t *rEALLOc(Void_t *oldmem, size_t bytes)
 
 Void_t *mEMALIGn(size_t alignment, size_t bytes)
 {
+	mcheck_pedantic_prehook();
 	size_t fullsz = mcheck_memalign_prehook(alignment, bytes);
 	void *p = mEMALIGn_impl(alignment, fullsz);
 
@@ -2277,6 +2280,7 @@ Void_t *mEMALIGn(size_t alignment, size_t bytes)
 
 Void_t *cALLOc(size_t n, size_t elem_size)
 {
+	mcheck_pedantic_prehook();
 	// NB: here is no overflow check.
 	size_t fullsz = mcheck_alloc_prehook(n * elem_size);
 	void *p = cALLOc_impl(1, fullsz);
@@ -2287,12 +2291,20 @@ Void_t *cALLOc(size_t n, size_t elem_size)
 }
 
 // mcheck API {
+int mcheck_pedantic(mcheck_abortfunc_t f)
+{
+	mcheck_initialize(f, 1);
+	return 0;
+}
+
 int mcheck(mcheck_abortfunc_t f)
 {
 	mcheck_initialize(f, 0);
 	return 0;
 }
 
+void mcheck_check_all(void) { mcheck_pedantic_check(); }
+
 enum mcheck_status mprobe(void *__ptr) { return mcheck_mprobe(__ptr); }
 // mcheck API }
 #endif
diff --git a/common/mcheck_core.inc.h b/common/mcheck_core.inc.h
index b038bb0539..85a34de295 100644
--- a/common/mcheck_core.inc.h
+++ b/common/mcheck_core.inc.h
@@ -30,6 +30,8 @@
  * Unlike glibc-clients, U-Boot has limited malloc-usage, and only one thread.
  * So it's better to make the protection heavier.
  * Thus overflow canary here is greater, than glibc's one. Underflow canary is bigger too.
+ * U-Boot also allows to use fixed-size heap-registry, instead of double-linked list in glibc.
+ *
  * Heavy canary allows to catch not only memset(..)-errors,
  * but overflow/underflow of struct-array access:
  *	{
@@ -61,8 +63,14 @@
 #define FREEFLOOD	((char)0xf5)
 #define PADDINGFLOOD	((char)0x58)
 
+// my normal run demands 4427-6449 chunks:
+#define REGISTRY_SZ	6608
 #define CANARY_DEPTH	2
 
+// avoid problems with BSS at early stage:
+static char mcheck_pedantic_flag __section(".data") = 0;
+static void *mcheck_registry[REGISTRY_SZ] __section(".data") = {0};
+
 typedef unsigned long long mcheck_elem;
 typedef struct {
 	mcheck_elem elems[CANARY_DEPTH];
@@ -159,6 +167,12 @@ static void *mcheck_free_helper(void *ptr, int clean_content)
 	if (clean_content)
 		mcheck_flood(ptr, FREEFLOOD, mcheck_allign_customer_size(hdr->size));
 
+	for (i = 0; i < REGISTRY_SZ; ++i)
+		if (mcheck_registry[i] == hdr) {
+			mcheck_registry[i] = 0;
+			break;
+		}
+
 	return (char *)hdr - hdr->aln_skip;
 }
 
@@ -197,6 +211,17 @@ static void *mcheck_allocated_helper(void *altoghether_ptr, size_t customer_sz,
 
 	for (i = 0; i < CANARY_DEPTH; ++i)
 		tail->elems[i] = MAGICTAIL;
+
+	for (i = 0; i < REGISTRY_SZ; ++i)
+		if (!mcheck_registry[i]) {
+			mcheck_registry[i] = hdr;
+			return payload; // normal end
+		}
+
+	static char *overflow_msg = "\n\n\nERROR: mcheck registry overflow, pedantic check would be incomplete!!\n\n\n\n";
+
+	printf("%s", overflow_msg);
+	overflow_msg = "(mcheck registry full)";
 	return payload;
 }
 
@@ -227,9 +252,25 @@ static enum mcheck_status mcheck_mprobe(void *ptr)
 	return mcheck_checkhdr(hdr);
 }
 
+static void mcheck_pedantic_check(void)
+{
+	int i;
+
+	for (i = 0; i < REGISTRY_SZ; ++i)
+		if (mcheck_registry[i])
+			mcheck_checkhdr(mcheck_registry[i]);
+}
+
+static void mcheck_pedantic_prehook(void)
+{
+	if (mcheck_pedantic_flag)
+		mcheck_pedantic_check();
+}
+
 static void mcheck_initialize(mcheck_abortfunc_t new_func, char pedantic_flag)
 {
 	mcheck_abortfunc = (new_func) ? new_func : &mcheck_default_abort;
+	mcheck_pedantic_flag = pedantic_flag;
 }
 
 #endif
diff --git a/include/mcheck.h b/include/mcheck.h
index a049745e4e..f4c9b7e61c 100644
--- a/include/mcheck.h
+++ b/include/mcheck.h
@@ -33,6 +33,15 @@ typedef void (*mcheck_abortfunc_t)(enum mcheck_status);
 
 int mcheck(mcheck_abortfunc_t func);
 
+/*
+ * Similar to `mcheck' but performs checks for all block whenever one of
+ * the memory handling functions is called.  This can be very slow.
+ */
+int mcheck_pedantic(mcheck_abortfunc_t f);
+
+/* Force check of all blocks now.  */
+void mcheck_check_all(void);
+
 /*
  * Check for aberrations in a particular malloc'd block. These are the
  * same checks that `mcheck' does, when you free or reallocate a block.
-- 
2.25.1

