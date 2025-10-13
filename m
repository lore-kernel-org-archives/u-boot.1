Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBF7CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 15:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A6E83621;
	Mon, 13 Oct 2025 17:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BaZIogEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 161E083677; Mon, 13 Oct 2025 17:34:43 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90EA835C6
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 17:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c0e357ab51so3753184a34.2
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760369679; x=1760974479; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/qhzOEppngBktT8AXHXBHbzdaPl/4Ht42jigu/mCGl8=;
 b=BaZIogEIhleC/gi05L/gH3R+9itJkLJOVB3/6Uup2+taYz6GcFEl8qNh/dEOB101wA
 xhuQfjtUr6leqbeJgQOobiHZK0rnqUSOItCn3x1RrDqI5ALooyE9CMWylry0XmeasSfx
 r2k7slatQxRlEIo794G1vDbaI04Qkf3iLje80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760369679; x=1760974479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/qhzOEppngBktT8AXHXBHbzdaPl/4Ht42jigu/mCGl8=;
 b=t7G/ecpYVlcQByPImkHVUhMULeYIqh4X8gKRQu5tlUloPbRFfm1y9yAMx7b6wyeahc
 903jUcQ2xYAP11b1RN8RqvdAPggzX1St4wztfi/zXR4ts81noOClSGlYyZ2mk+LLnFgw
 +nPrB/VjSXF2+QWy3vgcrD8WzuUnRufEuQo18KqqrDGOuO4/F+I25uoXN7sIYt0iUK5q
 /rivT76cEY2Upun+XNhYtI5sDJdhPHwccQHFarSvLdYMYEnMSPl3SEy459oB9Ea0aFH4
 8gjizpcwoTORmgH9SQkymBeDIASyOltaLzuF4+906O4xsDoWCVq8F2/7X5fqQafYKPIp
 KkXQ==
X-Gm-Message-State: AOJu0YzIinEx8yzGVw+aAHoSiQYadUTPo/Qnj5tbToA3gk0BKaMvu9My
 JXVXZ80M9K3Bv95Lg2h+6MkwDs0PIjdKAZUQE9B8/Ho7br1qEkVeyjm2/nL/YRhZua4=
X-Gm-Gg: ASbGncuAkiM/Vg3450H4rNDtItAic+43lBY71X1H9ox5N0JdTNaiO5n775Is8FOCHpe
 JBh900PduXAHmQA+0VkpWeme6oF0kyW8nbJ5t77CNvTPrcIaBUoSbT6+a5qEYitaBXlxAxZB4ke
 FOih8c5BCTwHE/NfNSyQQ/rBhRyxvVEGBVCME8rBEjK+9gZ0jaFLd4jU6qtAvUQ/elmjnRkExER
 cEzWGkyc2U33YdBUj/JN8yYDRwr8MFciOTa+06VGvceGUXU3OOgJM93YkccWqs8s81Jkl+wHT/x
 eorFx45LzIBdiietlAWh0C/UmKzGNqCdy2W4NHUO+IgGYK48AVQ+ZlMxmHC05IBfXr0MR/nmGY3
 p+S5IoL+PVd8iLPtGzwhsnrkSzxW7R2AulcCjI7SVk/a5PwhK/Vcz+4QBvBXUlU7QtjnOIke203
 l8CE0VWERobJ4/s6s=
X-Google-Smtp-Source: AGHT+IEbVoetUAjVbOZbDfZh7pJ5lKam6+sCzy1cPUjBKnyG/8M5DQ3g0IeGj8u+fkHZ7HvNtYnOOg==
X-Received: by 2002:a05:6808:bce:b0:438:bdb0:89b6 with SMTP id
 5614622812f47-4417b3d487amr9679515b6e.34.1760369679601; 
 Mon, 13 Oct 2025 08:34:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419894eafdsm2500480b6e.20.2025.10.13.08.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 08:34:38 -0700 (PDT)
Date: Mon, 13 Oct 2025 09:34:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v5 2/4] boot: Move obtaining the label into a common file
Message-ID: <20251013153436.GI6113@bill-the-cat>
References: <20251012064412.2892979-1-sjg@chromium.org>
 <20251012064412.2892979-3-sjg@chromium.org>
 <20251013141339.GC6113@bill-the-cat>
 <CAFLszThGU4_+=jUc09HvZSMpk3XyMuyXv_hquY=dTRECS2xOYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nxD73K7ojTDp4gz+"
Content-Disposition: inline
In-Reply-To: <CAFLszThGU4_+=jUc09HvZSMpk3XyMuyXv_hquY=dTRECS2xOYw@mail.gmail.com>
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


--nxD73K7ojTDp4gz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 04:11:59PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 13 Oct 2025 at 15:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Oct 12, 2025 at 12:43:54AM -0600, Simon Glass wrote:
> >
> > > The 'bootflow list' command supports looking at the EFI device-path w=
hen
> > > available. Move this piece into a common function so it can be used
> > > elsewhere.
> > >
> > > This updates the output from 'bootflow list'.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > You were supposed to drop this patch since it was only needed for
> > another patch you have dropped. Thanks.
>=20
> Oh I didn't know that. So in fact are there only two patches remaining?:
>=20
> boot: Move preparing bootdev into a function
> boot: Improve comments related to global bootmeths

Yes, thanks. And if there's no further feedback I'll just grab those
parts of this series.

--=20
Tom

--nxD73K7ojTDp4gz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO0cBQAKCRAr4qD1Cr/k
Ct5BAP9SusWPIoF3vQ0wrqj7iu2LajLSo9ExCmFy9g8d9QLQvgD8CQPlil+E4wN2
liPxJWfH9e6y9IQczW8AenY4lgo7FQQ=
=TnmB
-----END PGP SIGNATURE-----

--nxD73K7ojTDp4gz+--
