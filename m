Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF9CFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0BA283693;
	Mon, 27 Apr 2026 14:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="mldP7OtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDB5E83AA9; Mon, 27 Apr 2026 14:53:44 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE68880433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 14:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so8194320f8f.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 05:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1777294422; x=1777899222; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1NGtbkZOvJd4iwTIDW3/TB+bnqplu5MnmlgFpLTkS4A=;
 b=mldP7OtFZFDcTm+3wC+PwMIFzTk8ATgwIXgoKje4yBBRvAyt5furIDsc/awekgMH7t
 uDdGNre2O+huR4HBFNbIr3PqtgBQDjedADwG79eyYo+2IBey45wy2Zhjlm6liMXBtAZQ
 /NGkWUJ4tSYxoITs1tjAC5RQaLkYkFjbVFYHdjd3C0uhk2taWZYT6YyGfRpO2ir/8ncJ
 wVRUJBTUNhK1xszrj4PJ+Ge/2WPuGbTlxzCaG2c6LfOy62h6Q4D0DJIHdImpkblfugSX
 Sj/2ZiJ5mVoMC0Ev7pXnA8p2ZgiaKgclIfgBhnYN0gwr7tPCCNOR9Y3vIUGfFb4nsYqz
 rA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294422; x=1777899222;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NGtbkZOvJd4iwTIDW3/TB+bnqplu5MnmlgFpLTkS4A=;
 b=CcuKweblTUucjWxy0D8NZrGfv5aRyVYmWYEseAQqSyz9tHqisBX6w8mmKNbWJWrMRR
 HXtAe0EVRQkguF/ddia+vaargdCHvSNdpAnhF/wjtQPctzKhLDJf4QoQ22tWrE1ANWcS
 Z/sZrU+wbXL3zDORA0c+pjDHbxn7VMjzX0AiS1+OHS3RDgq2Cv6BK2Xt9EAFYHAheITc
 9FwtDfq6CfJBksUxJ0rTYFeKrSu4TSMpeBo4ugtGrTAWPrUb7DwKUsc/WUFgz9EUvHGR
 maCtYUxtFLQfJ/BpqX5wDSUFK6suj3Cg7x5hzPA8FKZFL9DQdFHoH7WvaqiyM0QWBq6w
 RPQw==
X-Gm-Message-State: AOJu0Yx2H9YBrkrdmIisUG6r1++F6f6eYkrK7RGWeiHgqB3hhOjBAjub
 3eAicjVq/6CDmDEFU5m+5O633zujE2pnJi1S88HjjMfoYX38+3HW4YOrKeDmaGT+oc4Uctca52o
 LQwH2
X-Gm-Gg: AeBDietRoImOjpFVUNJ4j+T3iAogBq5y0yx3K/iG3Dhwfew2avwP5ABBSvQgUpMRZUX
 FXiRCrrI+fO5fzsApsAfqm/cKbP4Bz09aibCLb8W8sVleWuMNqvEpfx9zecA057EH3akfDc/m+L
 72x4hviryNYogZv/q+VuAfQpDv8YS5JOgdlQ/ALFhYfWpEoXRioywCJ18ebD0yDwYpyX8n5ZIaM
 iGWXRFASpNdOpknDb7rHRmA71GKti5ghnuhh+nJ17NszaoeFXcyIxtky9A2Yqx2ophcY/x3/v7o
 XD7D4yJSBB02EZwlz/GAtK1KNFOhSgzqlXVTU/gi3DxK4Ii8udklcdSOP2j+hll32O18GhZHWl4
 P8SL92Q07rFeD/n/1C+GtDVNmQt+/KnKc94vXx0gIqoXjCuAZ0QsGlQGZekWMIUrZgcx1VV7PLc
 DhpmIfOJOV7bQ7zZj52pl5tOrPBA2RAyFOB9/RJa59jwc6xmqB8M6jZ72ujnhoT4cAwZG6jvsNs
 m/VZZe+4mKdrS7m
X-Received: by 2002:a05:6000:40cb:b0:43e:aa43:243 with SMTP id
 ffacd0b85a97d-43fe3e24eaamr68659859f8f.43.1777294421784; 
 Mon, 27 Apr 2026 05:53:41 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae.
 [86.98.192.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm74890468f8f.22.2026.04.27.05.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:53:41 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 27 Apr 2026 16:53:22 +0400
Subject: [PATCH] rockchip: rk3576: Properly handle USB controller takeover
 from BootROM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-rk3576-usb-gadget-v1-1-982fd1de08db@flipper.net>
X-B4-Tracking: v=1; b=H4sIAEFc72kC/x3MQQ5AMBBA0avIrE1SQytcRSzQaU0kSItIxN01l
 m/x/wORg3CENnsg8CVRtjWhyDOY5mH1jGKTgRQZVVGNYSl1bfCMI/rBej6wcUZpamxZEEPq9sB
 O7v/Z9e/7AcxX/jVjAAAA
X-Change-ID: 20260427-rk3576-usb-gadget-9f60529d312e
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Anton Burticica <mouse@ya.ru>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2259; i=alchark@flipper.net;
 h=from:subject:message-id; bh=x5QZoKCT7SF4HRdQNrsHLyrK41+s/8Dz9gNQg9SVD8Y=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWS+jwn4VXC/KNSw8+GnOKFK/nbj0GnHo/vdpfqOJ2ibe
 Wc+dTvXMZGFQYyLwVJMkWXutyW2U434Zu3y8PgKM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFT/cWb4H8Q+I2vLvFdF3xYLyc7hKHupn2FW13UiInT1/fBY9f9czgz/NN7MnB5
 eM0nmi30Rx2728/MMrs/OXFnFyy0r+ld7r1QHHwA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

From: Anton Burticica <mouse@ya.ru>

When booting via USB download mode (Maskrom), the BootROM leaves the
USB3OTG0 controller in an active state. U-Boot must properly reset
the controller before reinitializing it for fastboot or other USB
gadget functions.

Without this change, USB gadget mode commands such as fastboot and ums
fail when U-Boot is loaded via Maskrom USB download because the
controller state is inconsistent.

Signed-off-by: Anton Burticica <mouse@ya.ru>
[Removed unrelated changes, adjusted the commit description]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/mach-rockchip/rk3576/rk3576.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
index c17ba418ced5..84618ad5acb7 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -7,6 +7,8 @@
 
 #include <dm.h>
 #include <misc.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/hardware.h>
@@ -39,6 +41,10 @@
 #define USB_GRF_BASE		0x2601E000
 #define USB3OTG0_CON1		0x0030
 
+#define TOP_CRU_BASE		0x27200000
+#define TOP_CRU_SOFTRST_CON47	0x0abc
+#define SOFTRST47_ARESETN_USB3OTG0	BIT(5)
+
 enum {
 	BROM_BOOTSOURCE_FSPI0 = 3,
 	BROM_BOOTSOURCE_FSPI1_M1 = 6,
@@ -189,6 +195,18 @@ int arch_cpu_init(void)
 	 */
 	writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
 
+	/* If the controller was left running by the boot ROM, reset it */
+	if (read_brom_bootsource_id() == BROM_BOOTSOURCE_USB) {
+		/* Assert USB3OTG0 reset */
+		writel(RK_SETBITS(SOFTRST47_ARESETN_USB3OTG0),
+		       TOP_CRU_BASE + TOP_CRU_SOFTRST_CON47);
+		udelay(1000);
+		/* De-assert USB3OTG0 reset */
+		writel(RK_CLRBITS(SOFTRST47_ARESETN_USB3OTG0),
+		       TOP_CRU_BASE + TOP_CRU_SOFTRST_CON47);
+		udelay(1000);
+	}
+
 	/* Disable USB3OTG0 U3 port, later enabled by USBDP PHY driver */
 	writel(0xffff0188, USB_GRF_BASE + USB3OTG0_CON1);
 

---
base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
change-id: 20260427-rk3576-usb-gadget-9f60529d312e

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>

