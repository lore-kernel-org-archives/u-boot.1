Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE282FCA16D
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 18:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27AD83A8C;
	Mon,  9 Mar 2026 19:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dkp4BaGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF46A83A8C; Mon,  9 Mar 2026 19:10:24 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D804A83A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 19:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d74aa6bcdbso719958a34.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 11:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773079794; x=1773684594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LdGkvKfqCaDxSTkOgbk0GCcGDHb44c1C0d2M3OT4O0U=;
 b=dkp4BaGkQA9e7ln9asGSkcI/mbqP/0Qkp8hdTxgYgS/m2SbQOT+JdCxYw7sq4GaJ0J
 gEnC5cE3srG6a3y8idzPyVLb0xBdHlc5V/LkkLTEI1NRQqh1FQapulfW8fSv1O12NeZe
 LOADWzNGCieGx3/fEpabjwqjqCSjV+UOnFcDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773079794; x=1773684594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LdGkvKfqCaDxSTkOgbk0GCcGDHb44c1C0d2M3OT4O0U=;
 b=mUWf4uvaoSrULs/WmA+L2XD06/hMC8UQMDLM27t1ax1HTYr0DUFWDS2hQrHczWd8wp
 I0Mjqh1OxPI7V47wmG8w9xLpaS2C44GNKoPioVjSrotD6PNJ5AchMDpNfWGS/72HPyWr
 pipO9g4Z4JIDyDrAq/LCM4UbYPjde7eXJWZMjlpdf4ZrvGTyAC7Oy+mJfsroD4Dd2DsY
 YeCn0ROdR9esVmFJ0E7rGlqKHHCaU6YhQaWQ/pCiDG1DTaDCt2P+BU8jsrj4We8bGSNj
 L4nC/OjyXYPYOXsSSzdJo7u/iLw97FIMhD2eXEskefGXePBS+5nj1npNy1Zpur0JrGwj
 mfrw==
X-Gm-Message-State: AOJu0YyX9cyy+Dy8cTkRvGChEiHUJTjjt/t7niyh5SxQbwmIiwMQ6O32
 cB8zC1Y6PPyt+mnn972ImkLfx1Ym84akvANBTxJFfGY9akShcz8vJ/het9Tc3M1HhyH2VTPvmtc
 GGBaVmww=
X-Gm-Gg: ATEYQzyVRo4SEEles7gw6+1e0EKU86jVY2AI3xMY2MQpCT3iwdNdrClC7w5ufVaWMAV
 U2B0r5s54LfakJROFVpUogGXD/EYKyUwsXHZw7BSTFAwkUu+5TkU9ChpF2tfAo4TvVmuUy+CmeA
 1OPvb7GNkJOlHoLccRxpDL6be1BwTKeK+cHGTgeAiU0L/OQpJj/FcmO8StovwusTpEGMWf+4b9p
 FLQjszmvBvomH9NBTyIKaRLZX9/Lq0ZnL+EGDR/QiBxilFyJ+gXOWovz+cSqCR3kTOjSfyca6h2
 lKzG1u646QtOXxosaXeQOYK6rPfec22t/RRVdkt80OS74huc4GVbCrJbwgH7/6IAQ7ZnuBmgrnV
 JiubexmgSHNb0HdfspC+2Syk0kQh24CWeyrSn+e1J6ks3YqxgqyBxTEeOCFAGXv28vCWCADU2Uh
 27phS1EgjGUgLwyfyddJUY5+hdsuXpZctycU7OZ1aFapBAVW4N4hBEedXp59WfK3eSq0nDXSGsM
 712bMmuEENqTT1tfWToN6qTpBaqpz3kjvyafC+i8UzZyNVQ
X-Received: by 2002:a05:6830:620f:b0:7cf:d30d:b12d with SMTP id
 46e09a7af769-7d72702d7e8mr8269442a34.32.1773079794542; 
 Mon, 09 Mar 2026 11:09:54 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d73adb0c1bsm4750258a34.26.2026.03.09.11.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:09:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] doc: Use sys.path.append for pytests being found
Date: Mon,  9 Mar 2026 12:09:52 -0600
Message-ID: <20260309180953.3640434-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Rather than having our "docs" build tagets modify PTYHONPATH, have
doc/conf.py append the required paths at runtime instead. This will
ensure that our builds from readthedocs will also find all of the
required files.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>

Currently this is empy for example:
https://docs.u-boot.org/en/latest/develop/pytest/test_bind.html
But with these changes:
https://u-boot--903.org.readthedocs.build/en/903/develop/pytest/test_bind.html
---
 Makefile    | 3 +--
 doc/conf.py | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5df869213b63..88543808ff58 100644
--- a/Makefile
+++ b/Makefile
@@ -2759,8 +2759,7 @@ DOC_TARGETS := xmldocs latexdocs pdfdocs htmldocs epubdocs cleandocs \
 	       linkcheckdocs dochelp refcheckdocs texinfodocs infodocs
 PHONY += $(DOC_TARGETS)
 $(DOC_TARGETS): scripts_basic FORCE
-	$(Q)PYTHONPATH=$(srctree)/test/py/tests:$(srctree)/test/py \
-	$(MAKE) $(build)=doc $@
+	$(Q)$(MAKE) $(build)=doc $@
 
 PHONY += checkstack ubootrelease ubootversion
 
diff --git a/doc/conf.py b/doc/conf.py
index 84d028feda83..bf60fe14315a 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -34,6 +34,8 @@ if os.environ.get("READTHEDOCS", "") == "True":
 # add these directories to sys.path here. If the directory is relative to the
 # documentation root, use os.path.abspath to make it absolute, like shown here.
 sys.path.insert(0, os.path.abspath('sphinx'))
+sys.path.append(os.path.abspath('../test/py/tests'))
+sys.path.append(os.path.abspath('../test/py'))
 from load_config import loadConfig
 
 # -- General configuration ------------------------------------------------
-- 
2.43.0

