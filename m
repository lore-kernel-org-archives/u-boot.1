Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54F8C88E64
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 23:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50F4F80E05;
	Sun, 13 Sep 2026 23:21:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PxHG5nDUfpFA; Sun, 13 Sep 2026 23:21:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8589B80D63
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789341624;
	b=b71OivlyOKGwN+7gSs3LKDGx2zGiOOvCqtswekH7rN4DlqqEEOePpZ26VVdRKyPQvo0d
	 HGXd18NKEsiwYc2lwXoCqhnnSbbGaoIw3rIJ+JQjz8/c28gIV/UvO3utkDJN2mPJi336m
	 5Clz65jE5H/a3M6onbGPsDLQ+b9iC31oOWKjrVECGLmLyYgD3y4mDAI40JWBJUW+mB9r+
	 BVXEE2Zcg4RTyD++HUGerS/PurF48nLdbi8IioQEYxoaMx9uocUtEsOf98xhlanUVUyYD
	 dF7eB0DfgwZZR5dPBQy+VehnjrCD9azOidHEWbDqJu6JAiYChCAfo1s9iGrQ9rX57aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789341624;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Envelope-From:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0KcRMj6z2YbUW0B65DtrTVnCoFqFHPVCbknS7CivlpI=;
	b=rSjZuaPxSnX8LIPHVsO+8PtrWhuI8n5dmY9D68v5VAoIHf/jFGsqrfvXmzbLg3HhW181
	 5LwPqIIuMiAt0LobJLNKGhGNnQaSdBOgCb2DeAFl5ekOe8Ps3lpDHyTvl9dyBxOu9LVzB
	 gPykSGp4SLUhVX8rnl0fwhfjtVyJzz+pKu9QO+pdYeMvvY9/DYiJSAoJ94zFtk+Tc0OLc
	 4FSX7J0l8nJd5mZI/KanMCa28Q+t0VRTgAlZAF8GNxY1+Vy8pyreqi8/NQXNrNOAvKwvQ
	 GgYPGYbNZSlTjFZ4if2Ea447UQUxtTyOT3tqOgXzQfsavvzvm4DRdSm4LqT28Iun65w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789341624;
	bh=0KcRMj6z2YbUW0B65DtrTVnCoFqFHPVCbknS7CivlpI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k01ZU+fPcCYPUngPfKh+vH1MiatEw1s8XzoxlhK3HmsugHsv0pXSezGN5NH+ZIcf/
	 OiT0DVw0jgYRVPANHpqCn0bmrLfBrjCrjMCBFXhbARe8ynFetMtG6q+fCgSzIuaohj
	 GwtBuzEgHYst9FBJtMqO86nw+ZaCuy77O4+7BhmEMMPKD92SyhME/UKuhjeyEQYBb9
	 6wpvpjDhiKIhaEFLhHDSUNCdsy3Gm9yE6KM6MnV2WcW9kmxdcrTpVpUyqsD0X5KeyV
	 78wTIPegovk4VsKnNcCse4PwrvD7vX8xCLTAbz7YZnR7sSTiWY7pnkl7CZ/eflvzQh
	 ww6NR6eU3xaSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8589B80D63;
	Sun, 13 Sep 2026 23:20:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 528C323F
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 20:24:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43FA5403EE
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 20:24:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MpL201FLJgNp for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 20:24:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1E4BA403C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=198.54.127.149
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789331078;
 b=L8qbyEE0SbdbpICyPZc9ZpkoezVhw3dKUq/+pMSBenzxYHj6+jQ1XB8yhXHQ94J1fUBC
 U2yNn2Ajf8bKVwtgLbrSiqE6fnPcjUNaKNP99a9asnOfRNS+BCBzPMgr6BV9s/THV2Vpj
 gzhlfg3mo3o28w+BJ9SC7D2oheFRIG/BSRCKEsnSqVpp+GG2541vvlL1GCLXSwbLJzec2
 r2e2rxLl/ExHWqTXHsIkrVsMuXc5fT+9hxpd04tnKuI6lfITG+M0cMWOn2NklhqKDa6/R
 iH5/q3ioVkHqdD4dkDlHvLg1j4OCvGlQKnygxPxg9tZI6cVIMRy43F0wSK8a2GGzgrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789331078;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Envelope-From;
 bh=0KcRMj6z2YbUW0B65DtrTVnCoFqFHPVCbknS7CivlpI=;
 b=KSDFdCqAwpcBVZRJvRLGEe0dkOqWqfh2D41KRhlAC6ymuPL+/6IN4wDV343iUxQgoQl8
 ICSRP5j3LmA8ID9nWAqxvbdJQfFSkwgKI5Q3QBqnDqEKSZNrR7bmi5uKICqsMqwqWQZP5
 ahJ6oD8lNCuCKQC3DtoIok7uIMqr4TLl8NbOekv4TT8Dir9FijZBjQPF28zctN6P8Sd7q
 JkXiDvwwp7qDju+P+nO1bPF0fCfDLvBDKA6UIgFcCXTTIbPtMeDcU6LVZkFsLZxv8O2Q4
 sA7+UDpMFg4nzMWBuGcJZCgVPAUN6/Hb0i/UFQPCihhHG1LUkR7jBqSjNUJMtaUU3mQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=machinesoul.in; 
 dkim=pass header.d=machinesoul.in header.i=@machinesoul.in header.a=rsa-sha256
 header.s=spacemail header.b=axEofGgT; 
 arc=none smtp.remote-ip=198.54.127.149
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.54.127.149;
 helo=out-2z4y-a149.jellyfish.systems;
 envelope-from=siddharth.menon@machinesoul.in; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=machinesoul.in
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=machinesoul.in header.i=@machinesoul.in
 header.a=rsa-sha256 header.s=spacemail header.b=axEofGgT
Received: from out-2z4y-a149.jellyfish.systems
 (out-2z4y-a149.jellyfish.systems [198.54.127.149])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E4BA403C4
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 20:24:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [223.181.15.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.spacemail.com (Postfix) with ESMTPSA id 4hjfrj2Dtgz8sWT;
 Sun, 13 Sep 2026 20:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=machinesoul.in;
 s=spacemail; t=1789331062;
 bh=0KcRMj6z2YbUW0B65DtrTVnCoFqFHPVCbknS7CivlpI=;
 h=From:To:Cc:Subject:Date:From;
 b=axEofGgTYqPuhsTc2qBrgzXJgKrs9nTkmvt9nSqRGqcSDHljf+p7llPkW+ytqtmNg
 E3E7Qn0Nc9e57EZ4lq+7S7eCbLDgBtVslQ2zfkh3pVoG+B7s8BfTwsr/pfZ2gHW5Fd
 18SX3maZMFbtlLENOBN7frWyMJkFr05zhBIiUub4rX8tKzq2gP6oTAqmxAp2VJVx49
 Z77MRkDd2qHu2I4ZkXX6u+oVqJK43+XfOwiSG2tWi4l8QxcugxDfnholq3wx6tf0WV
 BoD7tEeOKDoSf8FpGl1S/1ueFd8939ob1zrVBxpQZ4GHH/CCw6/2oxvduopRGyoUcn
 HPSzfsoXjCC9w==
From: Siddharth Menon <siddharth.menon@machinesoul.in>
To: u-boot@lists.u-boot-project.org
Cc: Siddharth Menon <siddharth.menon@machinesoul.in>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] button: imx: add SNVS ON/OFF power key driver
Date: Mon, 14 Sep 2026 01:53:03 +0530
Message-ID: <20260913202303.2583287-1-siddharth.menon@machinesoul.in>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: siddharth.menon@machinesoul.in
X-Mailman-Approved-At: Sun, 13 Sep 2026 23:20:18 +0000
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
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/button/Kconfig              |   8 ++
 drivers/button/Makefile             |   3 +-
 drivers/button/button-snvs-pwrkey.c | 154 ++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 drivers/button/button-snvs-pwrkey.c

diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
index 6cae16fcc8b..f9a1c3e2437 100644
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
index 68555081a47..f617574a128 100644
--- a/drivers/button/Makefile
+++ b/drivers/button/Makefile
@@ -5,4 +5,5 @@
 obj-$(CONFIG_BUTTON) += button-uclass.o
 obj-$(CONFIG_BUTTON_ADC) += button-adc.o
 obj-$(CONFIG_BUTTON_GPIO) += button-gpio.o
-obj-$(CONFIG_BUTTON_QCOM_PMIC) += button-qcom-pmic.o
\ No newline at end of file
+obj-$(CONFIG_BUTTON_QCOM_PMIC) += button-qcom-pmic.o
+obj-$(CONFIG_BUTTON_SNVS_PWRKEY) += snvs_pwrkey.o
\ No newline at end of file
diff --git a/drivers/button/button-snvs-pwrkey.c b/drivers/button/button-snvs-pwrkey.c
new file mode 100644
index 00000000000..ba8120abe18
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

