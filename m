Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85BED15D93
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 13:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B37B88E8A;
	Mon, 21 Oct 2024 15:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QugfJspu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E87D88E6E; Mon, 21 Oct 2024 15:44:59 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CFA088E91
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 15:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so345054466b.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729518296; x=1730123096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4cZ5duzALf5+xY0usfykLGxY2RdyCHPso6b51k/XlNM=;
 b=QugfJspu9lDkLRa2h9FktcC7T2jJwP1M+eF4Z7YrzsMKh8cMopJj3UW4S8wF/0zvRs
 l7CvC5YwHa7SLdq7PgUC+Q0ldZVg5i2rw/fKXvoJ9LyWKBnymA0E8YHiQJXaI3ta79N6
 R7XDGeNmlBi8/jsyXBGEBoIPF97Kd1Y6PgKfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729518296; x=1730123096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4cZ5duzALf5+xY0usfykLGxY2RdyCHPso6b51k/XlNM=;
 b=tFSdt1fwV1JlFOS7AaVG4WqgXmx+Htac5YoAYMZe/y1l1Ejestx14Za4MPDTEy+Ajr
 5aztVhdELuqshhFjCW421aLJgpHH79sONp8eF26RpWHj4IPziugh5q2VMVLEWjOy7WTg
 /A5zn4/m15sA5P5sK1/r+Ty3gHOHpS2gSqwjymZ2c5WAs9lc61bZiegsKk0llZmKqRX1
 0lcb3hJacCmWcFk8FQIK50hQvNvnxZEaqH8Xvp/8dalqfRcf/4VYcSmd0UL8CXEFhWBr
 y0uY/kLaIZ3Xa/l7BNQDWYJa28bmqL9cRWhPfVcoYvZ4o8WkHWsAnJgkVh2QcDxQxkNa
 SXNw==
X-Gm-Message-State: AOJu0Yz+CDMZ9CcVChXhyezqOiej0i7rvwLnazOHumJvjIteQ/VxLpXm
 oSwgHtAnA6COLID81AuySWw5l55Oxs0iC5IVD1zRegCxyUFyx9Ac4otymSw1fYp9R+TLAoVQPOC
 Mxoul
X-Google-Smtp-Source: AGHT+IFuhJ7WJReMwWavc74P7ZvOiRzx3jJ2zVKtszME7V0mkHfWXffv6e/Hdt4bR2YC3BV/hjZwBw==
X-Received: by 2002:a17:907:7f2a:b0:a99:f675:b672 with SMTP id
 a640c23a62f3a-a9a69bab222mr814830866b.29.1729518296301; 
 Mon, 21 Oct 2024 06:44:56 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a9157360esm204047566b.157.2024.10.21.06.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 06:44:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] CI: Add a test for building without CMDLINE
Date: Mon, 21 Oct 2024 15:44:49 +0200
Message-ID: <20241021134450.22985-1-sjg@chromium.org>
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

Something this breaks, so add a test to keep it working. Since sandbox
enables a lot of options, it is a good board to use.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .azure-pipelines.yml |  8 ++++++++
 .gitlab-ci.yml       | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 3ff1b44a6bc..357cd06043f 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -19,6 +19,7 @@ variables:
   arm_catch_all: "arm -x aarch64,am33xx,at91,bcm,ls1,kirkwood,mvebu,omap,rk,siemens,mx,sunxi,technexion,toradex"
   aarch64_catch_all: "aarch64 -x amlogic,bcm,engicam,imx,ls1,ls2,lx216,mvebu,rk,siemens,sunxi,toradex"
   everything_but_arm_and_powerpc: "arc m68k microblaze mips nios2 riscv sandbox sh x86 xtensa -x arm,powerpc"
+  sandbox_no_cmdline: "-a ~CMDLINE --board sandbox"
 
 stages:
 - stage: testsuites
@@ -220,6 +221,7 @@ stages:
           built="$built $(tools/buildman/buildman ${BMANARGS} $(arm_catch_all) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(aarch64_catch_all) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(everything_but_arm_and_powerpc) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(sandbox_no_cmdline) | grep '^   ')"
           # Finally see how many machines that is.
           actual=$(tools/buildman/buildman ${BMANARGS} $built | grep "Total boards to build for each commit" | cut -d ' ' -f 8)
           echo We would build a total of $actual out of $total platforms this CI run
@@ -351,6 +353,10 @@ stages:
           BUILD_ENV: "FTRACE=1 NO_LTO=1"
           TEST_PY_TEST_SPEC: "trace"
           OVERRIDE: "-a CONFIG_TRACE=y -a CONFIG_TRACE_EARLY=y -a CONFIG_TRACE_EARLY_SIZE=0x01000000 -a CONFIG_TRACE_BUFFER_SIZE=0x02000000"
+        sandbox_no_cmdline:
+          TEST_PY_BD: "sandbox"
+          TEST_PY_TEST_SPEC: "nothing"
+          OVERRIDE: "-a ~CMDLINE"
     steps:
       - download: current
         artifact: testsh
@@ -565,6 +571,8 @@ stages:
           BUILDMAN: $(aarch64_catch_all)
         everything_but_arm_and_powerpc:
           BUILDMAN: $(everything_but_arm_and_powerpc)
+        sandbox_no_cmdline:
+          BUILDMAN: $(sandbox_no_cmdline)
     steps:
       - script: |
           cat << EOF > build.sh
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d89657e28b3..9770de5385a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -149,6 +149,17 @@ build all other platforms:
         exit $ret;
       fi;
 
+build no_cmdline:
+  extends: .world_build
+  script:
+    - ret=0;
+      git config --global --add safe.directory "${CI_PROJECT_DIR}";
+      ./tools/buildman/buildman -o /tmp -PEWM -a ~CMDLINE --board sandbox|| ret=$?;
+      if [[ $ret -ne 0 ]]; then
+        ./tools/buildman/buildman -o /tmp -seP;
+        exit $ret;
+      fi;
+
 .testsuites:
   stage: testsuites
   rules:
-- 
2.43.0

