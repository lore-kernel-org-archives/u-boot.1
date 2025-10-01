Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3CFCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 13:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D2D835D8;
	Wed,  1 Oct 2025 15:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CMH6pw/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 348818344E; Wed,  1 Oct 2025 15:21:26 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 179C381D6A
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 15:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6366b7fd337so3249737a12.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759324883; x=1759929683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WkklK3aWpY8KbIuFvqHyW0QSah9LbnwipUkAn3EByYQ=;
 b=CMH6pw/pxxVEmn6yl/sj7/n6iU047v35BE5qBkLKSDoMQtX4dYwhvLo6tjCkJY59eP
 HJOPypzZgWAP3vlXBsw68gfmbKNHaXYengwnP65+zJPQgbh91t/KK1BElYsBAoHGSzxZ
 LzMB/m6yTXkAX1S8M8n76+5MYERKroO+pXx9AaWemC7PHqLQ3F93h1UBeHLRstJFkRUX
 x44F6JEf+EbifJEU7A0K0zAkenTMDetJIU16eS9jpUXJuc8ebPwcofyFPc1rSA8cPHbe
 KGk9w2/3QGsydsnbl70SGjSwmFJHVL9Zny3ZKZjcAS0jHKyM8v+XuNRM2zqtRgkkBUxl
 7sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759324883; x=1759929683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WkklK3aWpY8KbIuFvqHyW0QSah9LbnwipUkAn3EByYQ=;
 b=Qbp24cClg+FY4IUpBUfFKR3mwGE7jyZJHzgZaHQzXYCInUYJ3ikzRutYQoVfIkhMOt
 9fzBam62fxul0Rk39NHvQcBcZ9zFVyFfnFqAaA5Acb96Ta6IkZ+Y9wpXISNVdwydEqyD
 qMjxf1xWtllQEUyOR9L+i9IDWlDagDDrqa/IF5G21HrMyi5u2HgYX1WjehGZm+PK7OAP
 EP9KBo7SotADJEAU+wnrdnV2Y5fZ6xGEuZo5gqEF6oufktPbb9eweP8cpwPDgPjq5oPd
 2FRvZQbPAdJh5wiHdREwFsw3BeLfigAx49lbrxadG72tyWA01G5kcV5XExFV4KGVyAAR
 BLlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYLDls5fmkQH95pPMi4RHTGtg4b2YIecYScraa5wtUA0DOzvXPfjmbMYsmLZCR7hho/Hzyba4=@lists.denx.de
X-Gm-Message-State: AOJu0YwlXxCNMKHuo8ivJtaHPyuvS4kxkbVWaxVGtcHuHVJIoB7EbSJj
 Hw7hl2tJ3HR39lN6wXH//liz8zDPdi0JpQSlkBpSGh9IVB2BsxGhRE1m
X-Gm-Gg: ASbGncs5HI1l/McuiFS7ycANEpWWU9b2A0SquOzOVSdNqe1k34IVFJ4IKMjfbXz/Cpe
 io+mvQAS06uqMOf/muq/W/B1R06c7Mhgrp8ahmctQK/UpxVS9XsCxDlgYXUwNgnrlmuORtu0mLt
 I2DXRNjvolKuZRlYSUEdn4qviDww2FY0+O1BC0muMJ9bOQg9m5tOt0slj+ouV54tTRAj+Zjkf+x
 1bPyvGguruP9NT3T2wSrDJKsOJGGYQd8SmcqhYSQVMAHx0mfQvudCHja6FLRxM37MlOk9oah3UB
 TzgcAtgeysJIUDX07Ktfpa7d5TnlLmwZDV35sGSf9Uy/zCYpU2iX5W7KIzBk5cXg2yE1eeZT/uv
 2v8Bstj9VQAZHzm5kioIgpzOLNJbcKPCt8Rmgwrrztkm1A3wAYNNaXLVIRUkDKfcVimri1oKCDn
 FYfAyxbhUWh+E/oGrCEf25vWHgtwegoNVeA0oa2sfNyxWn7qVD8ei1OKZyO4G9jJ1eg6N2e92l
X-Google-Smtp-Source: AGHT+IHzkY0hiRRA+7OxfvIwltrTyshirkxY3nagmYmVTCaWxR3oc/WrokAqeMMqcUcr7hvswmcT7g==
X-Received: by 2002:a17:906:730f:b0:afe:764d:6b22 with SMTP id
 a640c23a62f3a-b46e0ea1cfbmr397888666b.9.1759324883359; 
 Wed, 01 Oct 2025 06:21:23 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b401d3d4124sm566956766b.75.2025.10.01.06.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 06:21:22 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 3/4] configs: verdin-imx8m[mp]: enable USB Gadget OS
 Descriptors for fastboot
Date: Wed,  1 Oct 2025 15:21:06 +0200
Message-ID: <20251001132111.1490516-4-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001132111.1490516-1-ghidoliemanuele@gmail.com>
References: <20251001132111.1490516-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

USB OS Descriptors are used to install and configure the device without
requiring any user interaction on OS which support them (e.g. Windows).
Enable them in order to improve the user experience when fastboot is used.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/verdin-imx8mm_defconfig | 1 +
 configs/verdin-imx8mp_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index d33fd8614b54..cc30e23974d3 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -158,6 +158,7 @@ CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x40400000
 CONFIG_SPL_USB_SDP_SUPPORT=y
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index e50bd5865ca7..d825ba73e506 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -185,5 +185,6 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_IMX_WATCHDOG=y
 CONFIG_HEXDUMP=y
-- 
2.43.0

