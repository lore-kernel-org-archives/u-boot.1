Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7511D0D7BB
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 15:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD39A893A3;
	Fri, 11 Oct 2024 17:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tzCRdjWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C77289386; Fri, 11 Oct 2024 17:51:24 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E68D89392
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 17:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43117ed8adbso20517605e9.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728661872; x=1729266672;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=st3gsl4Hv1L87ZmhBwuH6nFBVIE/pTqHf20GzKXC8XE=;
 b=tzCRdjWcIxMrbq963hro0EG0Xfw7kw9V35PsVugSsTznTVpUANsU6e9GEsUJeVpE4j
 KkwbiERx0NHxx6aUowrfgVUvz2R0mO3Yfj0jygueM+B5uHy4WRzdaWerutp4Hn/MbAY7
 Kt247jmo1nd6J/mCeubkcNluQ5jNopBuIppxLt/yYbG+Z1u5gUIY+YjG32VjPXd/Y46J
 M2fK3N7raR395wGNOS+san5tWgyikvQD0U6WSpBOqxX4mVYyKxR98kvoXwanEJ8exv5o
 YaJ2m8NKNFaJMU1s5tgcH7n5TphcmWYkNTfy+ymZRDWgPJk1hS8j+YIpl/j6F+TWafFm
 oo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728661872; x=1729266672;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=st3gsl4Hv1L87ZmhBwuH6nFBVIE/pTqHf20GzKXC8XE=;
 b=ZTsUVC1cm7ii0PoNG37nkNfY1pcP58aAFtxzndH4Hbbd+34PXjCLo7VBw5xRp3cAGH
 Kb3jPkhfpHfEq4Bwcc8FWVqPH5HNuTXUsi8Z2EaxPWezgIgOXLMg6tPqW7jnkAOQib9h
 rN48rMaeZ5AnplpgR5te3jlN5nzzKdbuNSqEG/EWBFFJo9MbQaOXCYevTxzHMiSq8OVy
 TZSSmB1DaKtMjcXyDSlWuBf5EPOkSOPC5dsz1W5vokmShbf9bqu0bNsBygw5tm2TRPrR
 Wp7bTnnj4SkSgW1pmqKJsQKN5HvUt6TyPgnJCTMQkmOHji9jjh9r1XNEoEcUcY7tPvrF
 XEuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgxX0AoCjBieeUbggtefzxL/IDucytPzaD2/cBPqg13uPqeeenOYkGx8N77EyAUjHLbxvJMHo=@lists.denx.de
X-Gm-Message-State: AOJu0YyWWPBMVJoC+SRB5rEDSOzioexVMgxO7vV5zCsTUUS5zKc9M8E8
 bMUwSwgF9G4OrrqCmUyJg0ixMrUAPvHJhz0Mq87EUCfmQbADvaXhx5lSBRz34ss=
X-Google-Smtp-Source: AGHT+IHKaqZDknRe25/ylaGTj6J8KLjhJqrN8L62hWfhu6Oix5rfoPkVlGqBEb+CXF9LoGovWwq9tw==
X-Received: by 2002:a05:600c:21ce:b0:431:24c3:dbaa with SMTP id
 5b1f17b1804b1-43124c3dd9cmr4610915e9.2.1728661872590; 
 Fri, 11 Oct 2024 08:51:12 -0700 (PDT)
Received: from mkorpershoek-xps13.home
 ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431182d794asm45769005e9.1.2024.10.11.08.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:51:12 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 11 Oct 2024 17:51:03 +0200
Subject: [PATCH 2/2] configs: meson64_android: Remove dtbo support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-yukawa-aosp-parts-v1-2-7d74aa13ff8e@baylibre.com>
References: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
In-Reply-To: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.0
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

The device tree overlays are not part of the
Android Common Kernel code [1]

Historically, they existed to enable some Android specific
features but they have been removed.

Remove the dtbos logic since these files do no longer exist.

[1] https://android.googlesource.com/kernel/common/+/ac2ea0bb91a3b5f5e71eba66c441e58beca6767e/arch/arm64/boot/dts/amlogic/
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index c0e977abb01f..fa520265800c 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -116,31 +116,7 @@
 	"fi; " \
 	"abootimg get dtb --index=$dtb_index dtb_start dtb_size; " \
 	"cp.b $dtb_start $fdt_addr_r $dtb_size; " \
-	"fdt addr $fdt_addr_r  0x80000; " \
-	"if test $board_name = sei510; then " \
-		"echo \"  Reading DTBO for sei510...\"; " \
-		"setenv dtbo_index 0;" \
-	"elif test $board_name = sei610; then " \
-		"echo \"  Reading DTBO for sei610...\"; " \
-		"setenv dtbo_index 1;" \
-	"elif test $board_name = vim3l; then " \
-		"echo \"  Reading DTBO for vim3l...\"; " \
-		"setenv dtbo_index 2;" \
-	"elif test $board_name = vim3; then " \
-		"echo \"  Reading DTBO for vim3...\"; " \
-		"setenv dtbo_index 3;" \
-	"else " \
-		"echo Error: Android boot is not supported for $board_name; " \
-		"exit; " \
-	"fi; " \
-	"part start mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_start; " \
-	"part size mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_size; " \
-	"mmc read ${dtboaddr} ${p_dtbo_start} ${p_dtbo_size}; " \
-	"echo \"  Applying DTBOs...\"; " \
-	"adtimg addr $dtboaddr; " \
-	"adtimg get dt --index=$dtbo_index dtbo0_addr; " \
-	"fdt apply $dtbo0_addr;" \
-	"setenv bootargs \"$bootargs androidboot.dtbo_idx=$dtbo_index \";"\
+	"fdt addr $fdt_addr_r  0x80000; "
 
 #define BOOT_CMD "bootm ${loadaddr} ${loadaddr} ${fdt_addr_r};"
 

-- 
2.46.2

