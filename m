Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3D7C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 22:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD6AB86F56;
	Fri, 17 Nov 2023 23:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RFijvocM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1190F86FC9; Fri, 17 Nov 2023 23:10:16 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64DCD86F56
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-778999c5ecfso144385185a.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700259005; x=1700863805; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=puChSOCGWrnLc8JHhVOP0I0GLk7nHKOfC5MznETCIks=;
 b=RFijvocMuyfrRCrfglbeL9mq5OZpwXenTvUfYvp/UWgZWLUmhXnae1pzWdJuXhuMlC
 o8odzbdZK0uOuCCY00MC0VEGa1M8QCmCXQfydhAtAIShLBPyyhDDDmX6pg+0wfyZ8MYO
 4dAt0fH7+Hlc2B4FLx84rKFab4+3bqz2JUyiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700259005; x=1700863805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=puChSOCGWrnLc8JHhVOP0I0GLk7nHKOfC5MznETCIks=;
 b=xILkxBLDve8FGth5UXOBe1hswyBOWq7ODgF6Qxag9YQKIuwSaeCClMRpAjFLZz2DzV
 lAqdRVLD/PU7st7CZf5CttHyvXyyXReWQ2bOs39H0p+vLubaxQ13ExqSCgGTs7o/lKRI
 L6G23OTVXEIqxxnetya4+HfJT9rWjcU0K0zIYTc31LPRKPpJdeWNI+e+KnIM4eLtw3TV
 Kk1/GRMr1Ywxt8r8Mxk/YNY9AVheXq0rz3yrsHIjSKkzNk+GNLnuPensLojMJ/MuWOZ/
 IKcyjkOi7JkQj721nX0fWOGm4LM0kvBTxkulQdIcC7o+UHQeJ77s9m9Xs+QKz9NJXP0m
 RLwQ==
X-Gm-Message-State: AOJu0YxluaU/OBlUXq4zGOs+oLSVU7MltMGVSP6fJCRPpDy0nWWQI466
 Dug10I8zwVb2V+nRuV7jELbQAg==
X-Google-Smtp-Source: AGHT+IFAwQhUPzSmmttUB8E2YTrg+cUZL+rGDXi7amZvEBRlKpo1b9pkbNq4xTpHsjcNFXoOPjB9eQ==
X-Received: by 2002:a05:6214:234e:b0:658:65ed:7e8 with SMTP id
 hu14-20020a056214234e00b0065865ed07e8mr540850qvb.57.1700259004951; 
 Fri, 17 Nov 2023 14:10:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a05621410cc00b0066d132b1c8bsm931243qvs.102.2023.11.17.14.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 14:10:04 -0800 (PST)
Date: Fri, 17 Nov 2023 17:10:02 -0500
From: Tom Rini <trini@konsulko.com>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, pbrobinson@gmail.com
Subject: Re: [PATCH v4 0/3] [PATCH v4 0/3] [PATCH v3 0/3] BOOTP/DHCPv4
 enhancements
Message-ID: <20231117221002.GC170968@bill-the-cat>
References: <20231117214925.138486-1-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oJoVpqmAKzDVZt+K"
Content-Disposition: inline
In-Reply-To: <20231117214925.138486-1-seanedmond@linux.microsoft.com>
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


--oJoVpqmAKzDVZt+K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 01:49:22PM -0800, seanedmond@linux.microsoft.com wr=
ote:

> From: Sean Edmond <seanedmond@microsoft.com>
>=20
> In our datacenter application, a single DHCP server is servicing 36000+ c=
lients.
> Improvements are required to the DHCPv4 retransmission behavior to align =
with
> RFC and ensure less pressure is exerted on the server:
> - retransmission backoff interval maximum is configurable=20
>   (environment variable bootpretransmitperiodmax)
> - initial retransmission backoff interval is configurable=20
>   (environment variable bootpretransmitperiodinit)
> - transaction ID is kept the same for each BOOTP/DHCPv4 request=20
>   (not recreated on each retry)
>=20
> For our application we'll use:
> - bootpretransmitperiodmax=3D16000
> - bootpretransmitperiodinit=3D2000
>=20
> A new configuration BOOTP_RANDOM_XID has been added to enable a randomized
> BOOTP/DHCPv4 transaction ID.
>=20
> Enhance DHCPv4 sending/parsing option 209 (PXE config file).  A previous
> patch was accepted.  A new patch fixes a possible double free() and
> addresses latest review comments.

The changes from revision to revision should be below the "---" in a
commit and not the commit message itself. Please reword things for v5.
Thanks.

--=20
Tom

--oJoVpqmAKzDVZt+K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVX5LoACgkQFHw5/5Y0
tywYEgwAg3eoqoTmV5NTZCnUEpPJbNNfCej3XKEsbjMQp5baNv/S/8oa8HHBZA8W
BnXDdsWrPJ3dXUjB8CRgUVbNH/Hd9Rycm+tYQpnX9JUrUyUSIY54Ad5e/tmK2Z+2
xJGagNYrm402J6UtffXcteGb2CW3o/IuCXQuMDr04OaLjsM6Wa9MrObn0osfD1K3
NW50daBBFswUU9Z1h/hLfLFq8g+339cmLUKL+RhbHQjJtk6tgXGtdsRGY4X02L5A
IY/witRtAtTL9yU4PHntH+XqAXBjEUAw0hABiczPypEZ6tGMRcrZfPN5tI26fNyy
Yl03gRwl9BUWpl8gcKm4k41eE58LjJcrba3pZAoyR53SyMONYBJc3Q06MAixPWlc
13NGJYZEJ3+9dnZfOanTOnxJfsVZTnp8avFf8pcS0rWwxt3Hc+Kz2fZTCHkaHnJJ
Q/t3dKLRXt5r4CIaol3EyHXsShN9qafplTbwCxGzPRKpHmTyfn7diuckklc/dB46
HmvCZf7f
=Yy25
-----END PGP SIGNATURE-----

--oJoVpqmAKzDVZt+K--
