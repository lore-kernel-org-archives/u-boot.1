Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21032E67480
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 21:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13DDC88B55;
	Thu, 31 Oct 2024 22:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="hUbsWkyY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B67B5889EF; Thu, 31 Oct 2024 22:16:45 +0100 (CET)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF16488E94
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 22:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730409400; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ff7pSG4Cn1YBE424HALHD9/tTv4dgcXcZBta/PVcS4el0O/7pxvHE/aj7f7ChkQonQpc9dwlk5vwsU+GvMoIXsyhQoe/KRRZolcezFrwFMfk6QuMmyyfayISkPZ43bNr2ARmUzZQO+MNk2SoJwwPNEFxxYyeK20KZCpP7oezSx4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730409400;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=diBqMmrGNTQqPs3HdJpukIKxZeFg+VHUfhwzPZ0znC8=; 
 b=fVLVjfT3y+E2vJ9Gek9VDYfxJ5tEa2huegZQGi4ZVL0FWIWDrTlu6TReu8O2gfb1EA8ZL1eGk7F/jmDH9upzfn3J7rqI9EB3uK6buNSQ30A+wQ6fED1iyVHgxjw+PbmOK4lirrzA3KR/VjJQcxq5hxWLLSg2xOPrXxnF+3fshM4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730409400; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=diBqMmrGNTQqPs3HdJpukIKxZeFg+VHUfhwzPZ0znC8=;
 b=hUbsWkyYJIQ0qLocsGleKuaBpR1hVqizvWWEWo34Dxl6SnhuJ3xZkutG7I3y4aYP
 bu7lFInzLpL0Rbzwk5jgSTOe+99iu3F6bKzDj6Qk5PeEaeJJGRCssranjW2vbOynFaB
 fFQSOcO0dsEPn/oZxIkvoUjymZSvV9QXLsFBPMzE=
Received: by mx.zohomail.com with SMTPS id 1730409398632806.5258640940649;
 Thu, 31 Oct 2024 14:16:38 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
 id 5C3E410604AC; Thu, 31 Oct 2024 22:16:34 +0100 (CET)
Date: Thu, 31 Oct 2024 22:16:34 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, u-boot@lists.denx.de, 
 Kever Yang <kever.yang@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v1 1/1] rockchip: rock5b-rk3588: Enable automatic PCI
 enumeration
Message-ID: <d2ri4jalkbd2vxpubsbypv35wjpfj4dc25bicxkju45r4awap3@iyzh45ejli2f>
References: <20241031180212.116330-1-sebastian.reichel@collabora.com>
 <e457b630-bd7d-4f7d-bd4e-20f0e3fbc9a2@linaro.org>
 <1d28e59e-9e92-4570-960c-ed642731a226@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6ycazhcyre5n5xno"
Content-Disposition: inline
In-Reply-To: <1d28e59e-9e92-4570-960c-ed642731a226@kwiboo.se>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/230.358.61
X-ZohoMailClient: External
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


--6ycazhcyre5n5xno
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/1] rockchip: rock5b-rk3588: Enable automatic PCI
 enumeration
MIME-Version: 1.0

Hi,

On Thu, Oct 31, 2024 at 08:17:32PM +0100, Jonas Karlman wrote:
> On 2024-10-31 19:15, Eugen Hristev wrote:
> > On 10/31/24 20:01, Sebastian Reichel wrote:
> >> PCI enumeration is required to detect the onboard Ethernet device.
> >>
> >> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >> ---
> >>   configs/rock5b-rk3588_defconfig | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_d=
efconfig
> >> index c54e13e8732c..e5b9f7d326b4 100644
> >> --- a/configs/rock5b-rk3588_defconfig
> >> +++ b/configs/rock5b-rk3588_defconfig
> >> @@ -17,6 +17,7 @@ CONFIG_DEBUG_UART_CLOCK=3D24000000
> >>   CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
> >>   CONFIG_SPL_SPI=3Dy
> >>   CONFIG_PCI=3Dy
> >> +CONFIG_PCI_INIT_R=3Dy
> >>   CONFIG_DEBUG_UART=3Dy
> >>   CONFIG_AHCI=3Dy
> >>   CONFIG_FIT=3Dy
> >=20
> > This has been added and removed before, please see
> >=20
> > https://lore.kernel.org/all/20231104130451.111020-1-martin.roukala@mupu=
f.org/T/
> >=20
> > this commit adds it
> > 5b269ed404dc ("configs: rockchip: rock5b-rk3588: Enable CONFIG_PCI_INIT=
_R")
> >=20
> > this commit removes it again
> > 191ece249a96 ("rockchip: rk3588-rock-5b: Enable support for PCIe SATA=
=20
> > cards")

Ah, I should have checked the history. Sorry.

> What use-case are you trying to solve with a forced pci enumeration?
>=20
> With standard boot Ethernet should be enabled when it is needed.
>=20
> However for EFI boot Ethernet maybe is not detected? Please see [1] for
> a possible alternative patch that I created when someone reported an
> issue with iPXE boot some time ago.
>=20
> I did not get confirmation it fully solved the issue, from what I could
> test it should help get Ethernet detected during EFI boot on a ROCK 5B.
>=20
> [1] https://github.com/Kwiboo/u-boot-rockchip/commit/90b6d787de0b3e6ed863=
440be576b01d83ba5789

LAVA by default has a U-Boot script doing the following (IIUIC across all
boards), which fails with the current setup:

setenv autoload no
setenv initrd_high 0xffffffff
setenv fdt_high 0xffffffff
dhcp
setenv serverip 192.168.201.1
tftp 0x0400000 16212093/tftp-deploy-or30pzbe/kernel/vmlinuz
tftp 0xa200000 16212093/tftp-deploy-or30pzbe/ramdisk/ramdisk.cpio.gz.uboot
setenv initrd_size ${filesize}
tftp 0xa100000 16212093/tftp-deploy-or30pzbe/dtb/rk3588-rock-5b.dtb
setenv bootargs 'console=3DttyS2,1500000n8 root=3D/dev/nfs rw nfsroot=3D192=
=2E168.201.1:/var/lib/lava/dispatcher/tmp/16212093/extract-nfsrootfs-e0aw1q=
lf,tcp,hard,v3 rootwait ip=3Ddhcp'
booti 0x0400000 0xa200000 0xa100000

Basically it comes down to missing network support when breaking
into the U-Boot shell. Also while it is obvious one needs to
enumerate the PCI bus for U-Boot developers with knowledge about
the Rock 5B, it's unexpected for people with less knowledge. So I
think it's sensible to have a default configuration supporting
network in the U-Boot shell without extra steps.

-- Sebastian

--6ycazhcyre5n5xno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmcj86cACgkQ2O7X88g7
+po8VRAAnAGwD1qN1F8Lm+XNjfHcMQSEyZUQZnO4A87s/xMYcQS7QE1zW0XJMiQ6
kEjfp/uZ4bwJHHJYJ3ipKH2/A/phXmg6s5cf7uC/0DckYOq4PwuNe+az/FJu9mcs
oWPMo4PalZQ8bfzP/+tB2hZFrU24rtG72fZNWB7dGYNj1nIKY+70id14kZojr6/R
r0wUH96NvSESltEE5GkNmkPh4/RcfwEBEGGphmsBFwEafyacbdVgS5CKW8smw1bK
8gmZpY8AgX4bEd3QMCeAPj/T6qZdkTYU0cxchH6LhbwP0oWxgqmqunfBPe+5f6/W
WXlgFCAKxxtSF38YavxI5/SsRGui636I4x23HjfuNXc7PkKu7f/IQthH7CyxGbVQ
qujp4vyTemBtQPi6BtRwTJx6UvTYkX5eOYN8BaMYes+LyuE38FB8ksfLanlqBOd2
xyfHusx9UREpCfCyUOTrVObVxIzq1mJcYkYNWoPehKhujaggmPlIIRZQxxtFiFq8
r9hi8eBiV+aYgKFAUOoHLiwkN3jyylSMhgLY48NGq0wIdtKhA+KBkkWbtOjUBSE0
H7z5WQQQ3cqx20VWIs4xB/Ld/lNQrPya5cY826VtUtRKriRrlWks+LI1xy4ScLRf
lzoh6998codhdhOTFlBkIOR5xNd85zhAC2g3l4wDvyi1GQRrpWI=
=UHkY
-----END PGP SIGNATURE-----

--6ycazhcyre5n5xno--
