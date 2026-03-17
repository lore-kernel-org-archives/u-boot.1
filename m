Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415FDFD875E
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 13:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ADF684222;
	Tue, 17 Mar 2026 14:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nnt9OqkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA5A8428C; Tue, 17 Mar 2026 14:19:17 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EE7A841FA
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 14:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-67ba8095a87so3452828eaf.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773753553; x=1774358353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7acx1ZkhHvqmg4qNJf9WU8HPbaJzCawrXQVyg+qj+EA=;
 b=nnt9OqkPoZNXO6WY9yC3cHVdinORTTd5hvbdgokyynFk1O5l4EwFRxrMQLB6sHMlQE
 foEOxtn5Ppm0WlS8lI2ibVAZAR3cLrQK4zqe4O1+q6R+hNdhk4kiQnSfkZ1qQdZVxrfX
 kepKAfiK2K4t8rmlIx/sGhwCYLs5jgkmB0OHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773753553; x=1774358353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7acx1ZkhHvqmg4qNJf9WU8HPbaJzCawrXQVyg+qj+EA=;
 b=DrfwtqDWJE62qw5XlJLLXP55M3vGyM0vLDonKfSVLvv1vzflM/7n62x5I/DLh3O/8W
 E9V2wEb9qiz7H4uwTWPE6BY5zVj8xO7SQLv/bUB81RrsoH/ML8ImYIwuUOqK1+ILi3uH
 BHz94GpcRZ5TBo5YZpJBJYY/TtJTDHcrFQ7n7o/yqmtsdGB1eD65y1TSBPSM2bGQ91g6
 qQVZiyT2Gj7X+Q0rJ1ux2lk8dSUZLhSQHN+Nz14jOwqmqhs8TmtLfgGfA6raUeiXi4jw
 gXvD2cPv/PQ2dOwfrdBHibZCi/5CEXHTQ6PLVk6oClKhhFeNJXDTnsHhh5NwB4xpjGEP
 ap5Q==
X-Gm-Message-State: AOJu0YwItI1n0nR5vo+SzTLaveqbn3aZllkt9K89wV2omtXvgRF5PpiS
 +EJb/pyXnoLVqjUQvMxrdY8DDtjqw5pvZE8witmAP4F1TKM6hm+GGsyb/0V27Y+Y57hKq164bNh
 EJc8=
X-Gm-Gg: ATEYQzwlHyyBrYfigNHTo3ricGZyqR6KuhL1JAQIwQENufYj8Al5EY1hzOUrS7osBe+
 o5Or0uHVgZtXFBzcBPXgubUU8Iml6t6omyZP+ehcU4WJRhIJc1vAyznF5zrzHgXl00qLCAJ0J31
 kV+IJ+Fd9DPkOPVzzYFWVdryCoXyiKYnJDpdgDGBHRSPKseoA4Njh56dLd/baR2zQcHb/zN+Dxc
 Vvk9NozAZiZacAKvE0I6rJO/gkWZ4Rw+UORoXUiDmFMiNj+ZLRjKYPzKAOwXosfwXHP0hRaOe9K
 vn+XhdiTX5144swHYKvz9DaflyJB5veCfhGcdY7RVe7WJc3ROQO5AWiWnKeRHy+9q5nBFoj+HQT
 b6IZRUVQC0xWF5LVqiasr9NsEMFVQCd8GzoyC3pVMVHTJW754Pgz7p9ttsQACRV2ae5sNDG9yxZ
 FDN9b8q2D9l3QEMgO0LA==
X-Received: by 2002:a05:6820:1988:b0:67b:b5db:f0df with SMTP id
 006d021491bc7-67bda98ca3fmr11676110eaf.12.1773753553046; 
 Tue, 17 Mar 2026 06:19:13 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc9118bc7sm12040840eaf.6.2026.03.17.06.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:19:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] CI: Update sjg lab to match currently actively boards
Date: Tue, 17 Mar 2026 07:18:35 -0600
Message-ID: <20260317131839.2418655-1-sjg@chromium.org>
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

Various updates:
- c4 lack signing so does not currently build
- samus hardware is non-functional
- colibrimx8, rockpro64, rock3a, rock5b, rpi5, tk1 and play are new

Signed-off-by: Simon Glass <sjg@chromium.org>

---
A sample run is here:

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/29552

At present, coral, play, rpi5, snow and vf2 appear to be genuinely
broken on -next

The ff3399 board needs some investigation.

 .gitlab-ci.yml | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 245e422d72f..8f92f464499 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -681,11 +681,6 @@ pcduino3_nano:
     ROLE: pcduino3_nano
   <<: *sjg_lab_dfn
 
-samus:
-  variables:
-    ROLE: samus
-  <<: *sjg_lab_dfn
-
 link:
   variables:
     ROLE: link
@@ -751,11 +746,6 @@ pine64:
     ROLE: pine64
   <<: *sjg_lab_dfn
 
-c4:
-  variables:
-    ROLE: c4
-  <<: *sjg_lab_dfn
-
 rpi4:
   variables:
     ROLE: rpi4
@@ -797,3 +787,39 @@ qemu-x86_64:
     ROLE: qemu-x86_64
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *sjg_lab_dfn
+
+colibrimx8:
+  variables:
+    ROLE: colibrimx8
+  <<: *sjg_lab_dfn
+
+rockpro64:
+  variables:
+    ROLE: rockpro64
+  <<: *sjg_lab_dfn
+
+rock3a:
+  variables:
+    ROLE: rock3a
+  <<: *sjg_lab_dfn
+
+rock5b:
+  variables:
+    ROLE: rock5b
+  <<: *sjg_lab_dfn
+
+rpi5:
+  variables:
+    ROLE: rpi5
+  <<: *sjg_lab_dfn
+
+# NVIDIA Jetson TK1
+tk1:
+  variables:
+    ROLE: tk1
+  <<: *sjg_lab_dfn
+
+play:
+  variables:
+    ROLE: play
+  <<: *sjg_lab_dfn
-- 
2.43.0

base-commit: a27980786cfb3c430aa1c05da8e79180c584d221
branch: laba-us
