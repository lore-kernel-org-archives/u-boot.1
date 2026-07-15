Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B114C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 18:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA3584D15;
	Wed, 15 Jul 2026 20:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZsEHD2yL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E8BB84D15; Wed, 15 Jul 2026 20:42:35 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B03E84CC7
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 20:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69c19a37eeaso11410975a12.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140953; cv=none;
 d=google.com; s=arc-20260327;
 b=LmMRiCj2AIIlOP2YrS/9lOEL/hn+Kw9JQmusf4pCAUHuEWu35EMOpNIWNOnIZwkRAA
 UY4pBQ9EwyVbIgO4xEH0DOF94mwDjPAxXRoRBanF6wvU8jEXoHpDyJmPAc4dEoduW+JJ
 JHkD9h6EGu1NUDKQTiAQ2hxNDRM4Jn0S67fGvrlYXLeZrfF7j1TsIlpdTgX4e4qaPnkp
 IyvQ3tP20rxqUGoS8S4zvzib2cjhLSFXdJzU7gKpCIvW+G/ItL1pTmzazAxwQdtUipaL
 Ntmy+jcjG3QBvG9LtfepOlNbh/0oHv6MlxyNBnTbD32e0G4YHtSDhP2i6LUjeQ4IQ1D6
 K5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N6AzHWmwng2DJixAFlD82f9+GytrGhRLNIxMBVBB8iI=;
 fh=0W6kIyhADvhmhvhVQsZSTzGwPkofJTZJtlEtaI8GADM=;
 b=PmkZ1+QMEyx7+8bH1y1yKQcNlNbhEXs0cXv+zsK52PPJZjX3Nc9D6L5QhNaXY4qso5
 qtvy0cOWFi9Bkxys2IfyLUy2ll2stkhxmY41TXxWqxlVQUz8t2ZKwGJB4U/T6OFHND5B
 Yp1M7xCKHXdeKpiI1ckzxSmCQ/nDjaoPkmUsre6M8a6O/YDdmW1YyC9hWUNpe6zXtJSC
 Keb10n6tS/Q3cDhRfgAuF4EaqTEINUqzQvtE7u5zMVayezDd0e17aXk2nGw8ITP6frkp
 4nCjq4zq4glRft2QYqpzXK+7WteqQZYSMXQa9/5l1UtSsVt67SPTdDCUEK9rHyKPDVak
 wttg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784140953; x=1784745753; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N6AzHWmwng2DJixAFlD82f9+GytrGhRLNIxMBVBB8iI=;
 b=ZsEHD2yL/IQ90UIPkfMGI8I9kf2Ra0kcY6cvIoL3C1iW+8klMrrXesZHbHAXkuGKQk
 urlhcGk7dgwXJXuvDER0E7wPit1J3L8yLTpB+7YRu1BNoHoSnHWu9/9bxjgX8SycUzWA
 UGB2Udbsj6Iby5sukF3aA5zGV3+2xC+F45rW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784140953; x=1784745753;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N6AzHWmwng2DJixAFlD82f9+GytrGhRLNIxMBVBB8iI=;
 b=Rb+jbWbNnA6v4hNwiqx4E6oU37i/iyNXjZmtIU0R/131FJbcAKlYEw7sTqO0Dv1Poa
 IDy8Tq5QClBGENSCd/WUz7NwSVAK/lymXW8dEs1kcM9hqK5UNiLk/XgrD/Qw1fA5MEav
 WGK71CKKHvwKxZMtxDOjpcbQD5/j3sZdMUj5uvWrnny3d8Eb/WezA7vdm7v+FfBteC0Z
 rXSwcDVeQ8OkGXB3rJJa8QYMdtiWf/CK1gkXV9wWsN60vzslZfxDx6lOmW3576WBJQpI
 lAN4ZnRsLTliuSA5ZegsG062IEi8xagA9LXvlvBZ8F5q6M/LrcbYE6GxaD6fH5clmEZB
 /HFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpcUzmHqVHbjdotOGpHnqkk4MPfGSPjrBgULtyYtdkZb/UJKWyuQXNpbPGCGzvE0TTSVJ1xXno=@lists.denx.de
X-Gm-Message-State: AOJu0YxksA990cY3cWt4zRYYN88vqIqRdpcFhV/gp05zy4eRM0Z+KEj/
 SIvP0Sji/EloJMPhp9qy8e9GLnOTDAG1kILrsiOwr8x4Rl9NR9id3YjFypikwIYD4E255Schnr0
 InbYzIdWzs4NFsObkGDceMZG5GIMX8wciGknbaGvt
X-Gm-Gg: AfdE7cmcCjdB2mh+WkC7QsPQt5jtdB7oNDI9uFHiwPl2Ns+X6QgpMpqFOIZOKTt5lUr
 XHhpvLg1aUQeN8PRpl1EZ/zDEd78D90wGIwsp40WqcVNMkgFSf7D06icwmj0dan7V2nOiLBSQyz
 0/lS39LOkZcqcBey3scCyl8Z+ieHuJRBO/SoICGB7U9i/6BqHrHjenHp7IjZ3xtGS2/nvn1WVGT
 FNjvFiWtr7jQOoe6aDzs6NZIhObdcvQWwxmwhH/ZhxhOp3nCHCPfea2A6kjeBAbgqQ/VpY=
X-Received: by 2002:a05:6402:3216:b0:698:ecf:d18a with SMTP id
 4fb4d7f45d1cf-69cd29f19c5mr5492271a12.9.1784140953110; Wed, 15 Jul 2026
 11:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260706215446.4068820-1-visitorckw@gmail.com>
 <20260706215446.4068820-4-visitorckw@gmail.com>
In-Reply-To: <20260706215446.4068820-4-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jul 2026 12:42:18 -0600
X-Gm-Features: AUfX_myhdriER5O97aNHF-WnxIH7x81eCCfmDBIAaRmgPkMUSvgh2NlnxjF5gck
Message-ID: <CAFLszThVifkWtdM7y_5YjQZMcra-gg=5G9xfWEceOzWonkuxmA@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio: 9p: Add 9P transport driver
To: visitorckw@gmail.com
Cc: trini@konsulko.com, bmeng.cn@gmail.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.denx.de
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

Hi Kuan-Wei,

On 2026-07-06T21:54:42, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> virtio: 9p: Add 9P transport driver
>
> Add virtio transport driver for the 9P filesystem.
>
> This driver binds to the virtio-9p device exposed by the hypervisor and
> registers the transport operations with the 9P client framework. It
> implements the transmit and receive routines.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> drivers/virtio/Kconfig         |  7 ++++
>  drivers/virtio/Makefile        |  1 +
>  drivers/virtio/virtio-uclass.c |  1 +
>  drivers/virtio/virtio_9p.c     | 75 ++++++++++++++++++++++++++++++++++++++++++
>  include/virtio.h               |  4 ++-
>  5 files changed, 87 insertions(+), 1 deletion(-)

> diff --git a/drivers/virtio/virtio_9p.c b/drivers/virtio/virtio_9p.c
> @@ -0,0 +1,75 @@
> +     flush_dcache_range((ulong)tx, ALIGN((ulong)tx + tx_len, ARCH_DMA_MINALIGN));
> +     flush_dcache_range((ulong)rx, ALIGN((ulong)rx + rx_len, ARCH_DMA_MINALIGN));

Just to check, why are these needed? No other virtio driver (nor
virtio_ring.c itself) does any cache maintenance, so on a non-coherent
system the vring descriptors would still be stale and flushing the
data buffers alone would not help. If virtio on QEMU is effectively
coherent, these are dead code and should be dropped; if you have hit a
real cache problem, it needs fixing in virtio_ring.c for all drivers
rather than here. What do you think?

> diff --git a/drivers/virtio/virtio_9p.c b/drivers/virtio/virtio_9p.c
> @@ -0,0 +1,75 @@
> +     if (virtqueue_add(priv->vq, sgs, 1, 1))
> +             return -EIO;
> +
> +     virtqueue_kick(priv->vq);
> +
> +     while (!virtqueue_get_buf(priv->vq, &len))
> +             ;

Please can you propagate the error code from virtqueue_add() rather
than replacing it with -EIO

Also, this loop spins forever if the device never responds, hanging
U-Boot with no way out. I realise virtio_rng does the same, but a
filesystem request is a good deal larger, so please add a timeout
(e.g. using get_timer()) and return -ETIMEDOUT

BTW 'len' is the number of bytes the device actually wrote, but it is
discarded here. It would be worth passing it back to the client so it
can validate the size field in the reply header against what was
really received.

> diff --git a/drivers/virtio/virtio_9p.c b/drivers/virtio/virtio_9p.c
> @@ -0,0 +1,75 @@
> +     priv->client.ops = &virtio_9p_ops;
> +     priv->client.priv = priv;
> +     p9_register_client(&priv->client);

Since you are adding a new virtio driver you may need a bind() method
which calls virtio_driver_features_init(), as virtio_net, virtio_blk
and virtio_rng all do. That would also let you negotiate
VIRTIO_9P_MOUNT_TAG and read the mount tag from the config space,
which is needed for the device selection mentioned in my reply to the
cover letter. It would be good to at least log the tag now, so that
selection can be added later.

> diff --git a/drivers/virtio/virtio_9p.c b/drivers/virtio/virtio_9p.c
> @@ -0,0 +1,75 @@
> +U_BOOT_DRIVER(virtio_9p) = {
> +     .name       = VIRTIO_9P_DRV_NAME,
> +     .id         = UCLASS_MISC,
> +     .probe      = virtio_9p_probe,
> +     .priv_auto  = sizeof(struct virtio_9p_priv),
> +};

This is missing .remove = virtio_reset and
.flags = DM_FLAG_ACTIVE_DMA, which the other virtio drivers have.
Without them the device is left with DMA active when U-Boot boots an
OS. The remove path also needs to unregister the client: priv is freed
on removal, so the pointer held by p9_register_client() in patch 1
would be left dangling and a later 'ls 9p - /' would use freed memory.

Regards,
Simon
