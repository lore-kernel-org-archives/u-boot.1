Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1FFC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 08:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C6187876;
	Tue,  9 Jan 2024 09:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="csq2DIXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432EF87874; Tue,  9 Jan 2024 09:57:26 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47E7B8788A
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 09:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2cd56dac1adso20280201fa.2
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 00:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704790643; x=1705395443; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BntdAFzQeLTibRKT7FHxOBClqXl5Qi1Z2gyu6zMzPwU=;
 b=csq2DIXKUH1RbXgYUzPdMki2TAAoe/vlQ6xhB4yVrDpvydrQSCoKZvmpg3JhuaO7rA
 3HGUlK1qhE7rug2UBNrJRcBHHoi1Yc+MiRf6hD9No8UdBhQoTdr5/sOe4zHqINlkfkSn
 98AYKV7NJCGtT+TayjO1peqjT25zelDMsFYNfJ7G/1Cq0UaDWBOH4UdY3pF0kVknMmSj
 cV8irP2JYSgDH0MKXocnI/R7l9pEHE7azic7SbgwZzP6Ev6B54YbOPAbDLtvIADk4B7a
 QLfZBycHqf8PBHlyMKPBd5tTYI2I6U6YU6THB5S8KQtOdDArZU5A9W2Zko+YNfJYJ4fd
 WoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704790643; x=1705395443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BntdAFzQeLTibRKT7FHxOBClqXl5Qi1Z2gyu6zMzPwU=;
 b=pYAK3qkD9AfCovgiT3CqmHzc1XII27iXldDe4H2Pu69jgXDPscTQaIhSmJzIK9rPHm
 gyvRCiOI7CN1XGxyT4f1plKW0tVz5OwhqUuGDhkXNktWE5JJ5PZx2AmJg3lvSOFLbG5r
 F7MaUYRvMLZxV/wCD9Pv6XBlk2lFHJjZgHmggdPVKUF+EQwVfMW4yKRtHTEgb53pFpgl
 qmZD/EZb2mWDgTMDZavZ1sgawoV0d1o0sNkPxryfbIPKxufIKeYI6d3NdMQdMvtkBXZu
 jLb7fR9P66rcOG0mHrJrTCgEPDGucv+Z/Im1L0cxPLn34sABMnq7vy2vprwGNpMw0Cq/
 gaQA==
X-Gm-Message-State: AOJu0Yzovo1zDKhxZiy4TBh7oQczor9m6Hpo1dOHPch3ZhiUwh622UuH
 7RcR0wal9yTkZ0gTRNGsEllU3xNiq/OvSQfyo/svhbgaUSjdPQ==
X-Google-Smtp-Source: AGHT+IG+W3T04UxvMP4sq/y6xdKkSAEGMgJiqUMLmwZiM47VKCOEnF2TrGe2hX02qcHHgvGa+KTbRQnm3xj3RVUcVhI=
X-Received: by 2002:ac2:5928:0:b0:50e:9c59:5627 with SMTP id
 v8-20020ac25928000000b0050e9c595627mr2024671lfi.45.1704790643525; Tue, 09 Jan
 2024 00:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20240109085334.41481-1-heinrich.schuchardt@canonical.com>
 <20240109085334.41481-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240109085334.41481-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 9 Jan 2024 10:56:47 +0200
Message-ID: <CAC_iWjJniq4hXHA6-dc6ukn4BZFhuV50enr0ueQD-s+Ts1GsVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lib: smbios: verify_checksum() is duplicate
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
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

On Tue, 9 Jan 2024 at 10:53, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The function verify_checksum() duplicates what table_compute_checksum()
> does. Replace it. table_compute_checksum() is always compiled.
>
> Fixes: 415eab0655a8 ("smbios: add parsing API")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v2:
>         correct sequence of includes
> ---
>  lib/smbios-parser.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
> index b578c30840..110670343d 100644
> --- a/lib/smbios-parser.c
> +++ b/lib/smbios-parser.c
> @@ -5,22 +5,8 @@
>  #define LOG_CATEGORY   LOGC_BOOT
>
>  #include <smbios.h>
> +#include <tables_csum.h>
>
> -static inline int verify_checksum(const struct smbios_entry *e)
> -{
> -       /*
> -        * Checksums for SMBIOS tables are calculated to have a value, so that
> -        * the sum over all bytes yields zero (using unsigned 8 bit arithmetic).
> -        */
> -       u8 *byte = (u8 *)e;
> -       u8 sum = 0;
> -
> -       for (int i = 0; i < e->length; i++)
> -               sum += byte[i];
> -
> -       return sum;
> -}
> -
>  const struct smbios_entry *smbios_entry(u64 address, u32 size)
>  {
>         const struct smbios_entry *entry = (struct smbios_entry *)(uintptr_t)address;
> @@ -32,7 +18,7 @@ const struct smbios_entry *smbios_entry(u64 address, u32 size)
>         if (memcmp(entry->anchor, "_SM_", 4))
>                 return NULL;
>
> -       if (verify_checksum(entry))
> +       if (table_compute_checksum(entry, entry->length))
>                 return NULL;
>
>         return entry;
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
