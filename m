Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F0ACD4F21
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 18:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 629568865D;
	Wed,  4 Sep 2024 20:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rqT0a2A3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF0AC88B84; Wed,  4 Sep 2024 20:14:09 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E559F8865D
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 20:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7a8197d82a9so327414585a.0
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 11:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725473647; x=1726078447; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8THYcw/b5nkODZyEzDKGTg1cbSdcLtHAzNZkmo5Ak8Y=;
 b=rqT0a2A3fIi1Hat1g0SQtooQF1E6iLfHcQkTvhm9Bn2GSKpVMRe5b0z/wPDHbobXJ4
 Pkj8GdBA0TaGPHMWW9AwxyowB2JE01DKj9LnOb8329ldZjrzXfrJvj609BofjXtWiXj1
 pxejcmrFspF/CVoRLDH7mtZYhM9SXy2ft+LR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725473647; x=1726078447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8THYcw/b5nkODZyEzDKGTg1cbSdcLtHAzNZkmo5Ak8Y=;
 b=L7xhYvEAHCDkAlA2KZ6KaYXaGqK+wILjlWS7k2ssRroYex43tHdDc9i4ftYSxJ2t85
 mCwjHzpHCbb5fSfq28aoQxyxGMOUmuIutXIy/oTuDMJBqinK5ehwBQM7yqliFgzhe6Ug
 z+6Wdm2veP0JPWMjkEtYXJ6Yi7mIhEjakW+Jph2C8KRLkVzPu0V04lvwtWOHRLU3mUCs
 XukrnitBQC2f+liaJqR0kKYvGEnU7c0MgQ2K5omLhKRfLAyVam5G84+RPX9TaJ9KjNOy
 IuCx2TKoPqeG4W22AbSYoAPZqXNvye6uFe1sFT2mHkKkpbBQzgoAVIL/RoSTqPKZELxq
 dQEQ==
X-Gm-Message-State: AOJu0Yzvo4s46v3o2IdH+DEFjGnFffNe9/ochALLySvO/PWzPNMtru5C
 Un9iDyhsOFw3legw42+suTeqaIqNh9SYNhNTKGxqNCy9PCxy8JnA1XmiAx514KI=
X-Google-Smtp-Source: AGHT+IGRjecLR5GJ/Av+a709Ln6VVfJUiWf+cTUmFRnC5CkpIegRI45CeLeppsFSL+LKvyduzsvp+g==
X-Received: by 2002:a05:620a:2404:b0:79e:f82a:a219 with SMTP id
 af79cd13be357-7a97bd2b31amr810641385a.61.1725473646631; 
 Wed, 04 Sep 2024 11:14:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98ef4742fsm4400085a.58.2024.09.04.11.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 11:14:06 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:14:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20240904181403.GS2479150@bill-the-cat>
References: <ef195bc4-6b61-4c9e-9de8-269e93b73388@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p/VLhIc1BuxoGhZ6"
Content-Disposition: inline
In-Reply-To: <ef195bc4-6b61-4c9e-9de8-269e93b73388@denx.de>
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


--p/VLhIc1BuxoGhZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 10:17:43AM +0200, Stefan Roese wrote:

> Hi Tom,
>=20
> I know it's late in the release process. But please consider
> pulling these Turris Omnia DDR related patches / fixes, which
> Marek would like to see in the upcoming release:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--p/VLhIc1BuxoGhZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbYo2sACgkQFHw5/5Y0
tyzMuQwAkBpRHJWeIo58aS7k4PXf2JmHzE6xxu1TKXqXhCuTHPq4Cib11lvG1yhf
YJY5HRgYGtx4EZjiII6phwjdjQseyKZTdCuFSNNJcFWeHXugdPmycep7TbpxoCmQ
rqKZKX1smxRr/uz9o0YY0Ss7Vrq3barHslnp8gOK5Nx71YNJZhERjLfM9kmTgjvb
cZvcu1GuQ9YiqPIkHlWU0+EHNTKPA+mwfbN1t43OTgjdppPxDU9OSYihyhq3RrlY
q7gypfJAZjZbbgE1GkEXlH7OTbT3eZrQAGfmW6Sdk7/DWuCxGRqgp2KxVJCzCVok
VX12NeAk7HEaUT0/RUunhMMw5hz8tGjs1H3NftEpvyd1uVnNEIIUrpy89ZGLDUwH
EJFHf5nlV0hhZzGXlujOSxfisajLZxbuMJsGwyKP9WDBVpwjeMED73aA6A9QqZOy
mpn6+s9sAkI0s15ujVw2PNxJIaWJU0UXdCnxkvjpMDf84+b9zV+NGnoNxb3fWlXE
V1boaNXg
=CRG7
-----END PGP SIGNATURE-----

--p/VLhIc1BuxoGhZ6--
