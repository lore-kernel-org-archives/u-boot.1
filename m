Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E128C05023
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8AAC8847F;
	Tue, 16 Apr 2024 21:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kBV+W5nk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBA2A8844E; Tue, 16 Apr 2024 21:02:06 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE9F8843B
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6ea2ac4607aso2603146a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294116; x=1713898916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RrC9QJJ79XBW35sP6bQQd2FLEjOb+KE/kja+lZMDXBg=;
 b=kBV+W5nk3a2qPmbndzOMgXzvARpXEyFs6hvgoArew1+uJQBDkkLtBS7cHmXmk54tXz
 V976wjRP8Ae4NVpBeh7NtnnNeAA1IQOUOnH43e0qfM7kXRfVfTCkAcK/k//H+2vhq6+I
 9gCrT1irD/NuGuPmCFrPQOSEDs9ygsgHEmNz9XwBYr3tcHITftayhrnjxMtQa/SJi+lw
 9me9Hvwyb6DredQwCD/xaBZv41nBd6Rk3gHbGtGoLqk82Qah9N1QPxhghqeU0ZWLBMCK
 Ltm20Ih9LCw+H7aEWhwhA+GZykRnlOe4DbAuk9Mz0bmIJ+3md4nPIEWpzpGhzFgMn8R7
 9GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294116; x=1713898916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RrC9QJJ79XBW35sP6bQQd2FLEjOb+KE/kja+lZMDXBg=;
 b=TdK3Ep2BC4ecDOyLSR/dMVuRD/ny3G+kN6UP+13ywQq6ygSfU19cRvGXep8tJqYFxJ
 BPI5KLMSgDT15jN4l7TMxBLCXZ8TIE3DAj/d3Zwt56OENDvgQrqVtx531Z/Rf2rntNed
 POWWaSE4TWsnUiI/S4YlmnNWoTkXudR8/vloD1zpAABWE6XFqyQO6LvrqVh9nikDHt+N
 gyxA/qY9uDYzHlTEHH2ceL5pIKA7/BGMnSxRUUX6qcmnA0lU8OCZs7XN08saFP0FSY28
 jGbRZ/LgR/6Py6hTSAxhayPEsmmaqO9LRrx0MY5J72pUYJSZ5N2AmxHn1dWNUvYiIW+V
 vAdQ==
X-Gm-Message-State: AOJu0YyiKboHRZsXeMJLEzKETVGsU0eOUA8KXhPHILuF++udkzsbWyXG
 RAbwwFuCvCaSfK/A8Mm5m4KKtKWcZEeeJxJjQZtlB9/rmEACzb2QbPQC7orR8tX7xi3umOPhge/
 1
X-Google-Smtp-Source: AGHT+IG+0gXHnnthR3nSk7oY8CqdzoE+rUpAqvy34vGe2dkS1O6b2IBcZ3DvxZwiPvyptjSmCbuCBA==
X-Received: by 2002:a9d:624b:0:b0:6eb:5b4b:51fc with SMTP id
 i11-20020a9d624b000000b006eb5b4b51fcmr13106790otk.24.1713294115849; 
 Tue, 16 Apr 2024 12:01:55 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:01:55 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 12/23] image: switch sha256 to mbedtls
Date: Tue, 16 Apr 2024 12:00:08 -0700
Message-Id: <20240416190019.81016-13-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

When MBEDTLS_LIB_CRYPTO is enabled, use the APIs of sha256 from
hash shim layer instead.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 boot/image-pre-load.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index b504ab42a5..85d5ff3ab7 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -8,8 +8,11 @@
 DECLARE_GLOBAL_DATA_PTR;
 #include <image.h>
 #include <mapmem.h>
-
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+#include <mbedtls/sha256.h>
+#else
 #include <u-boot/sha256.h>
+#endif
 
 /*
  * Offset of the image
@@ -240,8 +243,13 @@ static int image_pre_load_sig_check_img_sig_sha256(struct image_sig_info *info,
 		goto out_sig_header;
 	}
 
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+	sha256_csum_wd_mb(header + offset_img_sig, info->sig_size,
+			  sha256_img_sig, CHUNKSZ_SHA256);
+#else
 	sha256_csum_wd(header + offset_img_sig, info->sig_size,
 		       sha256_img_sig, CHUNKSZ_SHA256);
+#endif
 
 	ret = memcmp(sig_header->sha256_img_sig, sha256_img_sig, SHA256_SUM_LEN);
 	if (ret) {
-- 
2.25.1

