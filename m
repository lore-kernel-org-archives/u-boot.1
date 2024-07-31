Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C26C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 21:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B83588AB1;
	Wed, 31 Jul 2024 23:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="YyB1QHCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05D35889DC; Wed, 31 Jul 2024 15:43:46 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 727B788A55
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 15:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3687ea0521cso3647835f8f.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1722433420; x=1723038220;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaPxAEgrkb7+0NfhnWk+xZXDrxyTMypnUxO3t8QBZgY=;
 b=YyB1QHCF3Dk4nM22RzUUoh9Wh8lmZKkWO6hB0fbOA08oy2bfMaNLNF2Rf548IyUFcB
 /E52jj/U5h4HPUMxKMOtlBQ58S9z3PxFTpqOPoVeYxb/cKtJdjMz5RDCaTF3PKwZyT9G
 xSnSrSkyWWNqGMvrKIYoQCV8lIEeu/MoDJZhO/s9CHOkNyESQ8HDfd9JHvYrfy9G6O0j
 Jx/j9wayTvM5yZEybnzWP7kHidfaqsZh+8u5Bo3lEIjbJF9rExP4/geb7BOVVMC+4d14
 XQosCC/y7vPGhGat50NUpOjKrf86On8aZT+o1AZeK/xqKd+OLMOl6mnDUVQ9JGgtkWhj
 mlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722433420; x=1723038220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CaPxAEgrkb7+0NfhnWk+xZXDrxyTMypnUxO3t8QBZgY=;
 b=B96vj0m4iv5aTMYuM+ZKQYzV6XrUokjSqJrsamFSmZUOH+ZYRAFCAJgVXcDRbme8MK
 ipMAXqtx5zLug9hiuDc7yhn5GJ/eoWKOHGaeEV3SrfqSGWDl8rcBAMbq7iYzDM/GdJ+p
 g3UNXS+wrqCJwuiF0YI24OglX4OYiOLjFKqmfwRT/2wNfdPvwK3vfI1BIBXJMxpXAMUL
 6h/ZZ3ixkVH+xO6LspE22w5FSQjVRotE+nMwv5lsK/EFN9s1bk+G2VwgHCLPs/Qo1sUe
 04LknKoyWbJM/1x0z14efoNlGDqxHIzJ5KJ1Stuto8G8OraCYMeBYfeIxBwqVNH9Lc5u
 Mtcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPtdWMDVsLprG6hX7IIeFLpDTvg61wZj6AxJ5c0lnV08x9avRkrtX2XOFiW453TnCESLaKoKXMXsFgldHcOcxZal46Jw==
X-Gm-Message-State: AOJu0Yxg4MshkTKGAR2iPjarEoVLOxvJ6+R1/LSxI7G8kdMLLDRyy92d
 s8os1tbqdGLXpTuecqPOv7F6+tbiI5pyvWNjPF9pIPeCbnA5r2LhQqrTKVvZsvA=
X-Google-Smtp-Source: AGHT+IEGJIRNZKCfDLA7/ns5wbjwvIv9Unqg9RzK7sSJH4v4ITWhCMmPlM7B40ftjU8cpB82k/kfRw==
X-Received: by 2002:adf:ea10:0:b0:36b:3563:15f4 with SMTP id
 ffacd0b85a97d-36b5d2dd544mr11310286f8f.56.1722433419889; 
 Wed, 31 Jul 2024 06:43:39 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b29sm17063739f8f.93.2024.07.31.06.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 06:43:39 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [RFC PATCH 4/4] usb: gadget: udc: Fix duplicate uclass name
Date: Wed, 31 Jul 2024 15:42:19 +0200
Message-ID: <20240731134257.686017-5-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731134257.686017-1-admin@hifiphile.com>
References: <20240731134257.686017-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 31 Jul 2024 23:11:08 +0200
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

Currently both USB host uclass and USB gadget uclass are using the same
name "usb" which break uclass functions like uclass_get_by_name().

Rename the uclass to "usb_gadget" while using "usb" as sequence alias
naming to keep the alias function working.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/udc/udc-uclass.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc/udc-uclass.c
index fbe62bbce4..b14f84e818 100644
--- a/drivers/usb/gadget/udc/udc-uclass.c
+++ b/drivers/usb/gadget/udc/udc-uclass.c
@@ -83,7 +83,8 @@ __weak int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 #if CONFIG_IS_ENABLED(DM)
 UCLASS_DRIVER(usb_gadget_generic) = {
 	.id		= UCLASS_USB_GADGET_GENERIC,
-	.name		= "usb",
+	.name		= "usb_gadget",
+	.name_seq_alias = "usb",
 	.flags		= DM_UC_FLAG_SEQ_ALIAS,
 };
 #endif
-- 
2.45.2

