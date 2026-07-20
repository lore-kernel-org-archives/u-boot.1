Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC29C4452A
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 13:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37B84844F6;
	Mon, 20 Jul 2026 15:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gCHKX1JR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1718384659; Mon, 20 Jul 2026 15:13:38 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 255E0838D7
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 15:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso11611835e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784553215; x=1785158015; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qtht9tfhTV3b0iiDMIW8Y8SGK+kHLdco2dg7cvmcEfs=;
 b=gCHKX1JRxb+uoYJrqRO0Q4cPwPZzzyrmMIvv1OyN4pDWLIruWMDs2DHX1lnVBVREeU
 NjHVsSdqy0Eki4FLPj8amXbwCnIPK2NtuqTZv1IMTyZxGjcrkYDrdoX2dZi6wly49/gy
 cYRgkMPaTrs2e6x4JC2SSFaq8bivTPGxkjKlxg7EbSub8eXEjCRAb4SJoODS4H+ef9a2
 TrD1ZJL+vISWAKVLEWnudjPBqI4WyXfC7ETq+jcEbkjngU/Cj2bqXMBlNAypJx50wQNW
 Y6HzZ0BdZ+E4KBDB74GcwtNsLH8cKSQ3TVC+g8ruUaZClWx6fcx0Vx6iWFdiz8ayXFBk
 ZjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784553215; x=1785158015;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qtht9tfhTV3b0iiDMIW8Y8SGK+kHLdco2dg7cvmcEfs=;
 b=BDEEorOn7vecrU5l+pnOt/uUXZlB0z70uDgoXlVHcUUIdM6Z1dO3WpIdCyRc3DcySl
 x5YEbvbeRAlCJviHJ4utmBiTdrkqOE62kkjCLHmpDD4FoYvYDNjFyD4k/ycFoBo9BCEm
 qA/oKascQJMMlSdznmnsrbS3KrrxFWDbQJafGg5a+3FFmP8qFUHYpbb1HdepfP8QtrYK
 g2yf/jH0ESWxQTXRtqE7cvNEFWjMJtaOsNlNSvJOGShNrBJx6bmsscDt6vVtgaDHWE1c
 6ZQTPY1JZpopcoQOJRoMMv9a90ULzytXDGwEmVhvHC5/HIJZ0pzDaUbd3pPQbDuLaXNk
 H+dQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJrfdSogmsCQR+WgIZIPJbFV+h3zzH5PdVs15RcIay7rps530rfVlJUK3C/i72ZoJJxQ5Kz8Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwRJ+KgI9a++CDNlkDMbiGOPJuDJh/HX2dWmY+77ciAveJSLmfC
 V/0CUBGrhe5nBa383L2Msoc+QqEe5o/xnbkqeap+iSHWo6yxc0FMBG+RV4AatXX7H1w=
X-Gm-Gg: AfdE7cmI9fiY0Dix4+/OkNcDWo388Higv6nv88qALtre+BA5G7bH/aOICu0dbi8cEvh
 qwh6hrR7Yjegqgj+8SNY2sFxyb0VlcYzurfhYjRIz+aE2XwT6QQmwbS/9Z0+wOcchIvIE7zCMMC
 8OzWFx1UVChYyad7Ya1VPZ0jN1HflYsZbmLB9Qt54unpLsJswWjS6xPLUBMVLVorsPolQf3E5wi
 zAPPA72TOR9bGtZrdw41SSX1z6VoNZp389RG2ZDqJR0S80G0jCsU0EZA0iC+fMr6pcx7ShegtGV
 0aEsNKoXd1i9gINSbHic5LFtHFcOSP965tzJAzZPZ1EqvrjUrpyQkTNlvkhI6ARBK1LXCRBNLX9
 BJiiVAkmLYxQ86VnGXHtG/KsZf0c/ScHPWIaaj277GRXkgPM+roHPZYM4pON7i/Wb2hsYIyEDZV
 cPQFqfQtjUMqwfuBzwFY8QfFW2sDVZAg==
X-Received: by 2002:a05:600c:285:b0:494:596e:e8c4 with SMTP id
 5b1f17b1804b1-4954a3fd583mr108160785e9.17.1784553215522; 
 Mon, 20 Jul 2026 06:13:35 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495499a5847sm202578675e9.2.2026.07.20.06.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:13:34 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH] CI: install python-cryptography for world build
Date: Mon, 20 Jul 2026 14:13:22 +0100
Message-ID: <20260720131325.37436-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.55.0
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

The mkmbn Python tool used for some Qualcomm platforms needs the
cryptography module, make sure it's installed so the world build can
succeed.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 .azure-pipelines.yml | 2 +-
 .gitlab-ci.yml       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 4417ef4e5a50..562c5747c9d3 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -733,9 +733,9 @@ stages:
           python3 -m venv /tmp/venv
           . /tmp/venv/bin/activate
           pip install -r tools/binman/requirements.txt \
             -r tools/buildman/requirements.txt \
-            setuptools
+            setuptools cryptography
           if [[ "${BUILDMAN}" != "" ]]; then
               ret=0;
               tools/buildman/buildman -o /tmp -PEWM ${BUILDMAN} ${OVERRIDE} || ret=$?;
               if [[ $ret -ne 0 ]]; then
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 245e422d72fa..eb13fde82b86 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -153,9 +153,9 @@ build all platforms in a single job:
     - python3 -m venv /tmp/venv;
       . /tmp/venv/bin/activate;
       pip install -r tools/binman/requirements.txt
         -r tools/buildman/requirements.txt
-        setuptools
+        setuptools cryptography
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
       ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=$?;
       if [[ $ret -ne 0 ]]; then
-- 
2.55.0

