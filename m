Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461C3FC619A
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 21:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A801B83C65;
	Sat,  3 Jan 2026 22:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="a6Cw2GFn";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="qhgfQj8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEC6483C67; Sat,  3 Jan 2026 22:22:38 +0100 (CET)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3451583C54
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 22:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-fn37.prod.antispam.mailspamprotection.com;
 s=arckey; t=1767475356; 
 b=PIo0EYGkradwEkwq876cxSKZF7AAGTxp0mIL/0CFloEXWUZSH3WtMjTost6LftEYCcBy8oP+ie
 gTJSS2bvuKvYxNnsoO57UqDFemFhsEXoQ9EglrYBn8xFIjw4pHmRsFUV5gUgkUNyOJdMBk1vbk
 iTkl8QqX0xfk1+WNLKKJDUnakAsfNDadpHWbhM4LwPDYlzGu2wB9eKujMH9gvJbB66hmsrXt8o
 RcdtBl+7blTVRc5ZNq/zTkQBeRd144VTw3+BAGmTMwKMNwXF8z9L1nYbJrRpHfVT2Yqavos5tO
 ggpqI7xF1FooLh1DOiBDhxE7IIoAyy35KJFU6Jboy4VZ8A==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-fn37.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-fn37.prod.antispam.mailspamprotection.com;
 s=arckey; t=1767475356; 
 bh=FwOb4+4LZ+KqgBp5euDAN1CE1QvzVwkUY21xNBzJUUA=;
 h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=I6h2mlee969qLftdgZPNiqb0oSCwgRkNjP9A8Wlvpo+U4CIk7GuHUsJRQ4xkp4dBHAhRvzMy1s
 +xrfn2DbFIkBuJb2SpJxuzTPa1w4qqJhTwMRJlKgwJuuASHT5jVH7b9UCPLq74AIWG5qjrK3to
 9sIVlx3NEBwpXR8iiJfSYBHzrVhsPU/rPaz/TaUTLZS0I3UHjPnRE7ovixsS/ik5oZrEvTy9Rs
 MhcJrxStJesqk1SzCMBWDaZ5a0RYWNP98AQoU263s4fUaidtPdtXPu1n1mhnSCP1F/RjuNW/D7
 7qUJtt1/+726qNIaWx+nZUzNUwHOpyIN3MjBnLxtbJDgSA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=ehKYbCdeUwDxpCO0wdJjKjW9E9xB2o0PYdiya6cEyAY=; b=a6Cw2GFn4ff+eMe/wS7P0xQfZv
 lTWIS8KuWCOFIVwiRwAbBhvt93DJu31QPtrC+KLWE1Y8jpH61gS5XjErW0NCaVcnb4kt9ZhysBokY
 Em1GN4hbW/k7qGK8T6e9UcmVgu9p9cSuJaVVZBlx9mLG4iAhcOeRelHeuOxUwHrjahd0=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-fn37.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1vc94y-00000006eyx-1SwP
 for u-boot@lists.denx.de; Sat, 03 Jan 2026 21:22:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=ehKYbCdeUwDxpCO0wdJjKjW9E9xB2o0PYdiya6cEyAY=; b=qhgfQj8BKeHFMNAs05vwb/WA08
 uFgmEbcV5XhpNRZickazwTpqWSYrqqKjAr70Tj1nLJbWi1O0lQZIxP3NzsOBqa7x/fUuOcpsjZ3X5
 S7ErY3p8evZbcOWSq4RAk6JQAGh2sqJudd03ERWmKp3loxtCgk0/Pct71DnE714Vp8ww=;
Received: from [95.248.141.113] (port=63547 helo=[192.168.178.65])
 by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <francesco@valla.it>)
 id 1vc94s-00000000Nry-0QUt; Sat, 03 Jan 2026 21:22:26 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sat, 03 Jan 2026 22:22:12 +0100
Subject: [PATCH] imx93_frdm: clear and mask TCPC interrupts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260103-imx93_frdm_tcpc_fix-v1-1-d7ef892697eb@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAArxL7neCjlLpKhJRutR9WaIQQ3T3pc
 wZmHkgYCRP01QMRb0p07AVEXYHbpn1FRr4wSC41F1wyCrlTdok+2Mudzi6UWavapnNKz8YbKOU
 Zsej/Oozv+wEh0YLuZQAAAA==
X-Change-ID: 20260102-imx93_frdm_tcpc_fix-53549c36b7d7
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Joseph Guo <qijian.guo@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Fabian Pflug <f.pflug@pengutronix.de>, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4275; i=francesco@valla.it;
 h=from:subject:message-id; bh=FwOb4+4LZ+KqgBp5euDAN1CE1QvzVwkUY21xNBzJUUA=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDJmRHV1rDqVmt2zT7F/19ufsP8f/crhGLavkujtJcEeCo
 ZV+rr1LRykLgxgXg6yYIkvIuhv39sw1/5a2gfERzBxWJpAhDFycAjARvuWMDPOqzSf++T0vxkbt
 AN/2qPlz2kxVnFa9C7qx517dacWrrayMDLP3/L95sXbSpedr7Ep/P5V/G3mxca3F2VkfLXQ7ot5
 8jeYEAA==
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 7eb3879771534efd907b8d6ab9c0cb6f
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vc94y-00000006eyx-1SwP-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-fn37.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

One of the two on-board PTN5110 TCPC USB Power Delivery controller on
the i.MX93 FRDM board shares its interrupt line whith the PCAL6524 power
controller (GPIO3-27). Since the PTN5110 starts after POR with the
interrupts enabled, this can lead to an interrupt storm on OS startup if
only the driver for the PCAL6524 is loaded, because none is servicing
(and clearing) the interrupt requests from the PTN5110.

Maks and clear all interrupts as part uring board initialization; they
can be re-enabled later by a proper OS driver if required.

Co-developed-by: Joseph Guo <qijian.guo@nxp.com>
Signed-off-by: Francesco Valla <francesco@valla.it>
---
Interrupt storms have been observed during the Linux kernel startup on
the i.MX93 FRDM [0], leading to the IRQ functionality being disabled for
the involved IRQ line. Even in case the IRQ line is not disabled,
several thousands of interrupts can be observed:

 94:      55749          0 gpio-vf610  27 Level     1-0022, 2-0050

This has been traced to the interrupt sharing for one of the on-board
PTN5110 TCPC and the PCAL6524 I/O expander. The same behavior was
observed and fixed on the i.MX91 FRDM [1], so the proposed solution
is the same: to mask and clear all PTN5110 interrupts during board
configuration.

With this patch applied, the interrupt line is completely silent on
startup:

 94:          0          0 gpio-vf610  27 Level     1-0022, 2-0050

I added the Co-developed-by tag giving credit to Joseph Guo since the
technical solution is theirs, as developed for the i.MX91 FRDM.

[0] https://lore.kernel.org/all/20251230171548.67289601@windsurf
[1] https://lore.kernel.org/all/aTDyW8Rm1u6hWUuc@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
---
 board/freescale/imx93_frdm/imx93_frdm.c | 59 +++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/board/freescale/imx93_frdm/imx93_frdm.c b/board/freescale/imx93_frdm/imx93_frdm.c
index c436ac6aa4791000c5eaee13f6190ad7d83bdc55..cfbcde2e1a579e9401a3df04011f567e218af6fa 100644
--- a/board/freescale/imx93_frdm/imx93_frdm.c
+++ b/board/freescale/imx93_frdm/imx93_frdm.c
@@ -5,6 +5,7 @@
 
 #include <env.h>
 #include <efi_loader.h>
+#include <i2c.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/arch/sys_proto.h>
@@ -36,6 +37,62 @@ struct efi_capsule_update_info update_info = {
 };
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
+#define TCPC_ALERT 0x10
+#define TCPC_ALERT_MASK 0x12
+#define TCPC_FAULT_STATUS_MASK 0x15
+
+#define TCPC1_I2C_BUS 2
+#define TCPC1_I2C_ADDR 0x50
+
+/*
+ * Mask all interrupts and clear alert status for the PTN5110 TCPC USB Power
+ * Delivery controller. This is required to avoid an interrupt storm on OS
+ * startup, since the interrupt line for the PTN5110 is shared also by the
+ * PCAL6524 I/O expander.
+ */
+static int clear_pd_alert(void)
+{
+	struct udevice *bus;
+	struct udevice *i2c_dev = NULL;
+	int ret;
+	u8 buffer_0[2] = {0, 0};
+	u8 buffer_1[2] = {0xff, 0xff};
+
+	ret = uclass_get_device_by_seq(UCLASS_I2C, TCPC1_I2C_BUS, &bus);
+	if (ret) {
+		printf("Failed to get I2C bus %d\n", TCPC1_I2C_BUS);
+		return ret;
+	}
+
+	ret = dm_i2c_probe(bus, TCPC1_I2C_ADDR, 0, &i2c_dev);
+	if (ret) {
+		printf("Can't find USB PD device at 0x%02x\n", TCPC1_I2C_ADDR);
+		return ret;
+	}
+
+	/* Mask all alert status*/
+	ret = dm_i2c_write(i2c_dev, TCPC_ALERT_MASK, buffer_0, 2);
+	if (ret) {
+		printf("%s dm_i2c_write failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = dm_i2c_write(i2c_dev, TCPC_FAULT_STATUS_MASK, buffer_0, 2);
+	if (ret) {
+		printf("%s dm_i2c_write failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	/* Clear active alerts */
+	ret = dm_i2c_write(i2c_dev, TCPC_ALERT, buffer_1, 2);
+	if (ret) {
+		printf("%s dm_i2c_write failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 int board_early_init_f(void)
 {
 	return 0;
@@ -61,5 +118,7 @@ int board_late_init(void)
 		env_set_ulong("dofastboot", 1);
 	}
 
+	clear_pd_alert();
+
 	return 0;
 }

---
base-commit: eb18217b63b79dfcec704d420fcc61e77397c88f
change-id: 20260102-imx93_frdm_tcpc_fix-53549c36b7d7

Best regards,
-- 
Francesco Valla <francesco@valla.it>

