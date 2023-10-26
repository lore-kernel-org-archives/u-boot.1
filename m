Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6D2C25B6E
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5548E87B9A;
	Thu, 26 Oct 2023 20:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BPFqORfJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5470087B5E; Thu, 26 Oct 2023 20:32:01 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED50D87B60
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-778af1b5b1eso92494585a.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345117; x=1698949917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ce52lp1G2O3n8hcqSsZtDHGfnHVsXMS7flM9UPJf/VE=;
 b=BPFqORfJ73ca/CItiiMOgPNAghj37qZlTnuGN96l90gjnORUnV8bplm0rz6X6UFxHj
 XbneL5U6+ldSpPMhyo8Ne3ToomGJ3XZkhRV1DRP8yKp+lIGWHk61ZNhQJLp36DYQlNXu
 ba4F2pjsqmt59jSk5UTyu3HSBjCdOcZr5Vupk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345117; x=1698949917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ce52lp1G2O3n8hcqSsZtDHGfnHVsXMS7flM9UPJf/VE=;
 b=ZWsXzIAjEgJBot+m4ybB3iIOMtsuGUByvoWrpx/5wuCfopbdXQxNGvXs4yea5QmQRL
 D6+HIQ0/qcGKOAYRRVd5nGTKhEF5oFjWlvXMEj0OGKqvZLvPSN7gRUGBzfyPwcPlmBrq
 HsdRZRFEHRRfAc82QEa7MHqojq0oxsL+cXkQckn3xe5nkEdEBoLQimaapM63xA39oxhc
 W8qfaZq9in1XYKzv1cgP89sWEuh6Vp0bjawGt57DuHGlqYWEpS9GirS2R6NiSaPRKtmn
 pjhSw3lK8LSy1jQq0e22mZqO6a5CqGv6QkxOMd6Y+Meb1S2U3KHgaXBxTUMsX3cxtwGo
 G4Lg==
X-Gm-Message-State: AOJu0YxdA5LjcfBsDMZdMjUVkgf9QebRkEIbtgdkj1ECgxEc1EpyGm9Z
 L2N/8aWv8ey/Ls+dpVUP+S5j9ZCeerkjMrkuEYlyvg==
X-Google-Smtp-Source: AGHT+IGd0V64ZrZ450omjJ/9Vt7o6XupHTK4oohp2eSCHq7bRt5Ttizl53X6j9ObhBssBVeswCEH5g==
X-Received: by 2002:a05:620a:1a90:b0:775:9c23:1da9 with SMTP id
 bl16-20020a05620a1a9000b007759c231da9mr153508qkb.49.1698345116917; 
 Thu, 26 Oct 2023 11:31:56 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v5 21/30] cmd: Make most commands depend on CMDLINE
Date: Thu, 26 Oct 2023 14:31:29 -0400
Message-Id: <20231026183138.636948-21-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

If we disable CMDLINE then we should not ask about enabling the hush
parser nor any of the commands that would be run on the command line as
it is no longer available. Convert the CMDLINE option into a menuconfig
and make every command referenced under cmd/Kconfig depend on it.

This leaves as future work moving the commands that are not under the
cmd/ hierarchy as future work.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v4:
- Reword the commit message slightly.
- Make this not depend on other patches
---
 Makefile    |  2 +-
 cmd/Kconfig | 20 ++++++++------------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 8a04dfcf3638..737dcde0b50b 100644
--- a/Makefile
+++ b/Makefile
@@ -851,7 +851,7 @@ HAVE_VENDOR_COMMON_LIB = $(if $(wildcard $(srctree)/board/$(VENDOR)/common/Makef
 libs-$(CONFIG_API) += api/
 libs-$(HAVE_VENDOR_COMMON_LIB) += board/$(VENDOR)/common/
 libs-y += boot/
-libs-y += cmd/
+libs-$(CONFIG_CMDLINE) += cmd/
 libs-y += common/
 libs-$(CONFIG_OF_EMBED) += dts/
 libs-y += env/
diff --git a/cmd/Kconfig b/cmd/Kconfig
index febfa2cdaa5f..0eb739203ade 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1,7 +1,5 @@
-menu "Command line interface"
-
-config CMDLINE
-	bool "Support U-Boot commands"
+menuconfig CMDLINE
+	bool "Command line interface"
 	default y
 	help
 	  Enable U-Boot's command-line functions. This provides a means
@@ -11,9 +9,10 @@ config CMDLINE
 	  Depending on the number of commands enabled, this can add
 	  substantially to the size of U-Boot.
 
+if CMDLINE
+
 config HUSH_PARSER
 	bool "Use hush shell"
-	depends on CMDLINE
 	help
 	  This option enables the "hush" shell (from Busybox) as command line
 	  interpreter, thus enabling powerful command line syntax like
@@ -25,7 +24,6 @@ config HUSH_PARSER
 
 config CMDLINE_EDITING
 	bool "Enable command line editing"
-	depends on CMDLINE
 	default y
 	help
 	  Enable editing and History functions for interactive command line
@@ -40,15 +38,13 @@ config CMDLINE_PS_SUPPORT
 
 config AUTO_COMPLETE
 	bool "Enable auto complete using TAB"
-	depends on CMDLINE
 	default y
 	help
 	  Enable auto completion of commands using TAB.
 
 config SYS_LONGHELP
 	bool "Enable long help messages"
-	depends on CMDLINE
-	default y if CMDLINE
+	default y
 	help
 	  Defined when you want long help messages included
 	  Do not set this option when short of memory.
@@ -77,8 +73,7 @@ config SYS_MAXARGS
 
 config SYS_XTRACE
 	bool "Command execution tracer"
-	depends on CMDLINE
-	default y if CMDLINE
+	default y
 	help
 	  This option enables the possiblity to print all commands before
 	  executing them and after all variables are evaluated (similar
@@ -2880,4 +2875,5 @@ config CMD_MESON
 	default y
 	help
 	  Enable useful commands for the Meson Soc family developed by Amlogic Inc.
-endmenu
+
+endif
-- 
2.34.1

