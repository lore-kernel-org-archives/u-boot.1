Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AAFE77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 18:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B2F480422;
	Thu,  2 Jan 2025 19:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="B/oCFyjD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A995680196; Thu,  2 Jan 2025 19:11:53 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D53803C6
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 19:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 43E363FA64
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 18:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735841511;
 bh=Zb0TlDD+4OHyxip71NaNMKlTtwoIxXJoj0Ts2Qfp0vM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=B/oCFyjD49QaNK2pSa3esHNMfdfYKAJfk4nc+5yUai6UrJsj9p8LDHc+yQpqcwYZf
 MFuZvpFpgN0Wn8YXRDmF/chTiQVuPVPIUJVUyFbJq5dt4zFo8C9g/UTipX/cnYL541
 kO2qgiueTHp7b0ie6aa2xNkft5gkam/AXw6BI7rOnMYer/CzBtJy/6pIzViUM1jyWf
 xFKQe9sEytoP4Uf9wFSq3kcPmDoqLD6ditOYpMXUmx4KbA9kArWYw2/0VPeli9p3p0
 A3ogNkwdauQtTkZHRHrMzArWwSPFmKMik2n6fkHDn9yfDt/3ei4ux7/FCm0dq2WsXo
 F19zJimI6yzpA==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385d6ee042eso6553640f8f.0
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 10:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841511; x=1736446311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zb0TlDD+4OHyxip71NaNMKlTtwoIxXJoj0Ts2Qfp0vM=;
 b=J65v+rb07TSCxBh/hKrpE+GaDU4LiDepCfBEbz+xLVr4mBeZ8jmpweKneYvEMbeNVA
 ccH9uVIcV924YWtsG+HC+luSUOxMQtN6NyubNwLwHDEkyghwtHLRMcOUYAiPYDrSh0ep
 JLHo54sA8wNrFLlmZsFGASzOx6hAxqP42NbplR0W3Buo7z3K8cOQ4DGKlH7AlwOfLXKc
 QgoBcAMI5kpLR0v3058wGfpF+USN2aMI72MdyGRzogTa8Ny2rI3Upk4/+BFzOAPhIbVR
 h6oFjOXhpUTQlKs2PGXX70gbC0OVuA/ehraCKxa63b347UFOiZqsEuQK+zTSYt4uEx7i
 ahXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGGn/rdUg/U3rH6tqx2NAZmxAQsQ6EP6nR3J4kKq5KdKsiHoEvS+u3yofTOhbJ99UxWnBkmK4=@lists.denx.de
X-Gm-Message-State: AOJu0YwR7krcEkcVwALjhC7D9V0kIx7cEctwNlpXahxyedTCjlt0NnAn
 SgzPZ7Ynab5qIRgO4M3xWhXq9vj8LqeCw9l0zpQwuNG3qMxh2nYi6tWkc7M3tHb3gG955xpNRaQ
 T2TvjvLxMNgpRhwS8DijTUf7wfPTwFBs+6HLvOQDKRmiEU5F6++/YnuXbkmMg6Ce/FXA=
X-Gm-Gg: ASbGncv6Gf6MJGbQa8EufFSZAmYvp1xexMKoqcjN+mKblYQCx3hFveclB++Ugbcb/r4
 XfFFzQelgKmF5gDf1YK2KscK9LJPgJ6xp8fhUXcVktj7TZE5RhkigQt8W+dCE54ApUOqoxkXm69
 PN/h7h2GxMYpo/D7acNwEzLAFSLhLn0rqRHl2rpd+SmYLpk/yaLYqLf7MBzFcwn8jMONvYYFrev
 lYn9ngCIHkmj2Du/+cX7xECSrqsjrp0jl5Bidotbmx3JmBSxb3ua6He5WDPb5bDAd9G3kJXLchd
 DEVW5HLVGyGEsg==
X-Received: by 2002:a05:6000:18a4:b0:38a:5122:5a10 with SMTP id
 ffacd0b85a97d-38a54452f1amr14077515f8f.15.1735841510861; 
 Thu, 02 Jan 2025 10:11:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhMWn7/NT+02+c1WayRq5fDY6L1Z2U5Tn9vwu3WPAOAMVbOu+MOKAu5htblPrfiQ2CMYJqRw==
X-Received: by 2002:a05:6000:18a4:b0:38a:5122:5a10 with SMTP id
 ffacd0b85a97d-38a54452f1amr14077500f8f.15.1735841510447; 
 Thu, 02 Jan 2025 10:11:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:2b1b:688c:df4:9c06:702e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6aeesm496278155e9.6.2025.01.02.10.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:11:49 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/4] efi_loader: print image load address in StartImage
Date: Thu,  2 Jan 2025 19:11:33 +0100
Message-ID: <20250102181133.378867-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
References: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
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

When starting image add the image load address to the debug output.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_boottime.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 080e7f78ae3..bc0cbd96e74 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -3194,7 +3194,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
 	struct efi_loaded_image_obj *image_obj =
 		(struct efi_loaded_image_obj *)image_handle;
 	efi_status_t ret;
-	void *info;
+	struct efi_loaded_image *info;
 	efi_handle_t parent_image = current_image;
 	efi_status_t exit_status;
 	struct jmp_buf_data exit_jmp;
@@ -3212,7 +3212,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
 		return EFI_EXIT(EFI_SECURITY_VIOLATION);
 
 	ret = EFI_CALL(efi_open_protocol(image_handle, &efi_guid_loaded_image,
-					 &info, NULL, NULL,
+					 (void **)&info, NULL, NULL,
 					 EFI_OPEN_PROTOCOL_GET_PROTOCOL));
 	if (ret != EFI_SUCCESS)
 		return EFI_EXIT(EFI_INVALID_PARAMETER);
@@ -3266,7 +3266,8 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
 
 	current_image = image_handle;
 	image_obj->header.type = EFI_OBJECT_TYPE_STARTED_IMAGE;
-	EFI_PRINT("Jumping into 0x%p\n", image_obj->entry);
+	EFI_PRINT("Starting image loaded at 0x%p, entry point 0x%p\n",
+		  info->image_base, image_obj->entry);
 	ret = EFI_CALL(image_obj->entry(image_handle, &systab));
 
 	/*
-- 
2.47.1

