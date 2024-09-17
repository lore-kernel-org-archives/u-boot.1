Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537BEC36006
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 10:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B2C88D2C;
	Tue, 17 Sep 2024 12:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bJB+FZQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41F4988D31; Tue, 17 Sep 2024 12:15:38 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DF2488D1B
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 12:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c27067b81aso4902437a12.0
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 03:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726568135; x=1727172935; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PVQqkUdM2TpK9VXkMezCTLMXLFhwY8lX/OKgZKvKxoI=;
 b=bJB+FZQt4vBKdqmcPoYQxjs+MHsxre0/7NXz8REvR14/o1gnfqFhEgllXl1qxZGovq
 At0uAr74ushOq6BtgofKLq24s+KBE9HeT2ajrNhFIMy5zHDwMSpM32erqllvbvr5QI9A
 6ueDFgiDuBE3xHApn+J5/La8d/S/kwESv50A/p0e+WCJz4b11L8pGZVCknJGMHOdzmgZ
 pJ/kqPOQUtlu7+B8hlJCnAZskRzhDzZItdKM7SnDxgA9Pnc21KDI1qLjdRemNlq428Bj
 CAi6PGRkyqNiZ+caKoSauFDTAdDh6IQWkKxF4l8Hx8Bzyogc+2Zlgvi60SgPJcxNkKn4
 MLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726568135; x=1727172935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PVQqkUdM2TpK9VXkMezCTLMXLFhwY8lX/OKgZKvKxoI=;
 b=EtJSpuSb1wH6Ff6cpd74ElLRu/6G0iM79R3ADpuhSeyEy2i+bdTbbs9SnApgdIuw3f
 6LaNZgOCe/Tq4jG5qJu/7bxHqWv5mjGMd3Iv/g5onINOZKwGPrQJB2CqBnN/rLjWEci/
 6kL8N70gDUUp3qEusSjV3JT6qATfpaSIucpcb9tJqaQLCd2gOoM91PRcRXIAa5jzIqo5
 jpCyzeiAWRT/rMLoENuUKmoz+4O0R+FJN5TRKZ6djMxw/JbovyO9TjTMW3J1Aq63Glaw
 MnBAH2APdCdzW1u3s1iVFE3jSp1jcKCw2KPTkFpH6RVPdlPM0LMM2dbZWYKquTvp805L
 QY1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8zx5aM8FwMBKR0WvsGjDHmB9ScqgBnJb5gn09SXLmXnOqsGVxndXoMXU+zTwJRfXatxUjtGQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxAwUo12t69HeuU+C8DaL0zGRN1Di70FLb7aUykcqRa2q6T5Sq/
 bkhST8fB+3OE2K4pZ6HkuzwocfFlR6Sop4LagaR1tJtMBR//I7UvtFelpn5gWSkIkGMtg1Dwvsu
 ekZzusDnDc95aLZ835zRVNlBmEMDeMO/5XxGPLg==
X-Google-Smtp-Source: AGHT+IHOxnT+tvKbuYQo3RnuZBLZlEglGPlzcLIOX2vz6xBfp1MUUqLnXxbEef0UNWUt9AOqH+cAMcWdHrKJthq7bdA=
X-Received: by 2002:a05:6402:3586:b0:5c4:2bd6:68d9 with SMTP id
 4fb4d7f45d1cf-5c42bd7d79bmr8815071a12.7.1726568135376; Tue, 17 Sep 2024
 03:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240916054038.2125910-1-vaishnav.a@ti.com>
In-Reply-To: <20240916054038.2125910-1-vaishnav.a@ti.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 17 Sep 2024 15:45:24 +0530
Message-ID: <CADg8p95UdVkqS5wVr29yy4hd71q6gz_0GztvvVrE4qBubHsf2Q@mail.gmail.com>
Subject: Re: [PATCH] fs: Fix reserved memory alloaction in fs_read()
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 seanga2@gmail.com, akashi.tkhro@gmail.com, u-boot@lists.denx.de, 
 vigneshr@ti.com, nm@ti.com, u-kumar1@ti.com
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

On Mon, 16 Sept 2024 at 11:10, Vaishnav Achath <vaishnav.a@ti.com> wrote:
>
> The reserved memory region in fs_read() is not being
> freed after read, free that. The issue was uncovered by
> commit ed17a33fed29 ("lmb: make LMB memory map persistent and global")
> as now the region used to load from fs cannot be reused by other
> loaders like tftp, wget which use lmb_get_free_size() instead
> of lmb_alloc_addr(), other loaders which uses lmb_reserve() is
> appropriately freeing the buffer after usage (Eg. Serial loader).
> Also while at it move #if CONFIG_IS_ENABLED(LMB) to if (IS_ENABLED()).
>
> Fixes aa3c609e2be5 ("fs: prevent overwriting reserved memory")
>
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---

Just for the record, this patch does not need to be applied. The
load-address based LMB checks in the tftp and wget functions have been
tweaked so that this issue will no longer be relevant -- those patches
have been tested by Vaishnav to confirm the same. Thanks.

-sughosh

>
> We started seeing boot failures since we have platforms that perform
> mmc load for firmwares and subsequent tftp load for kernel to same
> loadaddr, the reservation need not be permanent and is only to make
> sure that the read is not overwriting reserved regions, there is no
> permanent reservation/protection needed for each load.
>
> In failing case (J7200 EVM):
>
> _snip_
> run boot_rprocs
> 75416 bytes read in 11 ms (6.5 MiB/s)
> Load Remote Processor 2 with data@addr=0x82000000 75416 bytes: Success!
> 75416 bytes read in 12 ms (6 MiB/s)
> Load Remote Processor 3 with data@addr=0x82000000 75416 bytes: Success!
> _snip_
> lmb_dump_all:
>  memory.count = 0x1
>  memory[0]    [0x80000000-0xffffffff], 0x80000000 bytes flags: none
>  reserved.count = 0x3
>  reserved[0]    [0x82000000-0x82012697], 0x00012698 bytes flags: none (this is from previous mmc load, size == 12698h = 75416)
>  reserved[1]    [0x9e800000-0xa47fffff], 0x06000000 bytes flags: no-map
>  reserved[2]    [0xfce8fef0-0xffffffff], 0x03170110 bytes flags: no-overwrite
>
> With fix:
> lmb_dump_all:
>  memory.count = 0x1
>  memory[0]    [0x80000000-0xffffffff], 0x80000000 bytes flags: none
>  reserved.count = 0x2
>  reserved[1]    [0x9e800000-0xa47fffff], 0x06000000 bytes flags: no-map
>  reserved[2]    [0xfce8fef0-0xffffffff], 0x03170110 bytes flags: no-overwrite
>
>  fs/fs.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/fs/fs.c b/fs/fs.c
> index 4bc28d1dff..e00c2056a5 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -552,7 +552,7 @@ static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
>         lmb_dump_all();
>
>         if (lmb_alloc_addr(addr, read_len) == addr)
> -               return 0;
> +               return read_len;
>
>         log_err("** Reading file would overwrite reserved memory **\n");
>         return -ENOSPC;
> @@ -564,15 +564,13 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
>  {
>         struct fstype_info *info = fs_get_info(fs_type);
>         void *buf;
> -       int ret;
> +       int ret, alloc_size;
>
> -#if CONFIG_IS_ENABLED(LMB)
> -       if (do_lmb_check) {
> -               ret = fs_read_lmb_check(filename, addr, offset, len, info);
> -               if (ret)
> -                       return ret;
> +       if (IS_ENABLED(CONFIG_LMB) && do_lmb_check) {
> +               alloc_size = fs_read_lmb_check(filename, addr, offset, len, info);
> +               if (alloc_size < 0)
> +                       return alloc_size;
>         }
> -#endif
>
>         /*
>          * We don't actually know how many bytes are being read, since len==0
> @@ -587,6 +585,9 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
>                 log_debug("** %s shorter than offset + len **\n", filename);
>         fs_close();
>
> +       if (IS_ENABLED(CONFIG_LMB) && do_lmb_check)
> +               lmb_free(addr, alloc_size);
> +
>         return ret;
>  }
>
> --
> 2.34.1
>
