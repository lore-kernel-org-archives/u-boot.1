Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB60CEDB7D0
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 01:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EF5B838BB;
	Wed,  8 Apr 2026 03:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FZaQKZZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8428D83936; Wed,  8 Apr 2026 03:47:41 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 436D780433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 03:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so22686295ad.2
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 18:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775612857; x=1776217657; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jLopDRoJnKmwFOOzt54v+zxqpnC8OlDrW2aCiHA/KGk=;
 b=FZaQKZZgeBtFGxyOaEYEr8WjRDCV50iHcgyHnK1SBz/iqBOAUfnzZkFw9kC2JAcjz6
 NZflG4WuUTo/xCXT9ca112JfjGHS42HQtZdEfGZCdFqcqA38uUeHd3Hs9rAnISoBPEjj
 D6GySL7NkNuGmnF4oRjh4vxCLfWBiWC6mxVrlqXpaFl8U49OnmR+KheMEmfhPib1xPtZ
 1lpOIGWJu02jzTPcRdJCF9hmYGHKfisb+tXvAtGo735U3Sp/2KbPAPcXtuRNdGrWB8xO
 4498gL47cMW7ycjDOVhI/mteVahLw8CNTrRsmdJWKHNAwGzNegR+mP09i3cN1M/50vVX
 PdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775612857; x=1776217657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jLopDRoJnKmwFOOzt54v+zxqpnC8OlDrW2aCiHA/KGk=;
 b=bDVTKzaLJRJloQfeAExf4LcRQ9/F5wfSNqtq/oSc9wJIV2B4WLrDra7DJymy3R2jiP
 SODdXrtu+zVoNsw4qAlv8RNGxEiEz+uKinsXoUai8qSKJ3uflsuA/F0IJLqKJ2Lp8oNU
 /6+Fmoq2AmeDrhBGoFZPrZUDsKiqAJOnhGYKM0WkKeBRyitT+p/klFsM5WJL/sMfH4o7
 qPiECuR9tYtCyZoAKmZyX9H0AzvqrMAABrPwUndQzMyUg1z0F0508OB1aCWxNEy2Dy2t
 0LoePU13vgxwN0HFpPOsJ9PEJIouMPa0lhQ4AAdm8PiJ+64mKR5gpIOKHsbkLFPe4Z+h
 w+mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKRxBxax1Np27tMXuyqRljk97DpDBlpP9nzOJOaFZBwMCIZneSNZQqMYSqMQeyDSKhMS7XwLQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxQT8OOeYvYAYWn/COEqzpXQ9g2IVPUwaliFayk8V6HOJOl3IYp
 +1Y8Owi9qQ8ybZ7Zs7/RSwgDF7qR7uB9bRxLIlAWLxpSApP3h/ccfvMD
X-Gm-Gg: AeBDietYZxk9XbESEnzVtQ7hGSi+tt3HXxzuPHx6Jjt+Uoh/1/3avJf/6Y2KLjxnlDx
 Ttr6g5pPIJpxalJVUAEuTlaBv6xyKDsJn+h57dGI5hJQyUItZB58inEQBk6Nng9/frEoZIjGXK8
 AhxEuIJB7+wRNeNDi3rlAaWQ2bj5SB0RDz6cl6BPSRyak40/xYUYxopMSQ7dD8g+AlqLyElBAzL
 7PuYZyExNS8Z6m+7ckk3jWKdrA9c2d3DNQDaABiFx1VG9HOl3iQeeOjtgC81wbSc0tX2jtOf8NY
 gNWaRmfEQLpo5zn13Ugreae285ICphYkIzykDl1k6CgiMR0rEd+uuXNoFlAbeGpa3EsUo8os4BQ
 m9GB0IIFxJXMiOOLMEI+WBpDs9q4vhWeJ4DjOK8iaL+cHJjz6aGaePuSWcB/eYVAtFK8KZggOE+
 ZGwEuOW68P1VbQWUXnOoEqSw4yEv6PLN0=
X-Received: by 2002:a17:903:f8d:b0:2b2:52a9:555a with SMTP id
 d9443c01a7336-2b281715be8mr203704555ad.7.1775612857456; 
 Tue, 07 Apr 2026 18:47:37 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:dab2:836d:86a2:3f7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2adc8c4ecsm37593965ad.5.2026.04.07.18.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 18:47:36 -0700 (PDT)
Date: Wed, 8 Apr 2026 09:47:34 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/5] virtio: mmio: Allow instantiation via platform data
Message-ID: <adWztoaranObqP2s@google.com>
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-5-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406142411.2992618-5-daniel@thingy.jp>
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

On Mon, Apr 06, 2026 at 11:24:10PM +0900, Daniel Palmer wrote:
> The m68k QEMU virt machine doesn't use devicetree, yet, so
> allow it to create virtio-mmio instances via platform data.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
>  drivers/virtio/virtio_mmio.c | 27 ++++++++++++++++++---------
>  include/virtio_mmio.h        | 12 ++++++++++++
>  2 files changed, 30 insertions(+), 9 deletions(-)
>  create mode 100644 include/virtio_mmio.h
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index ddf873fa96fb..51ef90c768af 100644
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

Just realized this didn't send earlier.

The patch looks good overall.
However, I noticed some changes involving tabs vs. spaces.
Do we have a specific style rule requiring spaces instead of tabs here?

Regards,
Kuan-Wei

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
