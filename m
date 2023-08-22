Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8618EE49AF
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 17:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06B9C864F0;
	Tue, 22 Aug 2023 19:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF977864F0; Tue, 22 Aug 2023 19:41:02 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 51AE8864D3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 19:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67E3F11FB;
 Tue, 22 Aug 2023 10:41:40 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51A113F762;
 Tue, 22 Aug 2023 10:40:57 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v11 09/15] sandbox: trace: Increase trace buffer size
Date: Tue, 22 Aug 2023 23:10:02 +0530
Message-Id: <20230822174008.626239-10-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822174008.626239-1-sughosh.ganu@linaro.org>
References: <20230822174008.626239-1-sughosh.ganu@linaro.org>
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

When running the trace test on the sandbox platform, the current size
of 16MiB is no longer large enough for capturing the entire trace
history, and results in truncation. Use a size of 32MiB for the trace
buffer on the sandbox platform while running the trace test.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V10: None

 .azure-pipelines.yml        | 2 +-
 .gitlab-ci.yml              | 2 +-
 test/py/tests/test_trace.py | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 0be317b388..d4591234c4 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -275,7 +275,7 @@ stages:
           TEST_PY_BD: "sandbox"
           BUILD_ENV: "FTRACE=1 NO_LTO=1"
           TEST_PY_TEST_SPEC: "trace"
-          OVERRIDE: "-a CONFIG_TRACE=y -a CONFIG_TRACE_EARLY=y -a CONFIG_TRACE_EARLY_SIZE=0x01000000"
+          OVERRIDE: "-a CONFIG_TRACE=y -a CONFIG_TRACE_EARLY=y -a CONFIG_TRACE_EARLY_SIZE=0x01000000 -a CONFIG_TRACE_BUFFER_SIZE=0x02000000"
         coreboot:
           TEST_PY_BD: "coreboot"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5750d82023..cef42aca8c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -315,7 +315,7 @@ sandbox trace_test.py:
     TEST_PY_BD: "sandbox"
     BUILD_ENV: "FTRACE=1 NO_LTO=1"
     TEST_PY_TEST_SPEC: "trace"
-    OVERRIDE: "-a CONFIG_TRACE=y -a CONFIG_TRACE_EARLY=y -a CONFIG_TRACE_EARLY_SIZE=0x01000000"
+    OVERRIDE: "-a CONFIG_TRACE=y -a CONFIG_TRACE_EARLY=y -a CONFIG_TRACE_EARLY_SIZE=0x01000000 -a CONFIG_TRACE_BUFFER_SIZE=0x02000000"
   <<: *buildman_and_testpy_dfn
 
 evb-ast2500 test.py:
diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index ac3e95925e..ad2250920d 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -61,7 +61,7 @@ def collect_trace(cons):
 
     # Read out the trace data
     addr = 0x02000000
-    size = 0x01000000
+    size = 0x02000000
     out = cons.run_command(f'trace calls {addr:x} {size:x}')
     print(out)
     fname = os.path.join(TMPDIR, 'trace')
-- 
2.34.1

