Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDF9C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 06:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEB368853F;
	Thu, 23 May 2024 08:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n7N8rJRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B39AF884FB; Thu, 23 May 2024 08:08:56 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B161F88571
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 08:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2e1fa824504so70465541fa.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716444534; x=1717049334;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FacaTisVg5sOrZyME+FNuJXieB2xpuNKx5HNnZr6TCc=;
 b=n7N8rJRlcGXNXlMKyQwAzj34iwKTfYf5Nd5DCjO0/z1B8zQGV14uXrv3/LFohStqZB
 Bqp9PTZK28+5rMq43m9yhf1/eODY7ssJqxyhz46xD/BzUx2SY96w6zDGoWtZwAjWAuA1
 jEGiSS/4DJDgXRe6N5M+72fVRc4cHWeR86rLqMwfhLyI5LXjwBMrnDDIcrqjIrJ6LQnC
 wEjTHcEBgVR8IO+wUePjTRtMVnw5B9O3I1GI+12/2hHA//bxJuqPWbeecRGI+XHrv6tA
 YigzeCgVWaQ1MWcYPthtvxeE5NBuI4f+i76s1TKgH5y1YgDcSjtEQz6wsCLQ0F/VpArR
 1KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716444534; x=1717049334;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FacaTisVg5sOrZyME+FNuJXieB2xpuNKx5HNnZr6TCc=;
 b=GH0yiWpYbnvaWbHo2VQs0IPMQIiV8xea2+k3WN8wD4VA9ZB3LOSLCkaHZ9d/LqzROx
 Ac4ALnON1B3iBA5H7a4Dy2VqMTLvNRzhp9saT9W0fXu9Ch7Y6AWwQFdXFvky13xdQYR2
 Hr0V2BAgJr+6tq/QZC2+2FL0iLCDnb1bmUcAKrZGksjsIbrH+POFOi4jN03Y/rb0yJA4
 3VSPVL3YzB11FuLTYxIMfX3cTQjCUC1sS/v0HUpSjBrPPRD8A1mV5VfPrLgFo/pqYrfQ
 RrZiK7MtARZWlskb9pjRhURF9MXCZ4NuEouet4bbgqLZpK/dmuWI58JE/i2FDgrJxw+N
 zMcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBvgoytWn0gqYQhb18TTiuK4XQZ7mcTrTtSuwchcqWVm5+CWCALDvt7yJR0iUqcobbBk9RmptSavIRvpyyr/l6tZlF9A==
X-Gm-Message-State: AOJu0Yw2tLmRETcTOjljPiDQCiuZH0SfiAFJEyXyeiyYOK+ynQ4m1sx7
 1OcCEhe2zTmzrkEh4gWGo6C/CINFiCPnGImYooM8Pu1Jf94XfVPuGuhDWBpvT4E=
X-Google-Smtp-Source: AGHT+IE+yIG+CRnrhve++JjjlX9/SxeyGoqbUbDu3hfcENhOU3QtP/QYG6VCcmPGmNdubhr5bu8uAg==
X-Received: by 2002:a2e:a310:0:b0:2e0:5f2c:e0c0 with SMTP id
 38308e7fff4ca-2e949540cd1mr24973931fa.37.1716444533822; 
 Wed, 22 May 2024 23:08:53 -0700 (PDT)
Received: from localhost (lfbn-tou-1-402-59.w86-206.abo.wanadoo.fr.
 [86.206.229.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fad8e2sm14606485e9.33.2024.05.22.23.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 23:08:53 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Roman Stratiienko <r.stratiienko@gmail.com>
Cc: sjg@chromium.org, eajames@linux.ibm.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, paulerwan.rio@gmail.com,
 u-boot@lists.denx.de, igor.opaniuk@gmail.com
Subject: Re: [PATCH] abootimg: Add init_boot image support
In-Reply-To: <CAGphcd=ewtSE8VkfX=c4CL6-L7wj9badr3v_2Ep9QvJqHjZEiw@mail.gmail.com>
References: <20240519125337.2557883-1-r.stratiienko@gmail.com>
 <874japzz3s.fsf@baylibre.com>
 <CAGphcd=ewtSE8VkfX=c4CL6-L7wj9badr3v_2Ep9QvJqHjZEiw@mail.gmail.com>
Date: Thu, 23 May 2024 08:08:50 +0200
Message-ID: <871q5tys99.fsf@baylibre.com>
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

Hi Roman,

On jeu., mai 23, 2024 at 00:35, Roman Stratiienko <r.stratiienko@gmail.com> wrote:

[...]

>> >
>> >  static struct cmd_tbl cmd_abootimg_sub[] = {
>> > -     U_BOOT_CMD_MKENT(addr, 3, 1, do_abootimg_addr, "", ""),
>> > +     U_BOOT_CMD_MKENT(addr, 4, 1, do_abootimg_addr, "", ""),
>> >       U_BOOT_CMD_MKENT(dump, 2, 1, do_abootimg_dump, "", ""),
>> >       U_BOOT_CMD_MKENT(get, 5, 1, do_abootimg_get, "", ""),
>> >       U_BOOT_CMD_MKENT(load, 5, 1, do_abootimg_load, "", ""),
>> > @@ -375,7 +391,7 @@ static int do_abootimg(struct cmd_tbl *cmdtp, int flag, int argc,
>> >  U_BOOT_CMD(
>> >       abootimg, CONFIG_SYS_MAXARGS, 0, do_abootimg,
>> >       "manipulate Android Boot Image",
>> > -     "addr <boot_img_addr> [<vendor_boot_img_addr>]>\n"
>> > +     "addr <boot_img_addr> [<vendor_boot_img_addr> [<init_boot_img_addr>]]\n"
>> >       "    - set the address in RAM where boot image is located\n"
>> >       "      ($loadaddr is used by default)\n"
>>
>> Please include the help text update in the documentation:
>> doc/android/boot-image.rst
>
> That documentation does not mention 'abootimg addr' command at the moment.
> I do not see an easy way to add it in a way that makes sense.
>

I see. I will send a documentation update later then.

>>
>> >       "abootimg dump dtb\n"
>> > diff --git a/include/image.h b/include/image.h
>> > index be3c73a72e..b1fd6b3149 100644

[...]
