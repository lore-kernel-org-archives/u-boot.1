Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58206C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB5EC88847;
	Tue, 30 Jul 2024 16:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="moDY7hx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6812D88868; Tue, 30 Jul 2024 16:40:03 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DAB588842
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-399020cfbb7so19680825ab.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722350400; x=1722955200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYhc/YHjz+SNjU8S0PYvLCnIV64pvWKwFmmMo7EqYdI=;
 b=moDY7hx+EeoKhevTJWPNAMSohm9iEFBjEF362rCvmHg+xuT64FVoCaT5BXftFh4mfm
 7+e29yP5R3Qfp9iMqg0fAioCM1YzTqKFs6y/WHXvGzO7B5foOSgCxRw9zX01aVHzIS4P
 FYTW+tLWHh3ABRNTjlZeHkeDB5ZkekxjeBD2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722350400; x=1722955200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FYhc/YHjz+SNjU8S0PYvLCnIV64pvWKwFmmMo7EqYdI=;
 b=e7/EStjn+z4y0uWYbGx2u+3/HnTIgtwHW1kxGWokLg6ffipwFZY6iOlwhTTlvwB9WI
 T8v46Nvu1EkJH6+9uYl6iZHQ6Ok91KQxt+lltfdpRUQFKEosiyuEQoHcxwNz+PfDx7oI
 tjVji9M2aKCOLYYGZgNWTIYCNNJBfgutmlNlneq0zEgNa+MBPWvuxIDHSQ6ELKeLJyt2
 kCy2nLVP1+5Ao/pzTr/Xj0GW4KZZsaGWJuUkWvWZxUltFkOYp/oUpB7powQ8TMR3n87x
 t1b/AWh7hVaz9nzntGeWUrdzMROQLJuoXtLAnb67YNj7PXRTxrpWn4T7ishu2Q+G5yXp
 zZiA==
X-Gm-Message-State: AOJu0YymzTyvoITbgb4VIWL4rL6PzsVTpgkHhuaURDTH6pDkipgPLuGy
 zzd708KAketVFzv7nBQO3IyrDx+QqqQ4lYVqUGaLbPbfnogqfP//X/BO6qgh3xtcmpehDCNarVg
 =
X-Google-Smtp-Source: AGHT+IHGkCItpNmVm1kFw7l2yOr0YGndytgQvG08cA+jembjtwmfuC5CBzz+xM9peaBOZbG73V81QQ==
X-Received: by 2002:a92:ca09:0:b0:396:bfa6:6f30 with SMTP id
 e9e14a558f8ab-39aec2cda1emr149007845ab.6.1722350399694; 
 Tue, 30 Jul 2024 07:39:59 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39af4bb209fsm23369925ab.5.2024.07.30.07.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 07:39:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 1/4] malloc: Support testing with realloc()
Date: Tue, 30 Jul 2024 08:39:35 -0600
Message-Id: <20240730143938.3991937-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730143938.3991937-1-sjg@chromium.org>
References: <20240730143938.3991937-1-sjg@chromium.org>
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

At present in tests it is possible to cause an out-of-memory condition
with malloc() but not realloc(). Add support to realloc() too, so code
which uses that function can be tested.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/dlmalloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 62e8557daa7..1e1602a24de 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -1698,6 +1698,10 @@ Void_t* rEALLOc_impl(oldmem, bytes) Void_t* oldmem; size_t bytes;
 		panic("pre-reloc realloc() is not supported");
 	}
 #endif
+  if (CONFIG_IS_ENABLED(UNIT_TEST) && malloc_testing) {
+    if (--malloc_max_allocs < 0)
+      return NULL;
+  }
 
   newp    = oldp    = mem2chunk(oldmem);
   newsize = oldsize = chunksize(oldp);
-- 
2.34.1

