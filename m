Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260F4CD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 21:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F9C88003;
	Sun, 31 Mar 2024 23:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QTl2QEjr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ACC287DF1; Sun, 31 Mar 2024 22:03:38 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C39E587F77
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugeneuriev@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-515d515e28dso1110540e87.0
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711915415; x=1712520215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+mY6dXHcULqxXXWwnFpN8OlJTa3xJV+EwqFwZYcPIk=;
 b=QTl2QEjrob4eS9MIKydc0NWIklQKDvUzKRWqxRGMhPShI3gMJAb10jde/ygnO3X53p
 BNw4Y6e7Rm2blfoOLKIJuxzbuaucoNEAFGorbkVwrbKqwIGJ1y7rPSzodzIjjaOR5vnU
 Quf0sMrEBCrbO9Rt3Pl5IZ1nsWfRvRfPYFHxN1/m8eqdmPqqLha3aABZ43xQSjYlpxXb
 Gf+7NV8v+eRO+iE61SCFP4iKmYz2K7QuGOh3wjZCbgCu8sWxQmMuWqeaifOnn6iOvhzS
 KHz0rUGYYfiTMSwHdN8Z/yFI7XER5Hy6yWwRVzA8KBBk+Thsmd4HhXHH0PP8O6p22TE0
 BsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711915415; x=1712520215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y+mY6dXHcULqxXXWwnFpN8OlJTa3xJV+EwqFwZYcPIk=;
 b=janB3d2w81nU1djKv0G/rImitg04oHE2WmTFdRmO8dXH7yaOVCyIaqeVnLfQaCVHFb
 ex4IeEhCaoos5ndobitTKXuzB5FTqwJluOD29r+5MPpbvf3ZC2anj2Sqdpy9jWDbRDrN
 mA92eMz0I/uBjY+ks+oKFrVUVqe7ALvD+b/uTHQLjoz5nFjmsXCVr74n5J+8a5UJW91U
 OpRxjVkNkTqcl3Vbd0J+n+rjp6rKu4wSM7z+JmzO75hA+H8tRKRTMPlbKgiEwFu4KAxH
 C4j2Ma8GDV2ackUeJMxichClKQDKCnQePfyIlphsnU7mSrbmXroU0sETW2xvJwG8cmsU
 8Hsg==
X-Gm-Message-State: AOJu0YxSr+WrPF+RufzictDt1Xxeh1XdFJhtrGd5q30jnBxWOTtLs2P0
 SYDNcwoY8TE2afl2REj+llI2IJdv7Zhev5GkQr434LF+TFXnos8D
X-Google-Smtp-Source: AGHT+IGkNfxmeaA53D4ssOErcfQ5408QuXxseRQ+E2KYKsLvHYrExfc3F1F1xtWvWGBnqpBDlozojw==
X-Received: by 2002:a05:6512:3d18:b0:516:2b59:15b7 with SMTP id
 d24-20020a0565123d1800b005162b5915b7mr4059549lfv.22.1711915415009; 
 Sun, 31 Mar 2024 13:03:35 -0700 (PDT)
Received: from BlackProtonRN.clients.gtk.su ([185.16.100.35])
 by smtp.gmail.com with ESMTPSA id
 l5-20020ac25545000000b00516a08ce8f8sm425000lfk.269.2024.03.31.13.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 13:03:33 -0700 (PDT)
From: Eugene Uriev <eugeneuriev@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Eugene Uriev <eugeneuriev@gmail.com>
Subject: [PATCH 4/9] mcheck: integrate mcheck into dlmalloc.c
Date: Sun, 31 Mar 2024 23:03:22 +0300
Message-Id: <20240331200327.29141-5-eugeneuriev@gmail.com>
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

This changes are probable worth to be generalized in a
separate .h-file so, making it able to cover
libc-mallocs and others, without too much copy-paste.

But the malloc<=>mALLOc substitutions interfere
with an elegant way to do this.

Signed-off-by: Eugene Uriev <eugeneuriev@gmail.com>
---

 common/dlmalloc.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 0813e7e8b1..8de15d7193 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -2225,6 +2225,73 @@ void cfree(mem) Void_t *mem;
 #endif
 
 
+#ifdef MCHECK_HEAP_PROTECTION
+ #include "mcheck_core.inc.h"
+ #if !__STD_C
+  #error "must have __STD_C"
+ #endif
+
+Void_t *mALLOc(size_t bytes)
+{
+	size_t fullsz = mcheck_alloc_prehook(bytes);
+	void *p = mALLOc_impl(fullsz);
+
+	if (!p)
+		return p;
+	return mcheck_alloc_posthook(p, bytes);
+}
+
+void fREe(Void_t *mem) { fREe_impl(mcheck_free_prehook(mem)); }
+
+Void_t *rEALLOc(Void_t *oldmem, size_t bytes)
+{
+	if (bytes == 0) {
+		if (oldmem)
+			fREe(oldmem);
+		return NULL;
+	}
+
+	if (oldmem == NULL)
+		return mALLOc(bytes);
+
+	void *p = mcheck_reallocfree_prehook(oldmem);
+	size_t newsz = mcheck_alloc_prehook(bytes);
+
+	p = rEALLOc_impl(p, newsz);
+	if (!p)
+		return p;
+	return mcheck_alloc_noclean_posthook(p, bytes);
+}
+
+Void_t *mEMALIGn(size_t alignment, size_t bytes)
+{
+	return NULL;
+}
+
+// pvALLOc, vALLOc - redirect to mEMALIGn, defined here, so they need no wrapping.
+
+Void_t *cALLOc(size_t n, size_t elem_size)
+{
+	// NB: here is no overflow check.
+	size_t fullsz = mcheck_alloc_prehook(n * elem_size);
+	void *p = cALLOc_impl(1, fullsz);
+
+	if (!p)
+		return p;
+	return mcheck_alloc_noclean_posthook(p, n * elem_size);
+}
+
+// mcheck API {
+int mcheck(mcheck_abortfunc_t f)
+{
+	mcheck_initialize(f, 0);
+	return 0;
+}
+
+enum mcheck_status mprobe(void *__ptr) { return mcheck_mprobe(__ptr); }
+// mcheck API }
+#endif
+
 
 /*
 
-- 
2.25.1

