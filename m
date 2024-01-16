Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF77FC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 13:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 206D187707;
	Tue, 16 Jan 2024 14:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JJv15kfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38A88745E; Tue, 16 Jan 2024 14:39:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB6F7879E7
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 14:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705412360; x=1706017160; i=xypron.glpk@gmx.de;
 bh=cHpvbAlH38larXfvCb+Q4JoOMG7VcLJqWCtAQ44EFVo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=JJv15kfUz/aP5r/CQrMW/V6dUZ0m5QzM9XKTsEzQd6uFSonlykO3oVtQ563fckZg
 LVrTHZ/dlXA9RxQg3DrJstMTarpXk5LqNyIrD5t9t8eV4dW+QAfMtJM9SmLYeluZ2
 OHaZ+HcWQJ/uPfFdjyCWjuemO1KibZjGMP5v/Ea2YwCuwh8d6Lb5EAzMKJ/rS7FAJ
 T3ugN2B1cR5iJ8qhiSiTmbxCK1Ak7jZZOYR0tlHcaI/0pUc3Enj5pV/Yhk3hfGJH4
 /TP04p+Cc589ysfEliHy9zlihQn45q3N9kYhtkiEVwyLuKhZ1GaffuTwgWXnsck/h
 L5Gt0MGoy3zrMUsYEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V0H-1r086Z1ThP-013yvL; Tue, 16
 Jan 2024 14:39:20 +0100
Message-ID: <5d54af9b-205d-4130-868e-0773364446b9@gmx.de>
Date: Tue, 16 Jan 2024 14:39:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spl: Add support for booting from ESP
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>
References: <20240116123643.563412-1-mchitale@ventanamicro.com>
 <20240116123643.563412-3-mchitale@ventanamicro.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240116123643.563412-3-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5TLrOMD2Kg72pFGvcr3DPgJsgYFUNkWXmQ84VfAbnBchshkeEE5
 SoVJqQ/32cgcMuXLLaSaK0GpIvdZK5oUUmMz6miQ3HuJSuk2dIi+7uO71JXO42aAq6UePDd
 ljzecJjk4EKkla6E59qovn+TOLB3gwUVO/Y+YD5VVeGzBYyK1Mjuc9BSa/+kwJmOTOB+FnJ
 CeFKGOjpXPY67PtgtOSLw==
UI-OutboundReport: notjunk:1;M01:P0:FW+ZP50QTW4=;GF0VdqzB7c1ISevVqv4HTjZrGOe
 6vHO7cUXba94DSExJwfQBsC0JCXnSf6SstlkKTpJNp9SWcY6JDGi2M8o1NUQONlpfxa5YMUZ+
 MFkFthm5JlvOjCZmezDF4uwOvR2p7m/bUFrA2/6uOW6pRClLFTigwrpouSDJ2DfpNjTNIIONo
 CQUu7LTSW8DHycE2ecInzBVS8+HXSnIpjTpypljR8bl6z46jgY5j8N2s7Q7PvN6/UCaQJNXpz
 LJc9Y2hUPFtJyMCHKQQKHZE0DMQMGhxvCWuKEUHuQp5oFdcAuvGLVPEvfPXR7RyuWXbclwI9v
 fzMfr2N/sR7AvC3F08xrg1R71zGnI662hI5kFtpm6G+KxLUaxvP0v24qUGn83GQnTkdVtodlt
 kY0Q76+kDODzbtf4zEyb7HSjTzFSlSED08LXUEJQWRvFa3Q6RlmBHrN7AdXHJ66Z4VtkeRcfv
 Z4AwJFtoJoJEyEYtpzi7KZlCMbhZfqiZiYKxprx8DiIIf3DNyx4lhSE0ibsJI39yJdBSgLKVM
 Jw1/lQ8KFj0CiQDxaOV5wrsphUY+Ov4dYzUuCIdCZ8934BdGaJRolMlX5Aoi948KIaEVfVMHS
 LEPE1I/4f4VeS7EBKy9cryuR1njFeHbJyp/DAydunSZm8TwtRZO587KGyD/kUdxF0hUC65IGt
 QX4sXg8OFvDsA/v4l8TqJI4mt2/a1lMBV6tfMdWQTR00mnko7GwKPTz9idNUeVAv8XuthgBHG
 EzmbKZH9kq7/tO/O2IruvF3Nsy56T89HE6lE+TYHUhpIceEBiVGhID1U9nZqDw7ecqvwkbg7k
 eKxqNevYa6JOdIJvXw0JY3rMD3WaD12jB0aT6OP9XtBxPrEzVp9iRBMXRGtU3P76oIXxYuvaa
 O+XWNwQy8ful5yL9tZaOPSLPkaNCSd5yIwy1xU+UCdYkobqdVAq49WEiz2HVIjLNpnOdQ/Qkx
 xsT50+FdgvaK83rKaVdZJYZ8xP0=
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

On 16.01.24 13:36, Mayuresh Chitale wrote:
> Some platforms as described by EBBR specification may store images in
> the FIRMWARE directory of the UEFI system partition(ESP). Add support
> to boot from the EFI system partition if it is enabled for a platform.
>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>

Thank you for respinning this series.

For future submissions it would be preferable to have the changes
between the versions also in the individual patches.

> ---
>   common/spl/Kconfig      |  8 +++++++
>   common/spl/spl_blk_fs.c | 51 ++++++++++++++++++++++++++++++-----------
>   common/spl/spl_fat.c    | 34 +++++++++++++++++++++++----
>   3 files changed, 75 insertions(+), 18 deletions(-)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index cf7ffc9b112..48e4e43196a 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1292,6 +1292,14 @@ config SPL_SATA_RAW_U_BOOT_SECTOR
>   	  Sector on the SATA disk to load U-Boot from, when the SATA disk is =
being
>   	  used in raw mode. Units: SATA disk sectors (1 sector =3D 512 bytes)=
.
>
> +config SPL_ESP_BOOT
> +	bool "Load next stage boot image from the UEFI system partition"
> +	default y if BOOT_DEFAULTS
> +	select SPL_PARTITION_TYPE_GUID
> +	help
> +	  When enabled, first try to boot from the UEFI system partition as
> +	  described in the Ch.4 of the EBBR specification.
> +
>   config SPL_NVME
>   	bool "NVM Express device support"
>   	depends on BLK
> diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
> index 04eac6f306b..a2e8c2ce910 100644
> --- a/common/spl/spl_blk_fs.c
> +++ b/common/spl/spl_blk_fs.c
> @@ -10,12 +10,15 @@
>   #include <spl_load.h>
>   #include <image.h>
>   #include <fs.h>
> +#include <part.h>
>   #include <asm/cache.h>
>   #include <asm/io.h>
>
>   struct blk_dev {
>   	const char *ifname;
>   	const char *filename;
> +	int devnum;
> +	int partnum;
>   	char dev_part_str[8];
>   };
>
> @@ -44,6 +47,29 @@ static ulong spl_fit_read(struct spl_load_info *load,=
 ulong file_offset,
>   	return actlen;
>   }
>
> +static int spl_blk_file_size(struct blk_dev *dev, const char *filename,
> +			     loff_t *filesize)
> +{
> +	int ret;
> +
> +	snprintf(dev->dev_part_str, sizeof(dev->dev_part_str) - 1, "%x:%x",
> +		 dev->devnum, dev->partnum);

Using log functions allows to provide more information if
CONFIG_SPL_LOG=3Dy otherwise they fall back to printf() and debug().

> +	debug("Loading file %s from %s %s\n", filename, dev->ifname,
> +	      dev->dev_part_str);

log_debug(

> +	ret =3D fs_set_blk_dev(dev->ifname, dev->dev_part_str, FS_TYPE_ANY);
> +	if (ret) {
> +		printf("spl: unable to set blk_dev %s %s. Err - %d\n",

SPL binary size is limited on many systems. There is already a message
telling that we are in SPL. I would suggest to abbreviate the message.

log_err("Can't access %s %s\n", dev->ifname, dev->dev_part_str);

> +		       dev->ifname, dev->dev_part_str, ret);
> +		return ret;
> +	}
> +
> +	ret =3D fs_size(filename, filesize);
> +	if (ret)
> +		printf("spl: unable to get size, file: %s. Err - %d\n",
> +		       filename, ret);

log_err("File not found %s\n", filename);

Moving to log functions and adjusting the messages can be done in a
follow up patch. I don't want to stop this series.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>


> +	return ret;
> +}
> +
>   int spl_blk_load_image(struct spl_image_info *spl_image,
>   		       struct spl_boot_device *bootdev,
>   		       enum uclass_id uclass_id, int devnum, int partnum)
> @@ -53,7 +79,7 @@ int spl_blk_load_image(struct spl_image_info *spl_imag=
e,
>   	loff_t filesize;
>   	struct blk_dev dev;
>   	struct spl_load_info load;
> -	int ret;
> +	int ret, part;
>
>   	blk_desc =3D blk_get_devnum_by_uclass_id(uclass_id, devnum);
>   	if (!blk_desc) {
> @@ -65,21 +91,18 @@ int spl_blk_load_image(struct spl_image_info *spl_im=
age,
>
>   	dev.filename =3D filename;
>   	dev.ifname =3D blk_get_uclass_name(uclass_id);
> -	snprintf(dev.dev_part_str, sizeof(dev.dev_part_str) - 1, "%x:%x",
> -		 devnum, partnum);
> -	ret =3D fs_set_blk_dev(dev.ifname, dev.dev_part_str, FS_TYPE_ANY);
> -	if (ret) {
> -		printf("spl: unable to set blk_dev %s %s. Err - %d\n",
> -		       dev.ifname, dev.dev_part_str, ret);
> -		return ret;
> +	dev.devnum =3D devnum;
> +	dev.partnum =3D partnum;
> +	if (IS_ENABLED(CONFIG_SPL_ESP_BOOT)) {
> +		part =3D part_get_esp(blk_desc);
> +		if (part)
> +			dev.partnum =3D part;
> +		else
> +			return -ENODEV;
>   	}
> -
> -	ret =3D fs_size(filename, &filesize);
> -	if (ret) {
> -		printf("spl: unable to get file size: %s. Err - %d\n",
> -		       filename, ret);
> +	ret =3D spl_blk_file_size(&dev, filename, &filesize);
> +	if (ret)
>   		return ret;
> -	}
>
>   	load.read =3D spl_fit_read;
>   	if (IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN))
> diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
> index a52f9e178e6..8c426a3f3e7 100644
> --- a/common/spl/spl_fat.c
> +++ b/common/spl/spl_fat.c
> @@ -60,10 +60,10 @@ static ulong spl_fit_read(struct spl_load_info *load=
, ulong file_offset,
>   	return actread;
>   }
>
> -int spl_load_image_fat(struct spl_image_info *spl_image,
> -		       struct spl_boot_device *bootdev,
> -		       struct blk_desc *block_dev, int partition,
> -		       const char *filename)
> +int spl_load_image_fat_one(struct spl_image_info *spl_image,
> +			   struct spl_boot_device *bootdev,
> +			   struct blk_desc *block_dev, int partition,
> +			   const char *filename)
>   {
>   	int err;
>   	loff_t size;
> @@ -103,6 +103,32 @@ end:
>   	return err;
>   }
>
> +int spl_load_image_fat(struct spl_image_info *spl_image,
> +		       struct spl_boot_device *bootdev,
> +		       struct blk_desc *block_dev, int partition,
> +		       const char *filename)
> +{
> +	int err, part;
> +
> +	/*
> +	 * First try to boot from EFI System partition. In case of failure,
> +	 * fall back to the configured partition.
> +	 */
> +	if (IS_ENABLED(CONFIG_SPL_ESP_BOOT)) {
> +		part =3D part_get_esp(block_dev);
> +		if (part) {
> +			err =3D spl_load_image_fat_one(spl_image, bootdev,
> +						     block_dev, part,
> +						     filename);
> +			if (!err)
> +				return err;
> +		}
> +	}
> +
> +	return spl_load_image_fat_one(spl_image, bootdev, block_dev,
> +				      partition, filename);
> +}
> +
>   #if CONFIG_IS_ENABLED(OS_BOOT)
>   int spl_load_image_fat_os(struct spl_image_info *spl_image,
>   			  struct spl_boot_device *bootdev,

