Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F77C3DA41
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 17:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B75887F5;
	Mon,  8 Jul 2024 19:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kA+J7cin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30D5687919; Mon,  8 Jul 2024 19:42:00 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CDB988823
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 19:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5c661e75fcfso1101044eaf.2
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 10:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720460516; x=1721065316; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BTuimonjaI64dF1Cysd6j2KcCTavGS9MAUd8g7BynR8=;
 b=kA+J7cinDqbiYHjQjUsVzFjAUgygpH7sIvw0ZryElh4RAJLV6kViTgodVHg152r9QZ
 ZKg2MptUIIyOSiHSboRlqJIcvAVnRGg3FkO+9Qxyjkz5fWy2XBkyJpTcBF9NZZ3kcwZb
 bCdDpmz87SSVOijotmfh59Y6VEKk+QwffGtpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720460516; x=1721065316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTuimonjaI64dF1Cysd6j2KcCTavGS9MAUd8g7BynR8=;
 b=scdXZQtAzXFMtCffNeuatYqImqUL70nqnxUJmfhB4Gtwp6hCr0tOvBmhy5NtrJ0J+I
 wphrvUHF6NCWECDMM8ZGeu7Po8ft3rEjhAsuYjfrFw0sc2HXoIZsnLrdeN/x1G34nhnu
 vmVUulPydL4Aiqm+Z7I6rm8jJMkzb2cUWZWIoYJ+f82LG6BceedhWdV8GeVBwEKurx57
 IvhfKmxTp55qv3Bs++Gt/Yn+Syl7cObW9h61oaJmMk3vbH/6Hk66NTZnQc9HmB8QXA/Z
 1qZEixliW2uoM/ciC2WYe/yz32nb/dxJyq8/QrMaujvUz0AB0enP/NA6GoomOHX4Gm7f
 vLyw==
X-Gm-Message-State: AOJu0Yx+jkwsh0Zr4yVfiqin7ll5gA9SqmldgC0d+qx0yqyDk+t7lFpv
 ao4UNwCLrD8ZBsX+VCIGi5aLk+6yR616L4Rzd/dpg5xDAmu59Tl+9WnOasznA7Y=
X-Google-Smtp-Source: AGHT+IFYAcnqZja53UH9D4RCcT/AJnFKohL9fOy7V31MpnDB4Y9pmB+IDaSR0/rkAPIAs+2Orvwl3w==
X-Received: by 2002:a05:6871:24e0:b0:25e:56a:9665 with SMTP id
 586e51a60fabf-25eaebc6866mr48331fac.43.1720460515808; 
 Mon, 08 Jul 2024 10:41:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa22588dsm89360fac.37.2024.07.08.10.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 10:41:55 -0700 (PDT)
Date: Mon, 8 Jul 2024 11:41:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240706
Message-ID: <20240708174153.GK38804@bill-the-cat>
References: <20240706204547.15708-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nIrtPQli23GBVSA2"
Content-Disposition: inline
In-Reply-To: <20240706204547.15708-1-festevam@gmail.com>
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


--nIrtPQli23GBVSA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 06, 2024 at 05:45:47PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit fd46ea0e701920eb205c2bce9d527bf0dec10b=
59:
>=20
>   Merge branch '2024-07-05-assorted-updates' (2024-07-05 16:36:43 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240706
>=20
> for you to fetch changes up to 3d4c29258f8b4c4a5cf4ce79fb1ac80f66e4cf65:
>=20
>   clk: imx: add mux ops for i.MX8M composite clk (2024-07-06 15:40:04 -03=
00)
>=20
> u-boot-imx-master-20240706

Applied to u-boot/master, thanks!

--=20
Tom

--nIrtPQli23GBVSA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaMJOEACgkQFHw5/5Y0
tyy2MwwAlGH15ELaRgtVrjzPBBZq6BT8Uov1PcqzVT6r3j+8rkPoMAYeooepRmee
kRGXta4fNZ9ODDCLwlA7XBEdEI6eeJfKezjMjCmOcPh7oloDR1fepBhx6Kh7PD5o
zKbZNSSgKbSHCYvtl7nufvNSgkVM2xx/M7k5C9ZCIAEPsbrWF+kusPpjA0iYPApI
SMZAZgGzbopsca2/sj8fzyi9SIVHIChN7/6tNlk+1gQQSSiEbOghx3oRGO0gt2MD
zP/n1mUGSKJb+poal1I/hCSrFW3pwZJ5/zwp46rnTeq6KB2zYiYiOhMR/zRiMvF5
VWOAPw8hjmRLGVvESK97EFm/ONXQ+K9G39gDtLt+vxgIOtVELkRWZE44gQaJeFnj
PD8Q/nMK3/gqKY1Nq7pGkfa29DEj5XKzWI6yskSG6Qh/bC6XKwacGG614hI3CZdQ
tLbAqFLxfCDowflfWwjAhGaRKP+X4EM0x6Zo4fFbfIj/JLsJqk4F9jGQrEfzyblB
eHqYLG/8
=7pM3
-----END PGP SIGNATURE-----

--nIrtPQli23GBVSA2--
