Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF77C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 01:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79DA788C4A;
	Thu, 22 Aug 2024 03:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="XTOI+Xa7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6698788E5F; Wed, 21 Aug 2024 23:20:43 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8191188E44
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 23:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-429d2d7be1eso617435e9.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 14:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1724275241; x=1724880041;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xzRLJXxzIr8CeWJ443k8zfKBhnPO76GlIWQtTvsyjHQ=;
 b=XTOI+Xa7gk5dsQVr9gQ55RgJUA+VrahVTNHTi63Td4XPOQFLzsA+4BpONBhwpRvmwB
 /DuW3XmEax16hprHxOHZhoiAPZx5KF5kf7QLBuLnlrLa7WyOVAvU5b2Z071RBXEZjpip
 pXGuGTz0C9qgmnqAETZTrc3ZU0jvzBMfP+LEI0fDk5u1cp4qwIpMWYLPXuDwbJHJyEb1
 0bq6W8VvaXkFiGg8+r9GobAX99rG8S+Q86rYO5u38B5/msXQsvRqwBaYmK/ZcbAha74Z
 j0Hude8ugIeYGWepJl5BsVC2XHqu27p3LuFOCJ1IGfnnqXpDXVLG6M2dZGPvTKxVDpbr
 ridA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724275241; x=1724880041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xzRLJXxzIr8CeWJ443k8zfKBhnPO76GlIWQtTvsyjHQ=;
 b=gNycmSY5D0IChaxTgLLVMX9N+Zj7Pp9VOk1LpIDoab6XHFfRZ9foL9Q/khv7BWPaDp
 KhZvYlz/tInwtycuNFLNQHKvuuTjLjQ0raoGKrQbhe7WtPm7qCy+v+UnVFs5isP5Zii1
 /YRzXThr/L4fQ3Fe5kUcDXz0qxmCCU6seKZIcFq53MD5NGH+rwRJ5kD5ljmRVGJLwHB4
 aRruPUNbiQr2ZTVPpFD5WmYdYHkFUu4rf+5A/WZz1U3tGiSUGYIvinUW81TTO8P3sxEx
 nFWxMTa5HAi4vGVbxsAP63l3Rh1xSf5fvS9lbZiPt3BWzx+og3Vq70B1KTP1a3mQNTkW
 iW8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD+t6/Jl/V7b2so3lUT98yERhqtpDN6O30AavExKMSfKKNVE+3nP8EKXM4mOS3ChWhfy8/M4A=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+cBnCueuNG3oxPxMEiaXxj3TJFeqHvgpgT3fbMOENGXWpj49S
 3pkAYsRUM9NiP4W3W4jpmyowUZYwF3gGFhj5kUethDd7oCYJsLdubO3oT/1T1fg=
X-Google-Smtp-Source: AGHT+IEyZMlVC7qswNkFos/2Kla8LAPrGGV0IrF3NW5keDlKvbxuZqFsyDsk7j7ksscJLq45rDxf8Q==
X-Received: by 2002:a05:600c:4446:b0:426:5b17:8458 with SMTP id
 5b1f17b1804b1-42ac38c007fmr4719155e9.12.1724275240629; 
 Wed, 21 Aug 2024 14:20:40 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-42ab6e7de7bsm56940945e9.0.2024.08.21.14.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 14:20:40 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH 0/1] usb: gadget: ether: Disable USB pullup in eth probe
Date: Wed, 21 Aug 2024 23:19:47 +0200
Message-ID: <20240821211956.2091759-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Aug 2024 03:15:59 +0200
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

With feedbacks from Marek and a deeper look the patch "usb: gadget: ether:
Handle gadget driver registration in start and stop" doesn't fix the issue
in the right way.

We can't keep pullup disabled in udc start and remove usb_gadget_connect
from usb_gadget_register_driver since g_dnl doesn't call
usb_gadget_connect after driver register (it does call before udc start in
which case the controller may be not initialized yet eg. DWC2).

I think fix the issue in usb_ether probe is the simplest way to avoid touch
too much things.

Zixun LI (1):
  usb: gadget: ether: Disable USB pullup in eth probe

 drivers/usb/gadget/ether.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--
2.45.2

