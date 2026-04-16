Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0CDF8A146
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE1484206;
	Thu, 16 Apr 2026 11:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="xcT8vdke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E597784214; Thu, 16 Apr 2026 11:09:08 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7EEC84201
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1776330546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPAVGIpfcPYrWeOA094TQqj/XT2SGqPvI6a3PUsPD8w=;
 b=xcT8vdke8Pg0+KsqAXneEPKlBnro1dph0WrCVnBj80E1hvMj4UPfYvyvRzUQ7n+34VRoDF
 tTPOhwS9L7YZ97n5F12SJhV6BXYGQaCDXU5YwpsTFgCYKbbKarV8ZI0vE6Sw6qOE1aZ+av
 pIEio6exVOiI/U5CwXthUl/ZcWJJoHo=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 5e8d7371
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 16 Apr 2026 09:09:06 +0000 (UTC)
Message-ID: <c5ffb873-ed37-4abf-9da6-4389a6db7db8@kernel-space.org>
Date: Thu, 16 Apr 2026 11:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] virtio: mmio: Allow instantiation via platform data
To: Daniel Palmer <daniel@thingy.jp>, visitorckw@gmail.com, bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de
References: <20260413092240.3719260-1-daniel@thingy.jp>
 <20260413092240.3719260-4-daniel@thingy.jp>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260413092240.3719260-4-daniel@thingy.jp>
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>

On 4/13/26 11:22, Daniel Palmer wrote:
> The m68k QEMU virt machine doesn't use devicetree, yet, so
> allow it to create virtio-mmio instances via platform data.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> Reviewed-by: Simon Glass <sjg@chromium.org>
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

-- Angelo

