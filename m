Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB83CC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C11187B93;
	Thu, 26 Oct 2023 20:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uafmRPlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81EAA87641; Thu, 26 Oct 2023 20:31:54 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B6BB87B23
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7781bc3783fso94358485a.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345108; x=1698949908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7mjKd/GZNzWfl0/YqzAOe4T/BKCMoN25+tfgjsqTp8=;
 b=uafmRPlHZMYBI9aYS5/BDw1SmvtDMZYnJsQ8gA/j/z68ZCNuFR2D5IFEwLAnTxYFOK
 guNkgvbLZo1AHqURKVvVYMm3RJa3OW8ObtuH7UWRk+4PQvN4fkBHcd6A8qlAKKYreJV2
 dbSF3FenCgOl4Dxs8cqQTtsvMzL4UH47Ar+Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345108; x=1698949908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7mjKd/GZNzWfl0/YqzAOe4T/BKCMoN25+tfgjsqTp8=;
 b=EDo0apqjFUUZfnr8Dziqx15TBR5J4izTimcmPCLauf3GTEbKJEHH7gDtoOH98N6ehB
 4IwyiQ4KIGfQWizgqTqzmMtlMO7+I5Y2zVJTmyHqflCK16GPMpOAXvU3xrustAc36Kcy
 iMAzWyHq7JjSUUdu1nZxfAZC6i8iBYHKOhh+6pa1/Ngx1Lz+u802EuXYQAcRDWD5Jo/5
 TMLgrsJUG4fE4stHOWgkiQgD+y1MeDjeL10cI0KnlxFHwHxYQa8p/zqIIuqqUkTFLQmJ
 9SDXJJ5Ns+Ywq7uHKZXKMqRGzotwP+/FZV2UfrlQAYlf1b3+XFIhwfYGGS+mD17wS6r8
 YFXA==
X-Gm-Message-State: AOJu0YxtpqGo2f2x/eXcJe0pNqTzw3uHoysG5rS1MG5a4pXu4E+mk1og
 XcHAb0W12uCZ2PF8sPh9c7RBCkvYC2sxW4oGnzdH3A==
X-Google-Smtp-Source: AGHT+IEYvHkw1eukm7kBZG6I1WF/hOiPo2IpPQ7TaK7VnDZAyDHLI18Fp1MY1FyQyZXfaHuVDIdDtQ==
X-Received: by 2002:a05:6214:519d:b0:64f:6199:a8e with SMTP id
 kl29-20020a056214519d00b0064f61990a8emr634927qvb.23.1698345108640; 
 Thu, 26 Oct 2023 11:31:48 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v5 10/30] video: Don't require the font command
Date: Thu, 26 Oct 2023 14:31:18 -0400
Message-Id: <20231026183138.636948-10-trini@konsulko.com>
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

While it is nice to have the font command, using 'select' makes it
impossible to build the console code without it. Stop using 'select' and
make it default if CONSOLE_TRUETYPE is enabled when asking the command.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v4:
- Rework to have the command itself be default y if CONSOLE_TRUETYPE
  instead of selecting it. (Tom)
---
 cmd/Kconfig           | 2 +-
 drivers/video/Kconfig | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index cbba39099659..f8b34ca504b2 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2348,7 +2348,7 @@ config CMD_VIDCONSOLE
 config CMD_SELECT_FONT
 	bool "select font size"
 	depends on VIDEO
-	default n
+	default y if CONSOLE_TRUETYPE
 	help
 	  Enabling this will provide 'font' command.
 	  Allows font selection at runtime.
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index ab927641bb7a..6f319ba0d544 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -180,7 +180,6 @@ config CONSOLE_ROTATION
 
 config CONSOLE_TRUETYPE
 	bool "Support a console that uses TrueType fonts"
-	select CMD_SELECT_FONT
 	help
 	  TrueTrype fonts can provide outline-drawing capability rather than
 	  needing to provide a bitmap for each font and size that is needed.
-- 
2.34.1

