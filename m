Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38D9CF58D1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ABEA8936C;
	Fri, 20 Sep 2024 08:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BN/D/cly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F6E889325; Fri, 20 Sep 2024 08:03:37 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6939C89368
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8a7596b7dfso285924366b.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812200; x=1727417000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqQqYmwLo8VJOpRZK6prjdAjRN7zknrT8ZToVOJUP1E=;
 b=BN/D/cly58L5LXbLm/n7xWFPnfJwLVahzeiOkO3iwMrUIQpW/wk1xwmMk3XpJakaRN
 F3eEW7h/qIe20Oxzus8vK9KMO1TelA6hZ9HqzrjvGK674b9ke8YhEr8gQgp2sojjHfpJ
 0CW+LR7OvVoYeJg8UJnNwN//gta8LY/xYI8SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812200; x=1727417000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eqQqYmwLo8VJOpRZK6prjdAjRN7zknrT8ZToVOJUP1E=;
 b=MOf3H2SG1qNI8ZvvaCaMceN01pmmJDf4CWcQiXUasrSzOzKXBeXweTnUAhWsmpnYK3
 553bHxcum4FxLMLVfboZXLJ2aydCNyk6+b5TdH3OXCXKZ0GztMHasthk91gq38qJSqzA
 GaxzoxgnnVX6VpPKfzCy4cMyolQjznxjdJNyLwqq7tzpxcTj7+hQth25u9dRuTSgKx43
 589p9zzt1MQsLI9x/yHrAzChgK7LScm4ya1su+J1OCztasSm5OqeNmTITQUYb+3/wkE+
 QPLTAcbMF0eQFgxQuJrFEfNS73jL+mtaWSgSZqmkbB+JczfryMEJNMr3xxCVs3vgGwBP
 1v8A==
X-Gm-Message-State: AOJu0Yy3dKk105jETB/Ll/RMg5ENwT7F+WcCuYxLoE7IqDb1choVFL+X
 cByc5l+V06j+ysjZAJNedsGpvv5XBQ5+s6OgjgPVsdLZaXK7UBjGQmpzbEeUKCLBAEAKjc+BRsN
 OLhJm
X-Google-Smtp-Source: AGHT+IGep1Qdr++Euyig9H41xgNSH8nBzwgMI5/yzZR48YrZopE/H81OHEPNKNDI07WnGCCD491MhQ==
X-Received: by 2002:a17:907:3f9c:b0:a90:a9bd:1c36 with SMTP id
 a640c23a62f3a-a90d3557279mr202747666b.18.1726812199600; 
 Thu, 19 Sep 2024 23:03:19 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v6 19/19] CI: Allow running tests on sjg lab
Date: Fri, 20 Sep 2024 08:01:54 +0200
Message-ID: <20240920060158.106612-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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

Changes in v6:
- Drop patch 'test: Pass stderr to stdout'

Changes in v3:
- Split out most patches into two new series and update cover letter

Changes in v2:
- Avoid running a docker image for skipped lab tests

 .gitlab-ci.yml | 153 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7d621031b85..4d66e53b5b2 100644
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
2.43.0

