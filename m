Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D7CC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 18:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C00C0809D0;
	Wed, 12 Feb 2025 19:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CjWKF+MU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE4EB80C69; Wed, 12 Feb 2025 19:38:58 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FF61807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 19:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7be3f230436so664191485a.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739385535; x=1739990335; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DwnuVEcd8jP1vOk9K8SBsPfgV2Noyq2kTFAgzlk4+5Q=;
 b=CjWKF+MU7Gci9Bv3ozmBEXFK1pZLLvu+0nK6onmfTgkNs0Cegxr0ERxy8L74hY1UkG
 vX6OSYlnnI7cx6nYTEwSElqJ5MpL0TECdsNjGXOmADoBM/uS2ywWtRLzDSwFo9RBEpMu
 rV/J3pkeU2JKbnNg4ZDo1cXLCtRLnpkZlPsGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739385535; x=1739990335;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwnuVEcd8jP1vOk9K8SBsPfgV2Noyq2kTFAgzlk4+5Q=;
 b=lG0rlzl2sc8kXG5oOXifNI+67lG0yvpIiPXZOJLqC98JKzceL9SUVeTnj3ww6nLA4Y
 PnKcEOf6TvdvZRY3v5yt5ISypWxvWvPJtwAhWW0nPnnNT2DEyP29uDaZSBFQ1eo7vNAJ
 y37IrWpJEKgANwKjF/QcD77NI3iAgDDUVfTIY/FsVo80DYUupczZO7RdF/cUN6ig2Zy0
 xqOY8LgHNaD8BrXP87kmY0dHniApksvQJTL1tho/fyvPLpVrsgd2zI0SZQJpHovmp3I1
 oS+V3oL2BfaVfHH3TXmWca7TsT7VlAq8C0EWMj2lBbKAx/+F59CwQzVFQSyRtBDR9uMc
 KBDw==
X-Gm-Message-State: AOJu0Yyfbze0OtAiAakLnsj3cmWDI30X8lyy6vbFYMwKN8ckXQ8uIh2q
 PrC6vl1I9HmCQdqhoyaxK+ZK3A8DRl+f+x6uGdOZOo15QJIkABrB2x9aAdZzWxc=
X-Gm-Gg: ASbGncvkVIuUrQbgtKhQHSx34E2PXJmQB/4FydpIgL/60wMeI4ULyiEtqi8m1NuiSIu
 1F3us4A2bs3EJBUl2mer3FZfSvmsFxY+bDHMqw6rqZ2B5yaNsd8z9XEktFPnaIeV5C9WfRO/XYn
 c/fk/yQ6unM3FZJLG8r6NKWzCHA55k2C3bDIXiwwgujvG6vZ2BORpbvU0ktZeikM7mjZoU+TGo7
 KlnISEih7ZHjFUsnW+e8NJZcllHS6GT6kVa3teZN3zbyBr6Hce7Qo9L83GAqk8QcHzKJqCiZmCQ
 xuuJjOpXVjPnbLI=
X-Google-Smtp-Source: AGHT+IGVVkXdY30xD+xuWlzhAkeyk5jyjCNmQrekr786Q18E3EvxL39ctdfuT28TKY3XQyqAfWDh+g==
X-Received: by 2002:a05:620a:8014:b0:7be:6f05:1b2a with SMTP id
 af79cd13be357-7c06fce2ee7mr786535785a.56.1739385535095; 
 Wed, 12 Feb 2025 10:38:55 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c05cb5725bsm505073985a.47.2025.02.12.10.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 10:38:54 -0800 (PST)
Date: Wed, 12 Feb 2025 12:38:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-net-20250212
Message-ID: <20250212183851.GR1233568@bill-the-cat>
References: <7caf7a0a-c2ed-420c-afc7-620ab11461b5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WwuOCRbNx3nXdJVL"
Content-Disposition: inline
In-Reply-To: <7caf7a0a-c2ed-420c-afc7-620ab11461b5@linaro.org>
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


--WwuOCRbNx3nXdJVL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 02:54:37PM +0100, Jerome Forissier wrote:

> Hi Tom,
>=20
> The following changes since commit 3da1864b1f2fc3cf2b4eaa1849bcafa669ff67=
4c:
>=20
>   configs: Resync with savedefconfig (2025-02-11 09:57:33 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ u-boot-net-202=
50212

Did that tag get pushed? I had to look around and found the commit
mentioned but not the tag/branch.

> for you to fetch changes up to 893e32848f00e71eacdda2f7bfc32aa303f7a01f:
>=20
>   net: Kconfig: depend on DM_RNG for WGET_HTTPS (2025-02-12 10:25:14 +010=
0)
>=20
> CI OK: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/24=
577

One more small thing, I think when applying patches you had it add your
signed-off-by too, which isn't how things work here (but is how the
kernel works), which lead to checkpatch.pl noting duplicate
signatures, which I fixed. With that said, applied to u-boot/master,
thanks!

--=20
Tom

--WwuOCRbNx3nXdJVL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmes6rsACgkQFHw5/5Y0
tyzlNwwAoSDSYGNcFLt8p0veWzQ3cAz8sMGS6TadzRHa6nulbcNR4FINiVgAi4+k
zdxxzZXp3RNeFePX2B2faoInNiRebREQHGUnmyJKnWFaY4zMLQhEWabhkrHGDJHK
RPZbC76Kt+kHDbXEgg79yCXphbDaVkKVsGS3+907IhHYkmYLttzpEBMX/ntlMgA1
zaItevpOQnPz/hiAMrnNRoA5qg6nwV1PswEAVhq3h2xHlYy4Nxs+aG63fujBXDOB
U2h2+3rWxB80q7YN7tnMU+XtH4rfhQqOg6toUlF+pRCeimrZLZlVkAM8HanpV2Ff
Xib1ktF9BcAVSjaU7Z/N1+qzM2+g6GbRJq7Zerx6lxBe8O5MOtgpnrpn2j4SkRgo
y77ebVA9h2KPX3roXs7WZfmhU3SqjeRNC9gmVpRVeE5pCqf/GZTWorgJ3yE3ChO5
TzT6188HChlpq/1Z51mU1e0rd8aJEDn9xRsgB2r0zYt2dkWl9MS29RK/x5UiK+6O
sg8G20JO
=XeOI
-----END PGP SIGNATURE-----

--WwuOCRbNx3nXdJVL--
