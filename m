Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D1EC47DBE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 01:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C68A879A0;
	Wed, 17 Jan 2024 02:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KRhZrnb3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E85A879A0; Wed, 17 Jan 2024 02:13:32 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7548187885
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 02:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78329cb6742so517870285a.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 17:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705454007; x=1706058807; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MwR2e0GZu1flqgDyTHfAwZCCWD4k4+OElx8qGOIz2/s=;
 b=KRhZrnb3S2CCBmB/OOkgIzjrgAuDrPT6HvoQFXB8b8ZSbeymtDlZHNOEs6vZ35UVyn
 xgvureF2vrmjSZbdYmwMnRwwriSKBjnKNhuVIlgBawmmCeLjAG9GpPYJOiphs9bh2wBd
 /HqSDUUhnRL/1KoXWi76XaCWJ1G0hkU+bS7Qsc4j3+MVnQ1hVausxPz1+5Zv970IwnuQ
 1NvnG595v8pxvTE7M1Ubl2UBFXrZDzty07L6/mASS5tas06YoWoRjUDjT5h0oYk5gvAP
 8YUfYRmYsV4eLmZggdhqoADnff26ZTz5lnkuXehs/XQCe9f5EZ9O8TC2C9yLSn5kc4T9
 f/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705454007; x=1706058807;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MwR2e0GZu1flqgDyTHfAwZCCWD4k4+OElx8qGOIz2/s=;
 b=jU/sOB46IxwlMrK5u7vl++2gL+THx7qV3MGmYZ3HLNPnT3lpqXb83K4AtLA0x0brE7
 GvCwT3ZzjmIRouwmSlkPbsTM8IDWPMBp2UVw9yuzriL/OuJWUm8LF3Q0pIapfdU5bSLU
 +P8XxPJQD1ycc6yyuSJvHZsZB7o/LGHOPBNWWhSCUFYCHuFam0IYeQiFQZ6XVJQ7ei6A
 fKrNa4K2k5/gFYPfnbP2RTYiJwdn74P5o1hpOX6Wgbo9uUoYAbNRY+c/164g9LAGnohp
 siEP8bsCjBVh4NCGiNxDz3AKXCUg45nY5rbw09BS1SuCDqrWQ/9kOFLzNWTa4izV6epc
 j6dw==
X-Gm-Message-State: AOJu0YwMQFscu0HjymbZGsJIzkTlF9HJgRubcuWWumK+K/CZkaEDplo4
 oXnA9bks8o5pQredm4kK/Jc=
X-Google-Smtp-Source: AGHT+IG7JHQgEBY92G72OCGR9OB8xF5GrbIjuoaP5mnOVaMIiuMnxxb9p9KQXRAT0hwkSD5FFl1KhQ==
X-Received: by 2002:a05:620a:372a:b0:783:17fe:103a with SMTP id
 de42-20020a05620a372a00b0078317fe103amr8887615qkb.19.1705454006478; 
 Tue, 16 Jan 2024 17:13:26 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a0e8200b00783534c512bsm2658586qkm.32.2024.01.16.17.13.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 17:13:26 -0800 (PST)
Message-ID: <e3e76e8a-74e8-baa9-3605-6a3b3c5290e6@gmail.com>
Date: Tue, 16 Jan 2024 20:13:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] part: Add a function to find ESP partition
Content-Language: en-US
To: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tobias Waldekranz <tobias@waldekranz.com>, Johan Jonker <jbx6244@gmail.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <20240116123643.563412-1-mchitale@ventanamicro.com>
 <20240116123643.563412-2-mchitale@ventanamicro.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240116123643.563412-2-mchitale@ventanamicro.com>
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

On 1/16/24 07:36, Mayuresh Chitale wrote:
> If a disk has an EFI system partition (ESP) then it can be used to
> locate the boot files. Add a function to find the ESP.
> 
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   disk/part.c    | 16 ++++++++++++++++
>   include/part.h | 11 +++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/disk/part.c b/disk/part.c
> index 36b88205eca..6b1fbc18637 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -848,3 +848,19 @@ int part_get_bootable(struct blk_desc *desc)
>   
>   	return 0;
>   }
> +
> +int part_get_esp(struct blk_desc *desc)
> +{
> +	struct disk_partition info;
> +	int p;
> +
> +	for (p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
> +		int ret;
> +
> +		ret = part_get_info(desc, p, &info);
> +		if (!ret && (info.bootable & PART_EFI_SYSTEM_PARTITION))
> +			return p;
> +	}
> +
> +	return 0;
> +}
> diff --git a/include/part.h b/include/part.h
> index db34bc6bb7d..30e049c8f19 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -690,6 +690,14 @@ int part_get_type_by_name(const char *name);
>    */
>   int part_get_bootable(struct blk_desc *desc);
>   
> +/**
> + * part_get_esp() - Find the EFI system partition
> + *
> + * @desc: Block-device descriptor
> + * @Return the EFI system partition, or 0 if there is none
> + */
> +int part_get_esp(struct blk_desc *desc);
> +
>   #else
>   static inline int part_driver_get_count(void)
>   { return 0; }
> @@ -700,6 +708,9 @@ static inline struct part_driver *part_driver_get_first(void)
>   static inline bool part_get_bootable(struct blk_desc *desc)
>   { return false; }
>   
> +static inline bool part_get_esp(struct blk_desc *desc)

Please use the same signature as above.

> +{ return false; }

The statement here should be on its own line.

--Sean

> +
>   #endif /* CONFIG_PARTITIONS */
>   
>   #endif /* _PART_H */

