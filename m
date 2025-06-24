Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BB0C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 11:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BFE182C84;
	Tue, 24 Jun 2025 13:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="ZNuUfgu9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F8C82D83; Tue, 24 Jun 2025 13:47:01 +0200 (CEST)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B126882C4C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 13:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=8Wbd3CcN3r/ZBeuLb3Ai8KSdXlvTMQ1mRuGP6zGev7E=;
 b=ZNuUfgu91RGyiG1dmn8v2WaADjXsXUb5OmLdBImFf0PP6XSNGZ3gHRO+qrp1+CjbCzD6jMP4AdwAG+Gh8N2Cmp6N1h+RPKJyeq3Hd54mu5FmrcFn5CrmgT2QQM49UhMl/pxPh4W2gHdIEpVpYN/V9xGWhuDdmZ3AwUb0RXwOGng=
Received: from lukas-hpz440workstation.localnet (cm70-231.liwest.at
 [212.241.70.231]) by mail.netcube.li with ESMTPSA
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
 ; Tue, 24 Jun 2025 13:46:52 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/2] sunxi: Add NetCube Systems Kumquat support and fix
 nvmem MAC handling
Date: Tue, 24 Jun 2025 13:46:51 +0200
Message-ID: <2787254.mvXUDI8C0e@lukas-hpz440workstation>
In-Reply-To: <20250610053856.1873969-1-lukas.schmid@netcube.li>
References: <20250610053856.1873969-1-lukas.schmid@netcube.li>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12690550.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart12690550.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Lukas Schmid <lukas.schmid@netcube.li>
Cc: u-boot@lists.denx.de
Date: Tue, 24 Jun 2025 13:46:51 +0200
Message-ID: <2787254.mvXUDI8C0e@lukas-hpz440workstation>
In-Reply-To: <20250610053856.1873969-1-lukas.schmid@netcube.li>
References: <20250610053856.1873969-1-lukas.schmid@netcube.li>
MIME-Version: 1.0

On Dienstag, 10. Juni 2025 07:38:53 CEST Lukas Schmid wrote:
> Changes in v2:
>   - Renamed the defconfig to match "maker-model" style
>   - Use the default env offset and size
>   - Disable redundant env to have U-Boot and env fit into first MB of
>     SPI-Flash
>   - Remove unused config options (SPI_BOOT, CMD_RTC, SPI_FLASH_BAR,
>     USB_ETHER_...)
>   - Update mtdparts layout to reflect new environment layout
> 
> This series adds a defconfig for the NetCube Systems Kumquat and fixes
> and issue with setup_environment ignoring the mac-address loaded using
> nvmem-cells
> 
> Note: This series is based on U-Boot's `next` branch because it depends
> on the `sun8i-v3s-netcube-kumquat.dts` device tree, which was recently
> synced from upstream Linux and is not yet available in `master`.
> 
> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> ---
> Lukas Schmid (2):
>   sunxi: setup_environment: do not generate a MAC address when one is
>     set using nvmem-cells
>   configs: add support for NetCube Systems Kumquat
> 
>  board/sunxi/board.c               | 15 ++++++++++-
>  configs/netcube_kumquat_defconfig | 45 +++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100644 configs/netcube_kumquat_defconfig

Hi Andre,

Just following up on this v2 series sent on June 10th. It's marked as "New" in 
Patchwork and assigned to you, so just checking if it's still on your radar.

Happy to address any further feedback if needed.

Thanks again for your time!

Best,
Lukas
--nextPart12690550.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEPv6dcBmn59ssZMkSJnN+drMVRtgFAmhakCsACgkQJnN+drMV
RthEtwf/cIGdkjfK9IM4DiBKbFRCxlrhOuiqwpSnbxgf8xS1Fbs4VrZUZwNUnCaw
UxsNhAnOT1e6LsF7ui2fpkTLhPtJPKAfqI9ieqzffuU7t9YJgzNbuL72p3MuVRgA
pt2f1S+WyNcPJOdE5w3KMWy6cLkIV7qS+LBg5ZVrE0FrWkGGkGazv9lQ1sF516Vv
/it+frdhqfb6HBHjt+vFwtFa42Qiuugms1O/655Hh2g5wjwIKRbAkJLdPZvPsSwX
if1VZHg0JziWrmBNTUQ0aeAxaMML+4YRszZK6gCHD1nG3e+ImMbQPe0/EzmKG+aS
zHodBSSbMTRJYJ6Cb5wITsFkrlehbA==
=/I4f
-----END PGP SIGNATURE-----

--nextPart12690550.O9o76ZdvQC--




