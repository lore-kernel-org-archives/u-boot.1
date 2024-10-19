Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B612D3C920
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 16:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9EB88EC9;
	Sat, 19 Oct 2024 18:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qDf696az";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A98B888EF5; Sat, 19 Oct 2024 18:36:56 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7281688DD1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 18:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-460c1ba306bso4959691cf.2
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729355813; x=1729960613; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H4dc1w2sNEN3Mj6RIu4xjtBQ3zbSooZVWecOenRZFBY=;
 b=qDf696azlCKBJ52QPs58p4aceGG/2uawc+LGowy4/2H9zIKa/ZuE4ynYTEWdylo+Am
 02igXs1+pARY8viIUeIC35owhI8VuyR3kVIoGMSb0Q28XLngpHZlBHx28vzFvp4dJRhw
 FXOZi0JY57q7zI3ZDQmDP4wY/HHK2EyDpCGTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729355813; x=1729960613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4dc1w2sNEN3Mj6RIu4xjtBQ3zbSooZVWecOenRZFBY=;
 b=TSwPb84NW9t597Fm11d8MiaGsvvB4yBSqjQqAykLdQMsZgeVgLlBQKn0vT8yZMTroy
 Ukw7xummBMURzR2cAX+huz+tsiEsnh2z8IH92Sp9TguYcLUsiC+EN44Ku4HIgux0R4jQ
 raBPFP8yCSLxq1PgSdc+9qgKJrn3QUbc2gM0F+Q2glSxLA7EeI7gQTp0+cmwDkQEidSb
 /qqiSei0k0NB7t4+DJuBMKQWTirA7HStyLQjtIZf8mjD2d/FwUcnOpRsTJsX389/Ool8
 zhOjzwUJhzxvKqwsmRHh7cZjJXH/7e1e5hZCGSA7vGD2Zt4yBz4RZegV4hgXbrG3V7wO
 YCpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU733E8SB+HY0V1/B11AAVlevyNCBMD0N4tfO26Z1T1Dz1KKNYfcAPvhCtwKQFyIyIcXishgbU=@lists.denx.de
X-Gm-Message-State: AOJu0YzOVIEJMhzuLHc8NuF1m//QDUj1q7GQd5U3y4ND/HYy0DxkbRwH
 DpSiNHLa0bziprdFUJk7hx+iuocT8UkbiK7NQJhL2I7fSzmSJRp5DUMoBOzcsxI=
X-Google-Smtp-Source: AGHT+IEb8tHX40yWLUN3DNGtoDEfDcilKuRu4vHl2s3sFaM0xrBVO1D8dHtXkpyIWUiljBnucvK1Zg==
X-Received: by 2002:ac8:7c45:0:b0:460:ac3e:cf6 with SMTP id
 d75a77b69052e-460aee3eba3mr95951481cf.53.1729355813236; 
 Sat, 19 Oct 2024 09:36:53 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460aea450d4sm20123641cf.62.2024.10.19.09.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 09:36:52 -0700 (PDT)
Date: Sat, 19 Oct 2024 10:36:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Artur Rojek <artur@conclusive.pl>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v4 0/5] Adjust initial EFI memory-allocation to be in the
 U-Boot region
Message-ID: <20241019163648.GW4959@bill-the-cat>
References: <20241011212126.747741-1-sjg@chromium.org>
 <CAC_iWjKD=05pf=gcfCPUA0mGNbAX+jjyx5D03y0MWJRgxYDPOA@mail.gmail.com>
 <CAFLszTgJW2KPbD1dogSVKbxgyYtvKGgSAcB_j5kXtWdkTGvtNA@mail.gmail.com>
 <CAC_iWjJdoFLAyaa+NBoY1Hm0Q140ExU0rq-RKEqDV_yki9jojA@mail.gmail.com>
 <CAFLszThSFuAPnsOTw_4w6raWJzOojp16ULT88s9JgwoWcpMwJQ@mail.gmail.com>
 <20241017233458.GQ4959@bill-the-cat>
 <CAFLszTgKLYa9RYERvAiuJ89wSKG-Ane=FxsDuvvFBpBpS0QF+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SSgtj/USuBRNteb1"
Content-Disposition: inline
In-Reply-To: <CAFLszTgKLYa9RYERvAiuJ89wSKG-Ane=FxsDuvvFBpBpS0QF+w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--SSgtj/USuBRNteb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 05:51:03AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 17 Oct 2024 at 17:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Oct 17, 2024 at 05:22:52PM -0600, Simon Glass wrote:
> > > Hi Ilias,
> > >
> > > On Tue, 15 Oct 2024 at 07:32, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Tue, 15 Oct 2024 at 16:26, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Mon, 14 Oct 2024 at 22:28, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Sat, 12 Oct 2024 at 00:23, Simon Glass <sjg@chromium.org> wr=
ote:
> > > > > > >
> > > > > > > U-Boot relocates itself to the top of memory and is supposed =
to avoid
> > > > > > > using any memory below that region. This allows the maximum a=
mount of
> > > > > > > memory to be available for loading images.
> > > > > > >
> > > > > > > The lmb subsystem automatically protects U-Boot's code and da=
ta from
> > > > > > > being overwritten. It relies on this region being a contiguou=
s area of
> > > > > > > memory. This setup has worked well for at least 15 years and =
has been
> > > > > > > documented in the README for as long.
> > > > > > >
> > > > > > > The EFI_LOADER subsystem currently uses memory outside the U-=
Boot region
> > > > > > > when starting up.
> > > > > > >
> > > > > > > Some of the downstream problems this causes are:
> > > > > > >
> > > > > > > 1. It can overwrite images that have been loaded
> > > > > >
> > > > > > So can the load command
> > > > >
> > > > > Can you point to where? If lmb is enabled, it should be using tha=
t, so
> > > > > not overwrite anything.
> > > > >
> > > >
> > > > If you load the initrd in memory X and make the kernel ovelap you w=
ill
> > > > overwrite parts of the initrd.
> > >
> > > But lmb stops that. It is actually what it is for.
> > >
> > > > Let's try once again, the ''''problem''' that was discussed in IRC,=
 is
> > > > that the initramfs overwrites memory that was allocated by the EFI
> > > > subsystem *because* we haven't merged the LMB followup patches yet.
> > >
> > > OK, my problem was booting Ubuntu where the bootflow was unbound by
> > > exit-boot-services, resulting in freeing memory (and re-using it)
> > > which was still in use. I don't actually remember what was in that
> > > memory, though. This was over a year ago, when I sent my first version
> > > of the test[1]
> >
> > This was on x86 as well, yes? I believe that's what you said on the call
> > and part of where people get confused I believe.
>=20
> Yes, x86

I just want to emphasize that this is a rather critical detail that was
unintentionally omitted and lead to much of the confusion. This is a
heavily tested path on aarch64 and I strongly suspect riscv and then I'm
not sure who aside from you is testing this path on x86.

--=20
Tom

--SSgtj/USuBRNteb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcT4CAACgkQFHw5/5Y0
tyy7DwwAulCr+jEKXB2FTLQeELCTkl+XUQtmTXQVfhzpINyLgGGHNZFojodu4ouO
RUmJ0+SUYsJasP6OP96eq1b+uIdpqgRmv9rvRSpsNviYAFveu5N20kV9Hbl0JGed
Tg+ViyTzDy58idCcZj3ER01BPgijhl49goHKNIfYjo2ASh8p1R2vr0kKRqfSLEzp
zGcCwiM8OPiykjj9cfS8EeehwBtwLyaTiOfTp2CaeFJznXHCQgt16H2z4Ui6BqAF
ot1MT6zqpzKs0zw+EFwVY1ZTfd8186kIr4sAyFFpCm0TDrulDEcaif1nVRkTXb3s
u3ATPTY1lsBlCPnUJC1dWPP0CEKoY09ESVVc3EiSGKOl8oRIDOp+aSNDKG3WM86/
QnqFV5YbnV7dkybcnVGIzFjcJYOV0mECZIHvq+9C2JDu/zxkShaY4Pt7QXTWzMv9
VgXfpJelAM3A4d9OfKgJGhXjQkxguzbV3V1YfmJhaIxLstctHAg2gPzBW9ipWOFG
nSIRWSOl
=E5x5
-----END PGP SIGNATURE-----

--SSgtj/USuBRNteb1--
