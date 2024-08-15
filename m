Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28C7C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 19:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA7F88AA8;
	Thu, 15 Aug 2024 21:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nqs3uy/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D04EF88AA7; Thu, 15 Aug 2024 21:58:08 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E249788A77
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 21:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81f86fd93acso47892539f.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723751880; x=1724356680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BkzvDGwp2fzpvMg69UjmqsH1jrXRU6w3gE/niNUEpJk=;
 b=Nqs3uy/JMfRMD9Y2EZMUwQg5A/XyhZv7U9C9hVlkdacZy23M8rF31cJe3NjL190wkt
 Prqgn8eTZbh6QhNKoTFHbwelW+z7GCNbO+pnrtzlyNFNcDnjkPr7LpMQpMRtQzrZcOfc
 v7ie6TMJ0quRoe/o/svCl+cGWR/b66rmoFnxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723751880; x=1724356680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BkzvDGwp2fzpvMg69UjmqsH1jrXRU6w3gE/niNUEpJk=;
 b=H+0KEi+qfXuq/Z+Suvohp3HYstMVKdZbw5MGw49w+h1E29b6F1AabJgp7iL6A6NBDM
 kEQQKfCs7IsEjBEDxPKDdTBSE/e0y1almf7DVBmBFlPvSP6Wkws0AL6l7KoDv1VyquWs
 OwAwSuaAZilmmkk68UJryuNs6kVO6n+7QFbruWdTiAn1x4obFNCke0AES+uB7CROegVr
 1FNsqPD5RtYIAT3tffFj526aq0QonIGg2jS8WVvSI4Djj9CbAt7c9SIulRxs0WGW/wuG
 O/HWeTGWZnIncZcC/ChZFEr1vfeNzmT/zCk2PMOZxnKWdjZDiiL9db+YEQyTbKvTZ2Lq
 xunQ==
X-Gm-Message-State: AOJu0Yz9g7djT2PXQTCCDeGZV/sDZcWdcUzoAW2QLdM306Nrpkb6T5xK
 BRjW5eKSLVlo85AQKs+zPCxeBZBaYb2U7CWE4LdeSmiT/rKMh2hS6wIgP7dmnpdnZH6j2Y7Wk95
 4pw==
X-Google-Smtp-Source: AGHT+IG7MKv9JLlg/mT5MhpQzKVWypn/Hz1P8dUX6dhzzHWyyTmMpqodWlkhyAkAa1ZFuXnpVmhV/A==
X-Received: by 2002:a05:6602:6513:b0:7fb:c0c8:2fc7 with SMTP id
 ca18e2360f4ac-824e78544b6mr380172539f.3.1723751880473; 
 Thu, 15 Aug 2024 12:58:00 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ccd6f3e3f2sm697372173.100.2024.08.15.12.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 12:58:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 3/3] RFC: CI: Skip building dtc for world builds
Date: Thu, 15 Aug 2024 13:57:46 -0600
Message-Id: <20240815195746.749042-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815195746.749042-1-sjg@chromium.org>
References: <20240815195746.749042-1-sjg@chromium.org>
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

This is quite a significant waste of time in the world builds as dtc is
built separately for each board. Skip this to speed up the builds.

Unfortunately the newer dtc produces a lot of warnings, which causes CI
to fail. I am not sure what we can do about this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Drop patches previously applied
- Add dtc patches

 .azure-pipelines.yml | 2 +-
 .gitlab-ci.yml       | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index e1b2f87b974..4bdf1daa59c 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -561,7 +561,7 @@ stages:
           cat << "EOF" >> build.sh
           if [[ "${BUILDMAN}" != "" ]]; then
               ret=0;
-              tools/buildman/buildman -o /tmp -PEWM ${BUILDMAN} ${OVERRIDE} || ret=$?;
+              tools/buildman/buildman -o /tmp -PEWM --dtc-skip ${BUILDMAN} ${OVERRIDE} || ret=$?;
               if [[ $ret -ne 0 ]]; then
                   tools/buildman/buildman -o /tmp -seP ${BUILDMAN};
                   exit $ret;
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0a15b7352cd..b231b6cd5a4 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -104,7 +104,7 @@ build all 32bit ARM platforms:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
       pip install -r tools/buildman/requirements.txt;
-      ./tools/buildman/buildman -o /tmp -PEWM arm -x aarch64 || ret=$?;
+      ./tools/buildman/buildman -o /tmp -PEWM --dtc-skip arm -x aarch64 || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
         exit $ret;
@@ -118,7 +118,7 @@ build all 64bit ARM platforms:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
       pip install -r tools/buildman/requirements.txt;
-      ./tools/buildman/buildman -o /tmp -PEWM aarch64 || ret=$?;
+      ./tools/buildman/buildman -o /tmp -PEWM --dtc-skip aarch64 || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
         exit $ret;
@@ -129,7 +129,7 @@ build all PowerPC platforms:
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      ./tools/buildman/buildman -o /tmp -P -E -W powerpc || ret=$?;
+      ./tools/buildman/buildman -o /tmp -PEW --dtc-skip powerpc || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
         exit $ret;
@@ -140,7 +140,7 @@ build all other platforms:
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      ./tools/buildman/buildman -o /tmp -PEWM -x arm,powerpc || ret=$?;
+      ./tools/buildman/buildman -o /tmp -PEWM --dtc-skip -x arm,powerpc || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
         exit $ret;
-- 
2.34.1

