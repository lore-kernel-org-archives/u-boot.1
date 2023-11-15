Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3314DC48BF9
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 14:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 269758745E;
	Wed, 15 Nov 2023 15:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ca+hlaCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D775187258; Wed, 15 Nov 2023 15:24:12 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D551787282
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 15:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 07AD1419DA; 
 Wed, 15 Nov 2023 14:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700058248;
 bh=4d7YoQReBXfSN3/O9b+mxYV6MEU86uKLqqN+nc9fSLw=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=ca+hlaCaeeG6KawoC5YBi8iVoVujtqIh9nJuE+qe/yHp1mqsqc5uC5TUE1h/l7xno
 hbmC5GgsSgZZ7lrKl64rrZGTFL9inbZRBRor3GmU7rkebBBPE/k82A/B5kR7gjDuRL
 sbjH1ytQ97oaeYY5L10z79LkwNnwrkKLcViTS0E59sINZwPF7f///cT39qX1vP7PB4
 rHil0R4ot5JhqXg+OWJuQA0cv/2K6EZH+wB1ADZOePNgHVzsVYbNqsN8zUHyTQ/0nU
 niGSwA3yt52RD03vt2m9cYAWYmy3w7ow9yOonT4bcyLAeGupGrxzY6OO+E/c3isvd/
 5xjWIEDsi9low==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Alexander Gendin <agendin@matrox.com>, Zong Li <zong.li@sifive.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 6/6] configs: defconfig for QEMU RISC-V with ACPI
Date: Wed, 15 Nov 2023 15:23:55 +0100
Message-Id: <20231115142355.123038-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
References: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
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

Provide a defconfig for testing ACPI on RISC-V.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/emulation/qemu-riscv/MAINTAINERS    |  1 +
 configs/qemu-riscv64_acpi_smode_defconfig | 27 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 configs/qemu-riscv64_acpi_smode_defconfig

diff --git a/board/emulation/qemu-riscv/MAINTAINERS b/board/emulation/qemu-riscv/MAINTAINERS
index 3d7453f1b4..80c75a18f8 100644
--- a/board/emulation/qemu-riscv/MAINTAINERS
+++ b/board/emulation/qemu-riscv/MAINTAINERS
@@ -7,6 +7,7 @@ F:	include/configs/qemu-riscv.h
 F:	configs/qemu-riscv32_defconfig
 F:	configs/qemu-riscv32_smode_defconfig
 F:	configs/qemu-riscv32_spl_defconfig
+F:	configs/qemu-riscv64_acpi_smode_defconfig
 F:	configs/qemu-riscv64_defconfig
 F:	configs/qemu-riscv64_smode_defconfig
 F:	configs/qemu-riscv64_spl_defconfig
diff --git a/configs/qemu-riscv64_acpi_smode_defconfig b/configs/qemu-riscv64_acpi_smode_defconfig
new file mode 100644
index 0000000000..0227d1dfe0
--- /dev/null
+++ b/configs/qemu-riscv64_acpi_smode_defconfig
@@ -0,0 +1,27 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DEFAULT_DEVICE_TREE="qemu-virt64"
+CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_TARGET_QEMU_VIRT=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr}; fdt addr ${fdtcontroladdr};"
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_NVEDIT_EFI=y
+# CONFIG_CMD_MII is not set
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_DM_MTD=y
+CONFIG_FLASH_SHOW_PROGRESS=0
+CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_ACPI=y
+CONFIG_GENERATE_ACPI_TABLE=y
-- 
2.40.1

