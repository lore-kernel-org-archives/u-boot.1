Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBA6CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 14:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2173D839DE;
	Wed,  8 Oct 2025 16:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rWT5oIjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 735A283E8E; Wed,  8 Oct 2025 16:34:23 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 050D1839DD
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 16:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-43f935f7d14so3031207b6e.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759934060; x=1760538860; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bp+8AJHbTQWSpn6lOhjlD80JR5dBbbRN4T6KJLemTbk=;
 b=rWT5oIjC+GJ3m3MCvy74PS0dS2nCOj3BbOfHukaXMQpVH/sFToSGq09mB4ee+i63/w
 V23ysnNMYQxKv3jF0mnoQSo3cwg2XmagRObpEO+cIw6N8mc27yZtlOC4OAzyzReh8CiQ
 PuH5V8Qh9kec0juhSqExrK7XnsN5IwgrHPdtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759934060; x=1760538860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bp+8AJHbTQWSpn6lOhjlD80JR5dBbbRN4T6KJLemTbk=;
 b=Mwq07pJf07C8xoFMh87VNfy3XKfnbfLEzTal3n1ZNbvzAMLtyt6IqNBP3sNOJk6z+u
 OGnePKJSRtaBsrobTaPM1bKCDG5jTy+tAEOEUYymuaW93CEVLU4nh74B2zi/0PlWybtT
 AoHS9j0LTGGMPj8dEeluELKazIloFNa11L7hC0bacHIDFpZ8yE8xDKxupomIo4Kn+9t4
 +JyLUaesUfOsOPpTUkL6v6S6+5wT3QHm4f8UeaIGHe2jUCHC8/7xuhihDqIuSZQk2k+K
 2sFZinFUL0nJscsh2ouPD0a5e+yamNqhucmnymWFje/QnQnQMyWhxestvbMkk8vceABZ
 z+Bw==
X-Gm-Message-State: AOJu0YxgoNPrNzWI0wwNDJOF1NVe8nnripfQ006qcAyvjjPtW2g2Cctb
 G1F3qsnlzGQBTQv0roCyMk088vVg6mPEATTG/RSg5qkoJ9UINEqN+IddxxLoQBe+Ee8=
X-Gm-Gg: ASbGncv/IwZp6uYqC42+vmJRhuxUghWf9E1PfOGHFIPORe+2KWjB/Gx3Ek0/6rWTPtk
 8/BHSetDDr9c6xYY8kES9POl5qve5vfFk5bL2qHTM23Ngkqg3T5fSElLSDUqMOJN5PVHPGHVj2d
 mOyAsm4BEjkw0Ptdi4uFL1FGwssKHhsMSD1dfJF6jUxfOrv6rONofEwEmzzJ6F7g7monsLwTHIC
 Fu3bU3y9PgN84fD+9/5txBMmJAYELfjnXtFDxacDlsn/AhQ1IObkKQf+HggKOJ9xeAS8dBZ7RBr
 LxteUUzBdUgfese8NHVxvsbmzE1rqIKYwhbb9PRSi931U119ZduZcy77xEEQF+xhTwu040Y2ZQa
 qf4fzDqFd4c/xjevf8dPV/8z7sl7TZbrPOkzjbD6ulU5oPduE0ifBYtCqAdcCORZqOz+ih5uR+H
 tJT+jJTEls+Q==
X-Google-Smtp-Source: AGHT+IHMfkrRWJok+MiPnVYLybJWAkZZZ7c5t5tGx2LrDwx/GRy58ErXuxdxavL3leOK1bZsjGWGFQ==
X-Received: by 2002:a05:6808:5245:b0:43f:5e96:f01e with SMTP id
 5614622812f47-4417b409c6amr1815888b6e.50.1759934059629; 
 Wed, 08 Oct 2025 07:34:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44189a8d758sm15546b6e.17.2025.10.08.07.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 07:34:17 -0700 (PDT)
Date: Wed, 8 Oct 2025 08:34:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 02/17] boot: Try all bootmeths on the final partition
Message-ID: <20251008143415.GU298503@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-3-sjg@chromium.org>
 <20251007181356.GO298503@bill-the-cat>
 <CAFLszTieyj5_wTNCqsGryCses5a7DWpgVN9AUiJchmjPMViHTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PC03v5Fp5N3EjEUJ"
Content-Disposition: inline
In-Reply-To: <CAFLszTieyj5_wTNCqsGryCses5a7DWpgVN9AUiJchmjPMViHTg@mail.gmail.com>
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


--PC03v5Fp5N3EjEUJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 06:53:44AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 7 Oct 2025 at 12:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 01, 2025 at 03:26:27PM -0600, Simon Glass wrote:
> >
> > > At present when one bootmeth fails on the final partition, the next
> > > bootmeth is not tried. Adjust the logic to go to the next bootmeth,
> > > which is the more natural behaviour.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > My feedback on v1:
> > https://lore.kernel.org/u-boot/20250331174144.GI93000@bill-the-cat/
> > was that we need to do a documentation change when doing a behavior
> > change. And I cannot recall if this change here is because of reports of
> > problems or not.
>=20
> This is a long time ago, but I think it might have been an
> inconsistency that I found myself. Otherwise I would probably have
> mentioned the person who reported it.
>=20
> The documentation already implies the logic in this patch, as I see
> it. But please suggest any changes.

OK, I guess it's because the commit message doesn't explain the bug
clearly enough. Is this a correct description of the patch:

At present, normally when one bootmeth fails on a partition, we move on
and try the next bootmeth. However, this was not the case for the final
partition due to a bug. Rework the logic so that all partitions are
treated the same.

--=20
Tom

--PC03v5Fp5N3EjEUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOZ2YwAKCRAr4qD1Cr/k
CtnPAP0bhM/FpMymkRm1LB/UdKycM/uT/H1huM+Kl4uF5/QmggEA09BNx1WUxyvV
SNwq+h7KWxCE0rqUTQKjN5nd7fuDsA0=
=WxNr
-----END PGP SIGNATURE-----

--PC03v5Fp5N3EjEUJ--
