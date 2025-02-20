Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE49CC021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 15:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159238001F;
	Thu, 20 Feb 2025 16:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17B1880077; Thu, 20 Feb 2025 16:22:44 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D6EA80017
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 16:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.98) (envelope-from <daniel@makrotopia.org>)
 id 1tl8Nj-000000003c6-4BKk; Thu, 20 Feb 2025 15:22:32 +0000
Date: Thu, 20 Feb 2025 15:22:29 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <foss+dt@0leil.net>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Heiko Stuebner <heiko@sntech.de>, devicetree-spec@vger.kernel.org
Subject: Re: [PATCH] Add 'bootsource' /chosen property
Message-ID: <Z7dItf07omjuTm0U@makrotopia.org>
References: <20250205-bootsource-v1-1-95f4ba69ac27@cherry.de>
 <CAFLszThr_vLbhU7A0_0VTLCGW03k6NmtxLVoW7OzrtxGFertZg@mail.gmail.com>
 <fb6792e8-97c5-4d0e-8ded-e73ea3a7513c@cherry.de>
 <CAFLszTg9-jMk0PBBSEVT=FonzRUNJOQ5NBMdDYUihWS8NkMhbQ@mail.gmail.com>
 <fc2c6f06-98d9-49d3-9ce5-46dd675e8846@cherry.de>
 <5E98D444-A005-42CD-8A6A-381791237A6E@makrotopia.org>
 <07eb10ff-2791-420d-a302-a2e8c308b468@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07eb10ff-2791-420d-a302-a2e8c308b468@cherry.de>
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

On Thu, Feb 20, 2025 at 04:04:27PM +0100, Quentin Schulz wrote:
> Hi Daniel,
> 
> On 2/15/25 4:13 PM, Daniel Golle wrote:
> > Hi Quentin,
> > 
> > On 10 February 2025 16:25:23 UTC, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > [...]
> > > What I can say from glancing at the code is that for Rockchip they do the following:
> > > 
> > > Register a bootsource type (e.g. MMC, SPI, I2C, USB, etc...), a bootsource instance of that type (e.g. MMC0, SPI3, I2C7, ...). The mapping between what the ROM says the device is vs what it is in the DT is done in their Barebox-specific DT via this custom prop in /chosen:
> > > 
> > > barebox,bootsource-<bootsourcetype><bootsourceinstance> = &label;  # à-la /aliases
> > > 
> > > This gets read and resolved and then inserted as
> > > 
> > > /chosen/bootsource = "/some/path"
> > > 
> > > into the kernel DT.
> > 
> > We are doing something quite similar downsream at openwrt.org for MediaTek router SoCs, see for example:
> > 
> > https://github.com/openwrt/openwrt/blob/main/package/boot/uboot-mediatek/patches/310-mt7988-select-rootdisk.patch
> > 
> > https://github.com/openwrt/openwrt/blob/main/target/linux/mediatek/files-6.6/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi#L32
> > 
> > https://github.com/openwrt/openwrt/blob/main/target/linux/mediatek/files-6.6/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-emmc.dtso#L60
> > 
> > 
> > Of course we could use the standard "bootsource" property instead, but having a way to reference the volume or partition used as rootfs instead of just passing a referencd to a physical device is advantagous...
> > 
> 
> If I understood correctly, your prebuilt DT would have
> 
> / {
>     chosen {
>         rootdisk-emmc = <&rootfs_in_emmc>;
>         rootdisk-nor = <&rootfs_in_nor>;
>         rootdisk-sd = <&rootfs_in_sd>;
>         rootdisk-spim-nand = <&rootfs_in_ubi>;
>     };
> };
> 
> and then at runtime you would populate /chosen/rootdisk property with the
> "rootdisk-<medium>" string with <medium> matching whatever the BootROM
> reports. I assume the goal is to somehow make sure that the rootfs is loaded
> from the same storage medium as the one used by the BootROM to load the
> first stage bootloader?
> 
> Can you confirm I did get that right?

Yes, that's more or less correct. It's to point Linux to the device or
partition of the uImage from which U-Boot has loaded the Linux kernel.

Note that for OpenWrt we prefer to store the uImage.FIT inside a raw
block or flash partition, or UBI volume, rather than as a file inside a
filesystem.

This information is then used for two things:

 - Mount the root filesystem
   We use a read-only squashfs which is part of the uImage.FIT, it essentially
   has the same purpose of an initramfs on other distributions, but mounting
   squashfs is much faster then decompressing the whole initramfs at once, and
   it doesn't need to remain in RAM permanently.

 - Know where an updated uImage.FIT should be written to.

> 
> I was specifically NOT aiming /chosen/bootsource to represent the storage
> medium used to load the kernel or rootfs, but rather the medium that was
> used by the BootROM to load the first stage of the bootloader that is
> user-flashable/uploadable.
> 
> You could very well decide to load/mount your rootfs from SD even if the
> BootROM loaded the first stage bootloader from SPI-NOR. This property is
> about representing the latter, not the former and not merging the meaning of
> both into one.

Of course, especially for general purpose Linux which would not fit into
NOR flash that's the only option.

In case of OpenWrt we usually do want to load kernel (and rootfs) from
the same device also used by the BootROM for booting. OpenWrt can easily
fit onto 16 MiB of NOR flash, including bootloader, EEPROM for MAC
addresses and WiFi calibration as well as some megabytes for user data.

To satisfy both needs, I reckon we would need to formally introduce an
OpenWrt boot-method to U-Boot, and then U-Boot could leave a mark in
/chosen where the uImage.FIT was loaded from, independently of the
BootROM which may differ?

> 
> However, I could see a BootROM being able to report from which partition and
> controller it loaded the first stage bootloader, and then it'd make sense to
> have that in /chosen, either as part of /chosen/bootsource or an additional
> property like /chosen/bootsource-partition.

That definitely makes sense too.
