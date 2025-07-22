Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21884C83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 09:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CECCB83824;
	Tue, 22 Jul 2025 11:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="j8A0beGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 186C183807; Tue, 22 Jul 2025 11:56:03 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABA0383346
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 11:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-60bf5a08729so10107531a12.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1753178160; x=1753782960;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3+PBw+GyItqe5/sId3XMJdHLEiDofkbcyuZb1BVCvTA=;
 b=j8A0beGCJAh80Ev+Omix048h9Yp8jrDx9CSk2x1ykCysroFUn2IUOXEUvhT08SJdk9
 AsutxvbdjsBQNbTVsr2gV0mKg5SAvrXt66tSIuWgz5Dyu01jMQIKmSH7Sv8PKnD9GTsu
 8yCBqiwzTntpsM97d9gM9pJM4RP6mj7bBse1gqoCJ9Fw/ZVWWlQsSon96DCxIP8LV8x/
 4DuxnwaIwcNQNWyWJR7WMmnlCWrxVvJDC0LtbDIOZp2nRGzuulAKrv0UAhX3k2o/kq/f
 V9zUzD/xDH0jV0lep7cM/vxLDSTCp1zXFvIuTM7EfGf2mceeGFiZGWHvq5HPjlDbu3rA
 7E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753178160; x=1753782960;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+PBw+GyItqe5/sId3XMJdHLEiDofkbcyuZb1BVCvTA=;
 b=Ibwls9En5ISorR0gQjD5Ux+NbfOGlkB1uf86gxHAvtaEODorQYNAyyIHmLAaIPWa3d
 BbM52oIDdeeYY0f2KtLoqk3BeMfzfStkOgUapFgh/BiKRFMa4eIbm1FziFD4P2iPxW9X
 H5uO+2x0wjEC/zNiHN9lz4P8GsqJOB5noKHbwBYAXzkvJf+qHbiLYBaiuWzpsAWeltbm
 MiFdsKM/dOJBqOTQg4sImOCRYHBup9LI/LN7DPHcoWwCPB//qyyCGwJJI5ahM85/Fco0
 W2gunAVcVKv5MJzShJzTfInghAu6E0aXE1/X4TtzAkXssmu3yUlnafLi5ER41dAvVtwD
 bDfg==
X-Gm-Message-State: AOJu0YzZpGCkvmODjdgTaC6An2P/Jb1LArc4dVXjIpFTo72ulw0G+thd
 Vvf/ra+IreX2VeNJ8N009JJ/l2jOXDnwHSOLnIICYQhNON/1NhhLu2qQiSof7oowy44=
X-Gm-Gg: ASbGnctwdXWcXrUrhxLb4qkyw8mLWdG/JtvWlcOwGGbznXUTu8ztVhkG79y6OPpKM1K
 wnTN6StS6/0LlHHKl1K/q4k83FWhdq1Z8+9WBzQ0qwQ3UB8n47ZWwkbH2Jl0BefGOxVlPA/VvVd
 Sq2QTeATK2TkvSEOARrDPnfnNt0ENMDnfe7ANSFiSdfPLRr0JDK19c1uTESm74FkZwmv0cwXn/V
 gvl3SWl3R2zi+DwCSrlS2+3Xm//XmUWDqHQBaSh2HmN68Mq1xyBAhjabE6nk3cSwr6rH8qz5piU
 y1b1Ht4uonInq65YjldAORvG41onEiaam12CL5WR7s9bScTZ1qXmv6Xl8fq54VLd0VzYeG2TsyZ
 osaK0rLr4jkJNIOt47cBBfh6KrumnXySU0A==
X-Google-Smtp-Source: AGHT+IHqvWdKhTpQYwcmPT2LW6UxM916rsvkMA/8NuqwxVSL1F4u4r6VST2gBsfkZgnOK9+HHIbxvg==
X-Received: by 2002:a17:907:3c85:b0:ade:9b52:4da0 with SMTP id
 a640c23a62f3a-ae9ce1fd7bemr2085327466b.60.1753178160046; 
 Tue, 22 Jul 2025 02:56:00 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6c79c279sm834754866b.28.2025.07.22.02.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 02:55:59 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 22 Jul 2025 11:55:35 +0200
Subject: [PATCH v4 3/5] usb: onboard-hub: Set the reset gpio pin before freeing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-usb_onboard_hub_cypress_hx3-v4-3-91c3ee958c0e@thaumatec.com>
References: <20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com>
In-Reply-To: <20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

In the usb_onboard_hub_remove, the reset gpio, if available, is
freed. The pin state however, remains unchanged, as set in the
usb_onboard_hub_reset. The hub is then left enabled.

During second onboard hub probing, the hub is initially enabled
(reset pin in state "0"), and then it is being reset by the reset
function (transition to "1" and then to "0"). Because of this,
the hub first disconnects from root hub, and then it connects again.

When the devices are being discovered in the usb_scan_port in the
usb_hub driver, initially there is the USB_PORT_STAT_CONNECTION bit
not set in portstatus, but USB_PORT_STAT_C_CONNECTION set in
portchange data (which is because disconnect event occurred first).
In this condition, the driver does not wait for devices to appear.
This can cause the hub (and all child devices) to be not enumerated
when rescanning on "usb reset" command.

To fix this, set the reset gpio to active in usb_onboard_hub_remove,
to put the hub into reset state.
However, in case the hub reset pin is by default held in high
state by HW before U-Boot takes over, in which case the USB hub is
active, then during the first probe it gets reset and we might get
into the same issue of the hub being not enumerated.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index c6379192fe8f..046831d09668 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -211,6 +211,13 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret = 0;
 
+	if (hub->reset_gpio) {
+		ret = dm_gpio_set_value(hub->reset_gpio, 1);
+		if (ret)
+			dev_err(dev, "can't set gpio %s: %d\n", hub->reset_gpio->dev->name,
+				ret);
+	}
+
 	if (hub->vdd) {
 		ret = regulator_set_enable_if_allowed(hub->vdd, false);
 		if (ret)

-- 
2.43.0

