Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7051CC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A066C8772E;
	Wed, 29 Nov 2023 18:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cfQws4fA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BE8875F5; Wed, 29 Nov 2023 18:22:53 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D507987637
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35cb3aa25e4so14292585ab.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701278569; x=1701883369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Y4u1Nj+AksGSx6UaBsaN0nYrI4rh/YV1H5l1JuASz8=;
 b=cfQws4fAJ22mP5ITtpiktWJbrChtArpDSe8OeGbo1pdFY1GQtIaj3vQgUOYmAjYy+c
 oPL73see0k+8s0oBPe1ITNIeTeaoC0uSPKzMJwLTeN361pLXE0gRNQRON74pQt/UySfP
 1eWzEzmyMMeUIbzZwGzRneNxSQ8xl0kLeqyME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701278569; x=1701883369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Y4u1Nj+AksGSx6UaBsaN0nYrI4rh/YV1H5l1JuASz8=;
 b=diPWYKvsnInrNeaUB9YZbhCqug3KAz7x8EDbU6JcEo1jUrj4lPYxjKapP/rTER162c
 FT9ay0wmYXWqlHbcdMgFMCV34uxyerTp3KcRAXAiHas9WvLrU0pkqIfrKZzRQOVIVQ1r
 GRo3WBvx2wVYCDxMAmHwHoQqwZvKUBfcSPeOQG3mZIq4JoxYK+zD67Df8dWgLDx1VC/k
 1evsLMHLj6Tff+5Hqh9jnHMA3A14qlLVgCoGiiSUs5QOZbwDu7OX4OjPuvhoi/vjV3ub
 qQaK71O/mOUxnfdgDIjHN9xgBHQRZfiIwJh2WacMx5blua3tHoAT1K4aiZW/Sd3aiWzd
 PWrQ==
X-Gm-Message-State: AOJu0YwU0Hem5P5U06qD49yaLlW4pTVi6Yz6/xyOT2BdK/KRwIjMxxUb
 f7aTShCmyBq1FcQ8Wz5q75gEUQ==
X-Google-Smtp-Source: AGHT+IGoKYqPmZAGwWLDW7tQod2JEp4OUoLYANKOnDLWolFNogzs1E68dUptxIsNKOqzFj5oWiR7Qw==
X-Received: by 2002:a92:cc49:0:b0:35c:8738:7e52 with SMTP id
 t9-20020a92cc49000000b0035c87387e52mr17451545ilq.4.1701278569521; 
 Wed, 29 Nov 2023 09:22:49 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:f4fd:5056:45a8:b749])
 by smtp.gmail.com with ESMTPSA id
 di5-20020a056e021f8500b0035d2fc4ce47sm471212ilb.9.2023.11.29.09.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 09:22:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 lkml <linux-kernel@vger.kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v7 1/2] arm64: Add BOOT_TARGETS variable
Date: Wed, 29 Nov 2023 10:21:52 -0700
Message-ID: <20231129172200.430674-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231129172200.430674-1-sjg@chromium.org>
References: <20231129172200.430674-1-sjg@chromium.org>
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

Changes in v7:
- Drop the kbuild tag

Changes in v6:
- Drop the unwanted .gz suffix

 arch/arm64/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 9a2d3723cd0f..1bd4fae6e806 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -150,6 +150,10 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 
+BOOT_TARGETS	:= Image vmlinuz.efi
+
+PHONY += $(BOOT_TARGETS)
+
 ifeq ($(CONFIG_EFI_ZBOOT),)
 KBUILD_IMAGE	:= $(boot)/Image.gz
 else
@@ -159,7 +163,7 @@ endif
 all:	$(notdir $(KBUILD_IMAGE))
 
 vmlinuz.efi: Image
-Image vmlinuz.efi: vmlinux
+$(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 Image.%: Image
-- 
2.43.0.rc2.451.g8631bc7472-goog

