Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CAFCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 14:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB9968341A;
	Mon, 11 May 2026 16:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IXpHMQzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEBB483BC8; Mon, 11 May 2026 16:50:52 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85BDC80F0E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 16:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso52359365e9.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778511050; x=1779115850; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CB8eOEKBMflall7lkmN5VTJaf1IksK+UCcPz5kXcq4s=;
 b=IXpHMQzcthz8gPpVoi96beRR3usLccUvMJ18kHO7LeKbg3hjvyKkTEGSDOYPePqdA0
 rXYWfiZYHY8jq9NlkuzameBM/sIpgvzc6Tl2x5Q5uzFTYY+M4rDLLJLJpuzng2GiVIo7
 iWSE8vNC1iK42ZG4NrMYOKVYX9jyfvIhZXs6S3Xda1YYFyr+ppyhG/5GRba8SgLXqSlH
 d9Y8uLgewGol9kW8HC80hVLMgKiUFy4T9c1FRu/U8XWgOk1fS77roazYTahDyyzHLccr
 Mak5Z6FYdiMcow2B0lrfYoNQdSarp4woLdwJ8k4vRzL8dcD19oYnMBr+4p1Ohsf5KVyj
 7V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778511050; x=1779115850;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CB8eOEKBMflall7lkmN5VTJaf1IksK+UCcPz5kXcq4s=;
 b=eXpMkzGdBOfiPUYjpVLf3OA2bm9KYpJf1NVbrWImF+gaJyl9iIwi+Wgv6aXrA52Dj1
 pGBUrwlupNH1aLHpQYAxjRrEaBgvK9mwwgAtibR5z4Dg+za9EQRfcgrL8AtYSCzSoRPm
 WpaqRBOB7lieYgHf0qVE02bv5pgt+ax8R7J20UkrTxCduCm4mq3SdgeXguJzUSBUYiQY
 jtMg7Klqnw4Pvu7eVH6UGlm2sNqKHmXJsr70kjLaB7hmC/9bY9GsKaUbjb5O920tWO7y
 nYBn/dPl2gG7JXRpI+3CHklP14fBhESWKWIfepcM4DTcWdr57Ncgjz4Pox4WRiwl6TEk
 u4Mg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0ie5O0X92HUV7DaS31gAhAbPd8V7HZZ2qwnyG2ZyjZJbqyaLwjRHyCt1fohzQqztR2VBAxE8=@lists.denx.de
X-Gm-Message-State: AOJu0YwQIluM+NKNweP4+VO+/N0Q+zymyuM3qIYNoLmbw5bGlzn+tcUQ
 fSVrzDyXkvv14V2Fw1+fHcKRraRY9kQmmLU5By1G9HjUhmILXGpdl+ZCaQQcMHYTR1c=
X-Gm-Gg: Acq92OHJFXn71pyarRum2nI6fAMMVu8/57vSTAk8LQCQj2mSnBvhaKGKOyDOAgShp+Z
 zimGSRmn7XaC694NQvwUdoZsC5XTMgK8nw1k+/p6J99CHtppfYmMBxU9BMFS2ThBrf2aCYt4Jee
 A1nKQeDgqlotppjDMXaG8zOkvqK+HNtOL1u4J+vS+5K/K+gPMSbQAj+VIHqBzOpWkuIfazG87ef
 mm9ftCWRQ3+4oFmq/GdeSd8xdJsx1Pr/6cnB1LFUQLoU5uhXCW4kZqFQLl952TkdlH2S7bq4rW8
 aVGOIj7Wy0U8FLHVFhRGXkHdt9jsEUdwwcSYIydb2cQp9lz2N2OUOMkh6d64X+wNn7s9KrddUNH
 +kfGmlei6VadUrQ3vqWorUrGy3L0EIcdzCwgWJ67GKbUDA58mSOAlgt2I3qEFLqEjTFzG94vk7H
 XMlJadAaGuOdE39J2NzJY3Kp7FsC6xw7M+vvBcgpED/YBe9sS0X9fBlsD3Xfyml1fsexY+wDtUB
 XVKWag=
X-Received: by 2002:a05:600c:3e10:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-48e5e0089e0mr298188885e9.13.1778511049684; 
 Mon, 11 May 2026 07:50:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:63dd:7879:45c5:21b9?
 ([2a01:e0a:106d:1080:63dd:7879:45c5:21b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6fffb9bdsm177545885e9.1.2026.05.11.07.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 07:50:49 -0700 (PDT)
Message-ID: <0fd48f59-1309-45ff-ab21-8b037449ea86@linaro.org>
Date: Mon, 11 May 2026 16:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] nvme: Fix missing address translation for PCIe
 inbound access
To: Torsten Duwe <duwe@lst.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>,
 Andrea della Porta <andrea.porta@suse.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, u-boot@lists.denx.de
References: <20260508154108.336B968BEB@verein.lst.de>
 <20260508154245.0E24868BFE@verein.lst.de>
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
In-Reply-To: <20260508154245.0E24868BFE@verein.lst.de>
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

On 5/8/26 17:42, Torsten Duwe wrote:
> From: Torsten Duwe <duwe@suse.de>
> 
> U-Boot currently does not account for PCIe bridges with a non-zero
> inbound access offset when talking NVMe, it only works on platforms
> where this offset happens to be zero.
> 
> This patch enhances the NVMe driver with the ability to also handle
> these cases.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> ---
>   drivers/nvme/nvme.c | 34 +++++++++++++++++++++-------------
>   1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index 2b14437f69c..99a47bf25f2 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -12,6 +12,7 @@
>   #include <log.h>
>   #include <malloc.h>
>   #include <memalign.h>
> +#include <phys2bus.h>
>   #include <time.h>
>   #include <dm/device-internal.h>
>   #include <linux/compat.h>
> @@ -27,6 +28,13 @@
>   #define IO_TIMEOUT		30
>   #define MAX_PRP_POOL		512
>   
> +/*
> + * Convert a memory address to the value needed by the PCI device to
> + * access the given location, taking into account inbound window
> + * translations of PCI bridges:
> + */
> +#define DEV_ADDR(a)		dev_phys_to_bus(dev->udev, (a))

This doesn't look very clean, I would do something closer to linux by precalculating
the DMA addresses after allocation like:
====================><================================
diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 2b14437f69c..1ce06402a90 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -241,6 +241,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev,
  	nvmeq->sq_cmds = (void *)memalign(4096, NVME_SQ_SIZE(depth));
  	if (!nvmeq->sq_cmds)
  		goto free_queue;
+	nvmeq->sq_dma_addr = dev_phys_to_bus(dev->udev, nvmeq->sq_cmds);
  	memset((void *)nvmeq->sq_cmds, 0, NVME_SQ_SIZE(depth));

  	nvmeq->dev = dev;
@@ -393,7 +394,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
  	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;

  	writel(aqa, &dev->bar->aqa);
-	nvme_writeq((ulong)nvmeq->sq_cmds, &dev->bar->asq);
+	nvme_writeq((ulong)nvmeq->sq_dma_addr, &dev->bar->asq);
  	nvme_writeq((ulong)nvmeq->cqes, &dev->bar->acq);

  	result = nvme_enable_ctrl(dev);
diff --git a/drivers/nvme/nvme.h b/drivers/nvme/nvme.h
index bc1d612dde4..9c5e57cb586 100644
--- a/drivers/nvme/nvme.h
+++ b/drivers/nvme/nvme.h
@@ -637,6 +637,7 @@ enum nvme_queue_id {
  struct nvme_queue {
  	struct nvme_dev *dev;
  	struct nvme_command *sq_cmds;
+	dma_addr_t sq_dma_addr;
  	struct nvme_completion *cqes;
  	u32 __iomem *q_db;
  	u16 q_depth;
====================><================================

and same for the orther allocated buffers.

Thanks,
Neil

> +
>   static int nvme_wait_csts(struct nvme_dev *dev, u32 mask, u32 val)
>   {
>   	int timeout;
> @@ -91,12 +99,12 @@ static int nvme_setup_prps(struct nvme_dev *dev, u64 *prp2,
>   	i = 0;
>   	while (nprps) {
>   		if ((i == (prps_per_page - 1)) && nprps > 1) {
> -			*(prp_pool + i) = cpu_to_le64((ulong)prp_pool +
> -					page_size);
> +			*(prp_pool + i) = cpu_to_le64(DEV_ADDR((ulong)prp_pool +
> +								page_size));
>   			i = 0;
>   			prp_pool += page_size;
>   		}
> -		*(prp_pool + i++) = cpu_to_le64(dma_addr);
> +		*(prp_pool + i++) = cpu_to_le64(DEV_ADDR(dma_addr));
>   		dma_addr += page_size;
>   		nprps--;
>   	}
> @@ -393,8 +401,8 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>   	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>   
>   	writel(aqa, &dev->bar->aqa);
> -	nvme_writeq((ulong)nvmeq->sq_cmds, &dev->bar->asq);
> -	nvme_writeq((ulong)nvmeq->cqes, &dev->bar->acq);
> +	nvme_writeq(DEV_ADDR((ulong)nvmeq->sq_cmds), &dev->bar->asq);
> +	nvme_writeq(DEV_ADDR((ulong)nvmeq->cqes), &dev->bar->acq);
>   
>   	result = nvme_enable_ctrl(dev);
>   	if (result)
> @@ -420,7 +428,7 @@ static int nvme_alloc_cq(struct nvme_dev *dev, u16 qid,
>   
>   	memset(&c, 0, sizeof(c));
>   	c.create_cq.opcode = nvme_admin_create_cq;
> -	c.create_cq.prp1 = cpu_to_le64((ulong)nvmeq->cqes);
> +	c.create_cq.prp1 = cpu_to_le64(DEV_ADDR((ulong)nvmeq->cqes));
>   	c.create_cq.cqid = cpu_to_le16(qid);
>   	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
>   	c.create_cq.cq_flags = cpu_to_le16(flags);
> @@ -437,7 +445,7 @@ static int nvme_alloc_sq(struct nvme_dev *dev, u16 qid,
>   
>   	memset(&c, 0, sizeof(c));
>   	c.create_sq.opcode = nvme_admin_create_sq;
> -	c.create_sq.prp1 = cpu_to_le64((ulong)nvmeq->sq_cmds);
> +	c.create_sq.prp1 = cpu_to_le64(DEV_ADDR((ulong)nvmeq->sq_cmds));
>   	c.create_sq.sqid = cpu_to_le16(qid);
>   	c.create_sq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
>   	c.create_sq.sq_flags = cpu_to_le16(flags);
> @@ -458,14 +466,14 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
>   	memset(&c, 0, sizeof(c));
>   	c.identify.opcode = nvme_admin_identify;
>   	c.identify.nsid = cpu_to_le32(nsid);
> -	c.identify.prp1 = cpu_to_le64(dma_addr);
> +	c.identify.prp1 = cpu_to_le64(DEV_ADDR(dma_addr));
>   
>   	length -= (page_size - offset);
>   	if (length <= 0) {
>   		c.identify.prp2 = 0;
>   	} else {
>   		dma_addr += (page_size - offset);
> -		c.identify.prp2 = cpu_to_le64(dma_addr);
> +		c.identify.prp2 = cpu_to_le64(DEV_ADDR(dma_addr));
>   	}
>   
>   	c.identify.cns = cpu_to_le32(cns);
> @@ -490,7 +498,7 @@ int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
>   	memset(&c, 0, sizeof(c));
>   	c.features.opcode = nvme_admin_get_features;
>   	c.features.nsid = cpu_to_le32(nsid);
> -	c.features.prp1 = cpu_to_le64(dma_addr);
> +	c.features.prp1 = cpu_to_le64(DEV_ADDR(dma_addr));
>   	c.features.fid = cpu_to_le32(fid);
>   
>   	ret = nvme_submit_admin_cmd(dev, &c, result);
> @@ -516,7 +524,7 @@ int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
>   
>   	memset(&c, 0, sizeof(c));
>   	c.features.opcode = nvme_admin_set_features;
> -	c.features.prp1 = cpu_to_le64(dma_addr);
> +	c.features.prp1 = cpu_to_le64(DEV_ADDR(dma_addr));
>   	c.features.fid = cpu_to_le32(fid);
>   	c.features.dword11 = cpu_to_le32(dword11);
>   
> @@ -785,8 +793,8 @@ static ulong nvme_blk_rw(struct udevice *udev, lbaint_t blknr,
>   		c.rw.slba = cpu_to_le64(slba);
>   		slba += lbas;
>   		c.rw.length = cpu_to_le16(lbas - 1);
> -		c.rw.prp1 = cpu_to_le64(temp_buffer);
> -		c.rw.prp2 = cpu_to_le64(prp2);
> +		c.rw.prp1 = cpu_to_le64(DEV_ADDR(temp_buffer));
> +		c.rw.prp2 = cpu_to_le64(DEV_ADDR(prp2));
>   		status = nvme_submit_sync_cmd(dev->queues[NVME_IO_Q],
>   				&c, NULL, IO_TIMEOUT);
>   		if (status)

