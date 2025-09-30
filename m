Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D366CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 12:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1212F83071;
	Tue, 30 Sep 2025 14:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P23o7v0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5AC6832AD; Tue, 30 Sep 2025 14:53:41 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F7E83045
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 14:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-90f6d66e96dso1506080241.0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759236818; x=1759841618; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6oVKdWaJzYlb1iAIVJGOvYy0FH+9FsOhhBqTEt2Y0Gw=;
 b=P23o7v0kKHw23RGNn9XH6h+0CWVGoTg3aJrFJ5V8s9g7ujrmEu8FBsbyxUl951gC5x
 IQRPmnPYSVC6lt1xCfPJ+XFzWYxgoBt1/vm5r5vxr40HORtvdOdMCUT5wp7AgqV7sk6Z
 7SPc7lYcuUTYwWWMZ7SFIQOHIEvVw9GFBeeNlmk54bfX1L7U+lJJ4ngiPvdHRC6htypE
 iGxfuKiA80qhFCLH7P0VerA70LQRMyghrvMIAJB+S31bJ78cK+H8cnhHgMMmApdLz9NA
 otmwbbM+cXWgHOPOOdMf/IUUojYWytJGgessfPjoWg0jcIGjboPbuj39e5hQZE2j9a+3
 sXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759236818; x=1759841618;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6oVKdWaJzYlb1iAIVJGOvYy0FH+9FsOhhBqTEt2Y0Gw=;
 b=n3gmARa5pq2feZuIW/BZIq0S7ETmTAWO0mlLARBWAE0ogwVahk+Y9ZjUTJPg+Uidfe
 M7hqNk4nkJISGRei2kpFAnQdEJNX3YraTJjWrodXJTAzGXbrlWrVDU+ELtcTh86GEh1z
 hJFxujbOS0NvSARF6dcW/T3vVtry5SQg9eZYKqX7cNZkpEnYA2vU/z7fun+6txTKC97k
 iqrd6VKGXFWg/chDiOF8Awyat8zhbykS2k6HUKjuXUqLNOc+8WrXRrxecJqgi5oI0SMD
 udfysxb5eLsH1S/6QGMtUNmPzvIIDmQ2PlW4mbDVGBzm9QIHVY6Q5hos957YWbS98jUb
 qqeA==
X-Gm-Message-State: AOJu0YyKr/Im1nhy9Ypeli0ca/3geiiT8gdW8mZEy6kONC7Ndx0tJy4U
 opve/6dnm+27c/UicTQj1W4DVOW6IMOSRqAa7+MwCUAI0BlcnquwYICgZH/roHQLo6rM+YOWY9o
 /f64j
X-Gm-Gg: ASbGncvVJHlnqQ93rCuS2SRh+tcgjCq0KS0M/tI6GDnuZpSr990Kc9tzuQwBwvAyAUR
 0GueEQhKOgIcbsv02Wx7q404iJjlmO4+FHcVwK3htq4SUcMUSD44mCCwQ9F9RVUHk+ddHbebuVr
 kA3f+S3Zg/NfihGuPBm3fcDXKwNT/KvwWyrGXlTbrI32enGyHRB0LEevlHPtXuL8uHvIlxIAm3g
 hgtSdyOr56KvK86cM6NfUYNtThY6NEmNtze3A9tmofIj8kenuegomjhjCBu6j+SIDknKfoKl2wK
 NlJFl9WLpxW88p+pMYJuL9YTmUuUEg1SXb3IiDLsigjtOnmp8/7cmnUSzqfxf1wv6e7tHsB4mVE
 814Zd27EvFFHqpjiaUlcpvg3mHNvmViVRqF6cKcdd+4daLZzet0DChoZbbtDL2mbl38ncvir9+u
 NMYr441zvty0+KAiI=
X-Google-Smtp-Source: AGHT+IHwQrahf7/1MtjKtwzW2wSxGM1/+VdDXjC6kEEr8BVRXw2+9od8TBSeKP1dl2gOCOtIP+twOw==
X-Received: by 2002:a05:6102:f11:b0:524:bee7:aea7 with SMTP id
 ada2fe7eead31-5acd1c834ffmr7832140137.35.1759236817830; 
 Tue, 30 Sep 2025 05:53:37 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e.local ([177.93.10.188])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-916d1518f84sm3063914241.6.2025.09.30.05.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 05:53:37 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
Date: Tue, 30 Sep 2025 06:53:28 -0600
Subject: [PATCH v3] doc: Update coding style to recommend b4 for patch
 submission
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-b4-docs-v3-1-1fbf094347a8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMfS22gC/3WMwQrCMBBEf6Xs2ZVN2sTUk/8hHmKatgvSlESCU
 vrvpr2JeBreMPMWSD6yT3CuFog+c+IwFagPFbjRToNH7gqDJKmolS3eG+yCS6ips0pp6klbKOs
 5+p5fu+l6Kzxyeob43sVZbO2vIwsktEo7YYUpoS4PnmwMxxAH2CRZ/jlKFNicjDSqJ6Pr9uu4r
 usH1JFIk9gAAAA=
X-Change-ID: 20250929-b4-docs-60da5560f06a
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Javier Tia <javier.tia@linaro.org>
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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
Changes in v3:

* Update trailers
* Link to v2: https://lore.kernel.org/r/20250929-b4-docs-v2-1-478285f08639@linaro.org

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

