Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BA8E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF11871FB;
	Mon,  2 Oct 2023 03:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AfJU+rVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4572F871AF; Mon,  2 Oct 2023 03:15:48 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D1687151
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-76c64da0e46so573879639f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209303; x=1696814103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5aGpZRTU1kLEYyHxYmVQaX5FSHURvc52aYAiQTdNqE=;
 b=AfJU+rVVwhk7DomeMueQAZASJ6OwKNobbbWKqEU2I6tzRNoTWE9apyzaPcmvM/c+l8
 u40W6RUgUJEDkMPD9/gSgUW8Ly4P0yhZCqEO75CAOfdSBRU5y9Q8JbAZe8K+ElbxYB2o
 6de7wvlX+FzVpRfLrxjvqX5SVWF9BAoadpYQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209303; x=1696814103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5aGpZRTU1kLEYyHxYmVQaX5FSHURvc52aYAiQTdNqE=;
 b=aGNxqvKmKPPDmRRV5m1aFIRpw3ATkwXQiqQH+bxTqC0rBQJiIxZDFSxzlxX0wQyJYg
 BaaokKjxW8vGT/IIAzqEqPhbzHtLvZJZ15vDW/xmUtRhCce78cKnd4qbbJ/W/DBIHSY+
 QW/QCOqQpsaL0KaosiT68ixvKzryAv/CbSMZ0RWxsNrZVZHM4RS8xomqFeu2qbzQn9z8
 6XxNxzo9QNMwwj6ExZNToalFS9keg0BZa8B7lDs0aHIJnv3AVCkTMffh+A5RY/SMqeQ3
 F1s2BIECIT3Ef+cH9yc44CObp86K+/i+SSXIxECNI9KUDxUXdzyLN59E2E2wwc4kGicP
 nXVQ==
X-Gm-Message-State: AOJu0Yz3Kll/OBRXD2xJIsXRaA0WsVIeXdH9CrR2KEWgfqD9bOwD66CC
 k3hrscE+d0T1aN1tViR8xSurAU4fm+brVOZtN7g=
X-Google-Smtp-Source: AGHT+IGBF2Leus+6SIPXTNtGVKmUz32ge+Rd8EoWlX5Any/w7ouR9vfVFOZ89S6kWVK3e6oPVI3R8w==
X-Received: by 2002:a05:6e02:1bc7:b0:34f:7e1b:a7a2 with SMTP id
 x7-20020a056e021bc700b0034f7e1ba7a2mr12877025ilv.13.1696209303152; 
 Sun, 01 Oct 2023 18:15:03 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6522951jam.177.2023.10.01.18.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:15:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 09/12] x86: Enable SSE in 64-bit mode
Date: Sun,  1 Oct 2023 19:14:44 -0600
Message-ID: <20231002011450.462468-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011450.462468-1-sjg@chromium.org>
References: <20231002011450.462468-1-sjg@chromium.org>
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

This is needed to support Truetype fonts. In any case, the compiler
expects SSE to be available in 64-bit mode. Enable it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v1)

 arch/x86/config.mk        |  1 -
 arch/x86/cpu/x86_64/cpu.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/config.mk b/arch/x86/config.mk
index 26ec1af2f0b0..b038b132985a 100644
--- a/arch/x86/config.mk
+++ b/arch/x86/config.mk
@@ -27,7 +27,6 @@ ifeq ($(IS_32BIT),y)
 PLATFORM_CPPFLAGS += -march=i386 -m32
 else
 PLATFORM_CPPFLAGS += $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-common -march=core2 -m64
-PLATFORM_CPPFLAGS += -mno-mmx -mno-sse
 endif
 
 PLATFORM_RELFLAGS += -fdata-sections -ffunction-sections -fvisibility=hidden
diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
index 2647bff891f8..54dc31bf6b71 100644
--- a/arch/x86/cpu/x86_64/cpu.c
+++ b/arch/x86/cpu/x86_64/cpu.c
@@ -10,6 +10,7 @@
 #include <init.h>
 #include <asm/cpu.h>
 #include <asm/global_data.h>
+#include <asm/processor-flags.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -39,11 +40,21 @@ int x86_mp_init(void)
 	return 0;
 }
 
+/* enable SSE features */
+static void setup_cpu_features(void)
+{
+	asm ("mov %%cr4, %%rax\n" \
+	"or  %0, %%rax\n" \
+	"mov %%rax, %%cr4\n" \
+	: : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "eax");
+}
+
 int x86_cpu_reinit_f(void)
 {
 	/* set the vendor to Intel so that native_calibrate_tsc() works */
 	gd->arch.x86_vendor = X86_VENDOR_INTEL;
 	gd->arch.has_mtrr = true;
+	setup_cpu_features();
 
 	return 0;
 }
-- 
2.42.0.582.g8ccd20d70d-goog

