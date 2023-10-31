Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11126C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 654DD875DC;
	Tue, 31 Oct 2023 18:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YZbDJ7QV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF9F87635; Tue, 31 Oct 2023 18:45:45 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0CC087517
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 18:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-778925998cbso410595485a.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698774342; x=1699379142; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6m5Pc9hfMxSrBbExTjNhPPhxmnQZZ2LaLHd+FKWjang=;
 b=YZbDJ7QV0LzXtA/TmH+eUKxMVpNPDqbDUbP4XnzYy5DvFmDORdBF+1Bfavv5h7+hNQ
 RpTE020+Rm98C7iUBs6K/VjbM5koKIrsVKXpwpJclw1iGNQPjdgRb8QoALdIICYChkMs
 eiVqm7CfvD44EMYsWvBvm3+HPrk0HbhqCn7Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698774342; x=1699379142;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6m5Pc9hfMxSrBbExTjNhPPhxmnQZZ2LaLHd+FKWjang=;
 b=IVytvqdbfm9FgVGntg+JJQ2qd4fhxHnnOaBnY/Cd6vUF+CiUbiAcY/J4/605InPeWi
 jvFJEeej4H/+v3RYNobfi+xloWxVR+vlapyxcU32qFrJJfAP6mC8qXcH/TKPrTxk6GTa
 K5Fusg89b3HQkD5LP7V5RjPbcWUUZp3MWO1a7Qxx3C3Clj7uDEpDhx+bFgUAPdCKzmB/
 tKLTmLLnl3XygaKuaUxblD3VrVK/YqEkWxEld0H1YBSUUYNqWyWdNcoaFs5yo1/Eyczl
 vwZT5s/tcn/5Rc99qXjw1BqIMigo+KoXGyWKINAj9qeOYyvXtPcQMItK0L+tsLlS+Ga4
 yiFw==
X-Gm-Message-State: AOJu0YzlKlYKDzqQFMAOHhFMVAkdujZVzMNsUUhvbyoM8L7M4e0k2i8r
 GkI/enqEvDieZrCx04wvZayU9+fPfxL9ACem5cDMEQ==
X-Google-Smtp-Source: AGHT+IGV7WR6uLjwQoYsHEQ5fBiDKMxnGiSLcKzZKhPe8ZptDRrpeHdemuYuyZqsywCSNHS+7zeSnA==
X-Received: by 2002:a05:6214:1bcc:b0:65b:ed3:9a02 with SMTP id
 m12-20020a0562141bcc00b0065b0ed39a02mr17763140qvc.17.1698774342214; 
 Tue, 31 Oct 2023 10:45:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 f9-20020a056214164900b0065af71585b5sm721875qvw.58.2023.10.31.10.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:45:41 -0700 (PDT)
Date: Tue, 31 Oct 2023 13:45:39 -0400
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/4] pinctrl: npcm8xx: Add name for gpio function
Message-ID: <20231031174539.GO496310@bill-the-cat>
References: <20231023070225.3142578-1-JJLIU0@nuvoton.com>
 <20231023070225.3142578-2-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pGVVqQfGhDlDQ19b"
Content-Disposition: inline
In-Reply-To: <20231023070225.3142578-2-JJLIU0@nuvoton.com>
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


--pGVVqQfGhDlDQ19b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 03:02:22PM +0800, Jim Liu wrote:

> GPIO function name is needed in the debug log
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
>=20
> Changes for v2:
>    - add commit message
> Changes for v3:
>    - no change
> Changes for v4:
>    - no change

Applied to u-boot/master, thanks!

--=20
Tom

--pGVVqQfGhDlDQ19b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVBPUAACgkQFHw5/5Y0
tyw6Igv/W+8D58hLHh7GZVytltID9g1wW8CDPKhKcU4bc0z2EnObmlDs8mA5NGXf
+5dRxH8XgcGbD6IJnp3DXPLiv6q+DptFSiQVXXizh1DK9mtzLoP2eYXy87XuLdpC
feMqpmNpht0aR3PakAfV2vmc9Ty3FCzOl0JRqlu+P8DoWBEuWrNiGtFLvH7fqPp8
Q9q79qym/R44JIJLUP/MjXq6lob23/xV4Rf8Xc8AUCWiK1ylezezBbMO2Xj8kZCW
d1Kh80njCfbcTbgasOh+5VsIasPjPz/OOJQhDDUgBjRMLuPFwGytL4jYKquVhVwO
yH7qF1oysn3sT6Xn5/kI8BFlLnXaynqpSLaGPT0XgOpm0B5Ui28EdzNyJaglusUf
IdfTauzVO9uTZEyoSwZuFBQdz/WKOw7PpOCieo6WUAUrk7aSc6RsunrCJ2kD7tot
7Dcfd3YQwik4RzMw0IJVwnJlzdesEcv5mgFGP5z0fA8YW/e8wYPDL7NIUMytywwf
SQDLr7s6
=Y4/I
-----END PGP SIGNATURE-----

--pGVVqQfGhDlDQ19b--
