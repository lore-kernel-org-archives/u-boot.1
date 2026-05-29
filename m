Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2BCCD6E45
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 09:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC6B846B4;
	Fri, 29 May 2026 11:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E6hJUIe0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24E8F846CA; Fri, 29 May 2026 11:57:24 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E708844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 11:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bda62f13d90so1503472966b.2
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 02:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780048642; cv=none;
 d=google.com; s=arc-20240605;
 b=DpuKNnRLkfP3NdgJs2sl0SaBNaIKRIQZcTbWlc+MQ8mlPw99a/LyOu2hMhDOw3wWdb
 0Ca+HBWKvCbKbLlQWJ2/R+/CFsQQlR/Cc+TGH6OqSq3263JWnIy8QiSQRSyrU2PFV8ZE
 1wzTtNDxIkZjVN8IE7K7i3WqwzRNv9nj/D5Q8O1+nnztdhAhatqWBqZ0DeYV2X0DGQKq
 W7L2IYbicWvmtTlwniYU26zwTD23j7aDXktA+Nn7sQdiTmdBQTS3hLusnaf1II7wrr8w
 Rm4Qc79UgbaapRb4gp6YbxSTjeWyVY2PhYrLZO7F6hpmMzHLcAMIMYJuEoxrIY9fqboS
 YfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VHal5vxJvV/NBy40FrDuBvby7ZV6l6y582OnCn9W0jI=;
 fh=Pwed0uR+fUcTESmvhLrbsa6n1RHCX2s8IPfo/JJetiI=;
 b=UCyxPtNWL0lrEcmN8BMMbUnK5oWy3QMJHyDdhhltEpLnZsoXVoXKlYvirIXc/Tw0Tm
 2ZZn2QCTlkhdoUOKJQu/dRp9wCQTy64l5dwQx29V0XfhDkR1p/Yk8lj8/N7stFCEdrBl
 PCkZP9U6e99N9vsnne0RNMLel5T8ciaxovj2Ic1JBcAc/0bmymccglyiW/U/+2Wansi2
 XcF4kd1SDTNig7kulDSzlWRLASzNlZliFel1KddnZSqgryCk8zxlCEf+PkRc6zcnS18Z
 ewYayRlcAk535n5OlvKLsFojDUf3fmuj/yPaJy00YIiVe3upbHJIPwAzpuxc8G9x0BSi
 8mUA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780048642; x=1780653442; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VHal5vxJvV/NBy40FrDuBvby7ZV6l6y582OnCn9W0jI=;
 b=E6hJUIe07p1lkrTydRn2mEj5dWIf9WmH7lS32A4wyvjy9L3U7BvsHw15VfNwqEMzpI
 aMn46YyyV3k8QCMuymK81+7L1wsvjdUIptcW5XDbzs1IHQh89+My4wvcdXKrNLgzjiY6
 DZKLDb+tfsz8WlfmgySwje5P2p+oMv1QO5MqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780048642; x=1780653442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHal5vxJvV/NBy40FrDuBvby7ZV6l6y582OnCn9W0jI=;
 b=JQY3t3l3pqjaNdzyh9SNt9yLyFDSUJfsLHuZEEOJh4f0Dk6SCwk/GYTKBIFiUv6VNQ
 InE0zRq7/QUrvSdFSYDvOQvKBj5ffQrwQ/7C6bJrXFKBQq6EkzScmyQJoVCtdfjS0Kbw
 aIGRhZIKM95+7ujqsIKFgS9ByCeG4DXuDdxwZ4r2acwZOdu9XELG7NwCqQUfyZD/TVKK
 sU/f1nNn8wpTWZgN+TnkGLbHq8/BMZ4yeAy7TL8OuKWn0JZfYfA3Q8rL1B1I/0/8pbBN
 JDtavDito6mtyMpu926jOWjgAUnPzPioyFFLya0t1WME0alW4M1LQ0k2/6M5MJyYidfe
 OnlA==
X-Gm-Message-State: AOJu0YwMY6Vlhz85ZRTi3TR4vysrStXO1ZmEb0Jdl3uZMk6Rh5zcIl4o
 mT86fjRncbFAyu1wKMj9YrqASbrMfjbAnnZJKBpWiyCc0bMucedHJp+92wahV0+cOZpKJiBrD4r
 Cta7zpGwgvyBFBYGd9n+aW74JxESTuUgjX09zfh/G
X-Gm-Gg: Acq92OEqziYqvGXCqcMjZbUxTMJ0WEtM89XgT978Eg9rRA7klGs9f2jnn3rFbBy8UHc
 cZiSrkPPuE4ujVW+e6+6OJSiHF2NEdCIpfF3FxiyL5ktFuUwy3SJmHW+FAu4lHOBcJrZ7PWDN5q
 AYNFpnejwcsnN9U8OLNQr7P+fYGQooS1AW/T/gfUpoMXG1hf5j9X/8oASdf6xIsYEKuY17ND0+9
 firpnddgmnGvtu6vVdcXuHOIPGWT2uP8MdAYrV6pnMpFjWuwAAACGdeur9f4aoK4ZAyo3LqkeAt
 FgE9beVBHtlRsBTjVDc=
X-Received: by 2002:a17:907:ab9:b0:bac:3bb7:268b with SMTP id
 a640c23a62f3a-be9cb6e2a29mr98283766b.38.1780048641621; Fri, 29 May 2026
 02:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034441.2075305-1-dmukhin@ford.com>
 <20260529034441.2075305-3-dmukhin@ford.com>
In-Reply-To: <20260529034441.2075305-3-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 04:57:06 -0500
X-Gm-Features: AVHnY4I9DiIKKYWL1j1wIb6GZrY1pChWh48SpvoZ8PaZNrWMyubL3vE4HxSZZp0
Message-ID: <CAFLszTgz6ia9qgkSq=2=JT+csdo=9O8KpjJeYi1=CS2n_yua4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] drivers: block: Introduce blk_flush()/blk_dflush()
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, sjg@chromium.org, 
 trini@konsulko.com
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

uHi Denis,

On 2026-05-29T03:44:35, None <dmukhin@ford.com> wrote:
> drivers: block: Introduce blk_flush()/blk_dflush()
>
> Add generic flush operations for committing dirty data to the storage
> device.
>
> This provides a common block-layer interface for flushing pending
> writes, allowing callers to ensure that data buffered by the block
> device or its backing implementation is written out to the underlying
> storage.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> disk/disk-uclass.c         |  6 ++++++
>  drivers/block/blk-uclass.c | 18 ++++++++++++++++++
>  include/blk.h              | 28 ++++++++++++++++++++++++++++
>  include/part.h             |  8 ++++++++
>  4 files changed, 60 insertions(+)

> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> @@ -514,6 +514,19 @@ long blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt)
> +long blk_flush(struct udevice *dev)
> +{
> +     struct blk_desc *desc = dev_get_uclass_plat(dev);
> +     const struct blk_ops *ops = blk_get_ops(dev);
> +
> +     if (!ops->flush)
> +             return -ENOSYS;
> +
> +     blkcache_invalidate(desc->uclass_id, desc->devnum);
> +
> +     return ops->flush(dev);
> +}

Why invalidate the read cache here? Flush pushes dirty data down to
the media; it doesn't change what a subsequent read returns, so the
cached contents are still valid. Erase/write mutate device state, but
flush does not. Please drop the blkcache_invalidate() call (and the
matching one in the non-DM inline below).

> diff --git a/include/blk.h b/include/blk.h
> @@ -99,6 +99,7 @@ struct blk_desc {
>       unsigned long   (*block_erase)(struct blk_desc *block_dev,
>                                      lbaint_t start,
>                                      lbaint_t blkcnt);
> +     unsigned long   (*block_flush)(struct blk_desc *block_dev);

This field lives in the !CONFIG_BLK (legacy) branch, but no legacy
driver in the series wires it up. The only consumer (NVMe) is DM-only.
Are you going to need the legacy plumbing?

> diff --git a/include/blk.h b/include/blk.h
> @@ -275,6 +276,14 @@ struct blk_ops {
> +     /**
> +      * flush() -  commit all dirty data to storage
> +      *
> +      * @dev:        Device to flush
> +      * @return 0 if OK, -ve on error
> +      */
> +     unsigned long (*flush)(struct udevice *dev);
>  };

Two small things: stray double space after the dash (flush() -
commit), and please place this next to .erase so the
read/write/erase/flush group is together.

> diff --git a/include/part.h b/include/part.h
> @@ -454,6 +454,14 @@ ulong disk_blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
> +/**
> + * disk_blk_flush() - commit data to a disk
> + *
> + * @dev:     Device to flush
> + * Return:   0 success, or -ve error number (see the IS_ERR_VALUE() macro
> + */
> +ulong disk_blk_flush(struct udevice *dev);

Missing closing parenthesis after IS_ERR_VALUE() macro.

> diff --git a/disk/disk-uclass.c b/disk/disk-uclass.c
> @@ -122,6 +122,11 @@ unsigned long disk_blk_erase(struct udevice *dev, lbaint_t start,
> +unsigned long disk_blk_flush(struct udevice *dev)
> +{
> +     return blk_flush(dev_get_parent(dev));
> +}

Please note in the commit message that flushing a partition flushes
the entire underlying device (the API has no start/blkcnt), so callers
don't expect partition-scoped semantics.

Regards,
Simon
