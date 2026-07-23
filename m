Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF29C531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCF4560A41;
	Thu, 23 Jul 2026 15:14:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5nK7tvHKw0cR; Thu, 23 Jul 2026 15:14:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E94D860A5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819641;
	bh=FYT3vXcbbIjCWk3tEydG+BkJEyrnRJpytkA/K0XEZOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MXLf7/Qs8R7m233U8BrPSXOqjeqDea5f+Py0YHi7pSh/GI7HRvETKqLUn+04dclKe
	 boJefHgFwAxwzTh4zsl+x469y6DFQLMN4R6AOYGH5DCBUrWU8E6+2fuqmOcHh1DiM3
	 raIMITB7NnsSyHsDhtrvxqztuzWABtxFW4PFvXmk/85akfxBwJssX7L8JFCVYnKYIY
	 qwqPUfj5UNfZPjtGE+X0Civ5bUAWAQnY+nuwb4MpqJVuLkpUHj2h8DUQzREoQU7W5g
	 QmmUDBh937v0hxuaSm+a6aKm3Bc4k3TMKKdTchOBG3BD8NWUe6qS0vreb8Vbw490Yk
	 oskGXW4Lf3wBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E94D860A5A;
	Thu, 23 Jul 2026 15:14:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E64593B1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D78D6403E4
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EawDgbo-s0B7 for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 13:30:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=tan.siewert@9elements.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A7BF2403E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7BF2403E9
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7BF2403E9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:37 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso196507f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784813435; x=1785418235;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FYT3vXcbbIjCWk3tEydG+BkJEyrnRJpytkA/K0XEZOg=;
 b=e8hmPK2TaosCF0TmS1PVxzSsmvK4S013ai7N++eZx9QznL6noIboIr6C/5HITcd0NZ
 itQsLhxdVCh9hy4t4nfQARgPabVhpRctNLS68Vtvl+auiNLe8rHYD+Py67mEHKFZgLE6
 9Kmx65oJvkIej8U7+wKZPw9Zr+1m9UajOig2g2Jok4J+k39dsGahUqHgSsOEyO6uhQ7a
 6XhxSmahfy7+DaYlJ6Kuz3A6E9MkUYAQ+Kuf1N4caOwGTDFIHJtpCUCflij8YdoBoHpY
 yiRp+mGtGTHi68NoWzQc/PEhzZiKPxUspqdP5HlSqs0cpmar5A2ixc37bSlBAHVqohYn
 BKjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwEPDN+5d7KqR/KMgv0qD7iFNJX6G25qN/UCKsgHakZuNH2E+fOmGvWn4yQsrI8tqIK5Ntah8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyMWVebrM71rt7x/Yd2kkwK/7mv1ZcLcJJAAPNV5x0ng9+7E40d
 silsjuSAz4KrBHl61nUmp5QCU9H75NpkF/hFW5gxY/cEqbS+CuQmwOSM3EmcQCdOhyI=
X-Gm-Gg: AR+sD12kYQhE93CRIIdQFYkdCbsgxx8T2qmxY4Yn7Hekd8526cqkgFT0UyWm3h043cl
 qRe2UCpz2ip64lhs3gy2adIfJORh4Dx+PS0fBphNpTVDACdgrDwP1uXcbqnfGFOnssY2D8tJUdD
 eJLQb65EuFRzCtwtZt2jXJxruzvGVGa5qlv5ki4tyfhKNvR9AijbJKpCZJ9YMvsGPwM0uraELA0
 t4xhXTbBh4ZTeTV14sDQN6uJ3OfNOCoc0Z73WyYhpQIL9hwp4PhZCTDOeaMzmZctt2ve0NqdbyM
 ovH9k4+++sfAmmGRBbE2ExvAlgIPvVoQy0dkZL5DGQ9XvAKNzS2Uf0GQjF0Kityp/tMqC4nxxYD
 3dWUIfpyC5Ae+fumzLP9vMLFQoQdWdDtVyGofSErbNa0stB5IMW2hgilb9fRjhZ/hcXNR9TIIsX
 SOdBUgXHMfx0EEiA==
X-Received: by 2002:a05:600c:3111:b0:495:44f3:4576 with SMTP id
 5b1f17b1804b1-49573cc2b8bmr33675305e9.7.1784813435608; 
 Thu, 23 Jul 2026 06:30:35 -0700 (PDT)
Received: from [10.12.249.172] ([2a01:599:841:3b94:b6c8:2fa:40db:8ecf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b043727sm97075405e9.4.2026.07.23.06.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 06:30:35 -0700 (PDT)
From: Tan Siewert <tan.siewert@9elements.com>
Date: Thu, 23 Jul 2026 15:30:05 +0200
Subject: [PATCH 4/8] sysinfo: add HPE GXP sysinfo driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-9e-gxp-v1-4-f86e5cea239f@9elements.com>
References: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
In-Reply-To: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
To: u-boot@lists.denx.de, Jean-Marie Verdun <verdun@hpe.com>, 
 Nick Hawkins <nick.hawkins@hpe.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Tan Siewert <tan.siewert@9elements.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784813429; l=5333;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=AziD0eSsIYaIa0ogN1BD8X9JMdARqHlcPc35tVi4TGA=;
 b=+gxzN0e9j/BSWWkpK4CuKX/AJiV6UAArcri+mSECpx1UzsZW+Nb5uSNyZhsmGXgPnRfxjsDfu
 qprQDaj0js2CtSxa/b7+CKMKovJuV8wvRpCRtwuBBqewQ+hwhYa9SM7
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
X-Mailman-Approved-At: Thu, 23 Jul 2026 15:13:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1784813435; x=1785418235;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FYT3vXcbbIjCWk3tEydG+BkJEyrnRJpytkA/K0XEZOg=;
 b=dxID0p6pi4Vfnyr2xomBFTfQYC/JY2Cv1HYo9J0jOHHSktQ+gM3H5GVvJzZtfBxEf/
 i4Gawpmi5U2WBFenOtf779io49C+s4OAW7inuRwgGb6WUyaUnXhIGtvqW1E+wV03/lGw
 TxHR4dVkkssh+ZLJUhdXEHZtJbKvXeI8gC9I7+GCISuW9yfOBjXlXfLlOxLq6YrNjaPB
 sB/XISDEAqJ2OChRNwWhB/mcMQVNajtrVJSvikwSCMRdY4QGWv0nr6otAWWFk8tMVArp
 4j6du9foc2FDVuSQpvPcNVvKkAgyUPUfjo++hjGEXKdSbtQnPW/+ZbydvvTZCn3S6KGh
 CSkA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=dxID0p6p
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

Add sysinfo driver for HPE GXP BMC SoCs providing board information.
It reads serial and part numbers from nvmem cells defined in the device
tree.

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: Tan Siewert <tan.siewert@9elements.com>
---
 MAINTAINERS               |  2 +
 arch/arm/dts/hpe-gxp.dtsi |  7 ++++
 configs/gxp_defconfig     |  1 +
 drivers/sysinfo/Kconfig   |  8 ++++
 drivers/sysinfo/Makefile  |  1 +
 drivers/sysinfo/gxp.c     | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 118 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81ebed7e865..323c0777cd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -345,6 +345,8 @@ F:	board/hpe/
 F:	configs/gxp_defconfig
 F:	doc/device-tree-bindings/spi/hpe,gxp-spi.yaml
 F:	drivers/misc/gxp_eeprom.c
+F:	drivers/sysinfo/gxp.c
+F:	drivers/sysinfo/gxp.h
 F:	drivers/timer/gxp-timer.c
 F:	drivers/spi/gxp_spi.c
 
diff --git a/arch/arm/dts/hpe-gxp.dtsi b/arch/arm/dts/hpe-gxp.dtsi
index fa174bdc582..9c761a675be 100644
--- a/arch/arm/dts/hpe-gxp.dtsi
+++ b/arch/arm/dts/hpe-gxp.dtsi
@@ -10,6 +10,13 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	sysinfo {
+		compatible = "hpe,gxp-sysinfo";
+		nvmem-cells = <&serial_number>, <&part_number>;
+		nvmem-cell-names = "serial-number", "part-number";
+		bootph-all;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/configs/gxp_defconfig b/configs/gxp_defconfig
index 2369b4cd07d..5501f9aefae 100644
--- a/configs/gxp_defconfig
+++ b/configs/gxp_defconfig
@@ -27,6 +27,7 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run spiboot"
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_SYSINFO=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="gxp# "
 # CONFIG_BOOTM_PLAN9 is not set
diff --git a/drivers/sysinfo/Kconfig b/drivers/sysinfo/Kconfig
index 6922dac9170..00d924a9c15 100644
--- a/drivers/sysinfo/Kconfig
+++ b/drivers/sysinfo/Kconfig
@@ -67,4 +67,12 @@ config SYSINFO_TQ_EEPROM
 	  Support querying EEPROM of TQ-Systems SOMs to determine board
 	  information.
 
+config SYSINFO_GXP
+	bool "HPE GXP sysinfo driver"
+	depends on ARCH_GXP && GXP_EEPROM
+	default y if ARCH_GXP
+	help
+	  Support querying board information for HPE GXP BMC SoCs.
+	  Uses the GXP EEPROM driver to retrieve serial and part numbers.
+
 endif
diff --git a/drivers/sysinfo/Makefile b/drivers/sysinfo/Makefile
index d21fb3c2270..ebc239320e7 100644
--- a/drivers/sysinfo/Makefile
+++ b/drivers/sysinfo/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_SYSINFO_RCAR3) += rcar3.o
 obj-$(CONFIG_SYSINFO_SANDBOX) += sandbox.o
 obj-$(CONFIG_SYSINFO_SMBIOS) += smbios.o
 obj-$(CONFIG_SYSINFO_TQ_EEPROM) += tq_eeprom.o
+obj-$(CONFIG_SYSINFO_GXP) += gxp.o
diff --git a/drivers/sysinfo/gxp.c b/drivers/sysinfo/gxp.c
new file mode 100644
index 00000000000..a1f33be11df
--- /dev/null
+++ b/drivers/sysinfo/gxp.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * HPE GXP sysinfo driver
+ *
+ * Copyright (C) 2026 9elements GmbH
+ */
+
+#include <dm.h>
+#include <nvmem.h>
+#include <sysinfo.h>
+#include <dm/device_compat.h>
+
+#define GXP_SYSINFO_MODEL		"GXP"
+#define GXP_SYSINFO_MANUFACTURER	"Hewlett Packard Enterprise"
+
+/**
+ * struct gxp_sysinfo_priv - GXP sysinfo private data
+ * @serial_cell: NVMEM cell for serial number
+ * @part_cell: NVMEM cell for part number
+ */
+struct gxp_sysinfo_priv {
+	struct nvmem_cell serial_cell;
+	struct nvmem_cell part_cell;
+};
+
+static int gxp_sysinfo_detect(struct udevice *dev)
+{
+	return 0;
+}
+
+static int gxp_sysinfo_get_str(struct udevice *dev, int id, size_t size,
+			       char *val)
+{
+	struct gxp_sysinfo_priv *priv = dev_get_priv(dev);
+	struct nvmem_cell *cell;
+	int ret;
+
+	switch (id) {
+	case SYSID_BOARD_MODEL:
+		strlcpy(val, GXP_SYSINFO_MODEL, size);
+		return 0;
+	case SYSID_BOARD_MANUFACTURER:
+		strlcpy(val, GXP_SYSINFO_MANUFACTURER, size);
+		return 0;
+	case SYSID_SM_SYSTEM_SERIAL:
+		if (!priv->serial_cell.nvmem)
+			return -ENODEV;
+		cell = &priv->serial_cell;
+		break;
+	case SYSID_SM_BASEBOARD_PRODUCT:
+		if (!priv->part_cell.nvmem)
+			return -ENODEV;
+		cell = &priv->part_cell;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (size <= cell->size)
+		return -ENOSPC;
+
+	ret = nvmem_cell_read(cell, val, cell->size);
+	if (ret)
+		return ret;
+
+	val[cell->size] = '\0';
+
+	return 0;
+}
+
+static int gxp_sysinfo_probe(struct udevice *dev)
+{
+	struct gxp_sysinfo_priv *priv = dev_get_priv(dev);
+
+	nvmem_cell_get_by_name(dev, "serial-number", &priv->serial_cell);
+	nvmem_cell_get_by_name(dev, "part-number", &priv->part_cell);
+
+	return 0;
+}
+
+static const struct sysinfo_ops gxp_sysinfo_ops = {
+	.detect = gxp_sysinfo_detect,
+	.get_str = gxp_sysinfo_get_str,
+};
+
+static const struct udevice_id gxp_sysinfo_ids[] = {
+	{ .compatible = "hpe,gxp-sysinfo" },
+	{ }
+};
+
+U_BOOT_DRIVER(gxp_sysinfo) = {
+	.name		= "gxp_sysinfo",
+	.id		= UCLASS_SYSINFO,
+	.of_match	= gxp_sysinfo_ids,
+	.probe		= gxp_sysinfo_probe,
+	.ops		= &gxp_sysinfo_ops,
+	.priv_auto	= sizeof(struct gxp_sysinfo_priv),
+	.flags		= DM_FLAG_PRE_RELOC,
+};

-- 
2.53.0

