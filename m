Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EBEE8784A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 17:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5542F83BC9;
	Tue,  3 Feb 2026 18:00:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OSfQjm27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCAF883B95; Tue,  3 Feb 2026 18:00:09 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A253383BC9
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 18:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7cfcb46ffc9so18273a34.0
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 09:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770138005; x=1770742805; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yqau5X2NptVQtZhdpYjfll9DUlbgVzA56WHMIGRoF1Q=;
 b=OSfQjm27gdnqaGFq0YWTds6wia4zAmFlK3jwz/ZlQoP3oNg4gRegDYql8sgbiJyFbF
 rze+OOGkvabWfPrNia/UeDbJvBxJTkjdSmbMTHWO4SXTwXIp2QfBtqdX7HWM6n1HOf5R
 kUTFf79gxNnWQpIftPuisE3cwbpaB5557DxV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770138005; x=1770742805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yqau5X2NptVQtZhdpYjfll9DUlbgVzA56WHMIGRoF1Q=;
 b=Eqyq/t70iO8pQ2g7xjoYIvN4byBrQA9gy8NcEvZiWPpKGV9CVR5msHZSeO6/Ha3+II
 Agc70vZ+14soia3N0DVHGt5GGn1ykPhH9REVCX9vEyaOisSnky0Z3qK6KKdqo238y/jQ
 2497zRWhW66S3T9lRfwnaF1/S04yY2IJhu5rBRMfszJ2Qf0F24pNSydOG0twsJCxjIRC
 7gt66aN7Cbg7BrOI+L29BdqkonpFnWxeR97vNXn7MuGnp+DQ9dotmRoN7Mw3cDXe57hW
 hk5Uf237mY1MeIfpkPwHvgWf0JuM/wbhRIOQAFUXb6I7eRYXLNZguoIPFHTAsMxneN2I
 FdOw==
X-Gm-Message-State: AOJu0YyzVjkI7TeFBj1bOXkhOFu2WEgF3GHxL9cL9MGJtqjfsXwEVCa2
 gb/7v7U79fjE1Eaq9IfSQClyQNiCYkctnT6KhZdcHeJvKS5U3MoNZNHDVAersTusyJvlfCvNYLc
 moZA4Ubo=
X-Gm-Gg: AZuq6aKkMhPDbYCX+60ROfXV+siR7Gr5vYnrJn8l0h7NlUCRDDbEl5pcVKDJ1XH8TJb
 h98EQThdXOOBCQLmVZvu7WOg5jZp+ZZNWGxba2Ztqbjd6B0gam1z3OYmVfqwZbDH1rxWpjMhhwX
 qj2mf+bguw0gA3hSKEF2VECG9I3DtGXUm0ADQhOJxFL/OQETdOYpKvxY4OYi+rDwJGjCkewqDSQ
 A7GRTO5VOA+kOZocnh4eQdvoGGw0AjAAGlkOCo4Ucm5rElMPVwgW9GRbY/O2/RmI9R6leGf7hPy
 QbippdaaYaMxEtC9AqliDA3i68XBQYODQ6zXVkFt9Ayq6FywLNnVzTdfXC7/gU8o/q1u5jmvUP4
 Mjqtz4S0Xz3CK2LEtx6KPF44kWwq6BkLLWJ9xdTOID5JkPFm6aGOp+aiO8y5qdjLsq1tRZN3KaY
 zLuyAaGtwd7yCiJ1A93l/y4zs5Bu7jTgoXvp1Vt9nykFDl3udUSrtbj5CYN3h/Y9hZrAf/sprai
 DDX/NcWk+Wez25BNxuhio3uy53nc4Qe8oAtYY0=
X-Received: by 2002:a05:6820:480f:b0:662:b663:5956 with SMTP id
 006d021491bc7-66a32ab3c90mr27586eaf.1.1770138005061; 
 Tue, 03 Feb 2026 09:00:05 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a354be1d8sm23861eaf.12.2026.02.03.09.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 09:00:04 -0800 (PST)
Date: Tue, 3 Feb 2026 11:00:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Dorde Stojicevic <dorde.stojicevic@rohde-schwarz.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: Backward compatibility to U-Boot v2020.04
Message-ID: <20260203170002.GO2603314@bill-the-cat>
References: <25380f75dd2443c0a882bcce78503511@rohde-schwarz.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WYoh/VoMSKneuhzX"
Content-Disposition: inline
In-Reply-To: <25380f75dd2443c0a882bcce78503511@rohde-schwarz.com>
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


--WYoh/VoMSKneuhzX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 03:41:05PM +0000, Dorde Stojicevic wrote:

> From ae3f90922f5c31bd6198deb149edb9476ecfe4ef Mon Sep 17 00:00:00 2001
> From: Dorde Stojicevic dorde.stojicevic@rohde-schwarz.com<mailto:dorde.st=
ojicevic@rohde-schwarz.com>
> Date: Tue, 3 Feb 2026 14:48:36 +0100
> Subject: [PATCH] arm: Backward compatibility to U-Boot v2020.04 Series-to=
: u-boot@lists.denx.de<mailto:u-boot@lists.denx.de> Series-version: 1
> Signed-off-by: Dorde Stojicevic dorde.stojicevic@rohde-schwarz.com<mailto=
:dorde.stojicevic@rohde-schwarz.com>
>=20
> Cover-letter:
> Backward compatibility with U-Boot v2020.04
> Needed in order to boot LynxSecure Hypervisor, otherwise
> U-Boot will fail at this position and reset the controller
> END
> Commit-notes:
> Backward compatibility with U-Boot v2020.04
> Needed in order to boot LynxSecure Hypervisor, otherwise
> U-Boot will fail at this position and reset the controller
> END
> ---
> boot/bootm.c | 27 ++++++++++++---------------
> 1 file changed, 12 insertions(+), 15 deletions(-)

This is an interesting find. And everything Quentin said applies. Also,
the patch as-sent doesn't apply cleanly due to spacing issues, possibly
=66rom copy/paste to your email client?

Now, taking this patch and re-formatting things a bit, if do a "git diff
--ignore-all-space":

diff --git a/boot/bootm.c b/boot/bootm.c
index 4bdca22ea8cf..9743051160ed 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -684,11 +684,7 @@ static int bootm_load_os(struct bootm_headers *images,=
 int boot_progress)
 		int ret;
=20
 		ret =3D booti_setup(load, &relocated_addr, &image_size, false);
-		if (ret) {
-			printf("Failed to prep arm64 kernel (err=3D%d)\n", ret);
-			return BOOTM_ERR_RESET;
-		}
-
+               if (ret =3D=3D 0) {
                        /* Handle BOOTM_STATE_LOADOS */
                        if (relocated_addr !=3D load) {
                                printf("Moving Image from 0x%lx to 0x%lx, e=
nd=3D0x%lx\n",

Is the interesting part. And you say this is on ARM, so we look at
booti_setup in arch/arm/lib/image.c. The failure cases of the function
is only "Bad Linux ARM64 Image magic!". So what are you trying to boot
here, and is it really acting like a Linux Kernel "Image" file, which
has a specific magic value? Or are we falling down to this case when we
should not be?

Since it sounds like you can reproduce this rather easily, it might be
good to use "git bisect" to narrow down which exact commit broke your
use case, and we can work from there.

--=20
Tom

--WYoh/VoMSKneuhzX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYIpjgAKCRAr4qD1Cr/k
Cu9mAP99sVSWO4eKTqtREno0oyOkyk/1WLawZFagZoT11/3PYgEA08QNu4oZ4RlQ
73JIY34EyLUS688RkcBeqSUym5dfXQE=
=chIV
-----END PGP SIGNATURE-----

--WYoh/VoMSKneuhzX--
