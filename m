Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645C1C36018
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 19:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B8A82B39;
	Sat,  5 Apr 2025 21:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743879978;
	bh=4Pz/YLianUd92goCBGgaCkGRJMyjjbv67bDQP2K6LCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W/eyzoVuE+KnkUWocLchB8qrFS4riuiNDryc+72dyOITFXjyXqelUVxtGLEh+Ge1t
	 EX76pGOgW3opWJp/P/8UowzQx1kxpJGalWz9OAgYY5ih68mDjXI6VgcGbqFHprazXG
	 t01nCEoD+4gaFsRlIfsIS1TunDttrxbgbOz8ugtI4Yr2ka5eKf1mkxgMy3XSzdUmN/
	 88ZjWY24WfXCHfTGcQp0O1Q5uB9ggFLkb443EcWLkRJI9Hb5tOC+CmYI4x3vs0MVZ9
	 nvMaRMnV7gw5Jwo3fw5v0Wn9C96btyyC8YXbP7z8ZV0PRIpYOtKIQsRl91vkNPuZxF
	 66U37Av2QNuRQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2859982B30; Sat,  5 Apr 2025 21:06:18 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA6882B12
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 21:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ZrbcKOcO"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 67CAB10276F6E; 
 Sat,  5 Apr 2025 21:06:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743879975; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=4Pz/YLianUd92goCBGgaCkGRJMyjjbv67bDQP2K6LCI=;
 b=ZrbcKOcOsp1RGpq/S9R96N+C2b4CToEzSc/y2+FHtg2766lt6fD8LG6IeNf2mELEh5J3OK
 RTUlGZAtqmgo/pnPPSY7KjdMApv6udIYBiy5GKS7gwJoGwM++iU1XXcAvu4Z+Unv9A/ncd
 DWkzAU72X6VsGTwCEUmmkhozdnWCTS358TXy+PmbFY2FQrGYRzZa/YyGE1wBV+yQffhAmm
 hx4+TCdJHKCjvmGSBO2bJDguWShNkmWTFMPwCMorTIhEpb+LLIg/HvGagUG6fGcOojDlI3
 fpGa/pSX7gTHfUlhdgn2XeR3lcJp6+0aVTfcB+2Nv600L2GuA/5mHnjrF1s5DQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 7/8] .gitlab-ci.yml: add tbot-lab
Date: Sat,  5 Apr 2025 21:05:59 +0200
Message-Id: <20250405190600.24081-8-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250405190600.24081-1-hs@denx.de>
References: <20250405190600.24081-1-hs@denx.de>
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
---

(no changes since v1)

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

