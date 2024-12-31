Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5E3E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 16:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 401228021A;
	Tue, 31 Dec 2024 17:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ofB9qmrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 915F08021D; Tue, 31 Dec 2024 17:05:34 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B885801CE
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 17:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6f19a6c04so866921485a.0
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 08:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735661131; x=1736265931; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6BPEEiRJDTErWWY8g950yGNsksUAz4gMeZyxlgR3pvA=;
 b=ofB9qmrWpWRDm1K/HXrXoVrMbhdoWhjg3e9X65OXFSYfdUkVxAMt3kphVc8qWIcRNT
 IBQ3BSaT8aCMQNH7TKSQ6SEcpt8KTKr3bn/FMtPwMD3idmZ5T7nKENTZuU6RARP+phUd
 zE3UPYFLsyXPSiD70JSkhMC0V4lztvDBWRa94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735661131; x=1736265931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6BPEEiRJDTErWWY8g950yGNsksUAz4gMeZyxlgR3pvA=;
 b=gbduYN/Zx+HonCYqIgP3oBndPZL451/LoiF/wcopu0HeMxuQMs3jc4najIUNuKJCfk
 JJ5wOhWVzrUzradhqTA/fSIBt0m6sQcujxZYV47KFqBbr76QZkthLLIP37MU3+nGpNI7
 XCY3knfDFcRpw8B+GvnfpUBLLgRQBzTPLx2s1xh7F7QMNCFwRsjb1Fxt6gtfidIvAnQq
 05JCX/9aWedfoMxfZo5XzIFeHZbEdologl4FMZNMMsvgb9XvSlKDypICKRY2qhlBm38U
 5YBqtmfkhjTcDCCtPC6hGMc9TQ9c/31KUeT1z5lO3O8XqIcjtW5XkjOf29MPhJ0BNELb
 5WHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT8wHkYhNNFCxf8XIEfkRq00VN1VFMELPd7vH8dymhKOizsGUaGMUDXipELoG/PEVQRf0gNDk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz16dS5u1KjSFuZaPw6Ye2xOoQSKo2267Bgdo9ygTssuZzsQHz+
 pbRsLcyzy92XAt2M6+htzUSvBccYFxT3p6Mkc9ImDo+fI3E/H+qxd1jDxsAuGis=
X-Gm-Gg: ASbGncu+Jjugy+Pa7oJLmA/CZzuxS0lzGV8P0JtgnFd6Aehpk8iTsL8rrm5gt3IO8NC
 aCQjiF1FaZ0G2P86GxBGX8++EJrJf95mMS1WPiU21JyaGPOc3njw7anKS9xokV89ouCi2TwLeex
 /9jWRtCKLrts4Rc9uSEmQ1vpomAeVfeS7MhUAbZbVxDZ/jzHN1KzJRcd09x/XIVKPH8GzDpuCDg
 lwfViEMvE8lOjFBFrhEFib/c3TFxdvwJXGPimg6nuifxlKNHnxdfCj7og==
X-Google-Smtp-Source: AGHT+IE7M7RXpZWf0GVEwo5qezaHRQwDrbHueHupszZzN1x0JKth2im6807e9MVIk/mIzshvRataBQ==
X-Received: by 2002:ad4:4eaf:0:b0:6d8:9e16:d08e with SMTP id
 6a1803df08f44-6dd23358001mr563683826d6.26.1735661131184; 
 Tue, 31 Dec 2024 08:05:31 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea757sm112962956d6.22.2024.12.31.08.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 08:05:30 -0800 (PST)
Date: Tue, 31 Dec 2024 10:05:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] Initial support for PXA1908 and samsung-coreprimevelte
Message-ID: <20241231160527.GJ3476@bill-the-cat>
References: <20241227-coreprimevelte-v1-0-ac8243eee4e6@skole.hr>
 <4950238.GXAFRqVoOG@radijator> <20241230152533.GC3476@bill-the-cat>
 <2974027.e9J7NaK4W3@radijator>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XH+jflJFRoCq1Kjd"
Content-Disposition: inline
In-Reply-To: <2974027.e9J7NaK4W3@radijator>
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


--XH+jflJFRoCq1Kjd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 12:16:28PM +0100, Duje Mihanovi=C4=87 wrote:
> On Monday 30 December 2024 16:25:33 Central European Standard Time Tom Ri=
ni=20
> wrote:
> > Yes, this is about moving to OF_UPSTREAM. Strictly and only with respect
> > to things that we have to deal with due to other bootloaders can we deal
> > with problems like that in the -u-boot.dtsi file. Otherwise we need to
> > match compatibles, etc, with upstream. Thanks!
>=20
> Fair enough. For v2 I can add "intel,xscale-uart" to NS16550's compatible=
=20
> array and the U-Boot dts if that's the right way to do it.

Sounds like the right track yes, thanks!

--=20
Tom

--XH+jflJFRoCq1Kjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd0FkQACgkQFHw5/5Y0
tywN7Qv+J2R2+RmWa9lq3hObCOMONoB9J808ohot7/21OGpeQENsqK5DC4medHQy
oBexvh+vDZVGEXYIjBCLxJzPfQjf77QNEP+ExjItyaU/ihSdvfChODoW266i/OUX
TC/SVIq8inaHcepiWCRbJJ9wtmCsaJZqCSoay9tNmE2CgEuriJBsbBBtDMMkxpMS
on0N+WbrFpIGXC2ZOyXdziEypiHtTrv1oqEL9RZqtI4k6ItvVl6BD4xlbErVDGxZ
kGQuj3HaEEr1PmD2msQDTsZUFeMIV1vKNOC9/A8ily/Mv70wKwja3uDW4YZ9BQl4
uuuv53QCCJhHdmhuVy6agv9Pa4i3I4EhU+IZbAf/wcYI7Jyj3g+OuiZZ6yykUEgW
4THkHpIrExBSUaoGSUHRM8ZvM+ez5V9dkgjUuc5HaBr314GiKXA8IXqY3PoCw9V6
8fDGNCzOmYTnWcpVccXHDYpxQz6o9Dg6wg5pWulwreZ9wnqXWKQkjDMQM5oOrxDP
GQIZrwrs
=0deF
-----END PGP SIGNATURE-----

--XH+jflJFRoCq1Kjd--
