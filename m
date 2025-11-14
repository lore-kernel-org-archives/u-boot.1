Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B3ACE7A9B
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 09:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B63983FA3;
	Fri, 14 Nov 2025 10:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oCaNIDeI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E43C283F3F; Fri, 14 Nov 2025 10:32:56 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C41AC83F20
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 10:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7B4003FC9F
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763112773;
 bh=SaJW74Qa1YX/SzjT0DTae2ZDsUzMMBgGm5o69cdgE/Q=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=oCaNIDeIW/dYI0oV08bf4B0lhHmWN7xCrs5Qah17lD8BBSldKVXbtJFpii8W36wPn
 SPtzggNsQpFUsUcIAWv074Z+XokcDQXmPdOmQOnMDew5Gwe3zYFUURPzlPOW81yTww
 W93tcoMiw7La+MR/moM99RYKa6iCTidy+eOdZJlJWbCJKRNqvXlJ1/BbVwUm9eXuwH
 cY6RiDp/ro4FtYjdfyda5KIWA5MJhqwQZjU0BfK+gwJ7eCWCEyIwUE2OOJWiFxWh/X
 x+QJQbbYIW1vc5kOALQQyJ+CBSNcfuvyi9L8uEvEMu+H0c7nr3ObwXl0zOOWT1uIuG
 pYIEcYlQLmTB8Xia/fmLEEMglLPtTlu4RLjNXG3a+eEbtclfTX3xQ8iM5VlZbunOEB
 MIOAphbQzqZPZ9qACs+Ktv7Ce8xH+zWNnucdeU6kasPcaRQD0WLqrxJ5ulxLWErFoM
 P1T3DmkyPUScRzfTJWAu+VJEbBq7kf2OrnUz0rD1gK1i0ICn41AHnomCtfR2d5XHUr
 Tz+oY9nhHq67gEu5yO4nEPlFwJHyfh3AkfTa7MvkNvNOKQSAaw+8BN0M7HQOtXReuL
 KNsHqG7CmcwzogZ56Ps2dqCIWGLlsb8UOXQ4ei1WFCSlfuQk4r46vfyG/XwvVhkGJp
 tFbWwj/vxr4Ootj2nFEWA/to=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4777a022d1fso15509535e9.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 01:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763112772; x=1763717572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SaJW74Qa1YX/SzjT0DTae2ZDsUzMMBgGm5o69cdgE/Q=;
 b=XC8J1THGJhvRO0oJvev+yt1XwBTJ04L47IbSfMUnHvv2ax6pMEESwkpa08dddSlJ0G
 vxPG0AL5/mznv6+jPOQLnPy72Th4R5/OSR2F9qNog4AI4N0oApcwmASyHB3x7D3Xwa8b
 8Yw96jlBqiTBd1tg26rKsMxD+FC7z0s53xanFM02a8XGzZsdHq35hJ/450wwGQEPjrdU
 ooUWmq5Eg6fxyKdrWe5CtIyxBnk7am4p1NUs6Om2YEmQiVlMxkM7rTT87jgAv6xhuw6A
 zPlAkDeCpwr5XzbmZJHlf9XJILfXkRnZmU0X5SFdUZwgVVf7zKa1Op1SHZEiaPANcku2
 W1tA==
X-Gm-Message-State: AOJu0Yyv6mXyvp9ktMZxN2fCZd3qymrkk2/1cLfCqbtQ89/G7BigfEVY
 1TyQpaT1RzmiOzwVbBCalwi2nbBAQi+RoiUA7RQJA0oocHwfYVqPTnOgLOIax9dtcJasXGGOkiv
 0nJEK93ZVD+epizoDzx83zpJcy2hng+XTvX60safAD9QBDnWbCln/xi8YSRzLJYzGFx3HiNu8ot
 0yuv5BfQ==
X-Gm-Gg: ASbGnctxH9GLIiViWPxU7fRFEE8iTywiEKPJp0Y9HCb3Lygfp2wMpI8A6dobSDa0iRc
 Wm8X851i+x/tz1c5y/EbJFD301FwR31DRKI/UqVCNM6fBVXxkM41JnAmvZ1bCTsZNPz96jyNGLM
 cI5qoT4Qu3w3PA0YO4iuLtumzrVW7TYg4eIBy/EOSAxAySlYrWM88PJwXA7umu6lEg3w8BvAPhw
 B8Boht4YtB7SoNC7eULtCycVUbVy+Av3Xp07AKop/zr8HgsqL2GLBAAnYnbtmFuT7cy+bAwAp5C
 YAv7l1UvG5COXo4Ux3XoWKypA1K2XUGb1qK2NBbNChx3sbRcLQWFuqRa1YbGyeONu+fe67xrx8I
 7faJGwj3eF2flbZlhJjVw7ZesD07U/lJNnUAI77DWio24ohCI6h6d01QOnBc96r+Lmw==
X-Received: by 2002:a05:600c:4594:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-4778fe9a707mr20442025e9.22.1763112771970; 
 Fri, 14 Nov 2025 01:32:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqdQtEKgl025caCMCdnrZ18Boe51g/OQrlpwuLVexXi8L0Rm8HKToDxRd6U0xhIFjpqltTHg==
X-Received: by 2002:a05:600c:4594:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-4778fe9a707mr20441765e9.22.1763112771563; 
 Fri, 14 Nov 2025 01:32:51 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778c857311sm85462825e9.8.2025.11.14.01.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 01:32:51 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/7] efi_selftest: expose runtime table address
Date: Fri, 14 Nov 2025 10:32:40 +0100
Message-ID: <20251114093246.56422-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
References: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
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

Save the address of the EFI runtime as a global variable.
This allows to simplify the setup of tests.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_selftest.h          | 1 +
 lib/efi_selftest/efi_selftest.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/efi_selftest.h b/include/efi_selftest.h
index 1b708849bcb..4ee46cbbb66 100644
--- a/include/efi_selftest.h
+++ b/include/efi_selftest.h
@@ -19,6 +19,7 @@
 
 extern const struct efi_system_table *st_systable;
 extern const struct efi_boot_services *st_boottime;
+extern const struct efi_runtime_services *st_runtime;
 
 /**
  * efi_st_printf() - print a message
diff --git a/lib/efi_selftest/efi_selftest.c b/lib/efi_selftest/efi_selftest.c
index 191da7fc451..2b95713afb4 100644
--- a/lib/efi_selftest/efi_selftest.c
+++ b/lib/efi_selftest/efi_selftest.c
@@ -16,7 +16,7 @@
 
 const struct efi_system_table *st_systable;
 const struct efi_boot_services *st_boottime;
-static const struct efi_runtime_services *runtime;
+const struct efi_runtime_services *st_runtime;
 static efi_handle_t handle;
 static u16 reset_message[] = u"Selftest completed";
 static int *setup_status;
@@ -259,7 +259,7 @@ efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
 
 	st_systable = systab;
 	st_boottime = st_systable->boottime;
-	runtime = st_systable->runtime;
+	st_runtime = st_systable->runtime;
 	handle = image_handle;
 	con_out = st_systable->con_out;
 	con_in = st_systable->con_in;
@@ -347,8 +347,8 @@ efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
 	efi_st_get_key();
 
 	if (IS_ENABLED(CONFIG_EFI_HAVE_RUNTIME_RESET)) {
-		runtime->reset_system(EFI_RESET_WARM, EFI_NOT_READY,
-				      sizeof(reset_message), reset_message);
+		st_runtime->reset_system(EFI_RESET_WARM, EFI_NOT_READY,
+					 sizeof(reset_message), reset_message);
 	} else {
 		efi_restore_gd();
 		do_reset(NULL, 0, 0, NULL);
-- 
2.51.0

