Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54198C531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD59640A0F;
	Thu, 23 Jul 2026 15:14:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zHdLC1PaeQIb; Thu, 23 Jul 2026 15:14:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D225D409C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819639;
	bh=Q2KW6IK91xNw1sdjKAcRZAgeeKGNV+/6pAt63TBJ6yE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1BwMvl7HC87C1SFUv7nFSi0HSFWzx1SPw5WiMbJAyqBW7sfE6+ipkOEdYRLOggCDz
	 kfRadm9EHXpZatxjGnIiCEcxs+DPAel1KYcy5ct58sTTBWFmcGCiab1edkoaBa/+fo
	 Dg+LefZN98tcMnHgFNggctRpzNxhuhJgHwmtVEqkH004GHNvWUvanWGXLm34ziopf5
	 cf64NsOf3L+I+MEXNdOT07O4Gyg0pEMxr9wFj43OFUeyykHLT3x00O4OlEGupt1pJj
	 SDZ1dFZRANthT22XMvGR/m6oZR51zOE04RUbUCYduKc6D46xRyzFlSBNVVvUIWJIEs
	 /Ft3u//eeIHjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D225D409C7;
	Thu, 23 Jul 2026 15:13:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A7BA8786
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98A06403EC
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UTnE5CeZZavE for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 13:30:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=tan.siewert@9elements.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 16E80403E4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16E80403E4
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16E80403E4
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:35 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4956242332dso5791355e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784813434; x=1785418234;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q2KW6IK91xNw1sdjKAcRZAgeeKGNV+/6pAt63TBJ6yE=;
 b=UqsjD2Ykby1dfa9cb8pkKLlZOKoOERcITOwc8aUOfaM/VFS8oYuHdVQJeFbQiEQUkD
 TnDFQhr5D34/49nXaFyt06fDjooSh9FyGFNjzcFIqi83BQ8KebNxj1Vu/iB2kus7ok6A
 VflR9Bq1QeIr2oODKLR69OsqRrQSpXXOANIvumqioL/GCrSRSzBM2v8JoWkh84Uma3Xc
 nxL0cJn3o3j02VayCvhRlaV+uOjBMrkwrcqGnn69S7VcY8lT+bJSgefss19Jf+YjffT/
 t432rJD57Frml9AuLOnKuAE1DJTpzaPJeytdlF522Nqxw8GcshcLAhHM1Uor0VuH88E/
 ONWw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpvk6CD8wxaHdOc91rfrFuWctIw3BsWaE3S2Tyb7fEe7oiPVivFpm6qAKXKqlGuF5XwXRmpedM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw6sMwav8jzxERD3h85SmX8UOIz9BKGpZuTDCSfLXYKSZy+666+
 bsYVbs1vzjvrr0PmXOIwWQGPTUZeeTl60yYKrNQuLrgifoBZ3cMDQbmb81iXTcoGptU=
X-Gm-Gg: AR+sD1397QV13x18uyEzdyU6HgT2QoCGEGFyn7hT8D8mdjkS143EH6+xNNtf+vK1EgE
 70a2gVMlMrfJ/Xoarqy6VJcNUPZG58NklGE5FfwStzx6ZKUUEkSr8TtsVyCDcFHSeBvhX7fv56T
 YQsityfN1jHuINhRNYsRF8vZs05FAZEqtOHOqcmBtgEHdFALnxbDxr3CJB79X22/u3xw/QBt1Uc
 BwqVAftwBlLbSSlSPUA/m4ZFhRwX7FMl4ZkRlNv0ZnR7q1H8hW3Nr7mUHbiXOYRyd/Xreccfh5a
 TFtsN7GUQjFgJcvcqv/ud0CWaycFF51AM01/52/hegZOnM/FyyFCf08FoRDrdcGfz7PgkE7dHbV
 YVC4eHdb+O4T4SjSqQwDaPKqYNe87FtF2iUwRNZEAltEk41Gr0lq9/LsKfIf5u4uKeofSOKboru
 KhH0j4GltQRaGIVg==
X-Received: by 2002:a05:600c:3b0e:b0:495:78af:78e5 with SMTP id
 5b1f17b1804b1-49578af7abemr8649175e9.1.1784813433659; 
 Thu, 23 Jul 2026 06:30:33 -0700 (PDT)
Received: from [10.12.249.172] ([2a01:599:841:3b94:b6c8:2fa:40db:8ecf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b043727sm97075405e9.4.2026.07.23.06.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 06:30:33 -0700 (PDT)
From: Tan Siewert <tan.siewert@9elements.com>
Date: Thu, 23 Jul 2026 15:30:03 +0200
Subject: [PATCH 2/8] misc: add HPE GXP EEPROM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-9e-gxp-v1-2-f86e5cea239f@9elements.com>
References: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
In-Reply-To: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
To: u-boot@lists.denx.de, Jean-Marie Verdun <verdun@hpe.com>, 
 Nick Hawkins <nick.hawkins@hpe.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Tan Siewert <tan.siewert@9elements.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784813429; l=4771;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=hk31pY3i50JFv1QaXK3ttNzesEgqPjplI6N9DGuj/Cw=;
 b=9ON6RnL6WkZbHRSzTty8sEStI2Xt2ikHfQPSMmWzicGRRe3ftXOfHrhpqq7rH+p0QWKjm8TQo
 0Hs0M1lPtO4BFdR4TVzo9Pap7qA3k0R+g436WjqrO8diB9hDsI2bl6O
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
X-Mailman-Approved-At: Thu, 23 Jul 2026 15:13:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1784813434; x=1785418234;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q2KW6IK91xNw1sdjKAcRZAgeeKGNV+/6pAt63TBJ6yE=;
 b=YMzdBD6sBDAAwCcKhezX9HY4JJDOa+BlaYUkZmTq3osAzKDVH1eD6ktzP8UEitOsoz
 gb0C8TwImWBIQheqTCn6o6upafEpOskFfpDmgc/fujUXgboP2fiJOfM+vnMHcD/0O7ZE
 ka9iLcCkHwEyUTs49d12pJo0xRlyo8H05jzb3wKf9Fbz/6XCvzXimCcX7g0dWr7pH0fx
 h9k2hN2+TEBdJo22ax5sVcuHM178Z49zdYnyhdFTNgm5RbKzgP7fcOR9CyfKNNvG5xdv
 d+UK7Y1UvdwreBhu+q9qjx9A9C1XmUaojXpdIadyNpF4CObRR1TbQ7sn1nx7js9s6mrv
 ZGbQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=YMzdBD6s
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>

Add driver providing access to the memory-mapped system information
area on HPE GXP BMC SoCs. The 256-byte region at 0xa0017f00 contains
board data organized in two 128-byte blocks, each protected by a
16-bit checksum.

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: Tan Siewert <tan.siewert@9elements.com>
---
 MAINTAINERS               |   1 +
 drivers/misc/Kconfig      |   9 ++++
 drivers/misc/Makefile     |   1 +
 drivers/misc/gxp_eeprom.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ecbb50e03a..81ebed7e865 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -344,6 +344,7 @@ F:	arch/arm/mach-hpe/
 F:	board/hpe/
 F:	configs/gxp_defconfig
 F:	doc/device-tree-bindings/spi/hpe,gxp-spi.yaml
+F:	drivers/misc/gxp_eeprom.c
 F:	drivers/timer/gxp-timer.c
 F:	drivers/spi/gxp_spi.c
 
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 44415f24ae1..5f22bcb330e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -83,6 +83,15 @@ config GATEWORKS_SC
 	  boards to provide a boot watchdog, power control, temperature monitor,
 	  voltage ADCs, and EEPROM.
 
+config GXP_EEPROM
+	bool "HPE GXP EEPROM driver"
+	depends on MISC
+	select NVMEM
+	help
+	  Enable access to the memory-mapped system information area
+	  on HPE GXP BMC SoCs. This region contains board data such as
+	  MAC addresses, serial number, and part number.
+
 config QCOM_GENI
 	bool "Qualcomm Generic Interface (GENI) driver"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..9ddbe9cd114 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_FSL_IIM) += fsl_iim.o
 obj-$(CONFIG_FSL_SEC_MON) += fsl_sec_mon.o
 obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
 obj-$(CONFIG_GATEWORKS_SC) += gsc.o
+obj-$(CONFIG_GXP_EEPROM) += gxp_eeprom.o
 obj-$(CONFIG_GDSYS_IOEP) += gdsys_ioep.o
 obj-$(CONFIG_GDSYS_RXAUI_CTRL) += gdsys_rxaui_ctrl.o
 obj-$(CONFIG_GDSYS_SOC) += gdsys_soc.o
diff --git a/drivers/misc/gxp_eeprom.c b/drivers/misc/gxp_eeprom.c
new file mode 100644
index 00000000000..0d8c7ede6e4
--- /dev/null
+++ b/drivers/misc/gxp_eeprom.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * HPE GXP EEPROM driver
+ *
+ * Copyright (C) 2026 9elements GmbH
+ */
+
+#include <dm.h>
+#include <misc.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+
+#define GXP_EEPROM_BLOCK_SIZE		128
+
+struct gxp_eeprom_priv {
+	void __iomem *base;
+	size_t size;
+};
+
+static bool gxp_eeprom_validate_checksum(void __iomem *block)
+{
+	u8 version;
+	u16 sum = 0;
+	int i;
+
+	version = readb(block);
+	if (version != 2 && version != 3)
+		return false;
+
+	for (i = 0; i < GXP_EEPROM_BLOCK_SIZE / sizeof(u16); i++)
+		sum += readw(block + i * sizeof(u16));
+
+	return sum == 0;
+}
+
+static int gxp_eeprom_read(struct udevice *dev, int offset, void *buf,
+			   int size)
+{
+	struct gxp_eeprom_priv *priv = dev_get_priv(dev);
+	u8 *dst = buf;
+	int i;
+
+	if (offset < 0 || size <= 0 || offset + size > priv->size)
+		return -EINVAL;
+
+	for (i = 0; i < size; i++)
+		dst[i] = readb(priv->base + offset + i);
+
+	return size;
+}
+
+static int gxp_eeprom_probe(struct udevice *dev)
+{
+	struct gxp_eeprom_priv *priv = dev_get_priv(dev);
+	fdt_addr_t addr;
+	fdt_size_t size;
+	int i, num_blocks;
+
+	addr = dev_read_addr_size(dev, &size);
+	if (addr == FDT_ADDR_T_NONE) {
+		dev_err(dev, "failed to get address\n");
+		return -EINVAL;
+	}
+
+	if (size == 0 || size % GXP_EEPROM_BLOCK_SIZE != 0) {
+		dev_err(dev, "size must be a multiple of %d bytes\n",
+			GXP_EEPROM_BLOCK_SIZE);
+		return -EINVAL;
+	}
+
+	priv->base = map_physmem(addr, size, MAP_NOCACHE);
+	if (!priv->base) {
+		dev_err(dev, "failed to map memory\n");
+		return -ENOMEM;
+	}
+	priv->size = size;
+
+	num_blocks = size / GXP_EEPROM_BLOCK_SIZE;
+	for (i = 0; i < num_blocks; i++) {
+		if (!gxp_eeprom_validate_checksum(priv->base +
+					       i * GXP_EEPROM_BLOCK_SIZE)) {
+			dev_err(dev, "checksum failed for block %d\n", i);
+			return -EBADMSG;
+		}
+	}
+
+	return 0;
+}
+
+static const struct misc_ops gxp_eeprom_ops = {
+	.read = gxp_eeprom_read,
+};
+
+static const struct udevice_id gxp_eeprom_ids[] = {
+	{ .compatible = "hpe,gxp-eeprom" },
+	{ }
+};
+
+U_BOOT_DRIVER(gxp_eeprom) = {
+	.name		= "gxp_eeprom",
+	.id		= UCLASS_MISC,
+	.of_match	= gxp_eeprom_ids,
+	.probe		= gxp_eeprom_probe,
+	.ops		= &gxp_eeprom_ops,
+	.priv_auto	= sizeof(struct gxp_eeprom_priv),
+	.flags		= DM_FLAG_PRE_RELOC,
+};

-- 
2.53.0

