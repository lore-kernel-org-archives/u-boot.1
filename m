Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03EBCDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9E886F01;
	Tue, 17 Oct 2023 00:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RGWSJKF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6667186EE2; Tue, 17 Oct 2023 00:30:12 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8733586E16
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7743448d88eso361178285a.2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495378; x=1698100178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SemGp6nQKj5g1Wvk47KnhI8KMOi0K1XOmGNkRv47wQw=;
 b=RGWSJKF8xfHiksKb0hwJJ9Kj7zjSzXYxRR2qkVrAw3GbnjvLM0enJnt2QZkb4ELoq/
 79hhciNtERAui4kzSN7P2s2oI2pQcl9Djg6bWtn1MFJAAXC7BwAMqQvbK1BvmIclT7qB
 Q8KoSqX2hn8lEaao7VUe1jO1s/aGuxcFP17Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495378; x=1698100178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SemGp6nQKj5g1Wvk47KnhI8KMOi0K1XOmGNkRv47wQw=;
 b=TDOte+19xa2QcwMvxSEgDNgCYVv7bSfPT+Zxagqk0UYO+ZuUKDCdKUXVUBzM5YMBs8
 JSSx4MJMsjc6guc5Cji8PHgCrPxuFu9sapXodhKqjd03aE1svZs4tXVEF/HvP5vY02L6
 2LVBFCl35vA1VczTE8r1wx9PXaMuLNsvwN4MPyHV2HJ2I2336Ke+ei+UPgseCfNvmUM7
 hQPUbILjFBnQIl0O1/ORQwbtUALoeqVZnLNb3vYt4ZGECNbwpSEM0aGoc3bAdo+K6tyk
 tnahJ0hmDKF4Lds2kLT8YDsdxd3/SZa+UVakndxKfozMgklPfLIZRRD8n4xAOWVMjAV/
 6sGg==
X-Gm-Message-State: AOJu0YzE1c8zH+PU6wU7kRs8baMA4MzYBj1nszcVtzwT/bzSTc43d8hP
 F3yYBtELXrB3ggtOFPSjA/oFrrGoBWzpMfrwTOrMAA==
X-Google-Smtp-Source: AGHT+IFzElJeF7l4xMqMSr92qtXPltP4AcfhDK4a2bwhmFrL31oL4bFMKLfQ2RsZTpWv7asYtgiBHA==
X-Received: by 2002:a05:620a:4442:b0:771:31c:adcb with SMTP id
 w2-20020a05620a444200b00771031cadcbmr658120qkp.7.1697495378075; 
 Mon, 16 Oct 2023 15:29:38 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:29:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 04/32] cmd: Add a few more dependencies on CMDLINE
Date: Mon, 16 Oct 2023 16:27:55 -0600
Message-ID: <20231016222835.596572-5-sjg@chromium.org>
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

Add this to some more commands to avoid build errors with sandbox.

Note that this is a temporary solution to expose more problems. A later
patch puts these behind an 'if CMDLINE'

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add an explation as to why this patch is here

 cmd/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5bc0a92d57ad..00a7f84bce99 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -231,6 +231,7 @@ menu "Boot commands"
 
 config CMD_BOOTD
 	bool "bootd"
+	depends on CMDLINE
 	default y
 	help
 	  Run the command stored in the environment "bootcmd", i.e.
@@ -420,6 +421,7 @@ source lib/efi_selftest/Kconfig
 
 config CMD_BOOTMENU
 	bool "bootmenu"
+	depends on CMDLINE
 	select MENU
 	select CHARSET
 	help
@@ -486,6 +488,7 @@ config CMD_GO
 
 config CMD_RUN
 	bool "run"
+	depends on CMDLINE
 	default y
 	help
 	  Run the command in the given environment variable.
@@ -576,6 +579,7 @@ menu "Environment commands"
 
 config CMD_ASKENV
 	bool "ask for env variable"
+	depends on CMDLINE
 	help
 	  Ask for environment variable
 
@@ -2132,6 +2136,7 @@ config CMD_EFICONFIG
 
 config CMD_EXCEPTION
 	bool "exception - raise exception"
+	depends on CMDLINE
 	depends on ARM || RISCV || SANDBOX || X86
 	help
 	  Enable the 'exception' command which allows to raise an exception.
@@ -2238,6 +2243,7 @@ config CMD_SYSBOOT
 
 config CMD_QFW
 	bool "qfw"
+	depends on CMDLINE
 	select QFW
 	help
 	  This provides access to the QEMU firmware interface.  The main
-- 
2.42.0.655.g421f12c284-goog

