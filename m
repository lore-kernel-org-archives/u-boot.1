Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB992C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 19:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0161084832;
	Sun,  5 Jul 2026 21:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mDD3teWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AAA184105; Sun,  5 Jul 2026 21:33:11 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B063847C8
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 21:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a1160a2c42so1545523eaf.0
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783279987; x=1783884787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTlF6gWP4COFHRdoEA99Jdwl64JzGr2z680Dj+ekn4w=;
 b=mDD3teWy3/nWkPwVUqyH4nIz0l8OnUheZdI57OvzwPbMTqSh9vzd/QW4UMI7GUaY0C
 /VbKe+5Gu1oS6YiH7EAhF9a3o659Diw2fyJxYpFpi3NDdNsvyeP6n8V/iileQBuSGn0J
 jvo3Z0TkduA5C/lCBB+eL0EjC10xFNdnuaQ5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783279987; x=1783884787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TTlF6gWP4COFHRdoEA99Jdwl64JzGr2z680Dj+ekn4w=;
 b=tIx3kRJKHXmDDDWT63aE9IMvcPYhOajG9fz/S/teLK59FwJq8H5GdpxSNBC4xe9wGk
 sRW/bNH8gsG4W8Y6m5NXHeZrn+1c6zjffDA32WB3TPHlcp3m1anCmXX5pUG1FSc23Uub
 BnEt+ox0omoTIv+ZuyBzNDuDRDKEICtSOw+B5eYWvcXLr96e4x/sEKb7MqpLrSfITAJ5
 mH2/y6OKtyOKayZMWqSNIYpg56cvBBej3Y8qJRJRl1IG8EgjVgGR1OdIAlqI09c2bxtz
 tjnQ4rQukCjjfUFItqAjH2Dhsf2T9bMIbzbOYisM6M0rODNZld7bVnJLyIuiuedYJLfK
 71BQ==
X-Gm-Message-State: AOJu0YxVzOu8AotcL82wPhPBeFG7nJeY8gl5Lcy8R2wAWTOkX1lCVXsQ
 WHuj8PYJYxRkyIxniMpbXQfn+77frXJ6oHhrd9O/oT3ob2X0d9vEnQECTpvMGH0+atkZj25/mq6
 cLpDo4Q==
X-Gm-Gg: AfdE7cmmfLT7vgVxQuHJU+XMci94TuKxJ6LWvP6mcNWcVN4pQriqw/zjPuAMEL9Cd6h
 KfmY3L3fB/zfEHi5O2UYjdqQtMAS6PJObiFAw/s3zDTggAnGCxNPNiavjT4k66zX6xxaSM0PeP+
 xH0qVAEcZMFa+yfTkIUFe8tVWFbdQk0P9KJ6c87fL7vrw++TvOX+wLRaYW0ukrTQ205e4HFG/8L
 /0OEMaCyZihRCylhL2dxZA4CHvdqW187uLgPTouWwukLf+TXR7ojlImxBi6VK+HjqG3SnWRXfIA
 2wXmVNNlT+cmqXOYL99cEDR98Z+sC3MIwr96Rftj+cv1v+N5mgeUvJOecZxK6MVI+YwL7hLIIf3
 8VYz3mDUaD9BIme/fpF8kLU8OwbjGfyIIVVb1zNu3UQL3zqct8rXb9aHHKzgr04eCmV9WiTF9GL
 /QLws=
X-Received: by 2002:a4a:e913:0:b0:6a1:8d78:79bd with SMTP id
 006d021491bc7-6a32f44863cmr4150138eaf.8.1783279987122; 
 Sun, 05 Jul 2026 12:33:07 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a3103e064esm7513448eaf.14.2026.07.05.12.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:33:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Javier Tia <floss@jetm.me>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/11] doc: Move the b4 guide into sending_patches
Date: Sun,  5 Jul 2026 13:32:12 -0600
Message-ID: <20260705193251.2190705-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705193251.2190705-1-sjg@chromium.org>
References: <20260705193251.2190705-1-sjg@chromium.org>
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

The b4 contributor guide sits in the coding-style document, which is an
odd place for it. Move it into sending_patches.rst, next to the patman
note, so both patch-sending tools are described together.

The b4_contrib label moves with it, so the reference from process.rst
still resolves.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- New patch: move the b4 guide into sending_patches.rst

 doc/develop/codingstyle.rst     | 48 -------------------------------
 doc/develop/sending_patches.rst | 51 +++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 48 deletions(-)

diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index 26881cf3900..b8d2bf23a54 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -24,54 +24,6 @@ The following rules apply:
   <https://peps.python.org/pep-0008/>`_. Use `pylint
   <https://github.com/pylint-dev/pylint>`_ for checking the code.
 
-.. _b4_contrib:
-
-* Use the `b4 <https://b4.docs.kernel.org/en/latest/>`__ tool to prepare and
-  send your patches. b4 has become the preferred tool to sending patches for many
-  Linux kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` that
-  targets ``u-boot@lists.denx.de`` and integrates with ``scripts/get_maintainer.pl`` for
-  recipient discovery.
-
-  Start a topical series with ``b4 prep`` and keep the commits organised with
-  ``git rebase -i``. ``b4 prep --edit-cover`` opens an editor for the cover
-  letter, while ``b4 prep --auto-to-cc`` collects reviewers and maintainers from
-  both the configuration file and ``scripts/get_maintainer.pl``.
-
-  .. code-block:: bash
-
-     b4 prep -n mmc-fixes
-     git rebase -i origin/master
-     b4 prep --edit-cover
-     b4 prep --auto-to-cc
-
-  Run the style checks before sending. ``b4 prep --check`` wraps the existing
-  tooling so you see the output from ``scripts/checkpatch.pl`` alongside b4's
-  own validation. You can always invoke ``scripts/checkpatch.pl`` directly for
-  additional runs.
-
-  .. code-block:: bash
-
-     b4 prep --check
-
-  When the series is ready, use ``b4 send``. Begin with ``--dry-run`` to review
-  the generated emails and ``--reflect`` to copy yourself for records before
-  dispatching to ``u-boot@lists.denx.de``.
-
-  .. code-block:: bash
-
-     b4 send --dry-run
-     b4 send --reflect
-     b4 send
-
-  After reviews arrive, collect Acked-by/Tested-by tags with ``b4 trailers -u``
-  and fold them into your commits before resending the updated series.
-
-  .. code-block:: bash
-
-     b4 trailers -u
-     git rebase -i origin/master
-     b4 send
-
 * Run ``scripts/checkpatch.pl`` directly or via ``b4 prep --check`` so that all
   issues are resolved *before* posting on the mailing list. For more information,
   read :doc:`checkpatch`.
diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index e29fa175727..85f3003074f 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -17,6 +17,57 @@ A good introduction how to prepare for submitting patches can be found in the
 LWN article `How to Get Your Change Into the Linux Kernel
 <http://lwn.net/Articles/139918/>`_ as the same rules apply to U-Boot, too.
 
+.. _b4_contrib:
+
+Using b4
+--------
+
+Use the `b4 <https://b4.docs.kernel.org/en/latest/>`__ tool to prepare and send
+your patches. b4 has become the preferred tool to sending patches for many Linux
+kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` that
+targets ``u-boot@lists.denx.de`` and integrates with ``scripts/get_maintainer.pl``
+for recipient discovery.
+
+Start a topical series with ``b4 prep`` and keep the commits organised with
+``git rebase -i``. ``b4 prep --edit-cover`` opens an editor for the cover letter,
+while ``b4 prep --auto-to-cc`` collects reviewers and maintainers from both the
+configuration file and ``scripts/get_maintainer.pl``.
+
+.. code-block:: bash
+
+   b4 prep -n mmc-fixes
+   git rebase -i origin/master
+   b4 prep --edit-cover
+   b4 prep --auto-to-cc
+
+Run the style checks before sending. ``b4 prep --check`` wraps the existing
+tooling so you see the output from ``scripts/checkpatch.pl`` alongside b4's own
+validation. You can always invoke ``scripts/checkpatch.pl`` directly for
+additional runs.
+
+.. code-block:: bash
+
+   b4 prep --check
+
+When the series is ready, use ``b4 send``. Begin with ``--dry-run`` to review the
+generated emails and ``--reflect`` to copy yourself for records before
+dispatching to ``u-boot@lists.denx.de``.
+
+.. code-block:: bash
+
+   b4 send --dry-run
+   b4 send --reflect
+   b4 send
+
+After reviews arrive, collect Acked-by/Tested-by tags with ``b4 trailers -u`` and
+fold them into your commits before resending the updated series.
+
+.. code-block:: bash
+
+   b4 trailers -u
+   git rebase -i origin/master
+   b4 send
+
 Using patman
 ------------
 
-- 
2.43.0

