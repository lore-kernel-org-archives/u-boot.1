Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A3DC982D1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 13:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 382D060B58;
	Thu, 17 Sep 2026 13:41:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WLEnqOrL8S4i; Thu, 17 Sep 2026 13:41:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DC6B760B57
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789652490;
	b=O4t+Ge59fX2XP35NUFB50R0lAu20ZcnB5SRZL3E0WZNL9VbjQ9Zu/0e1NpzN3TusVyAo
	 ugmbzJwRL2LZxmzhgZ0cs2RDvlNz9OMieu7Lo4AbTKLXh27i1lWhDL3Zy3wQqXuddf3NN
	 D6/z/vLFjzWimMONxloGN1RZxFHz6JTDzZzore9M2pDaCZCXlRmDlfHyWpWpMs38O7lit
	 FIDnJX4yObBsnOi4RP1FA0Evd1xBjuvtnrabJRTi1j9pF1WT3egYWN0jS02ephUh9Lmkc
	 12NSKDE43TBOuuIKeqeZraK3NCboBmH94byRJAFwjRmMs7uT9lN1slKfj28m1gZYbWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789652490;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Envelope-From:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EwpAVj6sFPqH6FVee3B8Tm2jtJ/8lKbTSL3UE8ZjO/A=;
	b=huwq+BjRN7oF61wJs2QaxtImKmb0aeFiFKI8CufzJhRuQC8kZRSMsF4rpH7ObhILDWr6
	 2MC4sZ90KtWc3DqVGZbpLMXik8GdDQrjbv/4wcjMBrGpNxA4wdi+JBjfXrKbMWjkEH8sU
	 9Fj4qb8/eF5wCOhCEMW7VMwD0O9vg5dDOICNaxwXP6MxFoLByqgOpFCE6T3WD0HPoLs+X
	 hgt/Z+L72tfCQZ7mVF8rnv0BDdHUnhfB3dLzAzJVGLcpON771ZfKUt0igbiT//AS9k4JN
	 KThHJRIKbUzDTTA2MPX4F/DMXwKC5fo0ZUzQIUR2BqiLiKGrSJM9BbqSiSFEBvxxnOA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789652490;
	bh=EwpAVj6sFPqH6FVee3B8Tm2jtJ/8lKbTSL3UE8ZjO/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ymJs6XH2HBOYH9SBonzP2Abt66RE4UORUAG+/7BjcVbkZnOdLybt0LNJX7m/KQcF1
	 /K9FsaEKc0Idw3L7aA9DeQmx6Cu+XbkhZXQV3SpRYEosh4RlRnVxO/kJufcWbOKaEU
	 DYTK70VP4ZzAKf1zraUYWISPDFkBvXwL+a2Rq2rfpoAxbJ7nivevOOLOHkhWe/G2Em
	 IcSRLwXRCCu6FDSoFhk/9SLu0Va6Way/QLne7lshi3atJ0E9Aoxyey3E1B2qwvtjYq
	 ZKek7tcBxGJcVMjY77YINIc+abDjRRZukAYKCvKaQUsR9y17tJStdzQU10WWI7maEB
	 C/YfsOTQ4CkiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC6B760B57;
	Thu, 17 Sep 2026 13:41:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 173FE465
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F10BB80F14
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:06:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xW7riXbvvLqA for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 11:06:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D110F80E2A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=63.250.43.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789643200;
 b=QG5DV/4xcPpeftDID6NyXBdnJXUEpDdo9nJeFNt0P1ZNjz4AtVBagBwYWUhLaDUqKaoL
 Flt9rB3Bm67HoH3t75AqmM1oQTlzX3RAeW66Mqd7g2vePeYFZaXkqgNfo1T4JAv3qsnwV
 1N++CImhXV/LKA6yz+MH5k8539vZvwi6LZbq6Q75WkEx/4lHpjNPiqEpxLqfZtNCRWK13
 uAAy6G/mGJ7yy/00enmdEwYn+wtNx9/PtOp9RPVWyTMOE1K7TCKO6Sl6UgsknB7hkEOLH
 7wIAjqR0Ub4PKtwd/L//2WJwjA5AmbSXSQeLAYuG5P6qz6HY5LC2F8F459Ip4T4P44A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789643200;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:X-Mailer:Content-Transfer-Encoding:X-Envelope-From;
 bh=EwpAVj6sFPqH6FVee3B8Tm2jtJ/8lKbTSL3UE8ZjO/A=;
 b=nn2CtxJJ44wcI0DVhKSy66Sg3iZrVhPK7WQFtcnPR99uVr+oH127jG5NwPVHdSFLurcf
 bpsDfeuNUHtVVyAIX+DkUKZf4JcuRWS6fmqECTlG4NIdu0cUN7Gp9WEhv8WpSk+ReVRyn
 xRwt5QIpI4aUW4StwqLuhcxeQ/iF3m9hvvdTys7tIJuZqL8BKtsh2Xu0585uZ2p39U5U1
 eUglauHccllrKtFHAyts40ZgD5gzP4NkqolQALqxJp+qV2ADOwjfV6f57jvs0KNb7rt/6
 pLXADv+nLQ7qCkgbxbK4+BI8zyrnKDb/rkm7YgJiheYBG3zan6f5KudaIF26O20h8JQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=machinesoul.in; 
 dkim=pass header.d=machinesoul.in header.i=@machinesoul.in header.a=rsa-sha256
 header.s=spacemail header.b=IUe1+lME; 
 arc=none smtp.remote-ip=63.250.43.116
X-Greylist: delayed 302 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 17 Sep 2026 11:06:39 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=machinesoul.in
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=machinesoul.in header.i=@machinesoul.in
 header.a=rsa-sha256 header.s=spacemail header.b=IUe1+lME
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.250.43.116;
 helo=out-2uec-a116.jellyfish.systems;
 envelope-from=siddharth.menon@machinesoul.in; receiver=<UNKNOWN> 
Received: from out-2uec-a116.jellyfish.systems
 (out-2uec-a116.jellyfish.systems [63.250.43.116])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D110F80E2A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [223.181.11.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.spacemail.com (Postfix) with ESMTPSA id 4hlt9L1Z0Dz8sWP;
 Thu, 17 Sep 2026 11:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=machinesoul.in;
 s=spacemail; t=1789642892;
 bh=EwpAVj6sFPqH6FVee3B8Tm2jtJ/8lKbTSL3UE8ZjO/A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IUe1+lMEd7k2WPU/8X2hVaIQ84Jo87tnj25g22birmBa2iUh0K4kWK9jwHOhWCZOI
 u6/Yi6ex534JDTTFhlxU8VJUHFKLtxS7rAvLE4g8ZtQEPw3FBNYydGcNfj5Ha4KXGU
 9fBYSsthrjB6EhRv/fZ0tL8kSoCS1gQwY9qNWbI5Z2npDlZe5eM0dpi/1fE6Nm64QV
 KJdaSK4EpkvulS4wchOqCimCx1cc5P8DkO8n14B64taqy1HcSG2J/gI51eYKQfbDDg
 VoL1gw3myGpdSEiujhJdbMOIkBqOD103Y9YPpOfNHAL9Fphkr+lLwbn1VMj6r/JgaT
 nsd6EQFMRFAhw==
From: Siddharth Menon <siddharth.menon@machinesoul.in>
To: u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Siddharth Menon <siddharth.menon@machinesoul.in>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v2 1/2] button: imx: add SNVS ON/OFF power key driver
Date: Thu, 17 Sep 2026 16:29:21 +0530
Message-ID: <20260917-snvs-pwrkey-v2-1-15b41002385f@machinesoul.in>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917-snvs-pwrkey-v2-0-15b41002385f@machinesoul.in>
References: <20260917-snvs-pwrkey-v2-0-15b41002385f@machinesoul.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
X-Envelope-From: siddharth.menon@machinesoul.in
X-Mailman-Approved-At: Thu, 17 Sep 2026 13:41:10 +0000
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

This is a port of linux/drivers/input/keyboard/snvs_pwrkey.c,
adding SNVS power key support for imx chips after i.mx6sx

ON/OFF key is used to power on/off whole system.

Signed-off-by: Siddharth Menon <siddharth.menon@machinesoul.in>
---
v1 -> v2:
Correct the Makefile entry from snvs_pwrkey.o to button-snvs-pwrkey.o

 drivers/button/Kconfig              |   8 ++
 drivers/button/Makefile             |   3 +-
 drivers/button/button-snvs-pwrkey.c | 154 ++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
index 6cae16fcc8bfa1b35f2b23b497f8e0ad5d865d2b..f9a1c3e243744c9d1699fee9b55cb5b143b2b9bf 100644
--- a/drivers/button/Kconfig
+++ b/drivers/button/Kconfig
@@ -48,4 +48,12 @@ config BUTTON_QCOM_PMIC
 	  on Qualcomm SoCs. These will be configured as the Enter and Down keys
 	  respectively, allowing navigation of bootmenu with buttons on device.
 
+config BUTTON_SNVS_PWRKEY
+	bool "IMX SNVS Power Key Driver"
+	depends on BUTTON
+	depends on MACH_IMX
+	help
+	  This is the SNVS powerkey driver for the Freescale i.MX application
+	  processors.
+
 endmenu
diff --git a/drivers/button/Makefile b/drivers/button/Makefile
index 68555081a47a2eb92e7445f78b0f77568284f1a5..336bbc94078c8b75707052084fffc5e46f95a496 100644
--- a/drivers/button/Makefile
+++ b/drivers/button/Makefile
@@ -5,4 +5,5 @@
 obj-$(CONFIG_BUTTON) += button-uclass.o
 obj-$(CONFIG_BUTTON_ADC) += button-adc.o
 obj-$(CONFIG_BUTTON_GPIO) += button-gpio.o
-obj-$(CONFIG_BUTTON_QCOM_PMIC) += button-qcom-pmic.o
\ No newline at end of file
+obj-$(CONFIG_BUTTON_QCOM_PMIC) += button-qcom-pmic.o
+obj-$(CONFIG_BUTTON_SNVS_PWRKEY) += button-snvs-pwrkey.o
\ No newline at end of file
diff --git a/drivers/button/button-snvs-pwrkey.c b/drivers/button/button-snvs-pwrkey.c
new file mode 100644
index 0000000000000000000000000000000000000000..ba8120abe18189430bb1e3bb5cc1afbfd1ad3a96
--- /dev/null
+++ b/drivers/button/button-snvs-pwrkey.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for the IMX SNVS ON/OFF Power Key
+ * Copyright (C) 2015 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright (C) 2026 Siddharth Menon <siddharth.menon@machinesoul.in>
+ */
+
+#include <button.h>
+#include <dm.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <log.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <time.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+
+#define SNVS_HPVIDR1_REG	0xBF8
+#define SNVS_LPSR_REG		0x4C	// LP Status Register
+#define SNVS_LPCR_REG		0x38	// LP Control Register
+#define SNVS_HPSR_REG		0x14
+#define SNVS_HPSR_BTN		BIT(6)
+#define SNVS_LPSR_SPO		BIT(18)
+#define SNVS_LPCR_DEP_EN	BIT(5)
+#define SNVS_LPCR_BPT_SHIFT	16
+#define SNVS_LPCR_BPT_MASK	(3 << SNVS_LPCR_BPT_SHIFT)
+
+#define DEBOUNCE_TIME		30000	// microseconds
+
+struct pwrkey_drv_data {
+	struct regmap *snvs;
+	int keycode;
+	ulong last_update_time;
+	bool old_state;
+	bool keystate;
+	u8 minor_rev;
+	bool click_pending;
+};
+
+/*
+ * Only report a new event once it has been held for
+ * DEBOUNCE_TIME, on both the press and release edge.
+ */
+static enum button_state_t imx_snvs_pwrkey_poll_state(struct pwrkey_drv_data *pdata)
+{
+	bool pressed;
+	uint state;
+
+	if (regmap_read(pdata->snvs, SNVS_HPSR_REG, &state))
+		return pdata->keystate ? BUTTON_ON : BUTTON_OFF;
+
+	pressed = !!(state & SNVS_HPSR_BTN);
+
+	if (pressed != pdata->old_state) {
+		pdata->old_state = pressed;
+		pdata->last_update_time = get_timer_us(0);
+	} else if (get_timer_us(0) - pdata->last_update_time >= DEBOUNCE_TIME) {
+		pdata->keystate = pressed;
+	}
+
+	return pdata->keystate ? BUTTON_ON : BUTTON_OFF;
+}
+
+static enum button_state_t imx_snvs_pwrkey_get_state(struct udevice *dev)
+{
+	struct pwrkey_drv_data *pdata = dev_get_priv(dev);
+
+	return imx_snvs_pwrkey_poll_state(pdata);
+}
+
+static int imx_snvs_pwrkey_get_code(struct udevice *dev)
+{
+	struct pwrkey_drv_data *pdata = dev_get_priv(dev);
+
+	return pdata->keycode;
+}
+
+static int imx_snvs_pwrkey_bind(struct udevice *dev)
+{
+	struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+
+	uc_plat->label = "Power Button";
+
+	return 0;
+}
+
+static int imx_snvs_pwrkey_probe(struct udevice *dev)
+{
+	struct pwrkey_drv_data *pdata = dev_get_priv(dev);
+	unsigned int val;
+	unsigned int bpt;
+	unsigned int vid;
+	int error;
+
+	pdata->snvs = syscon_regmap_lookup_by_phandle(dev, "regmap");
+	if (IS_ERR(pdata->snvs)) {
+		log_err("%s: can't get snvs syscon\n", dev->name);
+		return PTR_ERR(pdata->snvs);
+	}
+
+	pdata->keycode = dev_read_u32_default(dev, "linux,keycode", KEY_POWER);
+
+	error = dev_read_u32(dev, "power-off-time-sec", &val);
+	if (!error) {
+		switch (val) {
+		case 0:
+			bpt = 0x3;
+			break;
+		case 5:
+		case 10:
+		case 15:
+			bpt = (val / 5) - 1;
+			break;
+		default:
+			log_err("%s: power-off-time-sec %u out of range\n",
+				dev->name, val);
+			return -EINVAL;
+		}
+
+		regmap_update_bits(pdata->snvs, SNVS_LPCR_REG,
+				   SNVS_LPCR_BPT_MASK,
+				   bpt << SNVS_LPCR_BPT_SHIFT);
+	}
+
+	regmap_read(pdata->snvs, SNVS_HPVIDR1_REG, &vid);
+
+	regmap_update_bits(pdata->snvs, SNVS_LPCR_REG, SNVS_LPCR_DEP_EN,
+			   SNVS_LPCR_DEP_EN);
+
+	/* clear the unexpected interrupt before driver ready */
+	regmap_write(pdata->snvs, SNVS_LPSR_REG, SNVS_LPSR_SPO);
+
+	return 0;
+}
+
+static const struct button_ops imx_snvs_pwrkey_ops = {
+	.get_state	= imx_snvs_pwrkey_get_state,
+	.get_code	= imx_snvs_pwrkey_get_code,
+};
+
+static const struct udevice_id imx_snvs_pwrkey_ids[] = {
+	{ .compatible = "fsl,sec-v4.0-pwrkey" },
+	{ }
+};
+
+U_BOOT_DRIVER(imx_snvs_pwrkey) = {
+	.name		= "snvs_pwrkey",
+	.id		= UCLASS_BUTTON,
+	.of_match	= imx_snvs_pwrkey_ids,
+	.bind		= imx_snvs_pwrkey_bind,
+	.probe		= imx_snvs_pwrkey_probe,
+	.ops		= &imx_snvs_pwrkey_ops,
+	.priv_auto	= sizeof(struct pwrkey_drv_data),
+};

-- 
2.47.3

