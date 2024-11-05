Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B925D3177F
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 18:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA5198917B;
	Tue,  5 Nov 2024 19:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD3A488A0A; Tue,  5 Nov 2024 19:37:36 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDCF891B0
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 19:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 249731F0004D
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:37:33 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 3D9D9A44AF2; Tue,  5 Nov 2024 18:37:32 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 416A9A44AE7;
 Tue,  5 Nov 2024 18:37:31 +0000 (UTC)
Date: Tue, 5 Nov 2024 19:37:28 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>, u-boot@lists.denx.de,
 Paul Kocialkowski <contact@paulk.fr>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 3/5] rockchip: tpl: allow to call board/SoC-specific
 code before DRAM init
Message-ID: <Zypl6BpHOHBZbH7s@collins>
References: <20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de>
 <20241105-rk3399-sysreset-gpio-tpl-v1-3-12caff07a4e4@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K8VrGgLCA23Rijei"
Content-Disposition: inline
In-Reply-To: <20241105-rk3399-sysreset-gpio-tpl-v1-3-12caff07a4e4@cherry.de>
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


--K8VrGgLCA23Rijei
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Tue 05 Nov 24, 16:36, Quentin Schulz a =C3=A9crit :
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> This defines a weak tpl_board_init function that can be used for running
> board/SoC-specific code before the DRAM init happens, similarly to
> spl_board_init() for SPL.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

Cheers,

Paul

> ---
>  arch/arm/mach-rockchip/tpl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
> index bbb9329e725af79ea4c4049aa7890a4a143e7df5..6b880f19f84e57e7bc0c93b16=
b188bc56267827e 100644
> --- a/arch/arm/mach-rockchip/tpl.c
> +++ b/arch/arm/mach-rockchip/tpl.c
> @@ -21,6 +21,10 @@
>  #include <timestamp.h>
>  #endif
> =20
> +__weak void tpl_board_init(void)
> +{
> +}
> +
>  void board_init_f(ulong dummy)
>  {
>  	struct udevice *dev;
> @@ -54,6 +58,8 @@ void board_init_f(ulong dummy)
>  	if (IS_ENABLED(CONFIG_SYS_ARCH_TIMER))
>  		timer_init();
> =20
> +	tpl_board_init();
> +
>  	ret =3D uclass_get_device(UCLASS_RAM, 0, &dev);
>  	if (ret) {
>  		printf("DRAM init failed: %d\n", ret);
>=20
> --=20
> 2.47.0
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--K8VrGgLCA23Rijei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmcqZegACgkQhP3B6o/u
lQwq2hAAma3oK8WfEj43NMHfj3CYZ/d2SLNEyTz7wET0Mc/Yw2HZ6SVj5A7glSpG
9L6HZaLOXXaVtFH4Pn24dSgz2IA/O8blunAXYA/9LpqF3Q0Q3DgC7xFUY5c5A2hs
jn76lU3ssP/4sPK5wGelru/waLCw/plVpV58Atxcs1x0LSk3dFSRLwUWsk7bnNkh
KQ7Tz7V8llppWZU3sp/jKl3hl+c6F1iX6fyDRnpQb8cM4byWlR4FCJLNfCgXFFaQ
P89Fwgovb5Xb1A9jh5Roc2BrAG1cBf/0DvkN4vi6ovrvkxuelALynIVTBfNa6ajC
EvT7FJeVhrI7pgFtGOFpR94Ee4OU/gO0IZYUfMXSxcCm6K9DZwDr0jxcUhKWV/25
lypzwnH/s/fmLDMpC9HtRPLaVxKMLbgYRt2/+KCU5d4KFzFGOwW+sak6UAGyXG5g
o0o3uMexo5C6Cms6Fxh7W6hSW5udpZTTjpge6cahmXIxcUFh8UwC1y5jeuGjWhZw
zCAi8QDDznbBJ+ueMLmwASWi3a08sU81jAVZyXmA17un/h9+jshfZdmYRZf3r+1k
prP0vO7NLhf+vcbmJxUmtH8b4+561C130dPx1JB37D01fdFvtcVIMS+KUTyEZNe5
XNNDkJDopCfuwptyOIMqU+Eff2oz1Xhr118qDndiA+TkCDIaCgM=
=4SfA
-----END PGP SIGNATURE-----

--K8VrGgLCA23Rijei--
