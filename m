Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7572E6BF39
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 21:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD548420D;
	Fri, 30 Jan 2026 22:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="H1R6Onjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B0E844F4; Fri, 30 Jan 2026 22:07:46 +0100 (CET)
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50830841E6
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 22:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=vagrant@debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
 Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NL34bRIIpW7ErWeod4yaaTlidVF13wkX8KIDBWNNQxU=; b=H1R6Onjz1V/UfOaMy/b0wLKDUq
 ZyTtzNsNmFuCWv8RimAJwmMoNF7S/xgP4OQFsKWAE3dTCqWfJDAi2a1NwcClseCG1Hj0RHjZXAXPX
 4MwnL1uKRwPr07ruWQJGBpow6D6CsrxnB8caAuqzdRvUMNWQv2o9qFXrR6jwkTBiU1RGWQPpXEUQ7
 bkP1ldus9Sgo/BuaClFY5az5qSWeG9iaHqVPR0t2cT+W5YKEx1Z2njU1Xnyp/F6+x+9IagJO3atVP
 tXMHvphgRNe+dWBLZqyY/kB0WC2a261NkoYJwEDY83FNTz6UkV/TqBEIzq7ATogn498/M36tnYE/9
 3JOHhXRA==;
Received: from authenticated user by stravinsky.debian.org with utf8esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <vagrant@debian.org>)
 id 1vlviR-001zS2-2l; Fri, 30 Jan 2026 21:07:43 +0000
From: Vagrant Cascadian <vagrant@debian.org>
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: Re: rk3588 MNT Reform2 fails to boot from SD card
In-Reply-To: <11f467e2-1059-4edb-81a2-8b970b315882@cherry.de>
References: <87ikcjc1oc.fsf@wireframe>
 <11f467e2-1059-4edb-81a2-8b970b315882@cherry.de>
Date: Fri, 30 Jan 2026 13:07:36 -0800
Message-ID: <87bjiabyhz.fsf@wireframe>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Debian-User: vagrant
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
Content-Transfer-Encoding: quoted-printable

On 2026-01-30, Quentin Schulz wrote:
> On 1/30/26 2:46 AM, Vagrant Cascadian wrote:
>> Thanks for adding support for rk3588 MNT Reform2!
>>=20
>> I tried using u-boot 2026.01 with the rk3588 MNT Reform2, but it only
>> gets as far as SPL, and then fails:
>>=20
>>    U-Boot SPL 2026.01 (Jan 01 1970 - 00:00:01 +0000)
>>    Trying to boot from MMC1
>>    mmc_load_image_raw_sector: mmc block read error
>>    Error: -38
>>    SPL: Unsupported Boot Device!
>>    SPL: failed to boot from all boot devices
>>    ### ERROR ### Please RESET the board ###
>>=20
>> I *think* MMC1 is eMMC, which I currently have blanked, as recovering
>> from a failed install on eMMC is trickier.
>>=20
>
> It's surprising it isn't trying MMC1 twice as that's what it's supposed=20
> to do due to u-boot,spl-boot-order containing "same-as-spl" and the eMMC=
=20
> controller again later in the chain (see the property).
>
> In any case, no support for the SD controller in SPL according to the=20
> defconfig, can you try with:
>
> """
> diff --git a/configs/mnt-reform2-rk3588_defconfig=20
> b/configs/mnt-reform2-rk3588_defconfig
> index 6adc9e4e60c..982e6c6eb20 100644
> --- a/configs/mnt-reform2-rk3588_defconfig
> +++ b/configs/mnt-reform2-rk3588_defconfig
> @@ -50,6 +50,8 @@ CONFIG_MMC_HS400_ES_SUPPORT=3Dy
>   CONFIG_SPL_MMC_HS400_ES_SUPPORT=3Dy
>   CONFIG_MMC_HS400_SUPPORT=3Dy
>   CONFIG_SPL_MMC_HS400_SUPPORT=3Dy
> +CONFIG_MMC_DW=3Dy
> +CONFIG_MMC_DW_ROCKCHIP=3Dy
>   CONFIG_MMC_SDHCI=3Dy
>   CONFIG_MMC_SDHCI_SDMA=3Dy
>   CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> """
>
> and report if it gets you further?

Much further, indeed! With that applied to 2026.04-rc1, I managed to
load the kernel, initrd and dtb from NVMe, and boot all the way to a
rootfs!

With one big downside... no display on linux (eDP? panel, or on
HDMI). Neither upstream u-boot or vendor u-boot provided output on the
display, so that part is not a regression.

I have a slightly older rk3588 module that does not use dsi -> eDP, that
might be an issue... maybe upstream u-boot vs. vendor u-boot is
configuring or not configuring something needed...


> I think you'll be missing support for=20
> the CD gpio as well in SPL.
>
> So probably you need to enable SPL_GPIO:
>
> """
> diff --git a/configs/mnt-reform2-rk3588_defconfig=20
> b/configs/mnt-reform2-rk3588_defconfig
> index 6adc9e4e60c..7485d03a0cb 100644
> --- a/configs/mnt-reform2-rk3588_defconfig
> +++ b/configs/mnt-reform2-rk3588_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=3Dy
>   CONFIG_SKIP_LOWLEVEL_INIT=3Dy
>   CONFIG_COUNTER_FREQUENCY=3D24000000
>   CONFIG_ARCH_ROCKCHIP=3Dy
> +CONFIG_SPL_GPIO=3Dy
>   CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3588-mnt-reform2"
>   CONFIG_ROCKCHIP_RK3588=3Dy
>   CONFIG_SPL_SERIAL=3Dy
> @@ -50,6 +51,8 @@ CONFIG_MMC_HS400_ES_SUPPORT=3Dy
>   CONFIG_SPL_MMC_HS400_ES_SUPPORT=3Dy
>   CONFIG_MMC_HS400_SUPPORT=3Dy
>   CONFIG_SPL_MMC_HS400_SUPPORT=3Dy
> +CONFIG_MMC_DW=3Dy
> +CONFIG_MMC_DW_ROCKCHIP=3Dy
>   CONFIG_MMC_SDHCI=3Dy
>   CONFIG_MMC_SDHCI_SDMA=3Dy
>   CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> """
>
> aaaand also enable it in SPL DT:
>
> """
> diff --git a/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi=20
> b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> new file mode 100644
> index 00000000000..47509f4cb37
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +/* SD CD */
> +&gpio0 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> """
>
> I believe?

Do you think it is worth testing this part as well? Or is booting to
rootfs sufficient to demonstrate it is working?


live well,
  vagrant

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRlgHNhO/zFx+LkXUXcUY/If5cWqgUCaX0dmAAKCRDcUY/If5cW
qqNgAQD9HofGHRk8TyEafB8skPAtQTB2NAUmvL1PR7JhzOaILQEAzBuk5UJWjJrh
Wr+gnROGzpobUdlA7hN7dl7KSYf+UAg=
=Ssly
-----END PGP SIGNATURE-----
--=-=-=--
