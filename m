Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896FED2444A
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 17:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D63384127;
	Thu,  4 Dec 2025 18:35:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pX2rja9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42E2A84131; Thu,  4 Dec 2025 18:35:51 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A14FF8410C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 18:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 90DC14018D
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764869730;
 bh=9Lz1ixjf486ItYFjmlstZb9GBR/2MRpCh2BN721h3bY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=pX2rja9Iv126ZgnvkZjMFV9ZZ8n2g8MTGBv0GXbKJmSSIQbS1WtW/EvldsAsqKwQI
 9tFVI6sJeCh4Rn0exNm7ifWL6xEFwrpa827MJARezE0MMFuYmWEb1EpfJ4cGgTe6uN
 4XRhX7tupFBS6wOqa/ETde5rn/5DpNwegdk4g3xzgH8IGXfAKEs6hqZjLUieZOwaUY
 l2+UVQ1Z4UN4JV49pl1gFZJa49noyhlYTkDI0pKjvKQ5UH7cDruB4KfK6PgKG6E5wk
 Lz5sGfsSxermcKSW7XtKLdPsIm+3BVQ91X9Pf5FMvK8GjeVPvk88pIiMvBZXNkBf3u
 Mik5QB9Od4Yv+xmqYHngT5SNy+Q5rZ7KtNIhd1Z4f853Kcm/DJMLELuQm4xqJ/Bntp
 wQEI7T8eCHzP++oZfIvvLCR5qOzcC8rp1DJ147Mk8UQxHmpOgRvU+XyuGNj6Mrsfe0
 eskJCMIdRjg6dkcSKGXmGiUevV53YhUNAmBBepECB9+XMv+I894B8UDtqtJLyMik0q
 aMB6SuTj7G/vMEUH0g8n8chXqZaD+3yqCUEGz2Rlkb0JnCFeqApjt4jRabcKff4kE5
 NwyORFwKGW1RoSkEvPMHO+SUvIpROjcZzhaw+48PzfcmejYMy1oBWG5o0t+hMLP4bE
 /V9vv3YyYQsJy2MFgS+CIMw4=
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b7270cab7eeso102744966b.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 09:35:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764869729; x=1765474529;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Lz1ixjf486ItYFjmlstZb9GBR/2MRpCh2BN721h3bY=;
 b=FIiz4vr3qS9M6gxrMQnlV5Nmjk5ewJbcsyvU9Hg2ETo6PBajDqq8d04iWKx/qrpt9v
 W/Cjrad02VVgTiPrzSAe4oRuDmxyAkF+kDQ272hpCT8+kZw3G7igLGNoFArSYtmFZ5wv
 5yd4eNBlGDulEGtVBbZ3XiHH2xOfu1A8f8ryEEqakkU6d17PWPumJ4bBnkJXpwI0Bx6i
 QGaasej66OTK1niofHT0YM4SxyLgSNsKqoBxE51r0l2ri77yt32bWjJyyBo9a9ZlhaDs
 +l6YpWiKAFmDzci0Z5NhwVMrgA0CkRQmeRFvfRtxtCGgm7y4kUkbhjk5s4da1mgREulS
 kohA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUjkEV5omddo+ABNY+OqgPo4ZTrBnnXwS+gG/xaE/bgm65mh1LIp5WXheWY0WyBLdjCWwkpAw=@lists.denx.de
X-Gm-Message-State: AOJu0YyUuEk1Sigu4wNQW2pAmch4U5ymlmLgeixB7SytTBtXS3Nqe3fd
 lO6OJavoJGnDM1RMkdDF1B0xjejAUMQBwJHyA3ENBDqHMy4fKjUb7E40CsZofBqYWqFPlmFVhQU
 pmG/KcB54jAQ5iyHbeEsqUQkACvHBSTzuhZ8Ej0+2rXcn8x970KxLmwu7pNg5R5WsExC396M=
X-Gm-Gg: ASbGncsPzzQFj0Hz5kmiVNPFAyqkX2M9O66YpnO2MC7xflbjHw2bLXxLctnxzE0kpuF
 0Z3teVfDXwsy/WVO/Hh1P6XkDmjitTiSDvOFXJwvB9nRidy3y0V2gWOpIN1uFHVfX5rt+a5W49n
 VUdUPKNJkUO3MWcDuCbvMbuzJKypqd6G07TFrrSnb9kz2aFGmjWVmEFr3tiI/Rh2D20Jj1JcJuX
 UBskLvJfMt7enMdlGjUj370//Yiq4uxIomB+a1f+QGKCMFHW+Ee77Y/rxXw55VLkd4MtLZyWLd8
 b20fmW+5PK0HhVlbmalfSfiefXO8fqdLy04Tu05U1t3ojkOZGLRAcXwcrvmqb2oOMRxjBZO0Dz4
 PyqP6Ng8fENsmddR8cvTiYqcg4LX5qs+tRcJW1Lj9OI8YEi+ZHsmNEd+45uxPNsMZnXqMTTpaXl
 nW/PnSEeA=
X-Received: by 2002:a17:907:3e93:b0:b76:d548:f85b with SMTP id
 a640c23a62f3a-b79ec419633mr400024266b.11.1764869728882; 
 Thu, 04 Dec 2025 09:35:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMhVrMFY8IFmS03vcqu/PJPMT88BKoqkfyVGLazr3cJ1awloFkvpEFu5JbZVp593GBytlbxg==
X-Received: by 2002:a17:907:3e93:b0:b76:d548:f85b with SMTP id
 a640c23a62f3a-b79ec419633mr400020266b.11.1764869728298; 
 Thu, 04 Dec 2025 09:35:28 -0800 (PST)
Received: from [192.168.103.124]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4a558b3sm184423666b.69.2025.12.04.09.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 09:35:27 -0800 (PST)
Message-ID: <e6618a34-c767-4046-b8a3-47340f04c0a5@canonical.com>
Date: Thu, 4 Dec 2025 18:35:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Trigger capsule updates with automatically
 generated boot options
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 John Toomey <john.toomey@amd.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Yao Zi <ziyao@disroot.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>, u-boot@lists.denx.de
References: <20251202085101.1344799-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251202085101.1344799-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/2/25 09:50, Ilias Apalodimas wrote:
> The EFI spec in §8.5.5 says
> "The directory \EFI\UpdateCapsule is checked for capsules only within
>   the EFI system partition on the device specified in the active boot
>   option determine by reference to BootNext variable or BootOrder variable
>   processing."
> 
> Automatically generated boot options don't point to the ESP, they point to
> the disk itself and find_handle() won't match when searching for an ESP
> during a capsule update.
> This happens because find_handle() only matches device paths that are
> shorter or equal to the device path passed as an argument.
> Since the EFI spec allows it we want to allow capsule updates, when the
> boot option points to a disk, but that disk contains an ESP with a
> \EFI\UpdateCapsule  directory.
> 
> find_handle() implicitly changes it's behavior depending on the passed
> arguments as well. If the 'rem' ptr is not valid it will only search for
> an exact match. Otherwise it will match on the best match and return the
> remaining portion of the matched device path to 'rem'.
> 
> Tweak this slightly and pass an enum with 3 options
> - EXACT   - Exact match, as if 'rem' was NULL
> - SHORTER - Match a shorter device path and put the remainder in 'rem'
> - LONGER  - Inverse the logic and match a longer device path. Put the
>              remainder into 'rem'.
> 
> To avoid any regressions, LONGER is only used during capsule updates and
> since 'rem' always carries the remainder of the matched device path we
> can plug it in with minimal changes.
> 
> Reported-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reported-by: John Toomey <john.toomey@amd.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> 
> John, Balaji, can you check if this fixes your problem?
> 
>   cmd/eficonfig.c                  |  2 +-
>   include/efi_device_path.h        | 10 +++---
>   lib/efi_loader/efi_bootmgr.c     |  6 ++--
>   lib/efi_loader/efi_boottime.c    |  5 +--
>   lib/efi_loader/efi_capsule.c     | 20 +++++++-----
>   lib/efi_loader/efi_device_path.c | 55 +++++++++++++++++++++++++-------
>   lib/efi_loader/efi_disk.c        |  2 +-
>   7 files changed, 70 insertions(+), 30 deletions(-)
> 
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index d8d946c87ac8..e317f3c90c14 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -1321,7 +1321,7 @@ static efi_status_t prepare_file_selection_entry(struct efimenu *efi_menu, char
>   		return EFI_OUT_OF_RESOURCES;
> 
>   	/* get the device name only when the user already selected the file path */
> -	handle = efi_dp_find_obj(file_info->dp_volume, NULL, NULL);
> +	handle = efi_dp_find_obj(file_info->dp_volume, NULL, NULL, false);
>   	if (handle) {
>   		ret = efi_disk_get_device_name(handle, devname, EFICONFIG_VOLUME_PATH_MAX);
>   		if (ret != EFI_SUCCESS)
> diff --git a/include/efi_device_path.h b/include/efi_device_path.h
> index aae85228f681..f9c538730c94 100644
> --- a/include/efi_device_path.h
> +++ b/include/efi_device_path.h
> @@ -73,13 +73,15 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp);
>    *
>    * If @rem is provided, the handle with the longest partial match is returned.

 From the description I would no know what the function does.

This description needs to be updated to explain what efi_dp_find_obj() 
does in case of inversed_match = 0 or 1.

- for device paths that are longer than some dp with the GUID installed
- for device paths that equal to some dp some dp with the GUID installed
- for device paths that are shorter then some dp with the GUID installed

Which devices will match?
Which devices will be preferred?


>    *
> - * @dp:     device path to search
> - * @guid:   GUID of protocol that must be installed on path or NULL
> - * @rem:    pointer to receive remaining device path
> + * @dp:			device path to search
> + * @guid:		GUID of protocol that must be installed on path or NULL
> + * @rem:		pointer to receive remaining device path
> + * @inversed_match:	Match even if the dp is shorter. rem will stil hoild the

%s/Match/match/ to keep capitalization consistent

%s/stil hoild/still hold/

> + *                      remaining device path
>    * Return:  matching handle
>    */
>   efi_handle_t efi_dp_find_obj(struct efi_device_path *dp, const efi_guid_t *guid,
> -			     struct efi_device_path **rem);
> +			     struct efi_device_path **rem, bool inversed_match);
> 
>   /**
>    * efi_dp_last_node() - Determine the last device path node before the end node
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a687f4d8e85c..df7500a94876 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -84,7 +84,8 @@ struct efi_device_path *expand_media_path(struct efi_device_path *device_path)
>   	 * booting from removable media.
>   	 */
>   	handle = efi_dp_find_obj(device_path,
> -				 &efi_simple_file_system_protocol_guid, &rem);
> +				 &efi_simple_file_system_protocol_guid, &rem,
> +				 false);
>   	if (handle) {
>   		if (rem->type == DEVICE_PATH_TYPE_END) {
>   			char fname[30];
> @@ -625,7 +626,8 @@ static efi_status_t try_load_from_media(struct efi_device_path *file_path,
>   	struct efi_device_path *rem, *dp = NULL;
>   	struct efi_device_path *final_dp = file_path;
> 
> -	handle_blkdev = efi_dp_find_obj(file_path, &efi_block_io_guid, &rem);
> +	handle_blkdev = efi_dp_find_obj(file_path, &efi_block_io_guid, &rem,
> +					false);
>   	if (handle_blkdev) {
>   		if (rem->type == DEVICE_PATH_TYPE_END) {
>   			/* no file name present, try default file */
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index ddc935d22409..0391b92a8be4 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -1816,7 +1816,8 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
>   	info->system_table = &systab;
> 
>   	if (device_path) {
> -		info->device_handle = efi_dp_find_obj(device_path, NULL, NULL);
> +		info->device_handle = efi_dp_find_obj(device_path, NULL, NULL,
> +						      false);
> 
>   		dp = efi_dp_concat(device_path, file_path, 0);
>   		if (!dp) {
> @@ -2016,7 +2017,7 @@ efi_status_t efi_load_image_from_path(bool boot_policy,
>   	*size = 0;
> 
>   	dp = file_path;
> -	device = efi_dp_find_obj(dp, NULL, &rem);
> +	device = efi_dp_find_obj(dp, NULL, &rem, false);
>   	ret = efi_search_protocol(device, &efi_simple_file_system_protocol_guid,
>   				  NULL);
>   	if (ret == EFI_SUCCESS)
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index eafc647f558f..103328c76a6e 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -886,18 +886,18 @@ static efi_status_t get_dp_device(u16 *boot_var,
>    * @dp		device path
>    * Return:	true - yes, false - no
>    */
> -static bool device_is_present_and_system_part(struct efi_device_path *dp)
> +static bool device_is_present_and_system_part(struct efi_device_path *dp,
> +					      struct efi_device_path **rem)

Please, update the function description to make it clear what the 
changed logic is.

The name of the function seems no longer to match what it does.

>   {
>   	efi_handle_t handle;
> -	struct efi_device_path *rem;
> 
>   	/* Check device exists */
> -	handle = efi_dp_find_obj(dp, NULL, NULL);
> +	handle = efi_dp_find_obj(dp, NULL, NULL, false);
>   	if (!handle)
>   		return false;
> 
>   	/* Check device is on system partition */
> -	handle = efi_dp_find_obj(dp, &efi_system_partition_guid, &rem);
> +	handle = efi_dp_find_obj(dp, &efi_system_partition_guid, rem, true);
>   	if (!handle)
>   		return false;
> 
> @@ -919,7 +919,7 @@ static efi_status_t find_boot_device(void)

Please, describe the search logic in the function description.

>   	efi_uintn_t size;
>   	int i, num;
>   	struct efi_simple_file_system_protocol *volume;
> -	struct efi_device_path *boot_dev = NULL;
> +	struct efi_device_path *boot_dev = NULL, *rem = NULL;
>   	efi_status_t ret;
> 
>   	/* find active boot device in BootNext */
> @@ -940,7 +940,7 @@ static efi_status_t find_boot_device(void)
> 
>   		ret = get_dp_device(boot_var16, &boot_dev);
>   		if (ret == EFI_SUCCESS) {
> -			if (device_is_present_and_system_part(boot_dev)) {
> +			if (device_is_present_and_system_part(boot_dev, &rem)) {
>   				goto found;
>   			} else {
>   				efi_free_pool(boot_dev);
> @@ -967,7 +967,7 @@ skip:
>   		if (ret != EFI_SUCCESS)
>   			continue;
> 
> -		if (device_is_present_and_system_part(boot_dev))
> +		if (device_is_present_and_system_part(boot_dev, &rem))
>   			break;
> 
>   		efi_free_pool(boot_dev);
> @@ -977,7 +977,11 @@ found:
>   	if (boot_dev) {
>   		log_debug("Boot device %pD\n", boot_dev);
> 
> -		volume = efi_fs_from_path(boot_dev);
> +		if (rem->type == DEVICE_PATH_TYPE_END)
> +			volume = efi_fs_from_path(boot_dev);
> +		else
> +			volume = efi_fs_from_path(rem);
> +
>   		if (!volume)
>   			ret = EFI_DEVICE_ERROR;
>   		else
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index b3fb20b2501e..ad7f452c411b 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -30,6 +30,12 @@ const struct efi_device_path EFI_DP_END = {
>   	.length   = sizeof(EFI_DP_END),
>   };
> 
> +enum match {
> +	EXACT,
> +	SHORTER,
> +	LONGER
> +};

Please, document the enum and its values according to
https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-and-enumeration-documentation

> +
>   #if defined(CONFIG_MMC)
>   /*
>    * Determine if an MMC device is an SD card.
> @@ -109,10 +115,11 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
>    */

Please, document the new parameter.

Please, update the function documentation so that the logic is evident 
without reading the code.

Once we have a description of what the changed functions should do we 
need to implement tests in test/lib/ that verify the correctness.

Best regards

Heinrich

>   static efi_handle_t find_handle(struct efi_device_path *dp,
>   				const efi_guid_t *guid, bool short_path,
> -				struct efi_device_path **rem)
> +				struct efi_device_path **rem,
> +				enum match match)
>   {
>   	efi_handle_t handle, best_handle = NULL;
> -	efi_uintn_t len, best_len = 0;
> +	efi_uintn_t len, match_len = 0, best_len = 0;
> 
>   	len = efi_dp_instance_size(dp);
> 
> @@ -137,22 +144,35 @@ static efi_handle_t find_handle(struct efi_device_path *dp,
>   			if (!dp_current)
>   				continue;
>   		}
> -		len_current = efi_dp_instance_size(dp_current);
> -		if (rem) {
> +
> +		match_len = len_current = efi_dp_instance_size(dp_current);
> +		switch (match) {
> +		case EXACT:
> +			if (len_current != len)
> +				continue;
> +			break;
> +		case SHORTER:
>   			if (len_current > len)
>   				continue;
> -		} else {
> -			if (len_current != len)
> +			break;
> +		case LONGER:
> +			if (len_current < len)
>   				continue;
> +			match_len = len;
> +			break;
>   		}
> -		if (memcmp(dp_current, dp, len_current))
> +
> +		if (memcmp(dp_current, dp, match_len))
>   			continue;
>   		if (!rem)
>   			return handle;
>   		if (len_current > best_len) {
>   			best_len = len_current;
>   			best_handle = handle;
> -			*rem = (void*)((u8 *)dp + len_current);
> +			if (len_current <= len)
> +				*rem = (void *)((uintptr_t)dp + len_current);
> +			else
> +				*rem = (void *)((uintptr_t)dp_current + match_len);
>   		}
>   	}
>   	return best_handle;
> @@ -160,14 +180,25 @@ static efi_handle_t find_handle(struct efi_device_path *dp,
> 
>   efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
>   			     const efi_guid_t *guid,
> -			     struct efi_device_path **rem)
> +			     struct efi_device_path **rem, bool inversed_match)
>   {
>   	efi_handle_t handle;
> 
> -	handle = find_handle(dp, guid, false, rem);
> +	handle = find_handle(dp, guid, false, rem, EXACT);
>   	if (!handle)
> -		/* Match short form device path */
> -		handle = find_handle(dp, guid, true, rem);
> +		handle = find_handle(dp, guid, true, rem, EXACT);
> +	if (handle)
> +		return handle;
> +
> +	handle = find_handle(dp, guid, false, rem, SHORTER);
> +	if (!handle)
> +		handle = find_handle(dp, guid, true, rem, SHORTER);
> +
> +	if (inversed_match && !handle) {
> +		handle = find_handle(dp, guid, false, rem, LONGER);
> +		if (!handle)
> +			handle = find_handle(dp, guid, true, rem, LONGER);
> +	}
> 
>   	return handle;
>   }
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 130c4db9606f..0d3d7c187d72 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -339,7 +339,7 @@ efi_fs_from_path(struct efi_device_path *full_path)
>   	efi_free_pool(file_path);
> 
>   	/* Get the EFI object for the partition */
> -	efiobj = efi_dp_find_obj(device_path, NULL, NULL);
> +	efiobj = efi_dp_find_obj(device_path, NULL, NULL, false);
>   	efi_free_pool(device_path);
>   	if (!efiobj)
>   		return NULL;
> --
> 2.51.0
> 

