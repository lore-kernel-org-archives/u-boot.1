Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD26C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 16:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E4E287ED0;
	Thu, 22 Aug 2024 18:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="YTohYZyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB8D88C67; Thu, 22 Aug 2024 11:11:18 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EF6788EB9
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 11:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f025b94e07so4965931fa.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1724317875; x=1724922675;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/xtw7OXd08otj8vVNO+ytzTYQojqMCo0oL6x7TzM3A=;
 b=YTohYZypdWTmT/jKyeQUz3Og65amVmUjn/kQDoamrBFvOFU3eM/VoqPzAJ+UXmfjeQ
 uBWgeDAP9iif+XLxwrT+tipZYTWWO6lOsYbJ9ipMAVTzxxXMBjHrvStqF/iMqr7rgiTA
 lE/iWD7EQwntGZcZzqjuVuojzm24KMwtijt3Vnw5q0wHuwzoVCf6+THiW4jUFGJRZT/Z
 8Eus1nlnQwGw9kEYVjucd+Y0DqCuecjawNa+hkHvcXORLzRxuLkEZXpT+6uj9pWewPGc
 KryvomNzGtjbCDHxtzPDBNfeY5kIVQvit/Lo1U8y1JWnqM3QAvQ1PHGjksy9KOgssQ1V
 vYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724317875; x=1724922675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/xtw7OXd08otj8vVNO+ytzTYQojqMCo0oL6x7TzM3A=;
 b=BWXDVXyD3P5rlZJ6dCv4MDKpbOWSgBjNCMlwwdF+NAHvU9KDy5acFbnEAI+T3Pq6Av
 3NpHI05NdPbZkDCBLeKcP2MbPLF4fOqf9faoIz0ACWFN3qMwUZf95yfzioVkhOxeDFY/
 kQIlJ3v7/+UCuW1pbdnaGKB02nLKOIfbRHB6YtTbCbpk3h2DQcJxeTdv+dmXW4TshC5r
 aH27nfwbrBTWEEULtwBfCTomp+yQTryTnKqunASpAUJjXzIOevvYilZfcpHrhMlxZSqe
 4AUQUlr7zWrv17yQX636qkC/YDtrTsJ4lUvzu3Fghb1d2gNpEEpPGDJNCzTBSLDzOv4m
 WaAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMvxl9PNPl2AsgRkiKcRZPt5CgxsGXjDNdBc9R4aUY2EDDE0m7LD2UQGz94aScAWs8871u2Xg=@lists.denx.de
X-Gm-Message-State: AOJu0YwkJGacQ6TzVKlLr5flHFUW0xpr15tINNtKOrLrkrR9eguom0XV
 fXXawMSffj3BLiGrYZDGmy5dc4cqKb4moPVOp1tXlNcecmdXeNNz2r88VFiKy9tx3FwtbiQ0IE/
 yTAiEQLQiszVD1uaGLQHMxxhQKf5FXP4M7KSuww==
X-Google-Smtp-Source: AGHT+IHOGjA4QLGy2fQNWY5mWGq1i76qaOT7eAwufGl1ktqg/Z5XE5fHmyANzLIOUhLdTDL13dtb5FM5Bf3WgZ8HfI0=
X-Received: by 2002:a2e:4a12:0:b0:2ec:5933:a62c with SMTP id
 38308e7fff4ca-2f3f8863da7mr29301261fa.22.1724317875153; Thu, 22 Aug 2024
 02:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240821212218.2092540-1-admin@hifiphile.com>
 <5a1367d7-be94-4c75-9f40-891ca79f9c5b@denx.de>
 <CA+GyqeYxig+5pyYaCjPmQodXGjCYK=819cNZx9XmvJOnoYne_w@mail.gmail.com>
 <67e8423d-f8a8-412e-ae4a-014d52bf6a2f@denx.de>
In-Reply-To: <67e8423d-f8a8-412e-ae4a-014d52bf6a2f@denx.de>
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 22 Aug 2024 11:11:06 +0200
Message-ID: <CA+Gyqea1r6rP8gXfS6nOtOaKZ=sJ1+z_KguGzzJygQKmSNRakw@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: gadget: ether: Disable USB pullup in eth probe
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 22 Aug 2024 18:09:39 +0200
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

Hi,

On Thu, Aug 22, 2024 at 1:26=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Would it be possible to fix up the g_dnl ?

g_dnl's interface is pretty different from usb_ether, I can't find a
way to access
usb_gadget struct in g_dnl_register().

Meanwhile it can be fixed in udc core, by doing gadget_driver bind
after udc start,
in addition to keeping the controller in disconnected state.

diff --git a/drivers/usb/gadget/udc/udc-core.c
b/drivers/usb/gadget/udc/udc-core.c
index 6bb419ae2a..b917a79892 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -300,15 +300,17 @@ static int udc_bind_to_driver(struct usb_udc
*udc, struct usb_gadget_driver *dri

     usb_gadget_udc_set_speed(udc, driver->speed);

-    ret =3D driver->bind(udc->gadget);
-    if (ret)
-        goto err1;
     ret =3D usb_gadget_udc_start(udc);
     if (ret) {
-        driver->unbind(udc->gadget);
         goto err1;
     }
-    usb_gadget_connect(udc->gadget);
+
+    /* Keep pullup disabled until interrupt is available */
+    usb_gadget_disconnect(udc->gadget);
+
+    ret =3D driver->bind(udc->gadget);
+    if (ret)
+        goto err1;

     return 0;
 err1:
