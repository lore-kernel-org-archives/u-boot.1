Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0372CC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CDAE87600;
	Mon, 18 Dec 2023 19:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VBUmEDoz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E50E087509; Mon, 18 Dec 2023 19:20:34 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB0B87600
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-67f147c04b7so28091646d6.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702923630; x=1703528430; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41rOY4nhe0tDZZ3Xj+jiOtbIUhWWRTymvUdxcnAtoks=;
 b=VBUmEDozWTgrPxUIMsVeprstF5kGDRGnPlKI63Zv64rXEgobuNkjG9hOrFXufc7w4K
 xjfwPFJxyalG3RE3V+tABtOq9xtrqP51eeLmWrOOIufYdrpy7UnWoWTsHhyK3fGlGJIT
 HuXKz00wAFcw9PthICerEbtErrbTUKQNH36Z0PalcaBfzvJeE0v67gHDaJgVHkkEO+78
 lHFxGjDe909Yrn/z0vqZu8usDS3FiHlfSoRXMggx7DiY57rwvIuTGIFJVeZLQ+L9lyFN
 +KA21kLKpPlpptjWaSB0AIjr5+IjdSSMcyCDEI5Z+viBKvqBGpRn1UDxtnwTsplU1nYm
 mKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923630; x=1703528430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41rOY4nhe0tDZZ3Xj+jiOtbIUhWWRTymvUdxcnAtoks=;
 b=r1uD2rzP0c1M0LkqcAHZKEDvoXpBKpejSNkOXgaz9PPTwco+atj8V3iYi0jvar2mSW
 ahK+9xg+hOU6zcbmnCXUKiMTusjQPfcmZbwpnkUcBILpEfq48wHXxRRDO06FWImqq05X
 gbr5jNtT4oM2NOrMWzFAN71alp9S7jWXpSQZGCQNdqFkkGyma/DVBiYxutvYiPU6sagJ
 UyeZr1ldQXodx9zP1nltyaaraL7miCIcF8W7EU3ocJ0Zj5yuNhfkCgoA9JRfWIGuqv6b
 lbuY6XYFDmSyqCBGPVWwv4fyz27SX9c1802iuBCCer8vqIChJ0WYnqXY+lVoPUJa3D4x
 C+Aw==
X-Gm-Message-State: AOJu0YwYUeVhcQZTnVzBBw6vkZP0/Cnw/CEh3mKhcHyAcAgHTsQVN4uS
 vzJcMmq2OCa9TSROb/aTZAaCQnGqp7AIwuJNIvU=
X-Google-Smtp-Source: AGHT+IEgg/2veHFN1HI7Nf90j02FxA6quLWe543pizfVkS0waNDghEhNK7NspddvwR+3sTF9FuI9Tg==
X-Received: by 2002:a05:6214:765:b0:67f:40cd:84df with SMTP id
 f5-20020a056214076500b0067f40cd84dfmr3924544qvz.29.1702923630687; 
 Mon, 18 Dec 2023 10:20:30 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020ad44e87000000b0067f213933bdsm3046136qvb.2.2023.12.18.10.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:20:30 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 13/14] bloblist: Update documentation and header comment
Date: Mon, 18 Dec 2023 10:18:58 -0800
Message-Id: <20231218181901.337515-14-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218181901.337515-1-raymond.mao@linaro.org>
References: <20231218181901.337515-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

Align the documentation with the v0.9 spec.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 doc/develop/bloblist.rst | 4 +++-
 include/bloblist.h       | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/develop/bloblist.rst b/doc/develop/bloblist.rst
index 81643c7674..28431039ad 100644
--- a/doc/develop/bloblist.rst
+++ b/doc/develop/bloblist.rst
@@ -14,6 +14,8 @@ structure defined by the code that owns it.
 For the design goals of bloblist, please see the comments at the top of the
 `bloblist.h` header file.
 
+Bloblist is an implementation with the `Firmware Handoff`_ protocol.
+
 Passing state through the boot process
 --------------------------------------
 
@@ -99,7 +101,7 @@ API documentation
 -----------------
 
 .. kernel-doc:: include/bloblist.h
-
+.. _`Firmware Handoff`: https://github.com/FirmwareHandoff/firmware_handoff
 
 Simon Glass
 sjg@chromium.org
diff --git a/include/bloblist.h b/include/bloblist.h
index 8f0286fda7..e3c86808b4 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -66,6 +66,7 @@
  *
  * Copyright 2018 Google, Inc
  * Written by Simon Glass <sjg@chromium.org>
+ * Adjusted July 2023 to match Firmware handoff specification, Release 0.9
  */
 
 #ifndef __BLOBLIST_H
-- 
2.25.1

