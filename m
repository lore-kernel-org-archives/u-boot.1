Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954BACA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 19:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4163081490;
	Wed,  7 Oct 2026 19:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NyAXMEuz41Bn; Wed,  7 Oct 2026 19:39:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 520E98146F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791401975;
	b=Y6ZoUWk3tGhhbTalAaNtCONrJC1P083U5Ql5IXMLUs7r8Z0uxcC5Eu+jTTv6QJix0XjE
	 cCfaec65ywIfO+48xESgbi6T+phqT1pK7FvdZr/MC1DOotCvc/kmBIcq6PDjfB5NO9Abr
	 5ZUYjKXvta37shGveySxgyiF10oeba8731t5K2LqEd37JhbUH3ODcQJLYDiJPwkdUqgyx
	 Cfl3PAa8ryCcMwSHeQz3XT2M/qg8Zz6q81GXESWK/mwDj1jezga9+tWh72wrj+umCa7AT
	 1vVSRj7Q69eOB6zi4SVXxqjTWck67o/jq46ClbyNbng5Su5ZAmXUssDcdS47yjMxQkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791401975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6DswomCTu3m/fT1esz4Ve+KoU5PyB3pQN7a++6PHjFI=;
	b=UfRk8Mpc69Zn1sBl251kELcdrT/aDVdGzRT8ltwb4OCB8NXG7ti+eXbrm0XI7XcN6mBi
	 +DQ/sRcpId6mYHEi2DJ6jGzTciPa6OIMUEdrtusiS+K4BTlgWaOtzQQ2b/6ZVS1FM6UeZ
	 G/WGulKKvb9LB+zd4QfA/mMhUBunsqy8qLwkW/7d2am8bQt5xSDuVCcwAIkIx4YkRW2aD
	 a2l8v3IFlSiH3jkhjYpKZXQCLLDm0FG8ZKecogDrkLgFFpOKknSeLACXAUUY61AMjQUNb
	 1TLX3OVLUCd7JzpK3l63Mwcx5aibyDcrFz2Rvul/1hUdiOluJVkJiETgoxkADeo2P0g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791401975;
	bh=6DswomCTu3m/fT1esz4Ve+KoU5PyB3pQN7a++6PHjFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tvZilZbWcHYbIaZAA47atXjisWabfaJzpWJ86LIdmfVNbP0IRPiZNmY3FL1bEnKVk
	 wf+y9CkGHTGosXqG+Q2mUdcFrY2ZtkHPcLhhyCzRNYzwKXEHmN3MZkqJrljRwxkRs/
	 HHEneHgRb5HQOaNMX+ezzleHC83jw7KEeg/0c8tQFt/1hWdfNXyFUFRCy2/ZUYqiqo
	 yP2vR9d9kZGl3hab5eNscxCtRcFse2+YFK3ePoHDeO9Kbfls+mHnb92yQL+iLqJZ18
	 sTguUWzmcJXuOUhBjl8B4GFnxQMCu+PSQ0MQFxJ4zBx2bMWCh+iC9Bm7Nhj3WyrHT8
	 nuP13xMVdxNiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 520E98146F;
	Wed,  7 Oct 2026 19:39:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B17375
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 721E340B0E
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:09:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lXxe_RGjhHkc for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 19:09:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7043840B0D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791400154;
 b=VPlWdd+lt/EBVMFriMqA49l0fVk3bBoCIk3ttd+5KqHwmnvjMNS0gNX+zglMFwRXBNBV
 XeC041+xIEUoyYlut75Q7APN9neP93Lv41hhEea0t/Ff2DgZw5CjmLc6MTcTeryOTKaX/
 NKibXF5uvh3EXDmRdAauKWIAZgVrGpe3s+9Cug7ZeFNGXkQeTzI0MO5mqrJDVnH2ZXxYT
 FgIqUQsuTyIlNdRQRC6XwUBgsFVMA8qRT+Ab/aLGv4TRHT74G1mTz4lAVdku5tmwTcWPR
 68IHQ41M5BQH4nk2PhNzM98omVhFIJ/RR4b4wfHU4QctijZ/Px2OY8Fn77H6HLmzXGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791400154;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=6DswomCTu3m/fT1esz4Ve+KoU5PyB3pQN7a++6PHjFI=;
 b=R4JuS/WqnIX/KPWnqldrCGLnzDlPtTeKU6TWFwS6A0pbVVvcCIKqalYjIdAiaQyvf+tv
 YJXSkpKBxaxGMNTKflVNqxKwG/AYYHDjcCKAvsgbN98jQjxENHZHsrhNDQbcI4Po+hSos
 uPsksxsdY4Zcp+ZUlnqeKilhXtYVjlyfQefR6WK0IQMqiKgmFZIk12abyTiL0qUSX4Cnm
 X87FdYMDJgPYSBDIwicn/BNRlnwQ0fJ+HO+ya9IxKFZh/vYKlDrecuH3nIgcfN+YEv4SQ
 wTITpxpje0xZWYp4vzpIwrtbGJY3VuPJ9LngWct//QNWhBY8inhJO8nldB6a8GayAgQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b="sLJu/FNR"; 
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=sLJu/FNR
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7043840B0D
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:09:12 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2DDE73FBA2; 
 Wed,  7 Oct 2026 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791400150;
 bh=6DswomCTu3m/fT1esz4Ve+KoU5PyB3pQN7a++6PHjFI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=sLJu/FNRLBH8LSAPIKBtXekGlMfczj2u6ZtsKeeDgxX/0YeMtjuXfOB8KCAUwojtE
 LcVZoMQEA6abzfcxD00/k7mDF+0jgIzOZspfL4BmlqHPJ58motQApL+lWLp4Fy9uM+
 3NIQZDOg3BvwIwj7S5Rouf6YkluwOaQFiHfD+7G5Q4QEeEk3iAZWhNz1nbNwlYhGlF
 l8QriPIBX+rUXvKxbrQALa5j9LCi/nR7EUf/kyrUy2UtBuI5gA9gfT07utpcX242AY
 UgRLhDhv1TFgTSSeagbBHk3lGSkGZ0whmWeCc5EgqlwBj5ycasqGZsT7bWOkWM7XMm
 zfwnbqed5+OFR+BF6lICBXVRXKRQ3BHltRTkmBCsJRcDbXSZEWAtHp+KoaL0kkM6C4
 p/SPrwyethKAapuNb6H/Tt3m0V2Pt8j6YMpsCE63AajO8HRzKHvX6g/Sadtw0lGUUI
 09BkLFZ90BM76NuQv2TvK3lHTmaLqnwxRviHEbO5Xsm11xB3A5myW1a7l9iFHc+h5z
 eL81iapwGsL0Xgx9WoutIsKRAq4hhM6Xxet72Lt7tkzkjOiu/bG7lH55YlOH0jJoph
 OFfw88tmhzp3s415jkeJtkr6GqzdgM2h/U2yqjdjlqL5WWw8asQLMqW5k6M46ElnOY
 hO8qmv4iDCtDWd5S8wzTlRNc=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] sysreset: provide sysreset driver for qemu-x86(_64)
Date: Wed,  7 Oct 2026 21:09:03 +0200
Message-ID: <20261007190905.29585-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007190905.29585-1-heinrich.schuchardt@canonical.com>
References: <20261007190905.29585-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Currently we only support reset but not poweroff on x86 QEMU.
As we are running on top of QEMU we know the relevant ports.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/sysreset/Kconfig             |   8 ++
 drivers/sysreset/Makefile            |   1 +
 drivers/sysreset/sysreset_qemu_x86.c | 155 +++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_qemu_x86.c

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index a046dd02e66..ed4df7cef42 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -320,6 +320,14 @@ config SYSRESET_QEMU_VIRT_CTRL
 	  This device is used in QEMU machines (e.g. m68k virt) to trigger
 	  system reset and poweroff events.
 
+config SYSRESET_QEMU_X86
+	bool "Support sysreset for QEMU i440fx and q35"
+	depends on SYSRESET
+	depends on X86
+	help
+	  This driver supports reboot and poweroff on the i440fx and q35
+	  QEMU virtual machines.
+
 endif
 
 endmenu
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index d18a5d52360..c6f15aa9176 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -33,3 +33,4 @@ obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
 obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
 obj-$(CONFIG_SYSRESET_QEMU_VIRT_CTRL) += sysreset_qemu_virt_ctrl.o
+obj-$(CONFIG_$(PHASE_)SYSRESET_QEMU_X86) += sysreset_qemu_x86.o
diff --git a/drivers/sysreset/sysreset_qemu_x86.c b/drivers/sysreset/sysreset_qemu_x86.c
new file mode 100644
index 00000000000..c1451a87fc8
--- /dev/null
+++ b/drivers/sysreset/sysreset_qemu_x86.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ *
+ * Poweroff and reset driver for x86 processor on QEMU
+ */
+
+#include <dm.h>
+#include <sysreset.h>
+#include <pci.h>
+#include <pci_ids.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+
+/* ACPI S5 Soft-Off Register Flags */
+#define ACPI_SLP_TYP_S5 (0) /* Bits 10-12 = 000 */
+#define ACPI_SLP_EN BIT(13) /* Bit 13 = 1 */
+#define QEMU_POWEROFF_WORD (ACPI_SLP_TYP_S5 | ACPI_SLP_EN) /* 0x2000 */
+
+/* Standard x86 Hardware Reset Register Definitions */
+#define X86_RESET_REG_PORT 0x0cf9
+#define X86_SYS_RST BIT(1) /* Bit 1: System Reset */
+#define X86_RST_CPU BIT(2) /* Bit 2: Reset CPU */
+#define X86_FULL_RST BIT(3) /* Bit 3: Full/Cold Reset Toggle */
+
+/* Reset Command Byte Schemes */
+#define X86_WARM_RESET_VAL (X86_SYS_RST | X86_RST_CPU) /* 0x06 */
+#define X86_COLD_RESET_VAL (X86_SYS_RST | X86_RST_CPU | X86_FULL_RST) /* 0x0e */
+
+enum qemu_x86_chipset {
+	CHIPSET_I440FX,
+	CHIPSET_Q35
+};
+
+struct qemu_x86_sysreset_plat {
+	u16 pmbase_reg; /* PCI configuration space offset for PMBASE */
+	u32 pmbase_val; /* Assigned target structural I/O window address */
+	u16 pcicnt_reg; /* Subsystem bit routing enable switch register */
+	u8 pcicnt_val; /* Bitmask to assert the target configuration decoder */
+	u16 pm1_cnt_port; /* Calculated absolute runtime I/O port address */
+};
+
+static int qemu_x86_sysreset_request(struct udevice *dev, enum sysreset_t type)
+{
+	struct qemu_x86_sysreset_plat *plat = dev_get_plat(dev);
+	enum qemu_x86_chipset chipset =
+		(enum qemu_x86_chipset)dev_get_driver_data(dev);
+	struct udevice *pci_bridge_dev = NULL;
+	int ret;
+	u16 product_id;
+
+	switch (type) {
+	case SYSRESET_WARM:
+		/* Issue standard x86 warm reset via I/O Port 0xcf9 */
+		outb(X86_WARM_RESET_VAL, X86_RESET_REG_PORT);
+		break;
+
+	case SYSRESET_COLD:
+		/* Issue standard x86 cold reset via I/O Port 0xcf9 */
+		outb(X86_COLD_RESET_VAL, X86_RESET_REG_PORT);
+		break;
+
+	case SYSRESET_POWER_OFF:
+		if (chipset == CHIPSET_Q35)
+			/* Intel 82801IR (ICH9R) LPC Interface Controller */
+			product_id = PCI_DEVICE_ID_INTEL_ICH9_8;
+		else
+			/* Intel 82371AB/EB/MB PIIX4 ACPI-Controller */
+			product_id = PCI_DEVICE_ID_INTEL_82371AB_3;
+
+		ret = dm_pci_find_device(PCI_VENDOR_ID_INTEL, product_id, 0,
+					 &pci_bridge_dev);
+
+		if (ret)
+			return -ENODEV;
+
+		/* Map the target ACPI base window using DM PCI config write */
+		dm_pci_write_config32(pci_bridge_dev, plat->pmbase_reg,
+				      plat->pmbase_val);
+
+		/* Enable the hardware bridge routing decoder switch via DM */
+		dm_pci_write_config8(pci_bridge_dev, plat->pcicnt_reg,
+				     plat->pcicnt_val);
+
+		/* Write S5 word */
+		outw(QEMU_POWEROFF_WORD, plat->pm1_cnt_port);
+		break;
+
+	default:
+		return -ENOSYS;
+	}
+
+	/* Wait for poweroff or reboot */
+	while (1)
+		asm volatile("hlt");
+}
+
+/**
+ * qemu_x86_sysreset_of_to_plat() - setup platform defaults
+ *
+ * @dev:	sysreset device
+ * Return:	0 on success
+ */
+static int qemu_x86_sysreset_of_to_plat(struct udevice *dev)
+{
+	struct qemu_x86_sysreset_plat *plat = dev_get_plat(dev);
+	enum qemu_x86_chipset chipset =
+		(enum qemu_x86_chipset)dev_get_driver_data(dev);
+
+	if (chipset == CHIPSET_Q35) {
+		plat->pmbase_reg =
+			dev_read_u32_default(dev, "intel,pmbase-reg", 0x40);
+		plat->pmbase_val = dev_read_u32_default(dev, "intel,pmbase-val",
+							0x00000b01);
+		plat->pcicnt_reg =
+			dev_read_u32_default(dev, "intel,pcicnt-reg", 0x44);
+		plat->pcicnt_val =
+			dev_read_u32_default(dev, "intel,pcicnt-val", 0x80);
+		plat->pm1_cnt_port =
+			dev_read_u32_default(dev, "intel,pm1-cnt-port", 0x0b04);
+	} else {
+		plat->pmbase_reg =
+			dev_read_u32_default(dev, "intel,pmbase-reg", 0x40);
+		plat->pmbase_val = dev_read_u32_default(dev, "intel,pmbase-val",
+							0x00000601);
+		plat->pcicnt_reg =
+			dev_read_u32_default(dev, "intel,pcicnt-reg", 0x80);
+		plat->pcicnt_val =
+			dev_read_u32_default(dev, "intel,pcicnt-val", 0x01);
+		plat->pm1_cnt_port =
+			dev_read_u32_default(dev, "intel,pm1-cnt-port", 0x0604);
+	}
+
+	return 0;
+}
+
+static struct sysreset_ops qemu_x86_sysreset_ops = {
+	.request = qemu_x86_sysreset_request,
+};
+
+static const struct udevice_id qemu_x86_sysreset_ids[] = {
+	{ .compatible = "u-boot,i440fx-sysreset", .data = CHIPSET_I440FX },
+	{ .compatible = "u-boot,q35-sysreset", .data = CHIPSET_Q35 },
+	{}
+};
+
+U_BOOT_DRIVER(qemu_x86_sysreset) = {
+	.name = "qemu_x86_sysreset",
+	.id = UCLASS_SYSRESET,
+	.of_match = qemu_x86_sysreset_ids,
+	.of_to_plat = qemu_x86_sysreset_of_to_plat,
+	.ops = &qemu_x86_sysreset_ops,
+	.plat_auto = sizeof(struct qemu_x86_sysreset_plat),
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.53.0

