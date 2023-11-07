Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476CDC4167B
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 13:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90179871CF;
	Tue,  7 Nov 2023 14:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Orqax9E/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0BF587076; Tue,  7 Nov 2023 14:26:34 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C203F870D5
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 14:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-35932aa21a3so21273655ab.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 05:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699363591; x=1699968391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUczbla/3nICzQP9ZmDHPTBpFCCiTIH02+1QSP6Uf6s=;
 b=Orqax9E/guZTjRQyQQUs07k3c/qyt5+2TiUDvgHEXhxJ6ZvQxHPc6fJouDAvQFHTlP
 i1V46Hoaup1J7FbzZffaruNjUBkstzf8uRaxSjEV05BCj2QgOxjAWr0ow2t/AJ2iQyZq
 Mv9zPmaFoOvW+shhMXpTClIVvHo7dtbuIPSAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699363591; x=1699968391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mUczbla/3nICzQP9ZmDHPTBpFCCiTIH02+1QSP6Uf6s=;
 b=oXabXc0vxyTLWNeYdFkN4h/juuga4zCtl2J4Lzt+Su1C06+H9D4hpj6UIZWiCwznh2
 yhaq9YtAUbGQ8Fd0r+OQLsa2MoeRMiGXN1DAab0MFqAIo5CgHKhJVibaIX4Fdb7KZgU1
 Y3m5LJpqR7UCv8Sk6z7O7VMtpCouXDrpHErEGMmUTdQCLEvEpSXmhN8f8ShMUqpipqcF
 Kji34pp9gsKPHbw2D3YHKRJmbYZkqbsa2GFNNCePJ551a991ZPXbq4mzgBectPC4sawa
 yy/8J846X7cPWwczWh7hsiSl7jVSA3HwF4zjqfQikyCFJZjaK/DswLoljRB+z2qhh8aa
 NuyQ==
X-Gm-Message-State: AOJu0Yyenf3LChOEBzMUVCF/95cuadWHYNsyONTMrDQ9Nn5+LGkK/PQ1
 DpbeTqtgMAqOqOlUKvrxgN7ntA==
X-Google-Smtp-Source: AGHT+IFA2Meg21EeLlaQDzpshWitOcfdYqDCyk1R7zr9wR5+pxet1yylcylsnJ+ZznmSM2QLqVbohw==
X-Received: by 2002:a05:6e02:1847:b0:359:4199:1fe4 with SMTP id
 b7-20020a056e02184700b0035941991fe4mr3384295ilv.10.1699363591508; 
 Tue, 07 Nov 2023 05:26:31 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 db8-20020a056e023d0800b003596056a051sm3141589ilb.71.2023.11.07.05.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 05:26:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Simon Glass <sjg@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] kbuild: arm64: Add BOOT_TARGETS variable
Date: Tue,  7 Nov 2023 06:25:53 -0700
Message-ID: <20231107132619.34062-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231107132619.34062-1-sjg@chromium.org>
References: <20231107132619.34062-1-sjg@chromium.org>
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
2.42.0.869.gea05f2083d-goog

