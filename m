Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DE7CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 09:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF6558341A;
	Thu, 28 May 2026 11:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OXFeSEHa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D6A839A8; Thu, 28 May 2026 11:28:39 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB59580398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 11:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso7191045e9.0
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 02:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779960516; x=1780565316; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=FeW/6U8fo+wHBxIMqxO+I94eJRfN0AjGBfU9mYenYrs=;
 b=OXFeSEHaL4R8vZVReWWdIo6z81nFAp+JdWXm3BhdigWWEeK5oGIw2V0numSv3StCDf
 Gn6Dsecckux3kFClKCqFtnVG3dU3EzLBYzRVLEnteE1shRIz1ULnYZ9GVkLPnnzAoMIR
 7+hRN1vSsbZSL3lk9tnc0E28yY2CSaofSQrs+ZPqCnInYBRTdjx9xNimXwX9Y9BOcewp
 JEEB/ZhUUcxCDSbOds3/KaHUdx2+L9zLQFZYOEFgFHG86ixJqZqAwGjRBWaCZTEwnpPl
 yY3Ay9gTE3q8Zhfwg1w96v1Fd7bYPv/XshEXl0MNwUTE1bQe04qevYY/UO2VOw5w1APC
 Sx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779960516; x=1780565316;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FeW/6U8fo+wHBxIMqxO+I94eJRfN0AjGBfU9mYenYrs=;
 b=FARqIrRgH1GlUdviaOQUh2wiLPQ7bM5a/20TXuXZHPRa5PYv+Cft2bjwWUa2fqQAQX
 JZaYT5OZ2lMlNExEVYVQZ58V0A3gX+XLfoyrjbjEEp/jkF+tJLfyT4cewhv5v9orBI3E
 hm+1iHO/0EDbwDQrNqnP8Yj+Amsrwg4KmQ4Q3IEnSjIzyEExbVrY1ZMtEuIuM+tFLw+1
 0ZNqS5oQZkEIxHzyzpnTvMOoFANjRXmSmvWYwuZPnclPCreIz6KVcER03RHpUWb1wDK7
 rbuEL1BDT7Wn4tyGk+fhexL2G862LgdccnE+grA+F2yQtjWOXYJM4kd5BI5nIYbdYovN
 z3rA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+u9ZYjmZtYiuIGxHJM1RhdFGNzgTb3y5Fc/EItMo0fN39vjokdI5C6a5q5RUuJdZqyF1r2uCw=@lists.denx.de
X-Gm-Message-State: AOJu0Yxf3mfd3VBa61e0sY8t0UHGW5U8PSkPo63PWtiBOxuogtVvAz8/
 nA3yzY0AQGXl0QGhxYhOnaGaT6XJseX8Rhy1z2mSrOLJ1n3HTT/PoufWSlY0p+/GpCc=
X-Gm-Gg: Acq92OGUVSS5jN3gV33Rx1HEwCCfSuwwj4dbmjiZj2quriyEoApZjSW4r3Gx3bJL5u7
 iM4Dv2/IKRLkkxMCxkBA1/KdqJeaVEebJlfIaFPdkB6gDPMq+ptZqdI8qmUgeW6ssUEzkuGKYP8
 QeeR1UgRGKehkGNjz3muXqg3ktjGVqB+FD7wzRmTRyOcBIU9E/6q8Dqh2p1mz7SfLmCu9ZCmYki
 vpU/Zjrq4j7ZVi0A2Ngat0Sn8XzloKCqqJKMnJ1lyxuFFGmzI8K+DUaIARI9imJHUtx47kNlU0t
 9AWnk9yRcHJRFfO5BESCEs6898RjQqCtNuZBB+qrIdrhTc5gNEHTchdZ9txawS6CUszrJGOVFjB
 ektjDq3umjtQUShMsqxt/E5msTmcrpPa5aFE0uAzKPN82h3Usx/ozqWKr0hYp+2qGpG3WdF9AAO
 v/ycL9gqKIIxebyR3pbzoYXE2I0QV4Z0LaIjNCaaLwlfY=
X-Received: by 2002:a05:600c:8a08:b0:490:8a16:fd49 with SMTP id
 5b1f17b1804b1-4908a1707b4mr35860925e9.6.1779960515884; 
 Thu, 28 May 2026 02:28:35 -0700 (PDT)
Received: from [172.20.10.2] ([37.167.60.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eed49f19bsm424354f8f.14.2026.05.28.02.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 02:28:35 -0700 (PDT)
Message-ID: <baab255f-2cd9-4084-89b6-102a0c22ed19@linaro.org>
Date: Thu, 28 May 2026 11:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] drivers: nvme: Implement NVMe flush command (0x0)
To: dmukhin@ford.com, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20260528012056.1744362-1-dmukhin@ford.com>
 <20260528012056.1744362-3-dmukhin@ford.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260528012056.1744362-3-dmukhin@ford.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 5/28/26 03:20, dmukhin@ford.com wrote:
> From: Denis Mukhin <dmukhin@ford.com>
> 
> Add flush command implementation along with a high-level
> disk_blk_flush() API to be called at certain checkpoints
> during the boot (e.g. updating custom bootflow flags stored
> on NVMe).

First general comment, please split the patch by adding the
flush infrastructure first and then the nvme support.

The for NVMe, can it support write-through like SCSI FUA (Force Unit
Access) which bypasses the cache on writes, with slower writes
but safer and simpler than calling a flush before OS boot.

> 
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
>   disk/disk-uclass.c         |  6 ++++++
>   drivers/block/blk-uclass.c | 18 ++++++++++++++++++
>   drivers/nvme/nvme.c        | 20 ++++++++++++++++++++
>   include/blk.h              | 28 ++++++++++++++++++++++++++++
>   include/part.h             |  8 ++++++++
>   5 files changed, 80 insertions(+)
> 
> diff --git a/disk/disk-uclass.c b/disk/disk-uclass.c
> index ee3cc4407d76..b04b6306e5f2 100644
> --- a/disk/disk-uclass.c
> +++ b/disk/disk-uclass.c
> @@ -122,6 +122,11 @@ unsigned long disk_blk_erase(struct udevice *dev, lbaint_t start,
>   			 blkcnt);
>   }
>   
> +unsigned long disk_blk_flush(struct udevice *dev)
> +{
> +	return blk_flush(dev_get_parent(dev));
> +}
> +
>   UCLASS_DRIVER(partition) = {
>   	.id		= UCLASS_PARTITION,
>   	.per_device_plat_auto	= sizeof(struct disk_part),
> @@ -132,6 +137,7 @@ static const struct blk_ops blk_part_ops = {
>   	.read	= disk_blk_read,
>   	.write	= disk_blk_write,
>   	.erase	= disk_blk_erase,
> +	.flush  = disk_blk_flush,
>   };
>   
>   U_BOOT_DRIVER(blk_partition) = {
> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> index 73c24fd91763..0be1fdab1ba5 100644
> --- a/drivers/block/blk-uclass.c
> +++ b/drivers/block/blk-uclass.c
> @@ -514,6 +514,19 @@ long blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt)
>   	return ops->erase(dev, start, blkcnt);
>   }
>   
> +long blk_flush(struct udevice *dev)
> +{
> +	struct blk_desc *desc = dev_get_uclass_plat(dev);
> +	const struct blk_ops *ops = blk_get_ops(dev);
> +
> +	if (!ops->flush)
> +		return -ENOSYS;
> +
> +	blkcache_invalidate(desc->uclass_id, desc->devnum);
> +
> +	return ops->flush(dev);
> +}
> +
>   ulong blk_dread(struct blk_desc *desc, lbaint_t start, lbaint_t blkcnt,
>   		void *buffer)
>   {
> @@ -531,6 +544,11 @@ ulong blk_derase(struct blk_desc *desc, lbaint_t start, lbaint_t blkcnt)
>   	return blk_erase(desc->bdev, start, blkcnt);
>   }
>   
> +ulong blk_dflush(struct blk_desc *desc)
> +{
> +	return blk_flush(desc->bdev);
> +}
> +
>   int blk_find_from_parent(struct udevice *parent, struct udevice **devp)
>   {
>   	struct udevice *dev;
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index c3c44e50f19a..d9f099a11593 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -819,9 +819,29 @@ static ulong nvme_blk_write(struct udevice *udev, lbaint_t blknr,
>   	return nvme_blk_rw(udev, blknr, blkcnt, (void *)buffer, false);
>   }
>   
> +/*
> + * NVM Flush command (opcode 0x00).
> + *
> + * Applies to a single namespace; the controller must commit all dirty
> + * data for that namespace to storage before completing the command.
> + */
> +static ulong nvme_blk_flush(struct udevice *udev)
> +{
> +	struct nvme_ns *ns = dev_get_priv(udev);
> +	struct nvme_dev *dev = ns->dev;
> +	struct nvme_command c;
> +
> +	memset(&c, 0, sizeof(c));
> +	c.common.opcode = nvme_cmd_flush;
> +	c.common.nsid = cpu_to_le32(ns->ns_id);
> +
> +	return nvme_submit_sync_cmd(dev->queues[NVME_IO_Q], &c, NULL, IO_TIMEOUT);
> +}
> +
>   static const struct blk_ops nvme_blk_ops = {
>   	.read	= nvme_blk_read,
>   	.write	= nvme_blk_write,
> +	.flush	= nvme_blk_flush,
>   };
>   
>   U_BOOT_DRIVER(nvme_blk) = {
> diff --git a/include/blk.h b/include/blk.h
> index 8d1b70cabd31..3e2160a1ae4d 100644
> --- a/include/blk.h
> +++ b/include/blk.h
> @@ -99,6 +99,7 @@ struct blk_desc {
>   	unsigned long	(*block_erase)(struct blk_desc *block_dev,
>   				       lbaint_t start,
>   				       lbaint_t blkcnt);
> +	unsigned long	(*block_flush)(struct blk_desc *block_dev);
>   	void		*priv;		/* driver private struct pointer */
>   #endif
>   };
> @@ -275,6 +276,14 @@ struct blk_ops {
>   	 */
>   	int (*buffer_aligned)(struct udevice *dev, struct bounce_buffer *state);
>   #endif	/* CONFIG_BOUNCE_BUFFER */
> +
> +	/**
> +	 * flush() -  commit all dirty data to storage
> +	 *
> +	 * @dev:	Device to flush
> +	 * @return 0 if OK, -ve on error
> +	 */
> +	unsigned long (*flush)(struct udevice *dev);
>   };
>   
>   #if CONFIG_IS_ENABLED(BLK)
> @@ -291,6 +300,7 @@ unsigned long blk_dwrite(struct blk_desc *block_dev, lbaint_t start,
>   			 lbaint_t blkcnt, const void *buffer);
>   unsigned long blk_derase(struct blk_desc *block_dev, lbaint_t start,
>   			 lbaint_t blkcnt);
> +unsigned long blk_dflush(struct blk_desc *block_dev);
>   
>   #endif /* BLK */
>   
> @@ -331,6 +341,14 @@ long blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
>    */
>   long blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
>   
> +/**
> + * blk_flush() - Commit data to a block device
> + *
> + * @dev: Device to flush
> + * @return 0 if operation succeeded, or -ve on error.
> + */
> +long blk_flush(struct udevice *dev);
> +
>   /**
>    * blk_find_device() - Find a block device
>    *
> @@ -559,6 +577,16 @@ static inline ulong blk_derase(struct blk_desc *block_dev, lbaint_t start,
>   	return block_dev->block_erase(block_dev, start, blkcnt);
>   }
>   
> +static inline ulong blk_dflush(struct blk_desc *block_dev)
> +{
> +	blkcache_invalidate(block_dev->uclass_id, block_dev->devnum);

Call blkcache_invalidate only if flush cmd is supported

> +
> +	if (block_dev->block_flush)
> +		return block_dev->block_flush(block_dev);
> +
> +	return 0;

Why do you return success here and not from blk_flush() when flush is not supported?

> +}
> +
>   /**
>    * struct blk_driver - Driver for block interface types
>    *
> diff --git a/include/part.h b/include/part.h
> index 15daacd7faaa..63982d7b9370 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -454,6 +454,14 @@ ulong disk_blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
>    */
>   ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
>   
> +/**
> + * disk_blk_flush() - commit data to a disk
> + *
> + * @dev:	Device to flush
> + * Return:	0 success, or -ve error number (see the IS_ERR_VALUE() macro
> + */
> +ulong disk_blk_flush(struct udevice *dev);
> +
>   /*
>    * We don't support printing partition information in SPL and only support
>    * getting partition information in a few cases.

Thanks,
Neil
