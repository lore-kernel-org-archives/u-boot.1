Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C9EC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 14:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C548F885BF;
	Fri, 26 Jul 2024 16:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TPAzI2IC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45ACE878ED; Fri, 26 Jul 2024 16:00:51 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34B1C884DB
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 16:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3970f9331deso7540805ab.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722002448; x=1722607248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYhc/YHjz+SNjU8S0PYvLCnIV64pvWKwFmmMo7EqYdI=;
 b=TPAzI2ICymt0EeUyAflFb2+QaXjdLb94P4XIfUPlNQ7nCG81Nz8c4g94sDY9imELSY
 bijAnQZVsVHvAjQN6KW3rZP0R4TcjqBsvLjX5yHIhR6oIlJkQB/a6eQHH8OUqQ+yRa7V
 IZS5UarHPCUa2pJ4soKWaLlqzGG8tO/ibSkxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722002448; x=1722607248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FYhc/YHjz+SNjU8S0PYvLCnIV64pvWKwFmmMo7EqYdI=;
 b=xT8ynIP0HyEI24AHpny7wS9WlfqJZc/PEDsuTANTDElQjsBTHGRJ9SzpYv0otpAaZT
 erUcnwkg18fhtXDf5vb0QERwwWzbZQVnhSS7iyP3kvdNn0wpyTEo+0UBB1C67hQOm6ZT
 MOHID8S08Sod6+b35hZJHfQqDiFKxUII0D8xkyiwaviq4fxUab/lUqv4E3tjxiUZqLOS
 uWooohJbT6lt4soFNGKK3kynM6/C8dR1ZukZYbozysEsqEvf7+f13hSvJDScE3aAWOJd
 BRCYYnkSg/HlBaiqnvZKAk1HRvDKKIAunxBbBOFzexUdRVW2tCwhM+QVcB34VSgQGKdA
 iQ7g==
X-Gm-Message-State: AOJu0Yx6cfybvfJ6yj/lH/mzHO1U1Kua2DfFXmSk72qshYb7IkY0qosY
 4+hItAspiyFIZDreDp+qZ+6knPOp+bW5VH9p4KqN2236QyhgV+Z6GuWB/UPVcixKHDjyvT9a8A0
 =
X-Google-Smtp-Source: AGHT+IEnBIvuNI4jj1BB9OZkwCIv6JaoJFnCytcrU0f5oeYOCuDXRWos2kQUUdKwZoBM/0FOffIxMg==
X-Received: by 2002:a05:6e02:1486:b0:397:8704:ac84 with SMTP id
 e9e14a558f8ab-39a2400f176mr71883135ab.21.1722002447610; 
 Fri, 26 Jul 2024 07:00:47 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a22e7ec25sm14411905ab.6.2024.07.26.07.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 07:00:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Shengyu Qu <wiagn233@outlook.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 1/4] malloc: Support testing with realloc()
Date: Fri, 26 Jul 2024 08:00:35 -0600
Message-Id: <20240726140038.194946-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726140038.194946-1-sjg@chromium.org>
References: <20240726140038.194946-1-sjg@chromium.org>
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

