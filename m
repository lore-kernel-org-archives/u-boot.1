Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE29D1119B
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 02:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B93388D3A;
	Mon,  4 Nov 2024 03:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X7tOFCc/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7AB58911A; Mon,  4 Nov 2024 03:00:39 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57EE688D3A
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 03:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ea7ad1e01fso2526246a12.0
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 18:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730685636; x=1731290436; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLF8VwtvhjrzSNK/tAN4F/LJMkR5fbXCyQTX2Ga1DqU=;
 b=X7tOFCc/z1En483GILWDR0nONHG1prW7iGN6nHAPXiUMCbKMdCklHMAmDuEgMLS9u/
 SAjzOQk8eSSuH0uDiTFFxsFHfZwZjpuwNv9h8fpugeCXECt/3il6cRH/dL1HdWJT3NzB
 rXI5B3B3HzQtXyZtbV5fJXEuFVcSPHJL5w7+gKZ80zs1BJf9++3P5ZF1+spKUAAMvEUH
 VJyvPqJn+4JyDgYzuzUT0VLr8gqJa8SQcy+oYbiTsbw79mN9olfuXWIr4rUAfmeSiWSw
 otwqTPqPR0Xne/CpaW6NHU9i4/n1OlyUxdbNLj/HsZ4DoouCxRl+7TYbYC1711Z87THD
 KLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730685636; x=1731290436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RLF8VwtvhjrzSNK/tAN4F/LJMkR5fbXCyQTX2Ga1DqU=;
 b=RNNeZvGUNUJeBJbOLVbCRELLr4qLiiFzGRbds2tmhJ858rxPxp2wHYkCQyx8SHKwDe
 tQFe71E2zFaZ/BPMe4cLhWEIidFNyyIV12o8qpgbtVpkKDBrkHcX2QyHMw1rUT9aQ1ot
 jtUTwMxfSZDg09GkGYe75L613oE0gH8EtJsLsqjk/YvBj6mDy3biUCxR/sMt5JJutRwS
 TARtVcSCQPsqPf/4ojhsTLWeqgFL8crTo3UwXvw3O9fLjlRfT85VrBmfM0AXcoKXFC9Q
 CCe/o9ZGn8sRNdmThOdvfi2fu3DkHRaeYyaDUlKj8w8DzAPQ7OQ1cT04jF5+EjF1Ryv0
 bHDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUHZBaIKdPxFZPuXCV4EdQm9D0I4f0gBuzxFYOGJ97m0vw6pUiAGSBnxW63eEdQWIBoOuXLNQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyzuSlTpXMDPO1+L6ZICve1NUTlGZW5KgkirZRuxFD/S/hA9KJA
 MdIiN9icF7iGFFSX2k2jgC2YWRUhC0nreO+dbn9DZNyZkcjWEKYceH+qJ0fFvIXsJFdahbYMZmr
 wIoZOTIFMZOFMugAdBqyCWdAZVWE=
X-Google-Smtp-Source: AGHT+IGvJH83syC1oOMu5WHWA+iVKUqjquyVpAXJQxM/HuqcsaBP5c8juR/wa5EynbpMpUncJF2vVtFVJFIIemvUzjU=
X-Received: by 2002:a17:90b:4f44:b0:2e2:c2b0:d03e with SMTP id
 98e67ed59e1d1-2e93e0768damr21537691a91.5.1730685635573; Sun, 03 Nov 2024
 18:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
 <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
 <CAFLszTggpR9aaDAH_Mx_zDNnKAb7r_O+sdyyVVG_xULqkrWnzg@mail.gmail.com>
 <20240828100452.2143873d@wsk>
 <CAHCN7xLY4FxB4HZLcE0pEZsx7V=dhVokh2Wcrn2Jjf+B+SLCJg@mail.gmail.com>
 <20240905155402.486a7110@wsk>
 <CAHCN7x+jLfzMGFUcbAfHr9u_2s3Z=LxN-TNCtbzUUop66p4Rpw@mail.gmail.com>
In-Reply-To: <CAHCN7x+jLfzMGFUcbAfHr9u_2s3Z=LxN-TNCtbzUUop66p4Rpw@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 3 Nov 2024 20:00:22 -0600
Message-ID: <CAHCN7xK3-iUUGf20-JxAWfK05-te=sskbdpU4kU8ahy8sfROFg@mail.gmail.com>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
To: Lukasz Majewski <lukma@denx.de>
Cc: Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>
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

On Sun, Nov 3, 2024 at 7:41=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> On Thu, Sep 5, 2024 at 8:54=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wr=
ote:
> >
> > Hi Adam,
> >
> > > On Wed, Aug 28, 2024 at 3:04=E2=80=AFAM Lukasz Majewski <lukma@denx.d=
e> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > > Hi,
> > > > >
> > > > > On Tue, 27 Aug 2024 at 12:47, Fabio Estevam <festevam@gmail.com>
> > > > > wrote:
> > > > > >
> > > > > > Hi Lukasz,
> > > > > >
> > > > > > On Thu, Aug 15, 2024 at 5:14=E2=80=AFPM Lukasz Majewski <lukma@=
denx.de>
> > > > > > wrote:
> > > > > > > Unfortunately not - this change is only for properly setting
> > > > > > > start address of the u-boot.
> > > > > > >
> > > > > > > The _real_ problem here is the symbol placement generated by
> > > > > > > binman when we try to define the image as a single one.
> > > > > > >
> > > > > > > Moreover, this change follows other boards with imx8mm
> > > > > > > processor - ./configs/imx8mm_beacon_fspi_defconfig to be
> > > > > > > specific.
> > > > > > >
> > > > > > > The "fix" (for which I'd been now probably opt) for this issu=
e
> > > > > > > would be to generate two images with binman - one for
> > > > > > > u-boot-spl-ddr.bin and the final flash.bin with the former on=
e
> > > > > > > included (as it was before SHA1:
> > > > > > > 37e50627efacd8dae18b564e9d8886a033e181bc)
> > > > > >
> > > > > > Is QSPI boot broken on i.MX8MM?
> > > > > >
> > > > > > I am adding Adam and Mamta who have tested QSPI booting on
> > > > > > imx8mm_beacon and imx8mm_evk, respectively.
> > > > >
> > > > > Note also that I sent a series[1] which allows the symbols-base
> > > > > to be adjusted, if that helps.
> > > >
> > > > I've seen them - but not yet tested.
> > > >
> > > > Thanks Simon for the patch series.
> > >
> > > Is it still broken with this patch series?  I have been traveling and
> > > haven't had much time to test.
> >
> > Yes, I can confirm that it is still broken.
>
> Sorry for the delay.  I had to return my 8MM to Beacon, and I was
> waiting for a replacement.
>
> To not prolong it anymore, I decided to try it with an 8M Nano, and I
> got a boot failure on master. I was able to successfully boot
> 2024.01-rc5, but I haven't had time to bisect it yet.  I'll try to do
> that this week.  I think once we can bisect the error, it might become
> more apparent.

Git bisect narrowed down the git which broke the build:

commit 37e50627efacd8dae18b564e9d8886a033e181bc (HEAD)
Author: Marek Vasut <marex@denx.de>
Date:   Fri Apr 26 01:00:37 2024 +0200

    ARM: dts: imx: Convert i.MX8M flash.bin image generation to binman

I am guessing the binman isn't prepending the header stuff.  I'll try
to investigate it this week.

adam

>
> adam
>
> >
> > I've applied:
> > https://patchwork.ozlabs.org/project/uboot/cover/20240826191143.426387-=
1-sjg@chromium.org/
> >
> > on top of mainline:
> > SHA1: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
> >
> > Adding symbols-base =3D <0>; to imx8mm-u-boot.dtsi did not help.
> >
> > >
> > > adam
> > > >
> > > > >
> > > > > Regards,
> > > > > Simon
> > > > >
> > > > > [1]
> > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D421010
> > > >
> > > >
> > > >
> > > >
> > > > Best regards,
> > > >
> > > > Lukasz Majewski
> > > >
> > > > --
> > > >
> > > > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > > > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > > > lukma@denx.de
> >
> >
> >
> >
> > Best regards,
> >
> > Lukasz Majewski
> >
> > --
> >
> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.d=
e
