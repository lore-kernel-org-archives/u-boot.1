Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DD8E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A0486D83;
	Sat,  7 Oct 2023 23:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AI7v/7xl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1105786DE6; Sat,  7 Oct 2023 23:57:01 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29E7686ACA
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-277317a0528so736187a91.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696715814; x=1697320614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SlzUCAG+X3RYsx99+y5y7iKnWsHLdFpQp6A2PXqaGfw=;
 b=AI7v/7xlAgUknJRbg1beSTHfzu30XCbSX+muVfy/WEZ7IXUuFddHbHTLSYTXCvL2Nu
 0odgcRnkl90FzujctLy9bcMto3Xm9ae046IVMZ7AwlaHVPu2M7LQ42/z+bjkbAjP3tVk
 pdYU3AiiiTZbxXUZqYwm+ieYDH2s9ZwoE6LCW2FPtnWmiZSmITa/qsTFCwoD0uVGNSba
 ijKM3wmdOiab6FbqHARz8RNhqKUI1U0V98pY1o7PqTxN8XmiIIUmuKLf6i8sol1Sf3zg
 EnwC5R0jVpru8eWH8oeuQifggG6COH5AdQkPUGhGawjOa8HPa2LvmA+4tVsmhC+dWp33
 59Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696715814; x=1697320614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SlzUCAG+X3RYsx99+y5y7iKnWsHLdFpQp6A2PXqaGfw=;
 b=q98EWEYTYbVcZJXJ6XhB9NcfqlNV42lGQo/U/bs72vlDQHmuH/dFxSX/NoWTTQkCaW
 NPOONETBTCl6k/aZE4mOSo89bPLaGhJlteTYlh5LhmDJK45usbDk+ZCopBkgK4U3FJJY
 hc7bbAqDF7o1aXgeAS/Fbd/M2qhLXx2FyDsQQPdthDOIVhkl7H8isUOF+jdMR2lB2ZrW
 8w46c5xHBr8R4duGf9HFw41XhCzwPdmWQOt3f8aNVAFBxQElm5cxt9Au8LndiCedHbts
 Ey5UkWd8XylEQUfEk9qg01JYo1g6LjvIoUsUuSlTKlmL0TX027aZV4sg8WcLg3+JkQ9e
 yYlQ==
X-Gm-Message-State: AOJu0YxNsDpOFm0gJcupgYJjkbSzZF4XVOJ5iHyl39HGWpQf+o5XLIo/
 KyEq8TBaIkXPheocsZ5lRmuTz0h7hlg=
X-Google-Smtp-Source: AGHT+IEM0H4fOIsjYJiXF6anlaNxfQK2Z1x6kK2c25dlZ41O0+SDlHXXnwAYYrNKDLB16hSsUC/xRA==
X-Received: by 2002:a17:902:ce86:b0:1c4:2b71:7dc9 with SMTP id
 f6-20020a170902ce8600b001c42b717dc9mr13077031plg.4.1696715814200; 
 Sat, 07 Oct 2023 14:56:54 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d82a:6c03:129b:26f2])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a170902ecc400b001c74df14e6esm6346487plh.51.2023.10.07.14.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 14:56:53 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: sbabic@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/3] usb: ehci: mxs: Fix the USB node pointer retrieval
Date: Sat,  7 Oct 2023 18:56:46 -0300
Message-Id: <20231007215648.3156877-1-festevam@gmail.com>
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
---
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

