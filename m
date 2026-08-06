Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E26C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 12:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE1BB40637;
	Thu,  6 Aug 2026 12:54:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wzAIXPjL1i8Q; Thu,  6 Aug 2026 12:54:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F3D4405F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786020894;
	bh=j8YwPYOaI8jJVJbB1rqbtJGH+g7vQlxJyzpbbqu/olI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pvZl8sxVtkjm1BfMJWorzWSphlONDjE4ig1FBxCswwQNOLILxMZ9KVTrW4Srs/3GF
	 zdvXYo+3Q/gDh4CrCuP6vJFQsN1GH8xFSPt8rmR5L/ep6cc5FD6a3Kv9Sb2YiUxEXi
	 tW3iEkv4k9ZVyHjh2IV8x5bN30oyFkHVgZK0h7nxCMLn+rL0CgE6cSBP5L9UWPHAl/
	 C1a6eFgJGtNPPkwko95Qh/IHtawvY9dwMfkqdjhVslSNbsUAv5x/IQo8ScmFBieIeC
	 qHCoKEvwt+Ztu0jRlY1zri5Vj/+HeLDicQNCDSGGDxAZvE01Szl4e1o9tOSCfitqoE
	 qEHzmPPz7bEbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F3D4405F2;
	Thu,  6 Aug 2026 12:54:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C72D397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72E2D80DFD
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:54:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JwMIF0kZmgGP for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:54:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7A65F80DF6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A65F80DF6
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A65F80DF6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:54:48 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso32393365e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 05:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786020886; x=1786625686;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j8YwPYOaI8jJVJbB1rqbtJGH+g7vQlxJyzpbbqu/olI=;
 b=B+rDR9KSAaUf/u8qtmq38yTydpXkB+8iKAW7cSxvD62i946HNyXi9Fn4MgEn/tn2kY
 cBOdoozuAV5Df3E3zeq8ieTJDnp640brCukM3oex/K+hZD1k82I8TCS4ATbqdzhEIL5f
 QTaparoMPtp/JK2PZLJy8YIl8CRsocHpZWZScTnPa17Z6OJWnKtvoC6BHdPwNb3hADU9
 9kcbgj8M2eyX4MaHP26cefrpy2nTCw+Gs2Ge9Ywct6nzj/yaNfHKzsi7qS1DqeLGaBhq
 QF1DQR9CEvl+s+YJO40PhHoNMqe/MEjriMyyM3Kk4CAKEZ50nnaNesBC+LTIxGn5k8wW
 IZOw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrvo8kMm3uMxPPX8Y3+ezup1Xv8Vj05TnqUSvk/lrN8NdyVhLnZr6WzHlL/Xd/odGATR4Um3Tw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxxyfxMk73INNOvIjub+LABAl0E/3oHTE3Lyn2JYVyjgn13a/kQ
 xU6SWS5DuVpEZteZJHCGlvsuPZY8Rn4wSM250PYzOgi8R2KZgRFcQ+LF/4zbmTizz48=
X-Gm-Gg: AR+sD12bOQqxeqFqtIIQ//MqGPy2Y9OFjjdWtE08XJyHs2igUgp+G0nDx98HM+5HhRU
 KMu0AHhUBgFd15gk0GmuEFMKq0ksKRGShqJTgPwC3lLDyYKl2EtGzerOEM/M2/ZiAfsqVkRH0+6
 a6kyiKwx+EiuCDdRJ2IeOe+QslqMtqVGHXocmdlHHu7fgtXiF5I+CfkX9nlj1d1K6s9Pngysd4C
 FZ/vtPIo51nDtCYU4aIqrRcmW7f5Z/gK83UTC8ag7jxvdoM9KkT+6smkvqdON9vTuuGGIZVMrkq
 pnpUaEeY696M9dgRTs2w0NobIrjFt5fcx9c2ofwVuiKHsDsvwR2rmys+70X293QPP2N9xdtnNcz
 GLXtBf2NkEkPN0TNURVhfBNJHL7dmMb3nQzir/qbu9SiAZS6MFI853+Zc06UFmQ4/2PW8XVTnnK
 SPe4pHjXYVkC21T7099d6Kjc7gADum0FbEE7YGqemq8eoBZU/0IVNUmE7kzv2u16W4qmEUSnR4o
 KNjd4UUlbPQRomnKlxpwx9EeV8CX8ujX413hgDk5XemiWTEjMoAmJ9sQd4HfCGKjN2VPuiOQ76+
 Akvuog==
X-Received: by 2002:a05:600c:35c8:b0:498:28b:1025 with SMTP id
 5b1f17b1804b1-49959e08745mr16104855e9.5.1786020886345; 
 Thu, 06 Aug 2026 05:54:46 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542133f0sm69292995e9.5.2026.08.06.05.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 05:54:45 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 06 Aug 2026 14:54:37 +0200
Subject: [PATCH v6 3/3] usb: mtu3: add SPL gadget support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-3-66e133a4bf1a@baylibre.com>
References: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-0-66e133a4bf1a@baylibre.com>
In-Reply-To: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-0-66e133a4bf1a@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786020886; x=1786625686;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j8YwPYOaI8jJVJbB1rqbtJGH+g7vQlxJyzpbbqu/olI=;
 b=fUpib0hnIWU1WjsTIYaAqNpo63EHqltsOLAnJmTQ52zaWSFUzMpL/b9X45doQMPNwq
 0vvNjzIzDCNnT273R2xsQuCpVqB81/8SWT4UaKzU4lvUaBcTOdKEv3flNIgzOpqqguXO
 S6tv3HXrIh9P5yrlSBFcNemXKaQFIekWHQClWjiPpwMXP9Ow0B56JtqlBLltGkc2bcGr
 JXRZubS7c7hRNMplkUrEqZIzBfaRV2ZJZJmiruY2F+VFsP15LQ7LpwC17H33fppbG+a7
 3rQ0vaD+Hw9wI2W4U3RNnOV81k5G9Jd21szw5x7vmYZdq4HpXcilz/vRQVA8CELPaNo1
 EvqA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fUpib0hn
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

MediaTek platforms may need the MTU3 peripheral controller before U-Boot
proper is available, but the driver is currently selected and built only
with the main U-Boot configuration symbols.

Add an explicit SPL controller option and a phase-specific gadget mode.
Make the driver build and its role checks phase-aware so SPL can include
MTU3 without coupling it to the U-Boot proper controller configuration.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/Makefile             |  1 +
 drivers/usb/mtu3/Kconfig     | 20 ++++++++++++++++++++
 drivers/usb/mtu3/Makefile    | 10 +++++-----
 drivers/usb/mtu3/mtu3_dr.h   |  4 ++--
 drivers/usb/mtu3/mtu3_plat.c |  8 ++++----
 5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba33281..a8ba71e657a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_SPL_DM_RESET) += reset/
 obj-$(CONFIG_SPL_MUSB_NEW) += usb/musb-new/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/common/
+obj-$(CONFIG_SPL_USB_MTU3) += usb/mtu3/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/udc/
 obj-$(CONFIG_SPL_WATCHDOG) += watchdog/
 obj-$(CONFIG_SPL_USB_HOST) += usb/host/
diff --git a/drivers/usb/mtu3/Kconfig b/drivers/usb/mtu3/Kconfig
index 5ec498ec953..503c25ebd2f 100644
--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@ -42,3 +42,23 @@ config USB_MTU3_DEBUG
 	  Say Y here to enable debugging messages in the MTU3 Driver.
 
 endif
+
+config SPL_USB_MTU3
+	bool "MediaTek USB3 controller support in SPL"
+	depends on ARCH_MEDIATEK
+	depends on SPL_DM_USB_GADGET && SPL_USB_GADGET
+	help
+	  Enable the MediaTek USB3 controller in SPL. The SPL driver currently
+	  supports peripheral mode only.
+
+if SPL_USB_MTU3
+
+config SPL_USB_MTU3_GADGET
+	bool "Gadget mode in SPL"
+	default y
+	select USB_GADGET_DUALSPEED
+	help
+	  Enable the MTU3 peripheral controller in SPL so USB gadget
+	  functions can use it before U-Boot proper starts.
+
+endif
diff --git a/drivers/usb/mtu3/Makefile b/drivers/usb/mtu3/Makefile
index 234f3a380a3..d1f0cd24875 100644
--- a/drivers/usb/mtu3/Makefile
+++ b/drivers/usb/mtu3/Makefile
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
-ccflags-$(CONFIG_USB_MTU3_DEBUG)	+= -DDEBUG
+ccflags-$(CONFIG_$(PHASE_)USB_MTU3_DEBUG)	+= -DDEBUG
 
-obj-$(CONFIG_USB_MTU3)	+= mtu3.o
+obj-$(CONFIG_$(PHASE_)USB_MTU3)	+= mtu3.o
 
 mtu3-y	:= mtu3_plat.o
 
-obj-$(CONFIG_USB_MTU3_GADGET)	+= mtu3_core.o mtu3_gadget_ep0.o mtu3_gadget.o
-obj-$(CONFIG_USB_MTU3_GADGET)	+= mtu3_qmu.o
-obj-$(CONFIG_USB_MTU3_HOST)	+= mtu3_host.o
+obj-$(CONFIG_$(PHASE_)USB_MTU3_GADGET) += mtu3_core.o mtu3_gadget_ep0.o
+obj-$(CONFIG_$(PHASE_)USB_MTU3_GADGET) += mtu3_gadget.o mtu3_qmu.o
+obj-$(CONFIG_$(PHASE_)USB_MTU3_HOST) += mtu3_host.o
diff --git a/drivers/usb/mtu3/mtu3_dr.h b/drivers/usb/mtu3/mtu3_dr.h
index ec0e50c04ca..89fbde03625 100644
--- a/drivers/usb/mtu3/mtu3_dr.h
+++ b/drivers/usb/mtu3/mtu3_dr.h
@@ -10,7 +10,7 @@
 #ifndef _MTU3_DR_H_
 #define _MTU3_DR_H_
 
-#if IS_ENABLED(CONFIG_USB_MTU3_HOST)
+#if CONFIG_IS_ENABLED(USB_MTU3_HOST)
 
 int ssusb_host_init(struct ssusb_mtk *ssusb);
 void ssusb_host_exit(struct ssusb_mtk *ssusb);
@@ -27,7 +27,7 @@ static inline void ssusb_host_exit(struct ssusb_mtk *ssusb)
 
 #endif
 
-#if IS_ENABLED(CONFIG_USB_MTU3_GADGET)
+#if CONFIG_IS_ENABLED(USB_MTU3_GADGET)
 int ssusb_gadget_init(struct ssusb_mtk *ssusb);
 void ssusb_gadget_exit(struct ssusb_mtk *ssusb);
 irqreturn_t mtu3_irq(int irq, void *data);
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index ec920eaf166..73107167ada 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -439,17 +439,17 @@ static int mtu3_glue_bind(struct udevice *parent)
 
 	switch (dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		if (IS_ENABLED(CONFIG_USB_MTU3_GADGET))
+		if (CONFIG_IS_ENABLED(USB_MTU3_GADGET))
 			return mtu3_bind_gadget(parent);
 		break;
 	case USB_DR_MODE_HOST:
-		if (IS_ENABLED(CONFIG_USB_MTU3_HOST))
+		if (CONFIG_IS_ENABLED(USB_MTU3_HOST))
 			return mtu3_bind_host(parent);
 		break;
 	case USB_DR_MODE_OTG:
-		if (IS_ENABLED(CONFIG_USB_MTU3_GADGET))
+		if (CONFIG_IS_ENABLED(USB_MTU3_GADGET))
 			return mtu3_bind_gadget(parent);
-		if (IS_ENABLED(CONFIG_USB_MTU3_HOST))
+		if (CONFIG_IS_ENABLED(USB_MTU3_HOST))
 			return mtu3_bind_host(parent);
 		break;
 	default:

-- 
2.55.0

