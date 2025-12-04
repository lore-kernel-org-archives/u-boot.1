Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F127D1CDDD
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80CBD83F7D;
	Thu,  4 Dec 2025 05:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KsyfQ5Tp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ioMpBnkE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 775A683FA5; Thu,  4 Dec 2025 05:42:48 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F169183F6E
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:42:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B42Ltbr122728
 for <u-boot@lists.denx.de>; Thu, 4 Dec 2025 04:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QNasnbIIRzDVp53BldwNinzdWFzHPCt+Ad2YSTpqG0o=; b=KsyfQ5Tptxmmv7oD
 R9WJN6JbjRnH2WSsrSRrT3seqh/1sfoFP6HdjbO/n1Jp5Vl+p/ZU1x58Zx97wN8I
 pO1vd4hX17ZYfyOaovQHAnDTn7ZX3+ZT2nZ3aX4d1DljiXDikmsFac7t/vDoGjVS
 5yNSZKJrTQaTLrmVPyu8YsBUqQUcnf5oB6VFAng/XQA2ketQt94UHBNASiIHALCO
 0qQv/vi6KhhT+3GpwyGCjnHCitYgFIc7z5XI/nFpzvBtaeCa41XoK0Nt08pbqiuz
 kYTB2rXFejiH2SfjZ8Hy4nIiAkRAVXJINmKLh5DXkJG1dU8CVzCNWE1GHL0z03Cj
 +s6J/Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4au1f00a3y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 04:42:44 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7bf5cdef41dso917677b3a.0
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 20:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764823363; x=1765428163; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QNasnbIIRzDVp53BldwNinzdWFzHPCt+Ad2YSTpqG0o=;
 b=ioMpBnkEbrbtaLaoghsR3NbANusjq4m+wpXIYBZs/ttQXCY8HvQ53VsFUEoQpRAUHf
 AJ+mCdLrQH6oplOeI51NtwGYOtH610Ww5J63+BnalxJfQHpvYX1XrijGk2VgUgxx1OMD
 Yqi+V43OvaHSiZnQeYnK7Na3uqOuaI1TYPnq4ZepcS0G8WMSVB02QmWzG4c8OLQhU1kf
 CpiuCL3jiL6q1JnnWaIppBb8IDc1cxkZmfDhcY8WdnwCvVQVfs+319W6pwaI9SqOqm4O
 6NWqqUCVyh7YdYFEN6zcUibLXEyZHVhZ/iXa1+d/ESD69etTv77+XmQNekBelgfKeUEJ
 Ujlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764823363; x=1765428163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QNasnbIIRzDVp53BldwNinzdWFzHPCt+Ad2YSTpqG0o=;
 b=LwQkzKUse8eYqWMErt8/OTqF9+VYCtXJgQPvObFbaWDgF+lxDWHkVJNcA81T4fqoKL
 IdYhHrusOAWTJGtT882E2QGkysWi+sqBzwIFF6vwpPzw/v1kFH6tfpF0vBEANuCM4BIO
 u7ONq8E5IjGWOXmiBCU8cZ3QleCEGVbp+0FN727p0Dk7WRjf0oYzZJ/ZHMkLPvgRqMoR
 8ut/QJ5wr4HkJeer9/3J8o0vol5PwMEYtnfN75HBUef+BEbkKtDXA6muyIHxv0UdTDZe
 DTVqPqEk/GUvwsuOpIh7vfhT6QsDy8fw1wQ1l9BcuhdaO6c2yzkSmxbCUJIvhUHk4ZQs
 Jj5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnF3m+NkMlP4hOm85hYQdkT4pT2gc3BATf1ajHkZ27u+YOP+zCYdd0Z0AwnLWLxEsuYx6ZFMs=@lists.denx.de
X-Gm-Message-State: AOJu0YwSqQemetBMoBmDRyj3IRssPF53i7pkS26AtPlWUy+Z6HnjHAGG
 Ky284xlHtw0aMlA39AISodxnuFnBokDAxlq/uUqAIbU/PgeprFJf9K6tj7AFd91ShdM1L+m692L
 TWe71nf+/d6OLz6ln2FXx9ipcJBV3T5nxJNHoBIl1icZp5C83B2mH4HeU
X-Gm-Gg: ASbGncvQlrjXyXUyujqLB0o7En3wJi9U3A68Ni8XZoUYiZnuR9fTsVvpCNrrZk7OMgF
 kv6rcrILBCde+zwiEvcuaMSZMFTt7HZKtrXh6oCdu8tQwPbktsPFujkowHJYUCl7iu+P1oCz1Lr
 vXwlMGRgu3HcnptfiGSOdDS468fS1hW5fAdhpw62JUbPBGP1MtDjdykypM2GSPlJhmMVtWZ/fu2
 RCEnUvrFEHf8JegUmZFblAZI5LYx0r044OVt9mB4/ugQK7DJAeCRSxajEjEfLEkGhKXVRkFssVj
 Sq45rYdEx1RGR4HbM5e+7iAyyZDWpYSrEK7cXJaM6ySWKxcbOrwshUXt2P43y0EA2M18rV8bXK2
 g6p5eRjKLLdAhZandh64yY2/zEQCjau//cuKcCRKY+0HQbg==
X-Received: by 2002:a05:6a00:39a5:b0:7b8:b1ff:be51 with SMTP id
 d2e1a72fcca58-7e00dde19d0mr6021519b3a.18.1764823363172; 
 Wed, 03 Dec 2025 20:42:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb374YUpfiVNyL942sGofjerTA+TD7MVt4YjiiiJYJqzxO85Fn+QVkYB9hwUp9e024NYIZnw==
X-Received: by 2002:a05:6a00:39a5:b0:7b8:b1ff:be51 with SMTP id
 d2e1a72fcca58-7e00dde19d0mr6021479b3a.18.1764823362536; 
 Wed, 03 Dec 2025 20:42:42 -0800 (PST)
Received: from [10.151.40.76] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7e2a0a0066asm626289b3a.29.2025.12.03.20.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 20:42:42 -0800 (PST)
Message-ID: <b52c69db-5663-42c7-b26a-6178c88815b6@oss.qualcomm.com>
Date: Thu, 4 Dec 2025 10:12:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Trigger capsule updates with automatically
 generated boot options
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 heinrich.schuchardt@canonical.com
Cc: John Toomey <john.toomey@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
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
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20251202085101.1344799-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ev0CaRgGKKBE85jwRiJ83kBhDg2_wkAC
X-Proofpoint-ORIG-GUID: Ev0CaRgGKKBE85jwRiJ83kBhDg2_wkAC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDAzNSBTYWx0ZWRfX+wTKZ3KPA088
 Aj3aGYybN21S4/8BlGv6l/V/NBgdKGg5PqyD0lAxF4nIOCwXBM9RHMhtUOlEbWbihbG8NitD5E0
 Td601cY6fhuojRi0ib9TpYFCXV/flH0hjY5iUtYKE+HdCZUClCjaM8CiXCQF/EsquogKGk4r5st
 whdVB9UiNH1UMSh0bp9E1M++dZZWOf4oXuglN2r5vX3AqnDrI1svRfVf7YCs6M4aHw4EbIdIweY
 O3poiqCcvOYrXDM2j9bCH1salpJ88hjEbwmiAbiaPEXuBtXjHXeBEFcyUNTnD6jTNDLekuDgHnN
 Zp2yQ2WsPMvfVm1bL870KxD0FZzLRsI8dUdvJkH2znDWzO/Urf6tyHI6qRtMJCJ6DhA7h/pXCe0
 gSs8oCNVUayoI2P55efGJGs6PXs9TA==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=69311144 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=KKAkSRfTAAAA:8
 a=RF2hW3IrJVti4IgVq2cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_01,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512040035
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


On 12/2/2025 2:20 PM, Ilias Apalodimas wrote:
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

Hi Ilias,

Thanks for this patch. This fixes the problem and have verified the patch.

Regards,

Balaji

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
>    *
> - * @dp:     device path to search
> - * @guid:   GUID of protocol that must be installed on path or NULL
> - * @rem:    pointer to receive remaining device path
> + * @dp:			device path to search
> + * @guid:		GUID of protocol that must be installed on path or NULL
> + * @rem:		pointer to receive remaining device path
> + * @inversed_match:	Match even if the dp is shorter. rem will stil hoild the
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
> +
>   #if defined(CONFIG_MMC)
>   /*
>    * Determine if an MMC device is an SD card.
> @@ -109,10 +115,11 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
>    */
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
