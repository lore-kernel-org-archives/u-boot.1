Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE20EEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E070286AA5;
	Fri, 15 Sep 2023 02:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hiby9kRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F93F86A8F; Fri, 15 Sep 2023 02:23:09 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9425786A09
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-794d98181f0so52256239f.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737386; x=1695342186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNDJKVfwdWFEtR8CmYAZxHfxfzQtzcX5klS0ggfdFxE=;
 b=Hiby9kRCXZ6K+GDS2AFGSu59q43KpNs4U0VKMIeDTTiM+TQf/IThuRLQ/lxcjpCFzv
 SPmqT7nMAo57TTf6Y3x0/GGeS5vvEHRLPPQXRcmhibCHJeZVueCy9TMWB7OnzfJdmpdM
 gusMmM304Y5uGxrAMu+dx4M7KomMrO/pE3Lo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737386; x=1695342186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNDJKVfwdWFEtR8CmYAZxHfxfzQtzcX5klS0ggfdFxE=;
 b=Nq8hsEmRYAIL0HuQ5S6QN/3KJJM0QRjC8kenIgd26Swsvmx/wTOGainnlHvth1hi0q
 NoGvm+x3ZrkaFvkZqwuaX5Jycxee/uzqD6wv+/dwS+O/ssnAlcVCWNHGENsh6ehgE8jn
 aVGOULAaNGt4/Oxc9029O//tl1468BlPWAHv+XcKMFNkcsVxAiZmYsMtSYIDE+mfJ1cF
 nYklFYjxCwXlaMVKow8IMSjm7vyCljsXIazJ0Nr7md/tctlZnj55Yl0YaPKB3uTpjksH
 jAlN8b3/7FAp1A7AlgXwI0BjecidEzYuUmofS8Ewj6ox8XqJqGpbtab5tBPj0nnGsfik
 PWig==
X-Gm-Message-State: AOJu0YxBtrRRK2yn91P1fKFRZ2d0MTnr6HUQupHiLejYUGAjBUQ/qeY6
 n7djN/sfjMuWv/8B3uKfYU1BL2TskNygegeHYsI=
X-Google-Smtp-Source: AGHT+IEHim+ZIbRfxH/K0CHwmxsym8nJDzmK9c+E6ecRDp1aMn2Q0ZZQQ1mSS4ZapqLrqXEqktSg0w==
X-Received: by 2002:a6b:dd04:0:b0:794:cdd8:db3c with SMTP id
 f4-20020a6bdd04000000b00794cdd8db3cmr25969ioc.17.1694737386215; 
 Thu, 14 Sep 2023 17:23:06 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:23:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 25/27] moveconfig: Rename the tool to qconfig
Date: Thu, 14 Sep 2023 18:22:27 -0600
Message-ID: <20230915002236.798760-26-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

This does not move configs anymore, but queries them, based on a database
it can build. Rename the tool to better reflect its purpose.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/{moveconfig.py => qconfig.py} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename tools/{moveconfig.py => qconfig.py} (99%)

diff --git a/tools/moveconfig.py b/tools/qconfig.py
similarity index 99%
rename from tools/moveconfig.py
rename to tools/qconfig.py
index ed75d3277d60..dd55a696fda2 100755
--- a/tools/moveconfig.py
+++ b/tools/qconfig.py
@@ -5,7 +5,7 @@
 #
 
 """
-Move config options from headers to defconfig files.
+Build and query a Kconfig database for boards.
 
 See doc/develop/moveconfig.rst for documentation.
 """
@@ -900,7 +900,7 @@ def do_imply_config(config_list, add_imply, imply_flags, skip_added,
     all x86 boards will have that option, avoiding adding CONFIG_CMD_IRQ to
     each of the x86 defconfig files.
 
-    This function uses the moveconfig database to find such options. It
+    This function uses the qconfig database to find such options. It
     displays a list of things that could possibly imply those in the list.
     The algorithm ignores any that start with CONFIG_TARGET since these
     typically refer to only a few defconfigs (often one). It also does not
-- 
2.42.0.459.ge4e396fd5e-goog

