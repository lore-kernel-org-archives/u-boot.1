Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A7CCFA446
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 21:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0CBF8392C;
	Thu, 20 Nov 2025 22:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BQmFnn2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E856A84114; Thu, 20 Nov 2025 22:29:16 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E355832AD
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 22:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-450c6f5ff81so492971b6e.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 13:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763674153; x=1764278953; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RWeCCyD99x5obqp+W4y+Nx6TwfuABu3drRK1eKryKKo=;
 b=BQmFnn2+Lkh/f2R0LNQnITbRAmG1e+k3+X60lG9dFwYPQbg6PY5AQIPsKrKPmHQ3Na
 LMuAN9gJJrXTT1Gey4Xw5VbzpXfHbKgk1Zy5phjdiS0hJqWTwTprrgjDHs68X97a7BrG
 LTEAhZmyjxzZCYksMd/cYSXxoqRgpNclj7Mf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763674153; x=1764278953;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWeCCyD99x5obqp+W4y+Nx6TwfuABu3drRK1eKryKKo=;
 b=mkj5yvtGsIiNeqEenZ9g0qGGLSHKzujF5dsl/MHaIDdarRFF9gnrNznthITRSk+I6s
 skbwjvTHV09jeOEq4knBVaTgzqNITOa7A4+SAe4tX6SZRwbc/donMW3LvXBBiP3iY+4S
 Ty06CBh/DW356JjDPqDwwYaEub7og9WwtFnAw9RJBtK6Hr116ZHfqBXaBRYCiE4yfl0Q
 Vrv1Dig8JAnx7m06ipqgCR/4xvVHTpAyrXhvGoIJoI8O8hCXvAU0/9AVCEGA9F9k7kaT
 5VpHbWuXso2x04hMEwBMlZdQwmFq9r+OW6SzCXT2dzGnESu8gKhzvCXTpLxg7dxAFmRO
 SOPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdUKj/Ev8pDAvQCb6K6F4tFXmt0gBgdW5VoCVglF3YS03KYFEcplcGE6wj+/1gQB9kdfPFCeo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzu9tWEHClCvMa5sNoQyBvI0vNR2GDHaTwq5pVI7zBYet6Xo1Bs
 6blSiSr9oWSy7YG1qkKypxvRKp2remZGFRlexF1WUukB4XA/N/bCxLgeqMaaTI2H8Pc=
X-Gm-Gg: ASbGncuX3GedV5hoDnuHGA75VFPFKYbp76UAjHPR5gCVLfMPVxnzlNJrvLwOwayi/ft
 BAx8yKF5nW+RyysnrG+rp2gEJvyCi1EfSB0+VLrFAh2V50EH8ljDpjsYH3k5n3qCmZnVeidB7ch
 KptrY2JKZQrMZgvIgGxzLL6gB1sz5TXEA6UVHw+zshy0yyxDzZHU93NUvsKRuk+EvUOucXrWUoj
 yoqc9gVi9Uml6nA8gU/GovOfw70DPtsZP6KfeDBjZXtvbdixPNdoekmL3R/f6RNd7Z84a/eT5P0
 0lxwH+EX9l2ZzhSLuDTwmSQSlhh/u6FriJ9Pfnc63Gqv5R4ZqAsMmcfDGObVmJROHMEQqnj9EY8
 vFNtGsUlYS1Hx5KFgl/5rmERIgU7V588AgCbYSFsQBOU18Cv8JN72Nq3by0ccebpC4I1aeNayAz
 mA57FtGsKId3ik2t1pZKkvY49/k8C098LdbwOJaT0ylVeKVJZ7jfT8HyM2pw19
X-Google-Smtp-Source: AGHT+IGuuOrK1Af05sSvRFU+sqIAFB8isxWVXnQPeaahjsAW0Z0DdQ4D9EPKwS4aSKzanuN1ZsRUzg==
X-Received: by 2002:a05:6808:6781:b0:44f:6df8:6a2f with SMTP id
 5614622812f47-45112b59db2mr47461b6e.23.1763674153248; 
 Thu, 20 Nov 2025 13:29:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffe2d425sm1069291b6e.4.2025.11.20.13.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 13:29:12 -0800 (PST)
Date: Thu, 20 Nov 2025 15:29:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de,
 Kory Maincent <kory.maincent@bootlin.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Liya Huang <1425075683@qq.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Sukrut Bellary <sbellary@baylibre.com>
Subject: Re: [PATCH 08/15] dm: core: Support multiple drivers with same
 compatibles
Message-ID: <20251120212909.GQ2125796@bill-the-cat>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-8-91ce13c661e2@baylibre.com>
 <20251118140804.GR2125796@bill-the-cat>
 <DEDGK9KKB61P.1QY81TPR5JLNY@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AKgPdIRE/7XPCIO8"
Content-Disposition: inline
In-Reply-To: <DEDGK9KKB61P.1QY81TPR5JLNY@baylibre.com>
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


--AKgPdIRE/7XPCIO8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 11:42:53AM +0100, Markus Schneider-Pargmann wrote:
> Hi Tom,
>=20
> On Tue Nov 18, 2025 at 3:08 PM CET, Tom Rini wrote:
> > On Tue, Nov 18, 2025 at 11:40:28AM +0100, Markus Schneider-Pargmann (TI=
=2Ecom) wrote:
> >
> >> Currently once a driver matched the compatible string of a device, oth=
er
> >> drivers are ignored. If the first matching driver returns -ENODEV, no
> >> other possibly matching drivers are iterated with that compatible of t=
he
> >> device. Instead the next compatible in the list of compatibles is
> >> selected, assuming only one driver matches one compatible at a time.
> >>=20
> >> To be able to use the bind function to return -ENODEV and continue
> >> matching other drivers with the same compatible, move the for loop a b=
it
> >> to continue the for loop after -ENODEV was returned.
> >>=20
> >> This is required for ti-musb-host and ti-musb-peripheral which both
> >> match on the same device but differ based on the dr_mode DT property.
> >> Depending on this property, the driver is either UCLASS_USB or
> >> UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind
> >> function and returning -ENODEV the other driver can probe instead.
> >>=20
> >> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> >> ---
> >>  drivers/core/lists.c | 62 +++++++++++++++++++++++++++----------------=
---------
> >>  1 file changed, 32 insertions(+), 30 deletions(-)
> >
> > This seems like a big generic change (with potential performance
> > impact?) for a rather specific case. I assume the linux kernel simply
> > doesn't have this issue by handling OTG differently. So is there some
> > other way we can handle this here?
>=20
> I didn't find a nice way to do this differently. I did have a different
> idea to do this by overriding the compatible of the parent node of the
> usb devices. But I didn't like that idea so I proposed this solution.
> But I would be happy to hear about other ideas.
>=20
> For the performance part: I don't think this reduces performance in most
> cases. This will only add overhead through additional iterations if a
> driver with a matching compatible has a bind function that returns
> -ENODEV. In all other cases this should not add any iterations to the
> loops. Grepping through the code a bit, I don't think returning -ENODEV
> in bind() is widely used at the moment.

OK, thanks. I guess barring someone else having a better idea, we can
try this direction.

--=20
Tom

--AKgPdIRE/7XPCIO8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR+IIgAKCRAr4qD1Cr/k
CiQTAP0eD0kExvcmQCfImDyRMw8HLfrmGTv1fvRxeFVVFvpDAgD9FWUe2je+5Ftl
0M2ngHkDjV7BS5eRn2KUZ4U0+ygoVwk=
=JM+B
-----END PGP SIGNATURE-----

--AKgPdIRE/7XPCIO8--
