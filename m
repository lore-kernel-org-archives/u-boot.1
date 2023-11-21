Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE70C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 11:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 487938759E;
	Tue, 21 Nov 2023 12:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YVbqca75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C060287581; Tue, 21 Nov 2023 12:36:12 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7AC4875A2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7a67f447bf0so214586239f.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700566568; x=1701171368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dB/vG1X4+Ly+6sHdNUNJSb6d66cX5fxIJ0GmIdbR/ZQ=;
 b=YVbqca750yxrjWNoqdZSMTCWI4jT6RKcPJV57mqBaogII9bBeyMNB+i+Nd/Whbk0ff
 AKQ0biwSF4xkv/5DJ8g+RPh+SkswGpe615cXA9ol/fsa5G8SawTq1VbHyd1WFKOU8mxi
 TWKQrR3z5Jwv1A3h/pTBsmMMI7Bm7p54sllDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700566568; x=1701171368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dB/vG1X4+Ly+6sHdNUNJSb6d66cX5fxIJ0GmIdbR/ZQ=;
 b=CI+ELtdCtBUey5mAovnxndmRxF66WeFa6ptm8Aon8x/uK/wxRygOxnLszf/sBDKjgT
 LulSJJKw+BeI8ueFggf9DmjX1PV2gVkIm8DXqqt6yC+QC7kYkLIBNWmQavEylrfX8/90
 1eItxRncvULjnuv8I1FDfBTHnDps9ICwvqRllNcs2gUVHQFrw59iTb/mUGvtIbFSCAUj
 fNfR0Ek4qEf7vHkeXrqGlbyjliUFtx2P96nYIoYy9OsL4D5uNNr5Pc1Ig/qdgsdpnB16
 CmA08vb5oU4ZHEDXxSlxMfvgzu8etPxetYpbXhVEYeeTbv0Wgz9eYoFpN8uoBC55ljNW
 OICg==
X-Gm-Message-State: AOJu0YzUBlS6pFYoawf3vRMLKyWrKRCj5THYOTb/zsr+AkWAwFDWZtcI
 VrjQD3lKeV4ivwMTyR1Ggua/kIUYlNk099xQfhzXfA==
X-Google-Smtp-Source: AGHT+IFVH1Zh7d5CzIlqzEjACiDMUpBXCIgCcx9SCN/y53GVQ8dQJIE758Zrnc9ifIatdMVyKymTSg==
X-Received: by 2002:a5d:9389:0:b0:7ab:ec1f:f4a2 with SMTP id
 c9-20020a5d9389000000b007abec1ff4a2mr4863491iol.8.1700566568497; 
 Tue, 21 Nov 2023 03:36:08 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a0566380f8a00b0045bb982a3d2sm2559190jal.60.2023.11.21.03.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 03:36:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 6/7] WIP: efi: Allow helloworld to exit boot services
Date: Tue, 21 Nov 2023 04:35:52 -0700
Message-ID: <20231121113557.800353-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121113557.800353-1-sjg@chromium.org>
References: <20231121113557.800353-1-sjg@chromium.org>
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

This allows testing of the exit_boot_services call, providing more
coverage of the EFI bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/helloworld.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
index 1135d3a3c37e..1fb5fb5a62f2 100644
--- a/lib/efi_loader/helloworld.c
+++ b/lib/efi_loader/helloworld.c
@@ -206,6 +206,26 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
 			(con_out, u"Cannot open loaded image protocol\r\n");
 		goto out;
 	}
+
+	{
+		ulong ptr = (ulong)loaded_image;
+		u16 str[80];
+		int i;
+
+		for (i = 0; i < 8; i++) {
+			uint digit = (ptr >> ((7 - i) * 4)) & 0xf;
+
+			if (digit > 9)
+				digit = 'a' + digit - 10;
+			else
+				digit += '0';
+			str[i] = digit;
+		}
+		str[i] = 0;
+		con_out->output_string(con_out, str);
+		con_out->output_string(con_out, u"\n");
+	}
+
 	print_load_options(loaded_image);
 
 	/* Get the device path to text protocol */
@@ -243,7 +263,21 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
 		goto out;
 
 out:
-	boottime->exit(handle, ret, 0, NULL);
+	/*
+	 * TODO: Use vendor string to decide whether to call exit-boot-services
+	 */
+	efi_uintn_t map_size = 0;
+	efi_uintn_t map_key;
+	efi_uintn_t desc_size;
+	u32 desc_version;
+
+	ret = boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
+				       &desc_version);
+	con_out->output_string(con_out, u"Exiting boot sevices\n");
+
+	boottime->exit_boot_services(handle, map_key);
+
+	ret = boottime->exit(handle, ret, 0, NULL);
 
 	/* We should never arrive here */
 	return ret;
-- 
2.43.0.rc1.413.gea7ed67945-goog

