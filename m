Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB1EC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 15:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BB0C86F15;
	Mon,  6 Nov 2023 16:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C3SzemIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3197A86F1A; Mon,  6 Nov 2023 16:48:04 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3630286E40
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 16:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c50fbc218bso57652681fa.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 07:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699285681; x=1699890481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8FMeOc09UyTURLTnAAxgSJtNbl0kM65QBwZWKZGXces=;
 b=C3SzemIWICPgBaGbN79CanETd+u0JKUETGM5EGWB8NUTL+GcjIqqplmglQqy1zF9qR
 PK8+tRskJ/fCWebtPmBYbko942YXxD+gDdmJvVT6xjuoGieBA6+XMWWjvXw1Uz4jVABF
 eR0k3vTcu09OLHjkarBBzXSGB1OxjSYvUJX/5DbUU+3ZagNvu/RXCr2mfJSh7ApLeb9Y
 Omkeeh+cQMAjlvjDjuEAfYrmIxD9BmU/3IwNp407ARWuuj4Sq8bWK8WIz8dOE0XVy8mF
 HvwSuRNDiq7GRV3AI9d4AwYF9+8aMNpmLIzpESOJRwIZjJ0rpuASt+HxnR1XYzCZi2WI
 OVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699285681; x=1699890481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8FMeOc09UyTURLTnAAxgSJtNbl0kM65QBwZWKZGXces=;
 b=kYT+EqGjLC+qj1cKRIVEWWaIEw0Hcr5sYYaJZyJUh+C8+8GGAoHbpcFFfjmzCVi7aR
 0lE45joRfE/3PhMjVGEbblLjXtn51GjTGX/p5/t1VuPZgUfRSRy3Nt4NF0pfBaSj48A7
 qoTtTIz79sZp1RB8KUgBj6RUV0jch1Cxka3a8utnVbInU5x9nEfTp1nOSTMmGOcGBc6N
 z8AIlCFV55rtSvf/8B0MqT3imKyrRoFFk2alc5mFQJKg3H6tygRpclvs5lgZ0CmQqe2G
 PAa7kAIaWki1tcy72HT06zoKT+SVBIvRV4eywoKWlq5MKGga/pi+PzWdRMoy9Iq8fGHT
 04gg==
X-Gm-Message-State: AOJu0YzcCynX/7d8jkeOFhzWfy6OyNRcdKxREQIytEahU/EVDSPjW62r
 Zy1rAfaCyTyoxONKihVJcQFV9c6RcWtMNdfsZZ8=
X-Google-Smtp-Source: AGHT+IFAQBnSWlyxEVN9QvvsFxlzdry6XecbVUdeUOo5ogTLomBKalpGjpdQ0mNltruNvtBXJwjtSg==
X-Received: by 2002:a2e:8048:0:b0:2c5:b87:39bc with SMTP id
 p8-20020a2e8048000000b002c50b8739bcmr23146998ljg.1.1699285681418; 
 Mon, 06 Nov 2023 07:48:01 -0800 (PST)
Received: from localhost.localdomain (ppp046103219117.access.hol.gr.
 [46.103.219.117]) by smtp.gmail.com with ESMTPSA id
 f16-20020a7bc8d0000000b0040684abb623sm12264744wml.24.2023.11.06.07.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:48:00 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de
Cc: alpernebiyasak@gmail.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] efi_loader: Increase default variable store size to 128K
Date: Mon,  6 Nov 2023 17:47:53 +0200
Message-Id: <20231106154754.59374-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
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

In commit 9fd3f881c6ed ("efi_loader: Increase default variable store size to 64KiB")
Alper has a detailed explanation of why the size needs to be bumped to at
least 64K.  However enabling Secure boot, writing db, KEK, PK etc keys
will further increase the size so bump it to 128K.

It's worth noting that when U-Boot stores the EFI variables in an RPMB the
available storage is defined statically in StandAloneMM at build time.
The U-Boot code is detecting the available true size on the fly during
writes. When StandAloneMM is present this size defines the reserved
memory U-Boot can use to copy any runtime variables, before booting an
OS.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/Kconfig | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 4ccd26f94a93..0d024911b42e 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -133,18 +133,20 @@ endif

 config EFI_VAR_BUF_SIZE
 	int "Memory size of the UEFI variable store"
-	default 16384 if EFI_MM_COMM_TEE
-	default 65536
+	default 131072
 	range 4096 2147483647
 	help
 	  This defines the size in bytes of the memory area reserved for keeping
 	  UEFI variables.

-	  When using StandAloneMM (CONFIG_EFI_MM_COMM_TEE=y) this value should
-	  match the value of PcdFlashNvStorageVariableSize used to compile the
-	  StandAloneMM module.
+	  When using StandAloneMM (CONFIG_EFI_MM_COMM_TEE=y) is used the
+	  available size for storing variables is defined in
+	  PcdFlashNvStorageVariableSize.
+	  That value is probed at runtime from U-Boot. In that case,
+	  EFI_VAR_BUF_SIZE represents the memory U-Boot reserves to present
+	  runtime variables to the OS.

-	  Minimum 4096, default 65536, or 16384 when using StandAloneMM.
+	  Minimum 4096, default 131072

 config EFI_GET_TIME
 	bool "GetTime() runtime service"
--
2.40.1

