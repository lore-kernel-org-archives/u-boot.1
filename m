Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE35CCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 10:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7AAA83F53;
	Sun,  9 Nov 2025 11:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="f4o06sxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3415D83F4C; Sun,  9 Nov 2025 11:10:52 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5302783E8A
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 11:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-110-120.46.114.pool.telefonica.de
 [46.114.110.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 61679409F4; 
 Sun,  9 Nov 2025 10:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762683037;
 bh=2PA9PcpFzkbcj7bZEnIl6F+y+hkBjtE1CHjCC8OdrLk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=f4o06sxrqibnrVlnElPdxmtyaZRYY6+jsJXuSvBQES5PtNin4xCBSpt7IcPa/RE1R
 GS+Uawx5rDiQSZMWxYIyuy2RT5E24r//l3kmKETQg/9FGy8j0NiGvW9yDRdDMktza9
 eTs+FioYKLzYavdOyV3xX3BExthAxoi9tEso1YLr/IQIIuDOxz74MKM8ikrTxrw5ZR
 PC/iQiwLtZia7+DJGtxujpmlwta+OMClBw4igZJuxuykTKRpe41x1j74n7AIo2v4X/
 V1F8bY2apWcIASMmNH5LSnuu8TEQ5CaWyk6zkbEVC9xthlola/cE5eKyIpabO5V78d
 vBBpjVNr6h2vy+oJeYUPkQ5IJpMa61Sw/C28BBAS4we2R+HsWTEgWQGBQg3GkS7YH7
 NVkqsA/ficLI+mSblAKy7NX9I28Y54d16aYyZdJw3iiZwGYuOP7e1q1FQTdATpsAFX
 SSIt9hJKAgwDV2vWXnmFtKQi2GItH10J80xccNZkyjiuHSS4GL55jpGjmhaOk1UAtM
 Hx5eDoT3zNUPtJFbQ12z4Fiv5h1P8ieVrg5GrN7G/yt7h4Vk7gna57xrLVuDURC4GG
 C5XP8obYRHc6VykvHYlK95653GH3JlvDjz5joyjXIM1z9YlRcsPZnHUb5lckvRzV19
 0RUlVpy/w59ZjZN91VoTXjYI=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH RESEND 9/9] CI: test qemu-riscv64_smode[_acpi]
Date: Sun,  9 Nov 2025 11:10:10 +0100
Message-ID: <20251109101010.306268-10-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 .azure-pipelines.yml |  6 ++++++
 .gitlab-ci.yml       | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 3b684ec73ba..06f999aab1a 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -522,6 +522,12 @@ stages:
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
index 0337380f98e..7cd0e521049 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -474,6 +474,18 @@ qemu-riscv64_spl test.py:
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

