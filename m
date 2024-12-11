Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919EEE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 314DA80209;
	Wed, 11 Dec 2024 14:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G1dD7M+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 312E380241; Wed, 11 Dec 2024 14:54:36 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56134801CE
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-8418ecda128so360945539f.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925271; x=1734530071; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBFMHBZ0/4I19dbzmmgaNQwB48g9Lbbzm+PTh9wKguw=;
 b=G1dD7M+0ZbfOX/Ex8fm6ghLMdJ7g+yDvyYiBgel0BkbhQW0yEJM7MIv7//jNBP7Cx6
 anY6PkYcwDPP0j2buOU37RHb+TxVKCbgbRh+nx5E/YiNconAfo8hBAl1ligV4rSXq9Ba
 5hquwDYnOdPsi0p717VMp+JhdiwloQOuC8TO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925271; x=1734530071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TBFMHBZ0/4I19dbzmmgaNQwB48g9Lbbzm+PTh9wKguw=;
 b=VvKDkVUTkuN/jXTfI4c4+x4j+Py/qBb2z8ahcrqT90FKAM7PlzMEdBFws3CdlZkR75
 kS6V51TDQYRbSP8on0B1VvTxboFMjJ82CN42ycyYo0N5vZqepfG7CgJt7caHuF4TlK3u
 Xk/S+llY9pUXsYps/c1V617Sc6fZ3Oy1jYgouqD5Mi2o/Thf1a3YiaTGOvrLeU5VPjBN
 sYW1avtDD/Q9hzENfsgR5o4+7pLRFyPT5mmOLzptGixCezWuqBUfbQWmuHSpw3uAQxDX
 BAfW+zhskAFFcWGytu6ziehpd5KWW64OAIRMdUPlb03KhhRa73vZk9JW17HDFvqDfwTj
 ifNg==
X-Gm-Message-State: AOJu0YyKqM/hvOwHhe0ZNEqDvvOnkcHYM1oVMWGADMcGq+sV88RZ81Zg
 WCerNE56BdPD9Sur1tQN3RWuzFbrDtgDBEQkSjWBUOuvQKjsyYbEYU6ha1dUyY6xCyslJuIfdw4
 =
X-Gm-Gg: ASbGncvRGTEyQx1ZqTKOQ/FsEzzI4e5y++pfkTil9B20ebeZbJIydy46VdSe/YyzDvi
 NPjFrUNd50H9xpsSpD2KZdWyVHiiN+a0DxtRc3VPosGD6TuKI0hF9deSdv6/oYcBfR9FIAD/kFO
 pfJsTRYt93NhoAPAEUbgpB3FahiNW8Pa9Yz0dmyw5f3KQKoaiok9dtf8k22LOzU51plNrsg6cqi
 p+ndfV7lPNHJIVE2qIdy/K/JyAzzycuNYufKJZ5RIt2meS+2aH4NZUWfjc+vFJwiE2I/lyQjfUv
 WwHXTgwcawaVXoU=
X-Google-Smtp-Source: AGHT+IHYFCtyf7cpE/0UTecmROtDEuHZaGvZgDFei2iIfJUoCZ74JY8WuZTSmxZy45K6zOeTCMXVlQ==
X-Received: by 2002:a05:6e02:1a8a:b0:3a7:7ad4:fe78 with SMTP id
 e9e14a558f8ab-3aa08f65d7bmr36593875ab.19.1733925271522; 
 Wed, 11 Dec 2024 05:54:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Janne Grunau <j@jannau.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 04/23] efi_loader: Show the resulting memory address from
 an alloc
Date: Wed, 11 Dec 2024 06:53:58 -0700
Message-Id: <20241211135418.563803-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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

Update efi_allocate_pool_ext() to log the pointer returned from this
call, which can be helpful when debugging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Show the returned address rather than the pointer

Changes in v2:
- Use EFI_PRINT() instead of log_debug()

 lib/efi_loader/efi_boottime.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 080e7f78ae3..f27b3827ed2 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -13,6 +13,7 @@
 #include <irq_func.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <pe.h>
 #include <time.h>
 #include <u-boot/crc.h>
@@ -511,6 +512,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int pool_type,
 
 	EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
 	r = efi_allocate_pool(pool_type, size, buffer);
+	if (r == EFI_SUCCESS)
+		EFI_PRINT("*buffer = %llx\n", (u64)map_to_sysmem(*buffer));
+
 	return EFI_EXIT(r);
 }
 
-- 
2.34.1

