Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A1DCCFA02
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B15B83A61;
	Fri, 31 Oct 2025 18:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b6euCKo3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D46C83A6A; Fri, 31 Oct 2025 18:46:19 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30F2883A5E
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c28c21aba1so1725613a34.0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761932776; x=1762537576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XhSblQLwA0Ha2zEcW/cH+6716D1MevV3WrlfaAOPZqs=;
 b=b6euCKo37oKv3qFWxPIknwPI8RSO8qHoYk+Ht/DRhcoL8IFIKtdCjGIMohYdYFZomF
 z+fQHMcavoIvrmT/hgkRey0tNfPwh4k8iWVfM52hGzOTVwbTW30q3LTDsZVVwt6f1htw
 FFTQ8m6AzWQCBRqtumdVx4CIAGAMqd8cDeYtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761932776; x=1762537576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XhSblQLwA0Ha2zEcW/cH+6716D1MevV3WrlfaAOPZqs=;
 b=rVyykTHjZWAjLsunTFIWrBo/l7KctMGOUgurNrE4w9N2rXxkD3MHclnIlyfS9GP5Sq
 d2CY+zYZsz4D/0X4DHwI70rsxQ7xcG3vCKcUiBzbOjPI3LFs7aw/vxTFwHSOuxKFrxf/
 BxEHFRrgKoqy6xI8H0uoTVJ32OFuwzZAfMD9798g3o+lHDFRO6kaPfdQ5PUiez8lllqr
 Thyn4U5UmqJLq3K0xzEK4lZGfeoo+ve8yz72Mv9Z+E32UE9oY5rS94QA7KL7EnRzUK37
 pNgdnKBhTIW4fhO4wxk93wT1w0L3g9WrSVt926rmPgXYSn1S03nz61hW5uLtNpitmI2q
 m2Xw==
X-Gm-Message-State: AOJu0YxRskbqDeK7cgbYUw3fXB8lfQ65wqrQ3G1ku8acIcT9tNAlw1mY
 iQr9uc+ALJbmsF+uU8StcVqGGIqFIk6VPG2sS69OU7qG7krh+RXJGyO7jhn/jxIH810=
X-Gm-Gg: ASbGncuPPgYIBMOu2Ubhk+PmbEAi+HyiG/ewJ5JHY/EGPTb27CIj0YN9Z5iyho98NGO
 3BKh+6E9V+UWPQH3KvaUfzu9DFBtEKvlEbJIVciRXf1B2LbaBARrVtdmZEKBBzi666xPk72Z9HZ
 LJdVFPjiOaBzjkzlu5n7ydv1GfuwRipkyGXgWNcDo4KWHY6XLlru43X9fG/VBrUJoGdPf4vE26r
 H0g2rS5R5DxBDGgXS2r9HuJ7LMmAQ611DfFDpRqj2pMU39yLB4WNP5sZXSOy/31l9G74RrQXlIg
 Ao6TdhY1UcHDf3e7nHwcozZ/ny5RsnV8wNJZxorKEq6Ljxouz0DhgwGCIS4xlnHyAGpN97YDuJm
 bitVtauJalFxZ289pDk+7PLtZVspFswj1jYRptIVkFwlykibOh6RtDSaUi9274/3CgeIU/u/lfS
 2PYQzeAC9Q+mbPVM/sohbsQIhrjj0VAy1QXKG7sPxr6Zw/MNnm6g==
X-Google-Smtp-Source: AGHT+IEa9qykfqFqg5c8aEMvjbaA7+xvjrFDcHxG0JnUSBsE4AXCk1yS5bjEDzL85eI42nuzmvk/Xw==
X-Received: by 2002:a05:6830:6aaa:b0:745:9ba6:d32c with SMTP id
 46e09a7af769-7c6966e11b5mr2122472a34.2.1761932775874; 
 Fri, 31 Oct 2025 10:46:15 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c699c20ebcsm700414a34.11.2025.10.31.10.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 10:46:15 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:46:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] Cyclone V Board handsoff script
Message-ID: <20251031174613.GD6688@bill-the-cat>
References: <20251030003359.1023-1-briansune@gmail.com>
 <20251030180940.GY6688@bill-the-cat>
 <CAN7C2SC+uJ2OX9WmU7AmUjTZ7O4rWwQY0ueYYvWcUH1GF=fgZw@mail.gmail.com>
 <CAN7C2SDcEC+A5-rmCKMYD=vEYDFdOAfMp1G=T5SuQcXYOHDuJg@mail.gmail.com>
 <20251031155427.GC6688@bill-the-cat>
 <CAN7C2SCXWoi6XRKppKFUzPiUykYeQ0Mbm=S3dhALajP98S8rAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9LzXQm0D0ExYx8TO"
Content-Disposition: inline
In-Reply-To: <CAN7C2SCXWoi6XRKppKFUzPiUykYeQ0Mbm=S3dhALajP98S8rAA@mail.gmail.com>
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


--9LzXQm0D0ExYx8TO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2025 at 01:30:34AM +0800, Sune Brian wrote:
> > That's interesting. But that also does mean that someone needs to work
> > better with upstream about integration here as no, that's not where that
> > kind of tooling should live. At bare minimum it should be in
> > tools/something/ and have it's own requirements.txt file too for
> > whatever python modules it requires.
>=20
> Do you mean I should move it to tool folder?

Yes, as a starting point this should live under tools/something/ and if
there's some way to add Makefile rules to automate xml -> c that would
probably help other users. But that's just a nice to have thing. Thanks!

--=20
Tom

--9LzXQm0D0ExYx8TO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQT14QAKCRAr4qD1Cr/k
ClXWAQDfAR8QiOKXbRakejX4Qho7ZKClFC/lH9UE1ra0LxYXAAD+NmnXtC2tNXeR
d8nanOAU+5kT1J+cuG9esZYLGOVlZwU=
=jsPY
-----END PGP SIGNATURE-----

--9LzXQm0D0ExYx8TO--
