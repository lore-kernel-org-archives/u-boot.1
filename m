Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBD5C54E58
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 13:52:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0FC187EED;
	Mon, 25 Mar 2024 14:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T3j7TuVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3AB87EED; Mon, 25 Mar 2024 14:52:52 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C00EB87EAF
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 14:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5a47a3786dbso1248668eaf.0
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711374766; x=1711979566; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AGoNuN2pajNr9rGY4++Z3WP7lMtaSF9Dd3wKj63EO8o=;
 b=T3j7TuVAxp54Lss+xEqSR71ClZ/lC3CZhIe2/GvJ4J+SEIb6OY2tjZEfUjZLaXwt2F
 hgd7zSDcT6OV15+KtmAqIszCyLHYxyH7S6sKRkiQVynEabXmU+/4pCEb42j9ZwdssPF2
 MBG/li6yVu0jpK6gns4DWyy1mwwLCeo6ZuuNZy9g/dGVhOgRwPQrbiKBAbo9huJIbcKn
 fEM9mibldeg8c6ElkI65dZoeCPgMqje8hDbtG2N24ZAyo0ymdkcWSkhxCmmjiiJ6rOOa
 39XldNuMDmMtP64GY6yTtBbQMYgVZ5jdyzlMtjM1K4Goj+Gxq4AwzMIWdcOFLLAaEcMv
 n9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711374766; x=1711979566;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AGoNuN2pajNr9rGY4++Z3WP7lMtaSF9Dd3wKj63EO8o=;
 b=KbzStq/KaHRv9g+J0XHor/eMKTFEZUIm+DmN9rIG6kGoBlU5Pz0HtqBXVoXdHArgBv
 TEGev8DvlGuQxqusUlM/wNvFdVcKfihPA3Dx4IU9R66rREQZPBgVH0yiQgwzMMi+2s22
 I4z9CsRg6GZQ6CRi4FNnkl1GN9xKS9bMxL6wXR90lCb6599QJr5lziSl4zwO6ARUcRMd
 VmNQj9rs+X8I5tkXeJ5P42+4r/z1xHSkSDl2KdX2C5grF3mNRucKYoCg9+AhezN9lD+j
 o0rmWQ4yw7ICtStVkMhA5rsPxnvdlc0uqiElTuJ1QMePgpzFu4ICzoODgdfrWoy2lc3x
 zCAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf5lWbRFtK3E4LVXtt40BQ5fhoElFnw0u8PLfRijXUs+Iv6yrzWUufuIhm0wlcTLIsjLEymU8r2qVxhqxSUW/OvC91rg==
X-Gm-Message-State: AOJu0YyKKiexhKsgfiUFxjKx9PLKeggeK1k8NjQpMgJGPZlajtH5JgZw
 uBaUPBdYKNnY6sJh0/n+euMrvNsY/SPlsJvXFbU8hlLhSJIsXi9g
X-Google-Smtp-Source: AGHT+IFIO35H42d3LKCNU6E8qKChsYpnWNTsNcerir1hZbec1onhm+kh4RSASLP7NbdZnJNQi+nAcg==
X-Received: by 2002:a05:6359:45a8:b0:17e:bc8b:fbb5 with SMTP id
 no40-20020a05635945a800b0017ebc8bfbb5mr6441882rwb.3.1711374766330; 
 Mon, 25 Mar 2024 06:52:46 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:97a:fe72:ef3c:22d1])
 by smtp.gmail.com with ESMTPSA id
 15-20020a63000f000000b005dc26144d96sm5888788pga.75.2024.03.25.06.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 06:52:45 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: martyn.welch@collabora.com
Cc: parthitce@gmail.com, marex@denx.de, u-boot@lists.denx.de, y.moog@phytec.de,
 w.egorov@phytec.de, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] phycore_pcl063: Drop leading zero from USB vendor number
Date: Mon, 25 Mar 2024 10:52:30 -0300
Message-Id: <20240325135230.1777213-1-festevam@gmail.com>
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

CONFIG_USB_GADGET_VENDOR_NUM is a 16-bit number, so remove
the leading zero.

Reported-by: Marek Vasut <marex@denx.de>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 configs/phycore_pcl063_defconfig     | 2 +-
 configs/phycore_pcl063_ull_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/phycore_pcl063_defconfig b/configs/phycore_pcl063_defconfig
index 6b00df1cffb3..017054a8e12b 100644
--- a/configs/phycore_pcl063_defconfig
+++ b/configs/phycore_pcl063_defconfig
@@ -63,7 +63,7 @@ CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Phytec"
-CONFIG_USB_GADGET_VENDOR_NUM=0x01b67
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4fff
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
diff --git a/configs/phycore_pcl063_ull_defconfig b/configs/phycore_pcl063_ull_defconfig
index 6195fcfb73df..b3da43a5bf1e 100644
--- a/configs/phycore_pcl063_ull_defconfig
+++ b/configs/phycore_pcl063_ull_defconfig
@@ -54,7 +54,7 @@ CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Phytec"
-CONFIG_USB_GADGET_VENDOR_NUM=0x01b67
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4fff
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
-- 
2.34.1

