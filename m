Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3762BC4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC08884119;
	Mon, 20 Jul 2026 10:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="TBJ9TC6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED4E78460E; Mon, 20 Jul 2026 10:04:07 +0200 (CEST)
Received: from mail-wm2-x08.google.com (mail-wm2-x08.google.com
 [IPv6:2a00:1450:4864:31::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F88182991
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wm2-x08.google.com with SMTP id
 5b1f17b1804b1-49550b004f9so6289015e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784534645; x=1785139445; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JqQ9qHHdKPkI2AgFF55q4lsrQKdJOdtxR1rmQ9NO+dI=;
 b=TBJ9TC6Gg1J92uSH1vUWdcdlbRP7RLpDSr/GByhDGmKk68RDVkWwc4Q/aSvc9XkkAT
 quw073by4XWqqert4PASY0wX0vzBmHAZi3hzyi8F+w5Su0ClkOIqx/mCxhO6s6WFuXi3
 jzaf4r5Y/OFGVEnEZooQH/EO1rm0dlaQG8ZEyaCrqT0vIzeJd2QZjGJtHanAJ2hv8mSz
 bdjzihPc1ugVFnqGGPRmnCoaS5WYQU+xd9r61JPAUsFMRG2rWC8Bv8Tj+r41JqrBKd4F
 rJlAyIXLYpydGrfr/ZLs07jZ+FXKZaIjA+J2PbbtWOzzwquJIOX/lImgWP7jMxV6YEbg
 QOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534645; x=1785139445;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JqQ9qHHdKPkI2AgFF55q4lsrQKdJOdtxR1rmQ9NO+dI=;
 b=nxbfg/LZu6jAKT95PjSHx7STynfaJLpcXQfLY79gq8lNACgoMuaM+4KiYEG/vwvQFC
 a1cEpkz1fskUs6s5FAawnH0Gk/EHnmodGp1oO59XOE6/yeeYgnxqESAUgdG2tBub5mQS
 dMQ5JG4ykKkBiJC3gRo3UgoFIuqfZuuJbcexS4sCI4RGg/3QdKtSWxSOLEWywYVanDj1
 Y5GBpDkyYLMepjBFOl7+WI1op1L8Vhp0mwDGB5smTo+vR+W38FD/TYRZwbfEUfX2SIYE
 ihLXLJ6YHjPvinAuUZ1zLrqWRxHF0Hqo/sRi+Oj0r+6tulVTbqacByN7jFRZU3jT7WTO
 lrTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYYzgrAPJW1MlN2QCLY7FHNYD/2bPV2h4T2mf07jNzM8NloWeEuPpK98tB8QlHuTByDbKiCys=@lists.denx.de
X-Gm-Message-State: AOJu0YxlwnCbbz+Yz5utW42hQVPAEZ8wVK8Ueu5YZ16rqEyaVldIfhnp
 xu5WombukHSxCCjfGn5RcoPrh1zTmtOx76SQIY5bWHWvvcL0NOlRe5tLcHD+ohQQA7A=
X-Gm-Gg: AfdE7cl6RX92XxKR+8fTl0IiEMd8AqyygimWJHx273vYQxsd8H04sOt47ZPBltAPEC1
 yeLMBdpSUW3Z8bhF3baA3w6gjPDonKx6tFALjTV9rfQ/iDMJKs4ppg6II/Ojs3BPdUAgVOg5BKh
 MXskXhR71AP9EkZvz9Gp/e73nt/FwrczABx/G3hihnHM81gyNgnWby2ViBnJQ2QKisbFBeqM15y
 1mmebSTBjEoGsek+lwBXjaF+WUZaqLRlxUsbMyKfV0d0IIffaDnOa9aox26KiOJIkYxuem1Fnf4
 VjhyeoIaeBn0s61mjLmF04KWf9tpLJ7a9hjQXtbwFF4DrbMZg1IsfxxP7IEM6MmQcT54UGRNdg8
 wV0zbEVPwgDPhrpCq844/h8OQJqWeBNOkcKVUmSITCLs1fgjaz3pXV+J7VIWzbCZgPFey7ksIjn
 KD/ls+ksLEvizCzIW/DGnCtdW1pbEh1giy/HkAjo3W/9ThZFrsSI/069jiNJz/d8TsHbmXQ7vho
 M2HDCva
X-Received: by 2002:a05:600c:2156:b0:493:f822:ac5e with SMTP id
 5b1f17b1804b1-4954a411570mr117401485e9.23.1784534644687; 
 Mon, 20 Jul 2026 01:04:04 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2b87c6sm467532405e9.7.2026.07.20.01.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:04:04 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 20 Jul 2026 10:03:58 +0200
Subject: [PATCH v3] usb: mtu3: wait for TX FIFO to drain before disconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOyw7CIBBFf8WwdgxQ+ogr/8O4ADroGFsaoE2N6
 b9LdWNc6fIkN+fcB4sYCCPbbx4s4ESRfJ+h2G6Yvej+jEBtZia5rHgtarBW5wnCOMQUUHfQpbG
 ANIMj56ENmnpwqExVYWkFKpZNQ0BH86tyPL05juaKNq3qdXGhmHy4v25MYt39V5wECHBNVZvW2
 bLl/GD0/UYm4M76jq3RSX5qm9+0Mmuboi5UyVUjpfrSLsvyBC85JspCAQAA
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
Changes in v3:
- Return the value of readl_poll_timeout on error
- Link to v2: https://patch.msgid.link/20260718-ccaione-upstream-mtu3-tx-fifo-drain-v2-1-837345048224@baylibre.com

Changes in v2:
- Reset TX endpoints whose FIFO does not drain
- Propagate the drain timeout through the gadget pullup operation
- Link to v1: https://patch.msgid.link/20260717-ccaione-upstream-mtu3-tx-fifo-drain-v1-1-f867bdfc5d00@baylibre.com
---
 drivers/usb/mtu3/mtu3.h        |  2 +-
 drivers/usb/mtu3/mtu3_core.c   | 42 +++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/mtu3/mtu3_gadget.c |  5 +++--
 3 files changed, 45 insertions(+), 4 deletions(-)

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
index 2f5cc9b1480..d9df55ac5fe 100644
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
@@ -226,6 +229,34 @@ static void mtu3_ep_reset(struct mtu3_ep *mep)
 	mtu3_clrbits(mtu->mac_base, U3D_EP_RST, rst_bit);
 }
 
+static int mtu3_wait_for_tx_fifo_empty(struct mtu3 *mtu)
+{
+	struct mtu3_ep *mep;
+	u32 value;
+	int err;
+	int ret = 0;
+	int i;
+
+	for (i = 1; i < mtu->num_eps; i++) {
+		mep = mtu->in_eps + i;
+		if (!(mep->flags & MTU3_EP_ENABLED) ||
+		    !list_empty(&mep->req_list))
+			continue;
+
+		err = readl_poll_timeout(mtu->mac_base + MU3D_EP_TXCR0(i),
+					 value, value & TX_FIFOEMPTY,
+					 MTU3_TX_FIFO_DRAIN_TIMEOUT_US);
+		if (err) {
+			dev_warn(mtu->dev, "%s TX FIFO did not drain\n",
+				 mep->name);
+			mtu3_ep_reset(mep);
+			ret = err;
+		}
+	}
+
+	return ret;
+}
+
 /* set/clear the stall and toggle bits for non-ep0 */
 void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
 {
@@ -261,8 +292,15 @@ void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
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
+	/* Force the disconnect after a timeout; the failed endpoint was reset. */
 	if (mtu->is_u3_ip && mtu->speed >= USB_SPEED_SUPER)
 		mtu3_ss_func_set(mtu, is_on);
 	else
@@ -270,6 +308,8 @@ void mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
 
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

