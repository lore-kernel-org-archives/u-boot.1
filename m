Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63414CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B82B48729D;
	Thu, 19 Oct 2023 17:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uFUjXoAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD9408743F; Thu, 19 Oct 2023 17:01:17 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90F6D87436
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a81ab75f21so82745627b3.2
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727672; x=1698332472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gbpKLc3XWLredxJ3UkJbSTXt9FehQqh44IDXIeRCEQo=;
 b=uFUjXoAWsftxnewTDwHF8z4lrfdIZT+1UtBvRiQR4tfXf+Tkhsec1T89DDVVzNeBQX
 ld5/qlzQRIj49ZL7JICUGAUBkkPmeo4XUX5+gKnddmHdctLLPc6ZoCrCZIkB/yR8eSAd
 MbQJeip7Q0QQOSN09+9FL/1wmkW6hC+AHq3dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727672; x=1698332472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gbpKLc3XWLredxJ3UkJbSTXt9FehQqh44IDXIeRCEQo=;
 b=MpZXrAgIwG1pUvgly+vn38dBzFh3IRVQFcS8ZbyoMrV9QxWUnAN/Lzkeh/PDlW0KS0
 DLNMH9unccALyASTRnCBsbzbIciPGeEGhjgfDBw5watS/cqfv6VcvV0SXqcXyf0WP4tm
 TnaaeAj/Ff+a+Es5xVrks6tx1CTF8DCc/l3kjzPlMNCla4qELFdC+mmeYpGTuLSKZ+yW
 nN1hiqCNCIpzwv3svvaYQB/LCdjufE2AXqwSWiRwBsUhl2qYXC6rGZqRDIaEI8r1DUIi
 TrttUknYAdAQ/bYfYHzvj4ghQFVUEQ14jlgPz+q2JEPk3O69mye0P2YeJcpxY5br6VhZ
 bHXA==
X-Gm-Message-State: AOJu0YyRK++FNxPSNXjAs8LNTBrQWE2Zzfb4J8ND+6QNojQnRrCsqkfU
 Lu1/wbudgd/naPmo+3PMgJrRw+SK0X9mOf9xgTcG7w==
X-Google-Smtp-Source: AGHT+IGgrwPS/hM+QrNNfKSuooDI2ku+WZE5tKlsZjKOukyuCzBgzkEF5PHLGmfN2Do6u+Q+rwlV2Q==
X-Received: by 2002:a05:690c:90:b0:5a8:22b5:399c with SMTP id
 be16-20020a05690c009000b005a822b5399cmr2751937ywb.24.1697727671643; 
 Thu, 19 Oct 2023 08:01:11 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v4 06/24] Kconfig: Move CONFIG_SYS_[CP]BSIZE to common/Kconfig
Date: Thu, 19 Oct 2023 11:00:47 -0400
Message-Id: <20231019150105.714407-6-trini@konsulko.com>
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
index 5554bd14e2ef..ecf25b062ad6 100644
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
index 93c96f23b013..fba1548e135b 100644
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

