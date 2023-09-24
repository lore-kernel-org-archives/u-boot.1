Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AFBCE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E113D86BF8;
	Sun, 24 Sep 2023 22:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lrvDJaU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFE3086B75; Sun, 24 Sep 2023 22:40:36 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE4986B74
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79f96f83270so154845839f.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588033; x=1696192833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EsO0o9J6Uu5zILHzyiAdjyTsW3LzjuoADYG4Av1ZvlY=;
 b=lrvDJaU0p29AC7OuUuDqy89FsXCvDYxBmIKGAXR2ySUdkNp/xFqH02dQd8rV7xurl3
 GVBjPakrks40b4pUQ3KZ39HT8JGl/TykY4AuRlr2U1gZGUbf1QAlb5LgJlMN7NVqKtIk
 AhA1kyEYfyYjDyPUb8qh8yxEDdWueSOhiirsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588033; x=1696192833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EsO0o9J6Uu5zILHzyiAdjyTsW3LzjuoADYG4Av1ZvlY=;
 b=YaQJ/en9k93PInUQ4JNVWVMmdVkJZFgBlRLojhPbYb5ZbnHq+54zZ4OhRpNo2AJMIf
 SBGNp3f+hXYVyq2k/0b9pMP8RAI5MAUVudC7XRbYfd33iTmsvZ1ZOa0l4tqdEy0LSfwv
 lz5l/IZDjks5mtPYPkaNl/z/UUQQnan0qQN9wKlKVjPJETTUIvjheFOhHkBotwVEiPAl
 fSmX2LhYd0rSz5WSgiVRtuPtCxsN1rQJKJGUPWqfJabldzdNbceyaMAkgJ78Yi4mEDOG
 h/Qz/0E2fMJvLrPaESL7bubF4T3mAM7aeG1rB6Av3JIlXVwRLh2/yCgGKk03hVHd752N
 2LiQ==
X-Gm-Message-State: AOJu0YxPU+EWmdYfhUuF83hj2Evb7pVr/aUfMZnuH6v8Tb6VXRyiB1Ln
 q25OR/h0u74U/aKYNM+nn+BNjJUH68vgE/qvGWg=
X-Google-Smtp-Source: AGHT+IG4mQYjOoJ0K14QsSXViqTY7dTezuLOB6bGo+5R46sRcPsDSnp+4YXWcagfENZoAdnFG1e9kA==
X-Received: by 2002:a05:6602:19d4:b0:792:9a3e:2dd with SMTP id
 ba20-20020a05660219d400b007929a3e02ddmr5920546iob.3.1695588033407; 
 Sun, 24 Sep 2023 13:40:33 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Harald Seiler <hws@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 15/25] console: Move SYS_PBSIZE into common/
Date: Sun, 24 Sep 2023 14:39:33 -0600
Message-ID: <20230924203953.1829820-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

This relates to printing output and does not need a command line. Move
it next to the other console-related options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig    | 5 -----
 common/Kconfig | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a254c41110ec..5f6834b335dc 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -84,11 +84,6 @@ config SYS_CBSIZE
 	default 256 if M68K || PPC
 	default 1024
 
-config SYS_PBSIZE
-	int "Buffer size for console output"
-	default 1024 if ARCH_SUNXI
-	default 1044
-
 config SYS_XTRACE
 	bool "Command execution tracer"
 	depends on CMDLINE
diff --git a/common/Kconfig b/common/Kconfig
index 21eaa5e815f9..08d490ad4776 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -52,6 +52,11 @@ config CONSOLE_RECORD_IN_SIZE
 	  The buffer is allocated immediately after the malloc() region is
 	  ready.
 
+config SYS_PBSIZE
+	int "Buffer size for console output"
+	default 1024 if ARCH_SUNXI
+	default 1044
+
 config DISABLE_CONSOLE
 	bool "Add functionality to disable console completely"
 	help
-- 
2.42.0.515.g380fc7ccd1-goog

