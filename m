Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34951CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 23:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BE0683106;
	Sat, 30 Aug 2025 01:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U30rtCJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC5D835EA; Sat, 30 Aug 2025 01:40:00 +0200 (CEST)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93AB483106
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 01:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-528d8aa2f3bso759579137.2
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 16:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756510796; x=1757115596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=74Xw4ABbwHlDyA4a1zIhFa2yyUJXri7vkKRKHBkVSgU=;
 b=U30rtCJvA98OW1IVpjHx/Ki13CJZobO6lADAIi3NIah0853/4dVjHQvDsPqP76+ap2
 fRaS564Fkzs4GMJ+Ho6TmHT7rft9zSbS2aAqPRYk0hUC6xiwush/yFSKHA4WVGTFo1t8
 5lPkAQMrtrXm3s0k+s8wSYgXphkIuGaWuMxr0/5ea1TIFiBLPOe0ONHBJfX03aVn68By
 9m7aBmQayFT5CasLPb+DO2+hV3k0xGyIabYNTybAIv2tgpyNGS4d6RdIH6FjuR4D6Tlb
 cgM/Qx1UholKfv98I3+PpaVIAoudnEfnahCB/rXsHu6yZZPUIVVkMja0pxGCwqE98kHv
 68eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756510796; x=1757115596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74Xw4ABbwHlDyA4a1zIhFa2yyUJXri7vkKRKHBkVSgU=;
 b=GplM9IECke6UCFWStCzp5NIWVzE2ASS5jXoEyqyZHACJyspfl5DYVd4STQKQflAUJD
 xv50ezohzwTMXUafH+h5Kv42TKIeNmQoorM0yS7sq05L0pOzUa7qIQom/yESSM+E4yCH
 g9s2AQkPbO8pImoRSLsTrrqkR8X0GAjqjiHRKeQT2HQN5NSJQe+PJWAHn+zajDCZ6u7M
 D0gduDBIG/WHL6jxrYFwo98SsJqdo9EK7MoeYCYq4P1dQoBvjn0hkpxFJmoMhtv8YVbz
 6D5jTSXZZynj+L7XAnEjp+v8u90s/SN8w+BRgAKlIwXz+PL3WKckSjtxGt0h0PTwLbV0
 RObg==
X-Gm-Message-State: AOJu0YyhJtLEtuRZJvBNsxsE81zJIHTW4MXUf4SImiCesxcbaRdHErID
 dxs9H5P39F/odZCzNr14oDp3NJLUKMeb2itExXV3k/GtR+kRuvSsU2gFb+q+jkMDWr8YAKJRJ2u
 DMmkp
X-Gm-Gg: ASbGnctpn4y2cDdq67lMdlA3bYOdcy8iHoQBFbN7AyFjqXnJPLcDyAzoebS+kiyqnI2
 LG3AsewwGh40DwXUoXTcR+diZnF9sVs3Ohk3wj00sLf6om2JlzC/lMqsUsaxhm/sB5yHW/qpQ64
 DBqVwTMUSHlV5AcpSQrBZCllfSZwQOCsNK/OR3rzrbrjxMZhZiS53BO4RMx3vprXaFI4V9KP8Gr
 PW87OAcum4BCRh46m90ge9gTPpuq2lisCBJI0xFcARdvb2bAdD5bJpanwrPHM33xGiIpY0uYXkV
 jAf9hJQY34S65/2NGWngSF+jsupc5Q5366dqqqWYspl1cPZ05b6+U75TRUsXJDe5u/FK4I+tFBL
 Ac81/wKH+LhV3BHSrfFi8uirsX5oJS4JDfOStKYauJGs4xa5S515q3y7VJ/A=
X-Google-Smtp-Source: AGHT+IEJY3Nbs9gjvAbpASmOPrkOWYmpUUq9fF8EtsuwumyQm8kXseL5iiLQuv6ufgfe84lrC5xydQ==
X-Received: by 2002:a05:6102:c52:b0:522:e144:d758 with SMTP id
 ada2fe7eead31-52b1974e363mr107726137.3.1756510796221; 
 Fri, 29 Aug 2025 16:39:56 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-8943bb744fasm1360819241.15.2025.08.29.16.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 16:39:55 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 3/4] doc: Update U-Boot coding style guide with
 clang-format usage
Date: Fri, 29 Aug 2025 17:39:48 -0600
Message-ID: <20250829233951.547352-4-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829233951.547352-1-javier.tia@linaro.org>
References: <20250829233951.547352-1-javier.tia@linaro.org>
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

The U-Boot coding style guide has been updated to include information
about using the `.clang-format` configuration file for automatic code
formatting. This ensures consistent formatting across the entire
codebase and aligns with Linux kernel coding standards.

The guide now includes basic usage instructions for single and multiple
files, integration with Git, and examples of editor integrations. This
enhancement will help maintainers and contributors to easily adhere to
U-Boot coding standards.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 doc/develop/codingstyle.rst | 40 +++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index bc18b2ebb7b..77d8061faca 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -12,8 +12,9 @@ or only minimal changes.
 The following rules apply:
 
 * All contributions to U-Boot should conform to the `Linux kernel
-  coding style <https://www.kernel.org/doc/html/latest/process/coding-style.html>`_
-  and the `Lindent script <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Lindent>`_.
+  coding style <https://www.kernel.org/doc/html/latest/process/coding-style.html>`_.
+  U-Boot includes a `.clang-format` configuration file that can be used to
+  automatically format code according to these standards.
   * The exception for net files to the `multi-line comment
   <https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting>`_
   applies only to Linux, not to U-Boot. Only large hunks which are copied
@@ -23,6 +24,41 @@ The following rules apply:
   <https://peps.python.org/pep-0008/>`_. Use `pylint
   <https://github.com/pylint-dev/pylint>`_ for checking the code.
 
+Code Formatting with clang-format
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+U-Boot provides a `.clang-format` configuration file based on the Linux kernel
+configuration to help maintain consistent code formatting. Here are common ways
+to use clang-format:
+
+**Basic usage for single files:**
+
+.. code-block:: bash
+
+   clang-format -style=file -i <file>
+
+**Format multiple files:**
+
+.. code-block:: bash
+
+   find . -name '*.c' -o -name '*.h' | xargs clang-format -style=file -i
+
+**Integration with git (format only staged changes):**
+
+.. code-block:: bash
+
+   git clang-format
+
+**Editor integration examples:**
+
+* **Vim/Neovim:** Install vim-clang-format plugin
+* **Emacs:** Use clang-format.el
+* **VSCode:** Install "Clang-Format" extension
+* **Most IDEs:** Have built-in or plugin support for clang-format
+
+The `.clang-format` file in the repository root ensures consistent formatting
+across the entire codebase and aligns with Linux kernel coding standards.
+
 * Use patman to send your patches (``tools/patman/patman -H`` for full
   instructions). With a few tags in your commits this will check your patches
   and take care of emailing them.
-- 
2.51.0

