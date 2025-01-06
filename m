Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992EDE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC0A805E9;
	Mon,  6 Jan 2025 15:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bLsSLZeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C6638056D; Mon,  6 Jan 2025 15:48:16 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35D02805FA
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3cdd57060acso8552535ab.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174892; x=1736779692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U91qEydEiuJHTlNqYGXgRhTRf3u8AipOZ/fcJiJAW54=;
 b=bLsSLZeBWk/q/a2NsFWpze5Ox6NzZ0NLQufFEFKWxuw3Ix4yk73eTy8/Vk/4npDZFE
 wxLkNJ4BWexf0UhvZLY1aUnZTFybPdoUoYzcTsmPCjSmgXzo/Ahp70RorVVDxlkV4h2p
 1CxPiTcFZpGi3QUjGVv6FKp9uPmwFIKlMqjG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174892; x=1736779692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U91qEydEiuJHTlNqYGXgRhTRf3u8AipOZ/fcJiJAW54=;
 b=UCkczWy0CE2kRlIu3KjZg2BuYt/NVpsyjHlGtFW1Blg0rGY3/Xtgp+x0LSfuNBKJlc
 hmMEfW0kbT8FrooRxzl7cXYpBjKbqjJGz539i3szbltC1Z6pDvRPJEfKO+Cs2gu+ziut
 NL+/lKZv6Ulo/TyGoRNr3lxxZ0dv+f84jTYfEwAYfMH2I/Vn1SKC/2ynRmVharRmV3w2
 eaj5nNJs5ABGcjKF6mKC7L8+hGy234fYdGuS8jBns80DlFFdfWnnne9CqOWNdrF+ntv5
 YnNYcP2kXGl/BuxOdjqZY70ij9FE4J8c7G5RFsA/cekxBiTJwsul4nPi0e62RyRqZV0B
 viyQ==
X-Gm-Message-State: AOJu0Yw552yQWhb6uwrfDmS5cDvoTCP7XVvtsm67SKWBlUJkdJTY18JB
 wsiUKRxD6m0aP+A+xbJ4aa/HNFFkCYyosX7XviNNdSxGL85x72AwAR5nP/XJ6Ftc++9/S3qBch0
 =
X-Gm-Gg: ASbGncuCfxmRc5laBSqWlmZYZaPwz4tAwLrpmRFvxz8qiq9GVH9n7SWYMFmMxDRXDz1
 mfUfofVXic+m4xa6ye2H87nSHV7SMyd5kQSwGt1sPjAaRIQTV4FKnkJB7wRxaGTdUvVR8cusgPx
 Csqu3bV+40rZN89QZBN6ESKfDVTSGHT5e4oIcOgTyWmSvknpYL5V0sQqrZSRe1bkg9RJLN5Ct8/
 tbHOYds1pzx7xejlupwlwSIVvr7PKmjK3wGAj2vQxFbzPx8RP9rC5lrt+WyEyxEkBD1Pp7lV38X
 oNrDmAcku3DXdC/Fjw==
X-Google-Smtp-Source: AGHT+IEdJ8GPSnXdiM4CP0nnRdXfnzFmq/Fj+SplR8NtRVhm+eHfY8XliDbttLL4xQPRQM4d2QcqWQ==
X-Received: by 2002:a05:6e02:b42:b0:3a7:e67f:3c58 with SMTP id
 e9e14a558f8ab-3c2d1aa2b80mr495868545ab.3.1736174892344; 
 Mon, 06 Jan 2025 06:48:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c37bb139a0sm94081185ab.70.2025.01.06.06.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:48:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/8] efi_loader: Correct bounce-buffer setup
Date: Mon,  6 Jan 2025 07:47:51 -0700
Message-Id: <20250106144755.3054780-5-sjg@chromium.org>
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

This should set the bounce buffer to a pointer, not an address. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 2e197e94edd..9374f77d3b7 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -837,11 +837,11 @@ int efi_memory_init(void)
 	uint64_t efi_bounce_buffer_addr = 0xffffffff;
 
 	if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
-			       (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
+			       SZ_64M >> EFI_PAGE_SHIFT,
 			       &efi_bounce_buffer_addr) != EFI_SUCCESS)
 		return -1;
 
-	efi_bounce_buffer = (void*)(uintptr_t)efi_bounce_buffer_addr;
+	efi_bounce_buffer = map_sysmem(efi_bounce_buffer_addr, SZ_64M);
 #endif
 
 	return 0;
-- 
2.34.1

