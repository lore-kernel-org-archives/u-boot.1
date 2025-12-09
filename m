Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABC3D3B9A4
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 23:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9600983BC9;
	Wed, 10 Dec 2025 00:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="g0VcEWd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F267783C7B; Wed, 10 Dec 2025 00:03:25 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECB7083B8B
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 00:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2C61F4003D; 
 Tue,  9 Dec 2025 23:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765321403;
 bh=sFAZJJ6R3i/mfhTKXaGk04BQE6iDzCe1D5s6t/yQydU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=g0VcEWd2fIIE463hsq/9E3bXlTmHCdlkAtHy8cjTyS8FUuUQm9jbaFXhKT/DuSK9A
 d6thw+4B6Wbg/JDPhijkoNkehR5x6IWcnaThKKIIUHp8LZb4Z1CtMDWjUnVWAqw5Fe
 aCCGGGYDHNFiCiKG1QiHpd1J+i/ERLse0pmkfb1MCgJyg5pVKtp+Dr0d9G/BmX62Oi
 0u1xPEkVghelAiWrPxwf4FvR4yRw//gSDhI8JRa2GsTdQdXDSaXJebegnMFSpYziE0
 3anNKR0iN+4tgLgve5UkiggyS8XomYUS4VzrHJrFNCdBi+h8u0/T1vo5Ks3gGyyLI6
 b/W4mNEtzCb6FSG3QzX4LcPIxzRuBowXb/HPAsIAcuXWFm4k0iJgYzjFHvL4GbU/ST
 jPR64/muGt0PUE/66aSmSRPBxic0U5wqGMQLrnOSRFgP176lwrXYVFbZDdVRz+XrID
 F6RDsM4fg6l8Frqn1w97CIvyoH3y5tBAg2Jp+pvRM/3G+cinRa3AHHQCla1EQcTwI4
 rp7Zzmq1vKRaDZjLPMtiTmUZZdV4OSWko64PYS4Io+xSzUmFHzqc4MUQMLbmHfqVvM
 711fNGGeuHh1AtgMoU4KHHZLW8Cie77A8BTvQzwNj0RNrh4YT1lP8TA2FMgR71HRmQ
 uvm+tmI5Pj5BvuvcIoSCeTbM=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Stephen Warren <swarren@nvidia.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [U-BOOT TESTHOOKS][PATCH 1/1] py/travis-ci: add
 u_boot_boardenv_qemu_riscv64_smode_(acpi_)na.py
Date: Wed, 10 Dec 2025 00:03:18 +0100
Message-ID: <20251209230318.416872-1-heinrich.schuchardt@canonical.com>
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

Add missing boardenv files for

* qemu-riscv64_smode_defconfig
* qemu-riscv64_smode_acpi_defconfig

to enable network testing.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .../u_boot_boardenv_qemu_riscv64_smode_acpi_na.py      | 10 ++++++++++
 py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py  | 10 ++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_acpi_na.py
 create mode 100644 py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py

diff --git a/py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_acpi_na.py b/py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_acpi_na.py
new file mode 100644
index 0000000..a86e0bd
--- /dev/null
+++ b/py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_acpi_na.py
@@ -0,0 +1,10 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_grub_file = travis_tftp.file2env('grub_riscv64.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py b/py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py
new file mode 100644
index 0000000..a86e0bd
--- /dev/null
+++ b/py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py
@@ -0,0 +1,10 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_grub_file = travis_tftp.file2env('grub_riscv64.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
-- 
2.51.0

