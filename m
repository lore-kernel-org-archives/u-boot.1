Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEBEC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71FE881011;
	Fri, 14 Aug 2026 18:30:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3o7qZGVWBHRz; Fri, 14 Aug 2026 18:30:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E538812E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732221;
	bh=AkynStZoyQZbd2QXyIROSJL4/W4lB48HcTQxkuMx+7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RLbvX+7RBB+B2eqURLLyyF6hQGc5GhVvHrYcJPtItC85GiVm/Eqn3F3LCZWZfOMHL
	 M2xFTGq/z8HZNTi+WuDMSAOUx8ktdNiEaSoULVBJnO01CIOHDUxFLPSy16aAaWCt+9
	 mN3+w3l+s/mS3h+4CKO2JC47YJ0KakRU5tjv05R3jnxdFAD4Op3Y9tl3y4aIlPzlVz
	 QghPlC+neJNRiZPWH6mXFcEpCEchnXOcDK5XKFMM1QdGLPUzlzBFPapH+lyryZWbt4
	 2JR38MnQ32tQZlAeV9O5l+HnMWUvZNGG2NmVSjUe1yq/XDyTj2r28iXxuCSfUYhnsF
	 l5Tz2M67hQf6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E538812E7;
	Fri, 14 Aug 2026 18:30:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A45DC3A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96C5060A39
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uo2caX23LJI5 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:30:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 70B91608FE
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70B91608FE
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=AM2n1CbN
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70B91608FE
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:18 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-936d00181abso59350185a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732217; x=1787337017;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AkynStZoyQZbd2QXyIROSJL4/W4lB48HcTQxkuMx+7Q=;
 b=AM2n1CbN0rSpbjWX1BuKQxDUzu25qraPFAIZrcqfuGJ9b5P5K71CsZMrcXLUYLhoCQ
 GX2v7KC+36qlEIH0O/gqLbzWa0aK/vMRtZWIAihQyEvKBvfcHKMMj6jdgzOjsJSgpn7C
 /tq6hlQzkyiAxBNJpPCxeRrCSpBed9HS+/yGZ5uGw+qmkhpOY14DOZG6+1nW3OD1dOcP
 vCrbnmA9hFOpuuwfqfbEbY4ulGEwH8NVQzi3j3XQyBPjJndJcEBUmq9/AQVHoTxy6WQQ
 RuH8CV/yWnQbKwETFjVCxkj8feDL++Pck3ERJt3goJ9SngPLWyYj6cQB/GFbKjoHuqKM
 HqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732217; x=1787337017;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AkynStZoyQZbd2QXyIROSJL4/W4lB48HcTQxkuMx+7Q=;
 b=CEIzKbFq0TRN8VlNG8cb7+4hKqnSsecFSKBNhWFUhHqfGM1RpxPo3ePr2SFLExcJnK
 vN6tQ5e0JQE33bz9SD78NYoCz//xBiJK1zwvWLL/Za48lC2/lPV5BSBJV8/uUw29TxvE
 WkX27PjXGtpS5lvuZzXjYZa/voOCbSBxpFeYtDpqwVBkGs4Y6zQF1yug557SOAHOBo3F
 VBL+7V4kYe3F5WQD1kQiZuLhCXzK2D1fiJVN5BfRHFNzoMJWCmABLMLal/k1hpGvwuvY
 euoTZLzk9RYXKdQH9iq2FOu2SDZ2ZrfjX963f4VaxTVt8AjgJN4m7f701k74QPyiT2Gn
 PADg==
X-Gm-Message-State: AOJu0YxM3GgIXEORD9jYgJ+JIlshBNUa/pGF16S8yRHcD2FcHIE8IQ9j
 t/dbV+eZkFRgKEdcsI0Av55h7PvU+Nw6sb5fJMK54DnQGGad4MwtnHPVaNOP2V4OvJI=
X-Gm-Gg: AR+sD13KFYcLzghFh8LM08soxylFmvVNeuR8wHI0YD940r/TbiTXWHEpMeAnL68mRMI
 HprvXyNnKN8NMvwXXapaDHxW04VN11qFH0hxJ4hCOcgH/D27vMQ0SIh2/VgywsPi1ZqpoD5NSaD
 GFGa/5p9DFLnZmfwyxGzjFYu4pgGaEDde1dl2cY9IpSd+E9IqwqNcypaCLtvbNGMxQstUT0QuLQ
 gZtS96oHRp5fQ+8ME+WYtHG1SPk/k5h3teKEsEm5lEOOV2rkvvaWs0tOFenbueGudEh1/TJeha3
 LuKsRdDBFwlFNFu/rw78Um8R+yd1rfztoSX5iyctBMM4Z2oI3s8qN57BERTiWKGpZuj37wYublv
 TTXI8xvA4EO3ld/kLdWr9oUiLlce+YIrC2Z/iMWwwF1Pyk4XgA32ux3Tvi3w+XsoVYaaLSGaQwa
 ka/uRt/Uj9t98SbLk8nWV4gfW7qN62n/9wmbZNgEHBwEZmMHhRoapf/JRh4wsFwJ/lbHwijKtaA
 u/uoEKDtKu4PycVrhoWQMZqabw9jDGvgVzaF4+z3NpCjbDWfBBqiGas
X-Received: by 2002:a05:620a:45a7:b0:930:a963:da77 with SMTP id
 af79cd13be357-936d22ea9b8mr831944785a.26.1786732216735; 
 Fri, 14 Aug 2026 11:30:16 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936ce24d0b5sm324606285a.45.2026.08.14.11.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:30:16 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:30:12 -0400
Subject: [PATCH v2 1/3] net: add r9a06g032 A5PSW switch driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260814-rzn1-2026-10-net-v2-1-ff03583dc2b0@linaro.org>
References: <20260814-rzn1-2026-10-net-v2-0-ff03583dc2b0@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-net-v2-0-ff03583dc2b0@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732214; l=12496;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=ra4NImMnvAp/aAB7TzzsfWKldzQuah7CGXgfH7TFXpQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBUgTNWM8mSVcR+Fhni397JPnqD1yLNSEoB70T8wNs84m21Zlwq/wr6C+YIuSHOT3Ka2Nl1Tum+
 DcwFVcn3i4g4=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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

Driver for the Advanced 5-port Ethernet switch (A5PSW) on RZ/N1 SoC.

The A5PSW switch is modeled using DSA framework, but without actually
tagging packets. The goal is just to support network booting over a
single Ethernet port.

This driver is loosely based on the Linux driver by Clément Léger
888cdb892b61 ("net: dsa: rzn1-a5psw: add Renesas RZ/N1 advanced 5 port
switch driver") but without any of the VLAN tagging or other features.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/net/Kconfig      |   6 +
 drivers/net/Makefile     |   1 +
 drivers/net/rzn1_a5psw.c | 377 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 384 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index faa08e9ebba..edc4cb29598 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -880,6 +880,12 @@ config RENESAS_RAVB
 	  This driver implements support for the Ethernet AVB block in
 	  several Renesas R-Car and RZ SoCs.
 
+config RZN1_A5PSW
+	bool "Renesas RZ/N1 A5PSW ethernet switch"
+	help
+	  Support the Advanced 5-Port ethernet switch (A5PSW) found in
+	  the Renesas RZ/N1 SoC.
+
 config MPC8XX_FEC
 	bool "Fast Ethernet Controller on MPC8XX"
 	depends on MPC8xx
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 4c1f4094ab2..b8f270ae233 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_PCNET) += pcnet.o
 obj-$(CONFIG_PIC32_ETH) += pic32_mdio.o pic32_eth.o
 obj-$(CONFIG_RENESAS_ETHER_SWITCH) += rswitch.o
 obj-$(CONFIG_RENESAS_RAVB) += ravb.o
+obj-$(CONFIG_RZN1_A5PSW) += rzn1_a5psw.o
 obj-$(CONFIG_RTL8139) += rtl8139.o
 obj-$(CONFIG_RTL8169) += rtl8169.o
 obj-$(CONFIG_SH_ETHER) += sh_eth.o
diff --git a/drivers/net/rzn1_a5psw.c b/drivers/net/rzn1_a5psw.c
new file mode 100644
index 00000000000..2733ebcdfbb
--- /dev/null
+++ b/drivers/net/rzn1_a5psw.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Adapted from Linux drivers/net/dsa/rzn1_a5psw.c
+ * but without DSA tag support.
+ */
+
+#include <clk.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <dm/of_extra.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <miiphy.h>
+#include <net/dsa.h>
+#include <syscon.h>
+#include <regmap.h>
+#include <reset.h>
+
+struct rzn1_a5psw_plat {
+	struct clk_bulk bulk;
+	struct regmap *regmap;
+	struct udevice *miic;
+	struct regmap *syscon;
+};
+
+/* MoreThanIP 5pt Switch regs */
+#define MT5PT_REVISION		0x0
+#define MT5PT_SCRATCH		0x4
+#define MT5PT_PORT_ENA		0x8
+#define  MT5PT_PORT_ENA_TX(x)		BIT(16 + (x))
+#define  MT5PT_PORT_ENA_RX(x)		BIT(x)
+#define  MT5PT_PORT_ENA_TXRX(x)		((MT5PT_PORT_ENA_TX(0) | MT5PT_PORT_ENA_RX(0)) << (x))
+#define MT5PT_AUTH_PORT(x)	(0x240 + (x) * 4)
+#define  MT5PT_AUTH_PORT_AUTHORIZED	BIT(0)
+#define  MT5PT_AUTH_PORT_CONTROLLED	BIT(1)
+#define  MT5PT_AUTH_PORT_EAPOL_EN	BIT(2)
+#define  MT5PT_AUTH_PORT_GUEST		BIT(3)
+#define  MT5PT_AUTH_PORT_EAPOL_PORT(x)	((x) << 12)
+#define MT5PT_MDIO_CFG_STATUS	0x700
+#define MT5PT_MDIO_COMMAND	0x704
+#define MT5PT_MDIO_DATA		0x708
+#define MT5PT_MAC_CMD_CFGn(x)	(0x808 + (x) * 0x400)
+#define  MT5PT_TX_ENA			BIT(0)
+#define  MT5PT_RX_ENA			BIT(1)
+#define  MT5PT_MBPS_1000		BIT(3)
+#define  MT5PT_HALF_DUPLEX		BIT(10)
+#define MT5PT_MAC_FRM_LENGTHn(x)	(0x814 + (x) * 0x400)
+#define MT5PT_DUMMY_NOOP	0x5000
+
+static void rzn1_switch_write(struct regmap *regmap, uint offset, uint val)
+{
+	/*
+	 * MTIP switch errata:
+	 * There is a clock-crossing issue within the switch,
+	 * which can cause writes to be corrupted.
+	 * To avoid the problem, perform a dummy write with the
+	 * same data value, prior to the actual write.
+	 */
+	regmap_write(regmap, MT5PT_DUMMY_NOOP, val);
+	regmap_write(regmap, offset, val);
+}
+
+static void rzn1_switch_port_speed_duplex(struct udevice *dev, int port, int speed, int duplex)
+{
+	struct rzn1_a5psw_plat *plat = dev_get_plat(dev);
+	struct regmap *regmap = plat->regmap;
+	u32 val;
+
+	regmap_read(regmap, MT5PT_MAC_CMD_CFGn(port), &val);
+	val &= ~(MT5PT_HALF_DUPLEX | MT5PT_MBPS_1000);
+	if (speed == SPEED_1000)
+		val |= MT5PT_MBPS_1000;
+	if (duplex == DUPLEX_HALF)
+		val |= MT5PT_HALF_DUPLEX;
+
+	rzn1_switch_write(regmap, MT5PT_MAC_CMD_CFGn(port), val);
+}
+
+static void rzn1_switch_port_enable(struct udevice *dev, int port)
+{
+	struct rzn1_a5psw_plat *plat = dev_get_plat(dev);
+	struct regmap *regmap = plat->regmap;
+	u32 val;
+
+	regmap_read(regmap, MT5PT_AUTH_PORT(port), &val);
+	val |= MT5PT_AUTH_PORT_AUTHORIZED;
+	rzn1_switch_write(regmap, MT5PT_AUTH_PORT(port), val);
+
+	regmap_read(regmap, MT5PT_PORT_ENA, &val);
+	val |= MT5PT_PORT_ENA_TXRX(port);
+	rzn1_switch_write(regmap, MT5PT_PORT_ENA, val);
+
+	/* Max frame size */
+	rzn1_switch_write(regmap, MT5PT_MAC_FRM_LENGTHn(port), 9224);
+}
+
+static void rzn1_switch_port_disable(struct udevice *dev, int port)
+{
+	struct rzn1_a5psw_plat *plat = dev_get_plat(dev);
+	struct regmap *regmap = plat->regmap;
+	u32 val;
+
+	regmap_read(regmap, MT5PT_AUTH_PORT(port), &val);
+	val &= ~MT5PT_AUTH_PORT_AUTHORIZED;
+	rzn1_switch_write(regmap, MT5PT_AUTH_PORT(port), val);
+
+	regmap_read(regmap, MT5PT_PORT_ENA, &val);
+	val &= ~MT5PT_PORT_ENA_TXRX(port);
+	rzn1_switch_write(regmap, MT5PT_PORT_ENA, val);
+}
+
+static int rzn1_phy_wait(struct udevice *dev)
+{
+	struct rzn1_a5psw_plat *plat = dev_get_plat(dev->parent);
+	struct regmap *regmap = plat->regmap;
+	u32 timeout = 100;
+	int ret;
+	u32 val;
+
+	do {
+		ret = regmap_read(regmap, MT5PT_MDIO_CFG_STATUS, &val);
+		if (ret == 0 && (val & BIT(0)) == 0)
+			return 0;
+
+		mdelay(1);
+	} while (--timeout);
+
+	return -ETIMEDOUT;
+}
+
+static int rzn1_a5psw_mdio_read(struct udevice *dev, int addr, int devad, int reg)
+{
+	struct rzn1_a5psw_plat *plat = dev_get_plat(dev->parent);
+	struct regmap *regmap = plat->regmap;
+	int ret;
+	u32 val = BIT(15) | ((addr & 0x1f) << 5) | (reg & 0x1f);
+
+	/* Clause 22 only */
+	rzn1_switch_write(regmap, MT5PT_MDIO_COMMAND, val);
+
+	ret = rzn1_phy_wait(dev);
+	if (ret) {
+		dev_warn(dev, "PHY read timeout\n");
+		return ret;
+	}
+
+	ret = regmap_read(regmap, MT5PT_MDIO_DATA, &val);
+	if (ret) {
+		dev_warn(dev, "PHY read error\n");
+		return ret;
+	}
+	val &= 0xffff;
+
+	// TODO: check CFG_STATUS for READERR
+
+	dev_dbg(dev, "addr=0x%x reg=0x%x read 0x%04x\n", addr, reg, val);
+
+	return val;
+}
+
+static int rzn1_a5psw_mdio_write(struct udevice *dev, int addr, int devad,
+				 int reg, u16 val)
+{
+	struct rzn1_a5psw_plat *plat = dev_get_plat(dev->parent);
+	struct regmap *regmap = plat->regmap;
+	int ret;
+	u32 cmd = ((addr & 0x1f) << 5) | (reg & 0x1f);
+
+	dev_dbg(dev, "addr=0x%x reg=0x%x write 0x%04x\n", addr, reg, val);
+
+	/* Clause 22 only */
+	rzn1_switch_write(regmap, MT5PT_MDIO_COMMAND, cmd);
+	rzn1_switch_write(regmap, MT5PT_MDIO_DATA, val);
+
+	ret = rzn1_phy_wait(dev);
+	if (ret) {
+		dev_warn(dev, "PHY write timeout\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct mdio_ops rzn1_a5psw_mdio_ops = {
+	.read = rzn1_a5psw_mdio_read,
+	.write = rzn1_a5psw_mdio_write,
+};
+
+static int rzn1_a5psw_mdio_bind(struct udevice *dev)
+{
+	char name[32];
+	static int num_devices;
+
+	sprintf(name, "rzn1-a5psw-mdio-%d", num_devices++);
+	device_set_name(dev, name);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(rzn1_a5psw_mdio) = {
+	.name		= "rzn1_a5psw_mdio",
+	.id		= UCLASS_MDIO,
+	.ops		= &rzn1_a5psw_mdio_ops,
+	.bind		= rzn1_a5psw_mdio_bind,
+	.plat_auto	= sizeof(struct mdio_perdev_priv),
+};
+
+static int rzn1_a5psw_port_probe(struct udevice *dev, int port, struct phy_device *phy)
+{
+	/* Called once when switch is probed */
+	return phy_config(phy);
+}
+
+void rzn1_rgmii_rmii_conv_speed(struct udevice *dev, int phy,
+				int full_duplex, int speed);
+
+static int rzn1_a5psw_port_enable(struct udevice *dev, int port, struct phy_device *phy)
+{
+	struct rzn1_a5psw_plat *plat = dev_get_plat(dev);
+
+	/* CPU port is already enabled */
+	if (port == 4)
+		return 0;
+
+	/* Get speed/duplex from PHY */
+	genphy_update_link(phy);
+	if (!phy->link) {
+		dev_err(dev, "PHY %s no ethernet link\n", phy->dev->name);
+		return 0;
+	}
+	genphy_parse_link(phy);
+
+	/* Program the converter accoringly */
+	dev_info(dev, "MIIC = %p\n", plat->miic);
+	rzn1_rgmii_rmii_conv_speed(plat->miic, 4 - port, phy->duplex, phy->speed);
+
+	/* Program the switch port accordingly */
+	dev_info(dev, "%s port=%d using speed=%d\n", __func__, port, phy->speed);
+	rzn1_switch_port_speed_duplex(dev, port, phy->speed, phy->duplex);
+	rzn1_switch_port_enable(dev, port);
+	return 0;
+}
+
+static void rzn1_a5psw_port_disable(struct udevice *dev, int port, struct phy_device *phy)
+{
+	/* CPU port is already enabled */
+	if (port == 4)
+		return;
+
+	rzn1_switch_port_disable(dev, port);
+}
+
+static const struct dsa_ops rzn1_a5psw_dsa_ops = {
+	.port_probe = rzn1_a5psw_port_probe,
+	.port_enable = rzn1_a5psw_port_enable,
+	.port_disable = rzn1_a5psw_port_disable,
+};
+
+static int rzn1_a5psw_probe_mdio(struct udevice *dev)
+{
+	struct udevice *mdev;
+	const char *name;
+	ofnode node;
+	int ret;
+
+	/* bind phy ports of mdio child node to rzn1_a5psw_mdio device */
+	node = dev_read_subnode(dev, "mdio");
+	if (!ofnode_valid(node))
+		return 0;
+
+	name = ofnode_get_name(node);
+	ret = device_bind_driver_to_node(dev,
+					 "rzn1_a5psw_mdio",
+					 name, node, NULL);
+	if (ret) {
+		dev_err(dev, "failed to bind %s: %d\n", name, ret);
+	} else {
+		/* need to probe it as there is no compatible to do so */
+		ret = uclass_get_device_by_ofnode(UCLASS_MDIO, node, &mdev);
+		if (ret)
+			dev_err(dev, "failed to probe %s: %d\n", name, ret);
+	}
+
+	return ret;
+}
+
+static int rzn1_a5psw_probe(struct udevice *dev)
+{
+	struct rzn1_a5psw_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	dev_dbg(dev, "%s:%d\n", __func__, __LINE__);
+
+	/* Enable clocks */
+	ret = clk_get_bulk(dev, &plat->bulk);
+	if (ret) {
+		dev_err(dev, "Failed to get clocks\n");
+		return ret;
+	}
+	ret = clk_enable_bulk(&plat->bulk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clocks\n");
+		return ret;
+	}
+
+	/* Access the registers */
+	ret = regmap_init_mem(dev_ofnode(dev), &plat->regmap);
+	if (ret) {
+		dev_err(dev, "Failed to get regmap\n");
+		return ret;
+	}
+
+	/* Find the MIIC driver */
+	ret = uclass_get_device_by_name(UCLASS_MISC, "eth-miic@44030000", &plat->miic);
+	if (ret) {
+		dev_err(dev, "Failed to get MIIC\n");
+		return ret;
+	}
+	dev_dbg(dev, "got MIIC %p <%s>\n", plat->miic, plat->miic->name);
+
+	/* Upstream port is always 1Gbps */
+	rzn1_switch_port_speed_duplex(dev, 4, SPEED_1000, DUPLEX_FULL);
+	rzn1_switch_port_enable(dev, 4);
+
+	/* Some extra resets are located in system controller */
+	plat->syscon = syscon_regmap_lookup_by_phandle(dev, "syscon");
+	if (IS_ERR(plat->syscon)) {
+		dev_err(dev, "No syscon node found\n");
+		return PTR_ERR(plat->syscon);
+	}
+
+	/* Clear ETH and CLK25 resets */
+#define RZN1_SYSCTRL_PWRCTRL_SWITCH 0x188
+	regmap_update_bits(plat->syscon, RZN1_SYSCTRL_PWRCTRL_SWITCH,
+			   BIT(4) | BIT(3), BIT(4) | BIT(3));
+
+	/* Reset all PHYs */
+	struct gpio_desc phy_reset_gpio;
+	u32 phy_reset_delay;
+
+	ret = gpio_request_by_name(dev, "phy-reset-gpios", 0,
+				   &phy_reset_gpio, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+	if (ret) {
+		dev_err(dev, "failed to get phy-reset-gpios: %d\n", ret);
+		return ret;
+	}
+
+	phy_reset_delay = dev_read_u32_default(dev, "phy-reset-duration", 15);
+
+	dm_gpio_set_value(&phy_reset_gpio, 1);
+	mdelay(phy_reset_delay);
+	dm_gpio_set_value(&phy_reset_gpio, 0);
+
+	ret = rzn1_a5psw_probe_mdio(dev);
+	if (ret) {
+		dev_warn(dev, "mdio probe failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id rzn1_a5psw_ids[] = {
+	{ .compatible = "renesas,rzn1-a5psw" },
+	{ }
+};
+
+U_BOOT_DRIVER(rzn1_a5psw) = {
+	.name		= "rzn1_a5psw",
+	.id		= UCLASS_DSA,
+	.of_match	= rzn1_a5psw_ids,
+	.probe		= rzn1_a5psw_probe,
+	.ops		= &rzn1_a5psw_dsa_ops,
+	.plat_auto	= sizeof(struct rzn1_a5psw_plat),
+};

-- 
2.55.0

