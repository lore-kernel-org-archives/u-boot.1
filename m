Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDEECDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490E286F14;
	Tue, 17 Oct 2023 00:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lyVw3o7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F1DD86F26; Tue, 17 Oct 2023 00:31:03 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C8A86E37
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-77433e7a876so357002885a.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495444; x=1698100244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7teMQPpn8niVNhOZk6rW2MlOItjm/Yj77K3fK9Kc+B8=;
 b=lyVw3o7wCrnSYaP6o/Cl8fi5oLroxJFlHPszbJGetXtc+9wADhCFvCIihh0YQAj7Zk
 3fUB2Cex+Rm20CGBGkcLCyGPByf6UgSQ9y28Pf3irpddUij5JjRvKDSYCP8Koiq4znXP
 M7gGetNsPGW0zz7LajuI4fL6OSXvAwOsueWGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495444; x=1698100244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7teMQPpn8niVNhOZk6rW2MlOItjm/Yj77K3fK9Kc+B8=;
 b=S/4+iVZXxRGf2AY8vB5H+q8EOVVYdmZZhpZPlcwlanaZvm/UiWfZ0TvoZ9eBai+HzS
 oLk16e+5Y/Y1DfdxQycfO8pjPk5ZKQ6ufDLB6J8FsCxRPOq83TEpY6PwA9g/GYCwRpjt
 hZEhDs0gMHgzNGdrgmvTNX69qapR/DJ14saAIAEk2K7y22fec6vJyVa8jeRmwx6bcD/k
 FLki6mAtUnkgzdanpJnYXmoAStuUtZVpvm6l90D5HBWzzudUzv04AuQS90djpggM1RjD
 SEFrKwa5ijfmD3/xIxZH8G7mjRn7/5+eMoDYlq1wdrqu2ljWW1nQMmQ9BNAPMl2WUrxn
 m0rQ==
X-Gm-Message-State: AOJu0YzzA/hZzDzeIftm6tAcH3mmSs0HrhUIy0dLaqYFYX0Yo7+t1r/y
 K3LNsSYTawMAAR/Z5l2zZQrWF06OyTuvP15Z7UIGdw==
X-Google-Smtp-Source: AGHT+IH6FyaP0Ne1OJXtq2iWTsdVujJ4JOx9+RjBFuHMapRuUjWeehL4vZMTuRz0MoaacPVAxzoO0g==
X-Received: by 2002:a05:620a:1d81:b0:768:1e00:76c4 with SMTP id
 pj1-20020a05620a1d8100b007681e0076c4mr518466qkn.51.1697495444263; 
 Mon, 16 Oct 2023 15:30:44 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:30:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 13/32] console: Move SYS_PBSIZE into common/
Date: Mon, 16 Oct 2023 16:28:04 -0600
Message-ID: <20231016222835.596572-14-sjg@chromium.org>
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

This relates to printing output and does not need a command line. Move
it next to the other console-related options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/Kconfig    | 5 -----
 common/Kconfig | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 18be3da972d2..148414f011df 100644
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
index 93c96f23b013..1ffb055744d9 100644
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
2.42.0.655.g421f12c284-goog

