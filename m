Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D26EC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 23:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F80280F0B;
	Fri,  7 Feb 2025 00:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tWHutcby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5688980F16; Fri,  7 Feb 2025 00:15:52 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8149801DE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 00:15:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f9d9ee2ec2so2257392a91.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 15:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738883748; x=1739488548; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LYeLarAHE/ftk9OxQBMPPpdHdmNSsUzG4kAWmQ+q8IY=;
 b=tWHutcbypdB81EqfO208kMlO/lRT9/9akzEYfHqNOA68Lbq8gc/eO6guH6+RQY9VTb
 PZCNm0z3UhmtGqq2rjrRc5BrYpJhCa1EjxS20UKJmoZdSnbP7/DRTWrxT09mzlJdN0+V
 t+IOFSYLBjdME2s7DhWBIWYZmmc97cATvueeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738883748; x=1739488548;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYeLarAHE/ftk9OxQBMPPpdHdmNSsUzG4kAWmQ+q8IY=;
 b=tDA/vjuSt9XxhUfXWIP7Wuld/UmUGgbmziMZm2SxAEIXxk5qA6GBonc5nIzTB7qjKG
 ZRrA2d1h5kZlncG72k70FCTx9XUDOevkRaIMVfKQWUO/mTxir7jTpjuu0dA21Ml6St+u
 LFfk0dBV51EcLA+gfvTwJwDhlth3x47Oez5r9XFJvfm7eiVsN3JSgE/1Cg5o5XKtdDVx
 uJwZ/AfcSKMjJOQx6dvuYu4ODHH33YsZw92i0pw2wtcp8AYonDiL3OtbtULlA2XZspvk
 78tpz4Z1ogopbiC8WHydw9UmqLmFHAbGSDSLeCax+MUJL9Unj4iPBJkSRzC6rFVOBn+i
 MqRg==
X-Gm-Message-State: AOJu0YwNECdm8ShRr03PtnNATCrVmZdN+CrV7cG9uBZQec2vZtcA45Mn
 r9Vc6j2/lIT7wDMgIMFp5UQ3ABqy/s1/pOQbuX38M2X7wFjN9XSIl5UsO0vqIIk=
X-Gm-Gg: ASbGncuJaZx/cpA9fHjKIGHrhdQ3JHWYQBNnegDql/JQZLDADGK3c/WIGUtdbpsl0EH
 Fxp4B0+UgYhIakuf9XDWB1M2RphZyWcYYZI9Xnf/OoRgzr1LDEeE8IpsPnaLarhKaq0HvWk0xJ+
 hrJBZNmEnTitjGvSEh2uOfX6bcDw7oBYBOrtzxdlE39rgFbkArzKe0lqS8bYTrFMB+shtEXkkcD
 0og6RoUJDosIqfNgwUSa3/Rxg44Ur2FQ9WxX0c8RLfU9R0JQMIpRvjBGDYZHifpCbP4IIP414qH
 J2/hi1EL6CxSaF8=
X-Google-Smtp-Source: AGHT+IHWRVlJJuHHmxtiEVC2SgtOpAzOV377oxYykq6WF23DzGDUDRp+FumgvyMuX1sxZj4AIpx8Zw==
X-Received: by 2002:a17:90b:184d:b0:2ee:db8a:29f0 with SMTP id
 98e67ed59e1d1-2fa242d937dmr1310557a91.27.1738883748096; 
 Thu, 06 Feb 2025 15:15:48 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa12c887c0sm944678a91.1.2025.02.06.15.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 15:15:47 -0800 (PST)
Date: Thu, 6 Feb 2025 17:15:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 28/29] Revert "bloblist: Load the bloblist from the
 previous loader"
Message-ID: <20250206231544.GM1233568@bill-the-cat>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
 <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
 <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
 <CAEfUkUL7H5twRqZZBcfEHuExwtHFUrT9h7NV-3T0jx0c0SBEbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sNk+AsJR9NoneILd"
Content-Disposition: inline
In-Reply-To: <CAEfUkUL7H5twRqZZBcfEHuExwtHFUrT9h7NV-3T0jx0c0SBEbw@mail.gmail.com>
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


--sNk+AsJR9NoneILd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 05:34:58PM -0500, Raymond Mao wrote:
> Hi Simon,
>=20
> On Thu, 6 Feb 2025 at 10:41, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Wed, 5 Feb 2025 at 08:25, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > +CC Ilias,
> > >
> > > Hi Simon,
> > >
> > > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > The logic of this has become too confusing.
> > > >
> > > > The primary issue with the patch is that U-Boot needs to set up a
> > > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > > phases can then use that bloblist.
> > > >
> > > > But the first phase of U-Boot cannot assume that one exists.
> > > >
> > > > Reverting this commit seems like a better starting point for getting
> > > > things working for all use-cases.
> > > >
> > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > >
> > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKXNniOfV_-vFryq1=
Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > >
> > > If my understanding is correct, you want to add some logic to control
> > > when the U-Boot should or should not get the bloblist from the
> > > existing register argument.
> > > But xferlist_from_boot_arg() should be called when a valid register
> > > argument is there, I didn't see this in your patch.
> > > Maybe you plan to do this with other patch series, but simply
> > > reverting this results in a breaking of handoff policy and the
> > > firmware handoff won't work.
> >
> > Yes, I certainly did not want to revert it, but the current code is
> > too hard to understand and I did not look at it at the time it went
> > in. I've had three tries at working with what you have here, but each
> > turns to spaghetti.
> >
>=20
> Still not very clear on what concerns you have and what is the way you
> want to go.
> The logic is straight forward, when U-Boot has a previous loader and
> the registers pass in valid arguments - It indicates handoff should be
> done using the transfer list.
> Other kconfig options decide whether to use the passed in address
> directly or copy to a predefined address.
> But in either way, xferlist_from_boot_arg() is doing the right thing
> to get the transfer list from the register if it exists and is valid.
> I don't see a reason for removing it.

Exactly. We aren't reverting anything in master. As far as I can tell
the only problems we have are:
- No mechanism within U-Boot to pass a bloblist/handoff from one stage
  to another WITHOUT it being at a fixed address.
- The actions of "is there a bloblist" and "make a bloblist" are tied
  together, which is a problem with a fixed address being set in memory
  that is either maybe uninitialized or could be re-initialized.

But if we fix the former we don't really need to have the latter
normally.

--=20
Tom

--sNk+AsJR9NoneILd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmelQqAACgkQFHw5/5Y0
tyxLqgv+KY5voGWOSdczcD3GZxayibNDqtQql8lfGtwZepOIxSfCA91Np0nIMaHL
EfmOoAeLFeruNBXCm6cAhJyIxB67jTl8VElB77Dd5WlzPpbq0wfP1EHFgQ4ELD52
3A/rDHUdpw/S87rnDkm+AmHZJmeQBFuH2zavxoXwA25hkLqzJjh3i2Wp+zz2/R+s
YA444xCI/i+ulBpeOdt+ripNz0mim8VpB1ixGYjwGLDvYoah5BYUcKnbp9vGtDh/
3WmQNmH7IxPsqDybfwVCcY1yAEVUYc8PEUlFrXPXy5ezUUAm6+Uq6D9KtWP5tS5/
zTfnX63Tk+qsEMjrvBw3jMINLsDYWzBEFiZLGD6WhkTydrH5dm1ADezNQL7UCClf
HKYKf8+wdeRsrheTpWWv0hVM3e+3TUeEUOzHY5NQKRFrr4OFZQmvifIt8uIUvFYu
ShiHo21mrlg2cqLxfkQfM49UEkgUfQtbuaBD6uO0l5t4gTq1WamBEcwn3yKASfz/
g09sbu4/
=NrWS
-----END PGP SIGNATURE-----

--sNk+AsJR9NoneILd--
