Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACB3E7C4E6
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54AAC875F5;
	Wed,  4 Oct 2023 18:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="clGdARlc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44DF886EE0; Wed,  4 Oct 2023 18:43:34 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70352875B1
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-533edb5ac54so3961985a12.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437785; x=1697042585;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ew1zt3pNvvkATj1clCxbz6aJISraXZHi1FIqGjxl7IA=;
 b=clGdARlcUKW+Ce9DurXnfEaMdE+OXKHxAh5tU2G2UGQ5OTEtO8aQmOsllc6KLChliG
 ykrJNy9cal+5SalVNVXWK3z3lmOb4lv9ezATzAZNIcj4Brhm/RSiJPOh3PP4+4pmUvIY
 4A/ttpcGjB0J67Z0bosOIb6QyfhG5OdrT8mSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437785; x=1697042585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ew1zt3pNvvkATj1clCxbz6aJISraXZHi1FIqGjxl7IA=;
 b=j8oZQYVNTbTUHRROQBlwyOj+YARRwn0Y4RSbIXK5CTWEE2WK4c29sIVQ7BWPwBmsaX
 NupbQkWApQmD8mn6xu7hjhWxjuZObF36EguMx+yjVZMwu1d1jTLI6B0VL+QUfnWfPcUh
 tWTEKkSz0F1byjQ1kRj8ScYxmobuoAk+wXBhssh4Ez7CsP7mxs9VqqhsNWIw6VC9Ru9H
 scHlRNM78M5vf1RQd3a5yfh1YJXbNsjTS3/zbL6LGKEkuS4ZyxHSbadovMs8c/vs+qV8
 8o7uJbUjXfO7Ct/iTSivfPXuMvhk2aSarJyKBun+PPIzuCoSnb9SNd3VivEp0Oh4PATS
 8bMQ==
X-Gm-Message-State: AOJu0YxOvpQb4JURQv0VRIIHl8grO4JeJuEmDZrgMq3U88FjLhXLCQJ9
 35usGo7Xt6aAFd63kZk8Grio7t8Ly3+CuToKia4=
X-Google-Smtp-Source: AGHT+IEg2jBs0MM1h1Y181N+lf1Sd/NuVOMQAErKk7Go9GApjG/5k6++jn6XkoMR+J5Ero5oIAE4Fg==
X-Received: by 2002:a05:6402:6d4:b0:533:4c67:c911 with SMTP id
 n20-20020a05640206d400b005334c67c911mr2652394edy.19.1696437785128; 
 Wed, 04 Oct 2023 09:43:05 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:43:04 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Nikhil M Jain <n-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [RFC PATCH v10 09/24] cli: Add menu for hush parser
Date: Wed,  4 Oct 2023 19:42:05 +0300
Message-Id: <20231004164220.15738-10-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
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

For the moment, the menu contains only entry: HUSH_OLD_PARSER which is the
default.
The goal is to prepare the field to add a new hush parser which guarantees
actual behavior is still correct.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 cmd/Kconfig     | 13 +++++++++++++
 common/Makefile |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43ca10f69c..5fb4cef54c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -23,6 +23,19 @@ config HUSH_PARSER
 	  If disabled, you get the old, much simpler behaviour with a somewhat
 	  smaller memory footprint.
 
+menu "Hush flavor to use"
+	depends on HUSH_PARSER
+
+	config HUSH_OLD_PARSER
+		bool "Use hush old parser"
+		default y
+		help
+		  This option enables the old flavor of hush based on hush Busybox from
+		  2005.
+
+		  It is actually the default U-Boot shell when decided to use hush as shell.
+endmenu
+
 config CMDLINE_EDITING
 	bool "Enable command line editing"
 	depends on CMDLINE
diff --git a/common/Makefile b/common/Makefile
index f5c3d90f06..615eba8672 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -8,7 +8,7 @@ ifndef CONFIG_SPL_BUILD
 obj-y += init/
 obj-y += main.o
 obj-y += exports.o
-obj-$(CONFIG_HUSH_PARSER) += cli_hush.o
+obj-$(CONFIG_HUSH_OLD_PARSER) += cli_hush.o
 obj-$(CONFIG_AUTOBOOT) += autoboot.o
 
 # # boards
-- 
2.34.1

