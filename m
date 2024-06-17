Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7390DC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0110988352;
	Mon, 17 Jun 2024 16:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OECoYOP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1DD5882ED; Mon, 17 Jun 2024 16:40:01 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D661882ED
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6f9a4f9923aso2502879a34.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718635198; x=1719239998; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Do7lISWT9vN0SoHklcmW6DuQhcH2pFtXvvfpeZrN2yc=;
 b=OECoYOP8sV3xF7wT8YTeYlR7Zww2PwJp02bnfGJsxLBPJ+JcCfu3ehdhwkty0EnFZr
 7NS/3tRE30FbRa/BlzZCaz9778u4Kp8/aAlGbIjZLgDZ66M2FECtAwg0BMcq+YY9S7dM
 rhb/ObHjAVCV59Wu6DNYB1I57suErJkXOuY+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718635198; x=1719239998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Do7lISWT9vN0SoHklcmW6DuQhcH2pFtXvvfpeZrN2yc=;
 b=R+fBMpbdzG5a0O4eQ/KOpjh62Bm7gAWz6Z94fcPw9uF064eanqQk4T0pz9osbBGOfa
 gVju+6P5t62ckD5cAt1+6xGNjf8a4CVmj5o+EAwOZoHoPn9q79f/r8fv6+heOZiHmM9J
 ulysU9rA5qi/A1lpwRKHhVPID6rTJdVtM3N3MLZfQEl/T5sfdkojFXA2chFaaOb3g54H
 fFOs9UD0ZGkqAm0ayA6F4koaN1z6802N9XcxuyzMDjPlAhQtUrsQsUsop2fWreI/8fQB
 f3AkDupMK4bGrQWiUPYZbsQ7zC9RCMA4vQmKuLNN5ds18MrqUeUSTlCiHVNzywXAMd7w
 5K4A==
X-Gm-Message-State: AOJu0YzkKin4AxuaF4ckqprrs/Ip5MbRvpjqgKRUKOQD2fONUBhhZB8R
 vS5rW97OqphgSk4SKd0n7m2ZWXBRPOoZlZFdOT9IB+VhO/nLLKVbzI/LLe8qC2g51rCkNeMzpeH
 z9iw=
X-Google-Smtp-Source: AGHT+IEb520q+P5tIeM2olWjJFsCHSCpMv3HTpHjrVSGST41AX4dtzjtDsSfIU7vGYImBQnEuINlig==
X-Received: by 2002:a9d:7a81:0:b0:6f9:e125:947 with SMTP id
 46e09a7af769-6fb9364affemr10553533a34.3.1718635197896; 
 Mon, 17 Jun 2024 07:39:57 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b1afdc3sm1535901a34.19.2024.06.17.07.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 07:39:57 -0700 (PDT)
Date: Mon, 17 Jun 2024 08:39:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20240614
Message-ID: <20240617143955.GU68077@bill-the-cat>
References: <20240615121149.2203028-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U9tuVQFUPvqUwaB5"
Content-Disposition: inline
In-Reply-To: <20240615121149.2203028-1-kever.yang@rock-chips.com>
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


--U9tuVQFUPvqUwaB5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 08:11:49PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the fixex for rockchip platform:
> - pmic fix for rk8xx;
> - pinctrl fix for rk3188/rv1126/rk3588;
> - mkimage fix for rockcihp "-l" option;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/21111
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit ca6a992e09441d6cca73439c63c3735f86b36e=
a4:
>=20
>   cmd: sound: fix help text (2024-06-13 09:31:56 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20240614
>=20
> for you to fetch changes up to 3f9a19befe9277db2a337552912c6ddbcc0c8b10:
>=20
>   rockchip: mkimage: fix mkimage -l for header v1 (2024-06-14 17:07:59 +0=
800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--U9tuVQFUPvqUwaB5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwSrsACgkQFHw5/5Y0
tywvvAv9EG1hhBDFjYxGhU4g6yCyg7Ot22euitNdmJ6oxGKxvHH0MzPwTeV9z5W1
XyM75kfrWYYQ0LUybaCP0vD8tQYZgdJC4Va9n3k4+Lw38kGT5h0vUrI1YVTZSdAQ
SphF8Sbob+opGO0YaG1pDOkORcm494jV5lTuPreEsksj9eVJbBfEX9YzqhUEyLnl
Zv+nes6uwLPHX8Ie0YXiGMCTUgQZVh8crAc8Q0qqsyVLZjiThv5A9tkHRD36gZNa
HdLzsJ/JhbQrz6oaowlcnHkl00cE1zFjvhFBNGGHtXzXEd+bBBn3sC5v4GP4+Xds
w9veoCmx6WVpsDWZduI5RXtyUxTqLbM3xOdnkDG/rOR3sjwXiadFegd5I8tvWWbO
lwe67s2qczkqSHz3paVxluvwagUNV9DQRSaAeKyomFXYljOgVw/KaNWj1FcSFTFh
eaAe5MeIcZp77qGhORa5hEQfFymlQvbJflZKhOSbtqxkN8OAdsWZEz5koCl/J88Q
5zrHnUJJ
=lAKd
-----END PGP SIGNATURE-----

--U9tuVQFUPvqUwaB5--
