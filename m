Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CB7F5A8C5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28891842C7;
	Tue, 21 Apr 2026 00:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ATEm8nNl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD89842C7; Tue, 21 Apr 2026 00:35:45 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 041B1842B7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so3249332a34.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776724542; x=1777329342;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CST7TXWWzSMmnJhZklJi3jRlJGK4OHJf36o44Bveutg=;
 b=ATEm8nNliuuqs0R8J61QTTBWZXuw3wMBN7/9MOub9AiiQGYfD+DlHGx5zKlyamWWW1
 iFPU1UgRX4g4c9ZA6Ao5CSIa/FpJY727VIz5g9+7shuMj4RJJofj89Mmdd061y5Ldqb8
 Yswss/E5geFKv1g5BLHl/xCAzmxAk/VFPLwSNLIASvRKvGnuX6WHDyGI1xuXjl7+8apJ
 tvh89qGHrynHXGojUo9xTC7jpA/ixu4Z73EeLjo1WQDglVDWy+ZUYtc3e5sbDVfwx0cf
 0urJNVkQLKkTrX2knxxz2wJNEhUBVnXLQBrbJRiTS1m/GC4u8H3yMPnCS8iXDUn9DLaQ
 aRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776724542; x=1777329342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CST7TXWWzSMmnJhZklJi3jRlJGK4OHJf36o44Bveutg=;
 b=oJMytRJBnXsuNGCDBdzV5d5mt+1xWFQ9lipfSTfQWZFitol1cKgm02trlzooLqK646
 t8SaSNKyZ6ms6CkBagGsAA6yRMypBGeS17lHFpxDW7+ZnHao2eXf0+IcQ2liU5o1b/PT
 w7JssEX4J2FQbWhtrX06DBHbWtPf7syP0pO75A/lejQxn/vORueIK0n7OY820YUkLee/
 PQUwk3T6wuNn4Ky6rDyPxY6ndHB+iukzjADYvdpMoz/15LK2G3m2XM3y4KVntDwG+o+4
 DC1gMWtU4poe0NVGIGWg+nUI+GXKRMkRdmCwMD5keuyGs+Bm91FRamjJYOAXORiKZ9f/
 2EMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jO4y7CRZVyKmK5mW689YUdT7AQfDJeeo27EFRXu77mrylUNPyZdAkphkxbuxAa7hix3Pd/E8=@lists.denx.de
X-Gm-Message-State: AOJu0YxapCZ6snZLfbhRHjwIF3R5Kkfnxtx28Hly73gCC/eWgsdRtO3/
 PKIKqaRziaHXvujSixQJ/jPNksPsC9FNtguZoSiCLQM7xEEwVgQsEwi6QH45MT8B0Is=
X-Gm-Gg: AeBDiev3EHYPXNBhRPwDQyRISlZFM1CPT5SBjACy8/Kfm7WYr8cfO0bsMgdaksJOHvz
 Ra8yBV3u+gVGOPV2BB5OEs5z0DO4siZzdM3YhoBb1LI9BDjIEV8xhQnAkh+k8ghpMg4rJh2lQKm
 vKRelge4K/dvnFnlO9YAauMPb7OKwda/0AEiH8uyQTco3tLq7/vV0KIAnfRSJA0OwiCWrr1ezD2
 U6dwmo05bAH/PTgjRYNu4zn101UkAnD16GDZo1sJfqpGHcNp9r8WX41zSd35uEGDSkoa3lfuD/F
 F9yK8OAnxuPl1Z6bhPl6X+d08PiwjC91cftM/QnNgRfZfFA1VuOUBUu0ISsuMcxSY2qa0RF96RQ
 ey1mS6plXBRljaP3JMVV24sj1ltBmx+WHrbHn9Zlracr9E0EHHLGrxLFjpaQZmbCvEm3yNZZJus
 oPbErH6O/xqC+1tlRI0GnVSZ0asFeiyMXsC7Qm1io3iU5DkWfmBsLw/qYTTsbXwdEY8hVdJGrJ7
 +OFwZnAbQef
X-Received: by 2002:a05:6830:67ec:b0:7d7:49bf:48cf with SMTP id
 46e09a7af769-7dc94d7f448mr10512994a34.4.1776724541607; 
 Mon, 20 Apr 2026 15:35:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:49fb:b337:a968:94e7?
 ([2600:8803:e7e4:500:49fb:b337:a968:94e7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc975033acsm9521758a34.1.2026.04.20.15.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 15:35:41 -0700 (PDT)
Message-ID: <af534d93-aefe-4658-984b-ebed80f0cbc0@baylibre.com>
Date: Mon, 20 Apr 2026 17:35:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] env: scsi: Add support for partition type GUID
 based environment
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Jerome Forissier <jerome.forissier@arm.com>
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
 <20260419-type-v3-3-ec49acd6870e@oss.qualcomm.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260419-type-v3-3-ec49acd6870e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/19/26 5:24 AM, Balaji Selvanathan wrote:
> Add support for locating SCSI environment partition using GPT type
> GUID instead of unique UUID. This enables the saveenv command to
> work with partitions identified by their type rather than unique
> identifiers, providing flexibility for systems where partition
> UUIDs may vary across devices but types remain constant.
> 
> Introduce a Kconfig choice statement to select between three partition
> lookup methods. The choice provides mutually exclusive options:
> ENV_SCSI_PART_USE_UUID (default), ENV_SCSI_PART_USE_TYPE_GUID, and
> ENV_SCSI_PART_USE_HW. The corresponding string configs depend on their
> respective selection method, creating a clear configuration structure.
> 
> Introduce CONFIG_ENV_SCSI_PART_TYPE_GUID configuration option that
> allows specifying a partition type GUID for environment storage.
> When SCSI_ENV_PART_USE_TYPE_GUID is enabled, the environment subsystem
> uses the type GUID based lookup method via
> scsi_get_blk_by_type_guid() to find the first matching partition.
> 
> Refactor env/scsi.c to use compile-time preprocessor conditionals
> instead of runtime string checks. Replace the previous logic that
> checked if CONFIG_ENV_SCSI_PART_UUID was empty with explicit #if/#elif
> branches for each method.

Might be a bit cleaner to split the refactor and adding the new option
into two patches. This is quite a bit going on in one patch.

> 
> Elevate hardware partition selection from an implicit fallback to an
> explicit choice (ENV_SCSI_PART_USE_HW), improving configuration clarity.
> Move ENV_SCSI_HW_PARTITION to depend on this new option.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Introduce a new choice config: ENV_SCSI_PART_USE_HW for
>   ENV_SCSI_HW_PARTITION
> - Refactor env_scsi_get_part and env_scsi_load functions based
>   on the choice configs
> 
> Changes in v2:
> - Introduce a Kconfig choice config to select between UUID-based
> and type GUID-based partition lookup methods.
> ---
>  env/Kconfig | 51 +++++++++++++++++++++++++++++++++++++++++++--------
>  env/scsi.c  | 45 +++++++++++++++++++++++++++------------------
>  2 files changed, 70 insertions(+), 26 deletions(-)
> 
> diff --git a/env/Kconfig b/env/Kconfig
> index 7abd82ab6f3..d5d956cb4ce 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -780,10 +780,51 @@ config ENV_MMC_USE_DT
>  	  The 2 defines CONFIG_ENV_OFFSET, CONFIG_ENV_OFFSET_REDUND
>  	  are not used as fallback.
>  

We should update the help of `config ENV_IS_IN_SCSI` as well since it
mentions these options below.

> +choice
> +	prompt "SCSI partition selection method"
> +	depends on ENV_IS_IN_SCSI
> +	default ENV_SCSI_PART_USE_UUID
> +	help
> +	  Select the method to identify the SCSI partition for environment storage.
> +

I wish I would have thought of using `choice` in the recent changes I
did. It is much cleaner to explicitly select which one you want. :-)

> +config ENV_SCSI_PART_USE_UUID
> +	bool "Use partition UUID"
> +	help
> +	  Use the partition's unique UUID to identify the SCSI partition
> +	  for environment storage.
> +
> +config ENV_SCSI_PART_USE_TYPE_GUID
> +	bool "Use partition type GUID"
> +	help
> +	  Use the partition type GUID to identify the SCSI partition
> +	  for environment storage. The first partition matching the
> +	  specified type GUID will be used.
> +
> +config ENV_SCSI_PART_USE_HW
> +	bool "Use hardware partition number"
> +	help
> +	  Use the hardware device number to identify the SCSI device
> +	  for environment storage.
> +
> +endchoice
> +
> +config ENV_SCSI_PART_UUID
> +	string "SCSI partition UUID for saving environment"
> +	depends on ENV_SCSI_PART_USE_UUID
> +	help
> +	  UUID of the SCSI partition that you want to store the environment in.
> +
> +config ENV_SCSI_PART_TYPE_GUID
> +	string "SCSI partition type GUID for saving environment"
> +	depends on ENV_SCSI_PART_USE_TYPE_GUID
> +	help
> +	  Type GUID of the SCSI partition to store the environment in.
> +	  Uses the first partition matching this type GUID.
> +
>  config ENV_SCSI_HW_PARTITION
>  	string "SCSI hardware partition number"
> -	depends on ENV_IS_IN_SCSI
> -	default 0
> +	depends on ENV_SCSI_PART_USE_HW
> +	default "0"

Fixing the quotes here is technically an unrelated change, so could be
a patch on it's own as well.

>  	help
>  	  SCSI hardware partition device number on the platform where the
>  	  environment is stored.  Note that this is not related to any software
> @@ -791,12 +832,6 @@ config ENV_SCSI_HW_PARTITION
>  	  partition 0 or the first boot partition, which is 1 or some other defined
>  	  partition.
>  
> -config ENV_SCSI_PART_UUID
> -	string "SCSI partition UUID for saving environment"
> -	depends on ENV_IS_IN_SCSI
> -	help
> -	  UUID of the SCSI partition that you want to store the environment in.
> -
>  config ENV_USE_DEFAULT_ENV_TEXT_FILE
>  	bool "Create default environment from file"
>  	depends on !COMPILE_TEST
> diff --git a/env/scsi.c b/env/scsi.c
> index 91a6c430302..abb8b0a1dfd 100644
> --- a/env/scsi.c
> +++ b/env/scsi.c
> @@ -41,14 +41,19 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
>  		is_scsi_scanned = true;
>  	}
>  
> -	if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0') {
> -		if (blk_get_device_part_str("scsi", CONFIG_ENV_SCSI_HW_PARTITION,
> -					    &ep->blk, &ep->part, true))
> -			return NULL;
> -	} else {
> -		if (scsi_get_blk_by_uuid(CONFIG_ENV_SCSI_PART_UUID, &ep->blk, &ep->part))
> -			return NULL;
> -	}
> +#if defined(CONFIG_ENV_SCSI_PART_USE_TYPE_GUID)
> +	if (scsi_get_blk_by_type_guid(CONFIG_ENV_SCSI_PART_TYPE_GUID, &ep->blk, &ep->part))
> +		return NULL;
> +
> +#elif defined(CONFIG_ENV_SCSI_PART_USE_UUID)
> +	if (scsi_get_blk_by_uuid(CONFIG_ENV_SCSI_PART_UUID, &ep->blk, &ep->part))
> +		return NULL;
> +
> +#elif defined(CONFIG_ENV_SCSI_PART_USE_HW)
> +	if (blk_get_device_part_str("scsi", CONFIG_ENV_SCSI_HW_PARTITION,
> +				    &ep->blk, &ep->part, true))
> +		return NULL;
> +#endif
>  
>  	ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
>  
> @@ -95,20 +100,24 @@ static int env_scsi_load(void)
>  	int ret;
>  
>  	if (!ep) {
> -		if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0')
> -			env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " not found", 0);
> -		else
> -			env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition not found", 0);
> -
> +#if defined(CONFIG_ENV_SCSI_PART_USE_TYPE_GUID)
> +		env_set_default(CONFIG_ENV_SCSI_PART_TYPE_GUID " partition not found", 0);

It could be a bit more clear to have a different message for
this one. e.g. "partition type " CONFIG_ENV_SCSI_PART_TYPE_GUID " not found".

> +#elif defined(CONFIG_ENV_SCSI_PART_USE_UUID)
> +		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition not found", 0);
> +#elif defined(CONFIG_ENV_SCSI_PART_USE_HW)
> +		env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " not found", 0);
> +#endif
>  		return -ENOENT;
>  	}
>  
>  	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
> -		if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0')
> -			env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " read failed", 0);
> -		else
> -			env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition read failed", 0);
> -
> +#if defined(CONFIG_ENV_SCSI_PART_USE_TYPE_GUID)
> +		env_set_default(CONFIG_ENV_SCSI_PART_TYPE_GUID " partition read failed", 0);

similar as above

> +#elif defined(CONFIG_ENV_SCSI_PART_USE_UUID)
> +		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition read failed", 0);
> +#elif defined(CONFIG_ENV_SCSI_PART_USE_HW)
> +		env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " read failed", 0);
> +#endif
>  		return -EIO;
>  	}
>  
> 

