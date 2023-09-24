Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD18ECE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BE3086B57;
	Sun, 24 Sep 2023 22:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ReSckawB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C53986B34; Sun, 24 Sep 2023 22:40:27 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5879D86A38
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79f96daf565so153613139f.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588024; x=1696192824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKTanRS9DYowZyImbliCuaufAVqXvjgANac3H2+OiEs=;
 b=ReSckawBwmqxh0wubl2X8rxvws/LjeZGI/4GiZ3KjXOnUoeyvJlO1rV6kGvYA2ROjx
 +FG12o6qloQJmU1VDHdAm+V7zL22D2rQG//hyASegD/tIUBLubFrtMKODmcWrAfa8Baw
 XQKeCPe9T9preR6WClC1DeYrxweUiXC/QyfLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588024; x=1696192824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKTanRS9DYowZyImbliCuaufAVqXvjgANac3H2+OiEs=;
 b=Ybr+ustbftDe7TH8TSDi4zNBubzhzRrAS2HyzdrTS/+6/lDRvw8TyvXNOg1x1OiAjJ
 0F8vJ4H3G3NcolVFXq22QMl7Z37dDM+6O73foiYvVlNmWoBkd79ytOZDnU34JEaEx6jo
 gQT767Q4dUZOvFJ7/rHZFpB4IhXB3uqRuwMsfRqwXNdDiYs2T0JdYy92LebT/YffSA3E
 /ZoRWlETvWedTIVnqVJz3V9IyQZdWU91yYR0L46UHR+f1Mn2oeeXsuIu7bC5zHuB0Blh
 3smy9CsitH34h6mCqeZ2dGoUglN9SSPtALUSpM72gwDeOeAH4VOu2Snx8ucN9/q2/8hY
 M3Hg==
X-Gm-Message-State: AOJu0YyQ0zj2ld8IK+igXLAyavUwrPMckUFvjE25DaXGRh5mW4OgPp19
 VdI7EPejQb6VsHeoLapdjuLhRb1U9+ZYs57/KAE=
X-Google-Smtp-Source: AGHT+IErSLShl0v13Zb7cZaPpXHQsJOd52dskozCfsDelMYxjmgLw2j8UOcH4u9vBQPxCCgCnf1ECw==
X-Received: by 2002:a05:6e02:1d9b:b0:34d:ec9c:7321 with SMTP id
 h27-20020a056e021d9b00b0034dec9c7321mr7410337ila.3.1695588023922; 
 Sun, 24 Sep 2023 13:40:23 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 04/25] cmd: Add a few more dependencies on CMDLINE
Date: Sun, 24 Sep 2023 14:39:22 -0600
Message-ID: <20230924203953.1829820-5-sjg@chromium.org>
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

Add this to some more commands to avoid build errors with sandbox.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 64d723bd483b..cdc22a067b27 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -224,6 +224,7 @@ menu "Boot commands"
 
 config CMD_BOOTD
 	bool "bootd"
+	depends on CMDLINE
 	default y
 	help
 	  Run the command stored in the environment "bootcmd", i.e.
@@ -413,6 +414,7 @@ source lib/efi_selftest/Kconfig
 
 config CMD_BOOTMENU
 	bool "bootmenu"
+	depends on CMDLINE
 	select MENU
 	select CHARSET
 	help
@@ -479,6 +481,7 @@ config CMD_GO
 
 config CMD_RUN
 	bool "run"
+	depends on CMDLINE
 	default y
 	help
 	  Run the command in the given environment variable.
@@ -574,6 +577,7 @@ menu "Environment commands"
 
 config CMD_ASKENV
 	bool "ask for env variable"
+	depends on CMDLINE
 	help
 	  Ask for environment variable
 
@@ -2125,6 +2129,7 @@ config CMD_EFICONFIG
 
 config CMD_EXCEPTION
 	bool "exception - raise exception"
+	depends on CMDLINE
 	depends on ARM || RISCV || SANDBOX || X86
 	help
 	  Enable the 'exception' command which allows to raise an exception.
@@ -2231,6 +2236,7 @@ config CMD_SYSBOOT
 
 config CMD_QFW
 	bool "qfw"
+	depends on CMDLINE
 	select QFW
 	help
 	  This provides access to the QEMU firmware interface.  The main
-- 
2.42.0.515.g380fc7ccd1-goog

