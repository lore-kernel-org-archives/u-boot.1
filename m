Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C7EE748ED
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 10:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D1F7870C5;
	Sun,  1 Oct 2023 12:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T1WRRfg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F113D870C6; Sun,  1 Oct 2023 12:00:52 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FAD8870B6
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 12:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3231df68584so11383580f8f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696154450; x=1696759250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPo8gLq6xXDg/aiaGtn38iTgCitr6s5cc9aGJghK5Gk=;
 b=T1WRRfg3jI0FXuuwnkYp/69BnKBKgFe3QfgA2Vm6pgs1iw1LgX3OZAPwRN9fnoT+Gx
 3qeRI3Sopw6xRCz8SNpiGFVHX0SfCaBcB4XMGcr1DEt9J5nP3LTpfbfj++uY6QJyY0AY
 d9epJHjq89VaTO5asf14J26kS276BIZSD/2Xm9CrYVzVZi+/Qq6QW3++0KnLFzrTEDeL
 VpbzVIRy9GXHq43uCXfyCItYbpf1gI5VyXYAwcxb7Lv3ggIkNBUQeN7o8wxyefysIt6e
 tC6muEfX27+rUzUzUMFjOx3qdlbxLNMiR+rTTkxEm6xZTaL9mF5RAzNKia2A5LJQ9OcG
 5g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696154450; x=1696759250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPo8gLq6xXDg/aiaGtn38iTgCitr6s5cc9aGJghK5Gk=;
 b=ZPzPZ41tD1BBScAHuUNKq+YV7WtA3bXmIYfWRbUjonvXAg4UaWE5Gsl348P5N9UcfF
 omgU0T8GmCIIjEK7jFwuwinHvN8ryATrtSxTwtCbbHVpNnT/gu8CrbYKvYfKGKNVZYhb
 lskOqHWYOSWuwaC/M7qGoTzu3LnglEmfGq1YCngfUdwQBZl6rt+pmR2dz7mfTCAVCn+F
 Djjy4hq1cHdJXXeSgR1hDMMw665tm0Tu8AjSLItT0/FhetPnEfpi00ECsu9hrnoipiQk
 H4sSJuWymuwoUyIVxSbFft7efUMjEIUWMD9MOZxzWVE5XFyWj3LouA/WDAIEVF/IAJns
 x71w==
X-Gm-Message-State: AOJu0YwaNyVxV5cP0gqBsLAMInjHesGULmOYQN7KrFTo99cYbm1pRSK5
 /BauCp3QvxhNJXBokGdMupK2rKPedz2LbMXM
X-Google-Smtp-Source: AGHT+IElBKu0jeapomOW6Pa0F1JGFpsDyIjZdpJTK2xAWMOuKTfpcHousXts4p7ZpWnoShjuHTUCVQ==
X-Received: by 2002:a5d:4e8a:0:b0:324:885f:f806 with SMTP id
 e10-20020a5d4e8a000000b00324885ff806mr8633595wru.56.1696154450024; 
 Sun, 01 Oct 2023 03:00:50 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b00326f5d0ce0asm3087135wrw.21.2023.10.01.03.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 03:00:49 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, Y.Moog@phytec.de,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v4 7/8] doc: add ide_integration.rst to doc/develop
Date: Sun,  1 Oct 2023 12:00:35 +0200
Message-ID: <20231001100036.34936-8-jmcosta944@gmail.com>
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

Add 'Integration with IDEs' chapter.

For now, this chapter is mostly a reference to the documentation of
gen_compile_commands, in doc/build, but it can be futurely used as
a guide for other IDE-friendly features.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 doc/develop/ide_integration.rst | 12 ++++++++++++
 doc/develop/index.rst           |  1 +
 2 files changed, 13 insertions(+)
 create mode 100644 doc/develop/ide_integration.rst

diff --git a/doc/develop/ide_integration.rst b/doc/develop/ide_integration.rst
new file mode 100644
index 0000000000..455e09959c
--- /dev/null
+++ b/doc/develop/ide_integration.rst
@@ -0,0 +1,12 @@
+Integration with IDEs
+=====================
+
+IDEs and text editors (e.g., VSCode, Emacs, Vim, Neovim) typically offer
+plugins to enhance the development experience, such as Clangd LSP. These
+plugins provide features like code navigation (i.e., jumping to definitions
+and declarations), code completion, and code formatting.
+
+U-Boot provides a script (i.e., scripts/gen_compile_commands.py) that
+generates a compilation database to be utilized by Clangd LSP for code
+navigation. For detailed usage instructions, please refer to the script's
+documentation: :doc:`../build/gen_compile_commands`.
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 5b230d0321..272bdef84d 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -19,6 +19,7 @@ General
    security
    sending_patches
    system_configuration
+   ide_integration
 
 Implementation
 --------------
-- 
2.41.0

