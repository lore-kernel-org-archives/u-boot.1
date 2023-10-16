Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D094ACDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC6586F4F;
	Tue, 17 Oct 2023 00:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Heelsq+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6363586F62; Tue, 17 Oct 2023 00:33:40 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9417D86F51
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-773ac11de71so330379785a.2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495585; x=1698100385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PH/2BVT1cp4JUVxMCuS0SVUcP3RxLcuSvnnHG54ue8Y=;
 b=Heelsq+ybCINlz1RFBD/+ukAn7BKipUWXwEtNgELKZj92vLDh+9NkysR4L079pkgKS
 sd1dlaaiSLhI6LZy/rdl7vChRXsxTDuUwWOKQKlEySd7H5IC1cD70Mw4EY9TIvuIvgIg
 DjHS8vVtid66Es/AKQA/fxYcmsG2XYedteeVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495585; x=1698100385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PH/2BVT1cp4JUVxMCuS0SVUcP3RxLcuSvnnHG54ue8Y=;
 b=aHcVlB9SoNoMvtu/ICq8jfOkiQ1nDi6k1NgEyG1w4tYQkl0qxlJIddXeAOwdxrX/j9
 GqhZctFPAB5RVN48VZSNFFYUcB+QtuXxlZAGj5PSey3Ty859z2VhcEXTuUDgUSIIlHmx
 gfxtRc433gQ9VT6lefUy0E/nkkD1SZDQZnPSBmgiXCWyxzTeo5C92/KX82q5BRVV1LGE
 6xFfohkYX6dvEnILU+DWHbyvYBsYchL8P4tzjTP+xQ7zb15gwQtdqHx00FfcKVtvrXNE
 ADu2tK7JrS94fb6r7UhSTKxbKbCVgoDohUxvohHVB6FgSZw7RBc3wvOGY0OuFDFcrxxs
 L1dQ==
X-Gm-Message-State: AOJu0YxhFh3YPARMDTDCry3nIDIfJpogHw0Pd8YodOk8RI6XTXpfaEqm
 1VTWnduy2ijqCjkbFJw9EFOxDVraMHntc4m/F8k/0Q==
X-Google-Smtp-Source: AGHT+IEQGADjaEJBVscNiCGQfNXbEPqq+u2TRKAO7CmsdMjcfDxiuZKyeJAfxYf+MjEJHWJbjM7hnw==
X-Received: by 2002:a05:620a:4414:b0:772:6400:f111 with SMTP id
 v20-20020a05620a441400b007726400f111mr638174qkp.47.1697495585425; 
 Mon, 16 Oct 2023 15:33:05 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:33:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 29/32] arm: x86: Drop discarding of command linker-lists
Date: Mon, 16 Oct 2023 16:28:20 -0600
Message-ID: <20231016222835.596572-30-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

Since we can now cleanly disable CMDLINE when needed, drop the rules
which discard the command code.  It will not be built in the first
place.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to drop discarding of command linker-lists

 arch/arm/cpu/u-boot.lds     | 3 ---
 arch/x86/cpu/u-boot-64.lds  | 4 ----
 arch/x86/cpu/u-boot-spl.lds | 4 ----
 arch/x86/cpu/u-boot.lds     | 4 ----
 4 files changed, 15 deletions(-)

diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index fc4f63d83489..7724c9332c3b 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -14,9 +14,6 @@ OUTPUT_ARCH(arm)
 ENTRY(_start)
 SECTIONS
 {
-#ifndef CONFIG_CMDLINE
-	/DISCARD/ : { *(__u_boot_list_2_cmd_*) }
-#endif
 #if defined(CONFIG_ARMV7_SECURE_BASE) && defined(CONFIG_ARMV7_NONSEC)
 	/*
 	 * If CONFIG_ARMV7_SECURE_BASE is true, secure code will not
diff --git a/arch/x86/cpu/u-boot-64.lds b/arch/x86/cpu/u-boot-64.lds
index d0398ff00d71..00a6d8691211 100644
--- a/arch/x86/cpu/u-boot-64.lds
+++ b/arch/x86/cpu/u-boot-64.lds
@@ -11,10 +11,6 @@ ENTRY(_start)
 
 SECTIONS
 {
-#ifndef CONFIG_CMDLINE
-	/DISCARD/ : { *(__u_boot_list_2_cmd_*) }
-#endif
-
 #ifdef CONFIG_TEXT_BASE
 	. = CONFIG_TEXT_BASE;	/* Location of bootcode in flash */
 #endif
diff --git a/arch/x86/cpu/u-boot-spl.lds b/arch/x86/cpu/u-boot-spl.lds
index a0a2a06a18cd..50b4b1608552 100644
--- a/arch/x86/cpu/u-boot-spl.lds
+++ b/arch/x86/cpu/u-boot-spl.lds
@@ -11,10 +11,6 @@ ENTRY(_start)
 
 SECTIONS
 {
-#ifndef CONFIG_CMDLINE
-	/DISCARD/ : { *(__u_boot_list_2_cmd_*) }
-#endif
-
 	. = IMAGE_TEXT_BASE;	/* Location of bootcode in flash */
 	__text_start = .;
 	.text  : {
diff --git a/arch/x86/cpu/u-boot.lds b/arch/x86/cpu/u-boot.lds
index a31f4220a000..c418ff44aa08 100644
--- a/arch/x86/cpu/u-boot.lds
+++ b/arch/x86/cpu/u-boot.lds
@@ -11,10 +11,6 @@ ENTRY(_start)
 
 SECTIONS
 {
-#ifndef CONFIG_CMDLINE
-	/DISCARD/ : { *(__u_boot_list_2_cmd_*) }
-#endif
-
 	. = CONFIG_TEXT_BASE;	/* Location of bootcode in flash */
 	__text_start = .;
 
-- 
2.42.0.655.g421f12c284-goog

