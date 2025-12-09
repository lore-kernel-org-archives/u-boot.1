Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCBFD3B9B6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 23:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D2A83642;
	Wed, 10 Dec 2025 00:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="N7Gn1aoM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4760883655; Wed, 10 Dec 2025 00:59:12 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E5283015
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 00:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id EE2303F28E; 
 Tue,  9 Dec 2025 23:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765324749;
 bh=tnvmvRPC5QbY27BCMtxboS7xKyjCEnuFFd8NmuSjMbk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=N7Gn1aoMbyHwNScN5sQ6PugLuAM+yeo5UPbQbbI/V+nfPwUuifmrXv05pYIM/gwWJ
 g3pAtieLrEaxG8+KfGLy4N6BXZ0q3xGmixi+Wqp0/fxlokQWJrevTdoIKwYJxUYArZ
 CdjLtB8mcKZezUai39HAL+tbxrCsHTAoOsCuwJr/bcS8XefKjSX3T+7EUarWDPInmQ
 5yxQFegarLyatv0tqKV3pfaDsz9OzhpdevCDhU9saDN2+iLLLIZUngi59FutYsUWqZ
 x2pjmUGHK70o5EbSJJMVoayq4rg8lmve/tYBbvIsVhU1R0ZbO8EUn9SL23fzziYhES
 XOblABX0QxG38dm+NK5kVGVkfaCL2jslQXxx5Z2VYlRZ3nMXoC5Y8TJzZazpMm9Pcw
 uzvDSyElNOKX9T8N6/IZktbfov11yBcUqEBheED9+ECbv5EI09Hnqf5znvki7GCf6j
 GkhCotva0kQb+OKA46cKNOqgfYP5VzsF9Tc5wXsK+XAD6VQwxkloNT4x1jOWwFIw2l
 shdyFa3bXd+J5dERScJ2mWTQPQPGdMJlmmxAVtREnHY6w/Ns1Hmx1B43z4OVkUe86k
 VbSCbdNWQ2bL0LVs/FJFf9FQoRtcwplBqNBDlRTJYlxYMGRKv1MCRGFF8/xxCwKVPX
 R67Dg6N8P5u1ROV3Z5ebWupg=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] configs: qemu_arm64: disable SEMIHOSTING
Date: Wed, 10 Dec 2025 00:59:05 +0100
Message-ID: <20251209235905.431884-1-heinrich.schuchardt@canonical.com>
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

Semihosting allows a virtual machine to write to the host file system.
Such dangerous settings should not be in a defconfig.

Move it to a CI configuration override.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .azure-pipelines.yml         | 1 +
 .gitlab-ci.yml               | 1 +
 configs/qemu_arm64_defconfig | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 25b0e4c985c..81a36da7114 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -504,6 +504,7 @@ stages:
         qemu_arm64:
           TEST_PY_BD: "qemu_arm64"
           TEST_PY_TEST_SPEC: "not sleep"
+          OVERRIDE: "-a CONFIG_SEMIHOSTING=y"
         qemu_arm64_lwip:
           TEST_PY_BD: "qemu_arm64_lwip"
           TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 08bea0dd234..28a32f9f4d3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -387,6 +387,7 @@ qemu_arm64 test.py:
   variables:
     TEST_PY_BD: "qemu_arm64"
     TEST_PY_TEST_SPEC: "not sleep"
+    OVERRIDE: "-a CONFIG_SEMIHOSTING=y"
   <<: *buildman_and_testpy_dfn
 
 qemu_arm64_lwip test.py:
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 12ed6b61239..fd0bdad2d62 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -71,7 +71,6 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_TPM2_MMIO=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
-CONFIG_SEMIHOSTING=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_TPM_PCR_ALLOCATE=y
-- 
2.51.0

