Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9793EC35FF4
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 08:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E53888CEF;
	Tue, 17 Sep 2024 10:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XgoCjlOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B31F988D2C; Tue, 17 Sep 2024 10:46:23 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B4988BDB
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 10:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 13F8A3F03F
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 08:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726562780;
 bh=k4jHMA9BJv/3q/WBDDe3hzmI/WuEu/vZbChnv9133h4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=XgoCjlOLcn9DrNtdkd09m1Iu24XkhoAjHtiv5pstbU6ooDSJXP4b5O9h1e1kIg1e6
 09vCsQbyQa3VBRph95Zq/sG7nQf8ZT2zeI29wmv2xn/Bdrg679jB70KGlziX9Op/5+
 TcKpPhvjOSZWT6cDT7+L9IGl5guqCm9WY5CqfVt64ww/ETECY7DQc+Ga1S7gNyQRns
 aL7FZFNpUiNed8w9NGtWCnbApy1Enuar0RrjrdlzTrueLGX/gtpoZGGwFapvCB64xZ
 LUGi4ODgTirxe/7ZfREt0CO16JF9DrlimHHeQRuIC5LNRuWZI9GFy2zE0m2acIgGew
 FBfWrtC9RA7nw==
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5c2486f1f14so3876612a12.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 01:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726562779; x=1727167579;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k4jHMA9BJv/3q/WBDDe3hzmI/WuEu/vZbChnv9133h4=;
 b=sdYHz3rqb7MiGVNGPqzhbTboArFNj8ZeQmdOlsZpQ9bjB3ohrYJsWzlDbQNTQV5EDZ
 QiAs03/ffV5PErHSzUNbPBrwa8LIKkxy3pJVkPYsEUKo5sLbKvo7cM5hIGN7aPsUgPwC
 K10LSgntPKJQ8av7vd1kO15Y1uLpEmLM8zFJWHqZ8HSTpMjehFt/8QEvFwX4QZ+XZYDu
 o8d8ph04JfbS5cwcRJ70PcFDWWniDKcjrG1hsHFbCbAQlUw8qMAODebU5mFnfhZObIZ8
 Rzbxut3u9OT/NgTodjC85Vq8tL9TNMH6y2Oy9DgpsOy9VjVLg6Dn2i6SWNMsU/x9AAKV
 5zEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEGVeXdanjmhlAjEkSHDi5A1kgNM+sACzyqtcxtN8LUNDPXOWnuXLIuuG0VgCn0w6Zt17OFeY=@lists.denx.de
X-Gm-Message-State: AOJu0YwDOzEc3KwMBStnw9bSMY/VcSx/pXil7ExvVNKwF/7XFTrTD7ef
 97Rp3AqprIw8YqhPVrVb0pbivdK3IJ68mL9M+8mmuDn4l+7CUXMEiBmlUaSY0rjKM+fel1Rv9kK
 wpyiGhMyM3Jv5WftaZF2eHATyVqNmFimCtsjt2GFCkBapfNMudgo02FgMG8nNFNzJbtY=
X-Received: by 2002:a05:6402:3895:b0:5be:fbe7:11ac with SMTP id
 4fb4d7f45d1cf-5c413e2dbd8mr17088244a12.20.1726562779465; 
 Tue, 17 Sep 2024 01:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOhBKLy6vY6LgutWpO8UfWlYatryUzyWH3Ygn6UD1BOm3k00dcylDjwW8iWg/GycWO2t7odA==
X-Received: by 2002:a05:6402:3895:b0:5be:fbe7:11ac with SMTP id
 4fb4d7f45d1cf-5c413e2dbd8mr17088216a12.20.1726562778804; 
 Tue, 17 Sep 2024 01:46:18 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:cb9:d923:66c6:59f7:a3da?
 ([2a02:3035:6e0:cb9:d923:66c6:59f7:a3da])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb49761sm3597425a12.15.2024.09.17.01.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 01:46:17 -0700 (PDT)
Message-ID: <5969429e-6362-4676-85c1-6d4412138a7b@canonical.com>
Date: Tue, 17 Sep 2024 10:46:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] efi_leader: delete rng-seed if having EFI RNG
 protocol
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
References: <20240914160812.43632-1-heinrich.schuchardt@canonical.com>
 <ZukjyhHgzQB3SCvf@hera>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZukjyhHgzQB3SCvf@hera>
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

On 9/17/24 08:38, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> On Sat, Sep 14, 2024 at 06:08:12PM +0200, Heinrich Schuchardt wrote:
>> For measured be boot we must avoid any volatile values in the device-tree.
>> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
>>
>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>> 	put log_debug() in else branch
>> ---
>>   include/efi_loader.h          |  2 +-
>>   lib/efi_loader/efi_dt_fixup.c | 16 +++++++++++-----
>>   lib/efi_loader/efi_helper.c   |  2 +-
>>   3 files changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>> index f84852e384f..511281e150e 100644
>> --- a/include/efi_loader.h
>> +++ b/include/efi_loader.h
>> @@ -567,7 +567,7 @@ efi_status_t EFIAPI efi_convert_pointer(efi_uintn_t debug_disposition,
>>   /* Carve out DT reserved memory ranges */
>>   void efi_carve_out_dt_rsv(void *fdt);
>>   /* Purge unused kaslr-seed */
>> -void efi_try_purge_kaslr_seed(void *fdt);
>> +void efi_try_purge_rng_seed(void *fdt);
>>   /* Called by bootefi to make console interface available */
>>   efi_status_t efi_console_register(void);
>>   /* Called by efi_init_obj_list() to proble all block devices */
>> diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
>> index 9d017804eea..b97758d1305 100644
>> --- a/lib/efi_loader/efi_dt_fixup.c
>> +++ b/lib/efi_loader/efi_dt_fixup.c
>> @@ -41,7 +41,7 @@ static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
>>   }
>>
>>   /**
>> - * efi_try_purge_kaslr_seed() - Remove unused kaslr-seed
>> + * efi_try_purge_rng_seed() - Remove unused kaslr-seed, rng-seed
>>    *
>>    * Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for randomization
>>    * and completely ignores the kaslr-seed for its own randomness needs
>> @@ -51,8 +51,9 @@ static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
>>    *
>>    * @fdt: Pointer to device tree
>>    */
>> -void efi_try_purge_kaslr_seed(void *fdt)
>> +void efi_try_purge_rng_seed(void *fdt)
>>   {
>> +	const char * const prop[] = {"kaslr-seed", "rng-seed"};
>>   	const efi_guid_t efi_guid_rng_protocol = EFI_RNG_PROTOCOL_GUID;
>>   	struct efi_handler *handler;
>>   	efi_status_t ret;
>> @@ -67,9 +68,14 @@ void efi_try_purge_kaslr_seed(void *fdt)
>>   	if (nodeoff < 0)
>>   		return;
>>
>> -	err = fdt_delprop(fdt, nodeoff, "kaslr-seed");
>> -	if (err < 0 && err != -FDT_ERR_NOTFOUND)
>> -		log_err("Error deleting kaslr-seed\n");
>> +	for (const char * const *pos = prop; pos < &prop[ARRAY_SIZE(prop)];
> 
> I think
> for (int i = 0; i < ARRAY_SIZE(prop); i++)
>      fdt_delprop(fdt, nodeoff, prop[i]);
> 
> is a lot easier to read

On RISC-V using an index needs 10 bytes more of binary code.
Easy to read and efficient are conflicting here.

I will respin the patch.

Best regards

Heinrich

> 
> Other than that, the patch looks fine
> 
> Thanks
> /Ilias
> 
>> +	     ++pos) {
>> +		err = fdt_delprop(fdt, nodeoff, *pos);
>> +		if (err < 0 && err != -FDT_ERR_NOTFOUND)
>> +			log_err("Error deleting %s\n", *pos);
>> +		else
>> +			log_debug("Deleted /chosen/%s\n", *pos);
>> +	}
>>   }
>>
>>   /**
>> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
>> index 96f847652ec..a481eb4b7e3 100644
>> --- a/lib/efi_loader/efi_helper.c
>> +++ b/lib/efi_loader/efi_helper.c
>> @@ -522,7 +522,7 @@ efi_status_t efi_install_fdt(void *fdt)
>>   	/* Create memory reservations as indicated by the device tree */
>>   	efi_carve_out_dt_rsv(fdt);
>>
>> -	efi_try_purge_kaslr_seed(fdt);
>> +	efi_try_purge_rng_seed(fdt);
>>
>>   	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
>>   		ret = efi_tcg2_measure_dtb(fdt);
>> --
>> 2.45.2
>>

