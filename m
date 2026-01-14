Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2850D3901B
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 21:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B745480433;
	Wed, 14 Jan 2026 22:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="WzncQsjg";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="Qu/fy5y4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 176978063E; Wed, 14 Jan 2026 22:31:34 +0100 (CET)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A6E8803F5
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 22:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-cnq3.prod.antispam.mailspamprotection.com;
 s=arckey; t=1768426291; 
 b=HN/2VxQQp8US+vXcEEFckkfco1/sR9C1R1BNtfID2/2726oHrCbowvF9Chss3Mw+Oj20drX7X/
 7Yho/pakcghtelLccwMpvvOmJDXoAyKKpMvmYnkMfLmmkVqIexdlxOXnjLz7qFqcFUZW94mLU9
 q0ElktqL/co7JSRvwRE8bFTC7KNTG3IYJ5Q7duRwybchA7pLtKpwbL5C34+Q7V4ao/aoymuojq
 Ssh2FffYF7eTMqPV4xv+isNdTkiUWn3anU/y49rhNmBWs4gBMJzyqY2it0PLQ5iIzKKHxXriBg
 mYlEYRDBm9XJX1BytG/DnQsgx9T7WXvi+A1bcI7eSP2fJQ==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-cnq3.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-cnq3.prod.antispam.mailspamprotection.com;
 s=arckey; t=1768426291; 
 bh=LtHxnw6f0wKO6l/iAksy5cMQ+w7L9Ix93bB5pNZ22t8=;
 h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=gqv9vIsFUsh9lG2sjnBrt7RJ8xJediMelw2x+HrFl9U2z0KkypZ9RDXnwFaXHqyGnYmKNPCjlr
 PPt36Vp/yS05hSaHekfsGLHwg+YiDP26GAsCU2DI7sttvJeq1hXQAo5z2XEmz/AtGDkOaWoWZe
 fvNYBUua21OV8hFREb6Ut8VrOZpmUNoyY10/5a5y2o7F+aki2FcJo9fIrBzw90LzKrz5P+eP6G
 sTcP+yiKoVO2CPJsnalOu/ZwqSYFzW/zPV1BFJk+bhCK/gMdiAYSCAkVvaOxXCKKqLNbvhp8Q8
 V9M9/rlCw/qHiztu1++GR9SmKTs9H7Gbj8oI+GIb3ULkAQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=ZDSPuLxSdi9vcsCNaM7d2GV/WsV41n7700CiYzVsqts=; b=WzncQsjgTKUGuacINk+bTj9OUF
 Hr15EZaWEWNw/v4ZBoHSRbmM5k/IxC4SHQuExbfUNEj6jgsiasWZd8wRmKrVleZDmzsjTH0kEo1Dw
 CA36Op0Ml9LCOkwwYYw1c/Qf6+RDQdLUVoiomhW+F9CBjcO+5NUg3H750Y/5a0Vd6xcA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-cnq3.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1vg8Sd-00000006HiG-2RQC
 for u-boot@lists.denx.de; Wed, 14 Jan 2026 21:31:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=ZDSPuLxSdi9vcsCNaM7d2GV/WsV41n7700CiYzVsqts=; b=Qu/fy5y4/lYbLnxJ+CLeQQHWPZ
 kRrdWeHyemvcCf8T9b+5xTa5n/Y0o3+RiUPtYiV8YM7qOjYX05E1GciixYZgirCB/Q4vIy2fmOseA
 4+jbVei0QNQx71YUYGA5K8aEVYwu6caAIaamLN5qVcSyytMpmBUlBy8M1MTv/oFAC6v0=;
Received: from [95.248.141.113] (port=61754 helo=[192.168.178.65])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1vg8SM-00000000CH5-2L9g; Wed, 14 Jan 2026 21:31:10 +0000
From: Francesco Valla <francesco@valla.it>
Date: Wed, 14 Jan 2026 22:30:58 +0100
Subject: [PATCH v2] imx93_frdm: clear and mask TCPC interrupts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-imx93_frdm_tcpc_fix-v2-1-ac9b8c9ebafb@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NywqDMBBFf0Vm3RSTVNO46n8UEU3GOuCLJASL+
 O9Nhe66PAfuuTt4dIQeqmwHh5E8LXMCccnADO38QkY2MYhclDnPBaNp07LpnZ2aYFbT9LSxQhY
 3bWTZKasgLVeHSZ/VZ514IB8W9z5PIv/aX0/+7UXOOLMK+7sWpVbYPWI7ju2VAtTHcXwABWw4R
 bUAAAA=
X-Change-ID: 20260102-imx93_frdm_tcpc_fix-53549c36b7d7
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Joseph Guo <qijian.guo@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Fabian Pflug <f.pflug@pengutronix.de>, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4599; i=francesco@valla.it;
 h=from:subject:message-id; bh=LtHxnw6f0wKO6l/iAksy5cMQ+w7L9Ix93bB5pNZ22t8=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDJkZ3OI3XNUsflmqKOkb1Dxw3DRD9AbHtWX/15XlHTP5E
 Jm3//nfjlIWBjEuBlkxRZaQdTfu7Zlr/i1tA+MjmDmsTCBDGLg4BWAiojEM/z3bXJ44yP3k//+o
 f7mEHl+9s1rAusbGYofvMk/P6Fe+LGJkeLvD9FJ9KOOElmsd2+ZXv3U4I1Tw5X3dqRXuluu47i1
 05QcA
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
X-SGantispam-id: b4b21ba9823f2eed5586ed78a6014c42
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vg8Sd-00000006HiG-2RQC-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-cnq3.prod.antispam.mailspamprotection.com; 
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
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
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
Changes in v2:
- Collected Reviewed-by and Tested-by tags (thanks!).
- Link to v1: https://lore.kernel.org/r/20260103-imx93_frdm_tcpc_fix-v1-1-d7ef892697eb@valla.it
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
base-commit: d503633a36767d756c7de28305cf0de79440cbc0
change-id: 20260102-imx93_frdm_tcpc_fix-53549c36b7d7

Best regards,
-- 
Francesco Valla <francesco@valla.it>

