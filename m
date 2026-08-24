Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B668BC61DB7
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60FDD607ED;
	Mon, 24 Aug 2026 16:45:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QYKiSK3ZJkcW; Mon, 24 Aug 2026 16:45:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589948;
	bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SATlwWcqveX1SCR1005vPxYRcJogQAwibObyE/g/tTwHnjOMOjkc0YzKaRxJ3APX1
	 ZPC8A1p5kg2Mp7WoQCXyB1T2E2pVNPakNejAR5rSTRsbLRFaW9a3vRfc+bbLQVjMBc
	 j1k0e1yaxMqIod5qXj53Yp156I/AQyujUq/Xpw0PZpZooh3fipR9RfrukiEB8vcED3
	 ETQvdfhfzKNVRn5tijElneyVLakvtj0+JqAp9E8MZKMrlb+t8zu24rro+MLelx4ovv
	 ptBs3m1G+CWW2dTOZ2ir6s9fvmNn6EG0r03lM7acYTQ9ps6781myXAVlxL0bn5zT8k
	 Ij5oot0413HIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 778D06073B;
	Mon, 24 Aug 2026 16:45:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 27C6F396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DF5160627
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tSblRFMWIuPR for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=iW8kU0R8
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13CE5605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:06 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a59ec8f530so207465a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586184; x=1788190984;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
 b=iW8kU0R83nfBlzVVk2q8pxvutPk+FS8QqOlw1RVvm4rwbCKZLgDp9OOAqbZJS/dfAP
 nnf389A66WlPaUOlwfBc1D0oL24UfDltG9qfXkDMkOPBqZnMLZEHvnQiuK4Cg1UmiekQ
 zP8r3n4W9/yhOVqPjYOHoBvaWqy2Vumzca6zwwEWezsR4Nod6ACfemscQc+gHbqE7oGU
 f3zlyU1OJRbTlix9pkE8Pr4zqkzA9ROSzzMWhqz9/mjdMPFsA/Bg0IJyTKGOfWwK1Tpz
 EWgsgGKMo2cgTeXfQzzr2BEQvNxsQdo/F1hhTm5rbWw8H9nExL6mIy+1n8SIADeVU23S
 P4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586184; x=1788190984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
 b=FtlwuRyuOEFpmOAftAq/DuZGKtrDiMRXnO/S84JncbVCfIyrY44nffw82X8aFGTWbi
 XYFtQfM7fVBNmfEX7rSrK+iycSz3MnWLAv354uGKdGCOfMqLb4qsF8uqX0s53ZMZXsvU
 PWXTDRRtC+e3NyeL/ZGjK/fy9EA3UdoizPhl8+e2OYpA/tk7OIaOKKX+5mpU4u9aw8r7
 PA2yxWXgZL2YKcsZweKBiLMtskTeS4GEEQLuYO+zkMd6K8HJvO8f+hcaOd21cMG5oXNs
 t5I35+B6HoL8NfEqZf+oCRO6k+ooWXMdeXylfLexOXStJbz5Ssa2cspAi+la2YQKegq5
 zDjA==
X-Gm-Message-State: AFuF++nZZ7uy+hMHsw2burUfhvgF+5Vb5RG2S2Rp/qW30PGgF3dsNJJk
 4EXpBiTjG2rhTu+t4sXAZeuWMsVa36nslqExv2/+yHBEr9LMJLAPLBpfz5hwhzxwt0Foi4ymVCW
 ul7ZB
X-Gm-Gg: AR+sD12y8x2W2+CCgeT320yCWn292XAoqEHgire0bzASXDnKVUsHMIo1tZiiwbbEhEr
 A9Oac8sW8CUvCjPYSB8ds2HDJaW9EWhXv5+JDrKBINEvOokTVOw9GtoOQvaLSef8oR4wZ8auyKX
 dXgvFZHqmvU0tFCFgFnckJj19OiBsjv6e/Qwb64bAe5oX8aY5Np+mXgplpwhDFlPDwsqOj+yid3
 TxfRvA7dJM6rvyWG6SFOZNoD+ok0aCZcwzGEKniuoSGUfQCMUuR1GuV9c82F1pg9kyKjTWi7/Vu
 gi0U9v6n6zYWeziV45XgKhj007dNK/hJBqcLtqFjS/wnxNFAIvxp4S0UPyv8XgHi2aMt25xapqR
 frCvbUo9Ruc54oO0AsLvGX6O8SSyfCNiVmWDcahYGBjrHwdIqA8BgeRqIG9Z++RHay27Q+IXiei
 fZeKCOqtCJOZwPnM6WaUhiTz3L0gI+5dngqh9Qe32Djua3ZO/lTDMMr80yeTc+QJepof0kPnb1t
 +D8iPR+Kt3tqG+y79OKJA==
X-Received: by 2002:a05:6402:2710:b0:6a0:d411:930d with SMTP id
 4fb4d7f45d1cf-6a42f1cc70cmr14619613a12.2.1787586184577; 
 Mon, 24 Aug 2026 08:43:04 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e19a05bsm13368763a12.17.2026.08.24.08.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:43:03 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 13/24] usb: gadget: dwc2_udc_otg: fix up after the resync
Date: Mon, 24 Aug 2026 17:41:22 +0200
Message-ID: <20260824154133.217744-14-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

Adapt dwc2_udc_otg to the new gadget API. udc-core has its own
usb_gadget_register_driver() now, so drop the local ones.

Eight call sites reach dwc2_udc_probe() from board code without
DM_USB_GADGET, six boards plus the socfpga and rockchip mach files, so
call usb_add_gadget_udc() there too. That covers 49 defconfigs.

Build tested on trats2 and socfpga_cyclone5, both keep their UDC.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/dwc2_udc_otg.c | 86 +++----------------------------
 1 file changed, 8 insertions(+), 78 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 570fed347c9e..398aec56a274 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -246,81 +246,6 @@ static int dwc2_gadget_pullup(struct usb_gadget *g, int is_on)
 	return 0;
 }
 
-#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
-/*
-  Register entry point for the peripheral controller driver.
-*/
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	struct dwc2_udc *dev = the_controller;
-	int retval = 0;
-	unsigned long flags = 0;
-
-	debug_cond(DEBUG_SETUP != 0, "%s: %s\n", __func__, "no name");
-
-	if (!driver || driver->speed < USB_SPEED_FULL
-	    || !driver->bind || !driver->disconnect || !driver->setup)
-		return -EINVAL;
-	if (!dev)
-		return -ENODEV;
-	if (dev->driver)
-		return -EBUSY;
-
-	spin_lock_irqsave(&dev->lock, flags);
-	/* first hook up the driver ... */
-	dev->driver = driver;
-	spin_unlock_irqrestore(&dev->lock, flags);
-
-	if (retval) { /* TODO */
-		printf("target device_add failed, error %d\n", retval);
-		return retval;
-	}
-
-	retval = driver->bind(&dev->gadget);
-	if (retval) {
-		debug_cond(DEBUG_SETUP != 0,
-			   "%s: bind to driver --> error %d\n",
-			    dev->gadget.name, retval);
-		dev->driver = 0;
-		return retval;
-	}
-
-	enable_irq(IRQ_OTG);
-
-	debug_cond(DEBUG_SETUP != 0,
-		   "Registered gadget driver %s\n", dev->gadget.name);
-	udc_enable(dev);
-
-	return 0;
-}
-
-/*
- * Unregister entry point for the peripheral controller driver.
- */
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	struct dwc2_udc *dev = the_controller;
-	unsigned long flags = 0;
-
-	if (!dev)
-		return -ENODEV;
-	if (!driver || driver != dev->driver)
-		return -EINVAL;
-
-	spin_lock_irqsave(&dev->lock, flags);
-	dev->driver = 0;
-	stop_activity(dev, driver);
-	spin_unlock_irqrestore(&dev->lock, flags);
-
-	driver->unbind(&dev->gadget);
-
-	disable_irq(IRQ_OTG);
-
-	udc_disable(dev);
-	return 0;
-}
-#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
-
 static int dwc2_gadget_start(struct usb_gadget *g,
 			     struct usb_gadget_driver *driver)
 {
@@ -364,7 +289,6 @@ static int dwc2_gadget_stop(struct usb_gadget *g)
 	return 0;
 }
 
-#endif /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
 
 /*
  *	done - retire a request; caller blocked irqs
@@ -809,10 +733,8 @@ static void dwc2_fifo_flush(struct usb_ep *_ep)
 static const struct usb_gadget_ops dwc2_udc_ops = {
 	.pullup = dwc2_gadget_pullup,
 	/* current versions must always be self-powered */
-#if CONFIG_IS_ENABLED(DM_USB_GADGET)
 	.udc_start		= dwc2_gadget_start,
 	.udc_stop		= dwc2_gadget_stop,
-#endif
 };
 
 static struct dwc2_udc memory = {
@@ -939,6 +861,14 @@ int dwc2_udc_probe(struct dwc2_plat_otg_data *pdata)
 
 	udc_reinit(dev);
 
+	/*
+	 * The boards call this from board code, there is no udevice for the
+	 * parent. udc-core only stores the pointer.
+	 */
+	retval = usb_add_gadget_udc(NULL, &dev->gadget);
+	if (retval)
+		pr_err("failed to register udc: %d\n", retval);
+
 	return retval;
 }
 
-- 
2.53.0

