Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFBAC55174
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 13:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72C5C6070C;
	Sat,  8 Aug 2026 13:40:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kqcodhrQRwLm; Sat,  8 Aug 2026 13:40:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 64D99606DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786196419;
	bh=6vqgiLHQ0rfLg9z+V+Xhc7DBW68KMi5MaKDZpTttuCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vnAhDC5laK9Esqie9OAUdxwERMW0N7i3RCvv6RvHFzxkA/ee0Pd5fhHT/LdsmoqVO
	 n/1aISa9WfbF42rDl1x2U82vq6TQeomddiPwcfx3zsJ20T3klODmtiVKm0qetadT2R
	 QC67/QBTX56Ksx4OUKIb0fbe4Yi+m8lD8hY3KHY7lhrmx89oCRe0puF8PH60jrp9hW
	 JkVwz8HpYytDbKB2GK3wUh/gkrb9G3Ac/RTUNkKLs9M/YXbv4JGtcAju6dt/t6cmvV
	 E2Y6imynprYB+j74BdgDtPCmIHbJ04fc/agQBXmikx3bV/Zj74rpT1zFu+R5Z/w8lA
	 6dUaj1HUWqx1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64D99606DF;
	Sat,  8 Aug 2026 13:40:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CDE262F5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 709C140137
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:40:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dyhwzo0nbf16 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 13:40:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0B7854004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B7854004B
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B7854004B
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:40:13 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so219018f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 06:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786196412; x=1786801212;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6vqgiLHQ0rfLg9z+V+Xhc7DBW68KMi5MaKDZpTttuCQ=;
 b=PQBnPJVsgt0/GvNHE7T+zR5h7YgGD2GuwwF6uV+GpMhXQ9obW48d9mpoULekb/XOlj
 ZvxbCAO+3omNJ3tUXUk1vyxro06WoW75bED1ZHR//yJz7ZHOLKk+PJMtm9LIJthJ4GZJ
 zWJUvqCwuWCHSsoO+d1tiyxvPH48fdelKDa8SOzSMoWn6dvxXHumoVJ3XDLd592eC/hh
 YYJ4Ln+VisnmyYjRnsLlzmHrZcVrnGvprNIvTibPbCd45nzk6cL/bYFm2YjtLcLpwiJM
 AMzaK+7dP80fK0mjr2X7xtwMsUtui5Mk/+cMeWuYMcA/P3MQZy5uoOdGKnCopXgkuK5E
 bQ9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxjQ1/nIbWWcbMllD9TbaIrHTC6RviV7DKxm8Qs26cV0YsfORYxmBZUv/FrMccg+lIbRw5m10=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxYP7LytALA+1l4dRTrYH/7fwk6j8veaGIqSw06OooCQhjeiC65
 9eKyxKi0xT9E4MuNMeb0IPCvniYbKIQ/K9mvhhS3iYJTVCxuZy8H17SS/war8fOlvKQ=
X-Gm-Gg: AR+sD114FbVK8EJuhy69OJScZMK1Gt65ZXsPOySzPHDnEgnrjXz0H8YzU/sImToKcPb
 ZYNkXgnyF0lu8EcosLJS8VpCQ4jk3hbWEDY0otEkNVPFyf2gGcsSn3N84LfMH9rVhqh2HCZjSYd
 hmYVSdw9oEnFGEoihLlYNygLyZiolRzoYDVXxOZBNAAyQGDmCZJfPgHTpoa69aIc2QBh6fRbrOq
 36DNKIP0GJkpKzQiZTiaAtDXWSLXSUh25TXgtGgCm+Er5xeuNCaheRi/RKHV96ueN77nnOgsUwA
 wP1jAZe1Wlp9/u62pGRblLvCCsPiVmRws4pojmb5+kC2OV3+2aZbCrjNajDRwoiSebqqPMoeY3P
 Lb8recCI9yvNTUrjwhJVMsM0XcULfgqUEY61+VE+VEpeM+K8D32lC3ygoLgI4nngw8q4h3SK4gv
 X4DB9frC0raFNP/ecQht40rVFLxvH5JqMvFnEYTtP6+3NwtTHl0EHbOdgiMgyjwbwuyx5EWCPG+
 lvj4AdvHZfDRbaSR/bgIAjNTNaEid3/hJuP7ThxFFd7dpkofy9G
X-Received: by 2002:a5d:5f46:0:b0:47f:fb57:8c7f with SMTP id
 ffacd0b85a97d-47ffb579060mr23511753f8f.29.1786196411674; 
 Sat, 08 Aug 2026 06:40:11 -0700 (PDT)
Received: from [127.0.0.1] (static-226232.rol.raiffeisen.net.
 [195.254.226.232]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021506cbsm15587361f8f.14.2026.08.08.06.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:40:11 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sat, 08 Aug 2026 15:40:00 +0200
Subject: [PATCH v7 3/3] usb: mtu3: add SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-ccaione-upstream-mtu3-spl-gadget-v7-3-ed659a79a918@baylibre.com>
References: <20260808-ccaione-upstream-mtu3-spl-gadget-v7-0-ed659a79a918@baylibre.com>
In-Reply-To: <20260808-ccaione-upstream-mtu3-spl-gadget-v7-0-ed659a79a918@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786196412; x=1786801212;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6vqgiLHQ0rfLg9z+V+Xhc7DBW68KMi5MaKDZpTttuCQ=;
 b=FMn/j0D8tEYZM4xuCa3idhrnLkqpRLThVQulwN8ot5zvx3LjXZKG0W4CgHAKJxIPC0
 G3hci93bTNRbdz2mITXGNXdVSNHEWKYHmD0hB4OnkfF6cWjl8jBOvMNc2J9kkvcuj3G3
 oWTkmTMcWufKlaSaheNYsP0Nd/iX73XQSiDimUUOM2D/2Pxxe9UvehRzamKRiwtO8hQA
 1Tb81yy+/vyVcuBlBxl618Winh4TWs8+stHVdRe59UCBemqha0JXtMAFsPLucbEmP5hw
 /TkQ4hi0F84D75vbF6r1xK1tGV1rWe1C7ZW0RRBWZPB14lHf+siaNIAi3oKEHA8aKRC8
 Ip2Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FMn/j0D8
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

MediaTek platforms may need the MTU3 controller before U-Boot proper is
available, but the driver is currently selected and built only with the
main U-Boot configuration symbols.

Add an explicit SPL controller option with host and gadget modes. Make
the driver build and its role checks phase-aware so each phase can select
the MTU3 role it needs without coupling it to the U-Boot proper controller
configuration.

The upstream binding locates the xHCI child registers through the parent
ranges property. Select SPL_OF_TRANSLATE for host mode so SPL can resolve
that address before mapping it.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/Makefile             |  3 ++-
 drivers/usb/mtu3/Kconfig     | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/mtu3/Makefile    | 10 +++++-----
 drivers/usb/mtu3/mtu3_dr.h   |  4 ++--
 drivers/usb/mtu3/mtu3_plat.c |  8 ++++----
 5 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba33281..4c7ba741acb 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -66,7 +66,8 @@ obj-$(CONFIG_DRAM_SUN20I_D1) += ram/
 obj-$(CONFIG_SPL_DM_RESET) += reset/
 obj-$(CONFIG_SPL_MUSB_NEW) += usb/musb-new/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/
-obj-$(CONFIG_SPL_USB_GADGET) += usb/common/
+obj-$(CONFIG_SPL_DM_USB) += usb/common/
+obj-$(CONFIG_SPL_USB_MTU3) += usb/mtu3/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/udc/
 obj-$(CONFIG_SPL_WATCHDOG) += watchdog/
 obj-$(CONFIG_SPL_USB_HOST) += usb/host/
diff --git a/drivers/usb/mtu3/Kconfig b/drivers/usb/mtu3/Kconfig
index 5ec498ec953..8623adfdf51 100644
--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@ -42,3 +42,42 @@ config USB_MTU3_DEBUG
 	  Say Y here to enable debugging messages in the MTU3 Driver.
 
 endif
+
+config SPL_USB_MTU3
+	bool "MediaTek USB3 controller support in SPL"
+	depends on ARCH_MEDIATEK
+	depends on SPL_DM_USB
+	depends on SPL_USB_HOST || (SPL_DM_USB_GADGET && SPL_USB_GADGET)
+	help
+	  Enable the MediaTek USB3 controller in SPL. Select host or peripheral
+	  mode below.
+
+if SPL_USB_MTU3
+
+choice
+	bool "MTU3 SPL Mode Selection"
+	default SPL_USB_MTU3_GADGET if SPL_USB_GADGET
+	default SPL_USB_MTU3_HOST if (SPL_USB_HOST && !SPL_USB_GADGET)
+	help
+	  Select whether the MTU3 controller operates as an xHCI host or a USB
+	  peripheral in SPL.
+
+config SPL_USB_MTU3_HOST
+	bool "Host mode in SPL"
+	depends on SPL_USB_HOST && USB_XHCI_HCD
+	select SPL_OF_TRANSLATE
+	help
+	  Enable the MTU3 xHCI host controller in SPL so USB devices can be
+	  accessed before U-Boot proper starts.
+
+config SPL_USB_MTU3_GADGET
+	bool "Gadget mode in SPL"
+	depends on SPL_DM_USB_GADGET && SPL_USB_GADGET
+	select USB_GADGET_DUALSPEED
+	help
+	  Enable the MTU3 peripheral controller in SPL so USB gadget
+	  functions can use it before U-Boot proper starts.
+
+endchoice
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

