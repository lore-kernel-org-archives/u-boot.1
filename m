Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1185FE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 19:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB0098953F;
	Sun,  8 Dec 2024 20:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZQ0Wk0z1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B4B089538; Sun,  8 Dec 2024 20:07:54 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF59D893F9
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 20:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4674c597ee5so11776411cf.0
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 11:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733684871; x=1734289671; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BhOBV6xNV5M88OaGT4z9V3mdUBnBbaDhiN097MXjuw4=;
 b=ZQ0Wk0z1NBiBPUOO8dTu/IxT+JFsK3yZXs4qPx8b8va4EuKJyVITVDtrh3rN8cmYdY
 eTP8r9orgvTo0tmvh+z3alZWpPJXZL+BzsbnzlpjXR7NQtSgi1SzQaZUGVvv3Ppb3Br7
 b1S0pOJC7pzwjJ4kddCl08QqKquc1ZU1nTSTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733684871; x=1734289671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhOBV6xNV5M88OaGT4z9V3mdUBnBbaDhiN097MXjuw4=;
 b=bvrSy14kJP+iCF9vghCn3LAMpx4/a6pwA9Veplja+EZ5YT+BFfCg08jD2VOrdJej+K
 TrarkVkt8YeOJQWJWHK3eNg806GjFb6sdvRTlJmzHSxlSgsWXY5yTALEfypOFfFu/1Ov
 gQMvbrEi0IPiBSqMKSaQffzX0xz7IGGenKXjCfHxJtbF0Z9/2IAEwDfvFJssPtO7Kypy
 4nWd6UvvVh+1QXpr3a4uCW8qRvg/b86sW3OlxnahC+fHeHAs5ijQLrhpUzX0uOj+VNX1
 b8XbLfzxIZhnWo2Q4F13Gly/IXOiCueu9BBWdtuIfJRDPkVa0K2rS5wE2pzVfYDlWzrP
 GNjw==
X-Gm-Message-State: AOJu0YwSabRJamf6TraNixPkOtyTv1wwYeK2t+E7tpoajoGTUTwLA0AD
 1RFWhhPxn2gmhjXKyTz/iFkVskYA23Zgi1k8+e00osQI43IPH/TrcPfRxBYbmo2FEDhlBfpEz77
 +uzk=
X-Gm-Gg: ASbGncvXQNtkrPdCiBps//4Ieqkdc7Pth9lCIj3VbWjsrlASSEamyzv1HYPmTeY8WY3
 C1LImvXMn3Ifv2HRYAY7PK0XgSpFzznGa3rTrg5cnINpkJYf2Ji00mSBbeUGDrgbiMOb6oxES+k
 Xh/sFgCgWTYeOfRNvZcxLAbVAWsbdbt7u1qj9/u2ErCtLfHsf199n1wKTHGXb8ZU4OK6e8swDE4
 /LqWbHOQoeexLlSWsEQsHeZL0I4nGh83ruGhAIzL/wIAFFjNKmjAcOlrC41owbGvSYeUgjCSw==
X-Google-Smtp-Source: AGHT+IGNMKY5/CA2Q/OKSSeqUTnCiMMFkDov2dQUjS2n2vpZvDxLJYAnmqu/4PRfcY1cn5W5oMEhMQ==
X-Received: by 2002:ad4:576f:0:b0:6d8:85f2:c3 with SMTP id
 6a1803df08f44-6d8e70ce90amr140304976d6.14.1733684870881; 
 Sun, 08 Dec 2024 11:07:50 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66ddeasm41154076d6.25.2024.12.08.11.07.49
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 11:07:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/9] Docker/CI: Only test Xtensa on amd64 hosts
Date: Sun,  8 Dec 2024 11:07:24 -0600
Message-ID: <20241208190741.4192601-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208190741.4192601-1-trini@konsulko.com>
References: <20241208190741.4192601-1-trini@konsulko.com>
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

The xtensa architecture is interesting in that the platforms we support
are only valid on the binary-only toolchains as the DC233C instruction
set requires those toolchains (and not the FSF instruction set). Only
install the binary toolchain on amd64 hosts and only run the tests on
them as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci.yml          | 8 +++++++-
 tools/docker/Dockerfile | 4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 57037e243ecb..2671c3bb1061 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -144,12 +144,14 @@ build all PowerPC platforms:
         exit $ret;
       fi;
 
+# We exclude xtensa here due to not being able to build on aarch64
+# hosts but covering all platforms in the pytest section.
 build all other platforms:
   extends: .world_build
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      ./tools/buildman/buildman -o /tmp -PEWM -x arm,powerpc || ret=$?;
+      ./tools/buildman/buildman -o /tmp -PEWM -x arm,powerpc,xtensa || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
         exit $ret;
@@ -451,6 +453,8 @@ qemu-xtensa-dc233c test.py:
   variables:
     TEST_PY_BD: "qemu-xtensa-dc233c"
     TEST_PY_TEST_SPEC: "not sleep and not efi"
+  tags:
+    - all
   <<: *buildman_and_testpy_dfn
 
 r2dplus_i82557c test.py:
@@ -514,6 +518,8 @@ xtfpga test.py:
     TEST_PY_BD: "xtfpga"
     TEST_PY_TEST_SPEC: "not sleep"
     TEST_PY_ID: "--id qemu"
+  tags:
+    - all
   <<: *buildman_and_testpy_dfn
 
 coreboot test.py:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index ce1ad7cb23a2..8723834e6e5c 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -320,7 +320,9 @@ RUN virtualenv -p /usr/bin/python3 /tmp/venv && \
 # Create the buildman config file
 RUN /bin/echo -e "[toolchain]\nroot = /usr" > ~/.buildman
 RUN /bin/echo -e "kernelorg = /opt/gcc-13.2.0-nolibc/*" >> ~/.buildman
-RUN /bin/echo -e "\n[toolchain-prefix]\nxtensa = /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-" >> ~/.buildman;
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
+        /bin/echo -e "\n[toolchain-prefix]\nxtensa = /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-" >> ~/.buildman; \
+    fi
 RUN /bin/echo -e "\n[toolchain-alias]\nsh = sh2" >> ~/.buildman
 RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
 
-- 
2.43.0

