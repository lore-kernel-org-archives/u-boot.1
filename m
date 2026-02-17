Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F227CE81A32
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 13:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF3E83CF2;
	Tue, 17 Feb 2026 14:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VpTkDUKP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D149F83D17; Tue, 17 Feb 2026 14:32:27 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 379DA80325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 14:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65a26c220b6so5552472a12.0
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 05:32:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771335145; cv=none;
 d=google.com; s=arc-20240605;
 b=TC8Rxw12E865w4YwtTAoIM2QrLjujs9GTCdU0DLHjNMjHXEectOtGI/dzhTXIQ2oVv
 2Jg2iID1FTJB3L3bTT+fnJExGYEbOz0ToB/8ndg1UwejgZUeXoEIRePV/1KhlGsd2GMf
 n6pxWb9CxlMOcmlg34c7LgtNNw+PjhVjAP49LRgJFl386HFvOjxc+uOMqgc2xCUqv8pR
 8IxzI3ly9/Q0CDQCPNirq9DWH/VKpggbEy2CxclkymwtqXtYdh7L3kcxck7XA2LgGbEf
 oUw9bu7A4/QvzYxPeQMHRQq/hnLLs7gXLNgy33jroRnEi4hp9FhIoYhPwxIRCoFSPBfU
 1nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qCI8k7IqqbpwkNtNA0BQisI7vEwI5VDVp2RasfWYy+o=;
 fh=CU3xVSX3QIAqx361ReMgl8Rmj52cz4WgiYdJgW/4Rfo=;
 b=PlmAWDqM6HGY/XSYdgNdAptid626NKSG0bZvFQRzXaBjhULDgFHNdtTCMRqQ4FCB01
 gi3hZePMqHf0fYsrjEucHUnBXK4KEsXjiU3NH3Wb5bVNnPHlNj78YkKHDB9Jt/hV3Jov
 FDHug+oqRMXhDDKuO0nGQg+jOdtOE3tP9SpWV3NUCSuhxC4WKWK4hJpUHXWDQTBW8VIA
 saZfdXkWFH4iwaMK7/jgl9V9ywmet35dN49KOWrmCi6qOPCCTqATXLFOwX3whuiSjLfu
 9NpVCkVC2RlNlYXLlPmJLzdo3XDrHSHbBnaObJzxDCjpQFRgUndiPv2r63agt8W7c8As
 aqvQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771335145; x=1771939945; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qCI8k7IqqbpwkNtNA0BQisI7vEwI5VDVp2RasfWYy+o=;
 b=VpTkDUKPj9HZxORAIe16hYhK3Xg3KvNXGV8V4RrJNw103uDFprYJgdKHTeUFCoZAXq
 uEoYh4FGG7SlyNBZLAg/+cfKuX7kMgtzWSrRFDjM2ek21Y2rhbDtosoFBhfram2Z6mcz
 CReCSzrouEr9IA3dU9joDeEVxTvYrXELPLq58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771335145; x=1771939945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qCI8k7IqqbpwkNtNA0BQisI7vEwI5VDVp2RasfWYy+o=;
 b=kvkX9BLP8B30cbwkuLGLdrtGe95+5NSRolqziYquccSxrY8nV9QGW07lc0L24GitJ8
 5LafMhKDO914fWlv5WntmaFZs24Ly9GT7l9ttoROs5WePT4tjt9dgH9tIHORJth5w21D
 tzZnJE9fAgx/fbbVv7ENLvDux1dF9VbEdYECMiag3/ChWmLd+YAxy12VMGJpsDzh/XEa
 oHkXbHNZEziW0vGwctyYLN0L0OUX9zUZqesHJHEMtAuC5pJPQ40TDbK01bAqYS3Uxx3L
 wCsH6D6q58qhi2PqFn+WVvqKTVCpMLUcSYissxesfmLEKkcqXfhTLZCowRsatfIOst6s
 BoZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXdqP+hAgnUHiGRYyaqFqFbAvU6AGLwJMrMc47DYab2S6u4zXQrs4Kutb3JibBQB2/oNh4v/k=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7f1+/MMVke93b4m7QIrjV+zXYn8pTwZkSQ6kx+qGDxNBConYQ
 AbZ5CfeSOUqxtlqI9BWQRYsOfCjgUxxihtVShfPOjcCCshM6BvT9fkiB6++CVeOLGCviPjOk57p
 H352X3sIdxc/FVE6ILFk+obzDRxUNWUV6CVH3vszK
X-Gm-Gg: AZuq6aJVgXuC/5SVyWOCVM3XvOmBjuTdwXoZ5CaJdrVEqkNPvICh41MHr+wltx/+Sv2
 g9dfDqyBPYf5oyjx2HlOwqdxGbjceARZ9xBauXzVPlrgUf9Zd0KJ8nhUA+NpqFDlJTeNfnbkK21
 HmGrAyinpP+jiVjSP1vkIIP7GhwmFLsApmVcOGlng3961DEF31rAGesLwFDuC8KOqIS0W8VfHW0
 ViyPaKtAqN8qEfA1CJ0Tqhc6URYjQ3TdXT2mprk+YfVmIstDOe/21Fazt2NXGnRPdiwHXydiv6h
 lGH07w==
X-Received: by 2002:a05:6402:26cb:b0:65c:b21:2dee with SMTP id
 4fb4d7f45d1cf-65c0b21309bmr3707479a12.4.1771335144353; Tue, 17 Feb 2026
 05:32:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Feb 2026 06:32:12 -0700
X-Gm-Features: AaiRm52Om92nZmv43277wDIN1otE0Vk2OW5KS-KVws2mkGUMWoLvAaYVW-6-x18
Message-ID: <CAFLszThPZtfOmRvJ1mi8eyYqNRYZ4EvcuMYmkHGLDptXHS9yVw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand FIT
 loading
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Daniel,

On Mon, 16 Feb 2026 at 14:21, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Hi all,
>
> This RFC series adds a new boot method for OpenWrt's "uImage.FIT with
> embedded rootfs" firmware model, along with the underlying infrastructure
> to load FIT images on-demand directly from storage devices without copyin=
g
> them entirely to RAM first.
>
> I would like to discuss the design with U-Boot maintainers and fellow
> OpenWrt developers before submitting a formal patch series.
>
> Background: Why OpenWrt needs its own boot method
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> OpenWrt's modern embedded boot model uses a single uImage.FIT container
> that includes the Linux kernel, device tree, and a read-only root
> filesystem (squashfs or more recently erofs).
>
> At boot, the kernel maps the embedded squashfs directly from flash as a
> block device (/dev/fit0 via the fitblk driver[1]). No separate boot
> partition, boot filesystem, or initrd is required.
>
> This creates a monolithic, deterministic, flash-native firmware image tha=
t
> is fundamentally different from what U-Boot's existing boot methods
> (distroboot, EFI, extlinux) are designed for. Those methods assume:
>
>   - A partition table with a boot filesystem (FAT ESP, ext4 /boot)
>   - Kernel and initrd as separate files on that filesystem
>   - Mutable boot state managed by filesystem metadata
>   - Multi-OS flexibility on replaceable storage
>
> OpenWrt's model assumes:
>
>   - A single-flash embedded appliance with no removable storage
>   - One immutable firmware blob per slot
>   - No boot filesystem at all
>   - Boot-medium agnostic deployment (the same .itb image works on eMMC,
>     SD, SPI-NOR, SPI-NAND/UBI, and raw NAND)
>
> [1]: https://github.com/openwrt/openwrt/blob/30ac12f4b4682207c5b0501b3ffc=
50d56f58b690/target/linux/generic/pending-6.12/510-block-add-uImage.FIT-sub=
image-block-driver.patch
>
> One image for all use cases
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> The same .itb image can be:
>
>   - Used as a sysupgrade image inside a running OpenWrt system
>   - Flashed from U-Boot via TFTP or HTTP
>   - Written to an eMMC or SD partition via dd
>   - Stored in a UBI volume (SPI-NAND, raw NAND)
>   - Stored in a raw MTD partition (SPI-NOR, parallel NOR)
>
> It is entirely boot-medium agnostic. UEFI and distroboot by contrast
> assume a block-oriented storage device with a specific partition layout
> and boot filesystem, and cannot easily be used on raw flash devices or
> UBI.
>
> Why boot filesystems are a problem for embedded
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Boot filesystems (FAT ESPs, ext4 /boot) introduce:
>
>   - Metadata corruption risks on power loss
>   - fsck requirements after unclean shutdown
>   - State drift across firmware upgrades
>   - A structural single point of failure
>
> These are not theoretical concerns. OpenWrt is deployed in telecom
> infrastructure, industrial control systems, and ISP CPE devices =E2=80=94
> environments where thousands (sometimes millions) of devices must boot
> and receive software updates reliably for years without physical
> access. A corrupted FAT partition on a rooftop wireless backhaul
> device can mean a truck roll, in a private home often means scheduling
> a costly visit by the ISPs service team.
>
> The FIT-with-rootfs model eliminates this entire failure class:
>
>   - No filesystem metadata to corrupt
>   - No fsck needed after power loss
>   - No mutable boot artifacts
>   - Bit-identical system partitions across the entire fleet
>
> This is critical for QA reproducibility, telecom deployments, and any
> fleet where deterministic firmware state is a hard requirement.
>
> Reduced failure surface
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> A typical UEFI / distroboot path:
>
>   Bootloader -> Filesystem driver -> Directory traversal -> File read
>   -> Kernel -> Initrd -> Pivot to rootfs
>
> The OpenWrt uImage.FIT path:
>
>   Bootloader -> Read FIT blob from partition -> Kernel
>   -> squashfs/erofs rootfs mapped from same blob
>
> Fewer parsing stages mean fewer corruption vectors and lower boot-path
> complexity. The boot chain is shorter and each step is simpler.
>
> Secure boot friendly
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> FIT natively supports cryptographic signatures and verified boot chains.
> Because kernel, DTB, and rootfs are inside the same signed container,
> they are verified together =E2=80=94 no unsigned kernel swapping, no mism=
atched
> kernel/rootfs pairs. This is structurally cleaner than verifying
> separate files scattered across a boot filesystem.
>
> Real-world adoption
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This boot method is not a theoretical proposal =E2=80=94 it is already th=
e
> standard production boot method for a large number of shipping devices.
>
> In OpenWrt's MediaTek Filogic target alone, over 40 boards use
> fit_do_upgrade() for their primary firmware upgrade path. See
> target/linux/mediatek/filogic/base-files/lib/upgrade/platform.sh in
> openwrt.git for the full list.
>
> Beyond MediaTek, the SiFlower SF21-based BananaPi BPi-RV2 (NAND) also
> uses this exact method. Countless additional boards use minor variations,
> for example, appending the squashfs blob after the uImage.FIT container
> instead of using an IH_TYPE_FILESYSTEM uImage.FIT sub-image.
>
> Production / recovery architecture
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The slot configuration in this series supports:
>
>   - A production FIT image
>   - A recovery FIT image
>   - Separate persistent data partition
>
> Recovery can reflash production remotely and preserve configuration.
> This dual-slot model =E2=80=94 which Android eventually adopted for simil=
ar
> embedded constraints =E2=80=94 is a natural fit for the OpenWrt deploymen=
t
> model.
>
> Why existing boot methods cannot be reused
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1. distroboot / extlinux: Require a boot filesystem containing
>    extlinux.conf. OpenWrt avoids using a boot filesystem.
>
> 2. EFI: Requires an EFI System Partition with a PE binary. OpenWrt's
>    firmware is a flat FIT blob, not an EFI application. EFI also mandates
>    booting from a block-oriented storage device or PXE, while devices
>    supported by OpenWrt often come with SPI-NAND or SPI-NOR flash,
>    sometimes as little as 32 MiB in total.
>
> 3. script-based sf_bootdev: Reads a boot script from a fixed offset in
>    SPI flash. It does not understand partitions, does not iterate MTD
>    or UBI devices, and does not support FIT image detection.
>
> 4. On-demand loading: None of the existing methods support loading FIT
>    subimages directly from storage. OpenWrt's FIT images typically
>    contain a 5-20 MB squashfs that does NOT need to be copied to RAM =E2=
=80=94
>    the kernel maps it directly from flash. The bootloader only needs
>    to load the kernel and DTB (~5-10 MB), not the entire 20-50 MB
>    container. This requires a new loading abstraction.
>
> What this series adds
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The series is structured in two logical parts:
>
> Part 1: On-demand FIT loading infrastructure (patches 1-12)
> -----------------------------------------------------------
>
> A new image_loader abstraction that provides a read callback for loading
> data from storage on demand, rather than requiring the entire image to
> reside in RAM. This is wired into fit_image_load() so that bootm can
> load individual FIT subimages directly from block devices, MTD
> partitions, or UBI volumes.
>
> Three storage backends:
>
>   - Block device (eMMC, SD, SATA, NVMe, USB mass storage, virtio)
>   - MTD (SPI-NOR, raw NOR, raw NAND with bad block skipping)
>   - UBI volume (SPI-NAND, raw NAND)
>
> The "bootm" command is extended to accept a storage device specification
> instead of a RAM address:
>
>   bootm mmc 0:4         # boot FIT from eMMC partition 4
>   bootm mtd recovery    # boot FIT from MTD partition "recovery"
>   bootm ubi recovery    # boot FIT from UBI volume "recovery"
>
> This infrastructure is independently useful beyond the OpenWrt boot
> method. Any board that stores a FIT image directly in a partition
> (rather than as a file on a filesystem) can benefit from on-demand
> subimage loading.
>
> Part 2: OpenWrt boot method and bootdevs (patches 13-20)
> ---------------------------------------------------------
>
> A proper bootstd boot method (bootmeth_openwrt) that:
>
>   - Scans block device partitions, MTD partitions, and UBI volumes
>     for raw FIT images (detected by fdt_check_header on the first bytes)
>   - Boots via the image_loader / bootm storage path
>   - Supports configurable dual-slot boot (production + recovery) via
>     environment variables
>   - Provides a script hook (openwrt_boot_script) for boards that need
>     to probe hardware before selecting the FIT configuration
>
> Two new boot devices are introduced:
>
>   - mtd_bootdev: Iterates MTD partitions. A hunt callback walks the
>     MTD subsystem device list to bind bootdevs for both UCLASS_MTD
>     (SPI-NAND) and UCLASS_SPI_FLASH (SPI-NOR) devices.
>
>   - ubi_bootdev: Auto-attaches UBI from DT (compatible =3D "linux,ubi")
>     and iterates UBI volumes.
>
> The boot method integrates with bootstd's existing scan/priority
> framework. "bootflow scan" discovers OpenWrt firmware on all attached
> storage, and "bootflow boot" boots the first valid one =E2=80=94 exactly =
like
> distroboot or EFI, but for raw FIT images.
>
> Slot configuration example:
>
>   openwrt_slot_production=3Dfirmware
>   openwrt_slot_recovery=3Drecovery
>   openwrt_boot_order=3Dproduction recovery
>
> This enables production/recovery dual-boot, boot-loop detection (planned
> for a future series via pstore), and boot menu integration.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> The BananaPi BPi-R3 (MT7986) is the ideal demonstration device for this
> series because it is the only commonly available board that exposes all
> four storage types =E2=80=94 SPI-NOR, SPI-NAND, eMMC, and a microSD slot =
=E2=80=94 and
> can boot from any of them using the very same uImage.FIT image. This
> makes it possible to test every image_loader backend and the full
> cross-media boot flow on a single board.
>
>   - sandbox: unit tests for image_loader
>   - BananaPi BPi-R3 (MT7986): real hardware testing with SPI-NOR,
>     SPI-NAND (UBI), eMMC, and SD card =E2=80=94 including combinations of
>     present/absent flash devices and deliberate probe failures
>
> Patch overview
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> On-demand FIT loading (generic infrastructure):
>
>   01/20  boot: add image_loader on-demand loading abstraction
>   02/20  boot: image-loader: add block device backend
>   03/20  mtd: add mtd_read_skip_bad() helper
>   04/20  boot: image-loader: add MTD backend
>   05/20  cmd: ubi: export ubi_find_volume()
>   06/20  mtd: set flash_node on DT-created partitions
>   07/20  cmd: ubi: add ubi_part_from_mtd()
>   08/20  boot: image-loader: add UBI volume backend
>   09/20  boot: fit: support on-demand loading in fit_image_load()
>   10/20  cmd: bootm: accept storage device as image source
>   11/20  test: boot: add image_loader unit tests
>   12/20  doc: bootm: document direct storage boot
>
> OpenWrt boot method:
>
>   13/20  boot: bootmeth: add OpenWrt boot method skeleton
>   14/20  boot: bootmeth: openwrt: implement read_bootflow for block devic=
es
>   15/20  boot: bootmeth: openwrt: implement boot via bootm storage path
>   16/20  boot: bootdev: add MTD boot device
>   17/20  boot: bootdev: add UBI boot device
>   18/20  boot: bootmeth: openwrt: support MTD and UBI bootdevs
>   19/20  boot: bootmeth: openwrt: add openwrt_boot_script hook for bootco=
nf
>   20/20  boot: bootmeth: openwrt: add slot configuration from environment
>
> Diffstat summary:
>
>  29 files changed, 2666 insertions(+), 45 deletions(-)
>
> Planned future work
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   - pstore-based boot state tracking for automatic fallback to recovery
>     after repeated boot failures and boot-loop avoidance
>   - Comprehensive documentation and board migration guide
>   - dm-verity integration for runtime integrity verification of the
>     rootfs image, complementing FIT signature verification at boot
>   - Board enablement patches for MediaTek (MT7986, MT7981, MT7988),
>     Qualcomm (IPQ807x, IPQ60xx), and other OpenWrt-supported SoCs
>
> Comments, questions, and review very much appreciated.

Thanks for the detailed explanation. This seems fine to me and I
suspect it will be useful elsewhere. I will take a look at the patches
this week.

>
> AI tool disclosure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Major parts of this series were developed with assistance from GitHub
> Copilot (Claude Opus 4.6, Anthropic). The AI was used as a coding
> partner for scaffolding boilerplate, drafting documentation and commit
> messages, running checkpatch sweeps, and iterating on review feedback.
> All architectural decisions, U-Boot subsystem integration, hardware
> testing, and final review were done by the human author. Every line of
> code was reviewed and tested on real hardware before inclusion.

Regards,
Simon

>
>
> Cheers
>
>
> Daniel
>
>
> Daniel Golle (20):
>   boot: add image_loader on-demand loading abstraction
>   boot: image-loader: add block device backend
>   mtd: add mtd_read_skip_bad() helper
>   boot: image-loader: add MTD backend
>   cmd: ubi: export ubi_find_volume()
>   mtd: set flash_node on DT-created partitions
>   cmd: ubi: add ubi_part_from_mtd()
>   boot: image-loader: add UBI volume backend
>   boot: fit: support on-demand loading in fit_image_load()
>   cmd: bootm: accept storage device as image source
>   test: boot: add image_loader unit tests
>   doc: bootm: document direct storage boot
>   boot: bootmeth: add OpenWrt boot method skeleton
>   boot: bootmeth: openwrt: implement read_bootflow for block devices
>   boot: bootmeth: openwrt: implement boot via bootm storage path
>   boot: bootdev: add MTD boot device
>   boot: bootdev: add UBI boot device
>   boot: bootmeth: openwrt: support MTD and UBI bootdevs
>   boot: bootmeth: openwrt: add openwrt_boot_script hook for bootconf
>   boot: bootmeth: openwrt: add slot configuration from environment
>
>  boot/Kconfig                   |  88 +++++++
>  boot/Makefile                  |   8 +
>  boot/bootm.c                   |  62 ++++-
>  boot/bootmeth_openwrt.c        | 248 +++++++++++++++++++
>  boot/image-fit.c               |  96 ++++++++
>  boot/image-loader-blk.c        | 133 ++++++++++
>  boot/image-loader-mtd.c        | 103 ++++++++
>  boot/image-loader-ubi.c        | 112 +++++++++
>  boot/image-loader.c            | 163 +++++++++++++
>  boot/mtd_bootdev.c             | 150 ++++++++++++
>  boot/ubi_bootdev.c             | 180 ++++++++++++++
>  cmd/bootm.c                    | 148 +++++++++++-
>  cmd/mtd.c                      |  65 ++---
>  cmd/ubi.c                      |  33 ++-
>  doc/develop/bootm-storage.rst  | 210 ++++++++++++++++
>  doc/develop/index.rst          |   1 +
>  doc/usage/fit/index.rst        |   1 +
>  doc/usage/fit/storage-boot.rst | 201 +++++++++++++++
>  drivers/mtd/mtd-uclass.c       |  15 ++
>  drivers/mtd/mtdcore.c          |  45 ++++
>  drivers/mtd/mtdpart.c          |   2 +
>  include/bootm.h                |   2 +
>  include/image-loader.h         | 188 +++++++++++++++
>  include/image.h                |   4 +
>  include/linux/mtd/mtd.h        |  24 ++
>  include/ubi_uboot.h            |   2 +
>  test/boot/Makefile             |   2 +
>  test/boot/image_loader.c       | 429 +++++++++++++++++++++++++++++++++
>  test/cmd_ut.c                  |   2 +
>  29 files changed, 2673 insertions(+), 44 deletions(-)
>  create mode 100644 boot/bootmeth_openwrt.c
>  create mode 100644 boot/image-loader-blk.c
>  create mode 100644 boot/image-loader-mtd.c
>  create mode 100644 boot/image-loader-ubi.c
>  create mode 100644 boot/image-loader.c
>  create mode 100644 boot/mtd_bootdev.c
>  create mode 100644 boot/ubi_bootdev.c
>  create mode 100644 doc/develop/bootm-storage.rst
>  create mode 100644 doc/usage/fit/storage-boot.rst
>  create mode 100644 include/image-loader.h
>  create mode 100644 test/boot/image_loader.c
>
> --
> 2.53.0

Regards,
Simon
