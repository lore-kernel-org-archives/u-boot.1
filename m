Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80BDC52D6F
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 03:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9C2588E90;
	Thu, 22 Aug 2024 04:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G4qi89GS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB55388E51; Thu, 22 Aug 2024 04:56:57 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ED5D88DA8
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-81f9339e52cso13925539f.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295414; x=1724900214; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zuFXfhZT+VhkGr/iJUpZVtkVEyaxCfxQccXFd56CYA=;
 b=G4qi89GSz8SFWt7fDYMoHlObMf6wsNf2wwIjdaVvwYbNfNqrsvHpmhMUKRwb1CjdDb
 iarxbaXy8Z0U+3NLBMzWX56l87nUaSuegoPxdHTGWCkqyVwgguf8KHpfJfpaJ4g+f9SQ
 nGIPoLnQjt8EmODOqLAxNOtGHNP4We1aukJ6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295414; x=1724900214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0zuFXfhZT+VhkGr/iJUpZVtkVEyaxCfxQccXFd56CYA=;
 b=jYMML9y14S2yI90PDLZ10Ip3wMS4nuO8mirode/IAc8BPUX1YfA8EaOkUrhjTJ95wO
 J5PD8pRJ6asVdUs6bi7RizowKi2Qg3Rgs0B4si4fmnCDNg/CkTKbS5OmVnFWMw70IKrk
 wtzUE1lE56GocaGyQW8bzMFxmjQqSV5qXYqoQNcAD+tNMT8GIyrMU1ulMrwIaVF81oWH
 8sLnUIa7b66wBYwRp9jPlB3kBjg8psNjI0XIZVPA7ODESP5HMHD2hpXcf43ly7zJOIxo
 KqbknoO614Gev4cn8Z/aD61lJ04GKE1ilABubLGKs1hrkfbXm7jRuOdUosH1kPbV8y46
 Z+1Q==
X-Gm-Message-State: AOJu0YzPNFD0uKXMUFrs7UvCT+TE5xZT/1hcQ1wZyDjC2bRcyeBPovNF
 6iWOgxZ8Ii+nXSwyJFEozSsbJkGr0m1dIHSMwdZszvT/EruTvlaXbZK78xmhCk0EiWKRkGUwqW0
 =
X-Google-Smtp-Source: AGHT+IFG5oy5M8ali3LW8D2c95FLgr5OFkJLUyoLPBW2RHiRTARJRumXaTiqoEhDyFyFzFAqo+ER4Q==
X-Received: by 2002:a05:6602:641a:b0:824:d5ff:6a55 with SMTP id
 ca18e2360f4ac-8252f4d09a0mr546713939f.16.1724295413714; 
 Wed, 21 Aug 2024 19:56:53 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v4 19/19] CI: Allow running tests on sjg lab
Date: Wed, 21 Aug 2024 20:56:31 -0600
Message-Id: <20240822025631.1838434-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822025631.1838434-1-sjg@chromium.org>
References: <20240822025631.1838434-1-sjg@chromium.org>
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

Add a way to run tests on a real hardware lab. This is in the very early
experimental stages. There are only 23 boards and 3 of those are broken!
(bob, ff3399, samus). A fourth fails due to problems with the TPM tests.

To try this, assuming you have gitlab access, set SJG_LAB=1, e.g.:

   git push -o ci.variable="SJG_LAB=1" dm HEAD:try

This relies on the two previous series targeted at -next as well as the
bugfix series for -master

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---

(no changes since v3)

Changes in v3:
- Split out most patches into two new series and update cover letter

Changes in v2:
- Avoid running a docker image for skipped lab tests

 .gitlab-ci.yml | 153 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0a15b7352cd..8586a472be1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -17,6 +17,7 @@ stages:
   - testsuites
   - test.py
   - world build
+  - sjg-lab
 
 .buildman_and_testpy_template: &buildman_and_testpy_dfn
   stage: test.py
@@ -491,3 +492,155 @@ coreboot test.py:
     TEST_PY_TEST_SPEC: "not sleep"
     TEST_PY_ID: "--id qemu"
   <<: *buildman_and_testpy_dfn
+
+.lab_template: &lab_dfn
+  stage: sjg-lab
+  rules:
+    - if: $SJG_LAB == "1"
+      when: always
+    - when: manual
+  tags: [ 'lab' ]
+  script:
+    - if [[ -z "${SJG_LAB}" ]]; then
+        exit 0;
+      fi
+    # Environment:
+    #   SRC  - source tree
+    #   OUT  - output directory for builds
+    - export SRC="$(pwd)"
+    - export OUT="${SRC}/build/${BOARD}"
+    - export PATH=$PATH:~/bin
+    - export PATH=$PATH:/vid/software/devel/ubtest/u-boot-test-hooks/bin
+
+    # Load it on the device
+    - ret=0
+    - echo "role ${ROLE}"
+    - export strategy="-s uboot -e off"
+    # export verbose="-v"
+    - ${SRC}/test/py/test.py --role ${ROLE} --build-dir "${OUT}"
+        --capture=tee-sys -k "not bootstd"|| ret=$?
+    - U_BOOT_BOARD_IDENTITY="${ROLE}" u-boot-test-release || true
+    - if [[ $ret -ne 0 ]]; then
+        exit $ret;
+      fi
+  artifacts:
+    when: always
+    paths:
+      - "build/${BOARD}/test-log.html"
+      - "build/${BOARD}/multiplexed_log.css"
+    expire_in: 1 week
+
+rpi3:
+  variables:
+    ROLE: rpi3
+  <<: *lab_dfn
+
+opi_pc:
+  variables:
+    ROLE: opi_pc
+  <<: *lab_dfn
+
+pcduino3_nano:
+  variables:
+    ROLE: pcduino3_nano
+  <<: *lab_dfn
+
+samus:
+  variables:
+    ROLE: samus
+  <<: *lab_dfn
+
+link:
+  variables:
+    ROLE: link
+  <<: *lab_dfn
+
+jerry:
+  variables:
+    ROLE: jerry
+  <<: *lab_dfn
+
+minnowmax:
+  variables:
+    ROLE: minnowmax
+  <<: *lab_dfn
+
+opi_pc2:
+  variables:
+    ROLE: opi_pc2
+  <<: *lab_dfn
+
+bpi:
+  variables:
+    ROLE: bpi
+  <<: *lab_dfn
+
+rpi2:
+  variables:
+    ROLE: rpi2
+  <<: *lab_dfn
+
+bob:
+  variables:
+    ROLE: bob
+  <<: *lab_dfn
+
+ff3399:
+  variables:
+    ROLE: ff3399
+  <<: *lab_dfn
+
+coral:
+  variables:
+    ROLE: coral
+  <<: *lab_dfn
+
+rpi3z:
+  variables:
+    ROLE: rpi3z
+  <<: *lab_dfn
+
+bbb:
+  variables:
+    ROLE: bbb
+  <<: *lab_dfn
+
+kevin:
+  variables:
+    ROLE: kevin
+  <<: *lab_dfn
+
+pine64:
+  variables:
+    ROLE: pine64
+  <<: *lab_dfn
+
+c4:
+  variables:
+    ROLE: c4
+  <<: *lab_dfn
+
+rpi4:
+  variables:
+    ROLE: rpi4
+  <<: *lab_dfn
+
+rpi0:
+  variables:
+    ROLE: rpi0
+  <<: *lab_dfn
+
+snow:
+  variables:
+    ROLE: snow
+  <<: *lab_dfn
+
+pcduino3:
+  variables:
+    ROLE: pcduino3
+  <<: *lab_dfn
+
+nyan-big:
+  variables:
+    ROLE: nyan-big
+  <<: *lab_dfn
-- 
2.34.1

