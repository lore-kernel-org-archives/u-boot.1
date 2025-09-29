Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139F5CAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 20:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 785F88319C;
	Mon, 29 Sep 2025 22:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uIHu42ET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73646832AD; Mon, 29 Sep 2025 22:59:18 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F67882A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 22:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-89018e97232so1050315241.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 13:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759179554; x=1759784354; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yVQ02PRUuSSPNLOT5GE3nUXkGUAaEpMc2UoZmQV2bpY=;
 b=uIHu42ETYs3jWbQB7+McC9c+sAb0DnN6TT1jZgfS9+1jYsWnoGmJ11ZPngSmm6iK4y
 mJJGVOFhIyZ7j20pxa/XukUvLGgsp470SLEh1b8jSoS9jzQb5OABgOB392X8k6Lonm+g
 wSPrzV0wqG0Z0uklTZmhIOwTIYl0ir8xiv0vl93Z0TxqqkbXUfGna0oNTD+d+RbA4iyf
 g2V9actr8RKrSLFUrb7Bi9rV2S7VeoUXul8PhgVqvwpOAf0bUnMUvNK434ESGXCfTgcH
 JKmpEhB8tL+peW5Ysx2eEk8cL79Iqg0YGDicuj941FTOpp6McIG6ckZrpaAqrmEhsiSM
 vDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759179554; x=1759784354;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yVQ02PRUuSSPNLOT5GE3nUXkGUAaEpMc2UoZmQV2bpY=;
 b=PV3DDikbwEQb74rskEkCb0TXTvxCTVOfsp74NZkDe9Lxi2r27WEdEZvSASeEv9asfr
 0LXbBULgbQpsMUlAvlQWExD2EoYx1fIeISPqHAVTV9/Oa5w3En/LVhgB0SeNZhO1ynPq
 xZQ/HJoLfSCwBYRrgcGGMFVOOhx2wVP4OO3fVLDv9sRVptpU8rGHt41vV7JhNwObTlm9
 vQ4BTd8G06jERPOkl2X5QaJ9k5HCEezNkogBCgSw5bOI4jvlLLkcXbyOPP6Lywe7LejR
 EH1DCRpcdRjHVbTxZwHc6PzQjLKdCd51zj6zExkbYdOAl51wsf92IPOE6xQW7LUXWCWN
 mjZw==
X-Gm-Message-State: AOJu0YzG1KdplSPjgszTpQBM8vvgf7q92Hf9fz3IVvqtz4en90lnd7Z3
 aWi4XNqajxUJ0xC4/caWXzYE4fiRNuh7tGPxtBfhOULh13+UcmiZVZUO5PTyfCe+Xvp8hMiZfUA
 WNOs2
X-Gm-Gg: ASbGncvgLzkAM9WXEvYwvwJKv/hIQMaJXT85sjEdAv4FBdCQXHJ0MYUMKPWQ6qFgj13
 Z2o7k70Q524wIMUUY6ngz57XNA6eokUdesUm91Zi49QWU8b1UdtJkd7bnvBG47CBBNwhEvAe5HA
 S5rJ8kRSGH9crIdTBP/SYPpEH2r2qrCCNkXWX8eTq/HcbMstWsxva46Tts3tkKJTJIVwPi2vVs2
 c1C05JOjo3C10UBG58JhdOOQLWIVsbX39N1yNH6Audgp3BgoFlsiTnYH2pThcmnYLHZtfbpeajm
 MKZNCUxC4NcVy9IWOL1Jy8e/BhJYTG8ZcgZmwd3CBxNRUb00G4B3mlm3pO//Audc7+o8JNm3VY3
 q1GUNO3uFDzbgRWXc3/zkul83FvCuPEA7oy4d4pbj34r6he1yqYL8KjW/
X-Google-Smtp-Source: AGHT+IEFeRppmoZNAtcGLt+OYgXxtmoEGksd1qENIfb9L196O7WSHb7pk8qC/V6P7C/cTBKv7aUMrg==
X-Received: by 2002:a05:6102:c4a:b0:525:df9e:9365 with SMTP id
 ada2fe7eead31-5accd2151f1mr7306696137.16.1759179553836; 
 Mon, 29 Sep 2025 13:59:13 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e.local ([177.93.10.188])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-916d878c126sm2610922241.11.2025.09.29.13.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 13:59:13 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
Date: Mon, 29 Sep 2025 14:58:54 -0600
Subject: [PATCH v2] doc: Update coding style to recommend b4 for patch
 submission
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-b4-docs-v2-1-478285f08639@linaro.org>
X-B4-Tracking: v=1; b=H4sIAA3z2mgC/2WMQQrCMBBFr1Jm7UgSTLCuvId0MSZpOyCJTCQoJ
 Xc3duvq8z6Pt0GJwrHAZdhAYuXCOXUwhwH8SmmJyKEzGGWsGs2I9xOG7As6Fchap2blCLr9lDj
 zey/dps4rl1eWzx6u+vf+N6pGhWSd16TPfez1wYkkH7MsMLXWvmEcX+ifAAAA
X-Change-ID: 20250929-b4-docs-60da5560f06a
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Javier Tia <javier.tia@linaro.org>
X-Mailer: b4 0.14.2
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

Replace references to patman with b4 as the recommended tool for
preparing and sending patches. b4 is widely adopted in the Linux kernel
community and U-Boot ships with configuration to simplify its use with
the project mailing list.

The updated guidelines describe how to prepare series with b4, handle
cover letters and recipient lists, run style checks, and send patches
safely. Instructions also highlight how to collect and apply review tags
before resending.

This change documents the preferred workflow for contributors and
ensures consistency with common practices across related upstream
communities.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
This small series updates U-Boot's contributor guidelines to sync with
current best practices around Linux kernel patch submission. It should
make contributing smoother for new developers.

The first patch updates doc/develop/codingstyle.rst to recommend the b4
tool instead of patman as the standard workflow for preparing and
sending patches. The revised documentation explains how to create and
manage series, run style checks, handle cover letters, discover mailing
list recipients, and collect review tags. This reflects widespread
adoption of b4 in the Linux kernel community and ensures U-Boot
contributors follow consistent, upstream-friendly practices.
---
Changes in v2:

* Drop commit changing .b4-config
* Link to v1: https://lore.kernel.org/r/20250929-b4-docs-v1-0-a56c1a1856c5@linaro.org
---
 doc/develop/codingstyle.rst | 54 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index bc18b2ebb7b0fc875a299b9e2e5c64c3d6a8e2b3..8ed6babe4556423fe30effc504615e07a841f21a 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -23,13 +23,55 @@ The following rules apply:
   <https://peps.python.org/pep-0008/>`_. Use `pylint
   <https://github.com/pylint-dev/pylint>`_ for checking the code.
 
-* Use patman to send your patches (``tools/patman/patman -H`` for full
-  instructions). With a few tags in your commits this will check your patches
-  and take care of emailing them.
+* Use the `b4 <https://git.kernel.org/pub/scm/utils/b4/b4.git/>`_ tool to prepare and
+  send your patches. b4 has become the preferred tool to sending patches for many
+  Linux kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` that
+  targets ``u-boot@lists.denx.de`` and integrates with ``scripts/get_maintainer.pl`` for
+  recipient discovery.
 
-* If you don't use patman, make sure to run ``scripts/checkpatch.pl``. For
-  more information, read :doc:`checkpatch`. Note that this should be done
-  *before* posting on the mailing list!
+  Start a topical series with ``b4 prep`` and keep the commits organised with
+  ``git rebase -i``. ``b4 prep --edit-cover`` opens an editor for the cover
+  letter, while ``b4 prep --auto-to-cc`` collects reviewers and maintainers from
+  both the configuration file and ``scripts/get_maintainer.pl``.
+
+  .. code-block:: bash
+
+     b4 prep -n mmc-fixes
+     git rebase -i origin/master
+     b4 prep --edit-cover
+     b4 prep --auto-to-cc
+
+  Run the style checks before sending. ``b4 prep --check`` wraps the existing
+  tooling so you see the output from ``scripts/checkpatch.pl`` alongside b4's
+  own validation. You can always invoke ``scripts/checkpatch.pl`` directly for
+  additional runs.
+
+  .. code-block:: bash
+
+     b4 prep --check
+
+  When the series is ready, use ``b4 send``. Begin with ``--dry-run`` to review
+  the generated emails and ``--reflect`` to copy yourself for records before
+  dispatching to ``u-boot@lists.denx.de``.
+
+  .. code-block:: bash
+
+     b4 send --dry-run
+     b4 send --reflect
+     b4 send
+
+  After reviews arrive, collect Acked-by/Tested-by tags with ``b4 trailers -u``
+  and fold them into your commits before resending the updated series.
+
+  .. code-block:: bash
+
+     b4 trailers -u
+     git rebase -i origin/master
+     b4 send
+
+* Run ``scripts/checkpatch.pl`` directly or via ``b4 prep --check`` so that all
+  issues are resolved *before* posting on the mailing list. For more information,
+  read :doc:`checkpatch`.
 
 * Source files originating from different projects (for example the MTD
   subsystem or the hush shell code from the BusyBox project) may, after

---
base-commit: 26efc940c865a04d345ac9d39f71746fc2821da6
change-id: 20250929-b4-docs-60da5560f06a

Best regards,
-- 
Javier Tia <javier.tia@linaro.org>

