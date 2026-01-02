Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCA7EED628
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 15:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13EC983AA0;
	Fri,  2 Jan 2026 16:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AQDIk7sp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9130883AAD; Fri,  2 Jan 2026 16:43:42 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E8783A8D
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 16:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-44fe6771b2dso2404779b6e.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 07:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767368619; x=1767973419; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JCzFF6LNFF3DaEYODYYuea90s/e/Qls/c0NT6+PRsGg=;
 b=AQDIk7spvTM7+nf6QK44nvBdtD3CnQ245R93NFuYM05Mni56+oLPwp4nWiVhq+pas9
 b2sMagzBHTgyoGBM45VKp8secwv4dvfQyom9pNxw4MMIUM4et3lAiDPta397BELHSVMp
 Em+iMiTUi9FwOfdEc+0/F21uM6pGVP9dm6Ml8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767368619; x=1767973419;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JCzFF6LNFF3DaEYODYYuea90s/e/Qls/c0NT6+PRsGg=;
 b=hvg1Vqc8ITcPBF5xy9c45bJ8wCIphcb2nIWf8HEZTpp/n8FEa0SxE8tqFdBTW1/3jV
 RrZNHF69lfKLs5soP2ohvRsPEqT5aknCg2OA9RSbSykwN9YBT+GjvSRPtTxYC07Tr8ju
 zkTQ7e9sKlD34ZNj1G6AOEsTEE/k5SVud2P3hansP29Kq0qgeQeluf1rZS6jqqljd/sr
 a1pjDhbxAYldvaa4fdE0342iEFFNXJnAw96xe6DakAYqvmfOu8qlbx+acwTrnBBYL2Ad
 5ZT1qySF56HRbZbLVZ+j5sqBCvGuU2i/+i/vQkxyWUNx4L47Dv5kAxCNqTPGO7xAlKT0
 Ptjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoC64362avAC2FwFhMKwVxTgBBAmDzKGR1VyD4bObW0zqTntb3ONkXyT8L5vaaEBNtnLViBdo=@lists.denx.de
X-Gm-Message-State: AOJu0YwXQprJvBBLOXJpzIvEEus/+tV2sxs35emmdA883iWi3PiQe5Ur
 MYFVvdVg9cfLPx73bNH2dfDsnU6BGZ7lZIUxId11rxie3H/OeA6cgA5tLAsTK60GsxY=
X-Gm-Gg: AY/fxX4a608wMVVdan94xiA2k6jTOoz12wt7gVTwXcZAULGv5gDNn0PGX140MTFuyau
 vjAJI0W1Hye9zJdm7hdNfU8g4LWmu5bHi2hrybXyhJcMob/d2bQS0yOz0jTtsjxOxYctpCKqPWE
 72ZfXtFWadfOfN77zNcFshO6+TaXx2vLXWcd0cFehtuW3v4cx6O23UcjxcJyUJff1Vg5P0VLlBk
 d5EcixgwX+nkM+GmmSYfaduvuK+k7H26dQjuOFt8XWCc731WkH7UiQtM63gT3lxqwTr3Fyr92ig
 aJR40X6vlsAze9yGcgjieibZ46voKFIgw+WS7u9KJ0ZC2w+3YxD1X97uTZCbeAtvRb7rdXk8BNd
 KgJSOnWbi6AYRJIKVAt5zcDgJMBcjrZIBh6WoB+GnP+nUBm+q+EI/IwhrMPyLceFf+neL5NZCVu
 hAO0bvlmFa1aghselR8ISNoCehWxaqh4Ryhd2ffa43dU9/FWgxEycwXVOwQgg7jHWsL0s6NyrbA
 vt/Wx7Iev0KkOXP4RDdcqJpDUHha8veMokriEo=
X-Google-Smtp-Source: AGHT+IE0L7J+qA4ocG7uZlervKYrMvIMswX4ae+7lcvQD7jdC4u5IyyNTzuVXDZeGu0tp5lWkBf7PQ==
X-Received: by 2002:a05:6808:c3f4:b0:43f:1d72:592 with SMTP id
 5614622812f47-457b20b3d75mr22799748b6e.23.1767368619085; 
 Fri, 02 Jan 2026 07:43:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaabbd472sm25102643fac.16.2026.01.02.07.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 07:43:38 -0800 (PST)
Date: Fri, 2 Jan 2026 09:43:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome@forissier.org>
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH] Add missing =?utf-8?B?4oCcbmV0?= =?utf-8?B?4oCd?= prefix
 in help net
Message-ID: <20260102154336.GF6124@bill-the-cat>
References: <20251227181852.4404-1-linkmauve@linkmauve.fr>
 <e2529768-467d-4bf5-a27f-9e50b8defdb1@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VxAcAyTzg9LdYRxN"
Content-Disposition: inline
In-Reply-To: <e2529768-467d-4bf5-a27f-9e50b8defdb1@forissier.org>
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


--VxAcAyTzg9LdYRxN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2026 at 04:19:03PM +0100, Jerome Forissier wrote:

> On 12/27/25 19:18, Emmanuel Gil Peyrot wrote:
> > From: Link Mauve <linkmauve@linkmauve.fr>
> >=20
> > The usage of the net sub-system was missing the complete command for =
=E2=80=9Cnet
> > stats=E2=80=9D.
> >=20
> > Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
>=20
> Not sure this is a valid S-o-b as per the U-Boot guidelines (real name
> required?). Tom?

As that is presumably Emmanuel's pseudonym, I would prefer their real
name, yes. It's also a trivial enough change that I don't think we need
to be overly concerned.

--=20
Tom

--VxAcAyTzg9LdYRxN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVfnpAAKCRAr4qD1Cr/k
Ct2tAQC/f9rdD73fGyFszml5yFSd/HvztNNrFMDjonDServ4JQEA4S+pGa/0V66M
TEHM/BWrSrKMDn1wXTXbcNwWJtv3RQs=
=OLJZ
-----END PGP SIGNATURE-----

--VxAcAyTzg9LdYRxN--
