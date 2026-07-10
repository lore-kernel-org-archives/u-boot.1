Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C0AC44513
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 16:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C266884A63;
	Fri, 10 Jul 2026 18:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SY+ZT1J8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1639684A8D; Fri, 10 Jul 2026 18:37:13 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900678498C
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 18:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e6b554044fso1040263a34.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 09:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783701428; x=1784306228; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=do9xE9OFv8QcjLTOw8vxTAWT54fi50Fde/vNgfrSXkY=;
 b=SY+ZT1J8KftWffR6MlGMGjC6hIO5MXH3hcDTsojsjNLwx8F5bO19u77YWQSPz1mT2j
 zlKYMPmdR1VX6BS6pMwApvWIu0VXbBV4DPRzDLIejHOiPHzE69mkgiY9eIAHfvu1/A5N
 /SWqzY0IGzaK1OzcVcIUDlzhS8qYlsjxbVoqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783701428; x=1784306228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=do9xE9OFv8QcjLTOw8vxTAWT54fi50Fde/vNgfrSXkY=;
 b=F7tvjrA6nZWcmAWNpzdoVD8fkXr60BoYwV4t098gzwVNWX7ufGHpM03IJAhqB78YNr
 0CFsQmpjVUIOHgqqweTgg0Jya7wE01U842lZq9eXKLKaLSni0j5xEBm0XOqohCX+E+yg
 a8xKm756La0HUqVNMCkZq+GQLXN40h+w4ry1LdvP6Cka0ih4gYwQnxtZQn/UM+VKogiM
 GtdXhM87ngb2+AtjhGwNZYuldXRa0pNEYpoWkvc5cOyqjIRP+MlsnUGSHVid+yNgESf+
 1U3lhYE4R824Uu3dEK5ew08GKhrwI8aSi4z/gwRc2z4ns2zKsk5BnnpHGmUbvlLoKqsq
 V/kw==
X-Gm-Message-State: AOJu0Yx0IG46e7Dx56LFVT3hZ/Yf260TQEwByCuZXXleTADJqb8xHB1F
 G92iHaYotVlxDHw75fiU7evoWD9ol4eejgQWDGKfMdlNKuxlqZCWFYO9gkEUC2/APTHH9/DqnCS
 gq8OwM4M=
X-Gm-Gg: AfdE7ckQH0KTGuvL7ox6GA0nJcfDu4XpaCKPde/BS1sitpDFwJbsvE/pyoC/hvQ7CWG
 sfF394NlR9+VikwleIlJU1ahRPh27n++oNIMnPykQn+P+Wlq3Yd0GFmcq6xAqSQ0pMHEGziDBYq
 +LRoXB6QopviMIO6j65NrZIgMmNn1zL7H7Bp5WWkLkJ4i/2eLAXqyv7dnS2tIzACAY8aPrU1oYj
 DSl3uFydpOosQK61ZZl/4AB9K/7u9Hj5vD3zy4dU4yT829uA9XF7qh6KRviA8UHeNIMjTXCDEpa
 4yfbMP4Q2poDXgbg3WxnlPpY9Gqi4r56II42oGqwG1ykUI+Xy7WjXFz1mDIY6roq0MJVrcl/qQS
 dOD+TJvHJXDkjl8T3CL/BNUVfzIFCntyZS9aSbgRgBP/RxeaX55dctYe0m/fT06CyZ18XECNGe6
 0SBEBd2Ct9pTOXwk696vkSfsdiYG96gKoLBr4V8nsJrzooEpKik+mLz0j8p3IPi8IAc/OKIIwjY
 77+iUAzesy/gmKLdRdcbJCuM85G33GIcA5s2RSYJwlYS/xsgF0EwJxGgabtrQ==
X-Received: by 2002:a05:6830:2317:b0:7e9:adef:4fd4 with SMTP id
 46e09a7af769-7ebd0156dcdmr8765253a34.11.1783701427946; 
 Fri, 10 Jul 2026 09:37:07 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2bae7fsm7333890a34.21.2026.07.10.09.37.07
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:37:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Gitlab CI: Switch to git.u-boot-project.org
Date: Fri, 10 Jul 2026 10:37:06 -0600
Message-ID: <20260710163706.2827580-1-trini@konsulko.com>
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

Now that we have everything available on git.u-boot-project.org, switch
URLs to that location.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
As part of the migration from source.denx.de to git.u-boot-project.org
we need to switch CI over. I plan to apply this, and continue to pushing
to source.denx.de, on Monday. The switch over date will be handled
separately.
---
 .gitlab-ci-sage-lab.yml | 2 +-
 .gitlab-ci.yml          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci-sage-lab.yml b/.gitlab-ci-sage-lab.yml
index e2f368486047..90f97696f86c 100644
--- a/.gitlab-ci-sage-lab.yml
+++ b/.gitlab-ci-sage-lab.yml
@@ -16,7 +16,7 @@
   before_script:
     # Clone uboot-test-hooks
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
-    - git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
+    - git clone --depth=1 https://git.u-boot-project.org/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
     - ln -s sage /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s sage /tmp/uboot-test-hooks/py/`hostname`
     - export LG_ENV="/tmp/uboot-test-hooks/bin/sage/labgrid-sage-env.yaml";
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 245e422d72fa..79f2af2cccf5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -36,7 +36,7 @@ stages:
   before_script:
     # Clone uboot-test-hooks
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
-    - git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
+    - git clone --depth=1 https://git.u-boot-project.org/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
     # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
     # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
     - ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
-- 
2.43.0

