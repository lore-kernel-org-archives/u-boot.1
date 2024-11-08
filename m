Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C88D5C0EF
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE5C890B9;
	Fri,  8 Nov 2024 16:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hUfHepwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA7588DF1; Fri,  8 Nov 2024 16:24:06 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E54891E9
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 16:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-83ab5b4b048so84717039f.2
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 07:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731079441; x=1731684241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFxdZnMYbm1Ua/F7HlsWbcjLRimg5Mp7oi/AdNVGT4M=;
 b=hUfHepwboMmoIpchf3XdJFnCFCtNIDptuVtDzOu0Ssr+SkG9/gj1Ego4ahhGQxnq5E
 zlTxBAuhM/7Nvv6DSHu6O6q7/sPi2cSzRO2uI3sy6HCxQYh8c1snaybbs5OvzB2SLN2V
 aYJZr4cQKza/3192YA3l8qnS4qrj7NZlBT8XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731079441; x=1731684241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFxdZnMYbm1Ua/F7HlsWbcjLRimg5Mp7oi/AdNVGT4M=;
 b=pDEOxuTLVmBO8fcNSI9q2jiQxm07pegBX1bPazNy2WkMYAguZVPGttR480ggHuxRK2
 g/K8Pm70oaO3z5H0KLZOu+gFsgzM3FIF6G37mjcOWudf0KHtLNLmu23uGdpQLqfsRbtg
 0Ki/zTeHN7vMNrSzXI4AtN7DZHklhc4/hHPplzOS0QJ/hsTw0UKIZwZOvrlaxwyIQgmj
 g2l/stWGRnDJ4jpvCU5yRrbP3JoPcWE/U5C5xNQMwY/XXc8wrehQ6nPhoa2JBsXHaHG/
 To+RV3qjrEvlcbwVNn3n5ePXxYCcBhHo991xUi4AnlD49gKxtMkpm8TuYHfktPT1zK2y
 +T+g==
X-Gm-Message-State: AOJu0YyqETKPsuZJ5wlsAl6eud/0txT0Kuwn9oXPE6Xbe9fV1cZL+Vf2
 k6Q28LMDKOtiqWBwyhHZ4YwXmeQv211lz6R97+ahBOpUK64ageSlm4D+b8EicJp9PC0c2qDpMR8
 =
X-Google-Smtp-Source: AGHT+IEG+37wi5fpRLK2Of72+wdMS30g0711Y/jx7wXU/w9JRFqee8VPHoIbmWI5qx3nhbAr+SBHsQ==
X-Received: by 2002:a05:6602:2c84:b0:837:7e21:1688 with SMTP id
 ca18e2360f4ac-83e033433d4mr335170539f.11.1731079440967; 
 Fri, 08 Nov 2024 07:24:00 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de5f7e3283sm864420173.6.2024.11.08.07.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:23:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/9] buildman: Correct the indentation in the setting-up
 section
Date: Fri,  8 Nov 2024 08:23:45 -0700
Message-Id: <20241108152350.3686274-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108152350.3686274-1-sjg@chromium.org>
References: <20241108152350.3686274-1-sjg@chromium.org>
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

The example settings file should be indented so that it shows correctly
in the output. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/buildman.rst | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 8acf236f2b3..5eda01fd5e1 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -186,23 +186,22 @@ Setting up
 #. Create ~/.buildman to tell buildman where to find tool chains (see
    buildman_settings_ for details). As an example::
 
-   # Buildman settings file
+      # Buildman settings file
 
-   [toolchain]
-   root: /
-   rest: /toolchains/*
-   eldk: /opt/eldk-4.2
-   arm: /opt/linaro/gcc-linaro-arm-linux-gnueabihf-4.8-2013.08_linux
-   aarch64: /opt/linaro/gcc-linaro-aarch64-none-elf-4.8-2013.10_linux
+      [toolchain]
+      root: /
+      rest: /toolchains/*
+      eldk: /opt/eldk-4.2
+      arm: /opt/linaro/gcc-linaro-arm-linux-gnueabihf-4.8-2013.08_linux
+      aarch64: /opt/linaro/gcc-linaro-aarch64-none-elf-4.8-2013.10_linux
 
-   [toolchain-prefix]
-   arc = /opt/arc/arc_gnu_2021.03_prebuilt_elf32_le_linux_install/bin/arc-elf32-
-
-   [toolchain-alias]
-   riscv = riscv32
-   sh = sh4
-   x86: i386
+      [toolchain-prefix]
+      arc = /opt/arc/arc_gnu_2021.03_prebuilt_elf32_le_linux_install/bin/arc-elf32-
 
+      [toolchain-alias]
+      riscv = riscv32
+      sh = sh4
+      x86: i386
 
    This selects the available toolchain paths. Add the base directory for
    each of your toolchains here. Buildman will search inside these directories
-- 
2.34.1

