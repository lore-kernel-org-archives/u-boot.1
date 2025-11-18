Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73698CEE34D
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 21:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB36D836CE;
	Tue, 18 Nov 2025 22:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n3osirP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A75583A48; Tue, 18 Nov 2025 22:00:21 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9528180FA1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 22:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c6cc366884so1813242a34.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 13:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763499617; x=1764104417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9IEJ+8cwANrlwZ5IFWDNfKNDNZUoJISgjR4SUwcxZPM=;
 b=n3osirP69rJAPoKWmPAnMPPIbbwzKWlH0FnXJnthWIF7M12NWdlZojCKp3/W4Mlrht
 lGFscdlES24RvaLbAcTwJS2sjccDdb1Tx4kxcxSiik+eMfNh90KdY4PruHlK2rBusAmv
 +KVe2Sznq3p0haZhKq8T+K1O2xHLZ+Z8HV/1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763499617; x=1764104417;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9IEJ+8cwANrlwZ5IFWDNfKNDNZUoJISgjR4SUwcxZPM=;
 b=iXabCPvGiLWTIGp/UDZuyPE0GFgmwjxRYQj3jp3k+VmuZGIeMISEFo5NhRgEUdVo8f
 GycZTp+2D0OFM68h/sWJHj6jZbeZOoslwfhGySW6lzPsALZXUCzR6vaenHla5GW3mqii
 LeeFjdWvwso/wWf0O1WsO+k/Agk8O2olR6Z1oE0xQGJJ4KPQ8FcYRWPN/ZE8OUNn16HC
 R8rRLR7RfoCmPUeG/Lk2Y6WwSWojTWd0f3Ihc/cwwm75LjXGkqnL+yuo2p4MgXXCHrmq
 +YIW4aJnXU1r+itwbv687tJ8nLyuQFI2654l5ff2SLks6diGnPpY4l+PNZfI02hx/yho
 AzMg==
X-Gm-Message-State: AOJu0Yw/kKmwcRghMDlV8syyRAgBhIIhnsSd60Gd6P5iw0TKb1gbTLA7
 fIW2+elP4jbiZpoYVdVKLc27wSUbn4/TTUef/eSrHIb/Nctbo/DbclIjouo1lWyEfcalF8h2Aof
 1mwtN0O3laA==
X-Gm-Gg: ASbGncuhfzvoNq/DgC2GCsVTzdWnf37gUJDV0NdBPob07Aqv1sruAfFRpN2r+XajKmY
 KaRCZQU2k/YTDx0gw/PNm7e3sbWIRZMKA999VrCqKWNjv8G2HvvaAHVbZRNiDi8bLa26snG/mk8
 CFrjfyo3mDng12hp/TGjtnmF3zODARRzZhqDIdCfL6q/GL6PCOLK/eRrJaVki0DW+TwP8qS5K10
 ObAOW3CM0U2/AgPUu2B6hiiCYouM55g7R5sXrHPTutKyFH6x3ZZ5aMcoayZ9jpDlVrF1G3YJL3p
 Z8d1Q6gyOy8I6iQGD7tW6rbgQLoY9bz+tujJGcqdbRrQgSO5Iu9lHfCt6KOxOa/eRGp+QqpBQQC
 CgfD5+WKg03V+u3SSVLG6X5317QurBb0KoypHCC1NAMHTSv1ix09TV1HMLkVDPXWugB+nEm9Png
 yIoOL76TtAkSNR8Noag3CG1fn6Cpb/BCsdMc0HU411u5elDW1Mh9wvP96eujKYam0=
X-Google-Smtp-Source: AGHT+IF67hIRnlzd/mG7YS2MN9XjfSLe/OJ0eBjpT+WNO0W9mheA+mY25AA7wtNlsxntlA76yePQQw==
X-Received: by 2002:a05:6830:4120:b0:750:97f0:3c02 with SMTP id
 46e09a7af769-7c7445b5b26mr9680281a34.18.1763499616728; 
 Tue, 18 Nov 2025 13:00:16 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c75610f638sm3583110a34.21.2025.11.18.13.00.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 13:00:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 1/4] Gitlab: Add a "sage-lab" stage to access a board farm
Date: Tue, 18 Nov 2025 15:00:12 -0600
Message-ID: <20251118210015.624758-1-trini@konsulko.com>
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

This is the Gitlab side of adding support for the board lab connected to
the "konsulko-sage" runner. On the software side, this lab uses only
upstream labgrid. On the hardware side, each device under test is
connected to its own exporter (typically a Raspberry Pi 4) that must be
turned on (and cleanly turned off) as part of a given test cycle.

Add support for testing on a SolidRun Hummingboard 2 (imx6), Raspberry
Pi 3 and Raspberry Pi 4. In all cases, we enable additional options to
run more tests on the board. As we have some networking tests, we test
both the legacy network stack and lwIP. In the case of Pi platforms, we
test all of 32bit configuration, plain configuration and rpi_arm64, and
again with and without lwIP.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Drop IPV6, we aren't testing it (no IPv6 router in lab)
- Make use of the labgrid reservation system so that concurrent jobs
  will wait correctly rather than fail.
- Catch build failures as a place to still acquire/release resources in.
- Add setuptools to pip
---
 .gitlab-ci-sage-lab.yml | 185 ++++++++++++++++++++++++++++++++++++++++
 .gitlab-ci.yml          |   5 ++
 2 files changed, 190 insertions(+)
 create mode 100644 .gitlab-ci-sage-lab.yml

diff --git a/.gitlab-ci-sage-lab.yml b/.gitlab-ci-sage-lab.yml
new file mode 100644
index 000000000000..fa7d79668b2c
--- /dev/null
+++ b/.gitlab-ci-sage-lab.yml
@@ -0,0 +1,185 @@
+# Definition for the lab connected to the "sage" host and managed with labgrid
+
+.sage_lab_template: &sage_lab_dfn
+  stage: sage-lab
+  rules:
+    - if: $SAGE_LAB == "1"
+      when: always
+    - if: $SAGE_LAB != "1"
+      when: manual
+      allow_failure: true
+  # USB can be unreliable.
+  retry: 2
+  dependencies: []
+  needs: [ "sandbox test.py" ]
+  tags: [ 'konsulko-sage-labgrid' ]
+  before_script:
+    # Clone uboot-test-hooks
+    - git config --global --add safe.directory "${CI_PROJECT_DIR}"
+    - git clone --depth=1 -b sage-labgrid https://github.com/trini/u-boot-test-hooks.git /tmp/uboot-test-hooks
+    - ln -s sage /tmp/uboot-test-hooks/bin/`hostname`
+    - ln -s sage /tmp/uboot-test-hooks/py/`hostname`
+    - export LG_ENV="/tmp/uboot-test-hooks/bin/sage/labgrid-sage-env.yaml"
+    # Prepare python environment
+    - python3 -m venv /tmp/venv;
+      . /tmp/venv/bin/activate;
+      pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
+        -r tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.txt
+        labgrid setuptools
+    # Add more tools
+    - sudo apt-get update && sudo apt-get -y install snmp rsync
+    # Acquire and turn on the exporter.
+    - labgrid-client reserve --wait board=${LABGRID_EXPORTER} &&
+      labgrid-client -p ${LABGRID_EXPORTER} acquire &&
+      labgrid-client -p ${LABGRID_EXPORTER} power on
+    # Prepare ssh
+    - mkdir --mode=0700 ~/.ssh;
+      printf 'Host sage-exporter-*\n\tUser labgrid\n' > ~/.ssh/config
+  script:
+    - export UBOOT_TRAVIS_BUILD_DIR=/tmp/${TEST_PY_BD}
+    # Don't stop on non-zero exit codes now, to provide as much chance as
+    # possible to ensure we don't leave lab resources acquired.
+    - set +e;
+    # Sage is 16 threads and has 3 devices attached, so 6 builder threads.
+    - tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e
+        --board ${TEST_PY_BD} ${OVERRIDE} -T 6;
+      RC=`echo $?`;
+    # Wait for the exporter to have the device ready
+    - while test `labgrid-client resources |
+        grep -q ${LABGRID_EXPORTER}/${LG_PLACE}/; echo $?` -ne 0; do sleep 1;
+      done
+    # Fingerprint the exporter
+    - ssh-keyscan ${LABGRID_EXPORTER} > ~/.ssh/known_hosts 2>/dev/null
+    # If we built, run the tests and save the results.
+    - export PATH=/tmp/uboot-test-hooks/bin:${PATH};
+      export PYTHONPATH=/tmp/uboot-test-hooks/py/sage;
+      test $RC -eq 0 && labgrid-client reserve --wait board=${LG_PLACE} &&
+      labgrid-client -p ${LG_PLACE} acquire &&
+      ./test/py/test.py -ra --bd ${TEST_PY_BD} ${TEST_PY_ID}
+        ${TEST_PY_EXTRA:-"--capture=tee-sys"}
+        ${TEST_PY_TEST_SPEC:+"-k ${TEST_PY_TEST_SPEC}"}
+        --build-dir "$UBOOT_TRAVIS_BUILD_DIR"
+        --junitxml=/tmp/${TEST_PY_BD}/results.xml;
+      RC=`echo $?`;
+      cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .;
+    # Release and power off everything.
+    - labgrid-client -p ${LG_PLACE} power off
+    - labgrid-client -p ${LG_PLACE} release
+    - labgrid-client -p ${LABGRID_EXPORTER} ssh sudo poweroff && sleep 15 &&
+      labgrid-client -p ${LABGRID_EXPORTER} power off
+    - labgrid-client -p ${LABGRID_EXPORTER} release
+    - exit $RC
+  artifacts:
+    when: always
+    paths:
+      - "*.html"
+      - "*.css"
+      - results.xml
+    reports:
+      junit: results.xml
+    expire_in: 1 week
+
+SolidRun Hummingboard 2:
+  <<: *sage_lab_dfn
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-hb-1"
+    LG_PLACE: "hb-1"
+    TEST_PY_BD: "mx6cuboxi"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG"
+
+SolidRun Hummingboard 2 (lwIP):
+  <<: *sage_lab_dfn
+  needs: [ "SolidRun Hummingboard 2" ]
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-hb-1"
+    LG_PLACE: "hb-1"
+    TEST_PY_BD: "mx6cuboxi"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a NET_LWIP"
+
+Raspberry Pi 4:
+  <<: *sage_lab_dfn
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-rpi4-1"
+    LG_PLACE: "rpi4-1"
+    TEST_PY_BD: "rpi_4"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a ~CMD_BOOTEFI_SELFTEST -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
+
+Raspberry Pi 4 (rpi_arm64):
+  <<: *sage_lab_dfn
+  needs: [ "Raspberry Pi 4" ]
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-rpi4-1"
+    LG_PLACE: "rpi4-1"
+    TEST_PY_BD: "rpi_arm64"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a ~CMD_BOOTEFI_SELFTEST -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
+
+Raspberry Pi 4 (rpi_arm64, lwIP):
+  <<: *sage_lab_dfn
+  needs: [ "Raspberry Pi 4 (rpi_arm64)" ]
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-rpi4-1"
+    LG_PLACE: "rpi4-1"
+    TEST_PY_BD: "rpi_arm64"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a ~CMD_BOOTEFI_SELFTEST -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000 -a NET_LWIP"
+
+Raspberry Pi 4 (rpi_4_32b):
+  <<: *sage_lab_dfn
+  needs: [ "Raspberry Pi 4 (rpi_arm64, lwIP)" ]
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-rpi4-1"
+    LG_PLACE: "rpi4-1"
+    TEST_PY_BD: "rpi_4_32b"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
+
+Raspberry Pi 4 (rpi_4_32b, lwIP):
+  <<: *sage_lab_dfn
+  needs: [ "Raspberry Pi 4 (rpi_4_32b)" ]
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-rpi4-1"
+    LG_PLACE: "rpi4-1"
+    TEST_PY_BD: "rpi_4_32b"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000 -a NET_LWIP"
+
+Raspberry Pi 3:
+  <<: *sage_lab_dfn
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-rpi3-1"
+    LG_PLACE: "rpi3-1"
+    TEST_PY_BD: "rpi_3"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
+
+Raspberry Pi 3 (rpi_arm64):
+  <<: *sage_lab_dfn
+  needs: [ "Raspberry Pi 3" ]
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-rpi3-1"
+    LG_PLACE: "rpi3-1"
+    TEST_PY_BD: "rpi_arm64"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a ~CMD_BOOTEFI_SELFTEST -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
+
+Raspberry Pi 3 (rpi_arm64, lwIP):
+  <<: *sage_lab_dfn
+  needs: [ "Raspberry Pi 3 (rpi_arm64)" ]
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-rpi3-1"
+    LG_PLACE: "rpi3-1"
+    TEST_PY_BD: "rpi_arm64"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a ~CMD_BOOTEFI_SELFTEST -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000 -a NET_LWIP"
+
+Raspberry Pi 3 (rpi_3_32b):
+  <<: *sage_lab_dfn
+  needs: [ "Raspberry Pi 3 (rpi_arm64, lwIP)" ]
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-rpi3-1"
+    LG_PLACE: "rpi3-1"
+    TEST_PY_BD: "rpi_3_32b"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
+
+Raspberry Pi 3 (rpi_3_32b, lwIP):
+  <<: *sage_lab_dfn
+  needs: [ "Raspberry Pi 3 (rpi_3_32b)" ]
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-rpi3-1"
+    LG_PLACE: "rpi3-1"
+    TEST_PY_BD: "rpi_3_32b"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000 -a NET_LWIP"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5e9995aed6ae..8aab61dcb62d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -5,6 +5,7 @@ variables:
   DEFAULT_AMD64_TAG: "amd64"
   DEFAULT_FAST_TAG: "fast"
   MIRROR_DOCKER: docker.io
+  SAGE_LAB: ""
   SJG_LAB: ""
   PLATFORM: linux/amd64,linux/arm64
 
@@ -24,6 +25,7 @@ image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:noble-20251001-11Nov2025
 stages:
   - testsuites
   - test.py
+  - sage-lab
   - sjg-lab
   - world build
 
@@ -593,6 +595,9 @@ coreboot test.py:
     TEST_PY_ID: "--id qemu"
   <<: *buildman_and_testpy_dfn
 
+# Add sage-lab stage
+include: .gitlab-ci-sage-lab.yml
+
 .sjg_lab_template: &sjg_lab_dfn
   stage: sjg-lab
   rules:
-- 
2.43.0

