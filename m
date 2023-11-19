Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD752C54FB9
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC9FA86F45;
	Sun, 19 Nov 2023 16:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c6Ha8gIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B8E1870AF; Sun, 19 Nov 2023 16:02:41 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C603D86F44
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7a98fdeaac7so151630939f.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700406155; x=1701010955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPDLaEBsiuaLoWhERQwxK3nM6Hz04+6uU6ZsB6GmVKQ=;
 b=c6Ha8gIrRscpGJuzb95GvnWVppFlMNfT3mcfL1hv12LI88iWZTx8SofrY6KU+ivbcE
 ZpezYRrQGp6vh9KWJa+iJMAYvtMK/k/xr4qqQ+VvP1/hP65jWbn8tPR4P9MXz6bTvixi
 7sR4RgnuHbOHttGSKyxlNUpSeF2hdpKqvCyvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700406155; x=1701010955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPDLaEBsiuaLoWhERQwxK3nM6Hz04+6uU6ZsB6GmVKQ=;
 b=XAkUSgoH3m90HvXvq0u6N1zlhR2NvUSr64ERx+npdUDRTmkhfDbYPpeD6Z816DmWQI
 ScWYDeTu1S8LGMflx8JIY2PcwlV/v+3qcHyUB+Cimzk9qt9UwpyU5oPn3ebNKtJcQSJG
 IbWsDe18Y6otfpKfeBIQFP6WJTG8078x5sjYBhHr1HXPYr4sR2QL9NwlPaZzeDxMOD6P
 rWG4z3LsQLZUnkJMeAcGytB27o5coYPUKhK3OnP9o7t1KqGQ6ZXjhXNwyDpnjlHKa8D/
 RGAZCmIWGUreZL+iLsm7V0I8ZMmj7RJlFRvBjx+gk6BxqrPIyU+flAor7BXjLdqHU6P9
 ngHg==
X-Gm-Message-State: AOJu0YwpT2pzZ7NlL9o8GFkY2JXidFoPyzEisEHw94m7+IwKpceho5fj
 6soTQ6GzdiCKDF6LIgfYbagAsg==
X-Google-Smtp-Source: AGHT+IEx7n9lWgQ5ZHDpFV/rohuH4tUzvXPoC9/I4DFizrOn2jcqxdjt/zGZCjyAWhAQMdYpGaWrNQ==
X-Received: by 2002:a05:6602:c7:b0:79a:b667:4e97 with SMTP id
 z7-20020a05660200c700b0079ab6674e97mr5843610ioe.0.1700406155245; 
 Sun, 19 Nov 2023 07:02:35 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a056638379800b004665bec29d1sm79923jal.128.2023.11.19.07.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:02:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] kbuild: arm64: Add BOOT_TARGETS variable
Date: Sun, 19 Nov 2023 08:01:14 -0700
Message-ID: <20231119150229.634424-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119150229.634424-1-sjg@chromium.org>
References: <20231119150229.634424-1-sjg@chromium.org>
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

Changes in v6:
- Drop the unwanted .gz suffix

 arch/arm64/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 4bd85cc0d32b..ae0c5ee8c78b 100644
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
 
 
-Image vmlinuz.efi: vmlinux
+$(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 Image.%: Image
-- 
2.43.0.rc0.421.g78406f8d94-goog

