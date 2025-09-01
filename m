Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B351CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 17:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 566D283A37;
	Mon,  1 Sep 2025 19:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sCQwoBL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 904DC83A28; Mon,  1 Sep 2025 19:48:07 +0200 (CEST)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 989B183A31
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 19:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5449432a9d7so1161522e0c.3
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756748883; x=1757353683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=74Xw4ABbwHlDyA4a1zIhFa2yyUJXri7vkKRKHBkVSgU=;
 b=sCQwoBL4A8tNaS2AFAUh6wZLEqfusMnI4rDFjH2JJ00sUXCfAeQ1vJGf1FikBkDtY7
 L1+uxXIEiEEGLL+DrvxPvvT7Qt3f/cJzvLOWu9I5KcSDve6K0AlItwjT3VSLgdYr6w5G
 CpSdvo46azDXix5aRdliMNKkGM9/AHslsOP8pCgRnRvvMaD1nE841I8He+bLDO4qQnvg
 j/i4h9JtI26F/vl619wrj/F8dwZqW7erlV6fabjsH0zmaHXGdeuf7VDbcwG5W+73nhH/
 JyB+NmQtw+2tADlvq25BLzk9Fp8VKix6km9nMEJlSiKy/hkKOPtFUmrJ+Ed7uTSxUhoy
 tlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756748883; x=1757353683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74Xw4ABbwHlDyA4a1zIhFa2yyUJXri7vkKRKHBkVSgU=;
 b=HdjEes3Jtn+Cd0h/gJBQGL3g632fcKmWaWTRN6EiyO4AsvShjyz0PyAB4z9N2BTC8c
 IEXjZ96C4x0/u1hwKmkEDcsPK9Qlvwlk7CAcj+QXs6tjiYaiwjYiiqPZCN7QgG9q2HaQ
 QMI0BOAMQEGda1+wt7OkAfrPlbJkrrmoFcEJ/07AojIU7SMfnFA3TVnFTJpHVDZMhrdF
 gViPcCj1yKwXcmM1ciOgRBjaUJsAz19HM1wQZwjLOKml708CDqP8u5i1oO9cFSRNBTpB
 42H5b+y4Z3UcUujvh5HRbAx6qpGLwAg9eqgaH0UwnwAuNq81hLRbEh4FdSFfsvrkOQzU
 9hPA==
X-Gm-Message-State: AOJu0YzK0+jb2zHwX7Iuy/MwSfLECJZOLrsdEVSZsmc/NTiPlvEvbGCh
 dZndOOjgz5vIyIJ3OIqqvmIzYrfbZFAmh2n2779fPaGQpd3UuAvhksiSKOJq/ATW2VSOnoHRroE
 CWUWj
X-Gm-Gg: ASbGncsrOgq6GBtCkEIMyUGto4EC4CUnTt+iDb0YVLqsY9TjDCEOSMReH9lsCKA0WXa
 hnmcmXBPa6F+R3ZQXvzFJUEVVUFawxQ16SjoPEbty9GxSxqAbhJWZeQLXDAsQbOAgrgsHG5IkED
 Uxzs5VF/l5ltL1fiETUTppHjOVAds0Rm5vLmucjcfyhUwykEajrpFanyCs+B5f2DMdwVEYnqcQL
 FMhT4gFXfo9pVlat9Q7v8n0c9RAuPQMVWucDQ4de6SuWvrlyARctoCD2+TxquxZTC7XeyHmIXa/
 IIrg7+QiTPcuVxLGAVOAhu4CSg86yT0AVd8iIiv+SIDIHzLpvqjhNnVBMqsJEqzEZeJP4ReUZeD
 UtGzqa+F8IueVJ5fQxuXvn61aX6uFXo+lMgIQIMNaC8OhXJ4h
X-Google-Smtp-Source: AGHT+IFmS6guWhWUlM4GgjzmiOW5hh3j6cdZoZnFiUZVcqbyAvzHiDFE7YmA0oxIMVzv+qSNHhE/NQ==
X-Received: by 2002:a05:6122:1792:b0:544:7364:ffc3 with SMTP id
 71dfb90a1353d-544a016e145mr2052734e0c.5.1756748883204; 
 Mon, 01 Sep 2025 10:48:03 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-54491464aebsm4670495e0c.14.2025.09.01.10.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 10:48:02 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 v2 4/4] doc: Update U-Boot coding style guide with
 clang-format usage
Date: Mon,  1 Sep 2025 11:47:55 -0600
Message-ID: <20250901174757.166162-5-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901174757.166162-1-javier.tia@linaro.org>
References: <20250901174757.166162-1-javier.tia@linaro.org>
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

