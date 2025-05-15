Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3CBC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 14:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FA5C82BD9;
	Thu, 15 May 2025 16:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SvIn/D42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B07482BC1; Thu, 15 May 2025 16:39:05 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27BA582BC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-605f7d3215cso625872eaf.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747319941; x=1747924741; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wPijTU1llKIaxMFRZ9Fp2hGLgWFAC+i0Nn0DuGV0g0k=;
 b=SvIn/D42mtwKSEYKa5NdjtrVzAp2ZO7CLoTyB4WeQ6AHVudaAsEqZWyKxF1M0vqwzX
 42CNIg+3OXcEMHdrSA+OOclG0/XDMmXwjgB35WoM0xCh3seGeT9nwVzffOaYFIJoTA+d
 l1I4elUzioTh/WoFOqPkBC7m8YKt0uCNC/Fgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747319941; x=1747924741;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPijTU1llKIaxMFRZ9Fp2hGLgWFAC+i0Nn0DuGV0g0k=;
 b=OCRzEDEVNLrotI0IDAFhu7QEk+fdwye7UklQXP3BNjhIH5dvss+vqGUNb/2zC0IXPY
 TMLiOgr+nF7zyIY9Epotb3hmA4wP/GfGXOrhcu2+ZyKz/u03K0own7E3bfGQEn75P/ER
 fiv2KzObbS429xMfdj9Bu4uQZAeimIzicqSi/5f0JhFdQHXSsrRi0WuNtneLrrcXxB7v
 qmA8hGfKf1/uyKPVipBB2YPQlLy42RJk1v/K2NMntDdZ4LSdab1orIplVMIGvINmeG3C
 38x0Lx10Kpsw9Qe6R8zOk3WMy9e4uy3ySnpAdzPMrPbt0j4fWivDxMQ4FYtbjJuGExhM
 o16w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZtIOZehi1Y8Lq7OA0dmkqmSoiGj7v7A4x/6vsDmpoRNgv563vbOtWcwcemVznVmpwheO5siY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1JTdgc9PJ9EnAizfubwCh4H94LFnTyUWfSXFEZ7s0uzZBe+iu
 LoaQRnlFg2RYULl+LBUIt4PoKorTmoT+imBJt0w6HAmgUuWhzmbAdQp4ADRxTdM=
X-Gm-Gg: ASbGnctX/o1sKBqi9CuaF+QHMn3wqFCYhVOzlgmCP0qDP+f+MZD+5Q7KFAUfhnidfmV
 hZZKN4cqm5lcwohVO3uLlvwqkbZ02IWwm867TdiCC9Ap5vDKARo1JMoq9Je2lNVM5BcKk4i5VWs
 40KwPcIrC83qEt3Irs55gSB1LjE13HQ9Dr609Cydgwuw2ZSjkdGIk6/CajNqehZfPTjS43VKyLw
 EQtKmPt2b0TtVMw6Jfl/qYaWrkd+A6o4sfBRvOKbOndv2PcYi4pMFUCtMyuj6lRR8ND2BQp34S+
 DAAGsu8Avro9hEcWVaVp6+ACAVt57Bw9II0nEyRyqdxwfxe+9RQdtgm8GXNcpL5/3HTzWS2HBy7
 ZpWzJOBOygIDEHytlccMAFhI=
X-Google-Smtp-Source: AGHT+IEbKgNbh46GlHxIsa+pKQr0NCCehHie/I1Kwmqhn5dLT88pAlA58VGNsiTNoYTxHXJ2GDZuVw==
X-Received: by 2002:a4a:ee0d:0:b0:604:5e57:80ab with SMTP id
 006d021491bc7-609df0836bfmr3967045eaf.0.1747319940667; 
 Thu, 15 May 2025 07:39:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6083fe5243asm2848789eaf.23.2025.05.15.07.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 07:39:00 -0700 (PDT)
Date: Thu, 15 May 2025 08:38:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, linux-amarula@amarulasolutions.com,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH v2 2/2] arm: imx: imx8m: soc: replace ifdef by IS_ENABLED()
Message-ID: <20250515143857.GJ603748@bill-the-cat>
References: <20250515133035.815572-1-dario.binacchi@amarulasolutions.com>
 <20250515133035.815572-2-dario.binacchi@amarulasolutions.com>
 <167689e0-2523-4682-8cba-574a20ace3d9@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mZv+01BiquNVCl3s"
Content-Disposition: inline
In-Reply-To: <167689e0-2523-4682-8cba-574a20ace3d9@cherry.de>
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


--mZv+01BiquNVCl3s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 03:40:15PM +0200, Quentin Schulz wrote:
> Hi Dario,
>=20
> On 5/15/25 3:30 PM, Dario Binacchi wrote:
> > Standardize on using the IS_ENABLED macro.
> >=20
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >=20
> > ---
> >=20
> > (no changes since v1)
> >=20
> >   arch/arm/mach-imx/imx8m/soc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/so=
c.c
> > index 806adcf145fa..6c53555d22bf 100644
> > --- a/arch/arm/mach-imx/imx8m/soc.c
> > +++ b/arch/arm/mach-imx/imx8m/soc.c
> > @@ -791,7 +791,7 @@ int boot_mode_getprisec(void)
> >   #endif
> >   #if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
>=20
> You can even do those two as well :)
>=20
> and all the others in this file :) I would recommend to only do for those
> that start with CONFIG_ which are Kconfig symbols. E.g. PHYS_SDRAM_2_SIZE
> isn't, so I don't think you can use IS_ENABLED.
>=20
> The easiest way to check everything is fine is to compile before and after
> patching the file and checking that the output is bit to bit identical (y=
ou
> may need to change the SOURCE_DATE_EPOCH to guarantee that though?

A change like that would just be code churn and I'd rather not see it.
Especially since yes, you *can* get away with IS_ENABLED(FOO) and the
kernel does it in a few places, but you shouldn't do that in U-Boot as
it's more likely to be an error (you wanted IS_ENABLED(CONFIG_FOO)) than
a helpful case of:
        if (IS_ENABLED(FOO)) { ... }

--=20
Tom

--mZv+01BiquNVCl3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgl/IEACgkQFHw5/5Y0
tyxiOwv/YgSK/M20l2zM1MVViTIr2pTTRA+Fqo6sAUJ0hFy0ND4WV25OSXOQhA2e
YxQ2T7zA6XRdtx/VgJBMaZgYw0Q4YTWOaYCIxPGpTkxG/XVdFLfFHFHT/kXIYw6L
DlgkxQCHZbJdOUKTJBRMMI5kKesjvQItw1nsrdbhHpb3TOG44KWu8L3FaFJnpaxj
5ikWy3uSrJ+ZIRNb6cRRDFP0zAHqANHGWJzuZV+gK1itKj7fGTqjg7i5eb7ndFrT
0ZNtucxTqeO0HmbLbyhwQT66E1nFf27HmR/DsfFA+O8HAhi3hsXj5i9NCEZIJ/uN
i0Y1Ewe3o3TzZqRbPZHFhZl1a/DrChiF823CgaXSZ/eZ5Hh61xxlk1RYOFKPb3iy
95nV/kxuBInP3hDLxM40K8GCDXmE3dAE4tL7aRm3fZ5N7IqlRZwFC5pA35fMs5S5
3Ar+qHWOfNDj46H4iEbLQtYbAqBPaK7DG3TTSQrQqIeYlWkoEL7SKvHbs/QHG/hw
fRGCpjke
=aAzE
-----END PGP SIGNATURE-----

--mZv+01BiquNVCl3s--
