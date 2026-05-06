Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9587ECD3424
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 07:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED908394E;
	Wed,  6 May 2026 09:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gd/k8RYE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF57846F4; Wed,  6 May 2026 09:52:55 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B439B80086
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 09:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso3116760f8f.3
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 00:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778053972; x=1778658772; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=U420R9PVdZ0h+BRAZmYlKtYBvoqZPTD+tdRZh8SfV24=;
 b=gd/k8RYEevO3lUsPIOpd9f9ADlHDlzDBcUwtDySooQb67CJY8i7Ouprb/LhS7xZYTR
 vkuVPGtxyTsa/e0AEybCg3uXeFWxb6z8XkZTu9da82nPn1Rf525IG3wMMWCe4bswXZTD
 xq9RF9IbHzZb15q9iYU+swuxqi+68bsrlpbIXm1qTNaZb2yh0UCXRQwQXOcYdsAx7tVW
 sVEyf6+8fPdWmK4ujovH3bFaddTEM77Vns/FfPvp2IuQAcIjtO2P2K2v10SG8KPHJHQd
 5e1MHo/bRnmWMJBqONL/XeNLJgozhmHPHpKRgNmnolPFQrfWhNGTDMpV9j5RezVvVzqp
 q+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778053972; x=1778658772;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U420R9PVdZ0h+BRAZmYlKtYBvoqZPTD+tdRZh8SfV24=;
 b=WZ2Zqcridpug1Gp2n2Ikj0Lgx6qWsv0vgDAnvGccCiABDXuf+aMqJZJIOnd3PC5G1x
 y0S4SPtW/rHoi3aOqZCbEUrcpzdKO4RpWgnE+b48/9p00dRgt8emzSVCuogFR8tJ6+th
 Gka9bwo0krfMvwDFUvlATB+9oR92ZkxvaUuOLp1bZl0+ZysK3esh41j2S8Z2sLzvvSCp
 PN/j2qZgO5lt5zuID5S0JaQk0DDE2BTzWMNE+DmZgrPkLURyLoA4lbJy4bBZTsZRXR+t
 FgJhg7ke9rAfKFwSA0D/PvYySOVFlGrdKgWHgkEwgfqOR0p5FGrjLRMpGWNFr4frS3IS
 HbKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gaCWiuT2OHXhZcvS33G/G2StUQ3ixWDoKH85a87Uu1ZDHA2u/VLh0+5PV3qnxoW2hU0pIQ8Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxY4SIgCxxy9iHESgrFo81/LcDn3ewI5Wcdnqd1G06R/r8676GV
 5Xw6IZh3XT3Nr3XWtTqaz8Zskc+af4o4z9+9GUBVO13NwWXpRHFbztHK/Su5v9bfD9k=
X-Gm-Gg: AeBDievyQ8LSMIpOEa2z7V78RAH1XD0LizFGi0wgvV4ibQdcRtj3+7Fc85J56ztxivz
 1vZioV195txCJ9quvSc2dCF83Sh06qoFzIST5n0z8uDUz7xadJhZT9XcQYIJ1IbEpTZS0REqqf7
 HSFfZi535lr79nHNwe25+oZWAW/EOq91EIwZ1byBv1hSG1A9lT/H5Umc1p+ANJ27GBFpyuecs+S
 HCwUKuR+zUmFe/vT903irkAmr+Fh3DbgT/OsY2l9ovyPSbNirOWcSd/nHkljSLVu1Buk/r2R4AW
 h4EmXUZtXQdbsUEIh0MzgD58sX88h4AlRuEB1PIy/rH08WobR0AeUdtzaPWlXZE6QERHk2VgEi0
 dHj9I7JzQtdTNx6gpFU0OXfEw7kuzA2YlYWUhe63WMNp7WL+pJNrBxg9+3uJ0HLNTflSFkswFUz
 XlmF5TlNzi4y3j6mULhPZOZZ1Cy/5qqoFyyzN6sMyr3OXmf1BzA1WE5dYNYGkNlKAPtPDl+K0n4
 O2ZQtinT9YtWcSFWQ==
X-Received: by 2002:a05:6000:4210:b0:43b:9a9f:8956 with SMTP id
 ffacd0b85a97d-4515ce1c80fmr3720852f8f.22.1778053971859; 
 Wed, 06 May 2026 00:52:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:19a4:dd04:854d:9f82?
 ([2a01:e0a:106d:1080:19a4:dd04:854d:9f82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960fd6sm11106656f8f.31.2026.05.06.00.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 00:52:51 -0700 (PDT)
Message-ID: <fcdac873-bba4-4a76-853b-23672989d43f@linaro.org>
Date: Wed, 6 May 2026 09:52:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Fix missing inbound DMA offset calculation
To: Torsten Duwe <duwe@lst.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Andrea della Porta <andrea.porta@suse.com>, u-boot@lists.denx.de
References: <20260430145412.BC53E68AFE@verein.lst.de>
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
In-Reply-To: <20260430145412.BC53E68AFE@verein.lst.de>
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

On 4/30/26 16:54, Torsten Duwe wrote:
> From: Torsten Duwe <duwe@suse.de>
> 
> U-Boot currently does not account for PCIe bridges with a non-zero
> inbound access offset when talking NVMe, it only works on platforms
> where this offset happens to be zero.
> 
> This patch enhances the NVMe driver with the ability to also handle
> these cases. The fix is required to boot e.g. the Raspberry Pi5 from
> NVMe.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
> 
> Kudos for the idea of case discrimination go to Andrea; this eases
> things a lot.
> 
> I do consider this a bug fix. The problem has popped up during RPi5
> development but really is a generic major defect IMHO. Please apply
> wherever appropriate.
> 
> 	Torsten
> 
> ---
>   drivers/nvme/nvme.c | 39 ++++++++++++++++++++++++++-------------
>   1 file changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index 2b14437f69c..8056f52fb50 100644
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
> @@ -27,6 +28,18 @@
>   #define IO_TIMEOUT		30
>   #define MAX_PRP_POOL		512
>   
> +/*
> + * This macro detects the correct inbound DMA offset in both cases:
> + *   1) the NVMe is mentioned in the device tree, along with its parent,
> + *	and no intermediate PCIe bus node in between.
> + *   2) the NVMe was found dynamically by PCI enumeration which has created
> + *	an intermediate PCIe bus node. That node will be skipped and the offset
> + *	looked up in the grandparent.
> + */
> +#define DEV_ADDR(a)		(dev_has_ofnode(dev->udev) ? \
> +					dev_phys_to_bus(dev->udev, (a)) : \
> +					dev_phys_to_bus(dev->udev->parent, (a)))

This looks subspicious, what is the state of the rpi5 here ? with a DT node or without ?

AFAIK NVMes are always dynamically detected, it seems the dma_offset is not correctly
copied to the nvme udev when created.

Could you look into this direction instead ?

> +
>   static int nvme_wait_csts(struct nvme_dev *dev, u32 mask, u32 val)
>   {
>   	int timeout;
> @@ -91,12 +104,12 @@ static int nvme_setup_prps(struct nvme_dev *dev, u64 *prp2,
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
> @@ -393,8 +406,8 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
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
> @@ -420,7 +433,7 @@ static int nvme_alloc_cq(struct nvme_dev *dev, u16 qid,
>   
>   	memset(&c, 0, sizeof(c));
>   	c.create_cq.opcode = nvme_admin_create_cq;
> -	c.create_cq.prp1 = cpu_to_le64((ulong)nvmeq->cqes);
> +	c.create_cq.prp1 = cpu_to_le64(DEV_ADDR((ulong)nvmeq->cqes));
>   	c.create_cq.cqid = cpu_to_le16(qid);
>   	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
>   	c.create_cq.cq_flags = cpu_to_le16(flags);
> @@ -437,7 +450,7 @@ static int nvme_alloc_sq(struct nvme_dev *dev, u16 qid,
>   
>   	memset(&c, 0, sizeof(c));
>   	c.create_sq.opcode = nvme_admin_create_sq;
> -	c.create_sq.prp1 = cpu_to_le64((ulong)nvmeq->sq_cmds);
> +	c.create_sq.prp1 = cpu_to_le64(DEV_ADDR((ulong)nvmeq->sq_cmds));
>   	c.create_sq.sqid = cpu_to_le16(qid);
>   	c.create_sq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
>   	c.create_sq.sq_flags = cpu_to_le16(flags);
> @@ -458,14 +471,14 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
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
> @@ -490,7 +503,7 @@ int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
>   	memset(&c, 0, sizeof(c));
>   	c.features.opcode = nvme_admin_get_features;
>   	c.features.nsid = cpu_to_le32(nsid);
> -	c.features.prp1 = cpu_to_le64(dma_addr);
> +	c.features.prp1 = cpu_to_le64(DEV_ADDR(dma_addr));
>   	c.features.fid = cpu_to_le32(fid);
>   
>   	ret = nvme_submit_admin_cmd(dev, &c, result);
> @@ -516,7 +529,7 @@ int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
>   
>   	memset(&c, 0, sizeof(c));
>   	c.features.opcode = nvme_admin_set_features;
> -	c.features.prp1 = cpu_to_le64(dma_addr);
> +	c.features.prp1 = cpu_to_le64(DEV_ADDR(dma_addr));
>   	c.features.fid = cpu_to_le32(fid);
>   	c.features.dword11 = cpu_to_le32(dword11);
>   
> @@ -785,8 +798,8 @@ static ulong nvme_blk_rw(struct udevice *udev, lbaint_t blknr,
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

