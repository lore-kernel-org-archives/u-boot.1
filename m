Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F0DC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 13:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18707874D5;
	Tue, 16 Jan 2024 14:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wJwIbR1V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9279874D5; Tue, 16 Jan 2024 14:45:51 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4079E870DF
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 14:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9F4873F277
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 13:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705412748;
 bh=FGKjH79oski5WyqjuGlcu3NDVef+Gy7Nc/Oe+aAi+vg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=wJwIbR1VkwIPGCPgB+OAXPCr1nI7JEDNRWjlXrLOAoSJl7WJlnZQQAdk6iOe0y93m
 LTimH9UF5rgdmj+1HgaOFe5ulffRDBOhkZtjg4IHOQ2Oe3EzCKJEFb2xmpk2hnGSEI
 T3fxt8go4FPejikaUOMyD+d03wBVjGpWO0CisftkWE25RUgWmy1hY5goAHNhDbBQi6
 R5KfFAvSPqg7+cqOwYEIg2dVWyM3BJfFP6TiHY58Qmg+7tpZIi2u83KzFjWlYZ7h/x
 mG5Xt6KSEVIV1UQwXdcBPUsUGFDp2M47QWkS1EvEaVAMRit10oSctICbDoTvf5K02A
 l5y6fktxuH6zw==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a28f6a78b83so623003866b.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 05:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705412748; x=1706017548;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FGKjH79oski5WyqjuGlcu3NDVef+Gy7Nc/Oe+aAi+vg=;
 b=cbcaObWDV1srypN5x38N+eT2bhBXgmEv+0sqXG/Cqqe35UF+Lt7qqrMMg9/5GQNju/
 uh21/BgSOEIyih34r/Uc/+YVgAxDReS5DZazOFak6BT/NPUcguQKLOQa6+9I0Q7Qcro4
 Q7SLx1NxkfjgyFWnKpwdtlP7+emG6N98fGqmJETePPDlyXCwNm0G7TAkaeOMCNFpuz8d
 HvrUZjJkfpym2BP2QQMBOJO/hqEyYzUuPSc+/JEW1JVEM4zqgNT4IKuOfEHPkHfxU2nB
 n8oBo3ws9QVQZ6a7xhR8y99ODTKHfSttGu9Zm6TfoXS9W2Z22yKKHD+Q2L1huzoL09NS
 eJCg==
X-Gm-Message-State: AOJu0YzAcIO5xZiBbs6EZyaFiRGhr1C4Y2V/7gYmEecKGUMsBiho5RXA
 BfXhD9vQFo1mb/3jgRrnBbAVesaQRQZmrD356Gs4KJfr69DIaldDMKVHizRbJPyaiZ66/UpU+KB
 Oo18PDODVMPpL1XTzSLgRfv5S2Cf29djwxol5ig==
X-Received: by 2002:a17:906:1619:b0:a28:af29:4d21 with SMTP id
 m25-20020a170906161900b00a28af294d21mr3293774ejd.120.1705412748153; 
 Tue, 16 Jan 2024 05:45:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYyYDY7lmT8ma2TJhaAYP8gN9XL7EZl96lM0D1FSLeow08ggHq91PUFAEKVqKFXNawPQnc5g==
X-Received: by 2002:a17:906:1619:b0:a28:af29:4d21 with SMTP id
 m25-20020a170906161900b00a28af294d21mr3293766ejd.120.1705412747830; 
 Tue, 16 Jan 2024 05:45:47 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 l16-20020a1709067d5000b00a26f6b8be1csm6477371ejp.75.2024.01.16.05.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 05:45:47 -0800 (PST)
Message-ID: <d3d71b07-9636-42e9-b29b-31ae84d8e4b4@canonical.com>
Date: Tue, 16 Jan 2024 14:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] part: Add a function to find ESP partition
Content-Language: en-US
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng@tinylab.org>, Tobias Waldekranz <tobias@waldekranz.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>
References: <20240116123643.563412-1-mchitale@ventanamicro.com>
 <20240116123643.563412-2-mchitale@ventanamicro.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On 16.01.24 13:36, Mayuresh Chitale wrote:
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

We want to be able to add the include to our API documentation. This 
requires adhering to the Sphinx documentation style.

%s/@Return the/Return:/

Cf. 
https://www.kernel.org/doc/html/v6.7/doc-guide/kernel-doc.html#function-documentation

Best regards

Heinrich

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
> +{ return false; }
> +
>   #endif /* CONFIG_PARTITIONS */
>   
>   #endif /* _PART_H */

