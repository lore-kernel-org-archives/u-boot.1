Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02884C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 14:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D38B876A6;
	Wed,  3 Jan 2024 15:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="puvKa3L4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00D4C876C9; Wed,  3 Jan 2024 15:13:13 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A78168771E
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 15:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bbd1f9e0b8so3681601b6e.0
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 06:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704291189; x=1704895989; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2lRdJmQ+ZB4vet5e3Guur7A+2GSeHMW89SkjabVe6qM=;
 b=puvKa3L4b60ExBXvD+qIcP+8lC2Ll2NWaqnYB+4vkigfqFW5OrFk8hUodjHEOXgxFn
 qhJtHxFvv7KXVzS4hfWOZrMhkzL2GUsUyrOImYR0Dqn9r64dQcHzq3QlogF6NloJ8Jwp
 tC4ePWhFOVvLA0fUoYLvkLruelWkJrGnuyvC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704291189; x=1704895989;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lRdJmQ+ZB4vet5e3Guur7A+2GSeHMW89SkjabVe6qM=;
 b=FXidEpMQoLZ1N71lYM9QcYE68SY49JEtYG7oU6ObZORB1Zr1UHvbsZ2IB2UI/a7HK0
 zGuH2UMdp04MWSn7AC/E4Y3qHpizYdSWhaj5vCsZMOxKC4fNBWO/RbVKzYUknQJ2jkPo
 yFaoA9Ayz/JAHFm3ZgCWD/1epvBtSvEdCOSUQRm7kKU/u0DF83l/V/or62pkQzUsK8Jx
 ceYEfdzi5R3XRUby9Kqpks7x0T1vA1JKNOCqZuP0Odjr5G+3L4w0hG8qNApzMY0LJAk+
 9IkHG+Vhfkrd37w/mYZnwmRiKj/Hr2JTNo68gEkPQXU/gIiW94DSNqes2RnwmaSkXHYx
 w6jQ==
X-Gm-Message-State: AOJu0YwjPbr8dpXeZvBAHP0Gex00gM76hfzCUXyOo5XStyjyb8oG42Vn
 V8EygPrzK2n8MYpDqoBWADe6TepfCWVoZQ==
X-Google-Smtp-Source: AGHT+IEKlhUKAuaXPekLpdfOq3S4sS6Un/sBCpejIFqFV0U8S0Iroi3SiqXVDvKeQVigMdLJZVOIBA==
X-Received: by 2002:a05:6808:ec2:b0:3b8:b72c:cbaf with SMTP id
 q2-20020a0568080ec200b003b8b72ccbafmr18777260oiv.101.1704291189245; 
 Wed, 03 Jan 2024 06:13:09 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 mn1-20020a0562145ec100b00680c7c14d4bsm935239qvb.129.2024.01.03.06.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 06:13:08 -0800 (PST)
Date: Wed, 3 Jan 2024 09:13:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, sjg@chromium.org,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 rfried.dev@gmail.com, dsankouski@gmail.com, seanga2@gmail.com,
 marex@denx.de, laetitia.mariottini@se.com, pascal.eberhard@se.com,
 abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH] mach-snapdragon: Move APQ8016 SoC derived board code
Message-ID: <20240103141306.GJ1610741@bill-the-cat>
References: <20240103130716.4144892-1-sumit.garg@linaro.org>
 <20240103132611.GH1610741@bill-the-cat>
 <CALeDE9MTYhc0DN3q8SWRqqqe4M0v23kd8WpmkCPoA=UzPKcvbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4LmsDXsznahLkBmi"
Content-Disposition: inline
In-Reply-To: <CALeDE9MTYhc0DN3q8SWRqqqe4M0v23kd8WpmkCPoA=UzPKcvbg@mail.gmail.com>
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


--4LmsDXsznahLkBmi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 02:05:55PM +0000, Peter Robinson wrote:
> On Wed, Jan 3, 2024 at 2:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Wed, Jan 03, 2024 at 06:37:16PM +0530, Sumit Garg wrote:
> >
> > [snip]
> > > Tom, Simon,
> > >
> > > Is there any U-Boot policy in regards to board code going forward? Are
> > > we moving in a direction to get rid of most board specific stubs from
> > > generic U-Boot code?
> >
> > There's not a policy, no. But this brings this platform more in to line
> > with others (assorted TI SoCs) that already have "board" files under
> > arch/arm/mach-foo as most of the board hooks are already abstracted such
> > that it's per-SoC with only an occasional further hook for true
> > board-specific changes.
>=20
> I think AQP8016 is a QCom device (db410c) not a TI device.

Yes, sorry. My point is that other SoCs already have board_foo hooks
under arch/arm/ and so what's being done here is a normal way of
handling the question.

--=20
Tom

--4LmsDXsznahLkBmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWVa3IACgkQFHw5/5Y0
tyzn0Av/YYK5m/XrR3C9bkRrRwEsIFBBXt1V8xLZGQXy5ujH8zuGZ5hJKiyM6QFr
whA+VI/RVG3FBEop+gwpd3zrFbeAVBbuW3OPkmBXOWNW7nEhu2PcP0J95m+OdG9+
r2ef1sdN2hon5QvqeGkPhShDDSJ0v/ksR4JqIIU/ukEPKI/M2KBPuYMkHdVbzQ6Q
K1CStKd4yd7LVQ6sZQz423EOfkprpnh+OfZIqCC9UU3Hdc4031hey+uwP1kZJS0L
41wwviwqXeeR2EdGckZhS2HC1ti47WEx5fCgFSncBu13k1hec2wRW0PG258erqqh
AS0qHrhJSCtbAth02dIOsljKUT0U4cIC7J0AP6Hw63+bQNGoxtkNRukNcgcv2emL
icCaodjclanu+TXrj/InnnxH9YH7KBtskYu2EuG6DigpwLuha+MWc5K+oB5Xa0ri
q3nHtoFBLimxk/FNvlmm0AGNaXZ/QbUY0KBWNhiyzagtLCwGFG1q9N2l1lM5kbid
oHX5W+m2
=qTg5
-----END PGP SIGNATURE-----

--4LmsDXsznahLkBmi--
