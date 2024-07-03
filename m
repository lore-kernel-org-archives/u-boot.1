Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82928C30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6989A87E13;
	Wed,  3 Jul 2024 15:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gXJYla3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB2487F9F; Wed,  3 Jul 2024 15:42:46 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD0B87C68
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 15:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D6E7CCE1B76;
 Wed,  3 Jul 2024 13:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A315CC4AF07;
 Wed,  3 Jul 2024 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720014161;
 bh=tVokBSXfvkEDrmlylBlAfG57iIHfV3oEyK2coV1fps4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gXJYla3Xu7jSYJTagUVc9n006hXvuVB2x/zdSL71XqsPwQ/SqkGVmguQdBNpNfUVQ
 zKW9u8usFMuE1kgKKyk9uPxcUWznig7Idwirhbe7/YUhVVPNMz6972tkupVQ36g7AP
 zNqj2CwfjmEcZpzLzr4gjY+opTb7L5v1zzXoko7T/Kxi5of4UoFHcWhED9KJj+gZPZ
 eenTDHWUS/B8BhZCS/o4ulI0gxf0ZboKJYiXgr68COw3+FPgZdL1ahdP2y9JPa0I2q
 GnGk+SeSDxkS9+n6/OrOJgfxdnic6GlTZ1XVA4Ym89pjdZyI4SzTJSwHEn7FYCmWfX
 7RE4nGJp3yVpA==
Date: Wed, 3 Jul 2024 14:42:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: u-boot@lists.denx.de, Ivan Griffin <ivan.griffin@microchip.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v1] board: mpfs_icicle: implement board_fdt_blob_setup()
Message-ID: <20240703-persecute-jumbo-cb910778c10c@spud>
References: <20240625090806.1787287-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/TrPeNelyc9IXXzc"
Content-Disposition: inline
In-Reply-To: <20240625090806.1787287-2-conor.dooley@microchip.com>
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


--/TrPeNelyc9IXXzc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 10:08:06AM +0100, Conor Dooley wrote:
> The firmware on the Icicle is capable of providing a devicetree in a1 to
> U-Boot, but until now the devicetree has been packaged in a "payload" [1]
> alongside U-Boot (or other bootloaders/RTOSes) and appended to the image.
> The address of this appended devicetree is placed in a1 by the firmware.
> This meant that the mechanism used by OF_SEPARATE to locate the
> devicetree at the end of the image would pick up the one provided by the
> firmware when u-boot-nodtb.bin was in the payload and U-Boot's devicetree
> when u-boot.bin was.
>=20
> The firmware is now going to be capable of providing a minimal devicetree
> (quite cut down due to severe space constraints), but this devicetree is
> linked into the firmware that runs out of the L2 rather than at the end
> of the U-Boot image. Implement board_fdt_blob_setup() so that this
> devicetree can be optionally used, and the devicetree provided in the
> "payload" can be used without relying on "happening" to implement the
> same strategy as OF_SEPARATE expects in combination with
> u-boot-nodtb.bin. Unlike other RISC-V boards, the firmware provided
> devicetree is only used when OF_BOARD is set, so that the almost
> certainly more complete devicetree in U-Boot will be used unless
> explicitly requested otherwise.
>=20
> Link: https://github.com/polarfire-soc/hart-software-services/blob/master=
/tools/hss-payload-generator/README.md [1]
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Off-list it was suggested to me to use MULTI_DTB_FIT in addition what
what I've done here, to allow U-Boot to actually make use of the
information in the firmware provided dtb to select a more complete dtb
for the OS (or for itself). I whipped up the following quickly just to
test that it works, but was super lazy about it as you can see:
diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mp=
fs_icicle/mpfs_icicle.c
index ade150bec98..76f37a7199c 100644
--- a/board/microchip/mpfs_icicle/mpfs_icicle.c
+++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
@@ -52,6 +52,31 @@ static void read_device_serial_number(u8 *response, u8 r=
esponse_size)
 		response_buf[idx] =3D readb(MPFS_SYS_SERVICE_MAILBOX + idx);
 }
=20
+#ifdef CONFIG_MULTI_DTB_FIT
+int board_fit_config_name_match(const char *name)
+{
+
+	char compat[256] =3D "microchip,";
+	size_t max =3D 256 - strlen("microchip,");
+	int ret;
+
+	/*
+	 * If there's not a HSS provided dtb, there's no point re-selecting
+	 * since we'd just end up re-selecting the same dtb again.
+	 */
+	if (!gd->arch.firmware_fdt_addr)
+		return -EINVAL;
+
+	strncat(compat, name, max);
+	ret =3D fdt_node_check_compatible((void *)gd->arch.firmware_fdt_addr, 0, =
compat);
+	if (ret)
+		return -EINVAL;
+
+	debug("found a match for compat: %s\n", compat);
+	return 0;
+}
+#endif
+
 void *board_fdt_blob_setup(int *err)
 {
 	*err =3D 0;

I'd rather invert the logic so that we compare the name of the config
with the compatible strings sans vendor prefix - what's here would work
for any of the boards were we are the vendor but not for the
beaglev-fire. Granted that board is not supported in U-Boot right now,
but I'll probably accompany a v2 of this that with an OF_UPSTREAM
conversion for the PolarFire SoC boards.

However, I don't really understand how I could make my implementation of
board_fdt_blob_setup() play nicely. It appears that if I enable OF_BOARD
then then the multi dtb stuff never kicks in (since we've updated the
fdt pointer to that of the firmware provided dtb). Given that
setup_multi_dtb_fit() is called almost immediately after
board_fdt_blob_setup() in fdtdec_setup(), it seems like dropping
board_fdt_blob_setup() entirely might be a better approach?

I think that'll have the same behaviours we want w.r.t. firmware config
options etc - except U-Boot will have to be built with functional
devicetrees for all boards it wants to support. Maybe that's not a
problem since it'd still be a single build for all boards. Maybe
Heinrich has a better opinion there than I do..

Thanks,
Conor.


> ---
> CC: Ivan Griffin <ivan.griffin@microchip.com>
> CC: Padmarao Begari <padmarao.begari@microchip.com>
> CC: Cyril Jean <cyril.jean@microchip.com>
> CC: Tom Rini <trini@konsulko.com>
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: u-boot@lists.denx.de
> ---
>  board/microchip/mpfs_icicle/mpfs_icicle.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/=
mpfs_icicle/mpfs_icicle.c
> index 4d7d843dfa3..2c1f7175f0e 100644
> --- a/board/microchip/mpfs_icicle/mpfs_icicle.c
> +++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
> @@ -9,6 +9,7 @@
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> +#include <asm/sections.h>
> =20
>  DECLARE_GLOBAL_DATA_PTR;
> =20
> @@ -50,6 +51,24 @@ static void read_device_serial_number(u8 *response, u8=
 response_size)
>  		response_buf[idx] =3D readb(MPFS_SYS_SERVICE_MAILBOX + idx);
>  }
> =20
> +void *board_fdt_blob_setup(int *err)
> +{
> +	*err =3D 0;
> +	/*
> +	 * The devicetree provided by the previous stage is very minimal due to
> +	 * severe space constraints. The firmware performs no fixups etc.
> +	 * U-Boot, if providing a devicetree, almost certainly has a better
> +	 * more complete one than the firmware so that provided by the firmware
> +	 * is ignored for OF_SEPARATE.
> +	 */
> +	if (IS_ENABLED(CONFIG_OF_BOARD)) {
> +		if (gd->arch.firmware_fdt_addr)
> +			return (ulong *)(uintptr_t)gd->arch.firmware_fdt_addr;
> +	}
> +
> +	return (ulong *)_end;
> +}
> +
>  int board_init(void)
>  {
>  	/* For now nothing to do here. */
> --=20
> 2.43.2
>=20

--/TrPeNelyc9IXXzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoVVTQAKCRB4tDGHoIJi
0lbcAQCdE3NmoFvr5eG5Ihs0wuuu+y8cwMkCWdqx7ZGapKUwZAEAoHSojVuKQ2T7
bqwqPk/Zr3RULHZFROWhH9xRL81n7QU=
=Ftsy
-----END PGP SIGNATURE-----

--/TrPeNelyc9IXXzc--
