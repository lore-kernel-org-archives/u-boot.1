Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3F0C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E25586958;
	Mon, 13 Nov 2023 15:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ezE0RhIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78B6186590; Mon, 13 Nov 2023 15:06:54 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A022D86A4B
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-778a47bc09aso299022585a.3
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 06:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699884409; x=1700489209; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a5in4A/s6yxnI87lJy377mzfOC8XPKXDkXN5kob8x/s=;
 b=ezE0RhIeT76ycnLMQL2PAH2S9WoJAw804hg1jBkAi2rBhDQp9xSwo0YQXFH0HBNYJ0
 E6rR7FADLqhhrho43eb+8mrWPppDae3uPntp9IWUBYod0SIuyR1yQEpz5Lue1KPvfvyB
 e0Qah5kF60fBOrpqP5sqXyHckd0SizWc8fJiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699884409; x=1700489209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5in4A/s6yxnI87lJy377mzfOC8XPKXDkXN5kob8x/s=;
 b=d9YIgYPV4hqkDZMcEbXge5MyQ/sdIkEYD4qbqQSQrOJPlbOTAKfSGsI8R8L3Oxxglj
 PtDCC4AwXt516wy7L2bTVcM6r6hqDx1yRmACRBis+u0wk31I29/svbIYFYAusZvOqFwx
 sjaPUiuHCb4tjIRZnUbOVrgu/U0f7sXicbxoSUYEdumufVbh+hD3rGoxtq9vgFqAV8pb
 67jMI/cB4rNlDiilWdSDFegDSmJEx2NWZ8INxM1KbMduZq3RPzbixr19iNnMhg6CrE/n
 tHo9/IPkdEJ8j+ibMZWztCQQZgB9UlDdbVTUcUXTbbxnTNesy26OSMgnp9NHcFOXvnaA
 YjIQ==
X-Gm-Message-State: AOJu0YyCImO6m635a4iOtqdht3kD0qnb1KKwUEzXRWw4PTjUK+jRglww
 qcqX0sdLp5rSl1d6yslP01DxrA==
X-Google-Smtp-Source: AGHT+IGB42yuMKwMHZPDls1yv234FnEa4FGz3BufwhEzDtSHyeKs60KeE/ZCTMJj6YtrFToZR+pM0g==
X-Received: by 2002:a05:620a:19a1:b0:774:26bf:efa2 with SMTP id
 bm33-20020a05620a19a100b0077426bfefa2mr9333524qkb.58.1699884409570; 
 Mon, 13 Nov 2023 06:06:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-631c-486f-62f0-4c29.res6.spectrum.com.
 [2603:6081:7b00:6400:631c:486f:62f0:4c29])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a05620a20ce00b0076dae4753efsm1891742qka.14.2023.11.13.06.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 06:06:49 -0800 (PST)
Date: Mon, 13 Nov 2023 09:06:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 09/12] x86: Enable SSE in 64-bit mode
Message-ID: <20231113140647.GI6601@bill-the-cat>
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231002011450.462468-5-sjg@chromium.org>
 <CAEUhbmWi9phnvS1U=z1O+8t7kK5mV=JLw8=YJ4A_u3tcrPSXGw@mail.gmail.com>
 <CAPnjgZ1CsWJa2Ta8fgbGmXZsvpg_BMFDRJmjqPqu6d+7z-TXxg@mail.gmail.com>
 <CAEUhbmUD9E+DkA4jq1tLMSi2ZmBLmOnB8x7jU74fL=J3YYNk-A@mail.gmail.com>
 <20231106153631.GI496310@bill-the-cat>
 <CAPnjgZ1Zp0kjW4zUunopGrUEhbWAtkZ3xwuHYxgo50K9GdFtSA@mail.gmail.com>
 <CAEUhbmUvfD5AOouDXivzrzMQFgirgicsJwBJKW_zMOPL+k7PMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ru2bB2keHnqXOutm"
Content-Disposition: inline
In-Reply-To: <CAEUhbmUvfD5AOouDXivzrzMQFgirgicsJwBJKW_zMOPL+k7PMw@mail.gmail.com>
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


--Ru2bB2keHnqXOutm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 09:01:02PM +0800, Bin Meng wrote:
> Hi Simon,
>=20
> On Mon, Nov 13, 2023 at 4:02=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Bin,
> >
> > On Mon, 6 Nov 2023 at 08:36, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Nov 06, 2023 at 06:26:15PM +0800, Bin Meng wrote:
> > > > + Tom,
> > > >
> > > > Hi Simon,
> > > >
> > > > On Mon, Nov 6, 2023 at 12:29=E2=80=AFAM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi Bin,
> > > > >
> > > > > On Sun, 5 Nov 2023 at 14:05, Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Mon, Oct 2, 2023 at 9:15=E2=80=AFAM Simon Glass <sjg@chromiu=
m.org> wrote:
> > > > > > >
> > > > > > > This is needed to support Truetype fonts. In any case, the co=
mpiler
> > > > > > > expects SSE to be available in 64-bit mode. Enable it.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >  arch/x86/config.mk        |  1 -
> > > > > > >  arch/x86/cpu/x86_64/cpu.c | 11 +++++++++++
> > > > > > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > >
> > > > > > I didn't suggest we enable SSE for x86. This is the wrong appro=
ach.
> > > > > >
> > > > > > We should rewrite the Truetype support codes to avoid using flo=
at/double types.
> > > > > >
> > > > > > This way the Truetype codes can be used on any other architectu=
res
> > > > > > without the need for the compiler to emit explicit floating
> > > > > > instructions.
> > > > >
> > > > > I am not aware of any such library. At present, enabling truetype=
 on
> > > > > coreboot64 causes a hang.
> > > > >
> > > >
> > > > If that's the case, we will have to either:
> > > >
> > > > - Switch all U-Boot builds' to use software float (e.g. -msoft-floa=
t)
> > > > which unfortunately depends on the compiler runtime intrinsics.
> > > > - Introduce a Kconfig option for hard float enabling and let each
> > > > architecture to decide whether it implements it or not, and update
> > > > Truetype to depend on the hard float.
> > >
> > > We generally do -msoft-float already, so introducing that for x86, and
> > > some Kconfig logic to ensure that no one else steps on this particular
> > > bug sounds reasonable.
> >
> > Yes soft float seems to be not-much-used on x86. For 64-bit chips the
> > compiler seems to assume that hardfp is available.
>=20
> We have compiler flags to ensure the compiler does not generate SSE
> instructions. Yes, I know SSE is in almost every x86 processor we see
> nowadays.
>=20
> >
> > So perhaps the best thing is to introduce a HARDFP option to x86 only.
>=20
> This option should be global as some other arches also don't have
> hardware fp, like RISC-V whose fp extension is optional.

RISC-V should take the ARM approach (and what I was suggesting for x86)
and enforce soft-float for everyone.

--=20
Tom

--Ru2bB2keHnqXOutm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVSLXMACgkQFHw5/5Y0
tywMfgv+KUMC9/9edlvw1ilC9xiavmrlqR/7wyUBFE06QrH+WR/bT62IZUKxCkAY
uPaSMeMyF/PrdUqbpbrumiJ7nmWXD8AVEoEowmAEt/1BPTW4YLQSuSFqdhl/70b6
YJeezhudzY3QfHX5wIpZZHacJuurosS/tSzoMhUixlR1ggk5ZdcNO0zhqTZyc57d
UEifFZZMJ86RJrSmcRZ/NCU1KbHsuSLN7SPJBIPyZdzBE6YE8A+W8+6aF026k+zS
umSocn5Q/M/N6kf7Ilb32FvUrasHpCoU714rIP3YkF/U9eSjrQVRZmIJL1ZTeDVX
bXNYMxeEkwUOgCRfqNU+SZuBZ91A3i2Ni0/qqiIHEisYJCB7B0T1QlHdU13ofSu7
dBm7QoP2TJesAE8jgnF4AS8Fsr8wmkNvxI9sBHT1iZuArvyVQ5wavgYo19QpMyoc
lsYckGyw47vHDXeaGePbnUpGxRK6TpoYhz7F5+Zx6E4IW6MKJUljWLvvdayT+7Gj
JrpnjFs6
=I//i
-----END PGP SIGNATURE-----

--Ru2bB2keHnqXOutm--
