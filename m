Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEC0C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67BAA882DB;
	Tue, 18 Jun 2024 16:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iFB6lZGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 412398832D; Tue, 18 Jun 2024 16:29:38 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08CA1881DB
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d35f1dfda2so1622943b6e.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718720975; x=1719325775; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2wqmeJ1eB+0918lErt0CUHYe3ENWYz8BZN0eWz6LxuE=;
 b=iFB6lZGdLTED0Fu6vGH+X9R1wW0GNDqi5fvWQWqUgabge579t/98BVs1UT1Lq3hoBF
 a7AH6+XJ0GDhWigqJaOmsfn/Zmy6IJQ4hvGcgIQpqTHHjW1y7xff3+WC3U9SbjKru6j4
 UTLUX6hllFX7SLBUDHrD2OeDhkWSMWBA2Phlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718720975; x=1719325775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2wqmeJ1eB+0918lErt0CUHYe3ENWYz8BZN0eWz6LxuE=;
 b=UjjyCu21Kh1Zd4ALJ9o51Nan4jNVCZ8gf9pozHtUi18WZ0V+g3cT1aU7WK50QqTF2k
 UWntmoagohP07DzPPBVcGVSWqKS2Fs3wklOr0xDRC/o9WKimvtSFEa6nY+XHJNbf+P7H
 /qVPHwlotEtqjOBH8DwQamJxnRTbJDAooBBd+t20AlPevfQSJglfbJMvx+AfHQTXnmuE
 NKYCGt600NDX+AUROuRqxh2MO5ZVBoDZnhS+qJ4YU2yLbvt26W6W46lJsH0vPJ+49Jh7
 oZcNLrJnKVvq60WpZsKHpmpUaQEF4bIsGDsWZoNjxYcVYIXjCgchdW59GNLQ0UV4yAUm
 AZlw==
X-Gm-Message-State: AOJu0YwsoNoxGl6tajRo5nngpHjU3XH7K7ELOytjIpuotLyXge6DRug4
 6G4GMnpKJiI+kD3Ofw8x1APSZuvP9jPoSIaf/1psBwO1261xf+pdj1wVaR20+qo=
X-Google-Smtp-Source: AGHT+IGTCw5zpNj+2dKTyP1quAHT0Qu4SmXgtQKCsrrxRWkL9P1V9IDeyMgWdHAuQWpNbQEfyLVmDw==
X-Received: by 2002:a05:6808:219d:b0:3d2:1d05:575 with SMTP id
 5614622812f47-3d24e92e80emr14666137b6e.32.1718720974725; 
 Tue, 18 Jun 2024 07:29:34 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2475e4dfcsm1814320b6e.7.2024.06.18.07.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:29:34 -0700 (PDT)
Date: Tue, 18 Jun 2024 08:29:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH] amd: versal2: Use U_BOOT_LONGHELP macro
Message-ID: <20240618142932.GQ68077@bill-the-cat>
References: <9fc5f9c3d92a45f0603e6e912394655f42e96173.1718716595.git.michal.simek@amd.com>
 <20240618141839.GP68077@bill-the-cat>
 <26e965b2-f1aa-4b33-ac64-1c16d1ea2313@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D+6iZFJ8Ly1YRZXg"
Content-Disposition: inline
In-Reply-To: <26e965b2-f1aa-4b33-ac64-1c16d1ea2313@amd.com>
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


--D+6iZFJ8Ly1YRZXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 04:23:58PM +0200, Michal Simek wrote:
>=20
>=20
> On 6/18/24 16:18, Tom Rini wrote:
> > On Tue, Jun 18, 2024 at 03:16:38PM +0200, Michal Simek wrote:
> >=20
> > > It is defined as __maybe_unused variable which fix issue when long he=
lp is
> > > disabled.
> > >=20
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > >=20
> > >   board/amd/versal2/cmds.c | 5 ++---
> > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/board/amd/versal2/cmds.c b/board/amd/versal2/cmds.c
> > > index fbd99918a7f4..56ae39bc6a1e 100644
> > > --- a/board/amd/versal2/cmds.c
> > > +++ b/board/amd/versal2/cmds.c
> > > @@ -71,10 +71,9 @@ static int do_versal2_load_pdi(struct cmd_tbl *cmd=
tp, int flag, int argc,
> > >   	return cmd_process_error(cmdtp, ret);
> > >   }
> > > -static char versal2_help_text[] =3D
> > > +U_BOOT_LONGHELP(versal2,
> > >   	"loadpdi addr len - Load pdi image\n"
> > > -	"load pdi image at ddr address 'addr' with pdi image size 'len'\n"
> > > -;
> > > +	"load pdi image at ddr address 'addr' with pdi image size 'len'\n");
> > >   U_BOOT_CMD_WITH_SUBCMDS(versal2, "Versal Gen 2 sub-system", versal2=
_help_text,
> > >   			U_BOOT_SUBCMD_MKENT(loadpdi, 3, 1,
> >=20
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >=20
> > Ah, any chance you can work up something to checkpatch to catch that? I
> > had gone through a while ago and fixed up the cases which should have
> > been using that macro but I see a few more have slipped in, again.
>=20
> yes there are some more again and as I see even one ours.
> I will add that checkpatch part to our todo list but no promise.
> And will fix that others.

I started fixing them up already, except for the amd ones. When you're
able to get the checkpatch.pl part done I appreciate it.

--=20
Tom

--D+6iZFJ8Ly1YRZXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZxmcgACgkQFHw5/5Y0
tyyfvwv+PO1bb7+xXxeZJrFKIg68XhZJ36+greT2j7C/qGuQiGukwZ4wy9vnfSEw
ufH9XSfc/+N6Ci6x+7y0yiQ1WTFzq/rlvZ2Sj9lrLchl3Ggfc1HxiqQjC1oAE7Fc
8Hgh8lrI0cFXV1p3sOw+VKDKvXkhHQlhQ6kCfngNPhb/+4ZKu63KtD6wYSb9mnBb
EeDOTw6Sbxsndamu66ZSGvG/RxYb9paVF6VcxNawLzUQk71iUScc5AZNrf8FnAC4
QJlpRXHdp+2RV3Gr8QcppziOdzwkKLoFw3SZYYC1zD9Qfs5KxhldxQzGPNeQM42K
OPJ3jL0NYqIfhxgh7KOfXelBBEe0wDMP62at1gR/7e5GU2qPXnKC33Q/zISdtIhG
1Xl4smniYJj1sLY7jcSj1ZkO85t3uLaicGs8C3tP8+cU7xuD09NhUZLveisdNQ5+
r6ksvCwRkSpz/vMhROsE9QNHaQ2AcEBxBsQRbeFxIHBa5ACs+15ma67b1z/kWcFv
WWgYInfe
=Zi6/
-----END PGP SIGNATURE-----

--D+6iZFJ8Ly1YRZXg--
