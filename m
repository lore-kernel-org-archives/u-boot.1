Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5B4C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6552D87B76;
	Thu, 26 Oct 2023 20:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SHgaYDCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8815C87646; Thu, 26 Oct 2023 20:31:49 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 585C98764B
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-777719639adso90961085a.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345106; x=1698949906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FU8vPKrZbSZKNvkxDosRzQQTNaXpRIdmK6BYvx7+xC8=;
 b=SHgaYDCjSZ5M5TuBYDr2u9MVm4Y8+DiMpBMammVc94Ahvkt2pmQuIxMtElfilpsECl
 oW6kdQ6/l+y6KaVaq4eOMbxh3sk7Xg8CGYhL/5omC/gaoGEirgZUia1IVAlCYlr9X3X2
 EacMZzlmyX7TMqyWwMni10pDvSvhRu6qI9Mao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345106; x=1698949906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FU8vPKrZbSZKNvkxDosRzQQTNaXpRIdmK6BYvx7+xC8=;
 b=vKZNt7pxIa6vnqIIIFVPbx74c64MHvsUGkWCcbCusA+a1ec+qpROvWmdIrUvEUZsDg
 cJ+DaLUJ8mTtSnhFHIpBzsmZyvLql4e0U7obYV32DWIpBMKw+l1nVVC1iFk3zWqkNJB0
 H3R7mtF5hBsS4SUWLO54hTDFxQNKF50Yw8y8gJOjerFq8ZU5twdTGF7292KWXDezD8GI
 CVAG83Q5xLf23bxQskqwoKTK/5Von0RNQvaC/3oNG8iEIIeDe3mxgGgfa2rNswVURH57
 4vglT21Aa+zKGyZIixPLe9RaJU+/ZR6BLxuwYLmSPOCaOFIOp1TlLnK+zIv/7L9TnAcg
 3OiA==
X-Gm-Message-State: AOJu0YxhtxvyzcTZ1UiSJKgn3rZpE0h51ALS1ooMeDOoS7RgCP3AyzQN
 XOWu3w0U1NfFH1jbx6Jeof+ux3nIdBxZdY0xnDDEag==
X-Google-Smtp-Source: AGHT+IFzgSbjSOV4154sP5PGWKHgE5S4N4XhG4PDYrbXZ8hI47xPplHdrEOv1gLtRkxFkFpoGS0aqQ==
X-Received: by 2002:a05:620a:8d02:b0:774:a9b:d62e with SMTP id
 rb2-20020a05620a8d0200b007740a9bd62emr124594qkn.46.1698345105771; 
 Thu, 26 Oct 2023 11:31:45 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.44
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v5 07/30] Kconfig: Move CONFIG_SYS_[CP]BSIZE to common/Kconfig
Date: Thu, 26 Oct 2023 14:31:15 -0400
Message-Id: <20231026183138.636948-7-trini@konsulko.com>
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

Move CONFIG_SYS_CBSIZE (console buffer size) and CONFIG_SYS_PBSIZE
(console print buffer size) out of cmd/Kconfig and in to common/Kconfig.
Create help entries for both which explain their usage and why they are
both not entirely command centric.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig    | 14 --------------
 common/Kconfig | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index cd2793b6876b..cbba39099659 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -75,20 +75,6 @@ config SYS_MAXARGS
 	int "Maximum number arguments accepted by commands"
 	default 16
 
-config SYS_CBSIZE
-	int "Console input buffer size"
-	default 2048 if ARCH_TEGRA || ARCH_VERSAL || ARCH_ZYNQ || ARCH_ZYNQMP || \
-		RCAR_GEN3 || TARGET_SOCFPGA_SOC64
-	default 512 if ARCH_MX5 || ARCH_MX6 || ARCH_MX7 || FSL_LSCH2 || \
-		FSL_LSCH3 || X86
-	default 256 if M68K || PPC
-	default 1024
-
-config SYS_PBSIZE
-	int "Buffer size for console output"
-	default 1024 if ARCH_SUNXI
-	default 1044
-
 config SYS_XTRACE
 	bool "Command execution tracer"
 	depends on CMDLINE
diff --git a/common/Kconfig b/common/Kconfig
index 43701fe9e897..4f7292f155db 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -52,6 +52,29 @@ config CONSOLE_RECORD_IN_SIZE
 	  The buffer is allocated immediately after the malloc() region is
 	  ready.
 
+config SYS_CBSIZE
+	int "Console input buffer size"
+	default 2048 if ARCH_TEGRA || ARCH_VERSAL || ARCH_ZYNQ || ARCH_ZYNQMP || \
+		RCAR_GEN3 || TARGET_SOCFPGA_SOC64
+	default 512 if ARCH_MX5 || ARCH_MX6 || ARCH_MX7 || FSL_LSCH2 || \
+		FSL_LSCH3 || X86
+	default 256 if M68K || PPC
+	default 1024
+	help
+	  Set the size of the console input buffer. This is used both in the
+	  case of reading input literally from the user in some manner as well
+	  as when we need to construct or modify that type of input, for
+	  example when constructing "bootargs" for the OS.
+
+config SYS_PBSIZE
+	int "Console output buffer size"
+	default 1024 if ARCH_SUNXI
+	default 1044
+	help
+	  Set the size of the console output buffer. This is used when we need
+	  to work with some form of a buffer while providing output in some
+	  form to the user.
+
 config DISABLE_CONSOLE
 	bool "Add functionality to disable console completely"
 	help
-- 
2.34.1

