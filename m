Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6EAC04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 12:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C00A488427;
	Wed,  8 May 2024 14:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PcjRqoh1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5D5C8843D; Wed,  8 May 2024 14:09:46 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEBEA882F0
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 14:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715170177; x=1715774977; i=xypron.glpk@gmx.de;
 bh=8H4ANy0otlcEb5rlepPCZahEDCbr8Fx5UnU55fslwBw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PcjRqoh1go/mkfgrmuTABvmo8PRpwnEuug6hrCpebn5UY0RaPX8IHipV/hJ16JHB
 F8gC8b3UePXTkDyjJPxyQ7VzW9qe41M6B1lkgw4PhIyhvw6Lw4nevU+E5EA/o2Pnj
 cz6An6HiNugwcrxnmm7oG0ttOiPjpt4HPt8jKSz/6pfDLYp/SPSTXCp0ILtfXz3x4
 7evrOP6aAstJPE/4Vy+BrMbT8gt1FVdfSvkKBZ7dVQC13t/eU9H8YbPiRH28OEvhX
 jyQKCLm3UTInH6ZCY96pnrQaEbV0BsQU2PLuwIfnSw7qArmkfmiSqTlOe+w3ZA/Xg
 JSYUJ7gPt2W5oouHjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.55.2.71] ([149.11.192.251]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxlzI-1spVLb2V1q-00vt6K; Wed, 08
 May 2024 14:09:37 +0200
Message-ID: <d906aedb-f3d3-4c2d-be3b-9ddc2c6cc902@gmx.de>
Date: Wed, 8 May 2024 14:09:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: capsule: detect possible ESP device path
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Weizhao Ouyang <o451686892@gmail.com>
References: <20240508112401.155528-1-o451686892@gmail.com>
 <c2323896-132a-4b02-86db-5cb62c6e1ba5@moroto.mountain>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <c2323896-132a-4b02-86db-5cb62c6e1ba5@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ISy7LzPnFuM3OB2AjCy4Ga4nD3G7kkcyCRXSS1mJyzyCuTKUad2
 V+d9QVBfy4T5SEBZQ0yoiyI6dvvH77AKtHk1KUHcIXkruPZUETYnUSu1MDOT5TVJM+qzFQP
 xqY/I1NkCeNjUfweIEBpIQS9EHWJimDNqT9al6lpTLkGy1x7imbu+ThLP6ePd1c7pATyzOd
 aSRj0rXX9+KhyPwDWIOYQ==
UI-OutboundReport: notjunk:1;M01:P0:QWJgqqz5DxM=;9HrM5DF0JABLGN3gJNwe74+lWLh
 qeY3rEDL8W3zlVswFxM5VBqlGM1k4H2LRWXfq2mgnVCsFS4fXJMAYAjWI9lG2kt8K/9HNJhXH
 9rlGIlyXfyhG1qaleAIPyfDlBRn5Kbviu58YMuo8z6NUMjo9wQHkO9UKQDNEMpaEXD/R47kmu
 54acQZ010YGma3NZ0cFktel9W2TZkYVZBsaXupJhgbcYcS6t/+yspAW5j8+HCjmt5AN36hFNs
 RiTK30OkaNWNAoMaMGkbR1XtrikVpbx1qkHv2cNLupGh2NDSzxAFhjALR6C4qCISTqQjTb/t9
 rL9iccdVj7B9oVb6oJ5bFI/aRjNoH1KCXoIVzMVB+NN5X7oJg4sI8Bwz+l92D5q0J0nU9DwTz
 iXhyUF48uP73jmBqTMlb6gX39Nc8Jc8jQ6CtC5R6vn7NkhjkCaNmKGB+PVcgiazbcJcw3f+ZH
 Z3ZIsqV+S30a669eiTNh6e8WyvMqB3nbp4gMmyWF8IJaAgqVTpkEuuCtElE2MkjioODCm7Rkl
 GaQSu0g/kpAgdqmUfOz187ZXU4596pDJe/8FoPmnJW9SMcyMBS3Qu/bdjSrL4Yi/pzpLANPvl
 DAMTzMBV5ga8e2hPBT5ukb9rWws2a92FrMAsQitCBIAk8TLcdtyCFG+W+9FZpGgECGFI8/aKV
 5LQnSL6JDtAnou9vMTlwfRnlDG1eLLpVTYdjloYAzBl7GPrtrS6ItpDEpopYOXdR5Ug4RbUG4
 V+ihhuAkCL/ea7l0wqDykk+bFNiSg8EROZvmEPa1/aGojX7C8fgfaXI+RJaqTPF8fgPwKheAD
 k9FNEBoZQ7jzdp6GfBDEVLjzDW8kQi0MRkhLFeKvRsrB4=
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

On 5/8/24 14:04, Dan Carpenter wrote:
> On Wed, May 08, 2024 at 07:24:01PM +0800, Weizhao Ouyang wrote:
>> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.=
c
>> index de0d49ebebda..919e3cba071b 100644
>> --- a/lib/efi_loader/efi_capsule.c
>> +++ b/lib/efi_loader/efi_capsule.c
>> @@ -922,6 +922,105 @@ static bool device_is_present_and_system_part(str=
uct efi_device_path *dp)
>>   	return true;
>>   }
>>
>> +/**
>> + * get_esp_from_boot_option_file_path - get the expand device path
>> + *
>> + * Get a possible efi system partition by expanding a boot option
>> + * file path.
>> + *
>> + * @boot_dev	The device path pointing to a boot option
>> + * Return:	The full ESP device path or NULL if fail
>> + */
>> +static struct efi_device_path *get_esp_from_boot_option_file_path(stru=
ct efi_device_path *boot_dev)
>> +{
>> +	efi_status_t ret =3D EFI_SUCCESS;
>> +	efi_handle_t handle;
>> +	struct efi_device_path *dp =3D boot_dev;
>> +	struct efi_device_path *full_path =3D NULL;
>> +
>> +	ret =3D EFI_CALL(efi_locate_device_path(&efi_simple_file_system_proto=
col_guid,
>> +					      &dp,
>> +					      &handle));
>> +	if (ret !=3D EFI_SUCCESS)
>> +		ret =3D EFI_CALL(efi_locate_device_path(&efi_block_io_guid, &dp, &ha=
ndle));
>> +
>> +	/* Expand Media Device Path */
>> +	if (ret =3D=3D EFI_SUCCESS && EFI_DP_TYPE(dp, END, END)) {
>
> Flip this around.  Always do failure handling.  Never do success
> handling.  full_path is always NULL.  Just return that.  Delete
> the variable.
>
> 	if (ret !=3D EFI_SUCCESS ||
> 	    !EFI_DP_TYPE(dp, END, END))
> 		return NULL;
>
>
>> +		struct efi_device_path *temp_dp;
>> +		struct efi_block_io *block_io;
>> +		void *buffer;
>> +		efi_handle_t *simple_file_system_handle;
>> +		efi_uintn_t number_handles, index;
>> +		u32 size;
>> +		u32 temp_size;
>> +
>> +		temp_dp =3D boot_dev;
>> +		ret =3D EFI_CALL(efi_locate_device_path(&efi_simple_file_system_prot=
ocol_guid,
>> +						      &temp_dp,
>> +						      &handle));
>> +		/*
>> +		 * For device path pointing to simple file system, it only expands t=
o one
>> +		 * full path
>> +		 */
>> +		if (ret =3D=3D EFI_SUCCESS && EFI_DP_TYPE(temp_dp, END, END)) {
>
> "Always" was hyperbole.  This success handling is fine.
>
>> +			if (device_is_present_and_system_part(temp_dp))
>> +				return temp_dp;
>> +		}
>> +
>> +		/*
>> +		 * For device path only pointing to the removable device handle, try=
 to
>> +		 * search all its children handles
>> +		 */
>> +		ret =3D EFI_CALL(efi_locate_device_path(&efi_block_io_guid, &temp_dp=
, &handle));
>
> ret is not used.  Delete.

Errors should be handled and not ignored.

>
>> +		EFI_CALL(efi_connect_controller(handle, NULL, NULL, true));
>> +
>> +		/* Align with edk2, issue a dummy read to the device to check the de=
vice change */
>> +		ret =3D EFI_CALL(efi_handle_protocol(handle, &efi_block_io_guid, (vo=
id **)&block_io));
>> +		if (ret =3D=3D EFI_SUCCESS) {
>
> 	if (ret !=3D EFI_SUCCESS)
> 		return NULL;
>
>> +			buffer =3D memalign(block_io->media->io_align, block_io->media->blo=
ck_size);
>> +			if (buffer) {
>
> 	if (!buffer)
> 		return NULL;
>
>
>> +				ret =3D EFI_CALL(block_io->read_blocks(block_io,
>> +								     block_io->media->media_id,
>> +								     0,
>> +								     block_io->media->block_size,
>> +								     buffer));
>
> Delete the unused "ret =3D " assignment.

ditto

Best regards

Heinrich

>
>> +				free(buffer);
>> +			} else {
>> +				return full_path;
>> +			}
>> +		} else {
>> +			return full_path;
>> +		}
>> +
>> +		/* detect the default boot file from removable media */
>> +		size =3D efi_dp_size(boot_dev) - sizeof(struct efi_device_path);
>> +		EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
>> +						  &efi_simple_file_system_protocol_guid,
>> +						  NULL,
>> +						  &number_handles,
>> +						  &simple_file_system_handle));
>> +		for (index =3D 0; index < number_handles; index++) {
>> +			EFI_CALL(efi_handle_protocol(simple_file_system_handle[index],
>> +						     &efi_guid_device_path,
>> +						     (void **)&temp_dp));
>> +
>> +			log_debug("Search ESP %pD\n", temp_dp);
>> +			temp_size =3D efi_dp_size(temp_dp) - sizeof(struct efi_device_path)=
;
>> +			if (size <=3D temp_size && !memcmp(temp_dp, boot_dev, size)) {
>> +				if (device_is_present_and_system_part(temp_dp)) {
>
> You could combine these conditions:
>
> 		if (size <=3D temp_size &&
> 		    memcmp(temp_dp, boot_dev, size) =3D=3D 0 &&
> 		    device_is_present_and_system_part(temp_dp)) {
> 			efi_free_pool(simple_file_system_handle);
> 			return temp_dp;
> 		}
>
>
>> +					efi_free_pool(simple_file_system_handle);
>> +					return temp_dp;
>> +				}
>> +			}
>> +		}
>> +
>> +		if (simple_file_system_handle)
>> +			efi_free_pool(simple_file_system_handle);
>> +	}
>> +
>> +	return full_path;
>> +}
>> +
>>   /**
>>    * find_boot_device - identify the boot device
>>    *
>> @@ -938,6 +1037,7 @@ static efi_status_t find_boot_device(void)
>>   	int i, num;
>>   	struct efi_simple_file_system_protocol *volume;
>>   	struct efi_device_path *boot_dev =3D NULL;
>> +	struct efi_device_path *full_path =3D NULL;
>
> No need to initialize this to NULL, it disables static checker warnings
> for uninitialized variables so it can lead to bugs.
>
>>   	efi_status_t ret;
>>
>>   	/* find active boot device in BootNext */
>> @@ -961,8 +1061,14 @@ static efi_status_t find_boot_device(void)
>>   			if (device_is_present_and_system_part(boot_dev)) {
>>   				goto found;
>>   			} else {
>> -				efi_free_pool(boot_dev);
>> -				boot_dev =3D NULL;
>> +				full_path =3D get_esp_from_boot_option_file_path(boot_dev);
>> +				if (full_path) {
>> +					boot_dev =3D full_path;
>
> Later, we free full_path but do we ever free the original boot_dev?
>
>> +					goto found;
>> +				} else {
>> +					efi_free_pool(boot_dev);
>> +					boot_dev =3D NULL;
>> +				}
>
> Better to delete indenting where you can:
>
> 			full_path =3D get_esp_from_boot_option_file_path(boot_dev);
> 			if (full_path) {
> 				boot_dev =3D full_path;
> 				goto found;
> 			}
> 			efi_free_pool(boot_dev);
> 			boot_dev =3D NULL;
>
> regards,
> dan carpenter
>
>

