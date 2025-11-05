Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526B6CCFA05
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 12:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BFEE83A1B;
	Wed,  5 Nov 2025 13:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="f1p5HODQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7A383A24; Wed,  5 Nov 2025 13:12:51 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB6DC839FA
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 13:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 08D9F3F520
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 12:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762344769;
 bh=o5UXDepVUGGCqwL572X8uGREuc/n4DBkQsW0WuwYTpE=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=f1p5HODQ8hi/nLZ2/a8PGJYBNDIEcpE0bvs+tN/kwFWTZwQRaLE3edAJBvWEXxPQm
 MQQY8eLJXNhs2Gx+OHSArxBFZCKql9u9jZS8KmWy9YDc3fF+gMY7ZYMUm2jOpTi3u0
 2pu2zpxMoViP3H3VNKxqvhgThqOiSYJatbDTDZsvJxnTeNl93pK15K/e5CRLhXfeoD
 sqN0VdSZ9R27E20FkJABSjpTRqsmIJdTI6G3q1Lm5M3Lxfj16iMqmHLHYRrpN0HZYt
 kQOAZF3YRq3oRcmV//Udkbmn/FE6O8Gq/VlggNh3reQ0d1jGy20HLoWrpqEr0pj4Yh
 qwd0bdzJFg3qTAt571uyN/vMmTBZXYGgSKCJXgeo/ZHh+NG8qBVqcAW/svsbJ6c/Qv
 zY/Z24s9tFlE9CfPHkX6AVHwtFRPWzEZgjTUOA46VDrCqmN7iWFSstn9uGJIrTB/Cr
 fRaG4aftTvlzRlLLGonDRRYvksnIl7qgZyPCQLAE0P/3ir8SMcFcewTSiREMGGsBVh
 W80OwubFX+na7x4ceNgKzHOxIsJWZJyFotXoGQAxiaq2X5+arQfGdNwYby+ayOZfj0
 B5R3hH/JnWz0IjLAR7y+TcDN9AOwXVVfnXf6yDK/4A7EHez0D9gxH1KLUokwo102Ua
 fu1eXiDwaehnHLTaFVW38/tA=
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-378d61ceb31so34601061fa.2
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 04:12:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762344768; x=1762949568;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o5UXDepVUGGCqwL572X8uGREuc/n4DBkQsW0WuwYTpE=;
 b=McMcoi+4T9DefrcD4OUxjkF7AcnActGDD70w3eYefw0zKoq7mDgyQkAups3hnRauDl
 siGkjHT/Uj6HIeDX5emJ06MGOAcUe6TniqAxdE3jy52KnTM03rR5oqm+8k01WWXUR27z
 Y67jIJNc33fw54Zsvn1Uv16hpCaoDkmAy2NBzcCFvHIYDDhMCEjZgfLX81yP5k9G3rwT
 vJAkJSumYbX7pp0sAZSA1Ky64ICBzqCFy4r3GD0bkYc8JsPoDiEnLiV//THfpmwkUlyc
 rc96omWf+GaiOq5rgIpefa2lpX3EXja/nXHuJ4wVqmuYfm8AZ4+jDdrD2rYXQOgyMuKw
 XZBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjufmUGlmMCK8rdRWPJ6p0z2CQ1I7tb/dZNFAdlTqV/TWPQj/s87fThyaHt787H0fRhGVbIcs=@lists.denx.de
X-Gm-Message-State: AOJu0YwOg5YG6bGJFcDqWYdZ4ybRu8nwkSKVrXidfXPebNpoTvz/9tdT
 4utYuAe4jDIkRO7Dr8KFvOsBiuihOIjZIc0+Ad8+JqvJIK//hrPXWgHrMd7s7N0M1vd2fQ8ijiQ
 9XU6J+rKeBxokeiUsc5ICHS9U/IBV8SlRYVrQsC7+86IU7baqeqh2jFKH8sJeNYxk+h1HltM=
X-Gm-Gg: ASbGncuEjtVnopLa5Rj0TjxUPvRPBnDKROXE8umkaRE/gXt3mUthJFmd/9W928+bbN2
 ebwQsqvbGB2g/OPtQiMNi3+i0hl1ZAQMAcRM8A4YoYRYzKP/O/ErVNKAVrFNueaxcehi5zo+wN4
 T409ffapdXtHNLQmW3zXKi3Ffzg+VmNEZicqiyEg0+qPHuqMjqgzgeegUdJ1kavMhTsIuntdq3l
 InYw7W4ekzeNrQ5VmtFygUlkNOJYMj7YzgPX9sTfk/zp7f/KKu87X7bcP2GvWQK2IPv0Fn6Y1mj
 vVtEcVI1VQhW3Lk32ZtmZHsfH5fZ/pRiNsEZ+WK/ClCYtfEqi3gV2y6y+6fcBSC0xKwXDvhikst
 AVHuHp+gX0kJClJnjReAJrKT/dpILPn3Q884+TpLA9GVt
X-Received: by 2002:a05:6512:b11:b0:593:f74:90c8 with SMTP id
 2adb3069b0e04-5943d7d147cmr944686e87.35.1762344768241; 
 Wed, 05 Nov 2025 04:12:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl4oKssWLNTo32XmitJ065xa/BjRPl9/jIvZucixf9liDCc7T7PV4O3EdxHAFCewfFjaR9RA==
X-Received: by 2002:a05:6512:b11:b0:593:f74:90c8 with SMTP id
 2adb3069b0e04-5943d7d147cmr944672e87.35.1762344767663; 
 Wed, 05 Nov 2025 04:12:47 -0800 (PST)
Received: from [172.26.194.12] ([93.94.208.154])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5943437f058sm1716777e87.6.2025.11.05.04.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 04:12:46 -0800 (PST)
Message-ID: <efb61fb9-2d13-4dc7-a006-68acb5d4dc81@canonical.com>
Date: Wed, 5 Nov 2025 13:12:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: Fix the name string memory leak during scsi scan
To: Bin Meng <bmeng.cn@gmail.com>
References: <20251105110724.634741-1-bmeng.cn@gmail.com>
Content-Language: en-US
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251105110724.634741-1-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/5/25 12:07, Bin Meng wrote:
> There is a memory leak during the scsi scan process due to the
> strdup'ed name string is never freed. Actually it is unnecessary
> to pass a strdup'ed name string to blk_create_devicef() as we can
> use the name string on the stack directly.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
> 
>   drivers/scsi/scsi.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 05608399be1..b414d022f3f 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -584,7 +584,7 @@ static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool verbose)
>   	struct udevice *bdev;
>   	struct blk_desc bd;
>   	struct blk_desc *bdesc;
> -	char str[10], *name;
> +	char str[10];
>   
>   	/*
>   	 * detect the scsi driver to get information about its geometry (block
> @@ -600,10 +600,7 @@ static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool verbose)
>   	* block devices created
>   	*/
>   	snprintf(str, sizeof(str), "id%dlun%d", id, lun);
> -	name = strdup(str);
> -	if (!name)
> -		return log_msg_ret("nam", -ENOMEM);
> -	ret = blk_create_devicef(dev, "scsi_blk", name, UCLASS_SCSI, -1,
> +	ret = blk_create_devicef(dev, "scsi_blk", str, UCLASS_SCSI, -1,

name is only used in a print statement and not passed on:

    snprintf(dev_name, sizeof(dev_name), "%s.%s", parent->name, name);

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>


>   				 bd.blksz, bd.lba, &bdev);
>   	if (ret) {
>   		debug("Can't create device\n");

