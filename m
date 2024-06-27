Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741A3C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 19:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48B708852A;
	Thu, 27 Jun 2024 21:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LCbYtSwT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A47884A9; Thu, 27 Jun 2024 21:05:56 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD10884A9
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 21:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-706b539fcaeso711222b3a.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719515153; x=1720119953; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pZzwDY7CuRWIhhOHwuzOzEGOaEnpThTlQu7ZRWBBMgM=;
 b=LCbYtSwTk4ec5r6Kd2Q1aezQnSucPap+VFOWU/3IW9m0EiADVsuax4zcqHBd9TlwMZ
 4BieBnqjoYFgxj0cZJVhIHLvs+gaOzu5EAH5HiIC6RcgvhZSrYRQYITCMSpHuHOElxzL
 Iq0A36XJxKSisLfLHU2DCTajzKukpdbKx5zRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719515153; x=1720119953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pZzwDY7CuRWIhhOHwuzOzEGOaEnpThTlQu7ZRWBBMgM=;
 b=TsexQTFa2DvvJvzYjSfk8Bfce9AmEQgt7NsS/PV+UXqgoa2bxjoLq/BIFaBBAbFn9k
 s/PpTiSfVDZ4eQFInT746OB8YmLZhxm9FnwGd+HZm3VJ81TxVUDO9jnitfSZpXQmxWtw
 sc0wHD1oHwDcC498/fTJQ3dTGbPhyY4AoQdhwaxJYmnxrxjQYFcsadNKh/YuN6iw9/Rd
 Cm8NZNG/Jmeal2/9I4MGAqvIOXWlSjpzZoXPpoGejZrQJLbE60u8tRAqWL2itJODVJQ+
 szUYJZOVmRmx1At9lvF+tsF6YARoiK1r+urGgxMn9z+XcjVNc41dv6jdUBVjYgXtYlAE
 8c3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPxHaWjtw1YTo6dR7HlJmln9+gcMLPp/aS0l/WuNqUAVNaxkAtO9ar6DGOdMJ0FG03Np+aNUUgjBn1irJjDrcBSs5PSA==
X-Gm-Message-State: AOJu0YxiZ+kpnIbeL3eRFkvtxUi94CM8u2yNhGbo2uo0l0Cxfs7Izy+j
 itS8TnLmMibCRaV8slRytN9ayOk2FSMiW4tlJEGNg6bmf4Soxu+wt/oENHxOV6Xoja9KarH8kb/
 JUzLf2pV40fgzsMJbFrKxOBMsCFum2CMqMmIM
X-Google-Smtp-Source: AGHT+IEp3Jc6YBAUh1OYxxzlq/DtDYmuz+xnjP+SoRO8Ykk7E9m8Pjgo92vtwwunjfv4JjSRwcjjZmuIe79kBt1Q7Hk=
X-Received: by 2002:a17:90b:234b:b0:2c8:8bf8:4e24 with SMTP id
 98e67ed59e1d1-2c8a2357084mr14031994a91.8.1719515152873; Thu, 27 Jun 2024
 12:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240627112904.99969-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240627112904.99969-1-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 20:05:41 +0100
Message-ID: <CAFLszThsS2oYVx3zxZhN6HSzHkA-NStydZfS=Jr25FpwRimJNA@mail.gmail.com>
Subject: Re: [PATCH] gpt: allow spaces in partition list
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joshua Watt <jpewhacker@gmail.com>,
 Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Mikhail,

On Thu, 27 Jun 2024 at 12:29, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This allows spliting partition list to several lines in environment file
>
> ex:
> --------------------
> gpt_partition_list=
>         name=boot1,size=5MiB,start=0x100000;
>         name=boot2,size=5MiB;
>         name=rootfs1,size=70MiB;
>         name=rootfs2,size=70MiB;
>         name=overlay1,size=20MiB;
>         name=overlay2,size=20MiB;
>         name=art,size=4MiB;

Is this referring to a .env file, i.e. a text environment file? If so,
I would hope that spaces at the start of a line would be automatically
removed.

>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  cmd/gpt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index 7aaf1889a5a..2b29ab98ccc 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -117,6 +117,7 @@ static char *extract_val(const char *str, const char *key)
>                 k = strsep(&v, "=");
>                 if (!k)
>                         break;
> +               k += strspn(k, " \t");
>                 if  (strcmp(k, key) == 0) {
>                         new = strdup(v);
>                         break;
> @@ -151,6 +152,7 @@ static bool found_key(const char *str, const char *key)
>                 k = strsep(&s, ",");
>                 if (!k)
>                         break;
> +               k += strspn(k, " \t");
>                 if  (strcmp(k, key) == 0) {
>                         result = true;
>                         break;
> --
> 2.43.0
>

Regards,
Simon
