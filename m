Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBFAC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 09:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2C3D8083E;
	Wed, 26 Mar 2025 10:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=rums.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=rums.se header.i=@rums.se header.b="tHmeX7E4";
	dkim=permerror (0-bit key) header.d=rums.se header.i=@rums.se header.b="4VoCYQ21";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 548D2810E8; Wed, 26 Mar 2025 10:33:30 +0100 (CET)
Received: from mailrelay1-2.pub.mailoutpod2-cph3.one.com
 (mailrelay1-2.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:406::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA3258070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 10:33:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=rums.se
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=onilsson@rums.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742981607;
 x=1743586407; d=rums.se; s=rsa2;
 h=content-type:subject:reply-to:cc:from:to:message-id:mime-version:date:
 in-reply-to:from;
 bh=2N4Ru7D+tUr84yapdSRlfGOIGMdDkNk482dPYJaNRF0=;
 b=tHmeX7E4xhd5uaf8Wtk1A2cADKTWN9Q/dOQlJDO9ogMNGxzyXjpkmXs9BHl10xTNda3+rSO90OYip
 fiGYyDBXE+vI5luYqJUQ0fxK0arNcXm6XAZQ5YR7PXBWv0aCHDE1tJFcLAqpYl6EFzQCIZy6aICv97
 v03eNdm4OBTEC2OSXwOTKKIlJJ4zE4VX2qjZ2cbQ5rcuThMRYxL5JNApgSNRH12H06xPhVxN8MT9CZ
 24bEyARbaMWqArsM2rjqqaBVBej0TdnTl+mH8XZgWQ+bscZ/8wdt1cM6BfoOVvB/FFE0oqOzl0keo4
 PnGJqhVnTkYsJmm+yTbs1kSJgmas6Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742981607;
 x=1743586407; d=rums.se; s=ed2;
 h=content-type:subject:reply-to:cc:from:to:message-id:mime-version:date:
 in-reply-to:from;
 bh=2N4Ru7D+tUr84yapdSRlfGOIGMdDkNk482dPYJaNRF0=;
 b=4VoCYQ21VGDXoukXc7suG2bCB8oAI/vKKION1/s6NNE4/YCdT5XXMNnX7gtgsVuiWN6mO7Z9SHAIU
 mjGkSnWCw==
X-HalOne-ID: 5ec89586-0a25-11f0-9855-4d2191f5f3b5
Received: from onecom-webmail-backend-production-66c6df7957-bcx5h
 (service.pub.live1-k8s-cph3.one.com [46.30.212.67])
 by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id 5ec89586-0a25-11f0-9855-4d2191f5f3b5;
 Wed, 26 Mar 2025 09:33:26 +0000 (UTC)
X-Originating-IP: 85.226.134.249
User-Agent: One.com webmail 47.0.61
In-Reply-To: <a1fedb6c-afc3-aabb-ed47-ef581e4a9432@denx.de>
Date: Wed, 26 Mar 2025 10:33:26 +0100
MIME-Version: 1.0
Message-ID: <1742981606374.7.6958@webmail-backend-production-66c6df7957-dlf7s>
To: <hs@denx.de>
From: "Oskar Nilsson" <onilsson@rums.se>
Cc: <u-boot@lists.denx.de>
Subject: Re: block devices on MTD and UBI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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
Reply-To: onilsson@rums.se
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Heiko,
On Wednesday, 26 March 2025 at 06:21:35 +01:00, Heiko Schocher <hs@denx.de>=
 wrote:

> Hello Oskar,
>=20
> Hmm... yep, so the theory ... but let me first look if this is used in ma=
inline:
>=20
> hs@threadripper:u-boot [master] $ grep -lr UBI_BLOCK configs/
> hs@threadripper:u-boot [master] $
>=20
> So no users at all currently? That explains, why it is may buggy.
>=20
> hs@threadripper:u-boot [master] $ grep -lr UBI_BLOCK .
> ./drivers/mtd/nand/spi/core.c
> ./drivers/mtd/ubi/ubi.h
> ./drivers/mtd/ubi/Makefile
> ./drivers/mtd/ubi/Kconfig
> ./include/ubi_uboot.h
>=20
> And option is not selected through any Kconfig ... so yes, expect bugs
> here... and I have no hardware for that to dig into ... I am sorry.
>=20

No problem, I'll continue to try to get it working on my board.
>=20
>=20
> > Note that I'm on u-boot-imx 2024.04 and have back ported the ubi and mt=
d block
> > patches, so there may be differences to latest.
> > Looking at the driver model, a .blk has been added:
> > =3D> dm tree
> > Class Index Probed Driver Name
> > -----------------------------------------------------------
> > root 0 [ + ] root_driver root_driver
> > thermal 0 [ ] imx_thermal |-- imx_thermal
> > simple_bus 0 [ + ] simple_bus |-- soc
> > mtd 0 [ + ] mxs-nand-dt | |-- nand-controller@1806000
> > blk 0 [ ] ubi_blk | | `-- <<nand-controller@1806000.blk>>
> > ...
> > Calling sqfsls, seems to find the right volume (rootfs0):
> > =3D> sqfsls mtd 0 /
> > FS: Setting up block device: ifname=3D'mtd', dev_part_str=3D'0', fstype=
=3D6
> > Read 512 bytes from volume rootfs0 to 9ef2cb80
> > Disk <<nand-controller@1806000.blk>> not ready
> > ** Bad device specification mtd 0 **
> > Couldn't find partition mtd 0
> > FS: Failed to get partition info (err=3D-19)
> > Interestingly after each command that uses a blk device, I get 128 blk_=
partitions
> >=20
> Do I see it correct that your patch:
>=20
> <https://patchwork.ozlabs.org/project/uboot/patch/20250325174708.426459-1=
-onilsson@rums.se/>
>=20
> fixes this problem?
> Yes, that's my patch, I've sent V2. Returning -ENOENT is definitely bette=
r.


> > =3D> dm tree
> > Class Index Probed Driver Name
> > -----------------------------------------------------------
> > root 0 [ + ] root_driver root_driver
> > thermal 0 [ ] imx_thermal |-- imx_thermal
> > simple_bus 0 [ + ] simple_bus |-- soc
> > mtd 0 [ + ] mxs-nand-dt | |-- nand-controller@1806000
> > blk 0 [ ] ubi_blk | | `-- <<nand-controller@1806000.blk>>
> > partition 0 [ ] blk_partition | | |-- <<nand-controller@1806000.blk>>:1=

> > partition 1 [ ] blk_partition | | |-- <<nand-controller@1806000.blk>>:2=

> > partition 2 [ ] blk_partition | | |-- <<nand-controller@1806000.blk>>:3=

> > partition 3 [ ] blk_partition | | |-- <<nand-controller@1806000.blk>>:4=

> > partition 4 [ ] blk_partition | | |-- <<nand-controller@1806000.blk>>:5=

> > ...
> > At first I also got the error "UBIFS not mounted, use ubifsmount to mou=
nt volume first!"
> > To fix that I added this small patch:
> > diff --git a/disk/part.c b/disk/part.c
> > index 8982ef3bae..f168311e9a 100644
> > --- a/disk/part.c
> > +++ b/disk/part.c
> > @@ -524,7 +524,7 @@ int blk_get_device_part_str(const char *ifname, con=
st char *dev_part_str,
> > }
> > #endif
> > -#if IS_ENABLED(CONFIG_CMD_UBIFS) && !IS_ENABLED(CONFIG_SPL_BUILD)
> > +#if IS_ENABLED(CONFIG_CMD_UBIFS) && !IS_ENABLED(CONFIG_SPL_BUILD) && !=
IS_ENABLED(CONFIG_UBI_BLOCK)
> > /*
> > * Special-case ubi, ubi goes through a mtd, rather than through
> > * a regular block device.
> >=20
>=20
> Please send a formal patch for this, so I can pick it up, thanks!
>=20
OK, I'll test more to see if there is anything that breaks when adding this=
 extra check.

Regards,
Oskar

