Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81096C369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE75F8070C;
	Thu,  1 May 2025 03:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P96M4/4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C030B8081A; Thu,  1 May 2025 03:25:40 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B858059D
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d9327d0720so3965495ab.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746062737; x=1746667537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uVtYdggRj3BbrDwXRKvk2iAPqqp1J3woZruqXFNbuOQ=;
 b=P96M4/4f4Q8jG1UnFZnJEwC2KHa42SZRnkZj8/vQqtAmfUxJk9WtZVhfyZnWgIQnwX
 Sr74ySf5PNp2rfcq+o2yJmKahTdTu1H5WmI0UHKMhJDIs8DAwQHOnDnE+u7m+bK4bWFN
 DQ7HqYarO5u3LxRfH6YuS2qhocZHzEb7EGSVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746062737; x=1746667537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uVtYdggRj3BbrDwXRKvk2iAPqqp1J3woZruqXFNbuOQ=;
 b=jNmaazG+9WgFXKj9Suw6kkyfxNURWgBBRJBNGEIjlOVUcbMzJnomQQj6l5kFwTONLZ
 kQ2JT0FX0wklxNmOizr0Icy71JYvXacyP2NArnZajBcCM5o7waSzdWxW1VmB79sl+pTM
 I3SPjfOkB9vREqbFiw9BedEA6nc3PvVEjjE7gggtfEjII5tQQE+kHbkpz6HewQ/V+v6x
 3IUSUVvbkOXVLBMhHmFeOUeiSmO10EpyPXnHbYh0NNjkvwPbwkpJO8TinZvwzqUvIkTx
 Nrc2md4T4FxKgAo7vNamACyB/MxoS4Mrb+IeYVlsTC1N1B14Eu8I64JweWnFrkbTM3K0
 saPQ==
X-Gm-Message-State: AOJu0YwI+JHGHocx3DlT+PXHI12Yoh1VLxLNb0Lwoq/M+80r/y0x3AZ+
 behM99dasaBMqnKzFUVVE3+ToPTSN0yxDAKzGAfPi08kw7SxYgU1i+4GKZa+SBlGF5T97GPU2BQ
 =
X-Gm-Gg: ASbGncuHvka/nz2RIXHc6PkkzjINAJ2rWU/mtVfH8fpeElE3kOmsWRRj7HSSqrYomWD
 f0BgE+Cf3L6FbGX8MMrwJAEkzG0pbFfAFtcu+RWV7jfIYrwOE3bsL76D/fB/KMFewKX2c9r50zc
 Pf6k9LwsvuwBBurAre8/LrJETpTekr5sQea8PHIbhFqV1cEh/pvpwqpnP9qGlQJGnvsThovrv1R
 2UN+qfwmLEnYLyEBhepMx5g11HUzQ5RGnxLhaR3tkq5HRrj1Urq81ei8vzRYMGX+YiKz3eNr2Br
 Uq1Bb62dc/vPDbsDiNgA16/gjyCoB5L0T97fzNx5KpQjkjWrHuABl90SQDUZh+H4PtItNi4k3yN
 w6w==
X-Google-Smtp-Source: AGHT+IGfkg09WPrBJYQvUxBrHc8zrnrxEKSP3fBIJnu4cFVZfDDwHf9pTkianhP+knoKkDfH6tsYuA==
X-Received: by 2002:a05:6e02:1c2b:b0:3d3:f6ee:cc4c with SMTP id
 e9e14a558f8ab-3d9675d7766mr60192615ab.0.1746062736697; 
 Wed, 30 Apr 2025 18:25:36 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f8631a1398sm996218173.140.2025.04.30.18.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:25:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH] CI: Update the CI lab
Date: Wed, 30 Apr 2025 19:25:24 -0600
Message-ID: <20250501012530.3954999-1-sjg@chromium.org>
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

Update the boards in the lab to match the current situation:

- bbb and pin64 are working again
- samus and c4 are still broken, with no end in sight
- new boards for colibrimx8, rockpro64, rock3a/5b, rpi5, zybo

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6f11331514b..d069ad952fa 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -622,10 +622,11 @@ pcduino3_nano:
     ROLE: pcduino3_nano
   <<: *lab_dfn
 
-samus:
-  variables:
-    ROLE: samus
-  <<: *lab_dfn
+# samus has a hardware failure 30-Nov-24
+#samus:
+#  variables:
+#    ROLE: samus
+#  <<: *lab_dfn
 
 link:
   variables:
@@ -692,10 +693,11 @@ pine64:
     ROLE: pine64
   <<: *lab_dfn
 
-c4:
-  variables:
-    ROLE: c4
-  <<: *lab_dfn
+# c4 needs binman supported added, so signing works
+#c4:
+#  variables:
+#    ROLE: c4
+#  <<: *lab_dfn
 
 rpi4:
   variables:
@@ -733,6 +735,36 @@ vf2:
     ROLE: vf2
   <<: *lab_dfn
 
+colibrimx8:
+  variables:
+    ROLE: colibrimx8
+  <<: *lab_dfn
+
+rockpro64:
+  variables:
+    ROLE: rockpro64
+  <<: *lab_dfn
+
+rock3a:
+  variables:
+    ROLE: rock3a
+  <<: *lab_dfn
+
+rock5b:
+  variables:
+    ROLE: rock5b
+  <<: *lab_dfn
+
+rpi5:
+  variables:
+    ROLE: rpi5
+  <<: *lab_dfn
+
+zybo:
+  variables:
+    ROLE: zybo
+  <<: *lab_dfn
+
 qemu-x86_64:
   variables:
     ROLE: qemu-x86_64
-- 
2.43.0

base-commit: f89124d10fcd1c8fa16bc3e5cc885b93945fe87d
branch: labe
