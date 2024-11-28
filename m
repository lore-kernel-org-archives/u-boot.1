Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B7ED70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBE7D89D31;
	Thu, 28 Nov 2024 20:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QzcjqJM5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C14189D39; Thu, 28 Nov 2024 20:13:12 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD1EA89D18
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2969ae2c99fso664231fac.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821187; x=1733425987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1dOJqfhavQlk1vzE1H71zxp82RS5HyP8F7dPO0ifK4=;
 b=QzcjqJM52c75x5xQMtPKu/YhWmpFzlWgoSmsk3zgGI+dmGZ5NHygzPI8Qp7XeL5Scl
 5AbgemVIWBX0ZbNSbMVhVOPfiDKnqMcNhhR2koQZ3oNcI006XEsHbg0CVMsRvrrMQRE2
 4/RMUNn+sh4D/Y54Zz06OnRwkgXyoHQgq8iHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821187; x=1733425987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T1dOJqfhavQlk1vzE1H71zxp82RS5HyP8F7dPO0ifK4=;
 b=dx0psVz8MU0necPFrGxnq+EelS9vKdlBG2kEFu609Kri6r/sEySVKQAMnFcFaEsSVP
 JvI2HhUFWB0hLjrXMsn+ICFdK2nqWYl+NKA3mb/1B+fd+UXsUNhcDbFL8Uhmxzpi9y2w
 ea4Z5hefvvvq2AjqZf04NotonYLgY+NDaEXz9ei6GtwJ1ULjuhRaD7d5rz2U8OB0RQl9
 RilKschDs/OZkpUo9FKUBWGhxUO9w3QWMFqKxy5yDB+GfSdJOoVj1f5b99dQllWOC+im
 rJeY26n4sgwdPRWc6R1WPlmHmJ/eneFUjql0cax/z/nIw0O/jvMYVc57M2odZ5n56Oeu
 skyw==
X-Gm-Message-State: AOJu0YwTwTqGRHG041uf0UYfkX70JIDPNgpBObQZsKhc1TKX3PBttlUv
 2pi9QKYWsNxLvTW6sotAJQvlth12moRSnozSEr9ksMjGx/8SY8bn7Jl2yLmk6JJH7Oo5eD9r3AE
 =
X-Gm-Gg: ASbGncvipv026rjY7txnvy29litjK8LnQhgHp7y+rdmpY441viiEWEL7Me/U+unYoaH
 DMds/uuwH8BSxPsx0qEdw+JRkL3q4O0fXyav2xlTfW5w7JNw/LYoI5PaPG9jeonGCxuB5a4ly28
 RyiQfJ0SnJd0VjpIj2rmAUGP14THq+dfVJTMdKYY7dpyvaLyRQ7WUmjYrJqG7rrB49NWFYDNNdg
 5RUMN1jFXhRKropTiKlKid7zecTRF9lJZP4IGmObpz4Jw==
X-Google-Smtp-Source: AGHT+IGQcSo6QHt8udMYNtajjjlYo9pFLHrosMQqOIx5XDKiOboJJ1NJoVGKDhj0uaMdkJitdlpitQ==
X-Received: by 2002:a05:6870:6125:b0:270:1884:9db1 with SMTP id
 586e51a60fabf-29dc3f96796mr6460574fac.7.1732821186084; 
 Thu, 28 Nov 2024 11:13:06 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 06/28] efi_loader: Update startimage_exit self-test to
 check error
Date: Thu, 28 Nov 2024 12:12:22 -0700
Message-Id: <20241128191244.900006-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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

Check for an error returned from the decompress() function, just in
case.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/efi_selftest/efi_selftest_startimage_exit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_startimage_exit.c b/lib/efi_selftest/efi_selftest_startimage_exit.c
index b65a10b7a4b..8d119f054c5 100644
--- a/lib/efi_selftest/efi_selftest_startimage_exit.c
+++ b/lib/efi_selftest/efi_selftest_startimage_exit.c
@@ -84,13 +84,15 @@ static efi_status_t decompress(u8 **image)
 static int setup(const efi_handle_t handle,
 		 const struct efi_system_table *systable)
 {
+	efi_status_t ret;
+
 	image_handle = handle;
 	boottime = systable->boottime;
 
 	/* Load the application image into memory */
-	decompress(&image);
+	ret = decompress(&image);
 
-	return EFI_ST_SUCCESS;
+	return ret;
 }
 
 /*
-- 
2.34.1

