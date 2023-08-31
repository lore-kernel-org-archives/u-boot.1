Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8821FC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37651867C7;
	Thu, 31 Aug 2023 18:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z+CsQpW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF2D867C7; Thu, 31 Aug 2023 18:27:00 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FB02867A0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-58fb73e26a6so12021397b3.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693499217; x=1694104017; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5y6fIe8QSvXyDBY+mwL41p7dALISr8cCVpMTcV1aZ3I=;
 b=Z+CsQpW4mFVgljD+zUfkVIiqAT95odtkkVmnBvPRdzZwolp2q4jXlhfTbYsnkS+xb1
 6a4W0DyjF0PB5eTJibRZPi6bk4/HDaRYcjjUX1jDv9iC0tm0Nht2qnt4OMIU/3bpCe1a
 uLHWSV9zuQwmMAtilKB2QRxkgliIOnHn5u1y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693499217; x=1694104017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5y6fIe8QSvXyDBY+mwL41p7dALISr8cCVpMTcV1aZ3I=;
 b=ezpPE02XbMyb+KMfYDXbvptHqHbmS0Mn5EBqfk5Rs4KIY/T36sx33WLuvbDrZAvuEH
 1JEWmr+wr7QozbWwTSR4npVLJMMY+gJNQUZqJ7nRlxFWztY0DmOn6bl2SbZVeB+Y0Fmk
 4CgXWJcz6rIgZXqopsqqPrO21ggwWNlTmZ0n2KjttUB0t4zNJTuMAAQLynF+aswwIo9y
 lV+ZKfEZ0O0cdGVBPRAshBSEoAJtaHZCcKRgO2O6FN5WZ0ej0whkVDbRTpr/bCse3IO5
 jQUC+Y3TiNnx4bvALlHI4BkqsT16KELMDrhRSYVp1LjsCGmWZw/04rjF6Lg/MwKmGUWN
 QovQ==
X-Gm-Message-State: AOJu0YzrjGy5qzTbo9pdLNUXnBGpyb5YfKvntNHLi8oV9fholbxI85lr
 +cNvAp8eCqyyI3p2q2yxOsWYrwB5MWeY+8G+54lHog==
X-Google-Smtp-Source: AGHT+IFIv4nw3PX5SpTVdpYDXgr0eRX5uxS7JVvAIohVY/vC4Tsw9Ay8MbxJmKACtu8wnpUSiaGaeA==
X-Received: by 2002:a25:da0a:0:b0:d78:f1d:2e23 with SMTP id
 n10-20020a25da0a000000b00d780f1d2e23mr178150ybf.53.1693499216828; 
 Thu, 31 Aug 2023 09:26:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 m19-20020a25d413000000b00c64533e4e20sm404420ybf.33.2023.08.31.09.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:26:56 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:26:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>,
 Simon Glass <sjg@chromium.org>,
 Steven Lawrance <steven.lawrance@softathome.com>
Subject: Re: [PATCH] tools: image-host: print error messages to stderr
Message-ID: <20230831162654.GJ3101304@bill-the-cat>
References: <20230817153612.30544-1-oleksandr.suvorov@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sCaNRFPqsLXBjFmS"
Content-Disposition: inline
In-Reply-To: <20230817153612.30544-1-oleksandr.suvorov@foundries.io>
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


--sCaNRFPqsLXBjFmS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 06:36:10PM +0300, Oleksandr Suvorov wrote:

> The make by default cuts off the stdout output from external tools,
> so all error messages from the image-host are not shown in a make
> output. Besides that, it is a common approach to use stderr stream
> for error messages.
> Use stderr for all error messages in image-host.
>=20
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--sCaNRFPqsLXBjFmS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwv04ACgkQFHw5/5Y0
tyw5Tgv/XO1jHrZLdu1N92Mx230LheWkzBOdpUWub9LliJfIuJ7niDV4aqiVN16I
sKUZWhavC9HFmMVb4AKS9zXrIRZnDKluRFlQgc3nYRVEdGgPo/DJGgxOMBHEqAj4
Cl8iD+cB4ICREuoRaJrFG80bU5DdVM1Jmkj1F8P8GHYKNHHhNbzeUygLP7e9WWuR
ssrzxLznw4zQKjbblQ7xCjmXs/6kecd/VEAao5dv61/j/5Q78XdKrRSRd+SOe1tc
s2NHshprVNwS7KNcaCuLwRLj9NRK22v7oJO7vf10f2YarLcU8ecYq9iugnhxRAQr
Wie63fi5baKtKLFs+BUVbE04UW61DOvdS+4IExu1rV2RdGvay02xuM43ssSDX03a
BofL9rdOZ1+Yv5L3sjvK8phkgAmQLPSMnt3+z5ZZygIwhFzkJy1NuvqTo6roeuKo
ScNG73fUI+Uu9LCaF+atx9e2vBA7/OtAgGgB7kybEB3hycIpbRZOMx42qv+hgPQl
5owDFTET
=lS8a
-----END PGP SIGNATURE-----

--sCaNRFPqsLXBjFmS--
