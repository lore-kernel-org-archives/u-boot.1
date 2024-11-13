Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059EDD637A4
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 17:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 801F588FFC;
	Wed, 13 Nov 2024 18:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jl+g7PHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D904588D56; Wed, 13 Nov 2024 18:53:38 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B62A788FFC
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 18:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7183a3f3beaso3881598a34.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731520415; x=1732125215; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cRXhOdHtt/pPPLp4VjW3QA1sjqug2Dwjye6oV1bIpTM=;
 b=Jl+g7PHitJYuvWebVW2NJz0Fw+eHtWcjecyz78M5GSRNesLnyFO6/237PAgXNqm1QH
 cmtCoyVGdr9G8Eb6x9XHMzhd/CStimSdZHKKn10lCaE7dYUpHXRqt1+ZqMdTZ0jFwmdb
 Ons/wpstQHCs33plFGGTesvD6rnO9u3ungb4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731520415; x=1732125215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRXhOdHtt/pPPLp4VjW3QA1sjqug2Dwjye6oV1bIpTM=;
 b=sjSriPRGbFGwdLmGApVuWL/f+qIHDuG94dJMzrf0jWP3sbmu9/wC71nIk1gkV1RY9P
 6V7Jx+WGYpVIj0S8+a6hdRyE+FDrhlvcxs/24qw2/GMds4zqFwu1yPhJ0JuVhuiyNy9i
 kDMzzFP6v23knaais/kM2UtRPVk48ftNEp0NDGFg19VoXV8kbRuIRBqnQF7n/pcjLIVa
 Bfn5X7ANEbJne2nb0TEFIqpzObKQRKmdhgIfULX75aJfjDasXAHkouM5BsCe8TTH/vYI
 pauRFEaST+iBzyde9EzNBNiQbvnDiCgy2USO9WstammWKwyTXPPR9dx8coCU7ajm661q
 FkxA==
X-Gm-Message-State: AOJu0Ywz59vYLYlGzL367UYgwhTZTmiF7dmvTHHH3TtxuGHeY3RYZMgR
 JUvTAyxL0kYue7q+DWCgLD12DS+Lsul6gON6DcmBtrxeCnyGnFDvNae9M3k7hjM=
X-Google-Smtp-Source: AGHT+IF469BJfja5g7/bfuhG+4wQMq2ujqr1WLv8Nr1XCL0e5xj8tDNsHRvjIG2mS7w1QHfsB7P6gg==
X-Received: by 2002:a05:6830:388e:b0:718:180b:5b3c with SMTP id
 46e09a7af769-71a1c2b1334mr22611690a34.28.1731520415473; 
 Wed, 13 Nov 2024 09:53:35 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a5fe6381bsm775806a34.15.2024.11.13.09.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:53:34 -0800 (PST)
Date: Wed, 13 Nov 2024 11:53:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alex Shumsky <alexthreed@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Janne Grunau <j@jannau.net>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v5 7/8] env: Provide a work-around for unquoting fdtfile
Message-ID: <20241113175331.GU3600562@bill-the-cat>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F8QdJLrtZIkeu46J"
Content-Disposition: inline
In-Reply-To: <20241113150938.1534931-8-sjg@chromium.org>
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


--F8QdJLrtZIkeu46J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 08:09:37AM -0700, Simon Glass wrote:

> Some boards use a CONFIG option to specify the value of this variable.
> This is normally handled by efi_get_distro_fdt_name() but in the case
> of sunxi this does not work, since 'soc' is sunxi, but the files are
> in the allwinner directory.
>=20
> Provide a work-around for this particular case.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--F8QdJLrtZIkeu46J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc055sACgkQFHw5/5Y0
tyyuhwv9EweKeA6CcAgbhc7f5HYGBzE85WcUd4Ij9G0HaxCDpL6BMN+FV8bhE+gI
XSADYUXzIQ1oqfpS6YG73lm3iG4iJDdisp1LTg3mZEJIEIp7DeYC+dXjLM/AUOEK
UugmewVeNTzHK/vKxkTzld2GpvfZfqi6Xy6nGVDUNptMFKbsDccFR02wtuOQnj/M
4+UfjX5YTr7oq1psMSJyRPOT9AV5uFG/8iL3eqT0CNxUJ9lDvwi0IfN5DMmvL4pQ
8pOjasZsc5uXroxLaHWqNBtEnU9JWLYP86behiEvJItpqqM5/EX/OreQHMiaQDlV
pJzStg/zPG28IHIXAvpbn+PkZn3NXEYu1gNWny/jmxhvb7UXw5tfrL2JdZn9DAEd
6w1xuB5/oSewGfx51NDwJie6/LRLlTf0Fwob1H8008/LiRiraT82vfGXJrOr6dMs
vAtLxrmbZzCwRfDOQerIFbyvo8ygmjuBGW523e0DVo1hIlA/CRf/MYzOHp3xYXz1
tyEuEG7J
=wmoB
-----END PGP SIGNATURE-----

--F8QdJLrtZIkeu46J--
