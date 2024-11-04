Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6318AD1CA08
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2130288F73;
	Mon,  4 Nov 2024 23:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RUph53DK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01FD7890C5; Mon,  4 Nov 2024 23:46:35 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D9A89078
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a6af694220so14127465ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 14:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730760390; x=1731365190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNA3iEoJdCg7aw5cfWAVSZbkx1y1S2oBVI5WLcPbj3A=;
 b=RUph53DKAtXdKuIofeiYAkzAKnwWbYPd9cOWR5JTGFKplvaOYHRpMH0EBHwZy0h521
 pLSHDBC2yxqK+3GRMX8dAbwhvY7TRwBd+xz+xhX3Fn8heyMM4KOvuIAb+kbOsq2EVdIJ
 uMDpp5UfviBxVIg2ykOREKBvodZ6NvdRLBeBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730760390; x=1731365190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNA3iEoJdCg7aw5cfWAVSZbkx1y1S2oBVI5WLcPbj3A=;
 b=YYLZrnPTOVEosLqJbITIOtIrWpuGTrQQh6NwCNzvVvHWOMPzaaLqdDBVY5siJruNM8
 bzNX9c13c14hajMrD5z+xl70wlryJRktmFAJv59qRd6hsBMnsc9LuRDJMVM30K7e32wV
 BvlM+mKL66Sj45l8G1ybGpigmLkU3NW924kClWB+5H9ckBbsPUYTyIjhbXonEt5UFS1j
 0TAuliy71oLwrF5PIXnaQT7L+MtpG3L1kpebjbW0TIBi/Z8RvmoK8Bl+YAtjfzNYmGOE
 LSrzvoIHvcv6amDSn2yKCzpp1Eu81oZW9elVzYmFaBsbUAQJLlIzmX3LUKRP6GaxpbnF
 mV0g==
X-Gm-Message-State: AOJu0Yw1CCVSOCDZnqftDrv6+ZYEfskoYJrXrc9ZNRe5BTvgYnnsSDxK
 +RZTy+9+68LfRZQV8/apTmmlVvSKi/RNHbL2BvsBJmfDIp/kekkmTB3flhjofDVjI3nRjP/rLMo
 =
X-Google-Smtp-Source: AGHT+IGrp3yccHwuUk8BQhwpyKbP90h/ABz5UzAMtxo9S9TfmVEMF9KDKgEG00S8oiWPrS4wH2AgfQ==
X-Received: by 2002:a05:6e02:2190:b0:3a6:a9bd:84bc with SMTP id
 e9e14a558f8ab-3a6b038fa0amr125601785ab.18.1730760390567; 
 Mon, 04 Nov 2024 14:46:30 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a97b009csm25535945ab.4.2024.11.04.14.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 14:46:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v8 11/11] CI: Allow running tests on sjg lab
Date: Mon,  4 Nov 2024 15:45:38 -0700
Message-ID: <20241104224550.677442-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104224550.677442-1-sjg@chromium.org>
References: <20241104224550.677442-1-sjg@chromium.org>
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

(no changes since v7)

Changes in v7:
- Rebase on broken-out testb series

Changes in v6:
- Drop patch 'test: Pass stderr to stdout'

Changes in v3:
- Split out most patches into two new series and update cover letter

Changes in v2:
- Avoid running a docker image for skipped lab tests

 .gitlab-ci.yml | 153 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0aeda53bc2d..97361337e21 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -17,6 +17,7 @@ stages:
   - testsuites
   - test.py
   - world build
+  - sjg-lab
 
 .buildman_and_testpy_template: &buildman_and_testpy_dfn
   stage: test.py
@@ -521,3 +522,155 @@ coreboot test.py:
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
2.43.0

