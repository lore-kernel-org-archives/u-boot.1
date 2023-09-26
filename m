Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F8AE7E65A
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 19:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1030D86BE7;
	Tue, 26 Sep 2023 21:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="MmR3gsKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3885A86BE2; Tue, 26 Sep 2023 21:29:16 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0EA186BF5
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 21:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=waldekranz.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tobias@waldekranz.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50337b43ee6so15893519e87.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1695756553; x=1696361353;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QMiQ9FGKp7IhTVx4kSa6Boo4qcUXLFwS3Kn18s383zY=;
 b=MmR3gsKtoVm48FF6QSPl6CiogPULz060cRRDU4euQb4QFfOx9mHpwAxHavj2nmUhSR
 F9CP+qrkmRonsuDdQFrxEGewc/tQWXT3IEbrLu01orOJH2oe8UCwSYqV3r9WcKMq9aWK
 ri6lA6i0xjsJglNKdQusHSP6Kl94N3r/HPUKT8dkNtHQsFvUvGcwx7pyH9QwgIvQzrtN
 cWeFvhJWwZEyamIaIl+3VelF4VbpynL+KIfC/SFl0jgua/Fwrhxy1Wsk/Jbe9Tmz4yuo
 MN5rS/8HAU20cQABhOxVmMY4WHRaeaZ9pOjPUYxFHatfl+fzU+UwpbIj1jezec5DtnZu
 bC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695756553; x=1696361353;
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QMiQ9FGKp7IhTVx4kSa6Boo4qcUXLFwS3Kn18s383zY=;
 b=Pr16VNAp/TL5yZQbleAqcD5roSSIhgr3YLHhoXOaz8NPH+SHwQWVspVkrJu8KjMkXl
 cAbxvqhxAzBiYIDdp5m8NojOsTDtvfX6e2xO2u62KEhImv59gPbq06Ql2QsPzAXbgMsu
 WlDn9cxmtCPZUUQ27g0OSzrIQiKMM/6WL7xUUwncFzEbhTuU9WFHyQ578IbzpaVqqnY5
 JthL6dd47oHlTj+RROIGElhtol8bYfRBZkFRYYCLla4iySel6VD2okZKZSnBjApL0tAu
 czUR76a3INRoNKfqDkSpFdKhSuhSDTBgxfSCFUv0b80pN/ve7PSnXmTlV492a7Ra8BYi
 Uk6w==
X-Gm-Message-State: AOJu0YxSUJVGuVSt8YPanrZLl5s9eF3CjdkKcJHT4bdAhO+0EzCqhx5l
 BTIaiQLrb1a9MyemwQvBxh5B2qpBVj6cIN3jSbzh6g==
X-Google-Smtp-Source: AGHT+IG4kphBaNCdUiBhLP7Q36j5EI1gDBOfAzi1X40PXBxOWhVAycd2RrVw8/+0LNMItjTKJ5zdug==
X-Received: by 2002:a19:654b:0:b0:4e0:a426:6ddc with SMTP id
 c11-20020a19654b000000b004e0a4266ddcmr8324086lfj.0.1695756552531; 
 Tue, 26 Sep 2023 12:29:12 -0700 (PDT)
Received: from wkz-x13 (h-176-10-137-178.NA.cust.bahnhof.se. [176.10.137.178])
 by smtp.gmail.com with ESMTPSA id
 x24-20020a19f618000000b004fdb85646f1sm2297087lfe.201.2023.09.26.12.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 12:29:11 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Bin Meng <bmeng@tinylab.org>, Simon Glass <sjg@chromium.org>, U-Boot
 Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 09/15] blk: blkmap: Support mapping to device of any
 block size
In-Reply-To: <20230926084346.2237483-10-bmeng@tinylab.org>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-10-bmeng@tinylab.org>
Date: Tue, 26 Sep 2023 21:29:10 +0200
Message-ID: <875y3wohrt.fsf@waldekranz.com>
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

On tis, sep 26, 2023 at 16:43, Bin Meng <bmeng@tinylab.org> wrote:
> At present if a device to map has a block size other than 512,
> the blkmap map process just fails. There is no reason why we
> can't just use the block size of the mapped device.

Won't this be very confusing to the user?

The blkmap device uses a fixed block size of 512:

https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/block/blkmap.c?ref_type=heads#L393

So if I map a slice of a 4k device into a blkmap, then

    blkmap read 0x80000000 0 1

would copy 4k instead of 512 bytes from the lower device to 0x80000000,
even though the blkmap reports a block size of 512.

It seems to me that the expected behavior would be that only the first
512 bytes would be copied in the command above.

>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  drivers/block/blkmap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> index f6acfa8927..149a4cac3e 100644
> --- a/drivers/block/blkmap.c
> +++ b/drivers/block/blkmap.c
> @@ -171,11 +171,11 @@ int blkmap_map_linear(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>  
>  	bd = dev_get_uclass_plat(bm->blk);
>  	lbd = dev_get_uclass_plat(lblk);
> -	if (lbd->blksz != bd->blksz)
> -		/* We could support block size translation, but we
> -		 * don't yet.
> -		 */

Hence this comment ^

> -		return -EINVAL;
> +	if (lbd->blksz != bd->blksz) {
> +		/* update to match the mapped device */
> +		bd->blksz = lbd->blksz;
> +		bd->log2blksz = LOG2(bd->blksz);
> +	}
>  
>  	linear = malloc(sizeof(*linear));
>  	if (!linear)
> -- 
> 2.25.1
