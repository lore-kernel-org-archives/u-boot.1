Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1821AC87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 15:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA9382AFC;
	Tue, 12 Aug 2025 17:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J/drQnHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23A0982AFC; Tue, 12 Aug 2025 17:04:06 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8A4782A53
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 17:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-30b776f0805so3301644fac.3
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755011042; x=1755615842; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bJ+30cuRCPE4j/wAskvq2tmSd8Tg94vomfWJbeE53uA=;
 b=J/drQnHoOSAoFlh/wFEqy5ltx/lQvhs2bpoCtMv7NxfnG6IVKAj3BWYH4or93ZLm+t
 ybBhJsSd+jO3V16dpcSsS+NTBTwH5C14xpUwrnrYkXzVdLmGREyVZqO9CzLpR5jc7F2p
 +M1gLNYrMHzR9A/s8sYw/QpbZ8rySbzbTw/og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755011042; x=1755615842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJ+30cuRCPE4j/wAskvq2tmSd8Tg94vomfWJbeE53uA=;
 b=BHBUaGAYHkU+RdXF538D9rT0wPrsx/zz4cf56vZ6yc1i4d7NahR1Frb0/KkWgbdkAF
 5ssRY9ucuiKzyqqg9YVOlJNWYPx46GHmmlF37C6VQfZUczPadUZ/uSWg2noa7aMRR4xz
 qyb3AUgqyRaluXJSVvP8TCTLIXn7q7v8UVY2qUi8N+XF7WkX2p/NT4CWsP8aWaEZoB/w
 61i4Ir06nwOU5Cp4HRrxcSzx8uwPHVO4pzmAL9AfguWv1ypzm4yy1qxFjJWc3G+qAR6/
 YcPRwSqbJdQwT+mdRTN7xOS7JA1iEWRrXEVQMSrzDoJWMYPnHSawhJfl+oJaTNvzPCWZ
 OBNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdvk8TvSst4IYeMH8AF7zTn6ml6DlUBa3wAiqO+K35JmYdNEoZzM0qCGwzQeu3DgszWEUT14c=@lists.denx.de
X-Gm-Message-State: AOJu0YwmzlMWUXu0V/tE45w9oblzdGW+4pQ1wDOwcNlXVgcUJloAFFUv
 gh4Q6toH8fjS1/hVwCP4AOPPi4j+La1m4tI4JtGc8Glfk+y9fR2AJziKVRZIrLnaLIk=
X-Gm-Gg: ASbGncsc3XEiZr6EE+vOKeQeJk4sLQa8WHhps9W5dnJqnh+Jm83WV0HgdwJT/6CZrWt
 h0mS+0fj1zwhoFCBfCn9t4kSW28fNh7WBnetv6Igz36BmosUboLJyPTZz9FdfBA4knzZ6IueH4I
 Rj98Jte4XROqC4+hcj/+koMC2/kG9mbmwmFDjEZssTR3SF3xXgEpNBZIrAqOjLwrZuhQEcPFOxL
 +0lcTMLbzxv8fNlyWV7eoFrcnvqFvoa0SPjQCD85ZLg83jiOcGWtIs5J83vCGVwrxBaodLNR9RR
 vDXWgyIX2NJmB83h3B0XiKBqahuRPKfOt2aAkxLpfLBr355ZL1RRIx0dXDyAOXCyAEc+fz8RgOJ
 UW2ldc5urp9oU/x8pC76nIhsXFjgRvT0dN9JHrWKqVF8Nn+Z9vSt7wJWw
X-Google-Smtp-Source: AGHT+IGzMJVj0tPsMsuWvO8qps86rZKrTRPLVxGLW+Y5+wlVOrpvfWWmmMUCagfAJdwF7PONs4OoRQ==
X-Received: by 2002:a05:6870:2806:b0:308:fc2b:b7e with SMTP id
 586e51a60fabf-30c211b8be7mr10229860fac.47.1755011041701; 
 Tue, 12 Aug 2025 08:04:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30c512bb7f6sm2486620fac.6.2025.08.12.08.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 08:04:00 -0700 (PDT)
Date: Tue, 12 Aug 2025 09:03:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Seeking advice on API return type inconsistency
Message-ID: <20250812150359.GS124814@bill-the-cat>
References: <f5c94319-8ef8-459d-88b2-836702779cfb@linaro.org>
 <e10a39e4-9606-4ae4-86dd-11de4b39b5ed@cherry.de>
 <2d6457b8-c637-4531-8f56-e2aea320a319@linaro.org>
 <20250812143349.GQ124814@bill-the-cat>
 <cc82add8-5f9c-4ee1-87ea-a458e840e621@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Kku3DdrMgTVUM8Lf"
Content-Disposition: inline
In-Reply-To: <cc82add8-5f9c-4ee1-87ea-a458e840e621@linaro.org>
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


--Kku3DdrMgTVUM8Lf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 03:46:56PM +0100, Andrew Goodbody wrote:
> On 12/08/2025 15:33, Tom Rini wrote:
> > On Tue, Aug 12, 2025 at 10:17:47AM +0100, Andrew Goodbody wrote:
> > > On 11/08/2025 17:36, Quentin Schulz wrote:
> > > > Hi Andrew,
> > > >=20
> > > > On 8/11/25 5:24 PM, Andrew Goodbody wrote:
> > > > > Hi,
> > > > >=20
> > > > > I was wondering what people's thoughts were on API return types. =
In
> > > > > particular there is this and other examples in include/clk-uclass=
=2Eh
> > > > >=20
> > > > > /**
> > > > >  =A0=A0* get_rate() - Get current clock rate.
> > > > >  =A0=A0* @clk:=A0=A0=A0 The clock to query.
> > > > >  =A0=A0*
> > > > >  =A0=A0* This returns the current rate of a clock. If the clock is
> > > > > disabled, it
> > > > >  =A0=A0* returns the rate at which the clock would run if it was =
enabled. The
> > > > >  =A0=A0* following pseudo-code should hold::
> > > > >  =A0=A0*
> > > > >  =A0=A0*=A0=A0 disable(clk)
> > > > >  =A0=A0*=A0=A0 rate =3D get_rate(clk)
> > > > >  =A0=A0*=A0=A0 enable(clk)
> > > > >  =A0=A0*=A0=A0 assert(get_rate(clk) =3D=3D rate)
> > > > >  =A0=A0*
> > > > >  =A0=A0* Return:
> > > > >  =A0=A0* * The rate of @clk
> > > > >  =A0=A0* * -%ENOSYS if this function is not implemented for @clk
> > > > >  =A0=A0* * -%ENOENT if @clk->id is invalid. Prefer using an assert
> > > > > instead, and doing
> > > > >  =A0=A0*=A0=A0 this check in request().
> > > > >  =A0=A0* * Another negative error value (such as %EIO or %ECOMM) =
if the
> > > > > rate could
> > > > >  =A0=A0*=A0=A0 not be determined due to a bus error.
> > > > >  =A0=A0*/
> > > > > ulong get_rate(struct clk *clk);
> > > > >=20
> > > > >=20
> > > > > get_rate is declared as returning a ulong but the description says
> > > > > that it can return negative errors. A simple test of the return
> > > > > value for being less than 0 will always fail so errors can go
> > > > > undetected. Casting to a signed type seems less than ideal.
> > > > >=20
> > > > > What is the best way to deal with this? Cast to a signed or update
> > > > > the API to be signed or...?
> > > > >=20
> > > >=20
> > > > Note that clk_get_rate() in the kernel has the same function signat=
ure
> > > > so I would refrain from changing the type otherwise we'll have some
> > > > "funny" bugs to handle considering it isn't that uncommon to import
> > > > drivers almost as-is from the Linux kernel.
> > >=20
> > > Ah yes. The difference being that the kernel does not seem to attempt=
 to
> > > push an error code through this API, you get a rate or you get 0.
> >=20
> > How is the error code pushed? Or is it up to the caller to decide that 0
> > means on a case by case basis?
>=20
> In the Linux kernel almost no code checks the return of clk_get_rate at a=
ll.
> Some code will check the value is sensible and 0 is obviously not sensibl=
e.
> But pretty much the call to clk_get_rate is not expected to fail.

Perhaps getting lost in the specifics then, but perhaps for this case we
should just do the same? But your question was more general, so another
example might help.

--=20
Tom

--Kku3DdrMgTVUM8Lf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJtX3gAKCRAr4qD1Cr/k
CuMcAQCraxSssB+PP443Mdd9juwBfUrOhrbNzCaa4gcOg9XHrgD+MXsgpytEq6+0
WCmAVNMz7YX6peLo7Sowy+vml/ac4gQ=
=dKzW
-----END PGP SIGNATURE-----

--Kku3DdrMgTVUM8Lf--
