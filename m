Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098C4E95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 13:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B9CE86C00;
	Mon,  9 Oct 2023 15:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ETra2odk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E2E86C58; Mon,  9 Oct 2023 15:15:51 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA62B86B1B
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 15:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-690d935dbc2so888112b3a.1
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696857347; x=1697462147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOwCfB25mOg7eyu/t+liiyNXmoKvX+8TJ4yix28N+hw=;
 b=ETra2odkwdNFcVc54KS6qpKqGF40ed+RpRCpiAnscjJOB7CfnSA4OXalTNXBCDSBc+
 GTVvOG8Zg0NpUyKg7V7NANaqvYrl2g4BCx6efiwhdnBx+NJJ74oyRX6lQipPf6Nl8xRl
 /UaqTrFag4DVdosSxcXmmPTKy+eTa0oMEbCRGmc/fraQNxCCTfALDzX9xRXgat6YCgqH
 /0MbopcuXso1GW0pWdO4XKf+w3//BFyB12zwVIR94Dy8YP/nAHqzHW4+pXgWQGmbyTsg
 nB3pmZk5a3PNv3O+K6yWRqRwnEL6ZTGHns7Hs93c5BcNodaLp6HdHlCC/aJ2fkvAsps2
 wLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696857347; x=1697462147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOwCfB25mOg7eyu/t+liiyNXmoKvX+8TJ4yix28N+hw=;
 b=LoagPusMy1/8bgTXdqmwa/3lr8nCXmUsw0AM7ONgdIAVLr95YD7SSVGe4T8895QILk
 ZguTHsAFS7k/kjQS8Bc/RPv32k72X60w2zdGwKVWaCFv1XBlbQybomI0481ZNiXqh71e
 1k4cuBzDBUBeAuZQxAiw0MpH0/+Hqmf2YYH40/dSC6z1WzFL2agjH1oB9SHRbzjraEUf
 Xl2pkrW71bftDp7tQ+gm80pH8OuFxZz0kn9PNdM1AqgG5zXD5tlkwteRcNkql1PEWVN6
 OBj9yIklppLmx0kbQhEB7wyC6xjHhMUh4En0KXcqxdG2gbUrHhrie09yZsTcJjnVRQds
 Z4gA==
X-Gm-Message-State: AOJu0Yz1Xk/py6oOr9fs9znqlBY6VgpyaI5i/Kc4HcjVB64Lfvo6cOv3
 jmX85mqknS+BqXndk74Bbz6t4J1Io9A=
X-Google-Smtp-Source: AGHT+IFhSPPdPqYIVhDvbBnP+U+KNkDr3PfCloOtCLuNZ5LYYo4XOS4LazRJe097eQwZVUUOjlMQEQ==
X-Received: by 2002:a05:6a21:3394:b0:163:ab09:193e with SMTP id
 yy20-20020a056a21339400b00163ab09193emr17733632pzb.1.1696857347101; 
 Mon, 09 Oct 2023 06:15:47 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:22d5:b586:66b8:6e03])
 by smtp.gmail.com with ESMTPSA id
 r10-20020a170902be0a00b001c8a0879805sm4743965pls.206.2023.10.09.06.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 06:15:46 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: sbabic@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3 2/3] usb: ehci: mxs: Use regulator_set_enable_if_allowed()
Date: Mon,  9 Oct 2023 10:15:35 -0300
Message-Id: <20231009131536.3475878-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009131536.3475878-1-festevam@gmail.com>
References: <20231009131536.3475878-1-festevam@gmail.com>
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

Since commit 4fcba5d556b4 ("regulator: implement basic reference
counter") the return value of regulator_set_enable() may be EALREADY or
EBUSY for fixed/GPIO regulators.

Switch to using the more relaxed regulator_set_enable_if_allowed() to
continue if regulator already was enabled or disabled.

This fixes the following error when running the 'ums' command:

=> ums 0 mmc 0
UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0xece000
Error enabling VBUS supply
g_dnl_register: failed!, error: -114
g_dnl_register failed

Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Marek Vasut <marex@denx.de>
---
Changes since v2:
- None
Changes since v1:
- Only collected Marek's Reviewed-by tag.

 drivers/usb/host/ehci-mxs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-mxs.c b/drivers/usb/host/ehci-mxs.c
index 092c79fd4bc5..ddf7cc2d00a7 100644
--- a/drivers/usb/host/ehci-mxs.c
+++ b/drivers/usb/host/ehci-mxs.c
@@ -236,9 +236,9 @@ static int ehci_usb_probe(struct udevice *dev)
 		debug("%s: No vbus supply\n", dev->name);
 
 	if (!ret && priv->vbus_supply) {
-		ret = regulator_set_enable(priv->vbus_supply,
-					   (type == USB_INIT_DEVICE) ?
-					   false : true);
+		ret = regulator_set_enable_if_allowed(priv->vbus_supply,
+						      (type == USB_INIT_DEVICE) ?
+						      false : true);
 		if (ret) {
 			puts("Error enabling VBUS supply\n");
 			return ret;
@@ -265,7 +265,7 @@ static int ehci_usb_remove(struct udevice *dev)
 
 #if CONFIG_IS_ENABLED(DM_REGULATOR)
 	if (priv->vbus_supply) {
-		ret = regulator_set_enable(priv->vbus_supply, false);
+		ret = regulator_set_enable_if_allowed(priv->vbus_supply, false);
 		if (ret) {
 			puts("Error disabling VBUS supply\n");
 			return ret;
-- 
2.34.1

