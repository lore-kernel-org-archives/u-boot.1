Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E007FCCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 15:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C05BD83E42;
	Wed,  8 Oct 2025 17:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 388D784014; Wed,  8 Oct 2025 17:40:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DE9B083A61
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 17:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C32A1CE0;
 Wed,  8 Oct 2025 08:39:50 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0AE43F66E;
 Wed,  8 Oct 2025 08:39:56 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:39:54 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Tom Rini <trini@konsulko.com>, Cody
 Schuffelen <schuffelen@google.com>, Dmitrii Merkurev
 <dimorinny@google.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Debbie Horsfall  <Debbie.Horsfall@arm.com>
Subject: Re: [PATCH v2 1/1] virtio: blk: support block sizes exceeding 512
 bytes
Message-ID: <20251008163954.6da0f778@donnerap.manchester.arm.com>
In-Reply-To: <20250830203954.25775-1-heinrich.schuchardt@canonical.com>
References: <20250830203954.25775-1-heinrich.schuchardt@canonical.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 30 Aug 2025 22:39:54 +0200
Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

Hi Heinrich,

> QEMU allows to specify the logical block size via parameter
> logical_block_size of a virtio-blk-device.
> 
> The communication channel via virtqueues remains based on 512 byte blocks
> even if the logical_block_size is larger.
> 
> Consider the logical block size in the block device driver.
> 
> Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	remove superfluous include linux/err.h
> ---
>  drivers/virtio/virtio_blk.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
> index 2f999fc8bbe..4224e3c17f4 100644
> --- a/drivers/virtio/virtio_blk.c
> +++ b/drivers/virtio/virtio_blk.c
> @@ -12,10 +12,17 @@
>  #include <virtio_types.h>
>  #include <virtio.h>
>  #include <virtio_ring.h>
> +#include <linux/log2.h>
>  #include "virtio_blk.h"
>  
> +/**
> + * struct virtio_blk_priv - private date for virtio block device
> + */
>  struct virtio_blk_priv {
> +	/** @virtqueue - virtqueue to process */
>  	struct virtqueue *vq;
> +	/** @blksz_shift - log2 of block size divided by 512 */
> +	u32 blksz_shift;
>  };
>  
>  static const u32 feature[] = {
> @@ -71,6 +78,8 @@ static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
>  	u8 status;
>  	int ret;
>  
> +	sector <<= priv->blksz_shift;
> +	blkcnt <<= priv->blksz_shift;
>  	virtio_blk_init_header_sg(dev, sector, type, &out_hdr, &hdr_sg);
>  	sgs[num_out++] = &hdr_sg;
>  
> @@ -109,7 +118,7 @@ static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
>  		;
>  	log_debug("done\n");
>  
> -	return status == VIRTIO_BLK_S_OK ? blkcnt : -EIO;
> +	return status == VIRTIO_BLK_S_OK ? blkcnt >> priv->blksz_shift : -EIO;
>  }
>  
>  static ulong virtio_blk_read(struct udevice *dev, lbaint_t start,
> @@ -177,15 +186,25 @@ static int virtio_blk_probe(struct udevice *dev)
>  	struct blk_desc *desc = dev_get_uclass_plat(dev);
>  	u64 cap;
>  	int ret;
> +	u32 blk_size;
>  
>  	ret = virtio_find_vqs(dev, 1, &priv->vq);
>  	if (ret)
>  		return ret;
>  
> -	desc->blksz = 512;
> -	desc->log2blksz = 9;
>  	virtio_cread(dev, struct virtio_blk_config, capacity, &cap);
>  	desc->lba = cap;
> +	if (!virtio_has_feature(dev, VIRTIO_BLK_F_BLK_SIZE)) {

Is that actually the right condition check? I would assume that we only
query the blk_size field if the feature bit is *set*, not when it's
cleared?
We see a failure (virtio block device not registering), because blk_size is
0 on the Arm FVP fast model, which is fine I think because the feature bit
is clear as well.

Cheers,
Andre

> +		virtio_cread(dev, struct virtio_blk_config, blk_size, &blk_size);
> +		desc->blksz = blk_size;
> +		if (!is_power_of_2(blk_size) || desc->blksz < 512)
> +			return -EIO;
> +	} else {
> +		desc->blksz = 512;
> +	}
> +	desc->log2blksz = LOG2(desc->blksz);
> +	priv->blksz_shift = desc->log2blksz - 9;
> +	desc->lba >>= priv->blksz_shift;
>  
>  	return 0;
>  }

