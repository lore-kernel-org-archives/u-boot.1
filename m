Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44308C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 08:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B08088E94;
	Mon, 16 Sep 2024 10:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YRGRyJ0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2968E88E26; Mon, 16 Sep 2024 10:24:53 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6AC88E70
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 10:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=al.kochet@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5365cf5de24so5116449e87.1
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726475090; x=1727079890; darn=lists.denx.de;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=POgL0z3u+quVXfwKtWrIXKyHq94o80HLbbX7RVLsFbk=;
 b=YRGRyJ0rARONFTKXnL73y1Oq7NRVF2oBv9vL1oUVZAtSViQknTOE6hPDu27Je900s9
 D+E77QCEg2o7XrvKsG7T+GVbcHC/4zAEfIl2Ym/YqEJ4K0ljJyDiyTmlIYjlxxPtNvy1
 iE7joswruWY/BpLVzfSw9f7IwOL0Sv4NS95mxBMlILFgbDSbfQvnFIcUL76rBhRQIy2T
 GdNMrsTl0JRxlUhFnG4TeXeWGXJmt7OM74KpReWK4rJXgIiMBM/yb+UnfifXVfwmX5Cd
 VmuWA2lbEH0WnPM/RVt/Orpo3J0c8aIlLI+swop+nnui+hFuKiqVjbd6VoJBO9PN9uX8
 7vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726475090; x=1727079890;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=POgL0z3u+quVXfwKtWrIXKyHq94o80HLbbX7RVLsFbk=;
 b=CuoFBg9lrDrlgY84GEisIy0FWqfZGhC/8bWeyDeXa0AVQf/YfcCkALu5cgslpIvRQz
 ydEBezszF9hjTtWnFxHzDK8CrGxGTd5JrqloiU4ZXV+nyA21T3h+C5p4Ih2NcLbnWIgc
 /9x+uUllvCbT6MXExmCb8ZS3lcGksJfwhBtWonwYjO69QeaBDzkFOKZKaWHslM/wiN91
 S/aLfZS7HXyxOEuV5lgDcxhBwUi51KM24AHJKyVwLgRnNnoLuk6RM7JyPnw2WfogymQK
 qOzdaHnaOCtj2WqpenWAXZD8/CVfAc2em2sUTtFo8y3Sh6UVJk1osFf5uJmgZ3dPeg4L
 l8Ew==
X-Gm-Message-State: AOJu0Yx1Pvaaz70jbOAEqgxDFR0Cm1I5j9b4G7kKR2aD4GFq0OqRzWWg
 YxCkS8uuJroOTjhaNfl9C/I+Ve/6sJvzeQqIMLu08iCqbcI2trrfx0tFqw==
X-Google-Smtp-Source: AGHT+IFsPyC2PwJkBDxytnFR2fnSeoUiZwQKasfL/QCze49W2imDutRupM8jR3qRPbVLL+Wp/193sw==
X-Received: by 2002:ac2:4e08:0:b0:535:674a:2c18 with SMTP id
 2adb3069b0e04-53678fbfb65mr7451180e87.32.1726475090008; 
 Mon, 16 Sep 2024 01:24:50 -0700 (PDT)
Received: from localhost.localdomain ([80.87.144.137])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5368704dca5sm804367e87.111.2024.09.16.01.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:24:49 -0700 (PDT)
From: al.kochet@gmail.com
To: u-boot@lists.denx.de
Cc: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH 1/3] binman: fix passing loadables to mkimage on first run
Date: Mon, 16 Sep 2024 11:24:44 +0300
Message-Id: <20240916082446.32082-2-al.kochet@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240916082446.32082-1-al.kochet@gmail.com>
References: <20240916082446.32082-1-al.kochet@gmail.com>
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

From: Alexander Kochetkov <al.kochet@gmail.com>

FIT use mkimage from BuildSectionData() to build FIT entry contents.
BuildSectionData() get called several times during building FIT image.

Currently when fit inserts loadables, it use self._loadables property that
contain loadables computed during previuos BuildSectionData() invocation.
So for the first run it use empty list and pass no loadables to mkimage.

That makes problem for adding signature to FIT image because mkimage
fails to add signature and aborts building FIT if no loadables provided.

The patch fixes described behaviour in a way that BuildSectionData() uses
recently calculated loadables value, not previosly calculated.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 tools/binman/etype/fit.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 2c14b15b03..e96222f4b6 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -542,8 +542,8 @@ class Entry_fit(Entry_section):
             """
             val = fdt_util.GetStringList(node, 'fit,firmware')
             if val is None:
-                return None, self._loadables
-            valid_entries = list(self._loadables)
+                return None, loadables
+            valid_entries = list(loadables)
             for name, entry in self.GetEntries().items():
                 missing = []
                 entry.CheckMissing(missing)
@@ -558,7 +558,7 @@ class Entry_fit(Entry_section):
                         firmware = name
                     elif name not in result:
                         result.append(name)
-            for name in self._loadables:
+            for name in loadables:
                 if name != firmware and name not in result:
                     result.append(name)
             return firmware, result
-- 
2.17.1

