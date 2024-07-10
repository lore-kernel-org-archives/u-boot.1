Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3785AC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 14:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D33F98871C;
	Wed, 10 Jul 2024 16:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c/aEuKDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 865AE8871A; Wed, 10 Jul 2024 16:39:02 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3B86886B6
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 16:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52ea2ce7abaso8909655e87.0
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720622338; x=1721227138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyjEfVaMEMdjvdWW1aJDTs/IKplrIBJotIiCmLQm/TY=;
 b=c/aEuKDcUTAqqZwfKvtwgdkT7KL3uiwzf8jRlDh53zOrFH4OJ90y0V0lQxt5pnFEhu
 t2ZbzPE9qdZElKUUaIqAMZlbiEs4Q1+8DDbXbXGF3WHSNzmc7PAHf4mHRjR9Pj5ANT6i
 JonxWAE0/Uqj2RHG+SL9vFqLOrTbyyUVXPLJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720622338; x=1721227138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IyjEfVaMEMdjvdWW1aJDTs/IKplrIBJotIiCmLQm/TY=;
 b=MKt7P+MwY0omYMfcIhvmwtqgqAO+K4RFk+amv0T++wa4aZoTemJa1lYzz0qIfVa32C
 /hJbSkUI2Cc6LB9dYp8/FaHVIHh2glObfkwGbFH1qBMc7PyOpmJjgN9ihKVpEeNVuzzS
 xjRGAjdHFAfoEx1PW8i3v0nyf546sl9gIxxnVqXomqBRsG+nMPaCKjoYSlxShSkMlBdN
 fW6pDdg8VqMxnOm2fGqnp+T2fHSkqq7fy2Tw8gFDz7Q713z90grhVpCbBGnhop6z18xo
 Ra0IHxfWdpc6oyIEdc0HedSTiUWTvfst8QjDW6xBGiGnlxvLzBs4Uqi5a+7YghXsiF/j
 Jjpg==
X-Gm-Message-State: AOJu0Yx7uRZdzGDKo9Dd7c+f6pgsGpfLyu48wMlWpYWBMquhLthkVjpO
 WLztvUzld9QBO4zAifxxrCvJyTa6UNa5XvIT380MeZeMxv277F3PuUeCmfLfJCzOk74sXEKmDJo
 =
X-Google-Smtp-Source: AGHT+IGZWnHE6ttI78TdKH1m0NQ9fKNj5+R+AHZUVirgn9zrTLU2/miBf4/vM6ZMF9/v1mFjOc6zWQ==
X-Received: by 2002:a05:6512:b12:b0:52c:dfe6:6352 with SMTP id
 2adb3069b0e04-52eb99d1f81mr5200590e87.48.1720622338527; 
 Wed, 10 Jul 2024 07:38:58 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa07dasm5471374f8f.87.2024.07.10.07.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 07:38:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Shengyu Qu <wiagn233@outlook.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/4] malloc: Support testing with realloc()
Date: Wed, 10 Jul 2024 15:38:51 +0100
Message-Id: <20240710143854.3905259-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710143854.3905259-1-sjg@chromium.org>
References: <20240710143854.3905259-1-sjg@chromium.org>
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
index 9549c59f358..65b130fabcd 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -1758,6 +1758,10 @@ Void_t* rEALLOc_impl(oldmem, bytes) Void_t* oldmem; size_t bytes;
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

