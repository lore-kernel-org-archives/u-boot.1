Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487C6C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73FD888405;
	Sun, 23 Jun 2024 22:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OWiFvgow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 218E2882E2; Sun, 23 Jun 2024 22:32:37 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECE8E87D07
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3748ebe7e53so15456095ab.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174753; x=1719779553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbhp7+Hqs9WgQGax9oyLn7OSXNw0V3NiIeKR6zbRazk=;
 b=OWiFvgowfmYRo6TQMJdL4dWHpztJcf6QghpzmsyNgwUnnXHFhQCYcRnazxNm6K8C2m
 /NS3gEyRKDSwFTr748LO5g0fY8Fs5cWpSLh89UI+d8rjEaG9QD8Nefa1uaGT70Ucd98p
 xUzDV9WDab8hTQMENF3QCxf1PydivtDwZUO3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174753; x=1719779553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nbhp7+Hqs9WgQGax9oyLn7OSXNw0V3NiIeKR6zbRazk=;
 b=r3e4+KcC5LXYzxFADnt17mAUOppnu6DZPUJJYxuyxjPYWz4KdmnuOKCDJYnQQYT7GA
 zSQyHEkTBKYU33o2lx37WMGK5NNqlQyCvmVmxsSUUATk5qRpv2zMy7Px03iwf3+cEYSI
 8trKMESixI7/Bvk/lep8SKwsP7cEwxB0E9TbIOZqwuNglxFu0mEFICayLCfgW2nX+9Ar
 DLdPXOIL1w1uzx8VpvLS0nSS39xgQ8uJS01iSS8fEb1iU50dJy2GOTx9SAeW6AUeotTY
 W9PLnnbGwKId5YPSThR49kyYUvs3ACW5LgkYim8csy4g6LM7oWi4wlESv6t5XqDKLfy5
 McuQ==
X-Gm-Message-State: AOJu0YxeU0OC5QuTL1TTrnj9rvHbig6B+MYcGgOOFlGoKwtbPHnPv2I6
 nPJ96vTGkr0wLpnMeQekgz5nh5dO5+HcSgy6+mLdnBQhEy7Gcu1Cvo5lIagjaBPg2RlVcOOn5In
 Whw==
X-Google-Smtp-Source: AGHT+IGS7a6o7hTC6JeuqOgOu0SWxqkDOoVy3A7tcXgek/A7+aFQK7lrtIOarZrkfDErt7UXG5laMA==
X-Received: by 2002:a05:6e02:1523:b0:374:983b:6ff2 with SMTP id
 e9e14a558f8ab-3763f6fa689mr37825825ab.20.1719174753568; 
 Sun, 23 Jun 2024 13:32:33 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 19/19] CI: Allow running tests on sjg lab
Date: Sun, 23 Jun 2024 14:32:13 -0600
Message-Id: <20240623203213.1571666-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203213.1571666-1-sjg@chromium.org>
References: <20240623203213.1571666-1-sjg@chromium.org>
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
---

Changes in v3:
- Split out most patches into two new series and update cover letter

Changes in v2:
- Avoid running a docker image for skipped lab tests

 .gitlab-ci.yml | 153 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 165f765a833..75c18a0f2f7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -17,6 +17,7 @@ stages:
   - testsuites
   - test.py
   - world build
+  - sjg-lab
 
 .buildman_and_testpy_template: &buildman_and_testpy_dfn
   stage: test.py
@@ -482,3 +483,155 @@ coreboot test.py:
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

