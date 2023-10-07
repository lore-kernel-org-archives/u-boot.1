Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFC0E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A7086C15;
	Sat,  7 Oct 2023 23:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lb5HM2kY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FFE786DC5; Sat,  7 Oct 2023 23:57:07 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27D7586DB8
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c60c10db16so1642105ad.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 14:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696715816; x=1697320616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LlLxIzyfdo9pSZ1DoCDplPmbE/VmZEoS3Gr5hLZWak=;
 b=lb5HM2kYGIfi0BvjkAL8akxtg1T/U3QgMDdyZDlCgmRWXB6h7hEBu66H5wgpMEu0Xh
 ySnOEDUY/nwM0oIaeJ1hiSMJuYeZvLiPY88zMsHz3Tyf0G80SnnR9cjSjSTIAdAxZpr8
 P4sKkTvhN9nzrx3wZceXs6LUScCcNujalG+E6zGafgxpWyB6d0Bby0HxSOD//k0Ne1vn
 ulRyX5YG+J9tXNiXzu9cb41fb8ktOtCKBXfRxJY7H+R7Ax2pSyppwnac8SHL6p6FAJxn
 2hK4aiabyfT+cBvQGJ49pV5MPppbm8GBjXdVYHZ/JAYX/a6OVjR+sbI3tv89YOp1dLc9
 GpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696715816; x=1697320616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0LlLxIzyfdo9pSZ1DoCDplPmbE/VmZEoS3Gr5hLZWak=;
 b=ABVsKUpW2D8UPJ4u4pwoN6gFG8a4raXh1VHm5yB2wkobwCARMBXQMaptWo0uPAzwFU
 A8G++S22hgA01IR+WDoGXY8t6aRENANZTz/ff4qh9bJARrR9iw4pBsuOvKarXmv8cXNa
 MdmwfZS1rwh7VFlbbM6PhsNvwFsiY5f15++6wg2Td0Xf8udKWIxQnBQAO8IBPxeCQczw
 bJkE/Pr8FoRSM6Q5BeQJ07WPjmzP+3Um4wr5VpQiUHAXT9JuHXgtzSDnWgrZSvgYsX97
 YZKA6AkL7Te13jZ/yIcVJOTjh+wQT9wCpF6IYYBduPqFgvpMLMgXQBYL22AyQLAWv0hb
 /Wxg==
X-Gm-Message-State: AOJu0YzzBUA6OIrCmgkuaVUFzoJBCqDFkIClUh7QgWAR6dr6IhUJurcS
 +A8ghzUw1k6M841w3KKawPJZouX6318=
X-Google-Smtp-Source: AGHT+IGt4Cokc/LJEV93hp/uXFbUky+WZ6aqfqG3Cr2aV8fgRKSaOPLNDLB0Yk/VR/WO5AbvsfiLgw==
X-Received: by 2002:a17:902:e5d2:b0:1c4:1cd3:8062 with SMTP id
 u18-20020a170902e5d200b001c41cd38062mr13247495plf.2.1696715816418; 
 Sat, 07 Oct 2023 14:56:56 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d82a:6c03:129b:26f2])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a170902ecc400b001c74df14e6esm6346487plh.51.2023.10.07.14.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 14:56:55 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: sbabic@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/3] usb: ehci: mxs: Use regulator_set_enable_if_allowed()
Date: Sat,  7 Oct 2023 18:56:47 -0300
Message-Id: <20231007215648.3156877-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231007215648.3156877-1-festevam@gmail.com>
References: <20231007215648.3156877-1-festevam@gmail.com>
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

Swict to using the more relaxed regulator_set_enable_if_allowed() to
continue if regulator already was enabled or disabled.

This fixes the following error when running the 'ums' command:

=> ums 0 mmc 0
UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0xece000
Error enabling VBUS supply
g_dnl_register: failed!, error: -114
g_dnl_register failed

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
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

