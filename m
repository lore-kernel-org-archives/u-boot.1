Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832C6C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 09:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C93F486C31;
	Tue,  7 Nov 2023 10:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c2rQEj2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 079F787116; Tue,  7 Nov 2023 10:08:52 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7DB86996
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 10:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50939d39d0fso7086021e87.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 01:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699348128; x=1699952928;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SMbFnfy20Y7eJGfjOvL5h6b0ybFDjxjZDYuxa0CENUA=;
 b=c2rQEj2v/zBkHDosDk73Haies9FijJE2tnRlXJ4iROU7B3VQbUnTT9XriRasGAzNCy
 OZa7zm62m4/NcIYqYx9gl/bhm+imFgSmSVJWgpfhaYH9g7JfS//ogntl1uJyn+QhRymz
 /MkjQ5H6Wu41hTGo3DsH4OZIYOUCJpmc8ZQsOQmgRD2ISny2rP5nmTkhjCgXHCGK3N0t
 NWEyesLXgfzT5+r3Zo9p5dGkUK1XYL5ox7NSeuTdhshNrcW0ivflgWBTsmmjDQVutwlt
 aTr61DCuqLZeXh0TsEmKLuGilV4ru9WOxTTzuSnNC4i9W+cCtgdRPB940bQJ+/Mx+aD7
 ar/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699348128; x=1699952928;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SMbFnfy20Y7eJGfjOvL5h6b0ybFDjxjZDYuxa0CENUA=;
 b=vBRS6QPbf8xSkWfZ67t1YmB/KaMmBm1+b+PsvWpQqI9gRm3WpoS+5kWt3v2r3fYw2Y
 dM4TparqGfCp9tTDQk7f+ulr3XLMPru7QyaLfIqE3QJiR1LQC9OZml/ED9rhWRXLKvIa
 WIaTBtTZdPXm4guxY1n5DOy399wmlyJD18rqq/InxlBiGeVQe5NHvyzJwLlCPQ61P5fd
 eWPjiBCOmeyk6tRVNrA0MChCw6hNmDX91vxubUaxhfR060RCmpPnd7ETO3zYZk5OJTCq
 dNEdUvMKDTmNOF/8IxGEY0lHlEtPCNJHuwS0WZbcA11I8Vt1POID/t8ygzjGYU6gsw13
 TMWA==
X-Gm-Message-State: AOJu0Yyzvl105oAegWlkjvrvmYwNGVFrja/bPB8rUeeWRlbFwf5UwUsI
 6E+6hEa1jpMXcDafWHuSJtoHQw==
X-Google-Smtp-Source: AGHT+IF/1SKnGQsB7tdXVm+L7UEwXyq0Os38W/CdNR+K5Pz+pRsQ4Ak5sh0vVa+srYrDn6mTruxMLA==
X-Received: by 2002:a19:5206:0:b0:507:adc9:a739 with SMTP id
 m6-20020a195206000000b00507adc9a739mr26416918lfb.37.1699348127828; 
 Tue, 07 Nov 2023 01:08:47 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 v16-20020a5d4b10000000b003253523d767sm1758720wrq.109.2023.11.07.01.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 01:08:47 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: lukma@denx.de, u-boot@lists.denx.de
Subject: RE: [PATCH] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
In-Reply-To: <000801da0e19$87c90380$975b0a80$@samsung.com>
References: <CGME20220620111357epcas1p103474818319b5dc45260e043b4ffe3cc@epcas1p1.samsung.com>
 <20220620111354.448512-1-jh80.chung@samsung.com>
 <169876380794.37728.2863914527348419844.b4-ty@baylibre.com>
 <87h6m4zfbx.fsf@baylibre.com>
 <056c01da0df2$1cd85fc0$56891f40$@samsung.com>
 <000801da0e19$87c90380$975b0a80$@samsung.com>
Date: Tue, 07 Nov 2023 10:08:46 +0100
Message-ID: <87h6ly9bhd.fsf@baylibre.com>
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

On ven., nov. 03, 2023 at 14:49, "Jaehoon Chung" <jh80.chung@samsung.com> wrote:

> Hi,
>
>> -----Original Message-----
>> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
>> Sent: Friday, November 3, 2023 10:07 AM
>> To: 'Mattijs Korpershoek' <mkorpershoek@baylibre.com>
>> Cc: lukma@denx.de; u-boot@lists.denx.de
>> Subject: RE: [PATCH] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
>> 
>> Hi Mathtjjs,
>> 
>> > -----Original Message-----
>> > From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> > Sent: Thursday, November 2, 2023 6:15 PM
>> > To: Jaehoon Chung <jh80.chung@samsung.com>
>> > Cc: lukma@denx.de; u-boot@lists.denx.de
>> > Subject: Re: [PATCH] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
>> >
>> > Hi Jaehoon,
>> >
>> > On mar., oct. 31, 2023 at 15:50, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
>> >
>> > > Hi,
>> > >
>> > > On Mon, 20 Jun 2022 20:13:54 +0900, Jaehoon Chung wrote:
>> > >> Add CONFIG_DFU_NAME_MAX_SIZE to change the proper size.
>> > >> If name is longer than default size, it can do wrong behavior during updating
>> > >> image. So it need to change the proper maximum size.
>> > >>
>> > >> This patch is proviced the solution to change value with configuration.
>> > >>
>> > >>
>> > >> [...]
>> > >
>> > > Thanks, Applied to https://protect2.fireeye.com/v1/url?k=195a8ba3-78d19e99-195b00ec-74fe4860008a-
>> > e609da47a4bcadff&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
>> > boot%2Fcustodians%2Fu-boot-dfu (u-boot-dfu-next)
>> > >
>> > > [1/1] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
>> > >       https://protect2.fireeye.com/v1/url?k=b04b2ae8-d1c03fd2-b04aa1a7-74fe4860008a-
>> > d8ec8502221dcca0&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
>> > boot%2Fcustodians%2Fu-boot-dfu%2F-%2Fcommit%2Fde9b2e10f10996050a10998a0836abe2f9e425e3
>> >
>> >
>> > This patch breaks CI for both arm32 and arm64 platforms:
>> >
>> > * https://protect2.fireeye.com/v1/url?k=3179f7cc-50f2e2f6-31787c83-74fe4860008a-
>> > a4f5d2c73833c4d5&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
>> > boot%2Fcustodians%2Fu-boot-dfu%2F-%2Fjobs%2F725163
>> > * https://protect2.fireeye.com/v1/url?k=22773f8e-43fc2ab4-2276b4c1-74fe4860008a-
>> > f6dc3d75fe9b283a&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
>> > boot%2Fcustodians%2Fu-boot-dfu%2F-%2Fjobs%2F725164
>> 
>> I couldn't access the above CI URL.
>> 
>> >
>> > It breaks because multiple boards which include dfu.h without having
>> > CONFIG_DFU being set.
>> >
>> > Tom attempted to fix this with:
>> > https://protect2.fireeye.com/v1/url?k=452a9007-24a1853d-452b1b48-74fe4860008a-
>> > a88f870953497071&q=1&e=b6fd9ce6-85b6-46a3-81aa-
>> > 8aa89d16a9ed&u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fuboot%2Flist%2F%3Fseries%3D369275
>> >
>> > But that had some different issues, see:
>> > https://protect2.fireeye.com/v1/url?k=f1c007bd-904b1287-f1c18cf2-74fe4860008a-
>> > a305de1bab5bdff1&q=1&e=b6fd9ce6-85b6-46a3-81aa-
>> > 8aa89d16a9ed&u=https%3A%2F%2Flibera.irclog.whitequark.org%2Fu-boot%2F2023-10-31%2335154532;
>> >
>> > I've fixed it up with the following diff:
>> >
>> > diff --git a/include/dfu.h b/include/dfu.h
>> > index 4573f753c565..2c3ffa3f9297 100644
>> > --- a/include/dfu.h
>> > +++ b/include/dfu.h
>> > @@ -99,7 +99,12 @@ struct virt_internal_data {
>> >         int dev_num;
>> >  };
>> >
>> > +
>> > +#if defined(CONFIG_DFU_NAME_MAX_SIZE)
>> >  #define DFU_NAME_SIZE                  CONFIG_DFU_NAME_MAX_SIZE
>> > +#else
>> > +#define DFU_NAME_SIZE                  32
>> > +#endif
>> >  #ifndef DFU_DEFAULT_POLL_TIMEOUT
>> >  #define DFU_DEFAULT_POLL_TIMEOUT 0
>> >  #endif
>> >
>> > If you have a better idea to fix this, can you please let me know?
>> 
>> After checking this, let you inform.
>
> It seems that it is depended on USB_GADGET and SPL_USB_GADGET. How about this?
> About <dfu.h> is included in some board files, It needs to check more.
>
> diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
> index 6502aba96f54..9922da56e704 100644
> --- a/drivers/dfu/Kconfig
> +++ b/drivers/dfu/Kconfig
> @@ -13,6 +13,14 @@ config DFU_OVER_TFTP
>         bool
>         depends on NET
>
> +config DFU_NAME_MAX_SIZE
> +       int "Size of the name to be added in dfu entity"
> +       default 32
> +       depends on DFU || USB_GADGET_DOWNLOAD || SPL_USB_GADGET
> +       help
> +         This value is used to maximum size. If name is longer than default size,
> +         we need to change the proper maximum size.
> +
>  if DFU
>  config DFU_WRITE_ALT
>         bool
> @@ -112,13 +120,5 @@ config SYS_DFU_MAX_FILE_SIZE
>           this to the maximum filesize (in bytes) for the buffer.
>           If undefined it defaults to the CONFIG_SYS_DFU_DATA_BUF_SIZE.
>
> -config DFU_NAME_MAX_SIZE
> -       int "Size of the name to be added in dfu entity"
> -       default 32
> -       depends on DFU
> -       help
> -         This value is used to maximum size. If name is longer than default size,
> -         we need to change the proper maximum size.
>
> I'm running CI with some patch. After checked, I will inform.

Did your CI run finish ? Is your solution working or should we pick up
the diff I send ?

>
> Best Regards,
> Jaehoon Chung
>
>> 
>> > Otherwise, I will squash this to keep CI green.
>> >
>> > Thank you
>> >
>> > >
>> > > --
>> > > Mattijs
