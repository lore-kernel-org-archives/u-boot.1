Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C55E95A8E
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 20:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8753786C42;
	Sun,  8 Oct 2023 22:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BHedY/Sb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52AA586C26; Sun,  8 Oct 2023 22:59:50 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 279208655F
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 22:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6a4ff9d7e86so31005b3a.0
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696798786; x=1697403586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t/zbsEOuDlSi2h1QydwleLdLBqtYiLFnrmHGGKBYaA8=;
 b=BHedY/SbPOp1/6dkJDKzwvpwN2ipMRa4NfBOnpBhDzZllmWLLcsv6PClnP4jXDV5zR
 xOHSnkfDI55fulFskn1B1htBnuDdRdTrGGU+5r53SrEdSIltP0/LEA7JHDEFHM8pkDw8
 wPP/BwGlVxL09tFepj6QzB15kYvh0CDtLG78WVTUcsL4iImdamrmPk9AbZR/5M6WJZ8+
 VFVYNxzUK5/EwMF8H6cZJDK4oSLt+7jqzvH1hJgiLe9lSC8hteh6Mdk06vv0dVQNYPKY
 h9E6pVshb+xzTpGp9w7y678qWo0aE4Pb5YDfBdU1Yf+AjjUF8Dl5W1QbAVFSaCDVhnd0
 0hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696798786; x=1697403586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t/zbsEOuDlSi2h1QydwleLdLBqtYiLFnrmHGGKBYaA8=;
 b=tGKLJjrrVaXnywzYlyDMcoNsbUSA8Y5nL4l7QIQn0jrE4vyKmiEsUU48q9KBWNJIxh
 ipyzdMRspqPSAQ47nnp4nTTxlGiASHtJqGZ725suhthmVxo/WxnjZVgDyayXDHizkItC
 3oanZnm3vYrC+QosmRQ6NpvOCx/bEkpKiJb3nwejH1jLt3iIPCLRktZhrmtEJB7Xu7F6
 Mb1ttU4OfSlkDpuuEEJtFH2Khw5GG2z1PZ6QGC8Kl9XXZpMqOXmx7ASL+XR4TKN/ZrkW
 q/rKUCloLzcmkZPT4FMDE4FrmXqgEUP73MCJk7QIYIPOcw6yPZ+fXlMayv1dkXeN74lA
 ZUgw==
X-Gm-Message-State: AOJu0Ywvv4nUbytmRPd01rPwPgBs4YLbNJbQj7q1A5Gi4TB2E3I8s3j8
 +0TvyfjRRIEsq9ugNxBoqCw=
X-Google-Smtp-Source: AGHT+IFLvXoqIWINuO34tzkLPi2PEHtlnohuj/+d5oYkzfoPFV/O2iZNaO7AV/TitPdLvyitiEp59Q==
X-Received: by 2002:a05:6a00:398c:b0:68a:6cbe:35a7 with SMTP id
 fi12-20020a056a00398c00b0068a6cbe35a7mr15889438pfb.2.1696798786171; 
 Sun, 08 Oct 2023 13:59:46 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3eae:c867:7cc4:36a5])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a62bd0c000000b0068e49cb1692sm4919550pff.1.2023.10.08.13.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 13:59:45 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: sbabic@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 1/3] usb: ehci: mxs: Fix the USB node pointer retrieval
Date: Sun,  8 Oct 2023 17:59:37 -0300
Message-Id: <20231008205939.3332647-1-festevam@gmail.com>
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

