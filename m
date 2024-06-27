Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D76C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A82C888582;
	Thu, 27 Jun 2024 13:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mfV/QHAK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E741885A8; Thu, 27 Jun 2024 13:38:26 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F3A18857C
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35f090093d8so5114646f8f.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 04:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719488304; x=1720093104; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAnucIN6n3FUDlz4qYZDqZ2DV6VW3/zlRYBQxXBy+iw=;
 b=mfV/QHAKxbpmtNuEcnDB9dImC8E7RvABBUj15wWjNermuklVqqriaiocMF8OyNxRTf
 13/DUz3FhAB7tNCmUnacMrAnGCW95dsrQ4e/gdvhaGqsOu1f5h06YaekbQfW9OxoDbnD
 xcIQNla0yRLoJhXAPBjZEbLChjrZ7rEdpRsGUKWIVInNL3WS2FXVdnyWDnF2+A68sdEw
 w+whqyAgCljBH1nD/4V90cNIBN7zNXeT1AdDXr0/2eMTUALGCc8bvv28HpQsOfe8zUcA
 A1aohlNtxVXrUJot1yVzbUpKGuIhTkkd4jkYqmE4KrPn6Gxlvp1HK5Zs1cZ2YkDGNKsi
 vTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719488304; x=1720093104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAnucIN6n3FUDlz4qYZDqZ2DV6VW3/zlRYBQxXBy+iw=;
 b=swoD9Svrw8Gos/ECxHNjEr5xqRGApcl9PPlOE0NqmA0MZsk13wq41iP2PzLiGNXNxj
 sI7/JfHJmIdWlprkrrJwKfRdGIFhsroFVfBm8C/Qo8C6BJSbFoawzQYki54DzIPPrxS3
 80nkc72EcUV1gdM2NE8tLYiqt5TLKPkLGy33z8pasUX6Rl/s9d26N8P0f41W42oLI4zP
 pE672ZA2DKkDBM4H9++2s0IKmrnBWEH5p5GDHa7WrslApiWD5gKpnIbbvGGEm8+QRlNb
 AugMseYrS3+t9GsBReMHJcZRgprOBUeahXSSvnq0uogil0e0M0dFa3vk8Iz/L2GWoCoZ
 +MVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtQVRPkE2dRY3za1QFiC7YEQfZTlUwJyQSWo+G0ihF1Bm25urmE7puN4gn1aYf2kmJsNzRlwlUfbH+A92PjsN6h+u+6w==
X-Gm-Message-State: AOJu0YzCLdH+dEiTbJr2vb4GHG58P875rXLLGfzEh+m/RsDO+w0N6Rbt
 rPYTNIltOUpXAUBqYkzoGaW+jgKkiPHTDxCFcuo45Tj+VHpt+4L5qzyyDTDpkAvx/SR5y1kfBnT
 e6mQNuw3wX3v+8h8X0tYi/nl0Syo=
X-Google-Smtp-Source: AGHT+IFzTGkfVKbbzzki3lIHRRx/PdaUJpWHA+fiD8bTqMno/5Qj6ZXCeO/rknOWmZuVqQpYzzBQasea23wWOZikpE8=
X-Received: by 2002:a5d:4106:0:b0:360:83cd:ea2d with SMTP id
 ffacd0b85a97d-366e7a1b31fmr9101654f8f.24.1719488303509; Thu, 27 Jun 2024
 04:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240618120030.41502-1-clamor95@gmail.com>
 <20240618120030.41502-2-clamor95@gmail.com>
 <D2351R7O6BQT.1TQPPLXS6F5AL@nvidia.com>
 <634429E0-0747-400D-8457-2BA066B18FE4@gmail.com>
 <CAPVz0n088T_EiPLcTRdZtDzYh078pU8+wgiuM1yLzm5x5kBbcA@mail.gmail.com>
 <D2AROWD3G731.1MMULONQ6YK97@nvidia.com>
In-Reply-To: <D2AROWD3G731.1MMULONQ6YK97@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 27 Jun 2024 14:38:12 +0300
Message-ID: <CAPVz0n3ESKFyemDU+ut6Bng8RKpm+Gij6HVA+hQ0DaTkp1STCA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] include: configs: tegra-common-post: make usb
 first boot target
To: Thierry Reding <treding@nvidia.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 u-boot@lists.denx.de
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

=D1=87=D1=82, 27 =D1=87=D0=B5=D1=80=D0=B2. 2024=E2=80=AF=D1=80. =D0=BE 14:3=
6 Thierry Reding <treding@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu Jun 27, 2024 at 12:27 PM CEST, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 18 =D1=87=D0=B5=D1=80=D0=B2. 2024=E2=80=AF=D1=80. =D0=BE =
17:16 Svyatoslav <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > >
> > >
> > > 18 =D1=87=D0=B5=D1=80=D0=B2=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 15:23:09=
 GMT+03:00, Thierry Reding <treding@nvidia.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
> > > >On Tue Jun 18, 2024 at 2:00 PM CEST, Svyatoslav Ryhel wrote:
> > > >> This ensures that the device can boot from a USB device prior to M=
MC. Useful
> > > >> cases are when installing a new OS from USB while MMC still has a =
working OS
> > > >> configuration or if the OS configuration is broken in late boot st=
ages
> > > >> (kernel boots but the system does not start).
> > > >>
> > > >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > >> ---
> > > >>  include/configs/tegra-common-post.h | 2 +-
> > > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > >What's the implication of this if no USB mass storage device is foun=
d?
> > > >How does this behave when USB cannot be read or booting from it does=
n't
> > > >work?
> > > >
> > > >I vaguely recall that boot order doesn't always proceed, though
> > > >admittedly I haven't tested all of these edge-cases in a long time.
> > > >
> > > >Thierry
> > >
> > > If no USB mass storage is found bootflow will continue with the next
> > > device in the list (mmc1) with co-responding info that booting from
> > > usb failed. I have tested this on lg p895 which has only mmc0 and
> > > with asus transformers which have usb, mmc0 and mmc1 in all
> > > possible configurations. I did not have booting issues whatsoever.
> > > ATM, transformers use boot order which I have proposed in this
> > > commit.
> > >
> > > Best regards,
> > > Svyatoslav R.
> >
> > Thierry,
> >
> > Since you have not responded to my statement above I assume that
> > you are fine with applying this change. In case you have any
> > objections please answer as soon as you can since I am planning to
> > include it into merge request for the next merge window.
>
> Sorry, I had meant to reply to this. I have no objections if this was
> properly tested and there's a reasonable fallback that works.
>

Np. Thanks for feedback!

> Thierry
