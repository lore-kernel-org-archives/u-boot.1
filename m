Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FC2C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 15:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3247E87F28;
	Mon, 19 Feb 2024 16:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="Ku1lyrko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B1E887DE9; Mon, 19 Feb 2024 15:39:11 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6EFE87F37
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 15:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.wojtaszczyk@timesys.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-563ed3d221aso4779039a12.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 06:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1708353529; x=1708958329;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dThvPOKm9Vtkz0vOi6C+GxBwy1yC65UbtdCyFXWfM6A=;
 b=Ku1lyrkoODfzWgMv4Q4e9ixrl9I5H8KjHjqFOGfK9Hb9b+HwCtrO7hjp3oZTGM4sz5
 qeqWkbXrmcCnOTTsNqxO7n6ZrMLBBHVNLeXA+k4XYi7ueqBK/XEoDH/jXl/bAED7+mbh
 Yy9vheLDR6RjeEZd0QJprppOLupDODnFpjS2X2OABBg7fdADIZcboqm2L65AO7G9C/on
 vSYO5h9r90qW1jXkLgqsDFz0/DUumOoC9342dWPlT1PfzPxSbsCizgZ5R4yhHAcb0egU
 JvaiG9eknsTJ0W2syV49lnPp+jIvootby0KQ9PlxoIcFTyyOeKiuuqlprCimSkIVTH4x
 fnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708353529; x=1708958329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dThvPOKm9Vtkz0vOi6C+GxBwy1yC65UbtdCyFXWfM6A=;
 b=MJfbeoJL7zIuyp6IPHvlo9YlV6pirlPow265YNzeuWQNOdOxr2ru7I2zFKBWUkc5UA
 /X4XqNlJIbsZw1+DZMECSjsyIrguEdoPR41gTjPGRcS8ZPcbWh83UHJ/0AnQgfOYijMb
 sY0Lcnw1xqm2E9enJQLbOhT3EjG1Vts4ca2ePPz9JlxVMv9eOMcOYd64mHBFk9GZMAws
 XcLdbpi2IIXiVJp6UX52lxIa7IXgH8L8VONJloo2+J2MHVVepILSAcKjYyVE+VIjjrNX
 NzcrqdSpKStyWzRXYtoarxR6Esdk4R6G26cSprItmd9uTqcMCKyhlkdDb598NVVPkDEX
 ytsQ==
X-Gm-Message-State: AOJu0Yw2wVkac8sn1RzogL8zhPMo2uVYXOOUDbU2a4S2cUPNGX1i/+hn
 fzFXbGrkcV/yQs9qndCGyVqL4MwUknYZjJsc2W8aICg3YqmeHKhocZ1vXj+d40m4TJ2NzdCFzFG
 z
X-Google-Smtp-Source: AGHT+IGTLvrC/C8glaTYPDGcB/ppCHsoMVipRWcW9STy/NqWKPu5zdMxaeAdcY1fITdATo3iZRontQ==
X-Received: by 2002:a17:906:4a10:b0:a3e:8bd8:b711 with SMTP id
 w16-20020a1709064a1000b00a3e8bd8b711mr2511810eju.37.1708353528979; 
 Mon, 19 Feb 2024 06:38:48 -0800 (PST)
Received: from localhost.localdomain ([91.216.213.152])
 by smtp.gmail.com with ESMTPSA id
 xo24-20020a170907bb9800b00a3ec3390eacsm554022ejc.126.2024.02.19.06.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 06:38:48 -0800 (PST)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: u-boot@lists.denx.de
Cc: marex@denx.de,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Subject: [PATCH v3 1/5] usb: ohci-generic: ignore ENOSYS and ENOTSUPP errors
 from clk and reset
Date: Mon, 19 Feb 2024 15:38:43 +0100
Message-Id: <20240219143843.18971-1-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Feb 2024 16:15:49 +0100
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

If a machine doesn't have CONFIG_CLK set the call to clk_get_bulk()
returns '-ENOSYS' error which should be handled the same way as
'-ENOENT' error. The same applies to reset_get_bulk() and 'ENOTSUPP'.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
Changes for v3:
- Removed extra parenthesis around error checks

Changes for v2:
- Changed logic style from !(== || ==) to (!= && !=)

 drivers/usb/host/ohci-generic.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
index ceed1911a9..d67fce2d02 100644
--- a/drivers/usb/host/ohci-generic.c
+++ b/drivers/usb/host/ohci-generic.c
@@ -28,7 +28,7 @@ static int ohci_usb_probe(struct udevice *dev)
 	int err, ret;
 
 	ret = clk_get_bulk(dev, &priv->clocks);
-	if (ret && ret != -ENOENT) {
+	if (ret && ret != -ENOENT && ret != -ENOSYS) {
 		dev_err(dev, "Failed to get clocks (ret=%d)\n", ret);
 		return ret;
 	}
@@ -40,7 +40,7 @@ static int ohci_usb_probe(struct udevice *dev)
 	}
 
 	err = reset_get_bulk(dev, &priv->resets);
-	if (err && err != -ENOENT) {
+	if (err && err != -ENOENT && err != -ENOTSUPP) {
 		dev_err(dev, "failed to get resets (err=%d)\n", err);
 		goto clk_err;
 	}
@@ -72,7 +72,7 @@ reset_err:
 		dev_err(dev, "failed to release resets (ret=%d)\n", ret);
 clk_err:
 	ret = clk_release_bulk(&priv->clocks);
-	if (ret)
+	if (ret && ret != -ENOSYS)
 		dev_err(dev, "failed to release clocks (ret=%d)\n", ret);
 
 	return err;
@@ -95,7 +95,11 @@ static int ohci_usb_remove(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	return clk_release_bulk(&priv->clocks);
+	ret = clk_release_bulk(&priv->clocks);
+	if (ret && ret != -ENOSYS)
+		return ret;
+
+	return 0;
 }
 
 static const struct udevice_id ohci_usb_ids[] = {
-- 
2.25.1

