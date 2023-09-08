Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4DACCFA0A
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 12:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3012186A63;
	Fri,  8 Sep 2023 14:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 684B686A56; Fri,  8 Sep 2023 14:00:43 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8F5D986A1D
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 14:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1176414BF;
 Fri,  8 Sep 2023 05:01:18 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D5193F67D;
 Fri,  8 Sep 2023 05:00:37 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 5/8] sandbox: capsule: Add a config file for generating
 capsules
Date: Fri,  8 Sep 2023 17:29:59 +0530
Message-Id: <20230908120002.29851-6-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908120002.29851-1-sughosh.ganu@linaro.org>
References: <20230908120002.29851-1-sughosh.ganu@linaro.org>
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

Support has been added to the mkeficapsule tool to generate capsules
by parsing the capsule parameters through a config file. Add a config
file for generating capsules. These capsules will be used for testing
the capsule update feature on sandbox platform.

Enable generation of capsules through the config file on the sandbox
variant.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 configs/sandbox_defconfig                     |   2 +
 .../test_efi_capsule/sandbox_capsule_cfg.txt  | 162 ++++++++++++++++++
 2 files changed, 164 insertions(+)
 create mode 100644 test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 98f0bc13a5..34f4adc10f 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -342,6 +342,8 @@ CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_ESL_FILE="board/sandbox/capsule_pub_esl_good.esl"
+CONFIG_EFI_CAPSULE_CFG_FILE="test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt"
+CONFIG_EFI_USE_CAPSULE_CFG_FILE=y
 CONFIG_EFI_SECURE_BOOT=y
 CONFIG_TEST_FDTDEC=y
 CONFIG_UNIT_TEST=y
diff --git a/test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt b/test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt
new file mode 100644
index 0000000000..2897c1904e
--- /dev/null
+++ b/test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt
@@ -0,0 +1,162 @@
+{
+	image-index: 1
+	image-guid: 09D7CF52-0720-4710-91D1-08469B7FE9C8
+	payload: u-boot.bin.new
+	capsule: Test01
+}
+{
+	image-index: 2
+	image-guid: 5A7021F5-FEF2-48B4-AABA-832E777418C0
+	payload: u-boot.env.new
+	capsule: Test02
+}
+{
+	image-index: 1
+	image-guid: 058B7D83-50D5-4C47-A195-60D86AD341C4
+	payload: u-boot.bin.new
+	capsule: Test03
+
+}
+{
+	image-index: 1
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test04
+
+}
+{
+	image-index: 1
+	image-guid: 058B7D83-50D5-4C47-A195-60D86AD341C4
+	payload: u-boot_bin_env.itb
+	capsule: Test05
+
+}
+{
+	image-index: 1
+	image-guid: 058B7D83-50D5-4C47-A195-60D86AD341C4
+	payload: u-boot_bin_env.itb
+	capsule: Test05
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 09D7CF52-0720-4710-91D1-08469B7FE9C8
+	payload: u-boot.bin.new
+	capsule: Test11
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	private-key: SIGNER2.key
+	pub-key-cert: SIGNER2.crt
+	image-guid: 09D7CF52-0720-4710-91D1-08469B7FE9C8
+	payload: u-boot.bin.new
+	capsule: Test12
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test13
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	private-key: SIGNER2.key
+	pub-key-cert: SIGNER2.crt
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test14
+}
+{
+	image-index: 1
+	fw-version: 5
+	image-guid: 09D7CF52-0720-4710-91D1-08469B7FE9C8
+	payload: u-boot.bin.new
+	capsule: Test101
+}
+{
+	image-index: 2
+	fw-version: 10
+	image-guid: 5A7021F5-FEF2-48B4-AABA-832E777418C0
+	payload: u-boot.env.new
+	capsule: Test102
+}
+{
+	image-index: 1
+	fw-version: 2
+	image-guid: 09D7CF52-0720-4710-91D1-08469B7FE9C8
+	payload: u-boot.bin.new
+	capsule: Test103
+
+}
+{
+	image-index: 1
+	fw-version: 5
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test104
+}
+{
+	image-index: 1
+	fw-version: 2
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test105
+
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	fw-version: 5
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 09D7CF52-0720-4710-91D1-08469B7FE9C8
+	payload: u-boot.bin.new
+	capsule: Test111
+}
+{
+	image-index: 2
+	monotonic-count: 1
+	fw-version: 10
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 5A7021F5-FEF2-48B4-AABA-832E777418C0
+	payload: u-boot.env.new
+	capsule: Test112
+}
+{
+	image-index: 1
+	monotonic-count: 1
+	fw-version: 2
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 09D7CF52-0720-4710-91D1-08469B7FE9C8
+	payload: u-boot.bin.new
+	capsule: Test113
+}
+{
+	image-index: 1
+	fw-version: 5
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test114
+}
+{
+	image-index: 1
+	fw-version: 2
+	monotonic-count: 1
+	private-key: SIGNER.key
+	pub-key-cert: SIGNER.crt
+	image-guid: 3673B45D-6A7C-46F3-9E60-ADABB03F7937
+	payload: u-boot_bin_env.itb
+	capsule: Test115
+}
-- 
2.34.1

