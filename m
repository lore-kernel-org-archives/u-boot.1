Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AC4C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 12:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 522EB889EF;
	Fri,  2 Aug 2024 14:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="c85eo6RP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA73E88B89; Fri,  2 Aug 2024 11:31:33 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546F488BBC
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 11:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f01e9f53e3so114977791fa.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1722591087; x=1723195887;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aZoJmClXlC74Ly6CNi8+QSHAm+Coxp+Vdeuflq5vYRA=;
 b=c85eo6RPb82dEC3e1PUB8jBhBgo6VZobyoJUhtJJqJ0uWM5PP6PjltthdPT2biiLmL
 VKwu94pzy3Lu7lu4yq//zSW/wwYcX59Kf+UDfKfMlKtTTfPZpvEe3yOUSPsd7vBtwQOR
 L54g5qvW94bttlrQWboVru+tOa+YIRELi33RFvN6ob/umATLe10xh30eGniTPtyFkrMp
 1VjohvNzp5jPqmf7UVfyTBuxEqhahmnJqHRC2m4vuyIkEO6XwTXMWBbNDYS0UdU3wsrf
 tB0rB/G/RIPPZT+Tb4VZosZe+xXEz+1CikEwhH+729r+pWIHxySuvMZtczxI59YgQMYI
 3pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722591087; x=1723195887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aZoJmClXlC74Ly6CNi8+QSHAm+Coxp+Vdeuflq5vYRA=;
 b=htSOM2C8piYjBuztyd2zynL9UWpd0Pr5p5JdELXZlDbzqv/6IkNXG5ou4S12jkPpde
 bld+OrcpV+27CQ6K8FAABCYAyNx31lG6BqkhLi+3iktnvK0JuJnTJ/GQiL0do9+gZjMF
 z0PlVRxYC/Bdj866bi5/tobkmeLJ5KnFDundtooxoEO7jkigPo5PItp7XteA+hi98DEp
 WQIbD6YqMmdozKuSqVdKYC9xizURozZOHYcC3sbJHlfia9Kx5ivNpwy9arm8gPIrLe3R
 9Rl+y+MPxgJMdhqjPqLy7d0ywii7ZWGhRQ33cNogR36JeGiz0Rw/UoaAGoe9wqy71JZ5
 lGEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbI/bAZlhNe6mNu715UdY7C7U7nA4nsqGsBpkFpeOeHMRC2hFbl2AQTyNqh11Q8IO7oyIAxWk2PRPcXh/Wa0MQ6luYhw==
X-Gm-Message-State: AOJu0YxOxh8fTKsKK2PF8tJ4awnu9vVpCXv+XlfOAyshGCY/Efe288uI
 Fib2zyhMDxLv93q0T1/IDwgH85BOukg1D95jvbGKzMDu/7w3jlroEYdCjLGXqac=
X-Google-Smtp-Source: AGHT+IELFARy96aqohFhglJrHSPtohScviRvVeQ555T8dqrKN1YwvYEsGU76kSYGWCIcB8/fa+2Wgw==
X-Received: by 2002:a2e:8496:0:b0:2f0:1a36:1d6b with SMTP id
 38308e7fff4ca-2f15ab5cb13mr25137751fa.40.1722591087268; 
 Fri, 02 Aug 2024 02:31:27 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-42824130e43sm83671905e9.0.2024.08.02.02.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 02:31:26 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH] usb: gadget: udc: Fix duplicate uclass name
Date: Fri,  2 Aug 2024 11:28:11 +0200
Message-ID: <20240802092820.917450-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Aug 2024 14:54:36 +0200
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

Rename the uclass to "usb_gadget" to fix, also makes bind/unbind by class
index (or sequence) working.

This breaks the capacity of using "usb" as DT alias sequence numbering
which needs a fix afterwards.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/udc/udc-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc/udc-uclass.c
index fbe62bbce4..723d1cdfd7 100644
--- a/drivers/usb/gadget/udc/udc-uclass.c
+++ b/drivers/usb/gadget/udc/udc-uclass.c
@@ -83,7 +83,7 @@ __weak int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 #if CONFIG_IS_ENABLED(DM)
 UCLASS_DRIVER(usb_gadget_generic) = {
 	.id		= UCLASS_USB_GADGET_GENERIC,
-	.name		= "usb",
+	.name		= "usb_gadget",
 	.flags		= DM_UC_FLAG_SEQ_ALIAS,
 };
 #endif
--
2.45.2

