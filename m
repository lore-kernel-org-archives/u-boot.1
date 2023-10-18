Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD68CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 05:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066BC86E6C;
	Wed, 18 Oct 2023 07:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SCyEOcMs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D486F86F04; Wed, 18 Oct 2023 07:27:30 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 799F986BD5
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 07:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-66d134a019cso41159376d6.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 22:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697606847; x=1698211647; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rzZbeLZrNeLFWaIXE72SzjMUAu0sUUW6soNPCLmUil4=;
 b=SCyEOcMsoFfNhurtCjpeepsJF8uiktDQpohF0Fmy30mGjheCpERBwdCNjSN4+F3blN
 Y02T+y0Aij8GdVvLDcdtOX7nrLL2j18e4qQcPcdDFt7VrA5b7G3DT3ftM6BjjmhF97J5
 xaj+YxFkcwttXSNJxue5dc2xBrBsSfOV/cPLVJy9qB65GPsLxohakGAF8M642R4xd0JQ
 icYIKS2j6NnKP2y7qu/T9uMRY0VL134ovLtzUQIsvAv5xOdW+Hp2cYyRief5oei+2y01
 rDOgeyaWVp7rl0Yo6YjXpP9ZzLm/5HxOdHoqvVdX4HqY6f6dVCT/B7FWDxPnZxQfpiFl
 80Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697606847; x=1698211647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rzZbeLZrNeLFWaIXE72SzjMUAu0sUUW6soNPCLmUil4=;
 b=NZ3yUPUyica7jVNGu4oktbAGGONdrMWwTr8wKQOXIs5BOy0axSTCvnNqKmpz3euAJ0
 0qLF7gOTl7jyXi0s2IsErugQblOV0ttDzFX+ikfkL1mZbIb36lwov5kE/SmgXZZDKrV/
 zZjauP/G+WkftxYKKqe8R2DI0hbXjJMxu8AsgGn9u0iH296zZIiUpPU4vLDzjgia7wEz
 w6w+g0TQ+cIN2jmexnSj6MRRNQ1zJxwDcRcxA+dP9spfDejLYOYqSKvsnzkdRXe6H9f3
 GBPe3D8JmOIwvg6ZksDYxdED2tTsXJXnYt1h8srnlDqeDxXGaOwBUxgm0mO5oABXDE5t
 x20Q==
X-Gm-Message-State: AOJu0YxsuUxh+Qf6SuRIIlid68WHXMCTIP+89HkSHWw3zerKjNjJYyrO
 r09QlUeqaJzXf2dMJ54h3KW1iq8+Q1+AxQ==
X-Google-Smtp-Source: AGHT+IE2C6tcce6oYbJXqJVryiUvdZd3/qfvDOreZyo29nGpDkuY2QSv8AKUIBvI0dM4gyqhEWwMRw==
X-Received: by 2002:ad4:576e:0:b0:66d:3636:8a9 with SMTP id
 r14-20020ad4576e000000b0066d363608a9mr4914693qvx.63.1697606846903; 
 Tue, 17 Oct 2023 22:27:26 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 y18-20020ad457d2000000b0065afd35c762sm1110353qvx.91.2023.10.17.22.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 22:27:26 -0700 (PDT)
Message-ID: <cf37d9b4-e896-5109-ae03-b8ddfbf8d913@gmail.com>
Date: Wed, 18 Oct 2023 01:27:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spl: mmc: Resolve emmc not load image after switched hw
 partition
Content-Language: en-US
To: Kuan Lim Lee <kuanlim.lee@starfivetech.com>, u-boot@lists.denx.de
Cc: cheehong.ang@starfivetech.com, weiliang.lim@starfivetech.com
References: <20231003041720.893-1-kuanlim.lee@starfivetech.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231003041720.893-1-kuanlim.lee@starfivetech.com>
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

On 10/3/23 00:16, Kuan Lim Lee wrote:
> When selecting MMCSD_MODE_EMMCBOOT as boot_mode, emmc do not load U-boot
> proper image after switched hardware partition.
> 
> Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
> Reviewed-by: Chee Hong Ang <cheehong.ang@starfivetech.com>
> Reviewed-by: Wei Liang Lim <weiliang.lim@starfivetech.com>
> ---
>   common/spl/spl_mmc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 20f687e138..dc8a45222b 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -447,6 +447,9 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>   #endif
>   			return err;
>   		}
> +		err = mmc_load_image_raw_sector(spl_image, bootdev, mmc, 0);
> +		if (!err)
> +			return err;
>   		/* Fall through */
>   	case MMCSD_MODE_RAW:
>   		debug("spl: mmc boot mode: raw\n");

So why doesn't the mmc_load_image_raw_sector below (line 475 or so) work?

--Sean
