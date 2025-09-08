Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6193FCAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 13:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94FE5809A5;
	Mon,  8 Sep 2025 15:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WyWQv7Hi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8286830E4; Mon,  8 Sep 2025 15:56:08 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF0880077
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 15:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3e4aeaa57b9so2041087f8f.1
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 06:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757339766; x=1757944566; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZX/LILXJ2XkebyMvxVn/v6pwueFgfxTr+AYiDHLn+ws=;
 b=WyWQv7Hi2jrNEUnH2gfCMapIhkJ7pHSwkYVRC2mh46B2Vh1kCmVqJoFyE93KdCQTHW
 m0neXU2I/m+a+MoVOp2izhVGkROr6yjzZIxRkc9FYSRQgJnkjJoz+39YcRXQz2WPoZN8
 VKfms83SG2L2DL25FRtvw9FN38A1V7WnsKI6SLSdZK4MWZM+Q+w8O+dHFGJ6OcmsxEQB
 ldkgnBTzsYgcbYGPx1wngER4SIK9doXzL1KQFcaBQ2DePUiEuxIgMZ7ikvg7NOh3XHyd
 01bCufqo3ysH0GvsSesPCYkUYZtTb88QuIQRVu/40wzonug+b+/UEiBG0ALpRZsyNCiC
 nSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757339766; x=1757944566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZX/LILXJ2XkebyMvxVn/v6pwueFgfxTr+AYiDHLn+ws=;
 b=rWdneIwo8zNhTglgSayQw0XMyIom6RL6OBSHy02GjcQG/I2/y9nPFqe/7cecTRvQDf
 h4uMUCZJemLaqQuDiwSrnfvtXDMy6oluvRK3b/JX1E+MFye3qr6uePMQK/Vr00Zf3ho4
 X+n+vc208loTqwfQbKpzpESQ5uSYViU2yxUHhfYMDCkgUD8JPVebB25/KoYs/M244MK3
 GwoSN1zEW8JxY5i4RJLkon+y/yn80dCRq8NcHzTtC/D25pQ0FFaGWXpfrFFBLsytA2x2
 HskmuigBX5jEGQIAzKsUUR/h0PpuwNUecNXSm+Jm5XMmzX43i7ew8gy/nMjVrhFDOGNY
 RJAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCWu922MhB3CPbQmyl8hEKIVPIOdohVX1vwnSXjelYTyxWLFvCo4toDoj2FEyfZWzTMFnKKHM=@lists.denx.de
X-Gm-Message-State: AOJu0YwgKZG53vgB0GuXetjW+oEv8yooJP3bc+yMwpQxvj0dux9aHrFl
 1UeYhKrkVptfISPEPz+JqPS3l9ZiwcBXIGTNWvGDeDQrCz8kNSRBLT6erQyNszePcrp5QV1tOKm
 WNDIfxJ6gKOL4TaD1I8lb2f5wBPBl0gU=
X-Gm-Gg: ASbGncutFRXRtHNNXMKWroKCKud4+hRKNe2O8JtPheZ+h4iTTsWzAINugnIrgTlwXZU
 ycWr5P4f/7kxNM8fC/P/WjYfORgkWJ2ceBqMEUm8pv4j9qHAlzPbU6qlimeDSjR6ItU/c/BY3X2
 hLWB7TfTnRL4VBvgcqV0BBmNZm+hThvG1wnoisuo/xPapIDY7j2I/598jwkaZ1I6m+/TZORUHa+
 lY9tAfc
X-Google-Smtp-Source: AGHT+IHcPscBoGpoTyct8UkcmMN/Gc8J6Qh94UyRMCm/AR1uk+saaqUoMnaVVo31d7OjeyosHuNgYOhj7iFj2DnbpdM=
X-Received: by 2002:a05:6000:40d9:b0:3da:d8a1:9b86 with SMTP id
 ffacd0b85a97d-3e645e85aafmr5048599f8f.50.1757339766139; Mon, 08 Sep 2025
 06:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250826093936.3521235-1-lukma@nabladev.com>
 <CAPVz0n3wpLtXB=1ZS4WiihVkDPTza75dXDKMjD63OyeSQwACRQ@mail.gmail.com>
 <20250908144107.10bcb8a1@wsk>
In-Reply-To: <20250908144107.10bcb8a1@wsk>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 8 Sep 2025 16:55:53 +0300
X-Gm-Features: AS18NWADaoWPsSxau0xv-xV7Pwngq0mj6kA5gLP-F7UvSCM31eRDQ2RONVCdTL8
Message-ID: <CAPVz0n3XoeMmGO7YpVPrej-R2m-vR1T_D1GsEbxJM+iJVGhAfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node is
 processed
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
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

=D0=BF=D0=BD, 8 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 15:41 =C5=
=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> > =D0=B2=D1=82, 26 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE =
12:39 Lukasz Majewski <lukma@nabladev.com>
> > =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > The Tegra30 SoC is a bit special, as it doesn't have the separate
> > > IP block to provide watchdog functionality.
> > >
> > > Instead, timer IP block allows such functionality when properly
> > > configured.
> > >
> > > As in the tegra30.dtsi there is a timer node, which "covers" all
> > > timers, with 'nvidia,tegra30-timer' compatibility it was necessary
> > > to manually bind U-Boot's WDT driver (based on WDT_UCLASS).
> > >
> > > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > > ---
> > >  drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> >
> > What is the practical application for this diver in therms of Tegra
> > and U-Boot overall?
>
> You have the WDT functionality working. It uses the same DTS bindings
> as ones used in Linux.

Why do we need WDT for Tegra in U-Boot at all? It is not used and has
no practical application.

> > Where is can be used so that existing means of
> > U-Boot cannot handle such case?
>
> Currently u-boot for Tegra 30 doesn't support Watchdog at all...

Yes, and it does not affect or break anything.

> You have for example collibri T30 modules without WDT functionality
> support.

Correct and? ALL Tegra devices work perfectly fine WITHOUT WDT

> After adding those patches you can use WDT class (and wdt command) to
> control WDT.
>

And what is the benefit? To have a driver for the sake of having a driver?

> Do you have more specific questions?
>
>
> It is strange, but I've just noticed your reply (caused probably by my
> "work" mail switch), so I would like to apologize for a late reply.
>
>
> --
> Best regards,
>
> Lukasz Majewski
>
> --
> Nabla Software Engineering GmbH
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Geschftsfhrer : Stefano Babic
