Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622F1C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 07:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0AF1874F8;
	Thu, 26 Oct 2023 09:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mG2lQc1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE5448750A; Thu, 26 Oct 2023 09:27:49 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69A6F874E6
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 09:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c9bf22fe05so4129415ad.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 00:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698305266; x=1698910066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTwZx3oM2k52vN4dFBT99PYUWHkrvjvdxEhL3D6GWJ0=;
 b=mG2lQc1qx92OEBcFhtXZwBW+jJeIR7Ji47sgYy/vk6+nst9akblAyTFVejoVvqUYWV
 AqLlbz9TKY4nCHT6uK6yOQiqRAxdX1aMSZ6EWxSzuYslgQE5P33jQ1L6Af4ETJVM5rhK
 v3DnPe7ny4g/oL0njDYF0x73eMyDTgv17Yt7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698305266; x=1698910066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UTwZx3oM2k52vN4dFBT99PYUWHkrvjvdxEhL3D6GWJ0=;
 b=OPRSfW0y+jImluQoknGwsPfB8iO9/UvvqVV1QkN3aehqXXnFjz3cdwtM7ZSN1ivSqU
 vxL4ZYSnlkr5XF2SfqsDjwAk5YXSi61XOSgVf4hMId6D08+KKGGZyJSlsfIFW3RaBW7T
 y4Z4RAT7i+K2+f6xJmGXUr2mSyGYiUYthh0ZdFlFnOTlGdoKpa1UkYGC/RuWrtIwdwL4
 Qu+xPJEo43dBG2SVqucqdEXg3BysqGWftjlkbvqIU8ADiBVTw6ib0/nVG8RgyE7RbcrN
 eoebIWrvD/ktExktz2ldvZoKrmGr0rEH61PqMjWVET6XP2pnfN18qALfCVt2zbY7xORe
 0j3w==
X-Gm-Message-State: AOJu0YwMM8JfV2U85bj2ETlM3UgK8b+EQZ49VuIgnqkgcfbLh6rvF9bv
 TLH38uas5YHGoipiiLbJ5PdDCw==
X-Google-Smtp-Source: AGHT+IESAAwq7rAUPMREBmZ6wjGQZPRao0krbTSghCrCp+7VkHSUuu7/MSZv4fKt+xYoabpzNXl+YA==
X-Received: by 2002:a17:902:ce92:b0:1c9:e774:58e1 with SMTP id
 f18-20020a170902ce9200b001c9e77458e1mr17515487plg.8.1698305265723; 
 Thu, 26 Oct 2023 00:27:45 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a170902e55100b001b7cbc5871csm10294023plf.53.2023.10.26.00.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 00:27:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kbuild: Correct missing architecture-specific hyphens
Date: Thu, 26 Oct 2023 20:26:23 +1300
Message-ID: <20231026072628.4115527-2-sjg@chromium.org>
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

These should add a hyphen to indicate that it makes a adjective. Fix
them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 690cde550acd..b63796e6f94a 100644
--- a/Makefile
+++ b/Makefile
@@ -675,7 +675,7 @@ ifdef config-build
 # *config targets only - make sure prerequisites are updated, and descend
 # in scripts/kconfig to make the *config target
 
-# Read arch specific Makefile to set KBUILD_DEFCONFIG as needed.
+# Read arch-specific Makefile to set KBUILD_DEFCONFIG as needed.
 # KBUILD_DEFCONFIG may point out an alternative default configuration
 # used for 'make defconfig'
 include $(srctree)/arch/$(SRCARCH)/Makefile
@@ -689,7 +689,7 @@ config: outputmakefile scripts_basic FORCE
 
 else #!config-build
 # ===========================================================================
-# Build targets only - this includes vmlinux, arch specific targets, clean
+# Build targets only - this includes vmlinux, arch-specific targets, clean
 # targets and others. In general all targets except *config targets.
 
 # If building an external module we do not care about the all: rule
@@ -1637,9 +1637,9 @@ help:
 	@echo  'Documentation targets:'
 	@$(MAKE) -f $(srctree)/Documentation/Makefile dochelp
 	@echo  ''
-	@echo  'Architecture specific targets ($(SRCARCH)):'
+	@echo  'Architecture-specific targets ($(SRCARCH)):'
 	@$(or $(archhelp),\
-		echo '  No architecture specific help defined for $(SRCARCH)')
+		echo '  No architecture-specific help defined for $(SRCARCH)')
 	@echo  ''
 	@$(if $(boards), \
 		$(foreach b, $(boards), \
@@ -1681,7 +1681,7 @@ help-boards: $(help-board-dirs)
 boards-per-dir = $(sort $(notdir $(wildcard $(srctree)/arch/$(SRCARCH)/configs/$*/*_defconfig)))
 
 $(help-board-dirs): help-%:
-	@echo  'Architecture specific targets ($(SRCARCH) $*):'
+	@echo  'Architecture-specific targets ($(SRCARCH) $*):'
 	@$(if $(boards-per-dir), \
 		$(foreach b, $(boards-per-dir), \
 		printf "  %-24s - Build for %s\\n" $*/$(b) $(subst _defconfig,,$(b));) \
-- 
2.42.0.758.gaed0368e0e-goog

