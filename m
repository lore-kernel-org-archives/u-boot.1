Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F919C0219E
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 14:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3ED807B1;
	Mon, 10 Feb 2025 15:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ktamjmsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51EA1807D6; Mon, 10 Feb 2025 15:32:42 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C794803F0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6ef7c9e9592so34238287b3.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 06:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739197959; x=1739802759; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cy0gwkyM1nihAGiKfWOUKilICrvqJ3HWReGbBCMYfPs=;
 b=ktamjmsjG/jhZLoBJNVgs2a+NKOTgydC3zT11JTNTpaima/r0GVGIup6DGubebJ1r+
 eNEVAgY/DGL8Gq3aWLU9P/MJa0wlrFTyWx/vyIXk6gSuCNGWJ4bokHqecci4/P9rQQxx
 1gGaZAHS7B3KL33Q6qqLbyw2fHDwat3T+Qkq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739197959; x=1739802759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cy0gwkyM1nihAGiKfWOUKilICrvqJ3HWReGbBCMYfPs=;
 b=qVTsJjkpWUDw3yM6NHiVz4a0QbI0if2ODzty1E0f+ncNciPb0EYVzyadzrxAS5IiyM
 opy/Y1pwd49C4CujnSqh/lfePAPX872gPifO2roO8Byg7X7nbDF7/dGYJnGgrS0hhCUi
 URMH1AHRZp2wKji4i8L4D5bEWlHZh3wU5v0ApaXIvt2tDGGEhCgQOlb0zpZtshePH/S6
 /Zbp87yuzhK8HTqXGE/67kky5rWgAqyTER1cj3sKsOiyPqeU2+9aVz+rtYtt3SW5THng
 8gmgqSYDPnvbG/PdV1436v12wgCIp7bJjW1n7jd8gcnf4pIQimoYBMKGF8JqiTkNgORm
 Kgxg==
X-Gm-Message-State: AOJu0Yx6KOOjYA8FL3A7zYOEhpEQ+aCh9+m0owOkIQQLLZx+hnuNdYjT
 k6KWPbg/TrHLrxKcNP/rW7Gss7d1lJCzPiOXpQ491e+XDrogNJ9rU7sXNkW7Dks=
X-Gm-Gg: ASbGncsiTFrtQay5FvtG6dtGdeFLqZ/KaGmclKTaHjLyEOFkC9xFbbH7rCehHfYrzWX
 k6LLR4/CIJRFjsG+AabKVNgW8KuPqN2HU8Rwo+KA8z3N8YbIUo/AJWKcfX+xMT+ESibiW3nWfjo
 sohXu/cfWVQyNjSTzmEe+2KcsM/LQ/iL+4oLtO8hYebIrvReEkYh7i3nU4u1FsAAYgTXp6D/VHS
 jeo7vKNwHsG/dxqpSrPc4k6xD6uK1I+dmCegUYRF1gv0JTMR+EB+OVL76dq1BjktLm5fOse/Fuk
 KLlPd0HDr/yJ/G8=
X-Google-Smtp-Source: AGHT+IERs0UvmVsS2ee105NxRxrAxAzglD09SSaxAk3f3IThkpcbXKm7qvloe+4i2bkb5S3hXGwkiw==
X-Received: by 2002:a05:690c:3681:b0:6ef:6536:bb6f with SMTP id
 00721157ae682-6f9b285c275mr121555927b3.22.1739197958906; 
 Mon, 10 Feb 2025 06:32:38 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb03536ff2sm1995167b3.52.2025.02.10.06.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:32:38 -0800 (PST)
Date: Mon, 10 Feb 2025 08:32:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH v3 23/29] efi: arm: Adjust how the monitor length is
 calculated
Message-ID: <20250210143235.GX1233568@bill-the-cat>
References: <20250209020136.4108987-1-sjg@chromium.org>
 <20250209020136.4108987-24-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SpsnpKpEfKxMk+fG"
Content-Disposition: inline
In-Reply-To: <20250209020136.4108987-24-sjg@chromium.org>
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


--SpsnpKpEfKxMk+fG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 07:01:22PM -0700, Simon Glass wrote:

> Adjust the conditions to support the EFI app when running on ARM.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--SpsnpKpEfKxMk+fG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqDfgACgkQFHw5/5Y0
tyw5Mwv/S5U9B8ULkXex9BGip4F+C9JfAJkFWOAE1ydCXlbWhpQbtJqp7CONlNJl
sryo2xBbG+hDDCx5ZZHOqrf1DzF17mitC2I9BWStGfhdUy4Wg4tdTrpDrLymnWPb
InHRHEof28S0T1UEd6HofUreN5OYEnZMY55YLK4Ru8ibgxz8lBx3Rm7PyQQLVpwC
qEwj5uyzndYvx11kTEWlN5e9dKbTwdOoU77O32UWDmUdh5O1WpKRGu7CY/PFHsjY
UtDBdkbJyvKBA+S66GQPw71CwmiNoPGf8cmP+UBN3PaQWuP7s8YZoKWx5wYgkZ9+
So2Mf7o5kGV5JWrIdDINrLtW+GNj6wGGMRgzRUaGtAXQenqx4WY4lpbcwDN6+gLg
sY+fNsXCqaihVdGDQqz5j1OADJWH0veAikmAGQY6ky99MQ9oRfM7keGs3eySkj0b
d+mSEbF5emXieDjF0HZG/H8LuocwM7/Zke+rD7iBCRqEB8MxOUIyT+OarEkLz0fF
VHlqo0Gi
=GDLk
-----END PGP SIGNATURE-----

--SpsnpKpEfKxMk+fG--
