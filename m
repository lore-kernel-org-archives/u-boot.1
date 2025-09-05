Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B49CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 20:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B44BD83959;
	Fri,  5 Sep 2025 22:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y6gCjWJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D68378392E; Fri,  5 Sep 2025 22:53:59 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61DFF8391E
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 22:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-52912c1c805so1462496137.2
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757105636; x=1757710436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UizvHU+Mo4Eja0G/Jbt5lteUugv97BEZ9bguedPHiPk=;
 b=Y6gCjWJWtiaO3cPAKJiwX+Tw4hQNQnjDz36qun04XuU+kZzb9+Ns7XO92/YUG75J1r
 85ZmxupHxWuThQmWkkGYGDcjHdZMskHEv1Ymt/NNCAC2GgJ6DHC79XAFzVDh+mS5W4+Y
 OhMn6K7jFzvkZhFboEFhJ5OjUSxtxld+ArKsJEUB0C9vUUVhdQD2PYN1/PoVp+NQzlUi
 oRFC++gC4hYO57qcGBYZ/4+XCBdCokwVF1kKxRCkCQPSjXL/ZUzT5FQ6oceRqDkP5QFT
 JAM7rl2zI5GKhz82u9e2JkB2dMaamgJf0eEDFU8K284TDL+PrX7YezRvVUcX+rrYC7AD
 ubuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757105636; x=1757710436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UizvHU+Mo4Eja0G/Jbt5lteUugv97BEZ9bguedPHiPk=;
 b=e+K1cVKK9jAFUlzEkv+s47LVWGVe6nQcwQvc+HMSuRteukd6Qp72UYUNUEn4p3MQaQ
 W1bgJxFOOvcM95nmE89pgjM73mARepWHkwUdtGjV+s2bEX/imxlrFE8tT91eEl97QV0W
 uQqvqCAMRsDXe45+QjJJcTUvVxgLpCfYCfc6QUb1SvGfVoncm5zKN8f7NY7sFngtw5sC
 /t/1KjiZ1BTWk344R1y/AsQ1MMz6VlScyCQIQ3oKHe9wMfyZn3rbK1dyKH8jxKjVr2Oz
 aeBVzgg+v+I1kAe5PBFGxLuI+7IDcxgvWlaUfulHb4RLdzJL48g7XMx4fHwWwx6nBuoi
 SluQ==
X-Gm-Message-State: AOJu0YxySz6MwFj8DDwa91o5RQFPGI9/uGhIUMWP32NYu26pf7GVqGrY
 wUQHQzw3r+FPSdByMjtVzJ4M5mejTdrCzEtXhHtggWg2OjCdUiV8Lxai4jfIFWKKXXOW1ck9hJi
 345XI
X-Gm-Gg: ASbGncsboMzB8pJQ7fTYcC1hXoLjBl9D3oEq15gEQb4YIdZesQzTrxoENNukUBEhSCB
 fXepK0J8snCmWrXT8E/B3OVZ2kePOg5GBNKuIpDEJMHLevZF+NG/NbcCXl7OVmN4hU3tNYTm8Rd
 MSG9N/gsFBFquXDVaePhoVomqA/WUTFGmOd2mJnFiI9/E4wxYL8f5H3BG/4rXr4C1D+wbo7sOLd
 uSZZAWzfM4Mg/loP/GjiKvpjUNBLxQoZfy2g+kQnvRK5A2to3KZ3Foo1NAaKDMzdhPfzFOP0207
 59B7yvodtK63f0b4YthsJEsaAK7dmq/ySFwENSuhvgxph5i/OKYLIX3j0StLnjASH4zZ79ktO+J
 +OS8ty1ziy7/4QLMtf+odJ8lOjNS20SvM+nvuLg+Cw+6xxf2xILpFWy6nU2U=
X-Google-Smtp-Source: AGHT+IE0Od9r1MVzhc2ORf3CH68jRspJ7G19xml83n7hLfrwvUOOkn657SlnfrCxnGN07Epcb9KCXQ==
X-Received: by 2002:a05:6102:2923:b0:523:d0d7:b963 with SMTP id
 ada2fe7eead31-53d218dd0fcmr111136137.22.1757105635951; 
 Fri, 05 Sep 2025 13:53:55 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-52aef459c9asm8395330137.1.2025.09.05.13.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 13:53:55 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/4] doc: Update U-Boot coding style guide with
 clang-format usage
Date: Fri,  5 Sep 2025 14:53:47 -0600
Message-ID: <20250905205349.127333-5-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905205349.127333-1-javier.tia@linaro.org>
References: <20250905205349.127333-1-javier.tia@linaro.org>
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
codebase and aligns with Linux kernel coding standards. The goal with
introducing a predefined coding style is consistency rather than
personal preference.

The .clang-format file is copied directly from the Linux kernel without
any modifications, ensuring complete compatibility with kernel coding
standards.

Include comprehensive best practices for using clang-format,
specifically guidance on formatting only changed blocks versus entire
files, creating separate formatting-only commits for better code review,
and leveraging git clang-format for targeted formatting. Add examples of
editor integrations. This enhancement will help maintainers and
contributors to easily adhere to U-Boot coding standards.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 doc/develop/codingstyle.rst | 81 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index bc18b2ebb7b..10bfa747c6c 100644
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
@@ -23,6 +24,82 @@ The following rules apply:
   <https://peps.python.org/pep-0008/>`_. Use `pylint
   <https://github.com/pylint-dev/pylint>`_ for checking the code.
 
+Code Formatting with clang-format
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+U-Boot provides a `.clang-format` configuration file that was copied directly
+from the Linux kernel without any modifications, ensuring complete compatibility
+with kernel coding standards. Here are common ways to use clang-format:
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
+**Disabling clang-format for specific code blocks:**
+
+In some cases, you may want to disable automatic formatting for specific code
+sections, such as carefully formatted tables, assembly code, or imported code
+from other projects. Use the following comments to control formatting:
+
+.. code-block:: c
+
+   // clang-format off
+   static const struct register_config regs[] = {
+       { 0x1000, 0x12345678 },  // Base address register
+       { 0x1004, 0xabcdef00 },  // Control register
+       { 0x1008, 0x00000001 },  // Status register
+   };
+   // clang-format on
+
+**Controversial aspects of coding style enforcement:**
+
+Coding style enforcement can be controversial, and it's difficult to have one
+configuration that satisfies everyone's personal preferences. The goal of using
+clang-format is consistency across the codebase rather than accommodating
+individual preferences. While some developers may disagree with specific
+formatting choices, maintaining a uniform style throughout the project makes
+code more readable and maintainable for the entire development community.
+
+**Best practices for formatting:**
+
+When using clang-format to format code, consider these best practices:
+
+* **Format only changed blocks:** It's preferred to format only the blocks of
+  code that have been modified rather than entire files. This keeps diffs
+  focused on actual changes and makes code reviews easier.
+
+* **Separate formatting commits:** If you need to format entire files, create
+  a separate commit containing only formatting changes. This allows reviewers
+  to easily distinguish between functional changes and pure formatting updates.
+
+* **Use git clang-format:** The ``git clang-format`` command is particularly
+  useful as it formats only the lines that have been modified in your current
+  changes, avoiding unnecessary formatting of unchanged code.
+
 * Use patman to send your patches (``tools/patman/patman -H`` for full
   instructions). With a few tags in your commits this will check your patches
   and take care of emailing them.
-- 
2.51.0

