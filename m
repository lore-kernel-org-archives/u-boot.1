Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1261EC54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F13B8806E;
	Wed, 20 Mar 2024 13:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F445Wz5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A06E8803E; Wed, 20 Mar 2024 13:41:56 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36DDC88059
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-609f060cbafso80113977b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710938513; x=1711543313; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tAYlyr7x/2/7jg/7Zdb7l4PTKk4S6GQpJeSmzE4CSFg=;
 b=F445Wz5zGN5ktkYWJHXXehkx5ESbrPL6ythwEADxUgndslm5aLI4swq3cxXnoG7703
 TGmr5JAia9cfQ6Px/tl9BWmvD8dDPQUlGNyjRqTxFlT93NhmPjtPiVx01LFuC3GC12U1
 IeO8ZIml1E2R3td5rYOG4BPDTMqK24gZspT0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710938513; x=1711543313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAYlyr7x/2/7jg/7Zdb7l4PTKk4S6GQpJeSmzE4CSFg=;
 b=GfImPGsgsyhFuwUwfb+RB0XhZKQ3SmBPdNbgbYIGngWlDX8nRxldbZpMQdh9dWdqca
 XHd4+jTCRt61I/ASpiD0OsoB/X0gBn2qzZRTnMAzweZ35r1pCG2kheHY9+KM929+Cx0d
 Y0oStQARoX13kGDSygtEgscgRIInXiRFzEV9XpFaJTV6MfeTuAAT4P1fzWY9XiZsB6d7
 MpqR9bg5Rm7eX8SJHJXkVRDMoWrlYFAMvUiDvF9m4B/aRCluGbu+KqER5YQMO3hWhSY8
 F8iMZKsc7DmVtQMXRdjPYdb7dOq8y9aAn6i0eCsr+AsCEGogWESQ1RXAXijr7KGzeYOh
 Zm1w==
X-Gm-Message-State: AOJu0YwZZTQLkOmUw0GQTsylREBMoxZOBtRh59ql1lQrv3h0xcDx6E6G
 MoWyANulNW9QdbdV+l9WKR5Aw+HV0vZjzrTvmNF79OoeV51mNAvdahmfDYtLXq56Fh20u5eSqzI
 i
X-Google-Smtp-Source: AGHT+IHSWrg7is2wP9brs7tMnUpqkLB1QaJVMvKWrxp7IhMpWZFaqfsaKNTCmzDjuCREjHViS5TKEA==
X-Received: by 2002:a0d:f485:0:b0:610:e457:a7a7 with SMTP id
 d127-20020a0df485000000b00610e457a7a7mr4211729ywf.14.1710938513051; 
 Wed, 20 Mar 2024 05:41:53 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 z80-20020a0dd753000000b0060a048aac3fsm2789698ywd.96.2024.03.20.05.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 05:41:52 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:41:50 -0400
From: Tom Rini <trini@konsulko.com>
To: "Leon M. Busch-George" <leon@georgemail.de>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v4] Makefile: use shell to calculate map_size
Message-ID: <20240320124150.GP3442575@bill-the-cat>
References: <20240310215356.109478-1-leon@georgemail.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CcoqI3iI1zX9K1hT"
Content-Disposition: inline
In-Reply-To: <20240310215356.109478-1-leon@georgemail.de>
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


--CcoqI3iI1zX9K1hT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 10:53:52PM +0100, Leon M. Busch-George wrote:

> From: "Leon M. Busch-George" <leon@georgemail.eu>
>=20
> The error message "bc: command not found" is easily missed since the
> build continues.
> bc is not a part of coreutils or base-devel. POSIX sh can also do the
> calculation.
>=20
> Signed-off-by: Leon M. Busch-George <leon@georgemail.eu>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--CcoqI3iI1zX9K1hT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX62Y4ACgkQFHw5/5Y0
tywhnAwAo+gSkId9uNBI/5e0jI2htEL0i3xXhLdiAeHTrf2xYz3EQhJNhyBOabyI
N9JjJ8mStiUnMkUoDvMddcB/gB8eXMkMdQ+pUY4nYn4yQZx8CHXYMhuYDvI5V/TF
Cu/BKxZ8ygvJCt+bz2lCgtmeCrHDLHw56V9G1grYiEoOf7JYOYQ/BpqguZKQQR9M
qaD2py2iL+JfO50p1kKpvYtOy/2KFomNgscyPtjfR1pINYbn/cMJVgVU2+Iem0uh
TZKB+Q4objVq1DlRHryoShn6UpTNapJlB0zwkp87wVNFGX8Sbnop7L+2g/O2Cr8V
UTDrP+c4cLu9qEjRBkfg/ccSdeAAKCzwBp1TQ/TooqxQwCxX7hLGd+KHE5miy0Eu
tUJjik736iv1+YWXlqgNFQ7SVFdl5vCTt3IqzNXi8P2YqjavK52kntntSOj28Mp3
rdE2OvBkxX6xXDFWIIqehOz6/dvdvazzcnQHaeFklan5+wGlh8FUDV0BkOUO+4WS
AiII3lD3
=C5hV
-----END PGP SIGNATURE-----

--CcoqI3iI1zX9K1hT--
