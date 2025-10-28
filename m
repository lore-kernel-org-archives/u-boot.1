Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0546DCCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 13:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E3C982A9E;
	Tue, 28 Oct 2025 14:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="D6Wzmhvm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58EF881D6A; Tue, 28 Oct 2025 14:17:30 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA0D82A9E
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 14:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F186340289; 
 Tue, 28 Oct 2025 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761657444;
 bh=aAsXwDH+iwMDg1yAiMgWpRLerubu70d3I7fAW+goVbI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=D6WzmhvmdL/OMz4yEjiJwfGOXKu94hUFknt89gaAjkyUadhOgIlq7kn+naVdPG6oH
 4ApaYyypAV8jrFoTPzNjZKByHMC1Uoe2Dqc6V33DvRJ/Sh76qms/Lzd/jq0eveZ9XB
 Mkz5G6yu5BmLYFnQ9gkuYXUgbp04N9AFmHZwOK0EcojcHLuqGRNid1iUo7zTEZ35DX
 PoCYLW2fZXDA9bR99tFr2vQ9RrifLOFgfKO9T+tis9M9LFMsGK1pv41htLYzXShsfF
 zEhHOnAxw9q39XXq3SajYsTnhqN3RMfzz+0NImWS/pIgo69PV7bQcniVqX60P8T2O6
 s4epEg3w505f2v/0O6wup+addWfbHfGsSV9liGqPgPJz+IcTO0HwXcj7Z466XYHXg8
 IWOKmrsRFdiYC8MTeS1Hbs0tM4wvNJEJLGIVmxRMEkyUkDMGXTBy3sNNIrkGeTZDsz
 /oWDiY/QWEE7pl6/657KbYQ0PXBt/bEUFtk78u7I95ojhBa9rEGLCFzORva2ra+gOh
 DS6bWaRSzQhQUzcPxmIW+sD1vuVChvf2yF21/PZQEKzroa1LqjdgIGnlS2x4FF2Rre
 SO6xM6H72S+/+Xg9HrzZNLppRvQW59y2uUhPN0dOXZdvBO/+RklvoijBxcmXQYfx/i
 GuJxja9WOY5n86LlJOcCkAZs=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] CI: test qemu-riscv64_smode[_acpi]
Date: Tue, 28 Oct 2025 14:17:19 +0100
Message-ID: <20251028131720.55212-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

QEMU comes with its own OpenSBI. For running RISC-V virtual machine
using one of qemu-riscv64_smode_defconfig or
qemu-riscv64_smode_acpi_defconfig is the natural choice.

Add the riscv64 smode configurations to the test scope.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .azure-pipelines.yml |  6 ++++++
 .gitlab-ci.yml       | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fc55c8b2100..be310b85eda 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -506,6 +506,12 @@ stages:
         qemu_riscv64_spl:
           TEST_PY_BD: "qemu-riscv64_spl"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_riscv64_smode:
+          TEST_PY_BD: "qemu-riscv64_smode"
+          TEST_PY_TEST_SPEC: "not sleep"
+        qemu_riscv64_smode_acpi:
+          TEST_PY_BD: "qemu-riscv64_smode_acpi"
+          TEST_PY_TEST_SPEC: "not sleep"
         qemu_x86:
           TEST_PY_BD: "qemu-x86"
           TEST_PY_TEST_SPEC: "not sleep"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 73ff975e574..e3cba5d6b90 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -471,6 +471,18 @@ qemu-riscv64_spl test.py:
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
+qemu-riscv64_smode test.py:
+  variables:
+    TEST_PY_BD: "qemu-riscv64_smode"
+    TEST_PY_TEST_SPEC: "not sleep"
+  <<: *buildman_and_testpy_dfn
+
+qemu-riscv64_smode_acpi test.py:
+  variables:
+    TEST_PY_BD: "qemu-riscv64_smode_acpi"
+    TEST_PY_TEST_SPEC: "not sleep"
+  <<: *buildman_and_testpy_dfn
+
 qemu-x86 test.py:
   variables:
     TEST_PY_BD: "qemu-x86"
-- 
2.51.0

