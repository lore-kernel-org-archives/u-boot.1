Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2E0E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 13:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3346D80040;
	Sun, 15 Dec 2024 14:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y+PNP4aK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C408004F; Sun, 15 Dec 2024 14:24:10 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED70C8001F
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 14:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-30034ad2ca3so26924271fa.1
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 05:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734269047; x=1734873847; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AspOJNSW3qiBqml6bQs7edXRSwXqzkwUAmtvazEPGUY=;
 b=Y+PNP4aKGmeERvVf/oqr3oQfP5aaJ8BUDVvGcXQkleP84daW5a4jSqHiNgaQTZjS8c
 8wAnMDCrhhkQZv+qs1kq2u0r+GFkBuBNiwd3g2qiGs/akkM9Vi3xL0UjJtTvf72y0piR
 VR+zVCJi8PiuCJEp+MRq0lhs3XmxSjYMtuWp6AZBu3ktuf5gWav8mFfMJYBrferpYGX4
 H7zHFn6BO0j3zYs/ZBpqIuV1G1RkwKPZN890qoqp04IGygGf1820348RFcm0HFnhJiDw
 rqBmx/qfXfgxCsmLhrsJUNcrswA2tDtl7LFDjvh5hdIf3lYvNaLn//gbwDCdaPS+nn8Z
 0BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734269047; x=1734873847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AspOJNSW3qiBqml6bQs7edXRSwXqzkwUAmtvazEPGUY=;
 b=BUJAmohpjPnRWSKQrWK/uOrvC4qSIEHphUsDQep5b7+9hBgNiZoE9/rorT23sNjhHH
 2PVyaHdmkzeFva2BE17WbR12GdpFSOOu+u5nPBKqS1rM94+6+3C1aSm7BPzZg5nhv4Q8
 xhCqWUgY3lCVO/WGAhDiNSaPwsH0jBay4eMCwP0MlQf4EPhsib7/+ymGVFIncDn6r3Ic
 gA2x6VvcHsv/1oPRmqIfVsN+ePTlqSQ1p/D+bZ1I117oTA2ygkF2BS1zb4TooMqsBzvM
 c8GCaCa6tBZN9/RrdSHjLcIcZgfeJSWgiqqhUTCk9ekHZDRFwuRTdii1NXk/VITCRn4V
 gB5g==
X-Gm-Message-State: AOJu0Yw4EBqyMXUMwg8PWJFFfs1OFdhzjLDiHyeqYW8NrTeK9rYm1onG
 s8lBCZVthqZQWdKpgx44bGz274YcsF0ReHN4b97mc/5SHsZ49R0BxbCkg6WXzGit+ilWevzJxSR
 2iSQlJwWLBWtUmfmqqV6bc/jeQwax9qAw
X-Gm-Gg: ASbGncuqsZkl0GVzfejlHxgqcs/shUOHwCWxzxUGA7qcGqEG2ly+mTe0FlNyQudh4AG
 vjKtphVpwGyVRRXggANnevvOjuXJM97C/t+Gy/vfGL0ezvvyh5suN7AAD99Dj+p+wHra7
X-Google-Smtp-Source: AGHT+IFVT5DjQl7Cco0Ys1q5RZmrJeGW1lrVYmPZXbx9SW8ebF76Hqa9HbRQQXKkJRmD1WGe/U3hmX94AXU0u1G7DVU=
X-Received: by 2002:a05:6512:3996:b0:540:1d58:da7b with SMTP id
 2adb3069b0e04-5408ad7f99dmr2719655e87.11.1734269047048; Sun, 15 Dec 2024
 05:24:07 -0800 (PST)
MIME-Version: 1.0
References: <CAJvHTNwFr4B=aNomxJ+davqz6eWG59E7H2Zh8=UnROsPyu=tuw@mail.gmail.com>
In-Reply-To: <CAJvHTNwFr4B=aNomxJ+davqz6eWG59E7H2Zh8=UnROsPyu=tuw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 15 Dec 2024 10:23:55 -0300
Message-ID: <CAOMZO5Dvyom8AyO0RpkcrCdk_349Mxum4Lc=o28fZBQGZEBCiA@mail.gmail.com>
Subject: Re: clang: error: unsupported option '-ffixed-x18' for target
 'arm-linux-gnueabi'
To: Jack Andrews <effbiae@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Dec 15, 2024 at 10:07=E2=80=AFAM Jack Andrews <effbiae@gmail.com> w=
rote:
>
> thanks for uboot!
>
> i'm trying to build uboot for raspi 4.
> these steps produced warnings and a compile error
> ```
> $ git clone https://source.denx.de/u-boot/u-boot.git
> $ cd u-boot/

> $ make CC=3Dclang rpi_4_defconfig
> clang: error: unsupported option '-ffixed-x18' for target

rpi_4_defconfig is a 64-bit target according to
doc/board/broadcom/raspberrypi.rst.

export ARCH=3Darm64
export CROSS_COMPILE=3D/usr/bin/aarch64-linux-gnu-
make rpi_4_defconfig
make

In your case, you need to use a 64-bit clang.
