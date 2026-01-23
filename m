Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E925D74ED3
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 14:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C222983B27;
	Fri, 23 Jan 2026 15:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i2nfHC15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 092D383B32; Fri, 23 Jan 2026 15:27:16 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D03F083B21
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 15:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7cfd57f0bf7so1535241a34.3
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769178432; x=1769783232; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=54u6FaUrhDwLIjjM+MkTlHwlidhasMLEV3M/jvUQELs=;
 b=i2nfHC15aHpjJIDRzPUBD/RDW+wB2k5IAMKG2JWikOVA9Qr2Cg7lDKaob5t6wSgIhT
 rApNCo/1zfM5h10EFY7mws94yId+DCTTF2adnhLkY94jfUuD/NPJnMPr7BZtsL4+8a4W
 qlGYbYkvRMFiHBZncQQSXiakXgaob5MmHMQTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769178432; x=1769783232;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54u6FaUrhDwLIjjM+MkTlHwlidhasMLEV3M/jvUQELs=;
 b=HjPHCZuEnMBCkt3xGytu/l03hT9MXPFyH2OOvqXRXq9ReJYNvcemwyjr3cCfcXugcC
 RE1IbgOxPaCwz/K5Jg0dhOPUy+5GU1/Pwiv+6L0YFLWRpP56NXMV6+GZ1bwofAamw8+Y
 774w8hFpt1Caeg7jIcDrdVglqxw5kjx+DlJaa9QuG8yNnOmnUWXxZPlIb3s3gdEKgfBD
 nLLGG/eOrdLdq/MmoLu4H5O+5y3Q24VsbzNcrMkNYPpmyvgcXBMZLIl/zYB4CpLdlo5u
 ky6tPP7N0dWV33+cKqGzOva86A29oJZh7n0yyHVRYHzvl957ZAAbdBDqmEQy6fVzQGcv
 mRqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8HRa6acNXEOFUNXwUJquWl0DBx6p66EbjIO1eJRqTIq+2/YeViLguiHM+KUvfwOCXQ1r0K0c=@lists.denx.de
X-Gm-Message-State: AOJu0YzcACIbCJMGzUsXHePgVYIx6seC9QRAIPKBYety5pac/3Krzhl0
 UblYt/bUjQKmHLxd/geuIdfz1Cs71qsDhqA9OK/hZee5XR0LUeqbNKAQQtc+TciNnDw=
X-Gm-Gg: AZuq6aLsHs37i/scsuYFBsSpGLOGVJIanzYRwscm39a1DdE9YJ/KumH48o6dNlyF0m+
 0yvLw9O6ykuhjFEY1MSHRpkT+GOrJm5oja2CABK4UYyZhScBjYRQfv9vyzrncCzHIE11y1cOZFr
 n+xXaFiXKF0hVU004Z7KEjnPPmOPpQmaHLlsV7MSnKq6Auy2IoCqHuvzadGXqv3PlBmPdWS+Dcs
 Cv0rLpMKcHjdpnsHWRt9CZXtwP/UX/nDkiM2weggzzNDYtnnEFqK2/Im5Ls8vy6GT/djP69raVq
 DZasOJHp+VG2gZ1maSz+GleAaJdCAmV84k8uvSLacjPhgx5kcE75PHGZmu/ydMwbfbV9sqiNKvF
 OPNPLTi/T59LI/I/pg1T4NtCY8cFjp2v1lMma5qEX9U2vBvR/jxXxjQ9LFlo4OSyK02mHwUhxy6
 TB5Ewo+xFuajzp/6dYZAdOe7ZclBB6DY72y80HtStF6v4/BAFJNZZUYKsjcZ1KNMmt2FFOcfGix
 6G07D8pn/9XYofhhBtuEJDqO91czFRUnbTD8WA=
X-Received: by 2002:a05:6830:82aa:b0:7cf:d819:a2d2 with SMTP id
 46e09a7af769-7d160b7fdc0mr553468a34.31.1769178432547; 
 Fri, 23 Jan 2026 06:27:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d15b3d32a2sm1966998a34.22.2026.01.23.06.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:27:11 -0800 (PST)
Date: Fri, 23 Jan 2026 08:27:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <20260123142708.GH3416603@bill-the-cat>
References: <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
 <20260122142323.GX3416603@bill-the-cat>
 <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
 <20260122191042.GD3416603@bill-the-cat>
 <CAOMZO5CJ4BAi95gjV8a=_W-Wu=zr1dMOoDOCB4yUVAzY2ARBUA@mail.gmail.com>
 <20260122194239.GF3416603@bill-the-cat>
 <CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com>
 <20260122232407.GG3416603@bill-the-cat>
 <CAOMZO5ADFCbzyv3whDo_w=hEwe9i1hhMZ-X+UEu8132pkFnqJg@mail.gmail.com>
 <CAOMZO5CLQZ3i+Eit5csv6E+az-_g2eOHfCr-whQTPeg06WtqEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="68BOYbq4XTwylsIL"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CLQZ3i+Eit5csv6E+az-_g2eOHfCr-whQTPeg06WtqEg@mail.gmail.com>
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


--68BOYbq4XTwylsIL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 09:52:39PM -0300, Fabio Estevam wrote:
> On Thu, Jan 22, 2026 at 9:25=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
>=20
> > The commit in the Subject is what appends 4 bytes, and the binary is
> > now shifted, causing the boot failure:
> >
> > hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
> > 00015f10  00 00 00 00 d0 0d fe ed  00 00 0a 43 00 00 00 38  |..........=
=2EC...8|
>=20
> To make things simple, let's use a supported board in mainline.
>=20
> Please follow these steps to reproduce the bug:
>=20
> U-Boot top-of-tree:
>=20
> make mrproper
> make sonoff-ihost-rv1126_defconfig
> cat spl/u-boot-spl.map | grep __bss_end
>                 0x000000000000b468                __bss_end =3D .
>                 0x0000000000000054                __bss_size =3D
> (__bss_end - __bss_start)
>=20
> hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
> 000016d0  a9 98 00 00 15 15 00 00  d0 0d fe ed 48 99 00 00  |............=
H...|
> 00001d20  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG..=
=2E...|
> 0000b460  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |............=
=2E...|
>=20
> b468 contains 00 00 00 00 instead of FDT_MAGIC. FDT_MAGIC appears at b468=
 + 4.
>=20
> After reverting 8b0ebe054bb3334c6ca9bed018360b08d4ddc7a4:
>=20
> cat spl/u-boot-spl.map | grep __bss_end
>                 0x000000000000b468                __bss_end =3D .
>                 0x0000000000000054                __bss_size =3D
> (__bss_end - __bss_start)
> hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
> 000016d0  a9 98 00 00 15 15 00 00  d0 0d fe ed 48 99 00 00  |............=
H...|
> 00001d20  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG..=
=2E...|
> 0000b460  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 0d 95  |............=
=2E...|
>=20
> b468 contains FDT_MAGIC as expected.

So this:

diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index d780a5060774..dcc201c30482 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -50,8 +50,8 @@ SECTIONS
 	.rel.dyn : {
 		__rel_dyn_start =3D .;
 		*(.rel*)
-		__rel_dyn_end =3D .;
 		. =3D ALIGN(8);
+		__rel_dyn_end =3D .;
 	}
=20
 	_image_binary_end =3D .;

Will shift the dtb location lower and __rel_dyn_end 4 bytes higher.
Which is probably fine.

--=20
Tom

--68BOYbq4XTwylsIL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXOFOQAKCRAr4qD1Cr/k
Cm1MAP4nEWRg++4lAdWlxi0+MSLc5ANwyIjr4nQE3vo1tbLp9AD8CCcGX+VbEJZC
fLvxbBRx+3wZzAqQ86BtvbG2StXb+AE=
=fIn5
-----END PGP SIGNATURE-----

--68BOYbq4XTwylsIL--
