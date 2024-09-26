Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC678CDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF21C88E1F;
	Fri, 27 Sep 2024 00:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UPW1/A6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C8FB87B77; Fri, 27 Sep 2024 00:42:28 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53DC788E1F
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4581ee65b46so10982491cf.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390545; x=1727995345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxkD34MKFHF4fk4yrYxZIT/1+3BwMKHTmDIDm51MPRU=;
 b=UPW1/A6MDnOjELYY4+Z4seBh9EkYyrWJwp6ZaRoms9ENG5bzyQnMBE4lzkO7tvgfUH
 JxYFP/swUSVFZ4g84lV17vSQTsAQ6ygKNu5NAfkf/ptu3pF49yRpHa7YBl9qEjJf1gFk
 0v+v30B4krc7vSlZNPORNP2oLLlX5JFADD2Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390545; x=1727995345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxkD34MKFHF4fk4yrYxZIT/1+3BwMKHTmDIDm51MPRU=;
 b=bAymYl3Gg9pxEW6WOvrlA31FavuU/gQhO0Gbsa2X4JBQnZBLZay8zE5qYK5gA/K9JM
 DidH6d0S2E6Xg8wI+O8+SheWqMvbsI38dsY+WJsKdvf1NsAQhZ6gI9ZTx7JIPOGFpKjg
 6Qv+JTi4/GZCJpu/vlkVt63TfBS9TkNiavZXWNdNpzzE/Vu518zHtIBk9s8nvhHzJ5hZ
 z9ByPug75wPrZmmcANJuE/GjMuY4XUaT/M9NETsgMUaVZfZiZI0TKncVyYb3DMq6+Ftn
 r/KQo+EZrEJ0UurUZ6Llafd0Fd6Nz3Epd0DDkV+FGSnbtOcRlygV8H2RGIqaN2cvI/jQ
 O3BQ==
X-Gm-Message-State: AOJu0YzNIZg6CsGyryX9Cm7MRoDOu4Vt75fyWq0YmI7x+BfvjMRwATQD
 CWnKXAGI8Y92Nu6ZzmUh9DrxXioirKp4Xu0jo79qP4v1OZGfSkMmNTRUUgHpfIoQXlXa/onyor2
 THUfZX30=
X-Google-Smtp-Source: AGHT+IHgCPX5pyDhOCgaElhF2AMgWfghH6jie5ExkU/+nqL3yw7AyoxxrtHHelpkJ2H0w6F9Njo0lw==
X-Received: by 2002:a05:622a:30f:b0:458:3867:c13c with SMTP id
 d75a77b69052e-45c9f20785amr15316701cf.19.1727390545071; 
 Thu, 26 Sep 2024 15:42:25 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:42:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 17/42] x86: Simplify check for SPL
Date: Fri, 27 Sep 2024 00:35:42 +0200
Message-ID: <20240926223814.1276764-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

Now that SPL means SPL (only) and is not defined for TPL, simplify some
checks for SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/apollolake/fsp_bindings.c | 2 +-
 arch/x86/cpu/broadwell/cpu_full.c      | 2 +-
 arch/x86/lib/Makefile                  | 9 ++-------
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/cpu/apollolake/fsp_bindings.c b/arch/x86/cpu/apollolake/fsp_bindings.c
index b4bb677f5cd..4b0756e77cc 100644
--- a/arch/x86/cpu/apollolake/fsp_bindings.c
+++ b/arch/x86/cpu/apollolake/fsp_bindings.c
@@ -653,7 +653,7 @@ int fsp_m_update_config_from_dtb(ofnode node, struct fsp_m_config *cfg)
 }
 #endif
 
-#if !defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+#if !defined(CONFIG_SPL_BUILD)
 const struct fsp_binding fsp_s_bindings[] = {
 	{
 	.type = FSP_UINT8,
diff --git a/arch/x86/cpu/broadwell/cpu_full.c b/arch/x86/cpu/broadwell/cpu_full.c
index 529dab18d5d..46a6436be54 100644
--- a/arch/x86/cpu/broadwell/cpu_full.c
+++ b/arch/x86/cpu/broadwell/cpu_full.c
@@ -84,7 +84,7 @@ static const u8 power_limit_time_msr_to_sec[] = {
 	[0x11] = 128,
 };
 
-#if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+#if defined(CONFIG_SPL_BUILD)
 int arch_cpu_init(void)
 {
 	return 0;
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 2738f0b577b..bf0605ad662 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -58,13 +58,8 @@ obj-$(CONFIG_FSP_VERSION1) += fsp1/
 obj-$(CONFIG_FSP_VERSION2) += fsp2/
 endif
 
-ifdef CONFIG_XPL_BUILD
-ifdef CONFIG_TPL_BUILD
-obj-y += tpl.o
-else
-obj-y += spl.o
-endif
-endif
+obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_TPL_BUILD) += tpl.o
 
 lib-$(CONFIG_USE_PRIVATE_LIBGCC) += div64.o
 
-- 
2.43.0

