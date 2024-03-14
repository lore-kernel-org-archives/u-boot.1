Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93B1C54E66
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:40:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B97687F6E;
	Thu, 14 Mar 2024 01:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MYGT4Z5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED5B287F87; Thu, 14 Mar 2024 01:39:54 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E80787E3A
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-68ee2c0a237so3884966d6.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376790; x=1710981590; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pCOFRc9/LfwJo51jr3HxMhskNshNkKdcASFIQTaJ/Mk=;
 b=MYGT4Z5uRMCW7XyeO1p312NYF45lKK6dPKKIYF+CPhuaCuUo/mLlsS8IMGoQ9LQ7TR
 KM/hY2jbmui3ASIUUlk54FMxGg9lqrJ7xAS+tom+nW3Ca5F6S17B05zTaSKSthTlBaUI
 Lxj1VPxXHMDbuqaHSZPKmkVKT3iqfg0o0ZWJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376790; x=1710981590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCOFRc9/LfwJo51jr3HxMhskNshNkKdcASFIQTaJ/Mk=;
 b=TluMSUGlgKcqoIpD2q9I09dJ/i2EZ9M7L4vIAWIgWs31Q9gVzNg9QLYNZJCstlMH3u
 QdFn4QGliHH88qPNlKIZp5JbidGMTV8GKkR21Uo11f20glj6W7/4aeGXt42LGs0DYzjS
 UE2cto6832dw2SsVCS6rTtiMaURyYB+8iEQcXDmXUziFFf8rJrzsVBuaaH21KVqejhjN
 JrAdCPny24obTEJFE7IehpF1xxmXLRMmMSxhvZFt8Cvxw7H3/XV8YHPKfuhI1cu/G2dN
 QwAomT8+x0zrs7rj6ZMQl57ht0lmmz3j2W2duTJqpZJ6l42Z4c3TOXg5keDB82HTLMSG
 YJgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMEvYepceZ6u15+iEHrOzuWweHZI69aYj5+wB2M+MyK4hklRJInblqYNuNS8+Rg1n5im0aC+3CoueL4DRbf+75OyY4eQ==
X-Gm-Message-State: AOJu0YyFAFPhVajzVUAHLmirD0i60Ttn9AjbLZUcKmTWAv+MYm2NU4Rh
 BUhR7ELuWyL/ddcAbTcV6/xaEHD8/aIfvlT6513BBh3hykzAzKua8xTDfXly+Us=
X-Google-Smtp-Source: AGHT+IGQ+esqZgXk/3DidBdokqF8tjM1c72YZw9wo0fAW0sgHxFyci+KhCeR/TjDwJJrk/azCXN1FQ==
X-Received: by 2002:a05:6214:2589:b0:690:abe6:b6d3 with SMTP id
 fq9-20020a056214258900b00690abe6b6d3mr2832031qvb.4.1710376790393; 
 Wed, 13 Mar 2024 17:39:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 fn9-20020ad45d69000000b0069044802760sm215161qvb.120.2024.03.13.17.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:39:49 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:39:48 -0400
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] initcall: break loop immediately on failure
Message-ID: <20240314003948.GK3442575@bill-the-cat>
References: <20240305145525.1397253-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yhJpvGnVMwJRYuqF"
Content-Disposition: inline
In-Reply-To: <20240305145525.1397253-1-caleb.connolly@linaro.org>
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


--yhJpvGnVMwJRYuqF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 02:55:13PM +0000, Caleb Connolly wrote:

> The current ordering always results in func pointing to the next
> function in the init_sequence. e.g. if fdtdec_setup() fails, ret will
> be set to the error code, then func will be updated to point to
> initf_malloc(), only then is ret checked and the loop broken. The end
> result of this is that the "initcall failed at ..." error will point you
> to initf_malloc(), when the error actually occured in fdtdec_setup()!
>=20
> This can be quite confusing and result in a lot of time wasted debugging
> code that has nothing to do with the failure (ask me how I know :P).
>=20
> Adjust the for loop to check ret immediately after the call and break
> early so that func will correctly reference the failed function.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--yhJpvGnVMwJRYuqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyR1QACgkQFHw5/5Y0
tywP4Qv9FoSflFR4Zh6QrYfmcHkb9TD7dIHbMmQGSIT1J1OVESrgL57OGSl6zl7W
G4J/6CvgJgZw7NkgL5hLUuJAz3Rfi+9u2reNkZUoHc/ob5IQFGBDtnABx8yWwGqu
dRPsE+eqxopeD1VNODOU82w+qavPnPBr1aNly40depDTtp2dCxW9+AksHztIBEHY
0crvbTVqFNqsKmDMcgq//p/HvSDpzBAf5gAJw0b15c/083aCdVCzLIJ1cfkXUKki
X/3Fb3cJc85+3tquWNx2dtKJlKO8OJVTk3CWdwfFNDKtaQ8AKhCB4VsbjBvw9VEP
QZpjz/cKGmFZGzC6CruOUWAHKAPYy+ouMYsoHuCSBZycZWlF26XBsRFSGSQ7nprU
X3Gu6FPqBxmWjN3niwAUJa+yM15/ORQQCg2n1Hcs1De+5FJHFV1TdN9Jg22J9LPq
rDxxIMR9XbjcotCwBqt4bnOENKAQTFyLfKW6+4CJcMkr4339+1fZgDd2a+vIaao3
POnIXV15
=g8iA
-----END PGP SIGNATURE-----

--yhJpvGnVMwJRYuqF--
