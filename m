Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E78C36010
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 16:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0D98171B;
	Mon, 31 Mar 2025 18:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bQTykxsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3AAB81ED8; Mon, 31 Mar 2025 18:09:23 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7364081026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 18:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3f6a92f2328so2458373b6e.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743437360; x=1744042160; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l/lq9LdBNMeKpM4qYKWRwwRDK/IAg3zpsrgHzjn4F7o=;
 b=bQTykxsca2W3tEIbWBmrj3eve4mEYWngouoqE2VOi0YgziajU5SrjvXfeCuUYsRsUu
 g8xbJPWU47tJh7wVG84p4Vl0zT0RArEnpkoxUshHhxbiapTEzxc7bkDK0V2rZVhD6QnM
 yoba7R712QVGOXIRfvq+j7akieBj0SqO+xAdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743437360; x=1744042160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/lq9LdBNMeKpM4qYKWRwwRDK/IAg3zpsrgHzjn4F7o=;
 b=l+9tcr2YnJFmQPj+Uo3LhRGOiMTQKTFvVqZmwybFc2TVnUTHLgmSFvtZoTh4LnoW2W
 IrjIggsKJfoyOGExTkTJ1e8eklLU4CU291MrNDny92Ggxt9zqdS9cxnn0nzNWuFIu02H
 OLvUG2cldGZ68rhBNbb9GFxCLGI8VtqszXpckXb7rJwO3OV/4TZxRSjx9R/oyQpWHU81
 W5rk6gN2kBgwdQwlrq45cVSxz1icE+Iqy6eB7bWQbw8+rurG8vNuYuiaJMWXL++uyNWH
 TgUrKAvcSJDtDVUvtLGboBmwYa776jLXa6oGWfVlcFBuoRfDMY6CIo4u6M0Ew/xH8y+B
 NxIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF90kB8+4Ih/WwdXN2ht08t1ug0U6krZ4UrhBgCFIZTrA0QW29UVCwt+ka3C7b+smkru+se40=@lists.denx.de
X-Gm-Message-State: AOJu0YyHI8MUmFhbZTGnQHWtpB2FEcewV87atvSr1BKOnTbyMo1XFSXr
 J3R6DJBVxlVC9AE0oSNYc+a5c8c2OIy08l0O7+b2LrhF3x07mMnq/KPEHU8SNT0=
X-Gm-Gg: ASbGncv6mKB8L/XxG1dhatlNhAJASkhVKuC6/I2iVzVfeFzYrotrq+pBPDNQrfVTyBU
 rhP5fBxKHjRJHaJ/u76lOX8uhVcSfMAdFIUGCmIK+XNqbq5GBJof5vrfHbGQqgb9chmwpkVcmW2
 QXN1CokDyRPAzPX+ML5KW5Uh4vYOMywQW8XP3TpvnDlJLOFdo9cfG1QFWpHYlhBWdYjWNTysT+z
 sZ7w6qp8IjobXibM1j4SmKOX8rzFddaqMoGYIPbripZFuIN902ZfxHSqJlHcb6jpk/TwUs3NLGL
 SLujz7uPXfGBBMnCVYTntLUDiQXUbsMQ6/SKysUcycmr22UfvsTw0xQehbszxkqfex2rf0HfmRv
 kNou8aw==
X-Google-Smtp-Source: AGHT+IG3D6Ihv3QC2hUIjwl1j/RD3Ub5LuVccDCRe9+Sf2ZVOKvEsGTcqODs3e6DQe6Y+/x+XPtK0g==
X-Received: by 2002:a05:6808:14d3:b0:3f6:ab0d:8db1 with SMTP id
 5614622812f47-3ff05c69846mr7308612b6e.3.1743437360213; 
 Mon, 31 Mar 2025 09:09:20 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05279b96sm1594637b6e.40.2025.03.31.09.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 09:09:19 -0700 (PDT)
Date: Mon, 31 Mar 2025 10:09:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 17/18] cmd: spl: annotate switch/case fallthrough
Message-ID: <20250331160917.GD93000@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-18-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zIPHI92K9w01fUTN"
Content-Disposition: inline
In-Reply-To: <20250327153313.2105227-18-andre.przywara@arm.com>
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


--zIPHI92K9w01fUTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 03:33:12PM +0000, Andre Przywara wrote:

> The argument parsing in the SPL configuration command uses an implicit
> switch/case fallthrough when dealing with a different number of
> arguments.
>=20
> Add our "fallthrough;" statement-like macro before the respective labels
> in the bootm code, to avoid a warning when GCC's -Wimplicit-fallthrough
> warning option is enabled.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--zIPHI92K9w01fUTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfqvi0ACgkQFHw5/5Y0
tyyd/AwAtBWWv5kq62EC6v4JnY5OGArAoR4XPJFQ7DBIzXbw38Z3xFBOf7DisRBf
aC9SsVd+1btB1E5tWgAFAeqHTxSBryD1zHsSIXSKvGMFdSFQXMYQwMUB7XLTFoiz
Yumy7vEdUJ+Nnr6tZsWDUp0a3NLpI3xSUi2kGmaCgbK6KCxZvaKhReCitXgB/N9K
CoG8Rdif+08qp5p+D8Z+0WTG3aoIeT6xMMh4KiE9MmZtcS1PsaiAIO1zJpWtT/BS
3NpLhxXhwa+LLw7f317mYDy+dTRY1zuDgySrxpS9373kBdJeJ6lCO4d2EbDm8Eyf
X7vSbuukP5xy5DVqoVn7E90DEFuUDbhI9WqZwjHOOT6Uz/ffMOWQ4kcSUkoAepGs
8pDj1It5MR0cezOH8p1/CGPn3iNBdBjDrOj1/px9laeTPxUBJnsjyaMIc1SMIDqm
NIr7aO7x8VMcITWoUbECWdTg1qz/wjTGeOCdRQ6u3ZOxuqHzzfV+SmnYFeXE+NYr
ZbRwT5Lb
=nXor
-----END PGP SIGNATURE-----

--zIPHI92K9w01fUTN--
