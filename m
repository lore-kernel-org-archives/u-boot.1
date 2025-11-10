Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468E2CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 15:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9229A83A71;
	Mon, 10 Nov 2025 16:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JSjqCf0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2634183980; Mon, 10 Nov 2025 16:42:37 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63DE183A71
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 16:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45033024e55so852765b6e.2
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 07:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762789353; x=1763394153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=D7WM2O7uhk5qpHF0i9T3hhi7riKWQFmOkra1ISFSZqo=;
 b=JSjqCf0yNbewyZiotJue/m9jGwxeE2yI7/aSKKskgXcOSeuH8OxufvT5yDGgWIHrtT
 fEe9s0IvLh6/NCQXwgZbE2cy9cNwrQHArUMbNyxuu8xtZGJtGB2uo1gBTXCPYBp+D3xE
 BUFtiSm5mytulOPyrLadA2BV910MUlPYFRNBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789353; x=1763394153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D7WM2O7uhk5qpHF0i9T3hhi7riKWQFmOkra1ISFSZqo=;
 b=PL5wwVn81Gi27wTTI1zUVfTN03JTrWe1yGN7MXIWsrwUzr7EMiT4ye//SXZUAxsOqZ
 S1gwLniuV6cu7PgdqLA67ILzfn0G7qjTpz/iA9v7Dx1+aBZjqhET3TcF5m5jZZE/cySm
 OTAbYI30dRkosmk44NMj0ILQfmTsLuvXi0VEXDCUyrIrw/izvtpOdPy+Mw0oAhwxu1q1
 ii5ZTUwd7l6yXctNj687zmd0myZf+Dez6mmT0H0AwRHHnPW7qwA9pYiUUPz+vGQVWF8C
 hghX2Llg/3PvYsMfm455dVs+pyxbsxqa1oAsbAmEsEOGG+B1lx1XwrdB/CsjnqqRkCwx
 3aog==
X-Gm-Message-State: AOJu0Yx7QdLwST6OlzwCTwDTVZfimZ87IoiuKEdYEsUMpacpIkWDMbtF
 93eEIy7lew7rstK9nsheR6eqJGrq0EYvqXjHahq0Ap4XWJRuI0CrvtfhE0rhoCfJDxta8L7GxiE
 AzywhwRDzFg==
X-Gm-Gg: ASbGncuKXUnW8RfYQDrV9erKucyuR61Pyw+m0AXbeFp+I+eiH5c0KRVYf43w4t8I83m
 TxIw94CUV+KqcAdPhEMJtZIlxrlMjIZkGktIrxFp2JQtG/QjWglBIdRPAhW8bTVW47NNNKWw2W8
 WBwzx2xE86TWyG/t42SO6yxTyyp5SsGhnW9wPTo9bzLmDt0QzXSLfU4kB2v2nMCMTupdf4Zkwi5
 0IvqiiEezivlBOOZJPiyUJ/jPNvhrzVjzk6UYiE4SKF7rIDprqQh9cdPPXH8V4I6VcaSBjS7R+d
 eVl3mj98Y0FXiYzC6skB0+DqH7bnox0HtlEj9cHN63OxM3K8Avv6IgPo0fLOAXNxcIMvzGpZref
 L2s1zo0tB8er9fxAkyyuI0yT4sc3Wk6V3bxT0Ylris4KTr3pAWl5Fo3axUL/FqgnpJHvZ3n7veQ
 i4yjwA45daAGtVePFeednHjNLSVLEFTtaBT4aivyH1Iw==
X-Google-Smtp-Source: AGHT+IGkCYjkLlECKMpbdulkhw+AKgltwzcf03MOxIkzxSbc9bWvLsoTrC3GJLEagLVcm/6mGEqxFA==
X-Received: by 2002:a05:6808:190f:b0:44f:6ab9:4aee with SMTP id
 5614622812f47-4502a38ae6cmr4012657b6e.63.1762789352953; 
 Mon, 10 Nov 2025 07:42:32 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4503c6b7688sm2251666b6e.21.2025.11.10.07.42.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:42:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Gitlab: Add a "sage-lab" stage to access a board farm
Date: Mon, 10 Nov 2025 09:42:31 -0600
Message-ID: <20251110154231.2629710-1-trini@konsulko.com>
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
Note that for the Pi platforms we enable/disable CMD_BOOTEFI_SELFTEST
based on overall binary size. I've created
https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/issues/2
to track addressing that issue.
---
 .gitlab-ci-sage-lab.yml | 182 ++++++++++++++++++++++++++++++++++++++++
 .gitlab-ci.yml          |   5 ++
 2 files changed, 187 insertions(+)
 create mode 100644 .gitlab-ci-sage-lab.yml

diff --git a/.gitlab-ci-sage-lab.yml b/.gitlab-ci-sage-lab.yml
new file mode 100644
index 000000000000..26a055f93121
--- /dev/null
+++ b/.gitlab-ci-sage-lab.yml
@@ -0,0 +1,182 @@
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
+        labgrid
+    # Add more tools
+    - sudo apt-get update && sudo apt-get -y install snmp rsync
+    # Acquire and turn on the exporter.
+    - labgrid-client -p ${LABGRID_EXPORTER} acquire &&
+      labgrid-client -p ${LABGRID_EXPORTER} power on
+    # Prepare ssh
+    - mkdir --mode=0700 ~/.ssh;
+      printf 'Host sage-exporter-*\n\tUser labgrid\n' > ~/.ssh/config
+  script:
+    - export UBOOT_TRAVIS_BUILD_DIR=/tmp/${TEST_PY_BD}
+    # Sage is 16 threads and has 3 devices attached, so 6 builder threads.
+    - tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e
+        --board ${TEST_PY_BD} ${OVERRIDE} -T 6
+    # Wait for the exporter to have the device ready
+    - while test `labgrid-client resources |
+        grep -q ${LABGRID_EXPORTER}/${LG_PLACE}/; echo $?` -ne 0; do sleep 1;
+      done
+    # Fingerprint the exporter
+    - ssh-keyscan ${LABGRID_EXPORTER} > ~/.ssh/known_hosts 2>/dev/null
+    # Don't stop on non-zero exit codes now, to provide as much chance as
+    # possible to ensure we don't leave lab resources acquired.
+    - set +e;
+    # Run the tests, save the results.
+    - export PATH=/tmp/uboot-test-hooks/bin:${PATH};
+      export PYTHONPATH=/tmp/uboot-test-hooks/py/sage;
+      labgrid-client -p ${LG_PLACE} acquire;
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
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a ~CMD_BOOTEFI_SELFTEST -a IPV6 -a IPV6_ROUTER_DISCOVERY -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
+
+Raspberry Pi 4 (rpi_arm64):
+  <<: *sage_lab_dfn
+  needs: [ "Raspberry Pi 4" ]
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-rpi4-1"
+    LG_PLACE: "rpi4-1"
+    TEST_PY_BD: "rpi_arm64"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a ~CMD_BOOTEFI_SELFTEST -a IPV6 -a IPV6_ROUTER_DISCOVERY -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
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
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a IPV6 -a IPV6_ROUTER_DISCOVERY -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
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
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a IPV6 -a IPV6_ROUTER_DISCOVERY -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
+
+Raspberry Pi 3 (rpi_arm64):
+  <<: *sage_lab_dfn
+  needs: [ "Raspberry Pi 3" ]
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-rpi3-1"
+    LG_PLACE: "rpi3-1"
+    TEST_PY_BD: "rpi_arm64"
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a ~CMD_BOOTEFI_SELFTEST -a IPV6 -a IPV6_ROUTER_DISCOVERY -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
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
+    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a IPV6 -a IPV6_ROUTER_DISCOVERY -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
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
index 6a36513c3b75..b32e6ade230d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -5,6 +5,7 @@ variables:
   DEFAULT_AMD64_TAG: "amd64"
   DEFAULT_FAST_TAG: "fast"
   MIRROR_DOCKER: docker.io
+  SAGE_LAB: ""
   SJG_LAB: ""
   PLATFORM: linux/amd64,linux/arm64
 
@@ -24,6 +25,7 @@ image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20251001-04Nov2025
 stages:
   - testsuites
   - test.py
+  - sage-lab
   - sjg-lab
   - world build
 
@@ -597,6 +599,9 @@ coreboot test.py:
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

