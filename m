Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7738CA1012
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 22:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3F6835C9;
	Thu,  4 Sep 2025 00:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zdlIQQGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF5A8368E; Thu,  4 Sep 2025 00:09:53 +0200 (CEST)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F14C835C9
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 00:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-544a2cf582dso274414e0c.3
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 15:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756937389; x=1757542189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=74Xw4ABbwHlDyA4a1zIhFa2yyUJXri7vkKRKHBkVSgU=;
 b=zdlIQQGI5b59KxWyo31qZxx6RFI/MHbX5B12Q4fMJL04WAmk+5jmKIIYl94+/+TW5K
 damqe3nT/+P+ImVcKYVakDHcdpVduz+wacbFvQv8T3+A16FVfsSX6HmLIcLkBCGC429a
 /TRIC2acZLrjSTj4DF/7SUCqcaECRyvvSvW3NvpoGpDLiuLn2Vs6ePMJhw/j8AWMmpy0
 JeTKSvS+9LiSMusx8i5xtZLMoH6BoeNAUPV/gmvIRBNrfKt0SzK71lmI6CIX1j2iK5ft
 rV5IBZeWqSj6A1FbdrMvVB0/VYTlxwPxBhLpm3ntzk2KLRQ0E2uWopXKeoHas4neoN0E
 yChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756937389; x=1757542189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74Xw4ABbwHlDyA4a1zIhFa2yyUJXri7vkKRKHBkVSgU=;
 b=w+PGuwX1/V3TgsTwNkNzY1UR6O00cdkD8ImVhPntEvUFuycuE1jsbL0TTejwwMdMWq
 mB+sIMkEKDI5k+PS4IlINpv806mLFq6Or223yo5e643BjQ0XRXaQPIgey+HYZSkd64cn
 SeE/U6ZDoXD2gmzJ5RxXqcIIAMAkX0U/xQHh83KTc/8RVy+cVppqB3Sd5GP6hxLuMF83
 GoQgUuik+ZiY9DJkbVu9NpI28OFCqGnTBsCuJs5RQhW6z3nRJ8e/YPYjYvxAG1vCzplV
 wG2xCFCpjG+SapZPlvNma2UJxSCQmbeDaXERfPq5WhvESithbR+MBgQ4GVm8xwL7/yif
 YijQ==
X-Gm-Message-State: AOJu0YwekYKRqeSDosvoumubgeNCKGihXJRm2BgDWI7+6kqERJqhwRbp
 AyoUUZMFvoRlw6aH1gL3gO/xld+eTBHxTl7eb02v768uhNinzfjJ1qq0PyHNJ5yKOm7/drNeWUe
 dKC/7
X-Gm-Gg: ASbGncsHrb0Nm+ZlN82zi2ce15UCVUcOHzah61tHnCIR/E03kQ+n0wLQb98Nsu/lvwQ
 ZAfjx5nlRV5MTUX3wC5UazVIbD5uIfa1jCvSrxl2F+klfbap/eXxVanSlB2h6MDNNDsC55/cOdo
 9csnYPxiN07qeglm+IJcUOpbqjXKyQ46n1H6SLW92BYKH2yYfzf4ZdqxTpATrRJCTAQ3gUfmzy+
 xJCWh3k/Au+9T/C14CmkQc0JCpYOXp/TGDJL0dyl8QXLpnSKA1ORdWZHvSfxFjR/sVqbDO9XDDI
 ZxJh6b6V5A/XAazPGf56GbhNXkdI5OiQuWSXYGZXZW9ISOdgy8+b2Pp3YEyXlOLQR5y4RSSevzY
 cTnmN2IHwWsnIkh1J157tCpF0aO5hmVCL763S16j6d4nEvyZ72y7meZCmUu0=
X-Google-Smtp-Source: AGHT+IHA0pH6inYAk6eKYFDkZtBp+TV2XPS+yY/vH8vYxOs92UBK7fq312kdH/D5QEFv0FrFIgkFDg==
X-Received: by 2002:a05:6122:1acd:b0:539:4e00:dba0 with SMTP id
 71dfb90a1353d-544a015c5dbmr6687646e0c.4.1756937389234; 
 Wed, 03 Sep 2025 15:09:49 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-544912c7125sm7474211e0c.5.2025.09.03.15.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 15:09:48 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/4] doc: Update U-Boot coding style guide with
 clang-format usage
Date: Wed,  3 Sep 2025 16:09:41 -0600
Message-ID: <20250903220942.473282-5-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903220942.473282-1-javier.tia@linaro.org>
References: <20250903220942.473282-1-javier.tia@linaro.org>
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

