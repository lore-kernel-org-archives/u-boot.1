Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1B5E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 10:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08544895D8;
	Fri,  6 Dec 2024 11:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EUda8RlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C6E895EC; Fri,  6 Dec 2024 11:26:43 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C867895AE
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 11:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d123ac1c3cso2029841a12.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 02:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733480800; x=1734085600; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wbkH4RCm+gz++FZ/258sv0My7+DQU1Xuw6Jj/pudXj4=;
 b=EUda8RlHm6VRkDKaAzI08Mf/Pqwv2i2JDJQBJmR+Tyx+r0sEo+2Am0CvM9iWk6+nuc
 CdFb1p1wD4Kw5eOtgYstUu59PkVOaMozHdMT8LtL/Yu1/peepQW3USNpvlIBxGYDz41c
 5qpaZSVrsZPhdGHoCEuju+pr0sGC2x7OJNk43OiItCZF8985+RK4+ZZZ252KJy97R/NX
 9yCqzlpIZbGpuGg4z+WB3BvczrgrGoCZ6BleOBC7Jt4UIoXDunUcgAzdJlh7o/5mKOHI
 HM3ZVeRfqYC+MB6k+gP+nKI+W+uH/z2rT/4S5RQk0B1yv413H/wym/VHpxUgU/tBySHL
 m1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733480800; x=1734085600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wbkH4RCm+gz++FZ/258sv0My7+DQU1Xuw6Jj/pudXj4=;
 b=p4x26S2JKLHTs1Rld1TuldQlwQQQ9dF2Kfy/d1TXSasJuyumrouS6Hwwo1m9jVIE5K
 5bvzAPvMl6sSxy20IShjAinlIc574d5VXzvIhevdAq8sNfsWh1e92w/UMUZlB674j7ns
 IYCKCZhVgDyMzlBMOTUaTYfQZUQoTChqIY5bJ/Sdqq9ysYg8UuhkgDLhVNYKAvn+l81G
 wIsmwZ+5dVqyDwgslggfopYU0kBJY9g2GEpO36E+a9UXMgfX4F49UpDMThrtkAsJaV2I
 /ZM4SrKzTl/lIGg84VHUIS8KcRS5ova5NJEh8KwQHmkOgeiJsUkoRUFyTGMixE1br47O
 XZwg==
X-Gm-Message-State: AOJu0YzqnWmg68gjJyPBEzZNSaOtSG4N/d1PrK5G4+hP3yxSIR6wm0pw
 XLGunHBq04CS4Oy6FaDF0J1K8OfRWt3cH+zbt/ldVF0TmZiln5yB+eUae5ZjOkaX9LPWWWjLkrl
 5SvW2p4T0FdKJHK8Z2bc0+h6pPQE=
X-Gm-Gg: ASbGncunSq8NwxRkaI7Bu7fvzJBQq7rHr+K0vwyhyupRBXCkkxAfVm2KsJ9rUenYVwB
 WcuhiMQVwNYa1WYHnjCEh4mA0oqtNpHDJikI=
X-Google-Smtp-Source: AGHT+IEQ5oP9TwN/CmSkp7WL+BbbUB845max383oRcjtp2EnEO/78DMI5jwGSlngVTg08LNrH7fp5HaaKBzJyazSwgo=
X-Received: by 2002:a05:6402:5411:b0:5d0:8889:de02 with SMTP id
 4fb4d7f45d1cf-5d3be7ab92dmr1865471a12.22.1733480800367; Fri, 06 Dec 2024
 02:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <20241103003322.626036-6-sjg@chromium.org>
 <CAFLszTiAW3w1m2c0t0B3VzJpgkuFWcs-vMP-iPu0yj92GbFBog@mail.gmail.com>
In-Reply-To: <CAFLszTiAW3w1m2c0t0B3VzJpgkuFWcs-vMP-iPu0yj92GbFBog@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 6 Dec 2024 10:26:29 +0000
Message-ID: <CALeDE9P6GWKVbvjhDemz5DtbrtUsamy1UL8W0chAKHih5SJ7qQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/25] led: Drop LED_STATUS_BOARD_SPECIFIC
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 3 Dec 2024 at 19:48, Simon Glass <sjg@chromium.org> wrote:

> On Sat, 2 Nov 2024 at 18:35, Simon Glass <sjg@chromium.org> wrote:
> >
> > This is not used by any board and there is a driver model version of
> > LEDs. Drop it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  cmd/legacy_led.c     | 40 ----------------------------------------
> >  drivers/led/Kconfig  |  6 ------
> >  include/status_led.h | 13 +------------
> >  3 files changed, 1 insertion(+), 58 deletions(-)
>
> Applied to ci/master, thanks!
>

Why is this being applied via a ci branch? I don't think that is
appropriate!!!
