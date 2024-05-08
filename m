Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF3AC19F4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 11:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F728843D;
	Wed,  8 May 2024 13:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="EVF8ePxM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91D108844B; Wed,  8 May 2024 13:53:00 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A2048839E
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 13:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715169172; x=1715773972; i=xypron.glpk@gmx.de;
 bh=FQYHxjy9ZH/+FFLnkQTWdhiOOhkdEf5fsZX6H2JANJE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:
 References:Cc:To:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EVF8ePxMivP8xE76O/ETOR2++rp5bxfWi1RVTRNitQUBZ/bTe3jqg1wl5245zMA4
 3f9FD9gMcJtFTYqHHmFpQyNL010SIj7PKqBKttgM+dxStIonA9nRRQvg4Kb6motAf
 WIJjEhfBRp6KxvPSVkqptZZFndD+YWjhGIRCJV96kdFOuh+u5xNPf7uwHAVl3dH9E
 +AV6Tk+H7551jJ7kXs1JCMWfRHIEornBVCc7mjrN4SOPpM5WI0JGsU2IU1RRNYBd/
 h/zzEm760JC6cEBJCc4LLbf7134hPmAjnXQX0HFI2WO2NRl0Y44H/32R2vSwbk7tg
 3cUEMdbWG1Gi7N2cng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.55.2.71] ([149.11.192.251]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1sDukP3qJK-00S7UP; Wed, 08
 May 2024 13:52:52 +0200
Message-ID: <f4caebe2-d218-4ce7-9c3d-4dc83a0e1c76@gmx.de>
Date: Wed, 8 May 2024 13:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: capsule: detect possible ESP device path
References: <20240508112401.155528-1-o451686892@gmail.com>
Content-Language: en-US
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de
To: Weizhao Ouyang <o451686892@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240508112401.155528-1-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o8iR8kOk7aI+ojcDsq4qq+Rqi8XqMRumZxx0AluKt40Rpce4JeS
 ZaLZ2GQE/majFEqcQ7MmAuHmWxerYQVbTN3geX9pSJES3jC4+95ix1/eavBD9vcMLw4uFSI
 T19/CTbRYgIQ+RPs35rgoaTJAhUya9sSgE96CYpaP5ZMggPFsFc3kji+xSYqYlgLicF4p8e
 qctkpEhv+1Ir69RC37iKA==
UI-OutboundReport: notjunk:1;M01:P0:IhlgU1+Ldwo=;GoEtdCETtArMkp5U8V0cHdf8sp2
 HMHFPx2gGdRYoVGP+eEh0Ezuokwnc0BjxKGhVz15QXi1XE9yC4rqt3HViyFcBvuI+Jd2lsFk6
 frVfVMHgE7+SaCRpG7jx1KOSJe7l76wJSZcjooVbT4DDjKA0vqfac0xxeuTw+dDa2AXsCbTwL
 /6PHf/MLMkbp8o2adJXqIyq5hPm1oknDYJ2Zj/6wFrpV3gM/+FM34JiW/MUuU43orp6r9jcQh
 7RT8M4UJ6KCRrBIK+gYpE2ecwVpDNyLYsn0E9xWijYFT31ydpYc0lq8WZBTDI5JpWNNPoXKSU
 OjVT6Y7ctr7fAX3+BjXm5sexT5sCzpiTQnxXmw+q0gdCAyartiWauv1vQq9HPzLBjHOzSY0ex
 tHPjzloccLdEC2rcs4Ly5FyPoTpQahsblLHAlUFNpl0At1UnVnpa7sB4zAbvMlwDAB96obwQ8
 EHLEKsVSxQSL04ik9HNf80h2nMVUJGUf6t7lU+JD5mzo4cY2LQv0Hgw1kFwa4h7+C1nWKwHMB
 e4aYY7xCqN4SHbE/x4WEbByAvR6YujPrPpgFs8majC5Sok2bzU/kpp+eVdsYoOldvCObayZl+
 EGQ1JeGmb5gxjEpXBGTxsIr6zWHBMi3HmRr24lbill40faSRuJ/ncTly7F5wUgPfx9uT9sRpZ
 xYofGmOLfzGiSyoNkSVmAOzcQ6QwoNkdSdMVoWwiffsAuntR0/GVpZtV/R7dmNG7zElUGXeTp
 iC6yJqeldrwgb+DuhtAa/CgMfA4wIs1X83+FYgwRecLiw0fNyfWht5ml36ZHsAMC+AmSXTN0a
 DTHonNbC8FrWobty4VV7TztX1FeKCGOYeJMyc2sDivWDA=
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

On 5/8/24 13:24, Weizhao Ouyang wrote:
> When using CapsuleApp to execute on-disk update, it will choose the
> first boot option as BootNext entry to perform the capsule update after
> a reboot. But auto-generate boot option will ignore the logical
> partition which might be an ESP, thus it could not find the capsule
> file.
>
> Align with the EDK II, detect the possible ESP device path by expanding
> the media path.

Hello Wheizhoa,

 From the description I would not know how to reproduce the problem you
face.

Could you, please, provide an example (including disk image and capsule)
for QEMU and describe expected and observed behavior.

We should add a CI test case covering the observed bug.

>
> Fixes: f86fba8adbf3 ("efi_loader: auto-generate boot option for each blk=
io device")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>   include/efi_loader.h          |   6 ++
>   lib/efi_loader/efi_boottime.c |  15 ++---
>   lib/efi_loader/efi_capsule.c  | 110 +++++++++++++++++++++++++++++++++-
>   3 files changed, 118 insertions(+), 13 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 9600941aa327..9d78fa936701 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -683,6 +683,12 @@ efi_status_t efi_protocol_open(struct efi_handler *=
handler,
>   			       void **protocol_interface, void *agent_handle,
>   			       void *controller_handle, uint32_t attributes);
>
> +/* Connect drivers to controller */
> +efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_hand=
le,
> +					   efi_handle_t *driver_image_handle,
> +					   struct efi_device_path *remain_device_path,
> +					   bool recursive);
> +
>   /* Install multiple protocol interfaces */
>   efi_status_t EFIAPI
>   efi_install_multiple_protocol_interfaces(efi_handle_t *handle, ...);
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 1951291747cd..2c86d78208b2 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -103,12 +103,6 @@ static efi_status_t EFIAPI efi_disconnect_controlle=
r(
>   					efi_handle_t driver_image_handle,
>   					efi_handle_t child_handle);
>
> -static
> -efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_hand=
le,
> -					   efi_handle_t *driver_image_handle,
> -					   struct efi_device_path *remain_device_path,
> -					   bool recursive);
> -
>   /* Called on every callback entry */
>   int __efi_entry_check(void)
>   {
> @@ -3670,11 +3664,10 @@ static efi_status_t efi_connect_single_controlle=
r(
>    *
>    * Return: status code
>    */
> -static efi_status_t EFIAPI efi_connect_controller(
> -			efi_handle_t controller_handle,
> -			efi_handle_t *driver_image_handle,
> -			struct efi_device_path *remain_device_path,
> -			bool recursive)
> +efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_hand=
le,
> +					   efi_handle_t *driver_image_handle,
> +					   struct efi_device_path *remain_device_path,
> +					   bool recursive)
>   {
>   	efi_status_t r;
>   	efi_status_t ret =3D EFI_NOT_FOUND;
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index de0d49ebebda..919e3cba071b 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -922,6 +922,105 @@ static bool device_is_present_and_system_part(stru=
ct efi_device_path *dp)
>   	return true;
>   }
>
> +/**
> + * get_esp_from_boot_option_file_path - get the expand device path
> + *
> + * Get a possible efi system partition by expanding a boot option
> + * file path.
> + *
> + * @boot_dev	The device path pointing to a boot option
> + * Return:	The full ESP device path or NULL if fail
> + */
> +static struct efi_device_path *get_esp_from_boot_option_file_path(struc=
t efi_device_path *boot_dev)
> +{
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	efi_handle_t handle;
> +	struct efi_device_path *dp =3D boot_dev;
> +	struct efi_device_path *full_path =3D NULL;
> +
> +	ret =3D EFI_CALL(efi_locate_device_path(&efi_simple_file_system_protoc=
ol_guid,
> +					      &dp,
> +					      &handle));
> +	if (ret !=3D EFI_SUCCESS)
> +		ret =3D EFI_CALL(efi_locate_device_path(&efi_block_io_guid, &dp, &han=
dle));
> +
> +	/* Expand Media Device Path */
> +	if (ret =3D=3D EFI_SUCCESS && EFI_DP_TYPE(dp, END, END)) {
> +		struct efi_device_path *temp_dp;
> +		struct efi_block_io *block_io;
> +		void *buffer;
> +		efi_handle_t *simple_file_system_handle;
> +		efi_uintn_t number_handles, index;
> +		u32 size;
> +		u32 temp_size;
> +
> +		temp_dp =3D boot_dev;
> +		ret =3D EFI_CALL(efi_locate_device_path(&efi_simple_file_system_proto=
col_guid,
> +						      &temp_dp,
> +						      &handle));
> +		/*
> +		 * For device path pointing to simple file system, it only expands to=
 one
> +		 * full path
> +		 */
> +		if (ret =3D=3D EFI_SUCCESS && EFI_DP_TYPE(temp_dp, END, END)) {
> +			if (device_is_present_and_system_part(temp_dp))
> +				return temp_dp;
> +		}
> +
> +		/*
> +		 * For device path only pointing to the removable device handle, try =
to
> +		 * search all its children handles
> +		 */
> +		ret =3D EFI_CALL(efi_locate_device_path(&efi_block_io_guid, &temp_dp,=
 &handle));
> +		EFI_CALL(efi_connect_controller(handle, NULL, NULL, true));

Which driver do you expect to connect here?

> +
> +		/* Align with edk2, issue a dummy read to the device to check the dev=
ice change */
> +		ret =3D EFI_CALL(efi_handle_protocol(handle, &efi_block_io_guid, (voi=
d **)&block_io));
> +		if (ret =3D=3D EFI_SUCCESS) {
> +			buffer =3D memalign(block_io->media->io_align, block_io->media->bloc=
k_size);
> +			if (buffer) {
> +				ret =3D EFI_CALL(block_io->read_blocks(block_io,
> +								     block_io->media->media_id,
> +								     0,
> +								     block_io->media->block_size,
> +								     buffer));
> +				free(buffer);
> +			} else {
> +				return full_path;
> +			}
> +		} else {
> +			return full_path;
> +		}
> +
> +		/* detect the default boot file from removable media */
> +		size =3D efi_dp_size(boot_dev) - sizeof(struct efi_device_path);
> +		EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
> +						  &efi_simple_file_system_protocol_guid,

If you are looking for an ESP shouldn't you use the ESP GUID to find it?
It is installed on the ESP in efi_status_t efi_disk_add_dev().

Best regards

Heinrich

> +						  NULL,
> +						  &number_handles,
> +						  &simple_file_system_handle));
> +		for (index =3D 0; index < number_handles; index++) {
> +			EFI_CALL(efi_handle_protocol(simple_file_system_handle[index],
> +						     &efi_guid_device_path,
> +						     (void **)&temp_dp));
> +
> +			log_debug("Search ESP %pD\n", temp_dp);
> +			temp_size =3D efi_dp_size(temp_dp) - sizeof(struct efi_device_path);
> +			if (size <=3D temp_size && !memcmp(temp_dp, boot_dev, size)) {
> +				if (device_is_present_and_system_part(temp_dp)) {
> +					efi_free_pool(simple_file_system_handle);
> +					return temp_dp;
> +				}
> +			}
> +		}
> +
> +		if (simple_file_system_handle)
> +			efi_free_pool(simple_file_system_handle);
> +	}
> +
> +	return full_path;
> +}
> +
>   /**
>    * find_boot_device - identify the boot device
>    *
> @@ -938,6 +1037,7 @@ static efi_status_t find_boot_device(void)
>   	int i, num;
>   	struct efi_simple_file_system_protocol *volume;
>   	struct efi_device_path *boot_dev =3D NULL;
> +	struct efi_device_path *full_path =3D NULL;
>   	efi_status_t ret;
>
>   	/* find active boot device in BootNext */
> @@ -961,8 +1061,14 @@ static efi_status_t find_boot_device(void)
>   			if (device_is_present_and_system_part(boot_dev)) {
>   				goto found;
>   			} else {
> -				efi_free_pool(boot_dev);
> -				boot_dev =3D NULL;
> +				full_path =3D get_esp_from_boot_option_file_path(boot_dev);
> +				if (full_path) {
> +					boot_dev =3D full_path;
> +					goto found;
> +				} else {
> +					efi_free_pool(boot_dev);
> +					boot_dev =3D NULL;
> +				}
>   			}
>   		}
>   	}

