Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1582C4167D
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 00:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1334B87854;
	Sat, 11 Nov 2023 01:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n3T4zVvq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 369068713D; Sat, 11 Nov 2023 01:29:36 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3908B87849
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 01:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-677a0ac3797so7235876d6.1
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 16:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699662573; x=1700267373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=et5CNEbbpEZc7/GZDGct9Q6Ku2JLjZggspOXrOUtq84=;
 b=n3T4zVvqwgRKh0ULltZU0toOcIe06MTVsgbb27nKA6hIr7VZBc2Q+REYU7UBA3LdqE
 J2Tjo2BQ/6/Hd2g7XfpkTVU1dc/rMYgwRjFI7QY1Ibo8byDjLWFUq2+UEOmipP71eY10
 V/ngpV5bRBPaVbX6a2nFOmFy/cw+7mABommZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699662573; x=1700267373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=et5CNEbbpEZc7/GZDGct9Q6Ku2JLjZggspOXrOUtq84=;
 b=Pl23E7kZOolixCop1zELw7hiH5bPd+f+PfU57xoexjoOWR9S7SBv5WA66M1FnAl593
 bzDB7xxDutT3oZX7KZ8BD7feAS8qYvP2k3Ycn6pgKebZdJqUM2rJ6YUVgQKQeHjHAl2A
 /oDOD64L1emJWh8oPBG2QpuDMJbzA9PVobomUraMXOFDv5Lx+F5xefubzaHeqtRFjvp4
 CzEtWYp/EOQ88rORAxfzAG2PeCr75l9AwahiU/M+poZ9M2VdAkf6zVPJH6UKaPWw51dY
 JpZhupGrrmQ/fA8vLVMfUvhn5PkoO4KsZcOVrWc4dJcAYrz11CnsYXJpDZQJB0K+zEWi
 z+pw==
X-Gm-Message-State: AOJu0Yw5fk0GTI9jVzmRmfT47TpwfAAnFNYeFeN0fkmCeQchyig0y+vQ
 D6TODnccahtRZOSO1eD7AwTpfw==
X-Google-Smtp-Source: AGHT+IEN8beePUf5tFQkONDRQomBUyxK3TsSyakryn92MhWDO9HPDNzsR0zDFHQT0xvjn7EW56ku0Q==
X-Received: by 2002:ad4:45b4:0:b0:658:1eec:408a with SMTP id
 y20-20020ad445b4000000b006581eec408amr734218qvu.40.1699662573056; 
 Fri, 10 Nov 2023 16:29:33 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5104:5a27:f95d:21d1])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a056214029000b00677adcfd261sm55898qvv.89.2023.11.10.16.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 16:29:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: lkml <linux-kernel@vger.kernel.org>, Tom Rini <trini@konsulko.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v5 1/3] kbuild: arm64: Add BOOT_TARGETS variable
Date: Fri, 10 Nov 2023 17:28:00 -0700
Message-ID: <20231111002851.1293891-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231111002851.1293891-1-sjg@chromium.org>
References: <20231111002851.1293891-1-sjg@chromium.org>
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

(no changes since v1)

 arch/arm64/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2d49aea0ff67..cd9bca2358d2 100644
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
2.42.0.869.gea05f2083d-goog

