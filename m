Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AEDE937E6
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 21:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29E62839D5;
	Sun, 12 Apr 2026 23:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZT1DuA1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98DCE83B99; Sun, 12 Apr 2026 23:34:42 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 484CA80077
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 23:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2aae4816912so25087625ad.2
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776029679; x=1776634479; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WBsG5W3S/FeZBb2k6xNUHGcbyCkAkyzQFqQ2ocMVLKk=;
 b=ZT1DuA1N+ReOkVnl0RiX1Fw9EW5zfiJqUOoZrVy6tkvVrlyIetZy2EKOjbQ4OSfc++
 CqD4i1GVDdYYciDTMH/tjHzIHmpNDT28yAtFiwYVLx0n5nVd77deJEUjzjFLDVjOXI+g
 oHwRv+tiYVWWsiPLaDRG+DrWOjtjetqwndyTNS6r9T5mZ29vkcuAHpaa73AGilNEUMrj
 hUwhSbrVdv7OlNJH4Zh00ugItavws+f6kg/z0MyuAMwr9RXcEbrh1+fLC9cyKsiHuGj9
 LWUa7qYku93f8xb28FbS9N9yD4cJtDFOIxfi1BWQ3NTD0dnR/C/ZFXUC5jHtVLwi3ue4
 nwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776029679; x=1776634479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBsG5W3S/FeZBb2k6xNUHGcbyCkAkyzQFqQ2ocMVLKk=;
 b=sj5zYk8P38JjihOGOZG3osjNeHRyO3cdlWubHvcl4Z/XmFeOj5q6T2oMvdQw8WAaeK
 Q/zHZhwVCjANUrhCMtvo1c4t2q0mU1CZ7vl8/Clvo8DC5a9PuM/ZnHAaseuISSGiNwdW
 tDMNN2DtkN6xlzEmuCu/9LlGhOD43rWX7wktkbxpngeAg8ruxFBclM6LOz+fKxcanx3R
 Ftu8ho5fTLgUXs+lyIDM0ItFPrcfOVPP3Gc8ESNZ9a2Mh8KSYIMv+1lznGiJfboMCNLc
 RtrjK69zKAjv6eFLFs4ygvnQi2Gn1GZqD85oATqhX1qfy+FXgCjcOIpt87x46K7ozgnW
 j3hQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ryl8LhfGVhOPQ8piZL82G4Jqsmu9BrBh9HXRDTGcr1lnIdXa7wH54bnLZqLSDfHyeanBESVk=@lists.denx.de
X-Gm-Message-State: AOJu0YxP4LIdotPsDuNZSwI3PAyatFQfFO2fx02JQoDig/soJXcFmwQU
 OZhDa1pdZRVTaA+MftB2s9yFct5dp32IOaLgq57La4/x1/vWAPaZg6Mz
X-Gm-Gg: AeBDiet/tfMyZHwzhfjUSzskb3gPqfoY33AyadU26vbR7jtAxVh+Es/MXZ43LLiKz4I
 +Ap50Xb83BPiDUBJwywWCeqLCgCps6aYBN2Q/Q62xdGnmmGknBPbZ979s7oGoWxkoHblPW+Ao6J
 yEkA6o3LfcNC/ERSRZwZToJTv1oFa0+di7bZeansiq3EOlWcR0hpUpkvQmfJESrGS1szGq35jUJ
 PnqKJPB+afnIJYCljIuVm2JwP5+FGzsB6vosCKb4JHChYkKe+6t9ZAWgEOWEb/xcHx32pi7qXKW
 DvOefWRanR8UHldgga1mdJgR9tevvhxwwSQ48AWjh9FbgHEj0aUFYL9BJ2GS7pt5ivO6eICt4bX
 YeFccgUfZCpqx8BNKC8n9N0K/ZZv9VaUJGnhfiZKMxFFk3vwScv+PnkZualLqSfx+ujUCPfarKK
 ExyhVkPdWNXT0yqBgtUU3ham7cZO7/j1y8kkY=
X-Received: by 2002:a17:903:2285:b0:2b0:b1e7:8841 with SMTP id
 d9443c01a7336-2b2d5a49b1emr112880415ad.32.1776029678548; 
 Sun, 12 Apr 2026 14:34:38 -0700 (PDT)
Received: from google.com ([2402:7500:477:c367:3a21:b5ec:1429:fbe])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d843c5c2sm86024805ad.12.2026.04.12.14.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 14:34:37 -0700 (PDT)
Date: Mon, 13 Apr 2026 05:34:34 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 4/5] virtio: blk: Fix converting the vendor id to a
 string
Message-ID: <adwP6m1zDjUQWAl0@google.com>
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-5-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408220928.3328551-5-daniel@thingy.jp>
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

Hi Daniel,

On Thu, Apr 09, 2026 at 07:09:27AM +0900, Daniel Palmer wrote:
> Currently we are trying to work out if the vendor id is from
> a virtio-mmio device and then casting a u32 to a char* and using
> it as a C-string. By chance there is usually a zero after the u32
> and it works.
> 
> Since the vendor id we are trying to convert to a string is QEMU's
> just define a value for the QEMU vendor id, check if the vendor
> id matches and then use a predefined string for "QEMU".
> 
> I don't think we should have been assumming all virtio-mmio vendor
> ids are printable ASCII chars in the first place so do this special
> casing just for QEMU. If the vendor id isn't QEMU print the hex
> value of it.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
>  drivers/virtio/virtio_blk.c | 12 +++++-------
>  include/virtio_mmio.h       |  2 ++
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
> index 3dd0cf36268b..d876c40deb05 100644
> --- a/drivers/virtio/virtio_blk.c
> +++ b/drivers/virtio/virtio_blk.c
> @@ -11,6 +11,7 @@
>  #include <part.h>
>  #include <virtio_types.h>
>  #include <virtio.h>
> +#include <virtio_mmio.h>
>  #include <virtio_ring.h>
>  #include <linux/log2.h>
>  #include "virtio_blk.h"
> @@ -164,14 +165,11 @@ static int virtio_blk_bind(struct udevice *dev)
>  		return devnum;
>  	desc->devnum = devnum;
>  	desc->part_type = PART_TYPE_UNKNOWN;
> -	/*
> -	 * virtio mmio transport supplies string identification for us,
> -	 * while pci trnasport uses a 2-byte subvendor value.
> -	 */
> -	if (uc_priv->vendor >> 16)
> -		sprintf(desc->vendor, "%s", (char *)&uc_priv->vendor);
> +
> +	if (uc_priv->vendor == VIRTIO_MMIO_VENDOR_QEMU)
> +		strcpy(desc->vendor, "QEMU");

Is there a chance that other non qemu virtio-mmio devices also use a
4 character string for their vendor ID? If so, this patch will regress
their output from a human-readable string to a raw hex value.

Regards,
Kuan-Wei

>  	else
> -		sprintf(desc->vendor, "%04x", uc_priv->vendor);
> +		sprintf(desc->vendor, "%08x", uc_priv->vendor);
>  	desc->bdev = dev;
>  
>  	/* Indicate what driver features we support */
> diff --git a/include/virtio_mmio.h b/include/virtio_mmio.h
> index 8c072826db55..cc59bc516c2c 100644
> --- a/include/virtio_mmio.h
> +++ b/include/virtio_mmio.h
> @@ -5,6 +5,8 @@
>  
>  #include <linux/types.h>
>  
> +#define VIRTIO_MMIO_VENDOR_QEMU	0x554d4551
> +
>  struct virtio_mmio_plat {
>  	phys_addr_t base;
>  };
> -- 
> 2.51.0
> 
