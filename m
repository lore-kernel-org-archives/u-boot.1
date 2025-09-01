Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAA6CA1007
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 23:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C86AB83A1A;
	Tue,  2 Sep 2025 01:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="E8pApxGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BABA083A41; Tue,  2 Sep 2025 01:49:28 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E0383443
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 01:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 197C53F9ED; 
 Mon,  1 Sep 2025 23:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756770566;
 bh=TjrbMPNSaKsT8gvmfWWb9UOdErcL9BYJv5Moq2lkEm0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=E8pApxGlAVW931gy7WbLAu2KX3cKxQ8SO2Dg5zu+zx09I+1BCXryLz7N87raqq09U
 u9gzgWXwtW4D/3bK94Hug/wh+ikct0+F1Jfh+vRo+p8fRShLgz+hLrLyjQuOAVq1k9
 24PRZwcUvWe4ilhojkPxW2S9u294PyogOTkD/TKmiu9Wi0NN6pCostCemjPY0CQbEb
 O9xJFx52vDPdbZauAtGhsHHYX83rYJoxE/E/agV+g8T6E+iZbeepGUt86RPDrjNV1F
 V1pCOXFILfVOfVvibAt+mXrUzShtDEB3W4JmEjAezq8KafoEXb7W2ZH8QKklkQinNP
 BykogjQPja3fA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [TESTHOOKS PATCH 1/1] travis-ci: add qemu-riscv64_smode* test
 environments
Date: Tue,  2 Sep 2025 01:49:21 +0200
Message-ID: <20250901234921.35642-1-heinrich.schuchardt@canonical.com>
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

Provide test environments for running
qemu-riscv64_smode and qemu-riscv64_smode_acpi.

These use the OpenSBI implementation provided by QEMU and
pass main u-boot as -kernel parameter.

ACPI is enabled for both boards. We still expect the boards to use
QEMU's device-tree as control device-tree.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 bin/travis-ci/conf.qemu-riscv64_smode_acpi_na | 11 +++++++++++
 bin/travis-ci/conf.qemu-riscv64_smode_na      | 11 +++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 bin/travis-ci/conf.qemu-riscv64_smode_acpi_na
 create mode 100644 bin/travis-ci/conf.qemu-riscv64_smode_na

diff --git a/bin/travis-ci/conf.qemu-riscv64_smode_acpi_na b/bin/travis-ci/conf.qemu-riscv64_smode_acpi_na
new file mode 100644
index 0000000..ff5ecfb
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-riscv64_smode_acpi_na
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2025 Heinrich Schuchardt
+
+console_impl=qemu
+qemu_machine="virt,acpi=on"
+qemu_binary="qemu-system-riscv64"
+qemu_extra_args="-cpu rva23s64 -m 1G -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net0 -netdev user,id=net1,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net1 -device virtio-rng-device"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
diff --git a/bin/travis-ci/conf.qemu-riscv64_smode_na b/bin/travis-ci/conf.qemu-riscv64_smode_na
new file mode 100644
index 0000000..ff5ecfb
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-riscv64_smode_na
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2025 Heinrich Schuchardt
+
+console_impl=qemu
+qemu_machine="virt,acpi=on"
+qemu_binary="qemu-system-riscv64"
+qemu_extra_args="-cpu rva23s64 -m 1G -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net0 -netdev user,id=net1,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net1 -device virtio-rng-device"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
-- 
2.51.0

