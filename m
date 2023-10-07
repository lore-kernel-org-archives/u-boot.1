Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC3CE95A67
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD93786F66;
	Sun,  8 Oct 2023 01:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R7PUq6Am";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0796D86EC6; Sun,  8 Oct 2023 01:14:19 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF81186F05
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-352a1a0348fso13402815ab.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720396; x=1697325196; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBp0HYn+zW7JB7fktd6W1FL9Bcd7GSWvX7ntYSU4Mzk=;
 b=R7PUq6AmO8O4zLWreQ4hJpuLddMMNDcSfp9SeqcYQIy0AkpJK6L1HcU/MiJf/HVmEs
 iRfCWqIKhTrFTCoMcNxMlOQUMbjINdRkavFSKlpDCgVb8ZWjIVtRMeEOhuTkC2lcijp7
 Lff9kmj12zNzmUYKDdXZBKmfleOEc24cDaOh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720396; x=1697325196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBp0HYn+zW7JB7fktd6W1FL9Bcd7GSWvX7ntYSU4Mzk=;
 b=ZKH12f1jN5L+IvGzE7QCeh2YDfXH6a7XVHAGjLRdHehe4MFuGqDA4Y9nuqvtmNjqC6
 h0DO3TTGE99nOktI4LZcfML8Ctb+e7DODBixAZG6yP46uMcfXl5jMrDqcgI7s5nGvP7r
 lqOGeTQeZCPvDj/AU9QsHC83OAuade6HYXL/edM9XpAKV5p3voUCXhb/E5MdhXez+p5v
 A95KyAOIQwdXLpLBm7CrMsmbhdCTFYAt975pBWjCfxB4t+8EJJREpJmd5lGugN/Id7YN
 6U/sbGX8p5CAfruvV3RUMEmqee/pDSopTBa58aaX9yJh/3LZdNPDjt7RYdPKjiGkuPai
 rMgQ==
X-Gm-Message-State: AOJu0Yy6xDeXwbZrOvI1WgMtHukV5BU73077+O8RYbAn8wp8aUjYxtaH
 Sg3jWZBk89KZh9ykUqi7xsEiJ+NCkZHLl9UsJ+M=
X-Google-Smtp-Source: AGHT+IGd2UPncUta7KQf8NzgD/JOap4QKZ0Wa261HFLaubMyoX62QVBXNKHgV7g7NUByvZFcQoxTcA==
X-Received: by 2002:a05:6e02:1d11:b0:352:a306:9ad1 with SMTP id
 i17-20020a056e021d1100b00352a3069ad1mr15139158ila.0.1696720396239; 
 Sat, 07 Oct 2023 16:13:16 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 15/27] console: Move SYS_PBSIZE into common/
Date: Sat,  7 Oct 2023 17:12:34 -0600
Message-ID: <20231007231255.277623-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

(no changes since v1)

 cmd/Kconfig    | 5 -----
 common/Kconfig | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f9e023730c53..96ea40109abd 100644
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
index 5e79b5422178..16601655caf7 100644
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
2.42.0.609.gbb76f46606-goog

