Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1948EE49B2
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 15:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AB7386446;
	Wed, 23 Aug 2023 17:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L4eQxijv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FEB8644D; Wed, 23 Aug 2023 17:14:06 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7D68863F6
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3a85c5854deso2286477b6e.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692803643; x=1693408443;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8/q0DcJ2Ef6TIgULkZX+6Jh7LNmI4g9brB5+Yz6D+5s=;
 b=L4eQxijvBiT6CcKGG8FrFKGyUnjHzwmf8DEtH7dgJdYxMC9DrHa0CzCl2L3fYCXrwD
 lMQiJvfvhL9iYdsX5ufz+4AmQ7bavyYy/ZFhmYzeIjGkf3nsD3Ud92UP7KM+wGDTw3wk
 hAgQq7KD8iPcBAJ1LMm7oPCyjirA9glXcV3IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692803643; x=1693408443;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/q0DcJ2Ef6TIgULkZX+6Jh7LNmI4g9brB5+Yz6D+5s=;
 b=Dm5uhia2X0Rg/2s3J3eYI6bWVSLVxRRK2+Go5zJIMkTIEOhPM100irn1jYt/t9kgmn
 c8Csz0Ii9G8AYlaJdX2SSOUD793/3BH7sSivkAyHXSAnLx9L4wiQ3l6CjSS4mU2YetbS
 7yY6TeiEl6o8O8mWUk6J85oo6IuJJk3IMsjr0zLMbYLgjOM/NM0syusPKOt5nCmsg6Id
 DdZeB73KG9WZtO0i9gxNXbrH6H0B/b6Cu74FaBwgyMfRdYpFFII/3mUK808GXaH2HKMW
 c1DidV9fXskfrNPz9hevh+VEWOtee1Ke29SZIsbrGhHSaRt9O3msT6+T8rlklSF7tbwX
 ycmQ==
X-Gm-Message-State: AOJu0YwZaWYOopA1v0b0N0mKe5PyVrNNdDD2IjNtpg44kAprd6D8PGTK
 xYEvLRl7H6uPasjjmERxgkk5bQ==
X-Google-Smtp-Source: AGHT+IEFS+El2vQPW2mHWvwNM/pg5rDyaecg7kLEJY9DjzNYRyLWPn3Lu6C6c82G31M+5ZJBTOM6WQ==
X-Received: by 2002:a05:6358:c3a7:b0:134:e952:16a8 with SMTP id
 fl39-20020a056358c3a700b00134e95216a8mr11343154rwb.24.1692803643217; 
 Wed, 23 Aug 2023 08:14:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a5b0ccd000000b00d74c54dea92sm1427287ybr.25.2023.08.23.08.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 08:14:02 -0700 (PDT)
Date: Wed, 23 Aug 2023 11:14:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: Re: [PATCH 7/7] fs: Fix a confusing error about overlapping regions
Message-ID: <20230823151400.GK3953269@bill-the-cat>
References: <20230823134209.1450567-1-sjg@chromium.org>
 <20230823134209.1450567-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ivjmPz9OeM96BJWm"
Content-Disposition: inline
In-Reply-To: <20230823134209.1450567-8-sjg@chromium.org>
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


--ivjmPz9OeM96BJWm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 07:42:03AM -0600, Simon Glass wrote:

> When lmb runs out of space in its internal tables, it gives errors on
> every fs load operation. This is horribly confusing, as the poor user
> tries different memory regions one at a time.
>=20
> Use the updated API to check the error code and print a helpful message.
> Also, allow the operation to proceed.
>=20
> Update the tests accordingly.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> +	if (ret =3D=3D -E2BIG) {
> +		log_warning("Reservation tables exhausted: see CONFIG_LMB_USE_MAX_REGI=
ONS\n");
> +		return 0;
> +	}

This isn't the right option.  Everyone has CONFIG_LMB_USE_MAX_REGIONS
set.  You would want to increase CONFIG_LMB_MAX_REGIONS.

But it sounds like what you've found and fixed is an underlying problem
as to why 16 regions isn't enough in some common cases now?  So we could
possibly avoid the string size growth here and have a comment that also
matches up with the help under LMB_MAX_REGIONS?

--=20
Tom

--ivjmPz9OeM96BJWm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmIjUACgkQFHw5/5Y0
tyxCFgwAn2hEdUF6elFXmDwMHqrP6YN3auwZhtKtByx5R4HZJkMO7F+RzGoblBBu
E4unS1xMTmdIYuX0dVtn1RJDX2iGAb986iwtD6mKSKNvCt4e6i0ksFtDVkQcW7gm
2sb0wVlyM2Nnw7IXzsLc0dsT0P6hexzS062FNM/bamnc1nDh+2/rRIsAvyWi40YI
9jrEfhjjK8N3eWsyYwLcrNJkMb95sncDlh0hvt8kIRSwjV5tHrFZJl/zfl7d5DZJ
dzGkG73QYiDOpBzSmZSg4Ds+F/Nm2qm3wfZfPJ4hfAeR9Rp2rXLbDH59yFsSIVGC
xkAHV6v+n2APC7DJdnwUHkcGcyll6Ytdih4jQMpTT0KS0VCslVHqmUUhr18ABzeh
PGHA0Ifbkq3PWskpfQWXfHuLeI9xTq0eEz2/geyppHq1SnLCQe2Yb1H+n6CCerpo
kcfkqICSArlP5yUGJqOR+SPE8eLl7BNT/aw7yxR0oVXpcQJ4DoGWZjMNKhfasBC+
+zPalaQv
=CSTC
-----END PGP SIGNATURE-----

--ivjmPz9OeM96BJWm--
