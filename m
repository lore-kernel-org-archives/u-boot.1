Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71649C54FB3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 13:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9027788966;
	Wed, 28 Aug 2024 15:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z7ZZGjiL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D676888AA; Wed, 28 Aug 2024 15:26:05 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 103AD88872
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2d3b595c18dso477359a91.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724851561; x=1725456361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCctJHhbEu7h2uEEjgJi+e2M9vWbD4J87E7olnFCpO0=;
 b=Z7ZZGjiLpn79bQbTpmc+GNFGMouYvUtAFdNHtcwS4nuOcUu8Osv244a+uGFs2qCqul
 dtdZMBnudoInFyq/+2Wjp8p8ZA2QVU92D4J2GWc95/ZbDd8pJ125Ov8gAB3lCxIvNvrU
 FbX8//b2spg9AZ1P2OmuagEi+VtGgf5LaKYh6XudKcTwFeWXSacOX/Ym1MMgkfz3P5Bl
 b+JgnLoiXEX5m4T+9civrQdDKbN3yZwz5TX60fDMsZ+URcU3V7/2QryndeJDCT5nbOly
 SeMyeKNe0OE6Fs3p5Gm54vth0K3p9QFN/7phfcauTTNNiRXx2CZNTSoPixiBU7lrtUU0
 SjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724851561; x=1725456361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bCctJHhbEu7h2uEEjgJi+e2M9vWbD4J87E7olnFCpO0=;
 b=h/Grb1qPkHGbWWd2Ae0BFTEs+K1eQheG+JoBCEEaSGWkMMNbKnNe6gXZ9HjmHQyIjr
 4tY77tdkBiOECWFvMseN3V0X3owq3xpcLNIO/+PrLJcu+LLcqhZHJa+gMyjD7H5cj9l0
 3t4EzWen5W3yGVV0qYHAvskbpaGGqrWyuBvZBSwHb4iAkwLOqHHkuUZNzC5yTJUzDx3v
 myNUIfUwYZNvKGhY2/854XsrqdLbin3geyCAhJ7mLopWgctaEcEQPpL9rcreQEtYAQDF
 ibgGGjbFk8DgMvuR8frfz9wHynN9cKg7pnl06T0ZbM9o/Dt4JkzuceFXShHV8zNoLmKN
 RwNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH/Ut5E/ty5+//yNNuYQiwAp9nVYhAlPbR/ZIBkSQHi6zt9MflrMtMEkf0wCio17c1KmX48+E=@lists.denx.de
X-Gm-Message-State: AOJu0Ywahha5nW4nEJGgkdwa41AjOtZiiT1agvhQEziCqojdwMNsmckn
 kQIh7ozSJVzWXKkPf0UkWuYj8caYk3yN7ktJQ1rzC2r9WZPihlr1
X-Google-Smtp-Source: AGHT+IHevbDW/tNBTDp5ppueEZcPxGDW3diVo5zwWuJLoWDGR9bH0S/y+hAARSDkZ7Q1JojLa9kpYg==
X-Received: by 2002:a17:90b:3d2:b0:2c9:6753:6192 with SMTP id
 98e67ed59e1d1-2d843d83a02mr3503170a91.12.1724851561469; 
 Wed, 28 Aug 2024 06:26:01 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4b3a:557e:6b5b:dbdc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d844617777sm1788660a91.24.2024.08.28.06.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:26:00 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: marex@denx.de, u-boot@lists.denx.de, tharvey@gateworks.com, smoch@web.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3 2/4] usb: ehci-mx5: Add a default for CFG_MXC_USB_PORTSC
Date: Wed, 28 Aug 2024 10:25:27 -0300
Message-Id: <20240828132529.3098961-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828132529.3098961-1-festevam@gmail.com>
References: <20240828132529.3098961-1-festevam@gmail.com>
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

Just like drivers/usb/host/ehci-mx6.c, add a default for
drivers/usb/host/ehci-mx5.c.

The motivation for doing this is to remove CFG_MXC_USB_PORTSC
from board config files.

All the mx5 boards, with the exeption of mx51evk, define
CFG_MXC_USB_PORTSC as:

 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)

So move this definition as a default into ehci-mx5.c.

Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
Changes since v2:
- None.

 drivers/usb/host/ehci-mx5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/ehci-mx5.c b/drivers/usb/host/ehci-mx5.c
index 44912de7787..d8f521befe1 100644
--- a/drivers/usb/host/ehci-mx5.c
+++ b/drivers/usb/host/ehci-mx5.c
@@ -79,6 +79,10 @@
 /* USB_CTRL_1 */
 #define MXC_USB_CTRL_UH1_EXT_CLK_EN	(1 << 25)
 
+#ifndef CFG_MXC_USB_PORTSC
+#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
+#endif
+
 int mxc_set_usbcontrol(int port, unsigned int flags)
 {
 	unsigned int v;
-- 
2.34.1

