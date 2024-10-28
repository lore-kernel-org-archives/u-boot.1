Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C263DD1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A04B389189;
	Mon, 28 Oct 2024 13:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OUTn5UAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D8878916E; Mon, 28 Oct 2024 13:48:46 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76F4289126
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so61291591fa.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119722; x=1730724522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmSwrjGTB012+WUMJLfr9GyArndIq+4WG/tNC+AKh7I=;
 b=OUTn5UAi5RY9otx5Gs+ubEGLsj0LThYOwtdLkVroPIdtOc0tBTktSD/z3BRuTxybBN
 b9LR4AbpUpMJxfZ6uMoX6EQOY9VWm/Gl2AqrsupKx1o4MuNEbCLxN1qm00Mh0Gjdyqq8
 2rpFcYbu2u6S4MP59/kGJfAPMyoCEHJaUWZhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119722; x=1730724522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XmSwrjGTB012+WUMJLfr9GyArndIq+4WG/tNC+AKh7I=;
 b=nVymfQUEkl20zJnFVqECkj57qeshirqekMBZ5URra0QeVkmpnYDfF86pQvzSxXD0Z7
 RHgn5eR93erPiU8c5fwmAHFJfCpazCCZVSUpD852nK2P3yV392Cu3JwwMIhDRTm+41Pt
 8ufOJsGL0GKZUEIFK+ZQjmoVeaxLwQz92pJnETS9JCj/R1EMtURTbQ6hSPi9pDXfdwIp
 wUuL/cEyaOeTky3tKM35shu8hOZm2M5HPzWYUV0B7CjvKnjc66GdCR3uiTKmUY1u55Gm
 VJdebpsSc7JcLcnnzkgpK8JrHpbLYSLlXLs5GqAJ7MsBcWCzA/8CsonQIO5mex3QvK7j
 gIiQ==
X-Gm-Message-State: AOJu0YxTAbxPe46zPDhvwvYErBhdJhdesautDUmFtU6SC5lQ00lm0Ujk
 M8vkGPdnAeL0IsmSZoPVyXKvBdmhQ41OAkD4+3oBl9E88TLJMF2On3jQ+tCjgG6Oh9vEIXK9sLk
 5ew==
X-Google-Smtp-Source: AGHT+IExI1OVoUNf+vtY0KqBP3UZ2IVrJX14ilOv8b/dAYnVPwnm9e8Jk3UWfBSlM4mVBVsLAsK3MA==
X-Received: by 2002:a05:651c:221e:b0:2fb:3df8:6a8c with SMTP id
 38308e7fff4ca-2fcbdfc705emr51375081fa.23.1730119721943; 
 Mon, 28 Oct 2024 05:48:41 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH 11/15] efi_loader: Create the log on startup
Date: Mon, 28 Oct 2024 13:48:02 +0100
Message-ID: <20241028124815.47262-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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

Create an EFI log when the EFI subsystem is first touched. This happens
after relocation in board_init_f()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_setup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index aa59bc7779d..468156db813 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -8,6 +8,7 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <efi_loader.h>
+#include <efi_log.h>
 #include <efi_variable.h>
 #include <log.h>
 #include <asm-generic/unaligned.h>
@@ -186,6 +187,12 @@ int efi_init_early(void)
 	/* Allow unaligned memory access */
 	allow_unaligned();
 
+	if (IS_ENABLED(CONFIG_EFI_LOG)) {
+		ret = efi_log_init();
+		if (ret)
+			return -ENOSPC;
+	}
+
 	/* Initialize root node */
 	ret = efi_root_node_register();
 	if (ret != EFI_SUCCESS)
-- 
2.43.0

