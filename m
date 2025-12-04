Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7A6D206A7
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 14:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE9083C91;
	Thu,  4 Dec 2025 15:35:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AFRfiVy6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NTTW6XmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBFCD84073; Thu,  4 Dec 2025 15:34:58 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB06383A57
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 15:34:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B4AEuMJ1159643
 for <u-boot@lists.denx.de>; Thu, 4 Dec 2025 14:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oAFq+2HAZpK1K1X0S0e49bGnoS4WjZ0ZOtfGzBxbMa4=; b=AFRfiVy61mrW1XvW
 oST+narOiycw3M3aLihXd5+0RfqbV5OekX55qrNhYqZ+zvZrUM8Eq5QYvuMxUOEd
 LVwZ3Lhgi3jBkv3arj/r3ULUmxHse5yFB7L3QE2sqE57gs9Lpqu6Ws2yjdpU/flI
 2M5PFjqp3yZPzOuDeAELgiDK2TCkk8dlNYqbZr+DXUUBPUp38Zhq0rXB8IJ0gagc
 RfsTkCM3Grf0bKKJaVOUK5Z9BUfrpvEOpeA5n0IA1YGcrMpeS96PUa6ZytYR8Uj7
 e8Qurr8+JjMzO3dLS52Pg0GAa1xmAw9OOxvSrA0EsDb4UQSA1k1MK03HSEKghUrd
 vorPQw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atu3h32xv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 14:34:50 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7b9c91b814cso2569418b3a.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 06:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764858890; x=1765463690; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oAFq+2HAZpK1K1X0S0e49bGnoS4WjZ0ZOtfGzBxbMa4=;
 b=NTTW6XmAFdJt2p27d0x0LuXKQ2X3DBZZePZdy0FJhhhozSzR+O6VKt/PKE3ajg11vE
 kLXZDk7zs1zqU83+E+K0jeT7gt+F2EDZNfpQGjC55OkLBTlKROy0+ojtGPNkh+cS5AZ6
 H88qbfqZTYKDqPndD3BuE/F1nr9pi+Mrh94CNBqRrFPB0+xSCHpm74hts+H4B4WAkp5P
 ysD/Mp84AFhvrBTeWgds9yZFsx9W4ewYOD+eR0/QNkhOgdASOycKkmhnpqIjW7+bDmFs
 sxoNWdNhShrsKS8UM/yVuTm4XMndXgbrJuRdSnIdepECxHZX13r5JKjxNDsrwAFhdebj
 KtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764858890; x=1765463690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oAFq+2HAZpK1K1X0S0e49bGnoS4WjZ0ZOtfGzBxbMa4=;
 b=PW2NjrMAqf3fqyPv0ko1ZZKmDJlqGZv0D/cQefaSABxdEqeAnP5Yd0Otxdfb5p9ZLK
 nAquzhKWy94i0IRuxOuMgKljlaIAoP3fw7a/ElVhdRUsr3rlguQrbMmHjwrwWQxfQjNb
 g5+Aif7KvYCcNvI0fGBTjTMJaAsqyYNg0F7s/+8uN3LTADqvF/ySFzGINnbnIm9MDKTj
 msLo1mLCHm3QsRySO0GefphAGk9h2li8OzVn93xgr8NVaEhmZTqSE6/ZSHRPo4fxoZWQ
 1U/s3PYGgUT1K+okJb88lHg8K+uC0uGrDeV4pxj37rEKK8Mb8Cfcc/DTUmtecbZK5JuV
 KZSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCvhG1Hls7fuYFOaDV8x3iSv1/m3RPPRrWCyGQwZ2pUjrrh8YUafXt6L7l9t47UBvrxrFEDio=@lists.denx.de
X-Gm-Message-State: AOJu0YwgjK7shcjHPOT+UonjFacxlKlmuHyxa8+eNQbSh+VBFZRTYUqj
 slmsKAZEB6gw3XJ7/3Oz7RIQN4n7sHNl/axClOnQanLjHVRP6o0t77DWJSJd6ykmvjtfZ6JYcc6
 t3tAQl/ERsjUu1hLeBjSnl+imziYJmYYYjMSXHVNXGv3ARgBKUFlgrG/C
X-Gm-Gg: ASbGncu4hzoMjDjlDRGXpfz5JNboYJw3hQLYOHLPIiD0dfLFUnzcf3d2ZbOYzA12brh
 Dj9H6h7IlR51w71oQw0w7hWthV1hgUsqARcIkHxdK+c7hA0sCVx034BhiJBF9+T4y9v5cbv+6wl
 QNw+hsXMVAZ5V+HjLes85RyU6V47Gz4UG9LBjrjrGrgAClcYvfYrQw23Zit6EAv03jTVwENB2Xv
 5Kxf3oNbT2UwvYRbSCkLIloD8Gyzcp+PbRv4kViAM7w81Ir68XTQspRd/iERYid+ECJsXjHf2bm
 BQidJgKcYTyBHuNyYg7Erw5WRm1ecA7ntjjRkykLxXn/cn9bQoEtPh+GSbnPdmvg7beTsCOEz80
 Llj7aw6LVZzuDKMqlOe0V+w6Txn4zO3U9nBaJhxudaY/HdcU=
X-Received: by 2002:a05:6a00:2d02:b0:7a2:7c25:1f38 with SMTP id
 d2e1a72fcca58-7e22730f066mr3392788b3a.13.1764858890023; 
 Thu, 04 Dec 2025 06:34:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcb0k4EBT+beqLLgS7XaC5fVnfAmWGAw9PrQm4nB4C+r6fdFRO0gzM09rs/hqEQyXN05vzTg==
X-Received: by 2002:a05:6a00:2d02:b0:7a2:7c25:1f38 with SMTP id
 d2e1a72fcca58-7e22730f066mr3392745b3a.13.1764858889441; 
 Thu, 04 Dec 2025 06:34:49 -0800 (PST)
Received: from [192.168.0.2] ([183.82.176.248])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7e2adc5bf26sm2404171b3a.39.2025.12.04.06.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 06:34:48 -0800 (PST)
Message-ID: <e1c18e96-4a92-4eb6-b7a9-ad5f976ae57e@oss.qualcomm.com>
Date: Thu, 4 Dec 2025 20:04:41 +0530
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDExOCBTYWx0ZWRfX0QXI5EshG2/F
 gZeNlu1HqGCnrBGioG2PBONg6uPiXNC11nUOfrR+zE45LYCfrR0KYeFVA3l+eLVntZrPjRx9p1t
 eCZ0ZZ+iFUJDeav6TMGm3X0I3mHpnzsg2NV4G9+0CwmGqyKU8kWy9iUOKBL/tXUcHT0fHsDILxV
 X1qcTIrEJ1cdodIgQ9VC5YX5Q9kcGnwlr24WBPhykGvGLSdFNHsniErbFxiP/HgOTZWZVLtNSh4
 tu31H0ND94BpVceKh+Q9JwX3ClPYz/ozcJlRw9L7mGbOcchFBI4mTGiAiiR3rYcVhuk+wo8dg+t
 0SmYA75rlcVkAQRTCVezKijXBYD6Py8JgVr/8VYYeCL0BO1dyt4uu27GUByopOvsu37AQ1ZRcOU
 4Luw8sf1+atVtvfAqHfr8DRsTMcyCw==
X-Proofpoint-GUID: 6zukribnxJv9MD_gCF06VBmXcneKGwRx
X-Authority-Analysis: v=2.4 cv=KJxXzVFo c=1 sm=1 tr=0 ts=69319c0a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Exdw+z3Mhf6bEvtwTPgSdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=KKAkSRfTAAAA:8
 a=RF2hW3IrJVti4IgVq2cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6zukribnxJv9MD_gCF06VBmXcneKGwRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_03,2025-12-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512040118
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

Have tested this and verified.

Tested-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

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
