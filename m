Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004D3D6911A
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09DF89D50;
	Thu, 28 Nov 2024 16:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="erK8kY1V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1535389D47; Thu, 28 Nov 2024 16:47:57 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C06F4893D7
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:47:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3ea6b011b27so998799b6e.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808872; x=1733413672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1dOJqfhavQlk1vzE1H71zxp82RS5HyP8F7dPO0ifK4=;
 b=erK8kY1Vu/XVFND/snXFEIhLJpIp59ApX4jcu1mf2KrZc0QIJ3sHWQJGTMdF9okK2t
 opYMuomlzy3ZaPN/OqVlAeRKLtsR0tSjCfnBy/VqSy8MfColJtI1s+fWkwsRpEDN6wSc
 yUvnI6MAaBHhV3AXMifoIRbeevsUe5syJdyGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808872; x=1733413672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T1dOJqfhavQlk1vzE1H71zxp82RS5HyP8F7dPO0ifK4=;
 b=Skb/fSzGyOOsdGbcDatWYcTUwjkr39x0K0+BtdlV3GKj2l5b04y+lywYGVYs5EUL32
 lkL4zTxuM22WvUsO01QFF+a3hGXHu1AfVD5hccncIJ5TM1wHC+FmL9fTvDSqmII8wkEd
 WY1lUIkmLCi5ks5t7TMjnb3NbHux+gAK1fo+KrcbC10HHPZDfJ9QXf8vG/9erh0woi/5
 UiyAeCmpZK4ItR48KwLf19s4Q7M9AJ69yL+lFRddJttknxSzExhihrEqv/sWDVtj77Jt
 5A9lCqTtap5u99EiaE/rxAxkO7B4Pcw6a/wX4yb3nQBrZaPEDF41xUKXGjraslZ4p1p4
 dr9A==
X-Gm-Message-State: AOJu0YxcPBkkn9VKUAiYL+LAbfGphB4sOzWuISHeYTfPbYKWvFxdAtZB
 ejNIhO4akXvuMPa02fD2bBpY5FUuyibHyqQ8Uu87jY1wBewygqttOTg2pWtYU724vkNq71lKjGs
 =
X-Gm-Gg: ASbGnctcEMkDZSC7aFyS+DUS/sUS1Tqb+Roqze2cw9eUu4177plDOOUw8vkB3yPkGFH
 nw/ndHR9nANVc4XNlSn6Nnzf6tZ8TzBH0quhBFUufTaFIynNDqYgE/MrV3Ru8XGg9BnanOv/tsh
 ARikFt9+Tp5T+qHoC4G5XoJrQ3hbYBPAMT6gKS7w7exPKF1ArFRkwd7c949zJpc0TTBp0dLMVJ4
 jeGU9CShPqXuhPDBqWtk92lAhDjEw+JwMeUSeq6dTbTaA==
X-Google-Smtp-Source: AGHT+IHWbFdRcQyVOm+HMyCaPar7jam7pxpNjOkLWVhV9s6bfbRBnsogNIJG8jGL9fgAAQ/u7zaYcA==
X-Received: by 2002:a05:6808:654c:b0:3e6:3a90:ac48 with SMTP id
 5614622812f47-3ea813c7046mr2133111b6e.1.1732808872616; 
 Thu, 28 Nov 2024 07:47:52 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:47:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/28] efi_loader: Update startimage_exit self-test to
 check error
Date: Thu, 28 Nov 2024 08:47:05 -0700
Message-Id: <20241128154727.771871-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

