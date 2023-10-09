Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C7DE95A96
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 13:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EF7F864D4;
	Mon,  9 Oct 2023 15:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vdrw0GLH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A602D864A7; Mon,  9 Oct 2023 15:15:49 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C9A1864A6
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 15:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-690d935dbc2so888105b3a.1
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696857344; x=1697462144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jbtNkGW6W6rxKbzuaYUzragRS4T83AFRZg/3b47f4PY=;
 b=Vdrw0GLHrQgEkV5rcs7cfpcJRnHfizTlYJXrMzsU90HiJcJ9yI3h5lbf4bDOTpYDSf
 ijo6Tu/0p8hIgzD4SFZmqV90V/Ig3sxBZw8gFT3Ncf8qmtiy7nvm8XawlIJZ/f63KQp3
 xjkT9wMgSoFlA3+I4hfJYUFJCqL0g+xk9Q342MD82mEgnqaf1pmMwXdvmM+8F9Ixkzat
 hDp03XgsbAD9tDxuF8yTFZT/tUqIVJ1ZWMKmyjk0ETEUJqi28/EtYEw05RxlYzHHY9uz
 ivGfR4sA3PpCdziwSLUVTESKFy45CDYN5qHWwhfxbPiWGImRYxEZ80Nkc+H/4hCuYf9e
 +6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696857344; x=1697462144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jbtNkGW6W6rxKbzuaYUzragRS4T83AFRZg/3b47f4PY=;
 b=qsQ7zl8cmBSw1njdC77xp0vUopQPvmp+RpHH25NREhDkmFTfar3wKr4xxVExecCsWt
 tn4FsYCj31fTHhHwjqeO5mUnNCQRr4FdXQLnwcdfzWQDizAZs1mGGVsYJBEKcIEwrqK9
 /EavgRbHeRwKht4TdZopEdqszt4jlsGGOOaOuQu9EFN+i4c1FpnLUNNz40jPSMx64U5x
 MDNnYegC0A6e2YweDmmjVSVkLVhWNJihRQuunva4Mhz/CvpSI92/IVRNdQ6iqINe/fcs
 3zBsmBkNlCKwzlDAZv38Vm8jgK5W8QEPr5QPp7a9rNZz0Pzhg8fbnnvmTtHj4W/2zK7a
 X8tg==
X-Gm-Message-State: AOJu0YzJYSWUXlFhu8j4cEkme47doMqS1KllPUNbfC6JzkjnVw9d53VC
 bpsTa/dPsmCgmoNVcXyo4nBDx5Dbeu4=
X-Google-Smtp-Source: AGHT+IGyZLifpihXKFYiE81AfzGDE8GE3cJ7l0ummrGvAbKHTE3rJgX9TDPQoVCc3DKdSCLqUMgOZA==
X-Received: by 2002:a17:902:e74b:b0:1c7:1eed:10f2 with SMTP id
 p11-20020a170902e74b00b001c71eed10f2mr17632770plf.2.1696857344489; 
 Mon, 09 Oct 2023 06:15:44 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:22d5:b586:66b8:6e03])
 by smtp.gmail.com with ESMTPSA id
 r10-20020a170902be0a00b001c8a0879805sm4743965pls.206.2023.10.09.06.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 06:15:43 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: sbabic@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3 1/3] usb: ehci: mxs: Fix the USB node pointer retrieval
Date: Mon,  9 Oct 2023 10:15:34 -0300
Message-Id: <20231009131536.3475878-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Fabio Estevam <festevam@denx.de>

Use dev_ofnode() to retrieve the USB node pointer from the udevice
structure.

This fixes the following build error:

drivers/usb/host/ehci-mxs.c:143:38: error: 'struct udevice' has no member named 'node_'

Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Marek Vasut <marex@denx.de>
---
Changes since v2:
- None
Changes since v1:
- Only collected Marek's Reviewed-by tag.

 drivers/usb/host/ehci-mxs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-mxs.c b/drivers/usb/host/ehci-mxs.c
index 147b2fa145d6..092c79fd4bc5 100644
--- a/drivers/usb/host/ehci-mxs.c
+++ b/drivers/usb/host/ehci-mxs.c
@@ -136,11 +136,12 @@ static int ehci_usb_ofdata_to_platdata(struct udevice *dev)
 	struct usb_plat *plat = dev_get_plat(dev);
 	struct ehci_mxs_port *port = &priv->port;
 	u32 phandle, phy_reg, clk_reg, clk_id;
+	ofnode np = dev_ofnode(dev);
 	ofnode phy_node, clk_node;
 	const char *mode;
 	int ret;
 
-	mode = ofnode_read_string(dev->node_, "dr_mode");
+	mode = ofnode_read_string(np, "dr_mode");
 	if (mode) {
 		if (strcmp(mode, "peripheral") == 0)
 			plat->init_type = USB_INIT_DEVICE;
@@ -151,12 +152,12 @@ static int ehci_usb_ofdata_to_platdata(struct udevice *dev)
 	}
 
 	/* Read base address of the USB IP block */
-	ret = ofnode_read_u32(dev->node_, "reg", &port->usb_regs);
+	ret = ofnode_read_u32(np, "reg", &port->usb_regs);
 	if (ret)
 		return ret;
 
 	/* Read base address of the USB PHY IP block */
-	ret = ofnode_read_u32(dev->node_, "fsl,usbphy", &phandle);
+	ret = ofnode_read_u32(np, "fsl,usbphy", &phandle);
 	if (ret)
 		return ret;
 
-- 
2.34.1

