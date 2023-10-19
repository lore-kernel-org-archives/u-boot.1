Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15361CDB484
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D398748F;
	Thu, 19 Oct 2023 17:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J9+5wNU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A342587259; Thu, 19 Oct 2023 17:01:35 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DCAE87470
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7db1f864bso96482937b3.3
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727690; x=1698332490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGwZJoiurMToJUJJt1ZwY8XyW3B/TxGPwTs7HXCJRPI=;
 b=J9+5wNU4YvSnZ/d+1MkdbclqW7oUZ3c+r7NA1BzsaZ9++/UizOSe/BJUMpl9jF+AXF
 ENck1V1DwdRpx9fStU1PZAoImM0eauldX3m+gtDipUEiEAgQyTTtoIfTWNU3DwaGyHKH
 r3j2cBXj6CWVDBU27TnS05YrcrUdlMhueYZDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727690; x=1698332490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGwZJoiurMToJUJJt1ZwY8XyW3B/TxGPwTs7HXCJRPI=;
 b=muSbdYQVXESiZRkjcrjezYVORsfneXWVEdYbfnqrdr6F6DsqMKf0bWPDvia9cIZ+so
 4clVOWihzCaTvzcHLFRK/pYGcDzT75MjXpenCcEtBX++Y1lo4QfBguqOR446WI3TyQTU
 STnnzilPEa5XrlWTVh5n3Ctgytwy4tsaFlkS8AHQRloLhbWroisVcQi8qaNi1YagQ+8/
 Yyhr7tgvE4uwDOaUJf+sbdMojt/mqOcxCojrXumHJovSYWdgbDhLGiiSMEbG3NgSKD82
 CNUv/1Qv232JS1pcvV3sLGFxf6hx8Z2Qu62s+dzRE3givaBUp/xZxOxKt8IA2J7MUs6+
 484A==
X-Gm-Message-State: AOJu0Yz6SePgzhgZIN9icKdqWNPA/53CrQWbdMdNUX1jigBSx+W+3Ble
 AJwQ4VeajkNGqqu1bSyRupZy/4Mvb994teG+AnX42g==
X-Google-Smtp-Source: AGHT+IFmkYQsQ6z3+jtwboCgPyWfddZDLjaX4XErMhsytYl0nv10XNA7BAhjDkAXgwzl6UghgbnGGw==
X-Received: by 2002:a0d:eb03:0:b0:5a2:20ec:40be with SMTP id
 u3-20020a0deb03000000b005a220ec40bemr2698838ywe.29.1697727689844; 
 Thu, 19 Oct 2023 08:01:29 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v4 20/24] cmd: Make most commands depend on CMDLINE
Date: Thu, 19 Oct 2023 11:01:01 -0400
Message-Id: <20231019150105.714407-20-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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
index e0040a40d330..969f3f74a74d 100644
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
index 099ec444ae99..91297cb53f9a 100644
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
@@ -2872,4 +2867,5 @@ config CMD_MESON
 	default y
 	help
 	  Enable useful commands for the Meson Soc family developed by Amlogic Inc.
-endmenu
+
+endif
-- 
2.34.1

