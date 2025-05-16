Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130BAC3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 18:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B48A82AFC;
	Fri, 16 May 2025 20:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EcnmA9HB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E44982B07; Fri, 16 May 2025 20:57:25 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 498CA82A8B
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 20:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-70a56b846d8so25686137b3.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747421842; x=1748026642; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ThQihQ9ayMDwu8GMCJpiIrFE5sWm3Io8Q3bcB4AOBKI=;
 b=EcnmA9HBIRWuTsqECDGHBJjcVMxfTJyn751l3jGnhA7dEu1ND5Z2k4IzRwW8Uc8cKT
 ALUg1UKO3QS5gYKqS2RbOxvF0+NnBa+zgqjMeLw/R5uQmtgZ6oarCP12MiZO+vixiqDi
 Yac5mBGukprTfVdL/9bd8nOr62wL68OLUioOFGtCRM5qoN2HWL82KmSEbGp/btMafIC+
 /L3l7sIJeBSQb9MiSiO5MUqK6OeBf4tmSeRxHhEcrXJg5aZcDAgu93vsEwGJR0aycA2D
 Zf/quHzDnfWh0IagvoP+t24PIJfmYhPd5DS+t9wwem98IfYkUnV91WCyqFYcuopJu4SB
 RKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747421842; x=1748026642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ThQihQ9ayMDwu8GMCJpiIrFE5sWm3Io8Q3bcB4AOBKI=;
 b=in2jBOkiXrHMLLODa7jwtzqg6GW3pjh3JmUek04VTDLy5fY43CFfwVreCb1meuxPlg
 Ur41ugGBkBIwCuE6Za9ybe95q8lDpDASR4CNj1kP/0EMnJQqjGEqMCDUUf+e5szGVpJh
 6sd6qFKogoABT9Hnpj1PIGSd7abxzkVgcQwpqKJdQmsvBpxF87Yu2Vf24Ix0ZeHBe6in
 qQFF1jpUGjtB/4wjhPvsOto54lhNUiRXfrKkTlJ3VSyu5w1AwynpIgc+UF+F1g0Aymt/
 09uQRgM0/km6RFWq32eZ32OPyVxcos43BzL4hBpWlJqFVEIJt2tAXg7oITElIzT9a1pz
 wWPQ==
X-Gm-Message-State: AOJu0Yzza3hj5EzeCk1T7EIAM/dZWora+y3FcS0gcsYsFs83S3c/HFsm
 M8DxpEjtyGhge4Z2oe9kOrDEPY4brFkSRCnjcPtKyqmGzFcVYRg6EkjnkQNKR/pLqmF4nyQ0lf4
 XI0C//DiAY0ZzGfytiEA+GmJx3dGSGm4=
X-Gm-Gg: ASbGncu/BHYDKpq8K6JYQXwAC+NumcTNPRITbwEntRGdRhjiK/QGj0062KeHQmFpxD/
 7H63+vImwDzGtgmZCHtF5BUekVJRbduGaG6UbHE7/jMvN8oQ9+uPE7GSNn3OrKHYTlVuQDaPAXi
 byB3vLvHDxVlLTGbO5irOTgdXVqJo/bOyd
X-Google-Smtp-Source: AGHT+IHgLS2TV74DITpjDzG8f6UCgWyMnxoahfOuJY7WGAhkW2IJhC5DPlcD1iBgiVJiaT7dEGYrFXxFG4fKoAWGaeI=
X-Received: by 2002:a05:690c:4b8f:b0:6f9:8436:3d2a with SMTP id
 00721157ae682-70cab0cc12cmr54144247b3.32.1747421841890; Fri, 16 May 2025
 11:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250516175434.124221-1-ant.v.moryakov@gmail.com>
 <20250516183153.GL100073@bill-the-cat>
In-Reply-To: <20250516183153.GL100073@bill-the-cat>
From: Anton Moryakov <ant.v.moryakov@gmail.com>
Date: Fri, 16 May 2025 21:57:11 +0300
X-Gm-Features: AX0GCFuuDRCjLJ_hksvzJP-Abr6Fw7IoQ0J-oy8mev7GCArj6Tfz-bHrm2Q9I0c
Message-ID: <CAHb2+K4rHfzLTg8ikQAZ1WowDWb8PHz3TO5NnSm2phSy4T10Gg@mail.gmail.com>
Subject: Re: [PATCH] drivers: usb: host: fix prevent memory leak in interrupt
 message submission
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Thanks Tom =E2=80=94 you're right, that `goto` after `return` is unreachabl=
e. I'll
fix that and resend with the corrected flow.

=D0=BF=D1=82, 16 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 21:31, Tom =
Rini <trini@konsulko.com>:

> On Fri, May 16, 2025 at 08:54:34PM +0300, ant.v.moryakov@gmail.com wrote:
>
> > From: Anton Moryakov <ant.v.moryakov@gmail.com>
> >
> > Ensure int_queue is properly destroyed when receiving wrong buffer
> > by adding error handling path. Fixes memory leak that occurred
> > when backbuffer validation failed.
> >
> > Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> > ---
> >  drivers/usb/host/ehci-hcd.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> > index 7d5519c65a9..765d8b327ee 100644
> > --- a/drivers/usb/host/ehci-hcd.c
> > +++ b/drivers/usb/host/ehci-hcd.c
> > @@ -1557,6 +1557,7 @@ static int _ehci_submit_int_msg(struct usb_device
> *dev, unsigned long pipe,
> >               debug("got wrong buffer back (%p instead of %p)\n",
> >                     backbuffer, buffer);
> >               return -EINVAL;
> > +             goto err;
>
> A goto after return cannot be right, and should have had some compiler
> warnings too.
>
> --
> Tom
>
