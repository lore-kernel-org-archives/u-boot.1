Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7ABCA0EE4
	for <u-boot@archiver.kernel.org>; Sat, 16 Aug 2025 12:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB01A83826;
	Sat, 16 Aug 2025 14:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=silbe.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B0283445; Sat, 16 Aug 2025 14:21:11 +0200 (CEST)
Received: from bbox-ptr.sascha.silbe.org (bbox-ptr.sascha.silbe.org
 [46.38.230.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F9F83443
 for <u-boot@lists.denx.de>; Sat, 16 Aug 2025 14:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=silbe.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sascha-ml-devel-u-boot@silbe.org
Received: from twin.sascha.silbe.org (twin.sascha.silbe.org [192.168.1.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "twin.sascha.silbe.org", Issuer "stunnel Pseudo-CA" (verified OK))
 by bbox.sascha.silbe.org (Postfix) with ESMTPS id 7687F1E0F42
 for <u-boot@lists.denx.de>; Sat, 16 Aug 2025 14:21:08 +0200 (CEST)
Received: (nullmailer pid 421145 invoked by uid 71000);
 Sat, 16 Aug 2025 12:21:08 -0000
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v6 8/8] Drop the special am335x_boneblack_vboot target
In-Reply-To: <20240627082949.357089-9-sjg@chromium.org>
References: <20240627082949.357089-1-sjg@chromium.org>
 <20240627082949.357089-9-sjg@chromium.org>
Date: Sat, 16 Aug 2025 14:20:34 +0200
Message-ID: <yh7ro6sfsbjh.fsf@twin.sascha.silbe.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
From: Sascha Silbe <sascha-ml-reply-to-2025-3@silbe.org>
X-Mailman-Approved-At: Sat, 16 Aug 2025 14:58:43 +0200
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

--=-=-=
Content-Type: text/plain

Hello Simon,

Simon Glass <sjg@chromium.org> writes:

[...]
> Now that am335x_evm boots OK on the Beaglebone black, drop the latter
> and update the docs to cover the change.
[...]
> diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
> index d243cb16e72..cabc181460a 100644
> --- a/configs/am335x_evm_defconfig
> +++ b/configs/am335x_evm_defconfig
> @@ -13,6 +13,8 @@ CONFIG_AM335X_USB0_PERIPHERAL=y
>  CONFIG_AM335X_USB1=y
>  CONFIG_SPL=y
>  CONFIG_TIMESTAMP=y
> +CONFIG_FIT_SIGNATURE=y
> +CONFIG_FIT_VERBOSE=y

Your patch drops CONFIG_LEGACY_IMAGE_FORMAT as a side effect of enabling
CONFIG_FIT_SIGNATURE. Is that intentional?

Debian systems use "legacy" format boot scripts to boot (at least when
using the "flash-kernel" package which is probably the most common
configuration) so recent U-Boot versions cannot boot Debian systems on
BeagleBone Black any more:

=== Begin ===
U-Boot 2025.01-3 (Apr 08 2025 - 23:07:41 +0000)

CPU  : AM335X-GP rev 2.1
Model: TI AM335x BeagleBone Black
[...]
Scanning mmc 0:3...
Found U-Boot script /boot/boot.scr
1625 bytes read in 2 ms (793 KiB/s)
## Executing script at 80000000
Wrong image format for "source" command
SCRIPT FAILED: continuing...
=== End ===


Sascha

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE7Ycc2t6Wt6eY1E5VwY9q6IEw7ZcFAmigd5IACgkQwY9q6IEw
7Zel6g/+LrfeNMTBB2hYS+9T/6y+GjCgrvOoUsFsme+a5e7nBiVCOijaCWQeOaiE
tThQjaXBT3aylX16aflzeJo+/NGRy//haDNCJQMyStYT6b8f8U+ciR7ydMPswoWi
ZHfLYDUjy+4rTm7QRSleayviGgyF5gTH2TKiO1hI3T1zGjaQLC7FzvnPkBaIk+TI
ir5vGJbWL3pjeRvxexZrmFJg6Ac8XiHQKZ+ktUUzeFWlYW7sEhzRfclRwGahk+YB
tLa82ONL1quieGSvnPUgQvr7R1nLa2VE4xIcJak/QcEqm/QxX7ym9SdZ27aqb8Ik
dS5up5khr2WaO1hhnv5MiCrxHukg1UDeKckxTNC4f1MhQybvCuvMA6jLYOmvFc9u
xPqjr7AAKxidCfjvl3l3K+TZBgkyccn6p2wQys7X3ifn7PHldXj4Tn6rbc9t4xw2
XoJAkxXMGtmILewBbalUPAylyXp/6gYLVPQX/zBHWwX3HMtc2Lio7461AKGZP03a
vHRsQtHxYOr9SnMdlJDl2P3eqVV6XA9SB7ToJQ1bAJFoGBIqrkNPkafHKpMowXz4
pSh9rPHlzzmFoncmbHgvzx6tEdt8vImAyyYd2E0lh/JGhcBX1NVGR5IqHLzCyokG
hneCS1iukQH9vaR5VcCV887h3kwbiT8PLKDRmfUYR3cbPN3oFMk=
=KXHQ
-----END PGP SIGNATURE-----
--=-=-=--
