Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FB5E77181
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 08:21:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5995897CF;
	Tue, 10 Dec 2024 09:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UgaYAUfP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36C9F89787; Tue, 10 Dec 2024 09:21:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 720CF897D2
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 09:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733818909; x=1734423709; i=xypron.glpk@gmx.de;
 bh=7YgYLNBQO4gga7jWXroTI/V7qQ+0B+Yx0H3ZWHu/Rww=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UgaYAUfP3YMwocgUe8vktxeS/WBzQCwxkVM6im8kwLKMTuAowYtCfpS/712Y2B/5
 UUQJQ61OACq9pu6pkQjftOKpTwoONiYj7nmCn1QcfoFBrQRUlcDnaeZzNlXd+Aemx
 6dBqcJfgIFaRIhbNmiwdth82bRdwmzOi1w5mA9XF+YaBsySoBDwQQGMDIvMEyzdOV
 ShGu/Wy9RpXBOHUiseiIWvhoG0DmIynJWRpzsQDUNLv8Zp2IEjX/gemLSXXBsTQkP
 44kjMbb211PkrNqBskHJGQ0ssKADT9IXcX6OD7IPVRf/kuyshi/imj4LZbIkoHwtM
 vbAtUrAiG95ubRFkXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGyxX-1tORsU2dqF-00EyCR; Tue, 10
 Dec 2024 09:21:49 +0100
Message-ID: <c9a76fec-a57e-466c-bdc4-0e18efd09ba0@gmx.de>
Date: Tue, 10 Dec 2024 09:21:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] Add part_find command
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Matthew Garrett <mgarrett@aurora.tech>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-3-mjg59@srcf.ucam.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241123195616.305687-3-mjg59@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MYrjcPaTaJIrfUse6Vu/SwpwysV9vbCUITfWzzynZaLYunqrIn+
 9yDLNPmudZyaWxMUiOGZKSUMkKSMm1Tmwo2B6nXvJMm0RYI4HsQ2PJ4PKe88Gly1+YdPFdX
 1sfmGZVzMynpIl8UQCzfYpVUFP9xm7uuAM/k39coqPJ30+utK4v8SN9sYKiJwXQE5+V8gnf
 5LyEUOMu/LDtGFc/v89IQ==
UI-OutboundReport: notjunk:1;M01:P0:Q21zAIK//Nw=;j0nq8CJwoZTP57akW4ngV+vzIYG
 PV43VAaIljRCWFRT8qcdr4aXWykAmOrcr2DkXJCE1jfXssLmyJN32yYyN3MU0sulJcrrs6ra3
 N6lD5MBC+VQ5fXUKPQjGnXS/neA4Gnxl1vruaE2mWcfCKWZBGTuBmO7wmhCCs7mYlC1NVIEzF
 DT895ok3d1/uidkJdUDsuNFq4e63FumJ7kljhH7BMumfGRztkfdtTzqTUCwyCSw5nh131DpDd
 +sYhCpvBzJBCvGM8z5247/JQ+9E4KW4dVjIVo5R8B1Sw8CsGXE24cCxY8v4dfS+kxTX2HI6yb
 1y1k3eRVKsOAJV3Z/d6ouCNd4a8tR38MjVF0OyAaFosggSIkSCRe+CXww3YOhfYUra92IKZ9n
 YLvg+rWJjdGkiHLhnltYHFpTZ+yTs8S7jC/rsAzUVjM3KpsMEmV+/7u/ULiKbFXJtIDJ19qsH
 H5zAi3wF/ieQ+aU3kbFzdX9itUjp92FAGU8GqktoUN1kGMdU7zH+LAg4Dhh0RinXPWLiQJguD
 LX0ohap6fo4WjzA6DlEQT5Omyrz3NJF8eWnlAPS8ywgPdv3s6t3jXDdiCj1P3pWXuY9DNO69E
 TbjdvdH4K9ow/9yxh1ns5A+PVqNCOY7iTKedfLO9llPpIlgyotTCvlvCo6oRJZdE8ir9hOWNK
 CWYUxGmb7mlhI9jEjkM3CCBADEnc6FHMuYEAJwCS3Ri7EspBHy8mpavCtFkjCB1ViSLIRwUTf
 hIk62GJbVYjGnNwiqTcadGjSFSbRQbFTQSWQ3+BV3bw9LENPOTPAmdPm0JVVVEhalPKkZr/jm
 GCzUc/eexeCeRKczwY9ku6W2L1Ac9kBlnCSE+L1GS4MZKpIM+vFA/XdbPoh/cxdwCalPhBgDM
 LC5CqcmNElDLDS+cYI1o9wCxFKDR50GmrJifzb8a+lRkH2bMBeJUxhbeObR6i5CesFXXoxdM0
 eBzITfuKO57LD7menwUUuiXedni59SY3q479jlC9hIR2yqZXKaEhfO0xq/4J2eNssq7AzxPkZ
 he99w/yM9wbqsVg4dXpSBw23H+V9Y85nOwL/yumxJ1zF5BN0ZH2ABfqQbyqvGmGQcUy7902/s
 yho2S1bmL4MBwy0861gyIzoJSRKrKk
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

On 23.11.24 20:55, Matthew Garrett wrote:
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> part_find takes a GPT GUID and searches for a partition that matches
> that. It then sets the target_part environment variable to the media
> type, device number and partition number that matched, allowing
> $target_part to be passed directly to bootm and similar commands.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>

For user to memorize the command it would be preferable to add the
functionality as sub-command to the existing part command.

Best regards

Heinrich

> ---
>
>   cmd/Kconfig     |  10 ++++
>   cmd/Makefile    |   1 +
>   cmd/part_find.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 167 insertions(+)
>   create mode 100644 cmd/part_find.c
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 1d7ddb4ed36..ee85928ca21 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1529,6 +1529,16 @@ config CMD_PART
>   	  Read and display information about the partition table on
>   	  various media.
>
> +config CMD_PART_FIND
> +	bool "part_find"
> +	depends on PARTITIONS
> +	select HAVE_BLOCK_DEVICE
> +	select PARTITION_UUIDS
> +	select PARTITION_TYPE_GUID
> +	help
> +	  Find a partition with a given type GUID and set the target_part
> +	  environment variable if located.
> +
>   config CMD_PCI
>   	bool "pci - Access PCI devices"
>   	help
> diff --git a/cmd/Makefile b/cmd/Makefile
> index d1f369deec0..16fd8dcd723 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -137,6 +137,7 @@ obj-$(CONFIG_CMD_NVEDIT_EFI) +=3D nvedit_efi.o
>   obj-$(CONFIG_CMD_ONENAND) +=3D onenand.o
>   obj-$(CONFIG_CMD_OSD) +=3D osd.o
>   obj-$(CONFIG_CMD_PART) +=3D part.o
> +obj-$(CONFIG_CMD_PART_FIND) +=3D part_find.o
>   obj-$(CONFIG_CMD_PCAP) +=3D pcap.o
>   ifdef CONFIG_PCI
>   obj-$(CONFIG_CMD_PCI) +=3D pci.o
> diff --git a/cmd/part_find.c b/cmd/part_find.c
> new file mode 100644
> index 00000000000..8c071d3c374
> --- /dev/null
> +++ b/cmd/part_find.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Aurora Innovation, Inc. Copyright 2022.
> + *
> + */
> +
> +#include <blk.h>
> +#include <config.h>
> +#include <command.h>
> +#include <dm.h>
> +#include <env.h>
> +#include <part.h>
> +#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
> +#include <efi.h>
> +#include <efi_api.h>
> +
> +static bool partition_is_on_device(const struct efi_device_path *device=
,
> +				   const struct efi_device_path *part,
> +				   __u32 *part_no)
> +{
> +	size_t d_len, p_len;
> +	const struct efi_device_path *p, *d;
> +
> +	for (d =3D device; d->type !=3D DEVICE_PATH_TYPE_END; d =3D (void *)d =
+ d->length) {
> +	}
> +
> +	d_len =3D (void *)d - (void *)device;
> +
> +	for (p =3D part; p->type !=3D DEVICE_PATH_TYPE_END &&
> +		     !(p->type =3D=3D DEVICE_PATH_TYPE_MEDIA_DEVICE &&
> +		       p->sub_type =3D=3D DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH);
> +	     p =3D (void *)p + p->length) {
> +	}
> +
> +	if (p->type !=3D DEVICE_PATH_TYPE_MEDIA_DEVICE ||
> +	    p->sub_type !=3D DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH) {
> +		// Not a partition.
> +		return false;
> +	}
> +
> +	p_len =3D (void *)p - (void *)part;
> +
> +	if (p_len =3D=3D d_len && !memcmp(device, part, p_len)) {
> +		if (part_no)
> +			*part_no =3D ((__u32 *)p)[1];
> +		return true;
> +	}
> +	return false;
> +}
> +#endif
> +
> +static int part_find(int argc, char *const argv[])
> +{
> +#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
> +	efi_guid_t efi_devpath_guid =3D EFI_DEVICE_PATH_PROTOCOL_GUID;
> +	struct efi_device_path *loaded_image_path =3D NULL;
> +	struct efi_boot_services *boot =3D efi_get_boot();
> +	struct efi_priv *priv =3D efi_get_priv();
> +	bool part_self =3D false;
> +#endif
> +	struct driver *d =3D ll_entry_start(struct driver, driver);
> +	const int n_ents =3D ll_entry_count(struct driver, driver);
> +	struct disk_partition info;
> +	struct blk_desc *desc;
> +	struct driver *entry;
> +	struct udevice *udev;
> +	struct uclass *uc;
> +	int ret;
> +
> +	if (argc !=3D 2)
> +		return CMD_RET_USAGE;
> +
> +#if defined(CONFIG_EFI) || defined (CONFIG_EFI_APP)
> +	part_self =3D !strncmp(argv[1], "self", 6);
> +	if (part_self) {
> +		ret =3D boot->handle_protocol(priv->loaded_image->device_handle,
> +					&efi_devpath_guid,
> +					(void **)&loaded_image_path);
> +		if (ret)
> +			log_warning("failed to get device path for loaded image (ret=3D%d)",=
 ret);
> +	}
> +#endif
> +
> +	ret =3D uclass_get(UCLASS_BLK, &uc);
> +	if (ret) {
> +		puts("Could not get BLK uclass.\n");
> +		return CMD_RET_FAILURE;
> +	}
> +	for (entry =3D d; entry < d + n_ents; entry++) {
> +		if (entry->id !=3D UCLASS_BLK)
> +			continue;
> +		uclass_foreach_dev(udev, uc) {
> +			int i;
> +
> +			if (udev->driver !=3D entry)
> +				continue;
> +			desc =3D dev_get_uclass_plat(udev);
> +#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
> +			if (part_self) {
> +				if (desc->if_type =3D=3D IF_TYPE_EFI_MEDIA) {
> +					struct efi_media_plat *plat =3D
> +						dev_get_plat(udev->parent);
> +					__u32 loader_part_no;
> +
> +					if (partition_is_on_device(plat->device_path,
> +								   loaded_image_path,
> +								   &loader_part_no)) {
> +						char env[256];
> +
> +						ret =3D snprintf(env, sizeof(env), "%s %d:%d", blk_get_if_type_na=
me(desc->if_type), desc->devnum, loader_part_no);
> +						if (ret < 0 || ret =3D=3D sizeof(env))
> +							return CMD_RET_FAILURE;
> +						if (env_set("target_part", env))
> +							return CMD_RET_FAILURE;
> +						return CMD_RET_SUCCESS;
> +					}
> +				}
> +			} else {
> +#endif
> +				for (i =3D 1; i <=3D MAX_SEARCH_PARTITIONS; i++) {
> +					ret =3D part_get_info(desc, i, &info);
> +					if (ret)
> +						break;
> +					if (strcasecmp(argv[1], info.type_guid) =3D=3D 0) {
> +						char env[256];
> +						ret =3D snprintf(env, sizeof(env), "%s %d:%d", blk_get_if_type_na=
me(desc->if_type), desc->devnum, i);
> +						if (ret < 0 || ret =3D=3D sizeof(env))
> +							return CMD_RET_FAILURE;
> +						env_set("target_part", env);
> +						debug("Setting target_part to %s\n", env);
> +						return CMD_RET_SUCCESS;
> +					}
> +				}
> +#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
> +			}
> +#endif
> +		}
> +	}
> +
> +	return CMD_RET_FAILURE;
> +}
> +
> +static int do_part_find(struct cmd_tbl *cmdtp, int flag, int argc,
> +			char *const argv[])
> +{
> +	return part_find(argc, argv);
> +}
> +
> +U_BOOT_CMD(
> +	part_find, 2, 0, do_part_find, "Find a partition",
> +	"<guid>\n"
> +	"- Examine the list of known partitions for one that has a type\n"
> +	"  GUID that matches 'guid', expressed in the standard text format.\n"
> +	"  If successful, the target_part environment variable will be set\n"
> +	"  to the corresponding 'interface dev:part'.\n"
> +);

