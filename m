Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B92CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91D2684582;
	Fri, 10 Oct 2025 16:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LpQLreBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 836CD845C1; Fri, 10 Oct 2025 16:39:57 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 334B283F70
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-74572fb94b3so1437200a34.2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760107194; x=1760711994; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x8ujkM4ImYu/J7SJfM1JpBA7x80UbxL2lqKyBmOB4MY=;
 b=LpQLreByNOKwoyfDeg0XBuIaSa9ccWlBGk2b0NRBjhm79mZRfpyPQ3nRulRxa1bryo
 kG2W7FlyQ19QcBnD7aa/gsA8BPMrBKvMBGu/PBVGAniW7Aq4LGGhWVZIs8M+uR6JB1nz
 hMNCI2xg/TyTIG/HxzHYVHYiuHphowhEH5nwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107194; x=1760711994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8ujkM4ImYu/J7SJfM1JpBA7x80UbxL2lqKyBmOB4MY=;
 b=QZO6VVd4ZKazSLQUki33pKBqmrkp/p/m99A+kvijVtIph4kj1VdTsWyOynPZ4NBnLO
 O+Rja3K69BO2QvYBkCUOGde66p1G65K/cwG3GO7aoHwVVkCpQJ3Tf+mx8MzABv1GWBng
 C27dzc73y6dCtyoR9D+cpRez3yhjYoXOw1P/Sa/gx2mkHyxZ6BwGifKtSJPZejUsChtG
 OcRGlUjU+F8JQUn8mqttN79w+uhjl0RC4kSSil9VKbDIZ3v8nWrrVmbjhXDGe1KcSSz4
 8RyJ+4vg1/ahqsP4i9Jkfog6FGeWl1rUsNDzm2GUDDiJ5tgx2P7tkwgHdlgZuMEZdO6c
 I9fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBH9Cjaeio+1aG1asVPIMm5org38xqPE2jWa+ztrnFAurER+Swf4pqTeUwbzfA2mby1K+pzX0=@lists.denx.de
X-Gm-Message-State: AOJu0YwNLlYG1fv6LN+mmuexHS/KUsvl5LjgLYJiVGVlR7tE5udSafzY
 DAMk0WU2Ode2AETG9DyKOsEWbUbKu50yot6AJw0Fh8ZWoEfSixuLxgxf57e5I5Yj8cE=
X-Gm-Gg: ASbGncvr8NOmTSXli5nfsoMFTp+RjuS+of++C6HPzpsMsv2G4M/dY1SxihHuwZiWz4q
 Vb4/zR9t+H5FQrSadpkdz08ozno80V4kMXEBNzE6HVGaQPODoXF9BrXD+uZvwJhUFgcpLy0/Sp6
 qCyvFLyXRbQ2V5iBSmjPScBSFV5nwvXpmCpmA15P3IMQLfFQdXg7myHrcs+c4LbfCst687PUT8r
 xfpQzc0sngvMgOd6jv71JfbXlgjWi7WfWlX8VEdW9Dgz5sy6sQfcDi7ZwGipKPogZpcV0C+iXP9
 U/S1Nryk41lsdwqmE3xdN5RoPtnsX+vYd3KmIElM+WNCn7PvpSpRS8RylcGhhADvY5ZWgCwz8az
 s3U5Z2MluASQpPf0gCA8VhYJHp4uWs7boXXsTq0K0gePXpWLmwx34JHnjHyULuHL4h5CI50myfD
 d0N2yk
X-Google-Smtp-Source: AGHT+IGXx7Vul401OJkgckAszC9l0dOAinwqw1kAX82+HcqLT7qVAILYjeGZ8jhHqqaRsuuOBSqqzw==
X-Received: by 2002:a05:6808:1203:b0:43f:29ec:a210 with SMTP id
 5614622812f47-4417b3e9520mr6101840b6e.47.1760107193830; 
 Fri, 10 Oct 2025 07:39:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-441988b15cdsm664219b6e.12.2025.10.10.07.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:39:52 -0700 (PDT)
Date: Fri, 10 Oct 2025 08:39:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v4 2/4] boot: Move obtaining the label into a common file
Message-ID: <20251010143950.GB298503@bill-the-cat>
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-3-sjg@chromium.org>
 <20251009172428.GP298503@bill-the-cat>
 <CAFLszThKqdoRwqSbazWgdw27q9RxJorTwkLmRzZ9FAV48S7gdg@mail.gmail.com>
 <87wm52vobc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lqPoeUzzxRrlEVrv"
Content-Disposition: inline
In-Reply-To: <87wm52vobc.fsf@kernel.org>
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


--lqPoeUzzxRrlEVrv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 04:11:51PM +0200, Mattijs Korpershoek wrote:
> On Fri, Oct 10, 2025 at 11:35, Simon Glass <sjg@chromium.org> wrote:
>=20
> > Hi Tom,
> >
> > On Thu, 9 Oct 2025 at 18:24, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Thu, Oct 09, 2025 at 03:29:53AM -0600, Simon Glass wrote:
> >>
> >> > The 'bootflow list' command supports looking at the EFI device-path =
when
> >> > available. Move this piece into a common function so it can be used
> >> > elsewhere.
> >>
> >> The point of this was to enable the show_bootflow->bootflow_show chnag=
e,
> >> so should be dropped.
> >
> > OK.
> >
> >>
> >> > Use 'usb' instead of 'usb_mass_storage' for usb so that it fits in t=
he
> >> > column space.
> >> >
> >> > This updates the output from 'bootflow list'.
> >>
> >> And this is unrelated and should be its own patch. Wikipedia says USB
> >> MSC or UMS are the common short forms for USB Mass Storage devices, and
> >> we should use one of them to have the output be more precise (since we
> >> support USB networking devices for example).
> >
> > Ok I can move it into its own patch.
> >
> > Are you wanting this to say 'ums' instead of 'usb' ? Will anyone know
> > what that means?
>=20
> Search for 'ums' gives the following U-Boot documentation:
>=20
> https://docs.u-boot.org/en/latest/usage/cmd/ums.html#ums-command
>=20
> Where the acronym is documented.
> This is also the acronym used by the cmd (to configure usb gadget as USB
> Mass Storage).
>=20
> So I'd say it's a reasonable acronym

Thanks.

> > Re the second point, at least in U-Boot a USB Ethernet device shows as
> > 'ethernet', i.e. the interface doesn't matter. We don't have logic to
> > look a level deeper, at present.

And this is unfortunate and confusing then because it'd be really good
to know if I'm talking about the USB ethernet I plugged in or the
ethernet port on the board. Made more confusing in turn by the platforms
(more historical than modern I *think*) where that ethernet port on the
SBC itself is wired in via USB.

--=20
Tom

--lqPoeUzzxRrlEVrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOkatgAKCRAr4qD1Cr/k
CvUwAQD45JoDNs5f5HxjS+nse0B30Qh3o+enjTnc7QIHYDzt2QEA/eFWq04HEQKu
o88Zo5So+Z+htZlZBohPt2rll1JFYAs=
=eMr2
-----END PGP SIGNATURE-----

--lqPoeUzzxRrlEVrv--
