Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6238DC2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FF0886B1;
	Fri, 21 Jun 2024 21:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OD471qmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5763988640; Fri, 21 Jun 2024 21:52:47 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84CAD88652
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7ebe508fa34so122844939f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999563; x=1719604363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYQvRiUNnfOOR+xidkmOapKEZkIh/XMIb68wz27lEII=;
 b=OD471qmg3PwQ6B+uXYLga5zDmMxxewetUkr7q/O4uJrF8GKzz2b5hYnkj4L8wbdpxe
 feBoANsMTcRttPK3yh8IqeByKXrA/1UL14R1inptm8wc/aJrR8MjNvWsVH7fl9QaGfVJ
 3KcO84r35iPFcPMWv0LM4/o3MWODZM7sbZhTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999563; x=1719604363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYQvRiUNnfOOR+xidkmOapKEZkIh/XMIb68wz27lEII=;
 b=ak0u/yAPkWOnEGnNnsLGsVXgq8x8wgzLRMkSPQRhSCnQtOWU3Oe5UXfP/hn5vZcluq
 D0DbOob6F8xnxYYEv8FjnZ/8le8kGegxJsNcX59baJduWC0eAsuBZSE8So+b4w3MoHB7
 vG7HAWSdv2wihS4tg0wA2iKxlL2JFGSGyM4mVaE42U9KEzzzg+S3f8txCk6+JNhrZoZS
 QocMcLXc5rPxCM+6WV+01nofaiEkUcz/9q8B7FG36NrrhEDoMKoAqMQt0muDWlRyzE4m
 +vfbgAy2HTYUY1Thmj+lelvUVZTYBS1wt3kPzoQAeaTRjAwuCXiZp0ut5A/Ehf9WvoXi
 4w/A==
X-Gm-Message-State: AOJu0YztLX32kqqXovgF+vbz64IsSlgBIKyOEZuBZpc/EsJWi7xp9hor
 KxTuVLEF/MxBO2DJq3hl42kQf8inEKL95He/eXdAA2ioQtZ8qVmRWlkmuFFzPumBysAOws+H1b1
 PwQ==
X-Google-Smtp-Source: AGHT+IFLevWEfXNgVi5OdesmPPi86kKgiTnZd9SLEpNe4Tc7Cr4/YKIjZk6f7KKydxN/4UIU0fhDjw==
X-Received: by 2002:a05:6602:2d93:b0:7eb:97a0:8209 with SMTP id
 ca18e2360f4ac-7f13ee61db8mr1030447139f.15.1718999563197; 
 Fri, 21 Jun 2024 12:52:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 43/43] CI: Allow running tests on sjg lab
Date: Fri, 21 Jun 2024 13:52:04 -0600
Message-Id: <20240621195204.2675252-44-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

