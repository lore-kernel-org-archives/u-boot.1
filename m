Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C875E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A77D5805F5;
	Mon,  6 Jan 2025 15:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A2fs81aH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0338780634; Mon,  6 Jan 2025 15:48:25 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A6D801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3cda56e1dffso13859145ab.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174898; x=1736779698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3uHakEL+4JiuIbbxMwa3RSUfj8D2CRk/ltaChpwzeg=;
 b=A2fs81aHofKzkiULFDMq5AcJyNxZPhzFBE1psJRhNgmtlchAMGaxmJwZ/1cMcJxfqz
 x6mLzTOEGZXj2z3nkBgezH8x0JaReMrdmJkjrEKwKEV/guKwadgCgGkJpVuqdP220Gd0
 soR1cRR+e36KZogLavaqnmE3tRv+Hq3ktZjH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174898; x=1736779698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g3uHakEL+4JiuIbbxMwa3RSUfj8D2CRk/ltaChpwzeg=;
 b=VJ0iDtSaGVuKm0KAu9whJejhqBwqq3ohaVe2m1DA+61q9E6QQ5biVB0kXwJAFAdtYJ
 n98A4tI5n/2/zxDktS8YY1+ut+GyEZumfBJk6NsdpGbXIe5lV/ry/i6omLhyQJfpPCdn
 Xy4OUAY9Xr18soG4pWx9K9nFSN5GZ4wX9n8I3Qzdyy7J2/JMbgX5zdVJFWPzsRGE34m3
 6To2MRIOWkkWD8CuOKaCkffIVMyCz1RZottVjrzS9fS46YBHlG8ctBgCbUMS6EpSjmwl
 6xAeUcqinwN7JMqNdvZ4lFMzucEzT1oxwFg4RSbYeuDvFETMLxQWG6XRollwjGEwDnu6
 0ulA==
X-Gm-Message-State: AOJu0Yzhx4/tHTR10r84UB3WqYXG8umtqLuhm9wjNEs7KlPe2deVMF5f
 ij/asj1TSdTOx19iZXGHpZKIU7aRpm1OqHz7a9rqV5rUD09MZyO2cEwbRTlqhVQIFWX7hRtuMCw
 =
X-Gm-Gg: ASbGncuIKcnbg6f0vEeTncjD9BQ7nUZBjeysWiXiAf6UYiTjN722hM8SxObO0oHiD0c
 mx5jRJ/oLIYryXyMjb9AW+cUMwANj1nCEqrrXWr4OhXZNpC393lgWeFLNHvBAWClNKlvho8bO5z
 aqs/JiQz7zmbUoqJjQrukAHv//dPOwqH2CadKsk0P7bh7WLByPl3F4T4M6dHtnrHOszueK6wYMD
 QNxD2bNzv+EhMp2FT+x6vS/QwMyGDqo0iQaA9AI8wl6kUWrKf6JUJsiEg3ZEOG8+MdsHRPPNpwP
 pBJPcDfYagZOyzUDyg==
X-Google-Smtp-Source: AGHT+IGVjRCyMuVs0a957OvQIF9MuKSzAxFKpcwDnFUFQpjkCmwZ8rj6aUcM/gooszhh3SUkQ/v75A==
X-Received: by 2002:a05:6e02:b45:b0:3a7:e732:471f with SMTP id
 e9e14a558f8ab-3c2d14d1cd2mr493681735ab.1.1736174898204; 
 Mon, 06 Jan 2025 06:48:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c37bb139a0sm94081185ab.70.2025.01.06.06.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:48:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/8] efi_loader: Update testapp to get memory map correctly
Date: Mon,  6 Jan 2025 07:47:53 -0700
Message-Id: <20250106144755.3054780-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106144755.3054780-1-sjg@chromium.org>
References: <20250106144755.3054780-1-sjg@chromium.org>
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

Allocate enough memory for the memory map so that it can be received
successfully.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/testapp.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
index 804ca7e4679..171ecdab043 100644
--- a/lib/efi_loader/testapp.c
+++ b/lib/efi_loader/testapp.c
@@ -28,7 +28,12 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
 			     struct efi_system_table *systab)
 {
 	struct efi_loaded_image *loaded_image;
+	struct efi_mem_desc *map;
 	efi_status_t ret;
+	efi_uintn_t map_size;
+	efi_uintn_t map_key;
+	efi_uintn_t desc_size;
+	u32 desc_version;
 
 	systable = systab;
 	boottime = systable->boottime;
@@ -48,6 +53,29 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
 	con_out->output_string(con_out, u"U-Boot test app for EFI_LOADER\r\n");
 
 out:
+	map_size = 0;
+	ret = boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
+				       &desc_version);
+	if (ret != EFI_BUFFER_TOO_SMALL) {
+		con_out->output_string(con_out, u"map error A\n");
+		return ret;
+	}
+
+	ret = boottime->allocate_pool(EFI_BOOT_SERVICES_DATA, map_size,
+				      (void **)&map);
+	if (ret) {
+		con_out->output_string(con_out, u"map error B\n");
+		return ret;
+	}
+	/* Allocate extra space for newly allocated memory */
+	map_size += sizeof(struct efi_mem_desc);
+	ret = boottime->get_memory_map(&map_size, map, &map_key, &desc_size,
+				       &desc_version);
+	if (ret) {
+		con_out->output_string(con_out, u"map error C\n");
+		return ret;
+	}
+
 	con_out->output_string(con_out, u"Exiting test app\n");
 	ret = boottime->exit(handle, ret, 0, NULL);
 
-- 
2.34.1

