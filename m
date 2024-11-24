Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07D8D68BFF
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AABC8954C;
	Sun, 24 Nov 2024 20:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iqZJzAkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29D3A8956D; Sun, 24 Nov 2024 20:06:05 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881048954C
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4668c8e757dso3053641cf.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732475161; x=1733079961; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G2ZW+3LuNNZgLo2xXSWnlxdsZ9Npkm4So4PZP5c2dA4=;
 b=iqZJzAkcj1bVCWs9s5oQK5gqoMGXuaNHU0JxVy0si1qdYlcM9rMAw6sP6n93J0L59u
 8m3XlHFrTcyoDaxWYFssTQLCCkzWdk35WKB/JGfwxaHGDbnD7srvYSDjbwbENPK5m+zD
 5WQuxbR1lBz/hx8vLkGIr+Sx5INejZdHDjXyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475161; x=1733079961;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2ZW+3LuNNZgLo2xXSWnlxdsZ9Npkm4So4PZP5c2dA4=;
 b=Pk2QkawZ1/JNK1uc0SSpXKbY5C7M8hPRyO3wlPOOpbYpOxH6BpfWyrUFBhdOpjVi3h
 S0DomGanZv/rUURgPIgguDmMV24MOnvjQ3wk5CRZJLIIbeD4a9jgut6JAIgJlgnQZqy4
 OvJINhfq0l3K+8ugzUmhe3A1J8qyFqmSevNCKu9nrRz9SVKKRKhPZiDO9sjeaM804G0/
 emnNOFfYgqFhWqLcUsst49iR8LWxDd1FbRf4C2Pi9mSi96a91JdOJKbaE6Sbw4DSJdIs
 LiZqluX6XKYtnUoUsrvb5wUarEqnWP51Hsfiw6JhCPXYhqYMXicEegU1K7DEK4nd6v6m
 Fmvw==
X-Gm-Message-State: AOJu0YzNrbjrTdS7mHpqiIp+yK2DI6UlarGVOKk5Nje7GYZz1GHuTP09
 yL2J8mLETcBi8EbfWF1fTvHs6cyJm0lNuIfFbnkPK1btR4mqxyzxblPzdgewc6U/PWxnglVUIXm
 bvF8=
X-Gm-Gg: ASbGncvPxOgzCaiSJJGdt70nFV+KFiAvdpA8W2zQ97oM8rYKGKTcS1Z8DqdUDEEpfSJ
 1w/GS9mIGJSRpG3l2gLIBOS/fJw1MIr6cvLCz3dcuHY9xqOxlVYKYnGD5XK0jNWxP6+EzDIekgX
 OFTF84DoFm8uRE4PgHOI8SaA3vgybAlPiNwTBEg5JBkZHi69nfTl6CZ/RHBZf9XcqsGdCw1u1NZ
 ovZRTLbiwcsKGWhKGQz6ESfIUlOPHAheqjzCsengzDoreMP8Q==
X-Google-Smtp-Source: AGHT+IGQj9xo32VFv2rCSRguocxwakeIICgjWN1LvE4VSBE1YXA8ytf52+j/AMP+S6VuVjdr/57tiA==
X-Received: by 2002:a05:622a:a0e:b0:464:888f:ae6c with SMTP id
 d75a77b69052e-4653d63b13cmr202848641cf.52.1732475161292; 
 Sun, 24 Nov 2024 11:06:01 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c4902casm36850601cf.85.2024.11.24.11.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:06:00 -0800 (PST)
Date: Sun, 24 Nov 2024 13:05:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20241123
Message-ID: <20241124190557.GF3600562@bill-the-cat>
References: <20241123213651.670462-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wxqRhwoFTDkS2JUJ"
Content-Disposition: inline
In-Reply-To: <20241123213651.670462-1-festevam@gmail.com>
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


--wxqRhwoFTDkS2JUJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 06:36:51PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit 52c0e5f8a39ef022ee5ab2dfd67661d1d34941=
c7:
>=20
>   Merge branch '2024-11-22-assorted-fixes' (2024-11-22 15:04:54 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20241123
>=20
> for you to fetch changes up to c02cdd41877bab89ab17f922f1e19c1c4237e83a:
>=20
>   arm64: dts: imx8mn: Include 32kHz oscillator clock in SPL DTs (2024-11-=
23 15:46:34 -0300)
>=20
> u-boot-imx-master-20241123

Applied to u-boot/master, thanks!

--=20
Tom

--wxqRhwoFTDkS2JUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdDeRIACgkQFHw5/5Y0
tywtWQwAnCgkmDxiwd4MzpGeBRRryCr0DB8s+3IMne1z+C9QopHpyj3AxQsiXMZW
VZBWIdIjQss5aQU4tVtOGQLFAFI1KrgzhK5AmXdJb3pUYps2rjKnywFFa0zXLsYU
OxXQvB7Drr9LQZGNR/7VubRMB6e+3YtWzTVhDnktcRXxmwR9NscArT59zPx6XI/V
j4oZssRhQ7+IxR2H1njMLPykAobZEILF0AB0Yy3rHX9Gownw1nXcwBfAhBEEiECH
gYeG/TkBGBhhTIjtQBmboGX7UL7FWGt1H94mH2PRUiig14jm+SET/W8tMV6NFFjt
r3716zyBxKT3/1En6XLFOKzdyMv1xHp0+MlPGMua+swYbSrd6/sRYb4FYF0JxrHs
Ksd3HKb4ykjhft/26dAdzXguqpvN2PRG1ji0y4VjKoEA7deE4P/TUFMeMVMaYkxI
rOdydWupvvalZHdC++XyJslb1lnMe4zIIvqFlgOSLD//B3dKz4vrvCSDX4IsT4Wl
BOZYq+vq
=/iFv
-----END PGP SIGNATURE-----

--wxqRhwoFTDkS2JUJ--
