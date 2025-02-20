Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27353C021AD
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 05:23:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 644C980A46;
	Thu, 20 Feb 2025 06:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TuDAc2TQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10F4C80C98; Thu, 20 Feb 2025 06:23:00 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D439801DE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 06:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51K5MtLj500635
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 19 Feb 2025 23:22:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740028975;
 bh=ziMPICXvnQRq2hFSSROsAd/If8Si5fE1ESUpsZjU47k=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=TuDAc2TQrX3933Nj+FUJUY+Pvv8NciLIZf6f/OlO66TSze1mW0eyTyREAvvraxYE/
 JKpl/3L4bnZ9/fRc3Tw/k6GYTEYQZYht/+C804949l6JVgj4Wpot7f9zERKOGFJl4Z
 /sukHCJP/dHfx9pep0HzHqCzkP2nAa7wcs9o3bhI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51K5MtOi044560;
 Wed, 19 Feb 2025 23:22:55 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Feb 2025 23:22:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Feb 2025 23:22:55 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.86])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51K5Ms4g058008;
 Wed, 19 Feb 2025 23:22:54 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 20 Feb 2025 10:52:53 +0530
Message-ID: <D7X0SJC303BY.Y2SK7Q0VHNTT@ti.com>
CC: "Raghavendra, Vignesh" <vigneshr@ti.com>
Subject: Re: [BUG report] spl: image size check fails in spl_load()
From: Anshul Dalal <anshuld@ti.com>
To: Sean Anderson <seanga2@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
X-Mailer: aerc 0.17.0
References: <20250214111251.2349093-1-anshuld@ti.com>
 <8a2961af-fbaa-74f6-8f2a-be9dd5e84a8a@gmail.com>
 <D7VCHLXD35RU.EG0QM37AEZ3X@ti.com>
 <b8af49dd-7999-a89f-600c-2d337bc6bb66@gmail.com>
In-Reply-To: <b8af49dd-7999-a89f-600c-2d337bc6bb66@gmail.com>
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

On Wed Feb 19, 2025 at 9:17 PM IST, Sean Anderson wrote:
> On 2/18/25 01:07, Anshul Dalal wrote:
> > On Sat Feb 15, 2025 at 11:18 PM IST, Sean Anderson wrote:
> >> On 2/14/25 06:12, Anshul Dalal wrote:
> >>> Hi all!
> >>>
> >>> I was trying to implement falcon boot on TI AM62x EVM with the kernel=
 image on
> >>> SD card's filesystem but the following check in `_spl_load` at
> >>> `include/spl_load.h:95` fails to -EIO as per the latest commit [89d33=
33]:
> >>>
> >>> 	return read < spl_image->size ? -EIO : 0;
> >>>
> >>> The check seems to be comparing the image size gathered from the head=
er
> >>> (spl_image->size) with the number of bytes read form the loader.
> >>>
> >>>   From spl_load.h:
> >>>
> >>> 	ret =3D spl_parse_image_header(spl_image, bootdev, header);
> >>> 	if (ret)
> >>> 		return ret;
> >>>
> >>> 	base_offset =3D spl_image->offset;
> >>> 	/* Only NOR sets this flag. */
> >>> 	if (IS_ENABLED(CONFIG_SPL_NOR_SUPPORT) &&
> >>> 	    spl_image->flags & SPL_COPY_PAYLOAD_ONLY)
> >>> 		base_offset +=3D sizeof(*header);
> >>> 	image_offset =3D ALIGN_DOWN(base_offset, spl_get_bl_len(info));
> >>> 	overhead =3D base_offset - image_offset;
> >>> 	size =3D ALIGN(spl_image->size + overhead, spl_get_bl_len(info));
> >>>
> >>> 	read =3D info->read(info, offset + image_offset, size,
> >>> 			  map_sysmem(spl_image->load_addr - overhead, size));
> >>>
> >>> 	if (read < 0)
> >>> 		return read;
> >>>
> >>> 	return read < spl_image->size ? -EIO : 0;
> >>>
> >>> During kernel build process the header size is computed including the=
 BSS
> >>> whereas it's removed when creating the uncompressed image. Therefore =
the size
> >>> of the uncompressed image on filesystem will be smaller than the size=
 specified
> >>> in the header. Which leads to failure of the above check.
> >>>
> >>>   From linux kernel's `arch/arm64/kernel/image.h:63`:
> >>>
> >>> 	#define HEAD_SYMBOLS						\
> >>> 		DEFINE_IMAGE_LE64(_kernel_size_le, _end - _text);	\
> >>> 		DEFINE_IMAGE_LE64(_kernel_flags_le, __HEAD_FLAGS);
> >>>
> >>> Disabling the check leads to a successful boot directly to the kernel=
.
> >>> Therefore it seems like the check is non functional as the size in th=
e kernel
> >>> header does not correspond with the file size of the kernel image.
> >>
> >> Did this work before v2024.04?
> >>
> >=20
> > No, the check existed by v2024.04. I tested on the commit prior to
> > 775074165d97 (the commit that added the check) and falcon boot works.
>
> Sorry, that's what I meant. E.g. did this work in v2024.01 etc.
>
> Just wanted to determine whether this was a bug or a feature request.
>
> >> How exactly are you loading your image? E.g. what are the values of
> >>
> >=20
> > I have my DTB and kernel Image on the 1st partition of the SD card whic=
h
> > is FAT. Which also includes the u-boot.img in case falcon fails and we
> > need a fallback.
> >=20
> >> CONFIG_SPL_OS_BOOT
> >> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> >> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> >> CONFIG_SPL_FALCON_BOOT_MMCSD
> >> CONFIG_SPL_FS_FAT
> >> CONFIG_SPL_FS_EXT4
> >> CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
> >> CONFIG_SUPPORT_EMMC_BOOT
> >>
> >=20
> > Since I'm not booting from RAW mmc but instead FS boot, I don't think
> > the SYS_MMCSD_RAW_* configs are relevant but in any case:
> >=20
> > CONFIG_SPL_OS_BOOT=3Dy
> > CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
> > # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is not set
> > # CONFIG_SPL_FALCON_BOOT_MMCSD is not set
> > CONFIG_SPL_FS_FAT=3Dy
> > # CONFIG_SPL_FS_EXT4 is not set
> > CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot.img"
> > # CONFIG_SUPPORT_EMMC_BOOT is not set
> >=20
> > Some other relevant configs:
> >=20
> > CONFIG_SYS_MMCSD_FS_BOOT=3Dy
> > CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=3D1
> > CONFIG_SPL_PAYLOAD_ARGS_ADDR=3D0x82000000
> > CONFIG_SPL_FS_LOAD_KERNEL_NAME=3D"Image"
> > CONFIG_SPL_FS_LOAD_ARGS_NAME=3D"k3-am625-sk.dtb"
> >=20
> >>   From what I can tell, the OS_BOOT path should not call spl_load in t=
he first place.
> >=20
> > It is called from spl_load_image_fat which is in turn called by
> > spl_load_image_fat_os as it's last return statement during falcon boot.
>
> Ah, there it is. This function is used both by OS_BOOT and regular boot. =
I intentionally
> tried not to touch the OS_BOOT path, but it looks like one change got in =
anyway.
>
> >>
> >> In any case, the root problem is that the size reported by the kernel =
is actually the
> >> space the kernel will need when it is loaded, and not the size of the =
data to load
> >> (which we need). So if we have a short read, we have no way of knowing=
 if the filesystem
> >> is corrupt, the image was truncated while writing, or if it's just mis=
sing the bss. And
> >> we still have to rely of the image size so that we can load from e.g. =
NAND or SPI where
> >> there is no filesystem.
> >>
> >=20
> > There seems to be no way to get the actual size of the kernel image jus=
t
> > from the image header. I think we should drop the check (at least in
> > case of FS boot without a FIT image). On NAND or SPI, the size from the
> > header would be larger than the actual file size. So, at worst we would
> > have read some extra data where BSS was supposed to be anyways.
> >=20
> >> One way to fix this could be to move the length check to spl_load_info=
->read. This would
> >> involve updating all the callers and callees.
> >>
> >=20
> > I think it would be better handled in spl_load where we can more easily
> > have separate checks for FIT and a kernel image whereas
> > spl_info_info->read would have no way of knowing if the binary type
> > without passing in the header as well.
>
> Yeah, I thought about this after I sent the email...
>
> > I suggest we do something like the following in spl_load:
> >=20
> > 	if (image_get_magic(header) =3D=3D FDT_MAGIC)
> > 		return read < spl_image->size ? -EIO : 0;
> > 	else
> > 		return read =3D=3D 0 ? -EIO : 0;
>
> I would prefer not doing this sort of thing since it grows the size of ev=
ery SPL, but only a
> few do falcon boot. Maybe it's better to skip the size check only for OS_=
BOOT and CMD_BOOTI.
>
> Or maybe we can move this hack to spl_fit_read. i.e:
>
> 	ret =3D fat_read_file(filename, buf, file_offset, size, &actread);
> 	if (ret)
> 		return ret;
>
> 	if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CMD_BOOTI))
> 		return size;
> 	else
> 		return actread;
>
> I think this would have the least impact overall.
>

Looks good to me, we would need to do the same for ext4 in spl_ext.c. I
can send a patch with the fix if you'd like.

- Anshul

