Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DA5D767F4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4142688DB1;
	Thu, 31 Oct 2024 19:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lEhnlj5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 120F788E18; Thu, 31 Oct 2024 19:14:12 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05EBE88C05
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b152a23e9aso79668485a.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730398449; x=1731003249; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n8Lddzz/doCXEGeUEw2spLhKjPEWpYR6eAwd09SBuyk=;
 b=lEhnlj5OjVhXIIvZ9BrqLLHlWfoD+v3AvgGEVBhui39IFtq5IRmKgJ6b1X0k1y5OAG
 uPVL2Q7LRCNCV+o4uZZnXrCvyOuSiWe+nNO4nRnoFSY8PJrJa+mrYv85Gi6foSkQTUjJ
 D4OjsrrI2DRZjOqcWdt2nJ7N8qaeBOFOsdWEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730398449; x=1731003249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8Lddzz/doCXEGeUEw2spLhKjPEWpYR6eAwd09SBuyk=;
 b=vMEfK3ob8+pRiW1n19sCjQWCjPqdCEcwq60L5zuHgNvodfAExipegpR3A73nn5SNeF
 HMlc0T7kaNlc3HK/Tk6SMmJAhwUCHJqxkMXBVLJbO4UspCrMLM8qcrz+RsHH18l1pfNi
 XianOrfdoYQdxRzD31x3f43FPLrizVHo8lDpIjblKQ4hC5K7sqNVeE4CKxOrGQ7btZeE
 RaW9sQaquJLcaZRNn5QlkVFcKRB2BQv1ClTSIo7teRg54u7ZJDfyoIPVCIdinqcdsd6H
 poaw+mPRzm67EadQnN/ZbKYyrObrRPk7713JIap3qvE+E+196o9cRrmFobnEZIGU7tWF
 mLIw==
X-Gm-Message-State: AOJu0Yze/2EccdJYO9/UFzFNfJ+JHeb7k0KTw7Zq9dfawWczGpF8FD9X
 aAhj/Lhy96DVqr5rSI6cyJT2u+4mE/uR4voaJpLiijAPaUg1l61gxpw7r4HOiAo=
X-Google-Smtp-Source: AGHT+IFbK/1cTg3QTr9sHAsxJkLkZlD1Ts/HVTYo3B6NlapXuz+japUa/RRicn8WjBR5/LOj8xQyyg==
X-Received: by 2002:a05:620a:2445:b0:7b1:5680:164b with SMTP id
 af79cd13be357-7b193efa878mr3157007185a.26.1730398448892; 
 Thu, 31 Oct 2024 11:14:08 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f39eb7b4sm93653885a.16.2024.10.31.11.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 11:14:08 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:14:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v9 03/11] sandbox: Add a -N flag to control on-host
 behaviour
Message-ID: <20241031181405.GX2558755@bill-the-cat>
References: <20241029192222.362445-1-sjg@chromium.org>
 <20241029192222.362445-4-sjg@chromium.org>
 <20241029201400.GJ4959@bill-the-cat>
 <CAFLszTigOBUyyi9pxpnLpXwhiw5hJfGEb6QeZPh4jesc5x4Rzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CjNQLJhDKI3/MFsI"
Content-Disposition: inline
In-Reply-To: <CAFLszTigOBUyyi9pxpnLpXwhiw5hJfGEb6QeZPh4jesc5x4Rzg@mail.gmail.com>
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


--CjNQLJhDKI3/MFsI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 06:52:33PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 29 Oct 2024 at 21:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 29, 2024 at 08:22:11PM +0100, Simon Glass wrote:
> >
> > > Sandbox is its own architecture, but sometimes we want to mimic the h=
ost
> > > architecture, e.g. when running an EFI app not built by U-Boot.
> > >
> > > Add a -N/--native flag which tells sandbox to reflect the architecture
> > > of the host.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v8)
> >
> > I believe Heinrich asked that you invert the logic here and add a flag
> > for when you need the unexpected behavior.
>=20
> Yes, but that is not correct, unfortunately. The expected behaviour is
> for CI to use the same filename for its efi apps, no matter what host
> architecture it is happens to be running on.
>=20
> The use case that Heinrich mentions seems to be broken on x86_64 now,
> as I mentioned on the other thread, perhaps due to a recently
> introduced bug in UEFI or QEMU. Just to be clear, this is not a
> problem with sandbox. I suspect Heinrich will figure that out at some
> point and then I will be able to try it too. I would also like to run
> it on sandbox.
>=20
> I hope to get an ARM machine running CI eventually, but I need to get
> my lab running first.

I talked with Heinrich about this in private and while neither of us
understand why you want this behavior, we'll stop objecting to it.

--=20
Tom

--CjNQLJhDKI3/MFsI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcjyO0ACgkQFHw5/5Y0
tyzfygv/VC327hbVDvgR2DAtDDPOyy+KgVzYYhfyeg8Xjed3bvXQcU4dVe7sIQDI
0TShsMNJ4CafS4/tgxZ6oldhGoSjIyZcjyDyTXOlZmPkTbv46131cVVbVF+jsYWd
+vseZ7E2tprK2XwcxZKrYpddyWb/+H0MmU1iG973j5HeEthEott7WRccGhwmLgbQ
6Y3V++A+d7A8ZE4DvtZl/myqAw6evMaQwcI+BiHmTIGAxdAUsEmbCy2tzoBMmTfy
9Ey3XZfbRu2Bky/29eNdfSYhv+SV90ddHbSHprqtf3Nq56vhJ7h7Y6YrcEqStNY5
Ll9CxwFR/wSQlca3b60x6JbxuZM4rYVsaIhr/KiNW50OJw7Ij/QI+u6+QFKmpvwE
DjVrBq5DVoTSuUrL1hlI/yMb2cBHY1wb+fHSCvFvBcuSYwM5y9QMHkOkiKyzv85E
UxypQscVlGd0EBKjkWQmepqHwi0I1LtchCZ+3Cway7mUNGTzYyXIiJNUdQDvJaed
wwAvALNz
=Grgf
-----END PGP SIGNATURE-----

--CjNQLJhDKI3/MFsI--
