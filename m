Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404A1C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58D33879D4;
	Fri, 12 Jan 2024 09:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hfbY6c9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDCA1879B5; Fri, 12 Jan 2024 09:56:12 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A432D879D4
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3367632ce7bso4245370f8f.2
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 00:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705049769; x=1705654569;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=h88mZ3vbH2Sh4w51Px/BhXHTZDWwIwdb3Wyxf3xNF2M=;
 b=hfbY6c9alD/g52CDefCuleg3a7PvhXiDc2M0G2mgD9RiVJedBUaccdyF34wM3HPLdl
 emBROPT59+hCAP5aQE8IBF+zlmClgspFXAzeYpQwp4JCkG03k4EHZfWM5H9vHZQ5BoNv
 5c26jfSBjGDtFwyMyzk2onoSJPVgWwbUjl6o68f7xFJvWHZxkiyRxVoip8OnapzDFKKI
 gb7Oo/aeJAyBYwMKv218B65IXarXCxYQpmjB7YdOyQ0I+9Mq6x4vnsXzIaa41oCWaWci
 UPi87CrCROhvrJeMivUzJNl8wO6Z+5l2UzmhhvT3ggNHBMsF60r8n81mzydFDKmLycg6
 kvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705049769; x=1705654569;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h88mZ3vbH2Sh4w51Px/BhXHTZDWwIwdb3Wyxf3xNF2M=;
 b=W/St8ABHVtizzhS17xHFd3fQKFh633xw3K73KCkHXPn2UHxQ0FYaMTrK6zeTbhNPPr
 1NjJITd11jWYa00/pfapHg7Bd0UrPTz5asLnWMNWYA4xxn5yXy7mOJ5hVYf/JJTR9yqm
 m6LRa3C59gXQoaoyZAUINt/S/JjQ5DpVhRqR/PoxdBrZUALLrVUf/3JFx/dCI2s/jNKD
 45/uN8G/xChTPqYteNKQYG4aKH0hFHuVGmmWgpW9Q3AiEiw8SoShQbeUmHqDS63jDgzU
 3yduDEmxYKMHuFgqGRfIChFHqhmAx/q5p6qXvo3s3LS0X5Mxr59dAvg2ogXTc+ppN9cn
 JEdw==
X-Gm-Message-State: AOJu0YyQfogMHYId2sWpxgXth6S4c42XaPJ/b4u0jOUBiN44RVZVoP+q
 lO/MzKUDZZK9lGJ36Wd3KukXMHWzGL8wfg==
X-Google-Smtp-Source: AGHT+IFuO186qGdEmiP9JX8jfpWPdIMecVvi2bfGnPycjcsRh+CzzA0xNGWyiJphvuusNAb4SrUWxg==
X-Received: by 2002:adf:ed8b:0:b0:337:6ea7:5a7a with SMTP id
 c11-20020adfed8b000000b003376ea75a7amr382318wro.124.1705049769141; 
 Fri, 12 Jan 2024 00:56:09 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 m6-20020adffa06000000b00336c6b77584sm3248095wrr.91.2024.01.12.00.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 00:56:08 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>, "jpewhacker@gmail.com"
 <jpewhacker@gmail.com>, "sjg@google.com" <sjg@google.com>,
 "semen.protsenko@linaro.org" <semen.protsenko@linaro.org>,
 "igor.opaniuk@gmail.com" <igor.opaniuk@gmail.com>, "trini@konsulko.com"
 <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel
 <kernel@sberdevices.ru>
Subject: Re: [PATCH v2] android_ab: don't ignore ab_control_store return code
In-Reply-To: <20240109103720.j6vudgbx5fi74pq7@cab-wsm-0029881>
References: <20231225102247.76794-1-avromanov@salutedevices.com>
 <20240109103720.j6vudgbx5fi74pq7@cab-wsm-0029881>
Date: Fri, 12 Jan 2024 09:56:08 +0100
Message-ID: <877ckflyl3.fsf@baylibre.com>
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

On Tue, Jan 09, 2024 at 10:37, Alexey Romanov <avromanov@salutedevices.com> wrote:

> + Tom Rini
>
> Hello! Please, ping

It seems that Igor (the Android AB maintainer) has been busy elsewhere.

I've requested to take over maintainership:
https://lore.kernel.org/all/20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com/

If that gets accepted, I will pick up this patch.

Thank you for your patience,

Mattijs

>
> On Mon, Dec 25, 2023 at 01:22:45PM +0300, Alexey Romanov wrote:
>> ab_control_store() can return an error if writing to disk fails.
>> In this case, we have to pass the error code to the caller.
>> 
>> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>>  boot/android_ab.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>> 
>> diff --git a/boot/android_ab.c b/boot/android_ab.c
>> index 73b55c196c..af3c375e07 100644
>> --- a/boot/android_ab.c
>> +++ b/boot/android_ab.c
>> @@ -337,7 +337,14 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>>  
>>  	if (store_needed) {
>>  		abc->crc32_le = ab_control_compute_crc(abc);
>> -		ab_control_store(dev_desc, part_info, abc, 0);
>> +		ret = ab_control_store(dev_desc, part_info, abc, 0);
>> +		if (ret < 0) {
>> +#if ANDROID_AB_BACKUP_OFFSET
>> +			free(backup_abc);
>> +#endif
>> +			free(abc);
>> +			return ret;
>> +		}
>>  	}
>>  
>>  #if ANDROID_AB_BACKUP_OFFSET
>> @@ -346,8 +353,13 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>>  	 * to the backup offset
>>  	 */
>>  	if (memcmp(backup_abc, abc, sizeof(*abc)) != 0) {
>> -		ab_control_store(dev_desc, part_info, abc,
>> +		ret = ab_control_store(dev_desc, part_info, abc,
>>  				 ANDROID_AB_BACKUP_OFFSET);
>> +		if (ret < 0) {
>> +			free(backup_abc);
>> +			free(abc);
>> +			return ret;
>> +		}
>>  	}
>>  	free(backup_abc);
>>  #endif
>> -- 
>> 2.39.2
>> 
>
> -- 
> Thank you,
> Alexey
