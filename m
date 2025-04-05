Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC46FC36018
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 18:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 944CC82AE1;
	Sat,  5 Apr 2025 20:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743878813;
	bh=W63jXgJCUD9Ezn+DJcFn57BRHeUjI4BkYJb1WlqtIOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ay1xkl8wWXDPMHwVzhlJQFMcbm3AXsBIGjAxh6X6vc8o7iGKzeS1ep4UpWyDhrlYb
	 vBpbVvq8SZuJcMbFj1v47h7icdkjSRtYHIqLMDAwknUfuApDgHvzhyfFAtQpL9c582
	 CTZhS667k6624NVairZnKX3yCCsfuRdESyWUPoF0SEhOxJ07Q2fiJawIycUSa02Iwt
	 LyXBNilRTfkNnnTy0MT/JLIlncG4Rgidg9LjxeLGoHlyzipqZhB3wnU2iysxAO/u11
	 uUtpxMhCmzAKa9RQnVoSv8kC8YyKtj1yPNVwGty2APfFZkvYvHp+RUp5h6upNlRWKz
	 ksfMyVRJ0Gdeg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A16A82B16; Sat,  5 Apr 2025 20:46:52 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35BE282AF6
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 20:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="UqdLWPAQ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D886F10252BC6; 
 Sat,  5 Apr 2025 20:46:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743878809; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=W63jXgJCUD9Ezn+DJcFn57BRHeUjI4BkYJb1WlqtIOk=;
 b=UqdLWPAQDZxY+YSgThHeUS6Yu+79F1011vb9Za43cOh37YKIP2O1iDgHJLphDl4J9xe+x2
 MzaWtAzUFiIpgsW+ubaTncjPWV4/0Dl9G+lijir85ZE3z3u6m9ml6C6rta+da7rY18Zif9
 FAYGKJhWN/NsqBcus7HjSCDVB775TZV2TzR40PqRNhRax8hJr5BmfxVxEe6EZvb7T5qrBP
 A4tNO3ngk+vfWYegkRr0ZKA7rYNplBNMaBVqs1x7cqSw9RBq6E8Z3uP3o2BUlypU56/ylm
 cASrkWn/GvjHzLNHmrf+1R0BoQwTL2FW6FASLEa56qQnFy3BRCWSdnqYMQWgdA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Heiko Schocher <hs@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 7/8] .gitlab-ci.yml: add tbot-lab
Date: Sat,  5 Apr 2025 20:46:25 +0200
Message-Id: <20250405184626.22377-8-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250405184626.22377-1-hs@denx.de>
References: <20250405184626.22377-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Heiko Schocher <hs@nabladev.com>

add testing real hardware with tbot.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

 .gitlab-ci.yml | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 46226eb2fc..f5c24ca30c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -27,6 +27,7 @@ stages:
   - testsuites
   - test.py
   - sjg-lab
+  - tbot-lab
   - world build
 
 .buildman_and_testpy_template: &buildman_and_testpy_dfn
@@ -693,3 +694,76 @@ vf2:
   variables:
     ROLE: vf2
   <<: *lab_dfn
+
+tbottest-test-all-boards:
+  stage: tbot-lab
+  before_script:
+    # install tbot dependencies
+    - python -m pip install --upgrade pip
+    - pip3 install --user pytest mypy paramiko termcolor2 pyserial coverage pytest-cov
+    - pip3 list
+    - python3 --version
+    # configure ssh
+    - mkdir -p ~/.ssh
+    - chmod 700 ~/.ssh
+    - echo "$SSH_UB_PRIVATE_KEY" | tr -d '\r' > ~/.ssh/staging.key
+    - chmod 600 ~/.ssh/staging.key
+    - git config --global user.email "hs@nabladev.com"
+    - git config --global user.name "Heiko Schocher"
+    - |
+      cat >>~/.ssh/config <<END
+        Host $SSH_UB_HOST
+          HostName $SSH_UB_HOST
+          User $SSH_UB_USER
+          IdentityFile ~/.ssh/staging.key
+          StrictHostKeyChecking no
+
+        Host ubtestinglab
+          HostName ubtestinglab
+          User $SSH_UB_USER
+          ProxyJump $SSH_UB_HOST
+          IdentityFile ~/.ssh/staging.key
+          StrictHostKeyChecking no
+
+      END
+    - export COLUMNS=160
+    - export PYTHONPATH=/home/uboot/.local/lib/python3.10/site-packages
+  script:
+    # install tbot dependencies
+    - python -m pip install --upgrade pip
+    - pip3 install --user pytest mypy paramiko termcolor2 pyserial coverage pytest-cov
+    - pip3 list
+    # Fix warning:
+    # The scripts coverage, coverage-3.10 and coverage3 are installed in '/home/uboot/.local/bin' which is not on PATH.
+    - export PATH=~/.local/bin:$PATH
+    # Fix warning
+    # fatal: detected dubious ownership in repository at '/builds/u-boot/custodians/u-boot-i2c'
+    - git config --global --add safe.directory /builds/u-boot/custodians/u-boot-i2c
+    # now start testing
+    - cd tbottesting
+    - echo "--------------------- test boards ------------------"
+    # set link to tbotconfig data
+    - ln -s tbotconfig-hs tbotconfig
+    # correct path to keyfile
+    - sed -i "s|~/.ssh/id_rsa|~/.ssh/staging.key|g" tbotconfig/hs/tbot.ini
+    # setup tbot
+    - ./preparetbot.sh
+    - returncode=0
+    - set +e
+    - python3 boardtests.py --usetbotflags
+    - exitcode="$?"
+    - echo "exitcode ${exitcode}"
+    - |
+      if [[ "${exitcode}" != "0" ]];then
+          echo "boardtests failed with exitcode ${exitcode}"
+          returncode=1
+      fi
+      exit "${returncode}"
+  artifacts:
+    when: always
+    paths:
+      - "./results/*"
+    reports:
+      # TODO how to report more than one board
+      junit: ./results/cxg3/results.xml
+    expire_in: 1 week
-- 
2.20.1

