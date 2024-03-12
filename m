Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7444DC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC22687E71;
	Tue, 12 Mar 2024 16:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K38Pm3Et";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34723875B9; Tue, 12 Mar 2024 16:19:28 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B3A87DFF
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33e672e10cfso2844537f8f.0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710256765; x=1710861565;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XJqZctOJzV1Z5BNh36+qBxreSv0yxTqzBOn7ExKL7tc=;
 b=K38Pm3EtuVRiz3cGaD+gOCumnnrB2ZCeFI4BS5BrGXbo5suMm6tRErFAeGWIVTjV//
 8CgI4bI38Y7ubd1T9ZGwxrxVSJtwg4Gojc0w5rYg5o1mpeM/NlcjZYojga/Jie5fMx5D
 L1kMqgNlNtwgcvT2360tzpEQPiqsxvp+JfHALP/nHkhive+ohn5ma9Gz7N7wYvm8p0+D
 bYlIbPvee7ieNqz5KZ+FqsmbfityOaB5G3XKG9j4SC4ohjPcirV7hHK58bjl/7cCNmQy
 dAXHYqTCX3MIAS8z3NsEFgi2Dv45OQjmHTPu6VoPjEFS0RTjEVgdtjS9qWaMt52R40Mj
 bYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710256765; x=1710861565;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XJqZctOJzV1Z5BNh36+qBxreSv0yxTqzBOn7ExKL7tc=;
 b=eNrqIpZV81oH5mLHCcG6SFmf8fEMZau/EsHbPM3+gDOPXcwmXxyVFl6WRkwyPadoBa
 xvP2zQMVyoK9PYeK/NiYaLn26fm6xaeiT2tVeWhwdoDTzUgAT701RgMMXODH7wBo+Gte
 M/EHMtCzZK5Ypu6Pqlb9sL8h76dQbm992ix3jkNszijyDRhR1/aqgvIb5ZFVQ5/O9ccQ
 h9YYr8SY2Qc4Dbrs9HgHDjPgEHzUHv/80dA9IlwodIy1IOIRu8HHE/JpL8Wo+CMlvPnw
 2iKEc4C6qe4oM5u0sfYSSUr5d+uzYMxAHINLNqazczrY9j4teXo63vIT3POAUZVSFfXQ
 jtWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXugpaDxVSjQugUjhcUBs6DpdihXhUP809PwR4CpEtGA8uwzOFGdAxZE2orKWboo+AWlaYo7fjQMCWXFOja6SWocB1tYg==
X-Gm-Message-State: AOJu0YxwyxbcAoSSjS2fQOVzDHlmeoLz62tJaJVgGNq7zHE2UTvCcUzq
 aHXFOUJ+9MjokAlDDf8kZfnLvY8uq08qMGF253NiXPRhGcqiFYKRbRPq2RbPLyX9rhSBg8lgXYj
 s
X-Google-Smtp-Source: AGHT+IF/TIXbi4VJnx6piagAz/KoBAy8sheouUbAJwhKrSD+37h0pV0H9QBB1UVx4Gol0zB0sjYmMw==
X-Received: by 2002:adf:f5d1:0:b0:33e:5fbf:ec4a with SMTP id
 k17-20020adff5d1000000b0033e5fbfec4amr7792160wrp.64.1710256765001; 
 Tue, 12 Mar 2024 08:19:25 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 x3-20020adfffc3000000b0033e99b339a6sm4502527wrs.62.2024.03.12.08.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:19:24 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Colin McAllister <colinmca242@gmail.com>, u-boot@lists.denx.de
Cc: Colin McAllister <colin.mcallister@garmin.com>, JPEWhacker@gmail.com,
 sjg@chromium.org, Sam Protsenko <semen.protsenko@linaro.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Colin McAllister <colinmca242@gmail.com>
Subject: Re: [PATCH v4 2/2] android_ab: Fix ANDROID_AB_BACKUP_OFFSET
In-Reply-To: <20240312125729.82695-3-colinmca242@gmail.com>
References: <20240312125729.82695-1-colinmca242@gmail.com>
 <20240312125729.82695-3-colinmca242@gmail.com>
Date: Tue, 12 Mar 2024 16:19:23 +0100
Message-ID: <87jzm74gw4.fsf@baylibre.com>
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

Hi Colin,

Thank you for the patch.

On mar., mars 12, 2024 at 07:57, Colin McAllister <colinmca242@gmail.com> wrote:

Sam also gave his review here:
https://lore.kernel.org/all/CAPLW+4kHmPtfACyND4Vc2p0ZrsyGY=+bRU=fdub4K1uX5p33Jw@mail.gmail.com/

Please include his review tag in the next submission.

I will add it at the appropriate place below:


> From: Colin McAllister <colin.mcallister@garmin.com>
>
> Currently, setting CONFIG_AB_BACKUP_OFFSET in a target's defconfig will
> not actually enable the #if protected code in android_ab.c. This is
> because "CONFIG_" should have been prepended to the config macro, or the
> macros defined in kconfig.h could have been used.
>
> The code included by ANDROID_AB_BACKUP_OFFSET has been refactored to no
> longer be conditionally compiled by preprocessor conditionals and
> instead use C conditionals. This better aligns with the Linux kernel
> style guide.
>
> Fixes: 3430f24bc6 ("android_ab: Try backup booloader_message")
> Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Signed-off-by: Colin McAllister <colinmca242@gmail.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> ---
> v2:
>   - Replaced #if conditionals with C if conditionals
>   - Opted to use CONFIG_ANDROID_AB_BACKUP_OFFSET directly instead of
>     macros in kconfig.h as CONFIG_ANDROID_AB_BACKUP_OFFSET is not a
> 	boolean or tristate value and doesn't have different values when
> 	building SPL or TPL.
> v3:
>   - Added "Fixes:" tag
> v4:
>   - No changes
>
>  boot/android_ab.c | 97 ++++++++++++++++++++++-------------------------
>  1 file changed, 45 insertions(+), 52 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 9a3d15ec60..f547aa64e4 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -187,13 +187,12 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>  		   bool dec_tries)
>  {
>  	struct bootloader_control *abc = NULL;
> +	struct bootloader_control *backup_abc = NULL;
>  	u32 crc32_le;
>  	int slot, i, ret;
>  	bool store_needed = false;
> +	bool valid_backup = false;
>  	char slot_suffix[4];
> -#if ANDROID_AB_BACKUP_OFFSET
> -	struct bootloader_control *backup_abc = NULL;
> -#endif
>  
>  	ret = ab_control_create_from_disk(dev_desc, part_info, &abc, 0);
>  	if (ret < 0) {
> @@ -205,53 +204,49 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>  		return ret;
>  	}
>  
> -#if ANDROID_AB_BACKUP_OFFSET
> -	ret = ab_control_create_from_disk(dev_desc, part_info, &backup_abc,
> -					  ANDROID_AB_BACKUP_OFFSET);
> -	if (ret < 0) {
> -		free(abc);
> -		return ret;
> +	if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
> +		ret = ab_control_create_from_disk(dev_desc, part_info, &backup_abc,
> +						  CONFIG_ANDROID_AB_BACKUP_OFFSET);
> +		if (ret < 0) {
> +			free(abc);
> +			return ret;
> +		}
>  	}
> -#endif
>  
>  	crc32_le = ab_control_compute_crc(abc);
>  	if (abc->crc32_le != crc32_le) {
>  		log_err("ANDROID: Invalid CRC-32 (expected %.8x, found %.8x),",
>  			crc32_le, abc->crc32_le);
> -#if ANDROID_AB_BACKUP_OFFSET
> -		crc32_le = ab_control_compute_crc(backup_abc);
> -		if (backup_abc->crc32_le != crc32_le) {
> -			log_err("ANDROID: Invalid backup CRC-32 ");
> -			log_err("expected %.8x, found %.8x),",
> -				crc32_le, backup_abc->crc32_le);
> -#endif
> -
> -			log_err("re-initializing A/B metadata.\n");
> +		if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
> +			crc32_le = ab_control_compute_crc(backup_abc);
> +			if (backup_abc->crc32_le != crc32_le) {
> +				log_err(" ANDROID: Invalid backup CRC-32 ");
> +				log_err("(expected %.8x, found %.8x),",
> +					crc32_le, backup_abc->crc32_le);
> +			} else {
> +				valid_backup = true;
> +				log_info(" copying A/B metadata from backup.\n");
> +				memcpy(abc, backup_abc, sizeof(*abc));
> +			}
> +		}
>  
> +		if (!valid_backup) {
> +			log_err(" re-initializing A/B metadata.\n");
>  			ret = ab_control_default(abc);
>  			if (ret < 0) {
> -#if ANDROID_AB_BACKUP_OFFSET
> -				free(backup_abc);
> -#endif
> +				if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> +					free(backup_abc);
>  				free(abc);
>  				return -ENODATA;
>  			}
> -#if ANDROID_AB_BACKUP_OFFSET
> -		} else {
> -			/*
> -			 * Backup is valid. Copy it to the primary
> -			 */
> -			memcpy(abc, backup_abc, sizeof(*abc));
>  		}
> -#endif
>  		store_needed = true;
>  	}
>  
>  	if (abc->magic != BOOT_CTRL_MAGIC) {
>  		log_err("ANDROID: Unknown A/B metadata: %.8x\n", abc->magic);
> -#if ANDROID_AB_BACKUP_OFFSET
> -		free(backup_abc);
> -#endif
> +		if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> +			free(backup_abc);
>  		free(abc);
>  		return -ENODATA;
>  	}
> @@ -259,9 +254,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>  	if (abc->version > BOOT_CTRL_VERSION) {
>  		log_err("ANDROID: Unsupported A/B metadata version: %.8x\n",
>  			abc->version);
> -#if ANDROID_AB_BACKUP_OFFSET
> -		free(backup_abc);
> -#endif
> +		if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> +			free(backup_abc);
>  		free(abc);
>  		return -ENODATA;
>  	}
> @@ -338,30 +332,29 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>  		abc->crc32_le = ab_control_compute_crc(abc);
>  		ret = ab_control_store(dev_desc, part_info, abc, 0);
>  		if (ret < 0) {
> -#if ANDROID_AB_BACKUP_OFFSET
> -			free(backup_abc);
> -#endif
> +			if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> +				free(backup_abc);
>  			free(abc);
>  			return ret;
>  		}
>  	}
>  
> -#if ANDROID_AB_BACKUP_OFFSET
> -	/*
> -	 * If the backup doesn't match the primary, write the primary
> -	 * to the backup offset
> -	 */
> -	if (memcmp(backup_abc, abc, sizeof(*abc)) != 0) {
> -		ret = ab_control_store(dev_desc, part_info, abc,
> -				       ANDROID_AB_BACKUP_OFFSET);
> -		if (ret < 0) {
> -			free(backup_abc);
> -			free(abc);
> -			return ret;
> +	if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
> +		/*
> +		* If the backup doesn't match the primary, write the primary
> +		* to the backup offset
> +		*/

checkpatch.pl seems to complain about this comment block:

WARNING: Block comments should align the * on each line
#166: FILE: boot/android_ab.c:344:
+               /*
+               * If the backup doesn't match the primary, write the primary

To reproduce, run:

$ ./scripts/checkpatch.pl --strict --u-boot --git HEAD^..HEAD

With the above addressed, please send a v5 including:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> +		if (memcmp(backup_abc, abc, sizeof(*abc)) != 0) {
> +			ret = ab_control_store(dev_desc, part_info, abc,
> +					       CONFIG_ANDROID_AB_BACKUP_OFFSET);
> +			if (ret < 0) {
> +				free(backup_abc);
> +				free(abc);
> +				return ret;
> +			}
>  		}
> +		free(backup_abc);
>  	}
> -	free(backup_abc);
> -#endif
>  
>  	free(abc);
>  
> -- 
> 2.34.1
