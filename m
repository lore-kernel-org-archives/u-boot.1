Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13121098782
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 13:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3220283FF5;
	Fri, 20 Mar 2026 14:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="scHdSs0M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D345E83CF5; Fri, 20 Mar 2026 14:53:16 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E80D83F00
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 14:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d7f8f0d7c9so60091a34.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774014788; x=1774619588; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MCLIZO4f5bFpFUfpjQX51N3LmkIIbcTrIfCkpMC8mTQ=;
 b=scHdSs0MCohSCOZn0UQZ1+328Z8zhEKjLn95sv9egAB4b+7KkYGm1nHfbx6+lEkSPO
 jJrSu7k2NaXzpL0bXEKzCcKrRpQjRuKIeefO56BoJaGBmeoTnpIaezUI/BQjNeUPM5ar
 01xwt4aE0c2A07inuIZJB+18dWrAx5yWgVvlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774014788; x=1774619588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCLIZO4f5bFpFUfpjQX51N3LmkIIbcTrIfCkpMC8mTQ=;
 b=Z0lL5F7KnR5rrcnPwLsKhbBY5OFIX7QDCiSEQ0DS+0DdzhUWHaGHZyalpbLqtgfEWW
 yPNxqJ8NV5AFxiQzB5NHf9nRVfRGGMowWoB/hqgcSOpEFP7tRD34bZCLyJ7DNKgrpCu6
 ZQszcWScQpmnGLRNW0ynEEaNyyDxV3K1dUn9DFqArrPz87u6B9UcDxWw3E9bfPwwwa6F
 /PdxCMaqtKku5QxDzUwUiAsonh9EWuzHHpQolQi9AxBlIyP546tRyMGp1sWmzK0e2I2w
 +FnBnFan1G2sffwuYoIJqai9OMtzhKm4OWMrVn3qFNvEHaaYPlqvEbLCnwgSncEYQKEq
 GWKg==
X-Gm-Message-State: AOJu0YwD5eM6tWWBPDECgOnjrCz1hTMOuPFEeHdkVTwEbw0gMY92L79y
 REDR2h55B3CG5PSbBm9i13AtFNsVtyqYOT+wx/0DiFSXA0VVBQSlMxCOukHNQqyg65A=
X-Gm-Gg: ATEYQzxhFqKmINn57WgjxYMjri2+WQWKzaq4UpaU/7KMAKDgSs6+HIpetuCkh7pLFbR
 4LYqmOYw85oskNmiYtbEmYYo13+fR1Jd1/6AO3U23rEO9jY250ikOhOM7p5P4nQv1c3PQw7Ul+N
 XBGMfnPYprM5JkgPrKY6bHSJ0GLMtR3UcJXZx+rPr7ysQGvbN5cZnl2ypPFGa18qUtpNvZPK1tk
 jDk+AAWMiyz/2Fj/61/B1BOU4YdZNl6VUKDqXRQPxyHg6OKH5Z8vw0w9OzhN8vUD+mOf0Zc4PWx
 XAZCnDoVKMPxkR+ebThjhSUyzc6y1X8O+plWveS2pQp7Rh5t0uFl0Xc36jMlA7sGJwBMRQKoOSj
 +/jXRXDxz9CR8adZpZpVYb7QDMP74eCnif8sh55q2vztYNtF0hNroqfh+LLYpDd4uYMFjbz6sDw
 k1BZ91v9P6PAEIW988culF2nAvpgAviNLIkRotLMbXGYsCVRDt9+yQzeui6KeNa8pMnMb22z6JE
 dHtm4byJmblJTDx7Sn8yvBrlv0mddUftCdf0C+VtqtU1tee
X-Received: by 2002:a05:6830:6c84:b0:7d7:ecfc:62d5 with SMTP id
 46e09a7af769-7d7ecfc6d91mr1005703a34.31.1774014788137; 
 Fri, 20 Mar 2026 06:53:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eadfc678sm2117281a34.19.2026.03.20.06.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:53:07 -0700 (PDT)
Date: Fri, 20 Mar 2026 07:53:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH] usb: gadget: Move USB_GADGET_DUALSPEED to be slightly
 more visible
Message-ID: <20260320135305.GX502704@bill-the-cat>
References: <20260317012433.4162524-1-trini@konsulko.com>
 <bcaede64-7918-4eaf-9695-a155b1395e50@mailbox.org>
 <20260317134107.GR502704@bill-the-cat>
 <bbdd71c7-3276-402e-a9f8-98afffd10538@mailbox.org>
 <20260318012649.GG502704@bill-the-cat>
 <bf3bb11e-e891-4703-ad47-04d53e21d7af@mailbox.org>
 <20260319133952.GO502704@bill-the-cat>
 <b48f3f6c-0403-4528-8de6-0b24caa810ef@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9KN+SQnZq9oH16YS"
Content-Disposition: inline
In-Reply-To: <b48f3f6c-0403-4528-8de6-0b24caa810ef@mailbox.org>
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


--9KN+SQnZq9oH16YS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 06:57:21PM +0100, Marek Vasut wrote:
> On 3/19/26 2:39 PM, Tom Rini wrote:
> > On Thu, Mar 19, 2026 at 01:50:56AM +0100, Marek Vasut wrote:
> > > On 3/18/26 2:26 AM, Tom Rini wrote:
> > > > On Tue, Mar 17, 2026 at 08:42:06PM +0100, Marek Vasut wrote:
> > > > > On 3/17/26 2:41 PM, Tom Rini wrote:
> > > > > > On Tue, Mar 17, 2026 at 03:34:36AM +0100, Marek Vasut wrote:
> > > > > > > On 3/17/26 2:24 AM, Tom Rini wrote:
> > > > > > > > As exposed by "make randconfig", we have an issue around
> > > > > > > > USB_GADGET_DUALSPEED. It is possible to select this symbol =
(via
> > > > > > > > SPL_USB_CDNS3_GADGET for example) and so have an unmet depe=
ndency. As
> > > > > > > > this is a hidden symbol, move it up within the menu.
> > > > > > > What is the issue this is fixing ?
> > > > > >=20
> > > > > > Valid configs causing the kconfig part of the build system to n=
ote
> > > > > > unmet dependencies.
> > > > > Lemme rephrase, is this actually a fix, or is this some readabili=
ty/ordering
> > > > > improvement patch ?
> > > >=20
> > > > Yes, it's a fix because randconfig finds problems that users may st=
umble
> > > > on to while trying to make a valid config for a platform.
> > >=20
> > > Is the commit message telling me, that "config USB_GADGET_DUALSPEED" =
is
> > > moved outside of the "if USB_GADGET" block ?
> > >=20
> > > Because if this is something else, and the symbols are simply reorder=
ed,
> > > that I do not understand how this could be fixing anything.
> >=20
> > I'm unclear what else you need to know to take this bugfix. The symbol
> > is not placed correctly, leading to possibly unmet dependency errors.
>=20
> Why do you think the symbol is placed incorrectly ?

Because we wouldn't get a Kconfig unmet dependency error if it was
correctly placed.

> What this change does, is it moves "config USB_GADGET_DUALSPEED" outside =
of
> the "if USB_GADGET" block in drivers/usb/gadget/Kconfig , which the commit
> message should clearly spell out.

I could reword "As this is a hidden symbol, move it up within the menu."
more, sure.

> However , I believe that is not the correct fix. The USB_GADGET_DUALSPEED
> has to be available only if USB_GADGET or SPL_USB_GADGET is selected, the
> former is already satisfied, the later is not and the SPL_USB_CDNS3_GADGET
> triggers a problem here. I think this is the correct fix:
>=20
> "
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index ebb306852a6..87d17780c45 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -178,10 +178,6 @@ config SDP_LOADADDR
>         hex "Default load address at SDP_WRITE and SDP_JUMP"
>         default 0x0
>=20
> -# Selected by UDC drivers that support high-speed operation.
> -config USB_GADGET_DUALSPEED
> -       bool
> -
>  config USB_GADGET_DOWNLOAD
>         bool "Enable USB download gadget"
>         help
> @@ -371,3 +367,11 @@ config SPL_SDP_USB_DEV
>           so it can be used in compiled environment.
>=20
>  endif # SPL_USB_GADGET
> +
> +if USB_GADGET || SPL_USB_GADGET
> +
> +# Selected by UDC drivers that support high-speed operation.
> +config USB_GADGET_DUALSPEED
> +       bool
> +
> +endif
> "

You don't need to guard hidden symbols. But this also probably also
works, so yes, please post that as a proper patch and I'll go Changes
Requested mine.

> > Yes, the error is discovered by randconfig which makes it harder to
> > describe how exactly to reproduce it (but I believe it does), but that
> > doesn't make it any less valid.
> This part is not relevant.

Well it's been unclear to me what you do and don't see as a valid
problem with this and the other patch.

--=20
Tom

--9KN+SQnZq9oH16YS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCab1ROgAKCRAr4qD1Cr/k
ChM0AP97UaOLzJ1eQNIMXSv9sh1tXkeRc7dKffklYra8qfvIqwD/Z/xyTBejoCAu
qoFk60mdp/r++5EJFfeBSTOYSz9cewo=
=z15V
-----END PGP SIGNATURE-----

--9KN+SQnZq9oH16YS--
