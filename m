Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88284F8A14D
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2180841C2;
	Thu, 16 Apr 2026 11:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VfTaKTFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8114B841D5; Thu, 16 Apr 2026 11:26:24 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B208407E
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82ce2e2880cso4987285b3a.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776331581; x=1776936381; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f7AtUkx0VyPnS/7wTUN1du3bU0kK4Kvdvu2eWwHOZlc=;
 b=VfTaKTFW8NMs239pF1XYAtbXQkTO3dqkWoUjmUcu3d27XSxxGImGiZp/pUkjvHY2Gm
 l8SeS2o3F4YurHR8UhLuirzVVV73rSc1l5p5Ha4Wz/VFE90+Dp2MekbfuOJgv8MXMFiB
 kRGt5pJukiRaOQf69pooTG8qT78P9V2qWEWFvu9xpDDAK0qyRkTFoeszyIchaEViVkle
 D4KcQey5RIXlRN1PYu2NE0D0+JqiCiNwCdNqpcjwcc0AdQSnsCvirZ/pNrn8Q8eWUm5A
 +p2MuxGY5N7uf1dpWDUuJ+yDd1iw93MWqIqLuCKxzfvXfGvYGP2DkHpxvS3pPy+fk2Dh
 W2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331581; x=1776936381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7AtUkx0VyPnS/7wTUN1du3bU0kK4Kvdvu2eWwHOZlc=;
 b=XrTpwrIUBcjTF9y0hiSZ468/3+9wO8jni6cSSDaxatEBAavQ8yT5XkiU6C8lK/e0je
 nYaE1Sx3nesCz+usFnoIiXIShmX7vj+EeSsA611Lo+e3o46+tNPGa+JeW0GCyfPqTzyP
 NEDyNCmE2Jvgs4FhfcABbCvII3grusGTqCKn4pFe20KUgR5nDFgYH0CBF08NBn7KSw2i
 HnIA2sl2WWK+rp+y8dL6p+vegyFsC7CDAzsbI4ph5h7s45IgXzO1b9JkB/g4/p0UfRyy
 gSdJT/y+AGK1AFQYX6IeOYxAp3g+VNAArI1dLrWwONAwkp40Be2j5utFJzc1aqOfEoz8
 Xo5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NW3WkOSjyWevDga06q6lAPOrmjM6R1znpM5zRxaHNcg1JE/uLNP91HWDcZtQutbv4ecKnBJY=@lists.denx.de
X-Gm-Message-State: AOJu0YxFDnm4zIgT29ia6GdSa/I5mCZGexXaLHc2eNRBqkxTSHhj6hJS
 YOAYF+dbSa4Hv5YnSyH7XDnkvmnfuP052Ys3sOrvZ/d0xl12fjh1ez/0
X-Gm-Gg: AeBDievCxW8PZSW1++JSBd3+i2bD08FpY5n+PteYg29VgZ9Jjtl1XA+pWMYo25ZUldN
 DLkHQXkNxj9PxjEelxHX4e1O6Hcnqi5hR6bF8aE0gNed/3LY5XBLAa1MyYE0aF0JWdgMGiEiTSv
 l0uodTLqpML4jcZnbhMbkvZhS01CcTT8Uvd+Rm6Rqp3JDOMsjhgyWl4IknHfA8+0Qn7ikZc+C/V
 lrGAy0sGoL95QpkDPORnfEA+ZRvf8J6Q0BRwE8/aKJcTVHGqXvnSDi/5koLNRcuH3KgX91jWxOX
 6jOrx9D9DmQWbZI1Fz/D1Pe1L0yjB+GQJgc37c9nek7wtf2bfSQ2+Hp54+/NjJKK29V4VrFrVs2
 7xKGQ8UXWhdoQ+umm5OlucDMWx1uMW6H3x1vVS7JTGJBQ7BkxVavu2pTyfDwF9sMeow5th8HyFx
 PZJMX+kqtr9PV81HiBkP/6gfMfr+bHaUo=
X-Received: by 2002:a05:6a00:12dd:b0:827:3946:a23c with SMTP id
 d2e1a72fcca58-82f0c1daae1mr25165457b3a.10.1776331580561; 
 Thu, 16 Apr 2026 02:26:20 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:6c74:6a92:c2eb:e814])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f67449c3asm4753310b3a.53.2026.04.16.02.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:26:20 -0700 (PDT)
Date: Thu, 16 Apr 2026 17:26:17 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 3/6] virtio: mmio: Allow instantiation via platform data
Message-ID: <aeCrOdbmu4GOhX8Z@google.com>
References: <20260413092240.3719260-1-daniel@thingy.jp>
 <20260413092240.3719260-4-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413092240.3719260-4-daniel@thingy.jp>
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

On Mon, Apr 13, 2026 at 06:22:37PM +0900, Daniel Palmer wrote:
> The m68k QEMU virt machine doesn't use devicetree, yet, so
> allow it to create virtio-mmio instances via platform data.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
>  drivers/virtio/virtio_mmio.c | 27 ++++++++++++++++++---------
>  include/virtio_mmio.h        | 12 ++++++++++++
>  2 files changed, 30 insertions(+), 9 deletions(-)
>  create mode 100644 include/virtio_mmio.h
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 1cd737aca249..28b46ab66238 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -12,6 +12,7 @@
>  #include <virtio_types.h>
>  #include <virtio.h>
>  #include <virtio_ring.h>
> +#include <virtio_mmio.h>
>  #include <linux/bug.h>
>  #include <linux/compat.h>
>  #include <linux/err.h>
> @@ -335,21 +336,28 @@ static int virtio_mmio_notify(struct udevice *udev, struct virtqueue *vq)
>  
>  static int virtio_mmio_of_to_plat(struct udevice *udev)
>  {
> -	struct virtio_mmio_priv *priv = dev_get_priv(udev);
> +	struct virtio_mmio_plat *plat = dev_get_plat(udev);
> +	fdt_addr_t addr;
> +
> +	addr = dev_read_addr(udev);
>  
> -	priv->base = (void __iomem *)(ulong)dev_read_addr(udev);
> -	if (priv->base == (void __iomem *)FDT_ADDR_T_NONE)
> +	if (addr == FDT_ADDR_T_NONE)
>  		return -EINVAL;
>  
> +	plat->base = addr;
> +
>  	return 0;
>  }
>  
>  static int virtio_mmio_probe(struct udevice *udev)
>  {
> +	struct virtio_mmio_plat *plat = dev_get_plat(udev);
>  	struct virtio_mmio_priv *priv = dev_get_priv(udev);
>  	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(udev);
>  	u32 magic;
>  
> +	priv->base = (void __iomem *)plat->base;
> +
>  	/* Check magic value */
>  	magic = readl(priv->base + VIRTIO_MMIO_MAGIC_VALUE);
>  	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
> @@ -405,11 +413,12 @@ static const struct udevice_id virtio_mmio_ids[] = {
>  };
>  
>  U_BOOT_DRIVER(virtio_mmio) = {
> -	.name	= "virtio-mmio",
> -	.id	= UCLASS_VIRTIO,
> -	.of_match = virtio_mmio_ids,
> -	.ops	= &virtio_mmio_ops,
> -	.probe	= virtio_mmio_probe,
> +	.name       = "virtio-mmio",
> +	.id         = UCLASS_VIRTIO,
> +	.of_match   = virtio_mmio_ids,
> +	.ops        = &virtio_mmio_ops,
> +	.probe      = virtio_mmio_probe,
>  	.of_to_plat = virtio_mmio_of_to_plat,
> -	.priv_auto	= sizeof(struct virtio_mmio_priv),
> +	.priv_auto  = sizeof(struct virtio_mmio_priv),
> +	.plat_auto  = sizeof(struct virtio_mmio_plat),
>  };
> diff --git a/include/virtio_mmio.h b/include/virtio_mmio.h
> new file mode 100644
> index 000000000000..8c072826db55
> --- /dev/null
> +++ b/include/virtio_mmio.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __VIRTIO_MMIO_H__
> +#define __VIRTIO_MMIO_H__
> +
> +#include <linux/types.h>
> +
> +struct virtio_mmio_plat {
> +	phys_addr_t base;
> +};
> +
> +#endif /* __VIRTIO_MMIO_H__ */
> -- 
> 2.51.0
> 
