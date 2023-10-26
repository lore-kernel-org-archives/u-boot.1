Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0E4C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 07:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5751C875B7;
	Thu, 26 Oct 2023 09:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="df6M061H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A245875BF; Thu, 26 Oct 2023 09:27:55 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DAC0875B8
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 09:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c8a1541232so4911495ad.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 00:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698305272; x=1698910072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5HROyknCuzezfPnKKu8GDq6Ak0A1oqAWU9OMPRzgBc=;
 b=df6M061HQRFlSgNTp5nvV3csad0v8hx3eYmC2u55Fj67td5uSdBY/jW2VFOR8QVw/n
 dPoqINavHb+FvhdtfqasAENXrhNNnW4mX9ygbuWlApTvQY2H/snCEBK27MQH1jAHLah4
 BZy8GE6geTn1SYCAwc1EJcY87mnJ0WLuQvsSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698305272; x=1698910072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5HROyknCuzezfPnKKu8GDq6Ak0A1oqAWU9OMPRzgBc=;
 b=snyo2BP9Hb3+cb6rnt4LWOcrAczdoGB1HUI9LAOMVlZ489xy1UgC5IDKgPd6CrNhfq
 8fI5MciNo1CQ0CD+zUedyZb8eCgJNyBq+M7FXRpNlRR1Oy0Opd3pBJ5H/75TpzH3pzCS
 V9DRao71XDU7cFFqnRj5cJbsD8aep6rUJrEfV7vJQBq/NnztbAENCKrp950bNBfCM2mK
 MLCxNLfboId6cnFX8/whAMcZK9KKU16IMM3fDQZ0hqHc5MQUt6/WWsDGhZR88Pc0F1hb
 Y6/OyKHB4xglLsx/mA6lBIhqzUjeC6hqa8cxcbkPmyjSB7pWy7nzOdcVSRclk/anTNYr
 2nmg==
X-Gm-Message-State: AOJu0YzxRE859nfeJSYSOwdQRZIyDrf9mfho4ak1xOUI4/X+hFDsFr6A
 1eI2ZK9wkMo6YYx/DPBzu4HYzQ==
X-Google-Smtp-Source: AGHT+IHLgMaOOEK4ReQTWHExwr7/eZYHbMKrsEkSXncJZod4bQAJS7bbZdeJ3aYm6Bj6VZxgH+W5gw==
X-Received: by 2002:a17:903:200d:b0:1ca:754a:692e with SMTP id
 s13-20020a170903200d00b001ca754a692emr15633418pla.30.1698305271862; 
 Thu, 26 Oct 2023 00:27:51 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a170902e55100b001b7cbc5871csm10294023plf.53.2023.10.26.00.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 00:27:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kbuild: arm64: Add BOOT_TARGETS variable
Date: Thu, 26 Oct 2023 20:26:24 +1300
Message-ID: <20231026072628.4115527-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231026072628.4115527-1-sjg@chromium.org>
References: <20231026072628.4115527-1-sjg@chromium.org>
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

Add a new variable containing a list of possible targets. Mark them as
phony. This matches the approach taken for arch/arm

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm64/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 4bd85cc0d32b..7b77b63e978f 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -150,6 +150,10 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 
+BOOT_TARGETS	:= Image.gz vmlinuz.efi
+
+PHONY += $(BOOT_TARGETS)
+
 ifeq ($(CONFIG_EFI_ZBOOT),)
 KBUILD_IMAGE	:= $(boot)/Image.gz
 else
@@ -159,7 +163,7 @@ endif
 all:	$(notdir $(KBUILD_IMAGE))
 
 
-Image vmlinuz.efi: vmlinux
+$(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 Image.%: Image
-- 
2.42.0.758.gaed0368e0e-goog

