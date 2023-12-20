Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC9CC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 16:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90439875B6;
	Wed, 20 Dec 2023 17:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v1CpE84Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16DA1876A8; Wed, 20 Dec 2023 17:53:47 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B678E807A7
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 17:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d2e56f3a6so6164985e9.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 08:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1703091224; x=1703696024;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=t/E3gRP8/jTLvNejTRV+pEGJwGdO8+5Qd1bnam6jWUk=;
 b=v1CpE84Y96QVgIQj/uRKBnIuwgBhv7jweYqX9JKymMc3GbIDa+oa/tHzefUF5Y34uQ
 gWSrjI+MEOvMMoqew0TLfnLa9TeZDWlHbhfWd69TBBE86bf9uEsdJRqU9XzOogqvkNU/
 1VgpwDOODu5ahX/kIbcGGCFgaCBJh7l5g2uDR6os+rHmkDtTaD9dAvLltO0P0uZHyoyE
 f5LXR1DDPzz/kvD3VZwtSoy7I22rPvXJJUrAP8ZOdu7zbyaNGnjWbelrr1Eyfux+z+UA
 PD0XI9QmKQba1Zh9dVBEhlJbJXc4/TNYaZ0JXs91StcGWaBMTdXGkzButUP/F/0+u8oA
 UETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703091224; x=1703696024;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t/E3gRP8/jTLvNejTRV+pEGJwGdO8+5Qd1bnam6jWUk=;
 b=qVue5L82fNnWuhPnxNUGVE5dy3AvoU9G3/u/pqct43J5amaIBOPgakdYlrG8LxCDpm
 PI/DfGuN85E9DXl0ivBo/JRzQPeIVm3hCYz1Yt9sPZc/TfkojR3TtCKAUy/HhQIK1D+2
 67CuYnSxZKBFQXIW9TqB0hpbpyZE7uiZYIRIeCUDc1UN1wHHP3zI+j2hJHNtV3/L3kUz
 79pZzCthfiAaFOrgH2CLG3/t8RupK67qxLxkdvK0Sh8YITuxsmpDnDJh3Sz7uOeUEKa2
 5CWPBBO32WMdcdmFyTKwlSssn2uacmx5rmpckdSQrqcuLNKqpbrL6L0Tq9z//PxhE+oO
 GMCA==
X-Gm-Message-State: AOJu0YwrKtaHdwf+YZFCrc8q5uz/XbNT850cNZtrk5oAEFQHYbjis9lP
 ngA7eWKMxK6FMv6wN+aJbHVW4A==
X-Google-Smtp-Source: AGHT+IEBr2rSHCdx4kypSmPZIykR8i7IKOq6cvLUZeOaM44HjxyvOJmTWfsPKKGMIsefiz0l6gQYHg==
X-Received: by 2002:a05:600c:45cd:b0:40d:2665:f11b with SMTP id
 s13-20020a05600c45cd00b0040d2665f11bmr1712961wmo.89.1703091223992; 
 Wed, 20 Dec 2023 08:53:43 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c198a00b0040c490db950sm7927646wmq.47.2023.12.20.08.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 08:53:43 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>, jpewhacker@gmail.com,
 sjg@google.com
Cc: u-boot@lists.denx.de, kernel@salutedevices.com, Alexey Romanov
 <avromanov@salutedevices.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH v1] android_ab: don't ignore ab_control_store return code
In-Reply-To: <20231128112636.26655-1-avromanov@salutedevices.com>
References: <20231128112636.26655-1-avromanov@salutedevices.com>
Date: Wed, 20 Dec 2023 17:53:42 +0100
Message-ID: <87sf3w24tl.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Alexey,

Thank you for your patch.

I'm looping in the Android AB reviewers and maintainers (Sam and Igor).

They were not automatically add due to a stale MAINTAINERS entry[1]

[1] https://lore.kernel.org/all/20231220-maintainers-fix-ab-v1-1-dd16fc5285ed@baylibre.com/

On Tue, Nov 28, 2023 at 14:26, Alexey Romanov <avromanov@salutedevices.com> wrote:

> ab_control_store() can return an error if writing to disk fails.
> In this case, we have to pass the error code to the caller.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  boot/android_ab.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 73b55c196c..5a3152dd53 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -337,7 +337,15 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>  
>  	if (store_needed) {
>  		abc->crc32_le = ab_control_compute_crc(abc);
> -		ab_control_store(dev_desc, part_info, abc, 0);
> +		ret = ab_control_store(dev_desc, part_info, abc, 0);
> +		if (ret < 0) {
> +#if ANDROID_AB_BACKUP_OFFSET
> +			free(backup_abc);
> +#endif
> +			free(abc);
> +			log_err("ANDROID: failed to store boot control block: %d\n", ret);

There is no point in logging here, because ab_control_store() already
logs:

	ret = blk_dwrite(dev_desc, part_info->start + abc_offset, abc_blocks,
			 abc);
	if (IS_ERR_VALUE(ret)) {
		log_err("ANDROID: Could not write back the misc partition\n");
		return -EIO;
	}

> +			return ret;
> +		}
>  	}
>  
>  #if ANDROID_AB_BACKUP_OFFSET
> @@ -346,8 +354,14 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>  	 * to the backup offset
>  	 */
>  	if (memcmp(backup_abc, abc, sizeof(*abc)) != 0) {
> -		ab_control_store(dev_desc, part_info, abc,
> +		ret = ab_control_store(dev_desc, part_info, abc,
>  				 ANDROID_AB_BACKUP_OFFSET);
> +		if (ret < 0) {
> +			free(backup_abc);
> +			free(abc);
> +			log_err("ANDROID: failed to store boot control block: %d\n", ret);

Same here

With that addressed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> +			return ret;
> +		}
>  	}
>  	free(backup_abc);
>  #endif
> -- 
> 2.39.2
