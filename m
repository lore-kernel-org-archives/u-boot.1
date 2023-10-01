Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83722E748ED
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 10:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9A65870B2;
	Sun,  1 Oct 2023 12:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h1BPAI2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781B0870B0; Sun,  1 Oct 2023 12:00:49 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F419870A4
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 12:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so15452210f8f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 03:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696154446; x=1696759246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7hb2jrvivQxON1XeovwgMxiW+RYRxZdLPP3zp29do4=;
 b=h1BPAI2EK56GVTvHRb8kjUXu2AmBcHMSQOEMjx1QzRo138EaVCUCpioknd8fv4wk8v
 g3BuyWVhHhkLpn8abGXZSdeyIch80PL9OgQ4OAsKu3BfO9q3FNBRdC8xI6kXTPxCuri4
 C+fLVh+rFQx4Cpoefd2nEBwH64ghAoOJ0OlZA+zx6YyhgOuDhUlOMLq20HhrvPmKwjFd
 b04O+myV3d436W6E/UzOQD4JSuZ7JCE7nknij/Oz4ItQrsZ0Nh06RTmEUmkbK/4W6Rf5
 b38Yg2rNG+IHk8lBjI1Watlb4Ek5g7XIGmUaCGMAe1OF5yUjKf415o+YCeOVF3M18gHy
 FCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696154446; x=1696759246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7hb2jrvivQxON1XeovwgMxiW+RYRxZdLPP3zp29do4=;
 b=fpqXvtgs8QAYOOdbJxUv7SYtMif/rUQN6wg6m+ExF3ak3cojJg7rWn7dRrG2lEWtt5
 Gw4TeFPZ1hsalhjKA/UoeIY5u77QPqngMrYBLqbG/PhzriZgpcmieAbsqqeyf9cPi/S7
 LzUVR3QiaIB7prch4lOgflJNttGF0f5tHeMiETu/gOxLXLyV9fScphgAmnHbEapzY0O4
 fHxTS7wcT2Jyl8y/cE4o8ceOWyzauCojFZdP98KBzAvO5xxoAmgnpqZIViA9rc7r8LJG
 kutp8VBUIlyvHHDFIBZ45p1X8UBVlLQAEy30xfABtd1gtm1laK/ePi1wGs0jxUr4a8uW
 bR7A==
X-Gm-Message-State: AOJu0YzZLAL2aOvwVqOIqeigZg6JDSNrSAqRgCy5KY6EMi/kMTeE+B+y
 8DN+Y8sicV/FrcmWyldYnlEhP9JEGrZ/wT8i
X-Google-Smtp-Source: AGHT+IG9NAQIlnI6iBtqVSWtzZdlQQOR4aabP2QdX+oK/Y0NXmZ7m1Ui2rQ/udx2lCloN2Di8i2tOQ==
X-Received: by 2002:adf:ea84:0:b0:321:6f5f:78ab with SMTP id
 s4-20020adfea84000000b003216f5f78abmr7065573wrm.56.1696154446258; 
 Sun, 01 Oct 2023 03:00:46 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b00326f5d0ce0asm3087135wrw.21.2023.10.01.03.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 03:00:45 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, Y.Moog@phytec.de,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v4 2/8] scripts/gen_compile_commands.py: adapt _LINE_PATTERN
Date: Sun,  1 Oct 2023 12:00:30 +0200
Message-ID: <20231001100036.34936-3-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231001100036.34936-1-jmcosta944@gmail.com>
References: <20231001100036.34936-1-jmcosta944@gmail.com>
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

For U-Boot's context, the regular expression defined by _LINE_PATTERN
should be adapted. Replace 'savedcmd' by 'cmd'.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 scripts/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 15ba56527a..0227522959 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -19,7 +19,7 @@ _DEFAULT_OUTPUT = 'compile_commands.json'
 _DEFAULT_LOG_LEVEL = 'WARNING'
 
 _FILENAME_PATTERN = r'^\..*\.cmd$'
-_LINE_PATTERN = r'^savedcmd_[^ ]*\.o := (.* )([^ ]*\.c) *(;|$)'
+_LINE_PATTERN = r'^cmd_[^ ]*\.o := (.* )([^ ]*\.c) *(;|$)'
 _VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
 # The tools/ directory adopts a different build system, and produces .cmd
 # files in a different format. Do not support it.
-- 
2.41.0

