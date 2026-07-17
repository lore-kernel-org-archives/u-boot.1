Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70E8C44516
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A900084DBB;
	Fri, 17 Jul 2026 15:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="NJpj2K0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85DA684E03; Fri, 17 Jul 2026 15:05:36 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D9D784CC4
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so4519472f8f.0
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 06:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784293534; x=1784898334; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+/4SxXBMg5ReT/2EZVg8/3N4taSd37rMIk2oL2dYMq0=;
 b=NJpj2K0etROlf3pwIGyDl9YqKLsXUnq+Z7mqgPdgztQrDNXph8iMKyRypvMdOD1qw+
 4AclQs1cBagIqUh5/BlrR//noX3G1f6DC7Jd2tECC6i6N4ed47zJzL5QEokDM0Rt96E3
 9zHR/JFS+OyA86Gt0b6bxJBx23UZSzFchoNUWrq9dq4ugxT1W2glkUUMnSywi/clk75F
 AvcJsTWOj0k6+9smHqv0H8UwQiCmj6UBa4KM/SOLCKe3xdFV/IUzpjNO8fLXz0q/IAme
 VOeXKhRb3WpcorXVr1VO/PiNe/k7QwuBQYapp610gyIr/z5l6PjcpHs1NAlT5q48GEay
 kuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784293534; x=1784898334;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+/4SxXBMg5ReT/2EZVg8/3N4taSd37rMIk2oL2dYMq0=;
 b=bkRL+jDpY3+G+bqxcDT4t9gQ+lmnxQEF7uBy8fPYsdLZZZctfggjKxLwr4rFNWJom7
 lufXBFXDR1FM7E2sY6DFX+BGVjeI18N+n7uRNqeHgJep5gzvAfj5tXvS5ZrREg5SqIzM
 FxJ3f+VeV6+flLOcWXMWL5uV5fDK7n2F0iQ7IsxsBQxj7E1wTu36N5MuGwFtc2LVvccm
 us3bfO3KX6gIhVlWvbswhl6t7SAHzhD9J3Cv3orzSPQk+XhdQNXp+WNHndk07mTmmqnD
 hme59dbs5PjUbnb8ICh5xHSs3BVuPJSCyvDznXchIaUoRTQ8NsoMf3Q43ZO/O3VOrvDS
 8/7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpV3Sfty1VKig9Cn6eLq7/t34P6DSbz2CrHyYVwBkmZ0rgbTQo5eXRtcdGac60hIpI9ZSQVqyM=@lists.denx.de
X-Gm-Message-State: AOJu0YzC2enP1w2uJnhhZDcZtTAwilJRBxCMDas6SswU3wdOlwtnNkdB
 rnT+tB0ZPd0xXaC3xnkS3jfHDyvDX1ZOo8e5Mz4dljTQZj1X3DV/o/VhSupzklfz3abTWMnLbRN
 038bUF+gAnA==
X-Gm-Gg: AfdE7cklc0dPeY00JF8W9akObqYS/oQ+uozehvfD2pr+IUn71KaCHGiOL+uxoxVcHWP
 roju6SdBiE3eVVJZUfnH1/eCsOhKR/0gN0JIKYOdDQnTy+Hh61ORW2u+j6LafXZaXMS3XZnwxX0
 2fDxqWIVeCzJ3EMceRI4aJTxHiw/0QpCgKQBOhcoDQLPlqJTGrjw7JqiO9P7gKe756IWWad4H42
 hSNcvIpZEbUxo64GHAPMKu8mPtvA4mELc185e9VFzwdXS/qVKhWE4cIhrloxtEobJ5t0tMd94fP
 +W1FChVrGJPOBC3DTEobdWaPR1tgHhWJHCff3xoRv4u+UuEzAnd3FWYrp8bQjtDfatJNYGkmnfH
 HJYhtJC3F2vIp4kE3H+KU+JVC2MuBaYtU6tHBuVE75gS5XMbrAb+ysAlsEZlU6YjcDPHhlH//3I
 oJmN2TK73bZkdh8+EOX5GHf8K4ffTPl+PU0V3FhV0A2PwRH6FPZGlHsqlJZVhDhXxO5NdKZVJGU
 0+ZwHPSw2twUzgwQK+U
X-Received: by 2002:a05:6000:46ce:b0:46d:d5db:9b with SMTP id
 ffacd0b85a97d-47f6232edc2mr2534780f8f.47.1784293533783; 
 Fri, 17 Jul 2026 06:05:33 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-16-115-126.retail.telecomitalia.it. [79.16.115.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e52f81sm4064693f8f.9.2026.07.17.06.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 06:05:33 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 17 Jul 2026 15:05:20 +0200
Subject: [PATCH] usb: mtu3: wait for TX FIFO to drain before disconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-ccaione-upstream-mtu3-tx-fifo-drain-v1-1-f867bdfc5d00@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNUQrCMBCE4auUfXahqTUFryI+pOlEV2hasokUS
 u9u1McPhn92UiSB0rXZKeEtKkusMKeG/NPFB1imaurazraDGdh7VyfgsmpOcDPPuZw5bxwkLDw
 lJ5ED+tFaXLxBT7W0JgTZfi+3+99axhd8/qbpOD4aX6DDhwAAAA==
X-Change-ID: 20260717-ccaione-upstream-mtu3-tx-fifo-drain-fe4b66e5c1e4
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>
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

Before selecting the high-speed or SuperSpeed disconnect operation,
poll the FIFO state of enabled IN endpoints that have no pending
requests. Bound the wait to 1 ms and proceed with the disconnect on
timeout. Endpoints with pending requests are skipped so an ordinary
disconnect does not wait for an active transfer.

Fixes: e09b88cd083d ("usb: add MediaTek USB3 DRD driver")
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/usb/mtu3/mtu3_core.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 2f5cc9b1480..aad03f3265a 100644
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
@@ -66,6 +69,28 @@ static inline void mtu3_ss_func_set(struct mtu3 *mtu, bool enable)
 	dev_dbg(mtu->dev, "USB3_EN = %d\n", !!enable);
 }
 
+static void mtu3_wait_for_tx_fifo_empty(struct mtu3 *mtu)
+{
+	struct mtu3_ep *mep;
+	u32 value;
+	int ret;
+	int i;
+
+	for (i = 1; i < mtu->num_eps; i++) {
+		mep = mtu->in_eps + i;
+		if (!(mep->flags & MTU3_EP_ENABLED) ||
+		    !list_empty(&mep->req_list))
+			continue;
+
+		ret = readl_poll_timeout(mtu->mac_base + MU3D_EP_TXCR0(i),
+					 value, value & TX_FIFOEMPTY,
+					 MTU3_TX_FIFO_DRAIN_TIMEOUT_US);
+		if (ret)
+			dev_warn(mtu->dev, "%s TX FIFO did not drain\n",
+				 mep->name);
+	}
+}
+
 /* set/clear U3D HS device soft connect */
 static inline void mtu3_hs_softconn_set(struct mtu3 *mtu, bool enable)
 {
@@ -263,6 +288,10 @@ void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
 
 void mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
 {
+	/* QMU completion may precede transmission from the TX FIFO. */
+	if (!is_on)
+		mtu3_wait_for_tx_fifo_empty(mtu);
+
 	if (mtu->is_u3_ip && mtu->speed >= USB_SPEED_SUPER)
 		mtu3_ss_func_set(mtu, is_on);
 	else

---
base-commit: 96c308b8d2a6a1496c0a7366db9a7becf42d2454
change-id: 20260717-ccaione-upstream-mtu3-tx-fifo-drain-fe4b66e5c1e4

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

