Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36565C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 13:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66C7087DD9;
	Thu, 15 Feb 2024 14:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DjPGZ7c+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A6D87DDD; Thu, 15 Feb 2024 14:13:19 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 901CE87DCF
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 14:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-607d8506099so4674597b3.0
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 05:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708002785; x=1708607585; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NXJ3/2jyfblBRpkQpWMo5iBIIIynn1K9reePjOqWMos=;
 b=DjPGZ7c+Ln10RfChRH24bCtM0XirtLcmQiGBjB+9L2K2ePY9xz4rGTJ+4lLOOXSmqN
 1NV8j4EyJQDiWpKhWani+q5qCyDgRdiT7gXnJmUOg4WszhsTS3JyZqwT5tb4qS7tMhh0
 94iJb1IKDBHsSWMYGao3P1oWI2Jx3Be8vsPws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708002785; x=1708607585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXJ3/2jyfblBRpkQpWMo5iBIIIynn1K9reePjOqWMos=;
 b=WTz8N9DxGEe75bNYpc74EvLY1W1VJ2W+cZ4mdnWfyfeVCakMP4u/OUnQN3QFRH7Ghx
 7MwqvnmcfoxlSxnABORbboP+jbiSnn/Z+R7jYa7vM+SPNkGK6fxfldlEeiFNkmKOy0bO
 qhi7ZcNQ7vL0NrPJIT9UKtEg+JGf1NCFBqp9PzQ4j9h2FkcMnYwFob9LKn8d3m+viwyV
 IbwqAa6BHIAkvbEDGRFSULqVimY6hQA62F6TOsBG4igtpzYm1nmK3wpXJDTwPgO6A6H3
 gpikMchOauQ75Z3/vpCFIRfNvKW6kV2ftil18KoLFAh526bODW9Ru9G6g0Cr8oOJracF
 ZLgg==
X-Gm-Message-State: AOJu0YyvCS1hdvTlVqjGOUobgp99GYwi6IDwr/It5Wdll9/lyTx5yyPv
 j4+2nL+6KXoG7UnsY3LcwypJSQhDLkErhG0P0Ck2jjw7eG5f56CuXfuWSfrHVKU2Gcw/2vq4Fvk
 Y
X-Google-Smtp-Source: AGHT+IFUg7y6KG92vJZQ7Tomd3UvDuwUhKHijTQUgCSYK+Dc7cBjlBoICCyoTeSfg5bVphyh9Zg2ug==
X-Received: by 2002:a81:af1c:0:b0:607:e20a:88aa with SMTP id
 n28-20020a81af1c000000b00607e20a88aamr593774ywh.16.1708002785290; 
 Thu, 15 Feb 2024 05:13:05 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 g3-20020a0ddd03000000b00607a1d2300bsm235626ywe.14.2024.02.15.05.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 05:13:04 -0800 (PST)
Date: Thu, 15 Feb 2024 08:13:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, martin@geanix.com,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v2] scripts: dtc-version: Don't show error messages
Message-ID: <20240215131302.GA3040305@bill-the-cat>
References: <5ece6e37de9321ad1c2e089659cbd80355181c4a.1707217112.git.dsimic@manjaro.org>
 <3baedbe13804025441547b23949bede9@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="avki2nT6biE8z6sS"
Content-Disposition: inline
In-Reply-To: <3baedbe13804025441547b23949bede9@manjaro.org>
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


--avki2nT6biE8z6sS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 04:48:52AM +0100, Dragan Simic wrote:
> On 2024-02-06 12:00, Dragan Simic wrote:
> > Prevent the error messages produced by which(1), such as the one quoted
> > below, from being visible in the build outputs.
> >=20
> >     which: no dtc in (./scripts/dtc)
> >=20
> > This makes the build outputs look a tiny bit cleaner.
>=20
> Just checking, is there something that prevents this patch from
> becoming merged?

I'll probably take this once the merge window opens, thanks.

--=20
Tom

--avki2nT6biE8z6sS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXODdUACgkQFHw5/5Y0
tyz3GQv/RF9rW8SrLXk5B9/cznkAE7HH4+Vyx2YK+Yp5vDU7lwg3Yh/T8fLTTL3n
eZTEAN7TKW0W3S3dOAfF750qUeCEPKy8bvqTRnX1uM4fiY6VxS/w1YLzeiTUOwqT
XRQDtsquBiqJp0fBFIsU5g3F2DoReYT/C+DfXFUo6lO7YDGsAmHnCi5+g6uI4fg4
DYswrGBR/mJZpicNG8UhII7auNzzyXIYvoatSBxlC/bI8jVwDnHKGTKqbuSmxs9t
CUXpcJqaQzFHteg1B75U33YwijR8tYzSrprAIjGshJGyhhgMBblF27+fdxvZTLLM
OIwUS8hoPcvTvPNZmfCuBWBLlTUTAOtU1FJs3BiiGancoUsobrJDYkIpjgjugEN4
0J1drb0MNI+N9pQvtR1m6x9JyVXqQnULUL4TOjwcJOHP8Jxm/v89sJvzpz7AXxe6
URpa0ZaApY76ZcIisHVwQCyqgEDKh6EUon71aK9dxwkKZ8qzeERlVkbP8Zn+nBUW
milvelKJ
=/uUY
-----END PGP SIGNATURE-----

--avki2nT6biE8z6sS--
