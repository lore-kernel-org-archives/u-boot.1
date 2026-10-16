Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186AACCF2C0
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 17:50:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE7F040AFC;
	Fri, 16 Oct 2026 17:50:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9IGBzs64WHiC; Fri, 16 Oct 2026 17:50:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 830B240ADB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792173004;
	b=rhrt2dPI9w9WgVaS6OvQjufwXCbcvYKBwfyRT2aYTIdDceNDnceSCWq8ZaIKaLdamXDt
	 inQgGAvCCTAq3a4lEaVUHOuBuI07JmT4XcI4LmaBn9EbitOCTOUvtFLZ2WK4HarSgWgeE
	 Y3cPW1MC+WT/zV/KjihxAfxvtKEdw7tLqr/CSQjWsehvDg56GSwe4j70EMtiPP8mRAR5O
	 a841rb8Bu27vOCAu+bBxKM9EAVlCk5JkP1ksEcRKS8+LBkbOG6W8oV+pkf8VPaNIpUv5t
	 R8f+40N4a14CgFqk9KhyFVfpeMfq7Gh8gaqToJfpuxfWgpmsdyV+JRTacnLf2oSqB1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792173004;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gUoId1AKiMdr+x9Qym5ch10gmtrPTcq7NXWdK0JCq+E=;
	b=UtrKdgQZLXxNBOlTDMMhZRgJ2cFdhHgickt+JMmoeqPuLOHxF5zxEmhtaBZnUsL9qE9A
	 eCnCNxawzWKaj9im3KQBAbDVSncj+QWDvwQElKG03JM+dAtH4JgCIVU3PE7fRXqlz0Xzm
	 UclWkPDRw6CsRbEEAjKHscY3QTew3eGMKq5k2/YOmD4/3S+JKHEr5LI2ccgWGASetwhld
	 aOVOEBNJ3aqnNEPcH3LbY3nSkIYe7bmqp29Nhywd2mOgcQkvySn3tJWrB+WYYZQiCrUmo
	 cVN5Q4zzLkvKz+sWYGSY5ehZ20+TfhZYOESwfBJXjbHdZUlX+NUuKSafsCOBrFwCMnQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792173004;
	bh=gUoId1AKiMdr+x9Qym5ch10gmtrPTcq7NXWdK0JCq+E=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PpG+LXQOMKWkH8mJP0z+vQ877warBej45nV81SV81htb6H7ogdh55dWn051sWUD1f
	 D/3WhwnPW0D1TrbywTqyMuE8Lm9M4JOAvIKxrpnknBC5UolKKiR9UVcBR7joUCqXYQ
	 M7JXRdbtZva81wqiEuzy8paDhyJ98YXmNk0/Nw/F901LDHatWDoSDEIyJObXFyT358
	 939i28+w7PAh7OlHlrF3HVEie2AB0NqEhN0oMnrK+0G3Xi3ZkORX6uLgctwJ18srOq
	 7dqC0efKnd1uA83mNrR3N0Tg1CqRs69cjd6gVXFMUfy7XM7Hb6VOmlvWwc33/cI5+x
	 Dr6NzQZAaLkiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 830B240ADB;
	Fri, 16 Oct 2026 17:50:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BBBB77AD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6833814A0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:49:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MOdA78Xw2dPU for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 17:49:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6FADA81218
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792172988;
 b=h59zuvKn3V49TwN2SWNWy5lYAkZWe2inaUlRwvfPD7DNgyV6cP3TZ1Y2BvV/Gz9X4byL
 fns/BC44pgZJ7DW31dmiAqq1gsqS/ZadMuN6o02cMty1qKu6o+DeNnDKTR+CJXkVPECrk
 patWix0YDjV2euBvak4dwuo8p2MM5JoTn7e/C44cH5fZIAWfUhaldCwI4jqO59TbYls+p
 9PSBz0AWeqBqrqCxojP4w2QCyOSbJy+3LV64X+8pEsUg+lvFp3ejnp/O+BYts6Im3GRbc
 2OLbw4PVVrAwUpF1qcF0GIU5qSGr/NiYLKcrPjMMHfqfSvSoz1f8tXS89ViFV9+xhGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792172988;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
 bh=gUoId1AKiMdr+x9Qym5ch10gmtrPTcq7NXWdK0JCq+E=;
 b=Io83r0MLZAnq51MMZUh2g+amTd7eQjCTvV1MUfAY/yhkUtGtYcCnlksdxTFmbDQ6O11M
 vEyW1vHgwnjOPnDIAQZr5+sAgsHIIKTUVTYo65yTx7zDz5NO6kadd0E7qFMSUQxZS2aQn
 osrpjfzY5Jr62unq9DrBLNTorYQN42+7ZSCnZBSmlfCnDs9tTKmLIHa1IXw4FqmMbGflF
 UI9BltZkttexghm3vKAdtzX45AB1jvNkcwamsrD6KDFZxbvU6J8bwoP69sOgZbvEYpoIq
 lAhMZ0NHre/ybYjGF5VCsfkBUvTFhUkvhxo45H/lYx/pJeJjdZvcDAgup1dbMDPlBCw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=B1Kdn1tT; 
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=742e5c17b=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=B1Kdn1tT
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FADA81218
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1792172988; x=1823708988;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:to:cc;
 bh=A5T0nUVatHrbfuYD+Op80/wH2PQFrq7bkMUQE8XCzRM=;
 b=B1Kdn1tTc+4opdlDK0v9eOhdRs7k1ik2RKTAUGo8SsXhveW0zpUCYwlG
 c4TMTQ+PKOn3UqvsZ7OrIjyLs6E143irTqbk4HQPkCxSbXNzeEqgZ8zIm
 Aaf8pHteZW2IV+fAB7orehciwSwf83Nbtoa8Rq45Ht1qMQypOVCQHBZeF
 nlcLdW0jWn2IJDjo9L3523XwDviPSZuyw3IVKp7agpMjzjXzymhtfYvIx
 +PgepI+TYP7TRuF7dqi28kd9d82DyyhZ6BVnmqVbWZEew3g9In7OL++gp
 dHvfm+YtBrJV5zVcm1Nd9WHuJQS/lfa9Htzsqv+ZSHqWgyih5GSCgq+nT w==;
X-CSE-ConnectionGUID: cnk9xSrkRFqZ+llq90NsCw==
X-CSE-MsgGUID: a7978BUqSJy/5gdNwvU+5Q==
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; d="scan'208";a="75561802"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Oct 2026 10:49:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 16 Oct 2026 10:49:45 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Oct 2026 10:49:44 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Fri, 16 Oct 2026 10:49:37 -0700
Subject: [PATCH] net: mdio-pic64hpsc.c: add a driver for PIC64-HPSC/HX MDIO
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261016-mdio-pic64hpsc-v1-1-80210f255d18@microchip.com>
X-B4-Tracking: v=1; b=H4sIALBj0moC/x3MQQqAIBBA0avIrBNURKKrRAvTMWeRikIE4t2Tl
 m/xf4eGlbDBxjpUfKhRThNyYeCiTRdy8tOghDJSSMNvT5kXckbH0hwPQSu0Ep1YT5hRqRjo/Yf
 7McYH021eM2AAAAA=
X-Change-ID: 20261016-mdio-pic64hpsc-ff42ea1ec08b
To: <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Quentin Schulz <quentin.schulz@cherry.de>, "Peter
 Robinson" <pbrobinson@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 Johan Jonker <jbx6244@gmail.com>, James Hilliard <james.hilliard1@gmail.com>, 
 Charles Perry <charles.perry@microchip.com>
X-Mailer: b4 0.14.3
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

This adds an MDIO driver for PIC64-HPSC/HX. The hardware supports C22
and C45 but only C22 is implemented in this commit.

This MDIO hardware is based on a Microsemi design supported in U-Boot by
mdio-mscc-miim.c. However, The register interface is completely
different with pic64hpsc, hence the need for a separate driver.

The documentation recommends an input clock of 156.25MHz and a prescaler
of 39, which yields an MDIO clock of 1.95MHz.

The hardware supports an interrupt pin or a "TRIGGER" bit that can be
polled to signal transaction completion. This commit uses polling.

This was tested on Microchip HB1301 evalkit with a VSC8574 and a
VSC8541.

A Linux driver is also available for this hardware. See these links:
https://elixir.bootlin.com/linux/v7.2.10/source/drivers/net/mdio/mdio-pic64hpsc.c
https://patch.msgid.link/20260408131821.1145334-3-charles.perry@microchip.com

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/net/Kconfig          |   8 ++
 drivers/net/Makefile         |   1 +
 drivers/net/mdio-pic64hpsc.c | 178 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 797c8c24d5d4..50d3834d2ba1 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1108,6 +1108,14 @@ config MDIO_MSCC_MIIM
 	  This driver supports MDIO interface found in Microsemi and Microchip
 	  network switches.
 
+config MDIO_PIC64HPSC
+	bool "PIC64-HPSC/HX MDIO interface support"
+	depends on DM_MDIO
+	select CLK
+	help
+	  This driver supports the MDIO interface found on the PIC64-HPSC/HX
+	  SoCs.
+
 config MDIO_MUX_MMIOREG
 	bool "MDIO MUX accessed as a MMIO register access"
 	depends on DM_MDIO_MUX
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 6a351018a880..dd643b9c4c7b 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_MCFFEC) += mcffec.o mcfmii.o
 obj-$(CONFIG_MDIO_GPIO_BITBANG) += mdio_gpio.o
 obj-$(CONFIG_MDIO_IPQ4019) += mdio-ipq4019.o
 obj-$(CONFIG_MDIO_MSCC_MIIM) += mdio-mscc-miim.o
+obj-$(CONFIG_MDIO_PIC64HPSC) += mdio-pic64hpsc.o
 obj-$(CONFIG_MDIO_MT7531_MMIO) += mdio-mt7531-mmio.o
 obj-$(CONFIG_MDIO_MUX_I2CREG) += mdio_mux_i2creg.o
 obj-$(CONFIG_MDIO_MUX_MESON_G12A) += mdio_mux_meson_g12a.o
diff --git a/drivers/net/mdio-pic64hpsc.c b/drivers/net/mdio-pic64hpsc.c
new file mode 100644
index 000000000000..4bb34bf96492
--- /dev/null
+++ b/drivers/net/mdio-pic64hpsc.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2026 Microchip
+ */
+
+#include <clk.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/kernel.h>
+#include <miiphy.h>
+#include <wait_bit.h>
+
+#define P64H_MDIO_REG_PRESCALER 0x20
+#define P64H_MDIO_CFG_PRESCALE_MASK GENMASK(7, 0)
+
+#define P64H_MDIO_REG_FRAME_CFG_1 0x24
+#define P64H_MDIO_WDATA_MASK GENMASK(15, 0)
+
+#define P64H_MDIO_REG_FRAME_CFG_2 0x28
+#define P64H_MDIO_TRIGGER_BIT BIT(31)
+#define P64H_MDIO_REG_DEV_ADDR_MASK GENMASK(20, 16)
+#define P64H_MDIO_PHY_PRT_ADDR_MASK GENMASK(8, 4)
+#define P64H_MDIO_OPERATION_MASK GENMASK(3, 2)
+#define P64H_MDIO_START_OF_FRAME_MASK GENMASK(1, 0)
+
+#define P64H_MDIO_OPERATION_WRITE BIT(0)
+#define P64H_MDIO_OPERATION_READ BIT(1)
+
+#define P64H_MDIO_REG_FRAME_STATUS 0x2C
+#define P64H_MDIO_READOK_BIT BIT(24)
+#define P64H_MDIO_RDATA_MASK GENMASK(15, 0)
+
+struct pic64hpsc_mdio_priv {
+	void *regs_base;
+};
+
+static int pic64hpsc_mdio_wait_trigger(struct udevice *dev)
+{
+	struct pic64hpsc_mdio_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = wait_for_bit_le32(priv->regs_base + P64H_MDIO_REG_FRAME_CFG_2,
+				P64H_MDIO_TRIGGER_BIT, false, 250, false);
+
+	if (ret < 0) {
+		dev_err(dev, "TRIGGER bit timeout: %x\n",
+			in_le32(priv->regs_base + P64H_MDIO_REG_FRAME_CFG_2));
+	}
+
+	return ret;
+}
+
+static int pic64hpsc_mdio_read(struct udevice *dev, int addr, int devad,
+			       int reg)
+{
+	struct pic64hpsc_mdio_priv *priv = dev_get_priv(dev);
+	u32 val;
+	int ret;
+
+	if (devad != MDIO_DEVAD_NONE)
+		return -EOPNOTSUPP;
+
+	ret = pic64hpsc_mdio_wait_trigger(dev);
+	if (ret)
+		return ret;
+
+	out_le32(priv->regs_base + P64H_MDIO_REG_FRAME_CFG_2,
+		 P64H_MDIO_TRIGGER_BIT |
+			 FIELD_PREP(P64H_MDIO_REG_DEV_ADDR_MASK, reg) |
+			 FIELD_PREP(P64H_MDIO_PHY_PRT_ADDR_MASK, addr) |
+			 FIELD_PREP(P64H_MDIO_OPERATION_MASK,
+				    P64H_MDIO_OPERATION_READ) |
+			 FIELD_PREP(P64H_MDIO_START_OF_FRAME_MASK, 1));
+
+	ret = pic64hpsc_mdio_wait_trigger(dev);
+	if (ret)
+		return ret;
+
+	val = in_le32(priv->regs_base + P64H_MDIO_REG_FRAME_STATUS);
+
+	if (!FIELD_GET(P64H_MDIO_READOK_BIT, val))
+		return -ENODEV;
+
+	return FIELD_GET(P64H_MDIO_RDATA_MASK, val);
+}
+
+static int pic64hpsc_mdio_write(struct udevice *dev, int addr, int devad,
+				int reg, u16 val)
+{
+	struct pic64hpsc_mdio_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (devad != MDIO_DEVAD_NONE)
+		return -EOPNOTSUPP;
+
+	ret = pic64hpsc_mdio_wait_trigger(dev);
+	if (ret < 0)
+		return ret;
+
+	out_le32(priv->regs_base + P64H_MDIO_REG_FRAME_CFG_1,
+		 FIELD_PREP(P64H_MDIO_WDATA_MASK, val));
+
+	out_le32(priv->regs_base + P64H_MDIO_REG_FRAME_CFG_2,
+		 P64H_MDIO_TRIGGER_BIT |
+			 FIELD_PREP(P64H_MDIO_REG_DEV_ADDR_MASK, reg) |
+			 FIELD_PREP(P64H_MDIO_PHY_PRT_ADDR_MASK, addr) |
+			 FIELD_PREP(P64H_MDIO_OPERATION_MASK,
+				    P64H_MDIO_OPERATION_WRITE) |
+			 FIELD_PREP(P64H_MDIO_START_OF_FRAME_MASK, 1));
+
+	return 0;
+}
+
+static const struct mdio_ops pic64hpsc_mdio_ops = {
+	.read = pic64hpsc_mdio_read,
+	.write = pic64hpsc_mdio_write,
+};
+
+static int pic64hpsc_mdio_probe(struct udevice *dev)
+{
+	struct pic64hpsc_mdio_priv *priv = dev_get_priv(dev);
+	u32 div, bus_freq;
+	ulong clk_rate;
+	struct clk clk;
+	int ret;
+
+	priv->regs_base = dev_read_addr_ptr(dev);
+	if (!priv->regs_base)
+		return -ENODEV;
+
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (ret) {
+		dev_err(dev, "Missing clock\n");
+		return ret;
+	}
+
+	ret = clk_enable(&clk);
+	if (ret) {
+		dev_err(dev, "Cannot enable clock\n");
+		return ret;
+	}
+
+	clk_rate = clk_get_rate(&clk);
+	if (!clk_rate) {
+		dev_err(dev, "Cannot get clock rate\n");
+		return -EINVAL;
+	}
+
+	bus_freq = ofnode_read_u32_default(dev_ofnode(dev), "clock-frequency",
+					   2500000);
+
+	div = DIV_ROUND_UP(clk_rate, 2 * bus_freq) - 1;
+	if (div == 0 || div & ~P64H_MDIO_CFG_PRESCALE_MASK) {
+		dev_err(dev, "MDIO clock-frequency out of range\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "rate=%lu bus_freq=%u real_bus_freq=%lu div=%u\n",
+		clk_rate, bus_freq, clk_rate / (2 * (1 + div)), div);
+	out_le32(priv->regs_base + P64H_MDIO_REG_PRESCALER, div);
+
+	return 0;
+}
+
+static const struct udevice_id pic64hpsc_mdio_of_ids[] = {
+	{ .compatible = "microchip,pic64hpsc-mdio" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(pic64hpsc_mdio) = {
+	.name = "pic64hpsc_mdio",
+	.id = UCLASS_MDIO,
+	.of_match = pic64hpsc_mdio_of_ids,
+	.probe = pic64hpsc_mdio_probe,
+	.ops = &pic64hpsc_mdio_ops,
+	.priv_auto = sizeof(struct pic64hpsc_mdio_priv),
+};

---
base-commit: 65a7532545336e4b73e049a69436e255da7df961
change-id: 20261016-mdio-pic64hpsc-ff42ea1ec08b

Best regards,
-- 
Thanks,
Charles

