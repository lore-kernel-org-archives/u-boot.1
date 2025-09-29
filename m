Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B29CAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 20:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B53B832AD;
	Mon, 29 Sep 2025 22:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nz8xpgmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF1383448; Mon, 29 Sep 2025 22:39:54 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2AEB8329F
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 22:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-556f7e21432so3914061137.2
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759178391; x=1759783191; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I7gti4Hx3MBdbYHU33NN0uERijDVuCtodXxky+2AwaE=;
 b=nz8xpgmwlide13LEa+ymsdW12YZyUfEBEKjZwjE4RIM8fGRB2ajp4u7VMO4+HPbeJL
 6yM1TWJSiVVm8QKsc+VHkoJ1mZst3ZgchAYk0JyZ9LOGtnlFrvqb57gHJCu2QXWTN3Pz
 Cy8JxDfAcGVnVkLo/C0NzayE6rNvtLz0vJHxmY+nAvpWwCf5cZeUeC7YT9Sk48eWDLLS
 x5zVqG8ABUMWG7nlViBSHUiOc/7X2D42JxUkoH55Kc3KvHW+0ulTKY6iZnOTzpeJnoil
 VcozKLobn4OkAV1i6QwRiXu1nM316Ov1ptUuIigHCx9zui5aKMbVKHJHwCr9utMSRYn8
 7qKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759178391; x=1759783191;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7gti4Hx3MBdbYHU33NN0uERijDVuCtodXxky+2AwaE=;
 b=GIBd/Yi12LHHKg2V6bELotFOmDNDvKmZZfIYjeFjAbnVqx06yJJiGd2RPNgphNO5K4
 AzzaYW83EuBsOLFMzyZ+kdIQl4h8fuD0cYi7GxvdtUcrYOCmLNwi5z2/c4+DUNxVlj7y
 f5v9cEINY9F/wI0DNXTYIEgl/h0G+yEKSeOvEpgTB0NFDqbl8kfFEjnd1iZ9XGVGAezS
 nJ5RbZKnUkovWjFjY3FSI8IrfGpwqNiL3IFZG753dCEBRY1Ml4HhIDFe34nUkfrOncT3
 Zhci2WXzApX4I+F9hsOSXVIfFNBIkT7g0MLyfGM35L6M9T1uFz7vAqOLqorOQ+RJo3CY
 8PlA==
X-Gm-Message-State: AOJu0YxWE6AhfpQ9q9QNwOKTWIadDM4bVZ9c1lh1YryV5Mb/DFHdIsI0
 QoQj2Kf+yWlRb6UBUxTiGf6xgev9oDuh1JUIzfwSHhz4pB3yD/aOq3Fy3Zte1j3S2D9B4fcNlJ3
 i0W/p
X-Gm-Gg: ASbGnct6MHUlMP/btMdIQjQ0YIW6ITiIduUJZvsbmhFRGDRyHTyg3Y6F2JwJGwSiws3
 s9NwsOyZvynCDiXq1usyisVxLDHD0zF7xFnpFs3gh6jwzShrzAASyGL9+WGLDvVK3ehzS9vlfRn
 CUMn+ljrIdbwrVQLLZxe40GvYdidXZ+vtRWOvRc0t7T7QAn6hulDuJA4YkwJFWSGFuV3DkpTKL0
 OlTlZ4lL6lw+hhaqMlse6Qyav9XCOdpNHFUyiFJCc9aIwYoE2ISUo1BpdnwuCizfS9HIkI2AXEh
 AeKmoRKBb/aQKveMXGtTa+Ar8uOHAW+sLncjuRxPbfHggItdwM/mOBUX7+vlIfOkkaNUYasZQql
 uGMqbwi2G4bQDFIym+ee+VWn94Q5piJkb6aJJfv7rg6D2XN74TY7KxqC7
X-Google-Smtp-Source: AGHT+IGs2y2rqmfDHBWsP6S5Q8arLMiRhz5ixF4ssZvK4R5uXA42Eh17sJ9T1FAboD8w6wxEJrjcdw==
X-Received: by 2002:a05:6102:2ac5:b0:56c:eed1:276d with SMTP id
 ada2fe7eead31-5c88db08e28mr2310379137.18.1759178390657; 
 Mon, 29 Sep 2025 13:39:50 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e.local ([177.93.10.188])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-916d1518f84sm2651076241.6.2025.09.29.13.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 13:39:50 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
Date: Mon, 29 Sep 2025 14:39:28 -0600
Subject: [PATCH 1/2] doc: Update coding style to recommend b4 for patch
 submission
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-b4-docs-v1-1-a56c1a1856c5@linaro.org>
References: <20250929-b4-docs-v1-0-a56c1a1856c5@linaro.org>
In-Reply-To: <20250929-b4-docs-v1-0-a56c1a1856c5@linaro.org>
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

-- 
2.51.0

