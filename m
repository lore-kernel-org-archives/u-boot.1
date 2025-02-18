Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1316BC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 06:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BBB180104;
	Tue, 18 Feb 2025 07:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uRRPDSLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6A528043C; Tue, 18 Feb 2025 07:07:37 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B23800B3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 07:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51I67WLO1487630
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 18 Feb 2025 00:07:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739858852;
 bh=QdtemP/MW60OEYbANID58kuLja4losRPa+4Nvtuk8wY=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=uRRPDSLPR6qOya2SeX5mn59ZVoL0hzU2vsC/fPv4ZK/V8gr9FXX0igagxBltWtGcq
 IFxTrSiqnje8dc+pnKj6aGxdW3EPoIs4o/i/PvZlHoM4C6Tw4sSvKYUgwg9ZGggCGs
 zcLwpEFzUK2d0iqNvtYV4KUBuDucvCudDurO8obU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51I67WPD111455;
 Tue, 18 Feb 2025 00:07:32 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 00:07:32 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 00:07:32 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.72])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51I67Vah060911;
 Tue, 18 Feb 2025 00:07:31 -0600
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 18 Feb 2025 11:37:30 +0530
Message-ID: <D7VCHLXD35RU.EG0QM37AEZ3X@ti.com>
CC: "Raghavendra, Vignesh" <vigneshr@ti.com>
Subject: Re: [BUG report] spl: image size check fails in spl_load()
From: Anshul Dalal <anshuld@ti.com>
To: Sean Anderson <seanga2@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.17.0
References: <20250214111251.2349093-1-anshuld@ti.com>
 <8a2961af-fbaa-74f6-8f2a-be9dd5e84a8a@gmail.com>
In-Reply-To: <8a2961af-fbaa-74f6-8f2a-be9dd5e84a8a@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Sat Feb 15, 2025 at 11:18 PM IST, Sean Anderson wrote:
> On 2/14/25 06:12, Anshul Dalal wrote:
> > Hi all!
> >=20
> > I was trying to implement falcon boot on TI AM62x EVM with the kernel i=
mage on
> > SD card's filesystem but the following check in `_spl_load` at
> > `include/spl_load.h:95` fails to -EIO as per the latest commit [89d3333=
]:
> >=20
> > 	return read < spl_image->size ? -EIO : 0;
> >=20
> > The check seems to be comparing the image size gathered from the header
> > (spl_image->size) with the number of bytes read form the loader.
> >=20
> >  From spl_load.h:
> >=20
> > 	ret =3D spl_parse_image_header(spl_image, bootdev, header);
> > 	if (ret)
> > 		return ret;
> >=20
> > 	base_offset =3D spl_image->offset;
> > 	/* Only NOR sets this flag. */
> > 	if (IS_ENABLED(CONFIG_SPL_NOR_SUPPORT) &&
> > 	    spl_image->flags & SPL_COPY_PAYLOAD_ONLY)
> > 		base_offset +=3D sizeof(*header);
> > 	image_offset =3D ALIGN_DOWN(base_offset, spl_get_bl_len(info));
> > 	overhead =3D base_offset - image_offset;
> > 	size =3D ALIGN(spl_image->size + overhead, spl_get_bl_len(info));
> >=20
> > 	read =3D info->read(info, offset + image_offset, size,
> > 			  map_sysmem(spl_image->load_addr - overhead, size));
> >=20
> > 	if (read < 0)
> > 		return read;
> >=20
> > 	return read < spl_image->size ? -EIO : 0;
> >=20
> > During kernel build process the header size is computed including the B=
SS
> > whereas it's removed when creating the uncompressed image. Therefore th=
e size
> > of the uncompressed image on filesystem will be smaller than the size s=
pecified
> > in the header. Which leads to failure of the above check.
> >=20
> >  From linux kernel's `arch/arm64/kernel/image.h:63`:
> >=20
> > 	#define HEAD_SYMBOLS						\
> > 		DEFINE_IMAGE_LE64(_kernel_size_le, _end - _text);	\
> > 		DEFINE_IMAGE_LE64(_kernel_flags_le, __HEAD_FLAGS);
> >=20
> > Disabling the check leads to a successful boot directly to the kernel.
> > Therefore it seems like the check is non functional as the size in the =
kernel
> > header does not correspond with the file size of the kernel image.
>
> Did this work before v2024.04?
>

No, the check existed by v2024.04. I tested on the commit prior to
775074165d97 (the commit that added the check) and falcon boot works.

> How exactly are you loading your image? E.g. what are the values of
>

I have my DTB and kernel Image on the 1st partition of the SD card which
is FAT. Which also includes the u-boot.img in case falcon fails and we
need a fallback.

> CONFIG_SPL_OS_BOOT
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> CONFIG_SPL_FALCON_BOOT_MMCSD
> CONFIG_SPL_FS_FAT
> CONFIG_SPL_FS_EXT4
> CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
> CONFIG_SUPPORT_EMMC_BOOT
>

Since I'm not booting from RAW mmc but instead FS boot, I don't think
the SYS_MMCSD_RAW_* configs are relevant but in any case:

CONFIG_SPL_OS_BOOT=3Dy
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
# CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is not set
# CONFIG_SPL_FALCON_BOOT_MMCSD is not set
CONFIG_SPL_FS_FAT=3Dy
# CONFIG_SPL_FS_EXT4 is not set
CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot.img"
# CONFIG_SUPPORT_EMMC_BOOT is not set

Some other relevant configs:

CONFIG_SYS_MMCSD_FS_BOOT=3Dy
CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=3D1
CONFIG_SPL_PAYLOAD_ARGS_ADDR=3D0x82000000
CONFIG_SPL_FS_LOAD_KERNEL_NAME=3D"Image"
CONFIG_SPL_FS_LOAD_ARGS_NAME=3D"k3-am625-sk.dtb"

>  From what I can tell, the OS_BOOT path should not call spl_load in the f=
irst place.

It is called from spl_load_image_fat which is in turn called by
spl_load_image_fat_os as it's last return statement during falcon boot.

>
> In any case, the root problem is that the size reported by the kernel is =
actually the
> space the kernel will need when it is loaded, and not the size of the dat=
a to load
> (which we need). So if we have a short read, we have no way of knowing if=
 the filesystem
> is corrupt, the image was truncated while writing, or if it's just missin=
g the bss. And
> we still have to rely of the image size so that we can load from e.g. NAN=
D or SPI where
> there is no filesystem.
>

There seems to be no way to get the actual size of the kernel image just
from the image header. I think we should drop the check (at least in
case of FS boot without a FIT image). On NAND or SPI, the size from the
header would be larger than the actual file size. So, at worst we would
have read some extra data where BSS was supposed to be anyways.

> One way to fix this could be to move the length check to spl_load_info->r=
ead. This would
> involve updating all the callers and callees.
>

I think it would be better handled in spl_load where we can more easily
have separate checks for FIT and a kernel image whereas
spl_info_info->read would have no way of knowing if the binary type
without passing in the header as well.

I suggest we do something like the following in spl_load:

	if (image_get_magic(header) =3D=3D FDT_MAGIC)
		return read < spl_image->size ? -EIO : 0;
	else
		return read =3D=3D 0 ? -EIO : 0;

- Anshul
