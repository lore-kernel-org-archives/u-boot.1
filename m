Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11975C4451B
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 10:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7B780287;
	Sat, 18 Jul 2026 12:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="LnPdAzz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA74E80517; Sat, 18 Jul 2026 12:38:06 +0200 (CEST)
Received: from mail-wr2-x00.google.com (mail-wr2-x00.google.com
 [IPv6:2a00:1450:4864:30::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42A7F80117
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 12:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wr2-x00.google.com with SMTP id
 ffacd0b85a97d-46e260f9e57so1680851f8f.0
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784371082; x=1784975882; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DMYvRGTH7NSWB/9xyncSNm593Xg068J7/7MLgsjk1bo=;
 b=LnPdAzz9C248Kfcpo1emLQJja5bzm+baMt1737EXXenGhHCrH7+5iE6k6x0qjRZ2kT
 1lCQfyn0niQZebQMMr9Lx84TFhQ3ecYMomj3xbCFnZxqr3k79ujq2wxwKgLboDaKDeK1
 ChFNZ+Et651IaqNpdLHtwhPKYHJcyaFFOJ+0TjDM7VPJWTplEG5Z5VObYp46fJoJFipd
 arYh1TFWaPPPnYi1Cuo3ufGESfd4e/QFkjuqLrb91HEY1HuSxS6m4WIUht+sH2gMV709
 glFIILuaTvQ5nO4jAsqmpKo+N3IJ1sbt54h7c6BMFgy9MgbdFpDfJpwuO7xb0bd4PIrJ
 8FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784371082; x=1784975882;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DMYvRGTH7NSWB/9xyncSNm593Xg068J7/7MLgsjk1bo=;
 b=J06gCYOk9+YbavAq8ETk/YQOhZY+SqNLet0iQiIyCb4DYA+vB92OaPqSwXhy+GzlWT
 8eMUELPVUrGiJ88AJ91iNTAYZBhC7eQ8KdIf6jgaVZsoVJBHgwTuqsj797IawbrFErk0
 aBW0kE3dow3ZosWcyc2zhmONGD6WqykKcsFPaJc2oywQlrLzfZ7h5nIt6WJmfQJGxSGD
 WXn01YCpJTGQwxCI9cI56Eru+uOIt2UoUNo3es7SeHk1rYfXT6xxgMaeDpLLM9TPFw/R
 +Djy/4l1CJzcxvuzSyHJjFVm1QC9CFLFna0qZ+QJuJ32QtbK4riZXY0NiQjXq47W15OB
 llJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYvNbN3Ksbi/c/3s9vxXTo9jNtOXP/d1uxppUXPPB1bUA0HuzkVpM5zpuB1czYrTPDpN1BIGI=@lists.denx.de
X-Gm-Message-State: AOJu0YztVJ9Ig+Ftij2jdezCNvTFJyXoi5NeFsy71FMMYG1DuoVRaidy
 scdC31exRhvbGhTNeeG6R8TYYdSbA5sjCRnBWU4z2nZb9LNc9eeeiSXgcD6MvlAS8jA=
X-Gm-Gg: AfdE7ckSE+dNJqvfl1845cpLL4XeuoJ5yCIM92ChPTx9yGwSQh+tpIIYfD6X2YPNbhM
 ZRbmJYZaIn85B59GRjEM4fN2Sc7NDtyrNNBbIO4IZlKkuHJINKdd/SegvXn6jPrOm5FF3UDBFvz
 jIfaru7m4yU5XXuAJX2i7qPTfehF7hRu3OxfMERcN6dI1HwjWxjatSjfNhjHROO6BjtGXhdRftR
 tb70L5D8IPvU823jWeF5L8puAW/CCu1Ij43WDkYMKvrHDuKvj6wQ5VQr8iYim+z496Pn6x8UYgB
 W0aVUtjrvu7i+Sw4JWsTklKSuhHaziWP670P1y2wMpa5eEGls9ExTDO+/u8fRZXVTSKGVyQm1Bu
 H+alkd56Zv1YAemAND/GbqrmU0jfhOKVUow/Zp4s3kyCX96fLsbJtvqSbUoIZLVSrT2czo41o6e
 Q2w2JXOAjwt2qQUdNQbp+hrBUY0+TeHbVNtzXtROtXMfYs9SKtnHqqWwzRjBx3EoDcAP4Qeube8
 OtQIp76uoYsLLUF2f5+xQhkpaG1vcQ=
X-Received: by 2002:a05:6000:71e:b0:473:1ccc:15cc with SMTP id
 ffacd0b85a97d-47f622c57admr6876498f8f.0.1784371081662; 
 Sat, 18 Jul 2026 03:38:01 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-16-115-126.retail.telecomitalia.it. [79.16.115.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed244asm10269005f8f.20.2026.07.18.03.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 03:38:01 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sat, 18 Jul 2026 12:37:57 +0200
Subject: [PATCH v2] usb: mtu3: wait for TX FIFO to drain before disconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-ccaione-upstream-mtu3-tx-fifo-drain-v2-1-837345048224@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOSw6CMBRFt2I69pkWoRhH7sMw6OdVnhFK2kIgh
 L1bcAUOT3Jyz11ZxEAY2f20soATRfJ9huJ8YqZV/QuBbGZW8ELyWtRgjMoKwjjEFFB10KXxCmk
 GR86DDYp6cFhqKbEyAkuWl4aAjuaj8mx+HEf9RpP26d1oKSYfluPGJHbvv+IkQIC7yVpbZyrL+
 UOr5UM64MX4jjXbtn0Bo+3GEOsAAAA=
X-Change-ID: 20260717-ccaione-upstream-mtu3-tx-fifo-drain-fe4b66e5c1e4
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>
X-Mailer: b4 0.15.2
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

Fastboot unregisters the USB gadget from the completion callback of
its final OKAY response. MTU3 QMU can report that request complete
while bytes remain in the endpoint TX FIFO. Disabling the USB function
immediately can therefore disconnect the host before it receives the
response.

Before selecting the high-speed or SuperSpeed disconnect operation, poll
the FIFO state of enabled IN endpoints that have no pending requests.
Bound the wait to 1 ms. If a FIFO does not drain, reset its endpoint,
force the disconnect, and propagate -ETIMEDOUT through the gadget pullup
operation. Endpoints with pending requests are skipped so an ordinary
disconnect does not wait for an active transfer.

Fixes: e09b88cd083d ("usb: add MediaTek USB3 DRD driver")
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v2:
- Reset TX endpoints whose FIFO does not drain
- Propagate the drain timeout through the gadget pullup operation
- Link to v1: https://patch.msgid.link/20260717-ccaione-upstream-mtu3-tx-fifo-drain-v1-1-f867bdfc5d00@baylibre.com
---
 drivers/usb/mtu3/mtu3.h        |  2 +-
 drivers/usb/mtu3/mtu3_core.c   | 39 ++++++++++++++++++++++++++++++++++++++-
 drivers/usb/mtu3/mtu3_gadget.c |  5 +++--
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 8a7ae83ee99..c812cd6fdcf 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -408,7 +408,7 @@ void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set);
 void mtu3_ep0_setup(struct mtu3 *mtu);
 void mtu3_start(struct mtu3 *mtu);
 void mtu3_stop(struct mtu3 *mtu);
-void mtu3_dev_on_off(struct mtu3 *mtu, int is_on);
+int mtu3_dev_on_off(struct mtu3 *mtu, int is_on);
 void mtu3_set_speed(struct mtu3 *mtu, enum usb_device_speed speed);
 
 int mtu3_gadget_setup(struct mtu3 *mtu);
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 2f5cc9b1480..da5967ba06a 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -10,10 +10,13 @@
 
 #include <linux/log2.h>
 #include <linux/bitmap.h>
+#include <linux/iopoll.h>
 
 #include "mtu3.h"
 #include "mtu3_dr.h"
 
+#define MTU3_TX_FIFO_DRAIN_TIMEOUT_US	1000
+
 static int ep_fifo_alloc(struct mtu3_ep *mep, u32 seg_size)
 {
 	struct mtu3_fifo_info *fifo = mep->fifo;
@@ -226,6 +229,32 @@ static void mtu3_ep_reset(struct mtu3_ep *mep)
 	mtu3_clrbits(mtu->mac_base, U3D_EP_RST, rst_bit);
 }
 
+static int mtu3_wait_for_tx_fifo_empty(struct mtu3 *mtu)
+{
+	struct mtu3_ep *mep;
+	u32 value;
+	int ret = 0;
+	int i;
+
+	for (i = 1; i < mtu->num_eps; i++) {
+		mep = mtu->in_eps + i;
+		if (!(mep->flags & MTU3_EP_ENABLED) ||
+		    !list_empty(&mep->req_list))
+			continue;
+
+		if (readl_poll_timeout(mtu->mac_base + MU3D_EP_TXCR0(i),
+				       value, value & TX_FIFOEMPTY,
+				       MTU3_TX_FIFO_DRAIN_TIMEOUT_US)) {
+			dev_warn(mtu->dev, "%s TX FIFO did not drain\n",
+				 mep->name);
+			mtu3_ep_reset(mep);
+			ret = -ETIMEDOUT;
+		}
+	}
+
+	return ret;
+}
+
 /* set/clear the stall and toggle bits for non-ep0 */
 void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
 {
@@ -261,8 +290,14 @@ void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
 		set ? "SEND STALL" : "CLEAR STALL, with EP RESET");
 }
 
-void mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
+int mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
 {
+	int ret = 0;
+
+	/* QMU completion may precede transmission from the TX FIFO. */
+	if (!is_on)
+		ret = mtu3_wait_for_tx_fifo_empty(mtu);
+
 	if (mtu->is_u3_ip && mtu->speed >= USB_SPEED_SUPER)
 		mtu3_ss_func_set(mtu, is_on);
 	else
@@ -270,6 +305,8 @@ void mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
 
 	dev_info(mtu->dev, "gadget (%s) pullup D%s\n",
 		 usb_speed_string(mtu->speed), is_on ? "+" : "-");
+
+	return ret;
 }
 
 void mtu3_start(struct mtu3 *mtu)
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index 027b7e61113..da633faae7b 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -451,6 +451,7 @@ static int mtu3_gadget_pullup(struct usb_gadget *gadget, int is_on)
 {
 	struct mtu3 *mtu = gadget_to_mtu3(gadget);
 	unsigned long flags;
+	int ret = 0;
 
 	dev_dbg(mtu->dev, "%s (%s) for %sactive device\n", __func__,
 		is_on ? "on" : "off", mtu->is_active ? "" : "in");
@@ -464,12 +465,12 @@ static int mtu3_gadget_pullup(struct usb_gadget *gadget, int is_on)
 		mtu->softconnect = is_on;
 	} else if (is_on != mtu->softconnect) {
 		mtu->softconnect = is_on;
-		mtu3_dev_on_off(mtu, is_on);
+		ret = mtu3_dev_on_off(mtu, is_on);
 	}
 
 	spin_unlock_irqrestore(&mtu->lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static int mtu3_gadget_start(struct usb_gadget *gadget,

---
base-commit: 96c308b8d2a6a1496c0a7366db9a7becf42d2454
change-id: 20260717-ccaione-upstream-mtu3-tx-fifo-drain-fe4b66e5c1e4

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

