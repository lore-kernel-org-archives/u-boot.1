Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281C7C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 09:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B82B8710F;
	Fri,  3 Nov 2023 10:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JtlbHCJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0D9F86F4A; Fri,  3 Nov 2023 10:43:29 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7831C8710F
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 10:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c594196344so25152301fa.3
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 02:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699004604; x=1699609404;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gjG5kfKe+AVIwaFUq3mTmblGfVqg7kdim9H0gv/9ago=;
 b=JtlbHCJlZj/m1hPJKQI2hAx9mj0NYFXLh13h77tknS/qrj5PXrWViF1vHxVcwLp+PJ
 ag1ZNVJtuHj5tcgj60aRPrH5wrcJdL/+qGzldNqFqHTVdP8C3TqMJ3kyAW+ILE3Z+HAP
 JTK6+Zi5oUE9w3OpIQTVpHcrhjiffqNGcdgYPJoG60n4kEx2nUSEegsl+4i6ZrS9Rrlh
 ly86j8ucr43Ss25TdxbG2I27Y2e2l2rEcLW4+MNCi+yum/fBUgLCbQoiYIhBGQ4RiGv0
 D4Py5MFf3uRvkqC0FSXJ+WZZTGJUqEkMzG5s5diAmKleTwSpDDn3gIhtCqwzlnoL9ONL
 4vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699004604; x=1699609404;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gjG5kfKe+AVIwaFUq3mTmblGfVqg7kdim9H0gv/9ago=;
 b=ftH34wGNZdXHtv7NDTft+4lVstidsfD8D0SV7OKldQ0jip8P02md7f/vayWm57h6/f
 MWPAjz3fJjBtmZV3CjmOKrqB1GH8cS5lZiExB0SXjPCjJ8hZxz1jDPtVYdWBYpF+G1qN
 A2H7nbilQE+/i96/p7CnqkA3HFiRkz4E/p9yvgAdDezoZUppGPPEPTRSi4/dt2WMIWVN
 MXYq43K4YvZpKExqQPXMeewN0rObe/jaqaUGMJHuh7o+ez9od4s0f/+lHqU7wturbdUB
 BGw4w8uj3bZNW/PplvCFvCU+z2dwRR1ftlKfn2OEhXUUCqbQ9QeIIiJX8LXFDatfClnm
 l/dw==
X-Gm-Message-State: AOJu0YyaUcIVIoZcnsVR2vVnD6nAlCQ1DBSNsuJdhAHMS0KPuAkNnUeW
 Mbtii2w9ABjHthmOqzt7wYrln96oK77JQqs/XGE=
X-Google-Smtp-Source: AGHT+IG/F0oQn5Rx3oF9yN0ZkFOykfzi5nwwgwZetivKDL6Eyta6Nuc4ZeEKB9troU2mzrDfZfOrWA==
X-Received: by 2002:a2e:9259:0:b0:2c5:8aa7:b922 with SMTP id
 v25-20020a2e9259000000b002c58aa7b922mr15424171ljg.19.1699004603635; 
 Fri, 03 Nov 2023 02:43:23 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e2:8300:dbea:ecb8:b89e:dd0f])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a7bcc15000000b0040773c69fc0sm1854694wmh.11.2023.11.03.02.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 02:43:23 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: lukma@denx.de, u-boot@lists.denx.de
Subject: RE: [PATCH] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
In-Reply-To: <056c01da0df2$1cd85fc0$56891f40$@samsung.com>
References: <CGME20220620111357epcas1p103474818319b5dc45260e043b4ffe3cc@epcas1p1.samsung.com>
 <20220620111354.448512-1-jh80.chung@samsung.com>
 <169876380794.37728.2863914527348419844.b4-ty@baylibre.com>
 <87h6m4zfbx.fsf@baylibre.com>
 <056c01da0df2$1cd85fc0$56891f40$@samsung.com>
Date: Fri, 03 Nov 2023 10:43:22 +0100
Message-ID: <87y1ffmath.fsf@baylibre.com>
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

Hi Jaehoon,

On ven., nov. 03, 2023 at 10:07, "Jaehoon Chung" <jh80.chung@samsung.com> wrote:

> Hi Mathtjjs,
>
>> -----Original Message-----
>> From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Sent: Thursday, November 2, 2023 6:15 PM
>> To: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: lukma@denx.de; u-boot@lists.denx.de
>> Subject: Re: [PATCH] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
>> 
>> Hi Jaehoon,
>> 
>> On mar., oct. 31, 2023 at 15:50, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
>> 
>> > Hi,
>> >
>> > On Mon, 20 Jun 2022 20:13:54 +0900, Jaehoon Chung wrote:
>> >> Add CONFIG_DFU_NAME_MAX_SIZE to change the proper size.
>> >> If name is longer than default size, it can do wrong behavior during updating
>> >> image. So it need to change the proper maximum size.
>> >>
>> >> This patch is proviced the solution to change value with configuration.
>> >>
>> >>
>> >> [...]
>> >
>> > Thanks, Applied to https://protect2.fireeye.com/v1/url?k=195a8ba3-78d19e99-195b00ec-74fe4860008a-
>> e609da47a4bcadff&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
>> boot%2Fcustodians%2Fu-boot-dfu (u-boot-dfu-next)
>> >
>> > [1/1] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
>> >       https://protect2.fireeye.com/v1/url?k=b04b2ae8-d1c03fd2-b04aa1a7-74fe4860008a-
>> d8ec8502221dcca0&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
>> boot%2Fcustodians%2Fu-boot-dfu%2F-%2Fcommit%2Fde9b2e10f10996050a10998a0836abe2f9e425e3
>> 
>> 
>> This patch breaks CI for both arm32 and arm64 platforms:
>> 
>> * https://protect2.fireeye.com/v1/url?k=3179f7cc-50f2e2f6-31787c83-74fe4860008a-
>> a4f5d2c73833c4d5&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
>> boot%2Fcustodians%2Fu-boot-dfu%2F-%2Fjobs%2F725163
>> * https://protect2.fireeye.com/v1/url?k=22773f8e-43fc2ab4-2276b4c1-74fe4860008a-
>> f6dc3d75fe9b283a&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
>> boot%2Fcustodians%2Fu-boot-dfu%2F-%2Fjobs%2F725164
>
> I couldn't access the above CI URL.

Sorry about that. CI was not public. That is fixed now.

>
>> 
>> It breaks because multiple boards which include dfu.h without having
>> CONFIG_DFU being set.
>> 
>> Tom attempted to fix this with:
>> https://protect2.fireeye.com/v1/url?k=452a9007-24a1853d-452b1b48-74fe4860008a-
>> a88f870953497071&q=1&e=b6fd9ce6-85b6-46a3-81aa-
>> 8aa89d16a9ed&u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fuboot%2Flist%2F%3Fseries%3D369275
>> 
>> But that had some different issues, see:
>> https://protect2.fireeye.com/v1/url?k=f1c007bd-904b1287-f1c18cf2-74fe4860008a-
>> a305de1bab5bdff1&q=1&e=b6fd9ce6-85b6-46a3-81aa-
>> 8aa89d16a9ed&u=https%3A%2F%2Flibera.irclog.whitequark.org%2Fu-boot%2F2023-10-31%2335154532;
>> 
>> I've fixed it up with the following diff:
>> 
>> diff --git a/include/dfu.h b/include/dfu.h
>> index 4573f753c565..2c3ffa3f9297 100644
>> --- a/include/dfu.h
>> +++ b/include/dfu.h
>> @@ -99,7 +99,12 @@ struct virt_internal_data {
>>         int dev_num;
>>  };
>> 
>> +
>> +#if defined(CONFIG_DFU_NAME_MAX_SIZE)
>>  #define DFU_NAME_SIZE                  CONFIG_DFU_NAME_MAX_SIZE
>> +#else
>> +#define DFU_NAME_SIZE                  32
>> +#endif
>>  #ifndef DFU_DEFAULT_POLL_TIMEOUT
>>  #define DFU_DEFAULT_POLL_TIMEOUT 0
>>  #endif
>> 
>> If you have a better idea to fix this, can you please let me know?
>
> After checking this, let you inform.
>
>> Otherwise, I will squash this to keep CI green.
>> 
>> Thank you
>> 
>> >
>> > --
>> > Mattijs
