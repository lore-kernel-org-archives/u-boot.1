Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FFCE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2242289741;
	Mon,  9 Dec 2024 17:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HmQftVeP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 945CE896F9; Mon,  9 Dec 2024 17:29:13 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AD328970E
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844b813b7f2so1678639f.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733761749; x=1734366549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvgtItDkHybz6kcL6UE142V3KRsrVGN95z89ozCGsIg=;
 b=HmQftVeP865q72IE3ArzjkmOz3WgYlLOfgvOGoK4FWcYlaI3p/HwD+//P/uCU+9u9h
 jC0oPkmmS5jtKYmDF5n0b36wpwDFMvh8AK1KBNDeyKJqkTJwxJIxy1jNY09DxxH4OhR5
 GSQDrkCiiBqSKXNk+6CyWR9e7DC2nc7xRuiG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733761749; x=1734366549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvgtItDkHybz6kcL6UE142V3KRsrVGN95z89ozCGsIg=;
 b=rPCxEVM1TZnnPxFaCQ+Qb7VZshw7tbdid9q9lz5xK2vLKTW4FzrvjNvgEo66j6G1Jc
 lAbZmiU1fdpo79b2oWOruFSOV02MrYrVgBz+H2AtbSKb3SoxDH0muNRBboOzm1YCnDvS
 H959SpNtSyH0JXxOYLTTzdRqNO1ivZdcb45yaefUNYUDNQsuNdRNHd2UgKxMAJicTZRd
 4sVuQp69sxRVw9msRdE/OW6WFhixqHmFISWNii8Te+meGytR2Ynf+ODgGvcItm9fZ5YJ
 zqjcUYlrvgOT4A/e2nyDx5NKo9lF/yPrbn+XwrTC7cnLghdhIW/WGvqUA5piX/TSb0Uz
 vLGQ==
X-Gm-Message-State: AOJu0YyrCElA32n6nSyYN8N04ra39eMW3ItOBQdxwMq73Ti+GjjxNP1F
 /WLl4Ful739LiwfxMlCaTmgfnwRaRDsFbvRe10Xuy5rmS/czzNs5jsqXE+gSn0PYTuWXF1spADs
 =
X-Gm-Gg: ASbGncuXUTdHa7+O9tOuCoy9lKql7yZJb1Kar43hpxxxH25R9GbSUPYOkiOsaZuRiau
 UJrQXOIZUfS6+RNQh8pii0/TW37UBWobXMEm8qAOjL9ZRfS4adUT4s1FOFnq/qfHmNd0lCSTCFT
 GtPD1BH6EGwykH0AeTM1TAiboP4sPqMEylRBOi1DQv/WaWmL40NMxr25RRLTfNI/EgX4Qsm31MX
 5tW7yrMPaSNpqQO/syGyEsG7EaBb5Gz7RIPjwPRCp9UJQFKYPIfXrXo/ApIXor32uIMD30a02Qm
 lPZfvrMM2us=
X-Google-Smtp-Source: AGHT+IGjGLpN1Yu0kn4unl0TiZp5Ma2F4dTlZEELxqDNN9tb3fw0024xw8yw4kvOckAQEsGg/M5Tfg==
X-Received: by 2002:a05:6602:6b0f:b0:841:9dee:510b with SMTP id
 ca18e2360f4ac-8447e23958bmr1467977639f.9.1733761748185; 
 Mon, 09 Dec 2024 08:29:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844737bc549sm272432339f.2.2024.12.09.08.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:29:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Matthew Garrett <mgarrett@aurora.tech>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/8] efi: Avoid a memory leak in efi_bind_block() on error path
Date: Mon,  9 Dec 2024 09:28:01 -0700
Message-Id: <20241209162801.288363-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209162801.288363-1-sjg@chromium.org>
References: <20241209162801.288363-1-sjg@chromium.org>
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

Free the memory used if an error occurs.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

 lib/efi/efi_app_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
index cc91e1d74b8..fec3f348cfb 100644
--- a/lib/efi/efi_app_init.c
+++ b/lib/efi/efi_app_init.c
@@ -60,8 +60,10 @@ int efi_bind_block(efi_handle_t handle, struct efi_block_io *blkio,
 	plat->handle = handle;
 	plat->blkio = blkio;
 	plat->device_path = malloc(device_path_len);
-	if (!plat->device_path)
+	if (!plat->device_path) {
+		free(plat);
 		return log_msg_ret("path", -ENOMEM);
+	}
 	memcpy(plat->device_path, device_path, device_path_len);
 	ret = device_bind(dm_root(), DM_DRIVER_GET(efi_media), "efi_media",
 			  plat, ofnode_null(), &dev);
-- 
2.34.1

