Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E0EC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 20:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A5E280756;
	Wed, 12 Mar 2025 21:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pOBvuCl/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29898807D7; Wed, 12 Mar 2025 21:10:58 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF376805D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 21:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9E5813F5B6
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741810254;
 bh=iqcZz8GOJQAcGD4apGTT/qN4Nz/uuNoOOnUHwPVWMCc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=pOBvuCl/bqHAsHrSeWjyZ91NDnMtXg2bzzfNn+P6QX+EKiNKVWve7bp8hJofMXSuo
 F53LvMRx26Ezrm1WUcZX1Ea5duyNs3mcgNkom0dGGcHHUHMXp7ilGmS3ZhHaR/x+4Y
 i0VGbF9jy6NwZl2ZQHJuFx07qA1/KZIOP5AHqsfZrRQ0qR/tgJreM7QCjD6WHLQLv+
 V+Iq4TIR1UXLOD+AshJwkuc79yyqaRde2WXoOASJQKfaYWh+NMVL/AI2rT8cQuGpTb
 zNplKhiI9+0pOOyVilkOnA1F/WyEti9aQ5Ems2W0ss5dJUx/g+MH04qlaoCvMNoatB
 mS3qBEwyzFVGQ==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390f3652842so107253f8f.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 13:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741810253; x=1742415053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iqcZz8GOJQAcGD4apGTT/qN4Nz/uuNoOOnUHwPVWMCc=;
 b=GE+bXPJSKqmt+DR1N9UA65G/Kgr5j0FCR0I0c+SkQVxmKHoVQpm6Ae4eXqFS1Bi124
 hzXuiD5SpzJQUwoV6H2U98kAmC66Z3sEMvS/GPka0a1TzWnRnAPxIH62GWlnv3XP4tN7
 tA+hWVc6w/6yEeafHvhDFvKOayEZul73vObRdO+Lz9prt9j6cZjRY1sS4WmTkSuWWY2/
 cJKiJSsoMyGEb0ZNno00m4Evwp5sZsF6Wg073vIumPFS6FKr1sWtcOHK/mh0ICSf5yF1
 yafhFahSNAF0zF2mQB33RT3K54SDFCmoTTwgEsHwtwua22uP/5euYbLSvwucUrUE1PFv
 SkwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2i+9LluU/WKJ2II6AUaR57MEWYh9Xozw567JuiFx4C2do/DLmWGTyYVUtHS8sdLXpI5XjDKI=@lists.denx.de
X-Gm-Message-State: AOJu0YwOeq6f+DC1xS5lt1/Hh/MmnU67yShPvReEerV33FQKf9H77PXe
 W2PGuXUdS21+aNLPTuI7c/r6FlVRLTGKHAbg1gYeDOaVt+kGUPCIdzLTQIYijyf9jT1FbebQJ9U
 T6rsrGYL7SZ23exbitCQlhRYErXSl4UK7Ap0DC9UNpUvsNOgr7tpv6pNjP7vWO4pWAMU=
X-Gm-Gg: ASbGnct2xCELT1mGrr1C4Xc9AvoV1n7dYfC5IO4US0Cy+9UJiD2fGpH05Cd9Cfw/O0O
 43ogyLPZ8DH9Pt6FqUwAhl1uH1ycHmasLSCzX0WEV2PThLKkT6eWUw6lkyEf++B4njJpzLbWBl1
 1RSab+odJF4MopVOwn6yDz3723vVgOr+C7nwJQ+R5zbZfzFKosEYygfWQYVxl9NHuK3TLKU6mJW
 Gq53112BY8wCBWiFpSsd9xmy84rV+/xAQUSWdnNLM3xkd/EcKHrwaKDVHyfHe1SbE3uWvAaLiSW
 /6UPPJBNUGofhdqIN7GYbAwQE6X7tSslYEERbtp1+FJ3XfSnTUfvinyeX51HDnCMEkQft9WF2hM
 8ODSQWQ==
X-Received: by 2002:a5d:64cb:0:b0:391:3fa7:bf66 with SMTP id
 ffacd0b85a97d-3913fa7c415mr15727793f8f.31.1741810253626; 
 Wed, 12 Mar 2025 13:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKIoQYgIxD4aALg3nFlRR1g2DgZFVP7A17s3VdWKfNUWvg8/1MYmCudf8p2fp5XeHGU1bH+g==
X-Received: by 2002:a5d:64cb:0:b0:391:3fa7:bf66 with SMTP id
 ffacd0b85a97d-3913fa7c415mr15727782f8f.31.1741810253204; 
 Wed, 12 Mar 2025 13:10:53 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:345b:e644:8505:68cc:d761?
 ([2a02:3035:6e0:345b:e644:8505:68cc:d761])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01cdd7sm22379863f8f.56.2025.03.12.13.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 13:10:52 -0700 (PDT)
Message-ID: <8d8b3709-3619-41c3-999c-2021ccb2300d@canonical.com>
Date: Wed, 12 Mar 2025 21:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/8] efi_loader: install device-tree on configuration
 table on every invocation
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-3-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250312085424.1201148-3-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12.03.25 09:54, Sughosh Ganu wrote:
> The efi_install_fdt() function is called before booting an EFI binary,
> either directly, or through a bootmanager. This function installs a
> copy of the device-tree(DT) on the EFI configuration table, which is
> passed on to the OS.
> 
> The current logic in this function does not install a DT if the table
> already has a DT installed on it. However, this existing copy of the

The device-tree is the configuration table. Maybe better write:

... if a device-tree is already installed as an EFI configuration table.

> DT might not be up-to-date, or it could be a wrong DT for the image
> that is being booted. Always install a DT afresh to the configuration
> table before booting the EFI binary.
> 
> Installing a new DT also involves some additional checks that are
> needed to clean up memory associated with the existing DT copy. Check
> for an existing copy, and free up that memory.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V7:
> * Change the type of fdt_pages to efi_uintn_t
> * Remove the check for either of fdt_pages or new_fdt_addr being 0
> * Change the format specifier for fdt_pages in the debug messages for
>    size_t
> * Put the assignment of new_fdt_addr and fdt_pages on separate lines
>    to avoid checkpatch error
> 
> 
>   lib/efi_loader/efi_helper.c | 32 ++++++++++++++++++++++----------
>   1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 15ad042bc61..37e5859741f 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -454,11 +454,21 @@ efi_status_t efi_env_set_load_options(efi_handle_t handle,
>    */
>   static efi_status_t copy_fdt(void **fdtp)
>   {
> -	unsigned long fdt_pages;
>   	efi_status_t ret = 0;
>   	void *fdt, *new_fdt;
> -	u64 new_fdt_addr;
> -	uint fdt_size;
> +	static u64 new_fdt_addr;
> +	static efi_uintn_t fdt_pages;
> +	ulong fdt_size;
> +
> +	if (new_fdt_addr) {
> +		log_debug("%s: Found allocated memory at %#llx, with %#zx pages\n",
> +			  __func__, new_fdt_addr, fdt_pages);
> +		ret = efi_free_pages(new_fdt_addr, fdt_pages);

We should not free the memory before removing the configuration table. 
Otherwise in an error situation we might end up with an invalid 
device-tree pointer.

/* Ignoring EFI_NOT_FOUND if not device-tree is installed */
efi_install_configuration_table(&efi_guid_fdt, NULL);
if (new_fdt_addr) {
	ret = efi_free_pages(new_fdt_addr, fdt_pages);
	...

> +		if (ret != EFI_SUCCESS) {
> +			log_err("Unable to free up existing FDT memory region\n");
 > +			return ret;> +		}

Ok, something weird happened. But this should not stop booting.

Just set new_fdt_addr = 0 in any case.

	if (ret!= EFI_SUCCES)
		log_err("Failed to free existing FDT memory\n");
	new_fdt_addr = 0;

> +	}
>   
>   	/*
>   	 * Give us at least 12 KiB of breathing room in case the device tree
> @@ -472,16 +482,21 @@ static efi_status_t copy_fdt(void **fdtp)
>   				 EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
>   				 &new_fdt_addr);
>   	if (ret != EFI_SUCCESS) {
> +		new_fdt_addr = 0;

efi_allocate_pages() only updates new_fdt_addr() in case of success.
If we set new_fdt_addr = 0 above, this line might be removed.

> +		fdt_pages = 0;

This line is not really needed as our if-statements don't use it.

Best regards

Heinrich

>   		log_err("Failed to reserve space for FDT\n");
> -		goto done;
> +		return ret;
>   	}
> +	log_debug("%s: Allocated memory at %#llx, with %#zx pages\n",
> +		  __func__, new_fdt_addr, fdt_pages);
> +
>   	new_fdt = (void *)(uintptr_t)new_fdt_addr;
>   	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
>   	fdt_set_totalsize(new_fdt, fdt_size);
>   
> -	*fdtp = (void *)(uintptr_t)new_fdt_addr;
> -done:
> -	return ret;
> +	*fdtp = new_fdt;
> +
> +	return EFI_SUCCESS;
>   }
>   
>   /**
> @@ -534,9 +549,6 @@ efi_status_t efi_install_fdt(void *fdt)
>   		const char *fdt_opt;
>   		uintptr_t fdt_addr;
>   
> -		/* Look for device tree that is already installed */
> -		if (efi_get_configuration_table(&efi_guid_fdt))
> -			return EFI_SUCCESS;
>   		/* Check if there is a hardware device tree */
>   		fdt_opt = env_get("fdt_addr");
>   		/* Use our own device tree as fallback */

