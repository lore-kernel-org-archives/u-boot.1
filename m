Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33325E7FDEF
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 21:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93BE683F63;
	Mon,  2 Feb 2026 22:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="mvknE4r/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AC7383F6D; Mon,  2 Feb 2026 22:43:34 +0100 (CET)
Received: from cascadia.aikidev.net (cascadia.aikidev.net
 [IPv6:2600:3c01:e000:267:0:a171:de7:c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E9EC83F59
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 22:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=vagrant@debian.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=debian.org;
 s=1.vagrant.user; t=1770068609;
 bh=9QtmwneOEmQH0e27d6TV7fj/szUzWrmaIuNMWgfYUyU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=mvknE4r/QOo+w0b30OvgNJe8FSRzuPEe73vQNU6kCaoVifjnXhxphIGTDyxxPDqVE
 cGUQRkQhdFzlBZjr3/DI2i2/6D6c9AtnFiIABAVLQFS5SkuFTvshf3I/cXhMV+/VAO
 FQe3Ffi/92a7xiKBzcrLKfgXMBeVEi3Ew+q7MSShgR6HIWp2L46TIcPnE2bAVi4eZN
 18hovQNAFfaB18SK03qUZPj0oTWgwC5VatHfItk+Fk5I8oTcwf5ydEo2NPul/sVD1P
 nwrw8HREKDHOy0nswEa9Re4f1KAjCW5U/lXYJxP34dI9rt77KEAvzaGiV1Ccz2ZQME
 J5/un+Vl2rJhQ==
Received: from localhost (unknown [IPv6:2600:3c01:e000:21:7:77:0:20])
 by cascadia.aikidev.net (Postfix) with UTF8SMTPSA id 1F555D39C;
 Mon,  2 Feb 2026 13:43:29 -0800 (PST)
From: Vagrant Cascadian <vagrant@debian.org>
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: Re: rk3588 MNT Reform2 fails to boot from SD card
In-Reply-To: <cfdccb81-4bc7-4e7b-accd-0524206f4547@cherry.de>
References: <87ikcjc1oc.fsf@wireframe>
 <11f467e2-1059-4edb-81a2-8b970b315882@cherry.de>
 <87bjiabyhz.fsf@wireframe>
 <cfdccb81-4bc7-4e7b-accd-0524206f4547@cherry.de>
Date: Mon, 02 Feb 2026 13:43:20 -0800
Message-ID: <87o6m6lt3b.fsf@contorta>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
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

On 2026-02-02, Quentin Schulz wrote:
> On 1/30/26 10:07 PM, Vagrant Cascadian wrote:
>> On 2026-01-30, Quentin Schulz wrote:
>>> On 1/30/26 2:46 AM, Vagrant Cascadian wrote:
>>>> Thanks for adding support for rk3588 MNT Reform2!
>>>>
>>>> I tried using u-boot 2026.01 with the rk3588 MNT Reform2, but it only
>>>> gets as far as SPL, and then fails:
>>>>
>>>>     U-Boot SPL 2026.01 (Jan 01 1970 - 00:00:01 +0000)
>>>>     Trying to boot from MMC1
>>>>     mmc_load_image_raw_sector: mmc block read error
>>>>     Error: -38
>>>>     SPL: Unsupported Boot Device!
>>>>     SPL: failed to boot from all boot devices
>>>>     ### ERROR ### Please RESET the board ###
>>>>
>>>> I *think* MMC1 is eMMC, which I currently have blanked, as recovering
>>>> from a failed install on eMMC is trickier.
>>>>
>>>
>>> It's surprising it isn't trying MMC1 twice as that's what it's supposed
>>> to do due to u-boot,spl-boot-order containing "same-as-spl" and the eMMC
>>> controller again later in the chain (see the property).
>>>
>>> In any case, no support for the SD controller in SPL according to the
>>> defconfig, can you try with:
>>>
>>> """
>>> diff --git a/configs/mnt-reform2-rk3588_defconfig
>>> b/configs/mnt-reform2-rk3588_defconfig
>>> index 6adc9e4e60c..982e6c6eb20 100644
>>> --- a/configs/mnt-reform2-rk3588_defconfig
>>> +++ b/configs/mnt-reform2-rk3588_defconfig
...
>>> +CONFIG_MMC_DW=3Dy
>>> +CONFIG_MMC_DW_ROCKCHIP=3Dy
...
>>> and report if it gets you further?
>>=20
>> Much further, indeed! With that applied to 2026.04-rc1, I managed to
>> load the kernel, initrd and dtb from NVMe, and boot all the way to a
>> rootfs!
>>=20
>
> Good to hear!
>
>> With one big downside... no display on linux (eDP? panel, or on
>> HDMI). Neither upstream u-boot or vendor u-boot provided output on the
>> display, so that part is not a regression.
>>=20
>> I have a slightly older rk3588 module that does not use dsi -> eDP, that
>> might be an issue... maybe upstream u-boot vs. vendor u-boot is
>> configuring or not configuring something needed...
>>=20
>
> We should have HDMI support for RK3588 for a few releases in Linux=20
> already. It works on RK3588 Tiger and Jaguar last time I checked. Maybe=20
> missing/disabled DT nodes for your module, or drivers not=20
> selected/installed.
>
> There should be eDP support as well, we use those lanes on RK3588 Tiger=20
> Displayport carrier which uses eDP for the DP connector. I tested that=20
> with=20
> https://lore.kernel.org/linux-rockchip/20251009225050.88192-1-heiko@sntec=
h.de/=20
> so maybe missing DT nodes for either the eDP controller or the panel for=
=20
> your board?

Oh, the linux kernel definitely works; with a vendor u-boot both eDP
panel and HDMI output work, it is only when booted from upstream u-boot
that I do not get display output in linux.

Unless there is some kernel configuration required when booting from
upstream u-boot that are not required with the vendor u-boot, but my
hunch is there is something just not getting configured (or getting
configured incorrectly or just differently) in u-boot.


>>> I think you'll be missing support for
>>> the CD gpio as well in SPL.
>>>
>>> So probably you need to enable SPL_GPIO:
>>>
>>> """
>>> diff --git a/configs/mnt-reform2-rk3588_defconfig
>>> b/configs/mnt-reform2-rk3588_defconfig
>>> index 6adc9e4e60c..7485d03a0cb 100644
>>> --- a/configs/mnt-reform2-rk3588_defconfig
>>> +++ b/configs/mnt-reform2-rk3588_defconfig
>>> +CONFIG_SPL_GPIO=3Dy
...
>>> +CONFIG_MMC_DW=3Dy
>>> +CONFIG_MMC_DW_ROCKCHIP=3Dy
...
>>> aaaand also enable it in SPL DT:
>>>
>>> """
>>> diff --git a/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
>>> b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
>>> new file mode 100644
>>> index 00000000000..47509f4cb37
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
>>> @@ -0,0 +1,9 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +
>>> +#include "rk3588-u-boot.dtsi"
>>> +
>>> +/* SD CD */
>>> +&gpio0 {
>>> +	bootph-pre-ram;
>>> +	bootph-some-ram;
>>> +};
>>> """
>>>
>>> I believe?
>>=20
>> Do you think it is worth testing this part as well? Or is booting to
>
> Likely yes.
>
> Can you test having U-Boot TPL+SPL (idbloader.img) on eMMC (block offset=
=20
> 64, 32KiB), but not U-Boot proper. Have U-Boot proper (u-boot.itb) on SD=
=20
> card (block offset 16384, 8MiB).
>
> U-Boot should boot from eMMC first and then fallback to SD card next.
>
> You can also try the opposite to verify this is properly setup as well.

Before messing with eMMC, I will have to dig up how to successfully
recover from if u-boot on the eMMC is good enough to load, but not
actually work...

At least with some rockchip boards in the past this involved shorting
pads on the motherboard at just the right timing, which was, let us say,
not very fun. :)

Hopefully this is a little easier with the mnt/reform! :)


> The BootROM initializes various controllers such that if U-Boot doesn't=20
> need to use another storage controller in SPL (or in proper=20
> pre-relocation) it'll likely reach U-Boot proper (and Linux) just fine.
>
> You can have this split in two commits. One to make it possible to boot=20
> from SD card, another one for supporting fallbacks.

Sure, will see once I have a better idea how to recover from unfortunate
surprises. :)


live well,
  vagrant

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRlgHNhO/zFx+LkXUXcUY/If5cWqgUCaYEaeQAKCRDcUY/If5cW
qnL9AQCEPzVJYbR4BZuXvAzq+6cw2eGWvBfewDmyLNA5UxeA6wD+KAYcMcTSXrWQ
0UaM1yBffM2rNzxYRBXuvV7v32q4eQs=
=3P1E
-----END PGP SIGNATURE-----
--=-=-=--
