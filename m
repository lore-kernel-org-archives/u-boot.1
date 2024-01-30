Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C59C47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 12:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD0587B1D;
	Tue, 30 Jan 2024 13:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IxE1K9Px";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4336087A00; Tue, 30 Jan 2024 13:57:35 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E841587B1D
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 13:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-602a0a45dd6so36058277b3.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 04:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706619451; x=1707224251; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3dHsg2j5Z7RU6GorhJCe5G+b4FGmIkuGB6VOf0QRN+o=;
 b=IxE1K9PxuH4oxyFKdoGLVJNLuCS7a+XnXp/+LctwYJuM/hI9hKVlKECVRpEISB3NKA
 asOLztJlbLWuEiJXPKDqCUC2S6a3kGUS1qAWdW4RAeztrGx4TNqxYans9zEAM0+7VfiC
 YfSuRy2/p3d05P8Pqq8Ybj4CF2ffj9H4jwcWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706619451; x=1707224251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dHsg2j5Z7RU6GorhJCe5G+b4FGmIkuGB6VOf0QRN+o=;
 b=nzUm25woceh3TR5TQ6DpkuZC/t9BRrWgUYVc0SJZnVacMq6FB7lsIvf8AjquIud4M+
 NmEr0QzP8n9BHzpvetcCIpofJr9O3593Zlq0eIJUqMYeNgf6e9Phv7SCr0CKy/ZHpv+k
 BWvJVmhHRkIEpZPdvhgvSGbfG16CVtFIuJqKOIvEi/5DrwOWuPxNsC9rJRDuZEk1mWbb
 etrtHAbySoIqDVksLMYoGgHWH9iCDrmv6iwogQ5r+s02qA4GRf+q/ymhMfAmOA84Wmes
 wAHVS4okM2Lvlzb3yhIO4Y7iqeAK4q4e/YgV89krnWjIOo+hUpCehdXvXnoaU8yqiyyU
 jAzg==
X-Gm-Message-State: AOJu0YzDlK7LSKxag0YdSc7siYvqe/KmZPdMOT0mCwaPW8U/RhWQ0ORH
 c5cIxC4xWI6hztgqjPY6dbFzOSk8cQ4okDfCcmWNFBn8EwkW2GiNuBM1iaK0ioM=
X-Google-Smtp-Source: AGHT+IHUdBau3ItiY707GQ1cVkK38+z4oeqrMCGOYu4Knv+UVC+4CwmjWNKc6NWy7UYKMZDzRo8Kiw==
X-Received: by 2002:a81:e804:0:b0:5ff:4e43:8430 with SMTP id
 a4-20020a81e804000000b005ff4e438430mr6281835ywm.1.1706619451618; 
 Tue, 30 Jan 2024 04:57:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 cm15-20020a05690c0c8f00b005ff992b46cesm3156018ywb.36.2024.01.30.04.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 04:57:31 -0800 (PST)
Date: Tue, 30 Jan 2024 07:57:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Primoz Fiser <primoz.fiser@norik.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, Yannic Moog <Y.Moog@phytec.de>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
Subject: Re: [PATCH v3] board: phytec: phycore-imx93: Add
 phyBOARD-Segin-i.MX93 support
Message-ID: <20240130125728.GQ1152441@bill-the-cat>
References: <20240125164503.32097-1-othacehe@gnu.org>
 <9f20708a-eefb-4a27-a413-8a9f5a472788@norik.com>
 <878r472m2n.fsf@gmail.com>
 <99d704dc-8133-45e1-a346-ab1d05d5fb7b@norik.com>
 <874jev2dgp.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YtfMy9FhUutahaxj"
Content-Disposition: inline
In-Reply-To: <874jev2dgp.fsf@gmail.com>
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


--YtfMy9FhUutahaxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 01:49:26PM +0100, Mathieu Othacehe wrote:
>=20
> Hey,
>=20
> > Can you re-check, please?
> >
> > Maybe check your include/generated/environment.h?
>=20
> Thanks for checking. It is strange that you do not reproduce that one.
>=20
> My include/generated/environment.h looks like:
>=20
> --8<---------------cut here---------------start------------->8---
> #define CONFIG_EXTRA_ENV_TEXT "bootenv=3Dbootenv.txt\0bootenv_addr=3D0x83=
500000\0console=3DttyLP0\0fdt_addr=3D0x83000000\0fdt_file=3D\"oftree\"\0fdt=
o_addr=3D0x830c0000\0image=3DImage\0ip_dyn=3Dyes\0loadfdt=3Dfatload mmc ${m=
mcdev}:${mmcpart} ${fdt_addr} ${fdt_file}\0loadimage=3Dfatload mmc ${mmcdev=
}:${mmcpart} ${loadaddr} ${image}\0mmc_apply_overlays=3Dfdt address ${fdt_a=
ddr}; for overlay in ${overlays}; do; if run mmc_load_overlay; then fdt res=
ize ${filesize}; fdt apply ${fdto_addr}; fi; done;\0mmc_load_bootenv=3Dfatl=
oad mmc ${mmcdev}:${mmcpart} ${bootenv_addr} ${bootenv}\0mmc_load_overlay=
=3Dfatload mmc ${mmcdev}:${mmcpart} ${fdto_addr} ${overlay}\0mmcargs=3Dsete=
nv bootargs console=3D${console},${baudrate} earlycon root=3D/dev/mmcblk${m=
mcdev}p${mmcroot} ${raucargs} rootwait rw\0mmcautodetect=3Dyes\0mmcboot=3De=
cho Booting from mmc ...; if run mmc_load_bootenv; then env import -t ${boo=
tenv_addr} ${filesize}; fi; run mmcargs; if run loadfdt; then run mmc_apply=
_overlays; booti ${loadaddr} - ${fdt_addr}; else echo WARN: Cannot load the=
 DT; fi;\0mmcdev=3D1\0mmcpart=3D1\0mmcroot=3D2\0net_apply_overlays=3Dfdt ad=
dress ${fdt_addr}; for overlay in ${overlays}; do; if run net_load_overlay;=
 then fdt resize ${filesize}; fdt apply ${fdto_addr}; fi; done;\0net_load_b=
ootenv=3D${get_cmd} ${bootenv_addr} ${bootenv}\0net_load_overlay=3D${get_cm=
d} ${fdto_addr} ${overlay}\0netargs=3Dsetenv bootargs console=3D${console},=
${baudrate} earlycon root=3D/dev/nfs ip=3D${nfsip} nfsroot=3D${serverip}:${=
nfsroot},v3,tcp\0netboot=3Decho Booting from net ...; run netargs; if test =
${ip_dyn} =3D yes; then setenv get_cmd dhcp; else setenv get_cmd tftp; fi; =
if run net_load_bootenv; then env import -t ${bootenv_addr} ${filesize}; fi=
; ${get_cmd} ${loadaddr} ${image}; if ${get_cmd} ${fdt_addr} ${fdt_file}; t=
hen run net_apply_overlays; booti ${loadaddr} - ${fdt_addr}; else echo WARN=
: Cannot load the DT; fi;\0nfsroot=3D/nfs\0"
> --8<---------------cut here---------------end--------------->8---
>=20
> Note that fdt_file=3D\"oftree\" which explains the issue on my side. Do
> you have a similar environment.h?
>=20
> What u-boot commit are you based on?

And what awk do you both have? environment.h is generated via
scripts/env2string.awk

--=20
Tom

--YtfMy9FhUutahaxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW48jUACgkQFHw5/5Y0
tyyy5wv/S1c9nt0tcwvrDSBrbCXDSqQdRTFqmOLeqZQtl/pUzm3OxmeSnw+JUM6A
hGwz2nlrBfjlEjX3dyu4atNP01L6zVqE2YuoBCstj+t0cLY0dYIhrDesKFpLfl/0
pZyVMcwvfUBgtWG8epLwngLlCR8FhiKTzpPdRAhJKFNVIcOQaYVIU9EHbUfi1Fxi
IDviGyeknymo+ykp0R0onVaEa3BXhLnzj3wniJFrxTTdu4Dev4Z7978UKyvg486t
a5m32y5kcqtnV//Dng5jD7tjut8Mi1d0qQZEn1j00f56AmQm0xhJtBVG8uUaz/zs
3Adko4rPBcbUB5tqWyk1MI9a24bupd8Tc1aC0Xqk2Vb6FI7Vsnib3D3GvusE3CKN
DVgs+TAnbVgsrc4haXuqeAJllMfCdGfA7VyB4301hj0nRVXA135WVOMTC0OGuN4g
lrAj5O4mRFOIwdT/TGbgSBRHs6Lte5sSSctZNQkbGOg68e8ljsZTcfuYwpLpwLj7
7Qww4H4v
=38rK
-----END PGP SIGNATURE-----

--YtfMy9FhUutahaxj--
