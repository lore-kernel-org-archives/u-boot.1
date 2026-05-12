Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F96CD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 09:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3A2580398;
	Tue, 12 May 2026 11:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C774803C6; Tue, 12 May 2026 11:30:54 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A9C801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 107)
 id F17D768C7B; Tue, 12 May 2026 11:30:49 +0200 (CEST)
Received: from neoN1 (unknown [80.255.5.134])
 by verein.lst.de (Postfix) with ESMTPSA id B819067328;
 Tue, 12 May 2026 11:30:22 +0200 (CEST)
Date: Tue, 12 May 2026 11:30:17 +0200
From: Torsten Duwe <duwe@lst.de>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>, Andrea
 della Porta <andrea.porta@suse.com>, Simon Glass <sjg@chromium.org>, Jan
 =?UTF-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] nvme: Fix missing address translation for PCIe
 inbound access
Message-ID: <20260512113017.6d91e06c@neoN1>
In-Reply-To: <0fd48f59-1309-45ff-ab21-8b037449ea86@linaro.org>
References: <20260508154108.336B968BEB@verein.lst.de>
 <20260508154245.0E24868BFE@verein.lst.de>
 <0fd48f59-1309-45ff-ab21-8b037449ea86@linaro.org>
Organization: LST e.V.
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; aarch64-suse-linux-gnu)
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

On Mon, 11 May 2026 16:50:48 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 5/8/26 17:42, Torsten Duwe wrote:
[...]
> > +#define DEV_ADDR(a)		dev_phys_to_bus(dev->udev, (a))
> 
> This doesn't look very clean, I would do something closer to linux by precalculating
> the DMA addresses after allocation like:
> ====================><================================
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index 2b14437f69c..1ce06402a90 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -241,6 +241,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev,
>   	nvmeq->sq_cmds = (void *)memalign(4096, NVME_SQ_SIZE(depth));
>   	if (!nvmeq->sq_cmds)
>   		goto free_queue;
> +	nvmeq->sq_dma_addr = dev_phys_to_bus(dev->udev, nvmeq->sq_cmds);
>   	memset((void *)nvmeq->sq_cmds, 0, NVME_SQ_SIZE(depth));
> 
>   	nvmeq->dev = dev;
> @@ -393,7 +394,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>   	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
> 
>   	writel(aqa, &dev->bar->aqa);
> -	nvme_writeq((ulong)nvmeq->sq_cmds, &dev->bar->asq);
> +	nvme_writeq((ulong)nvmeq->sq_dma_addr, &dev->bar->asq);
>   	nvme_writeq((ulong)nvmeq->cqes, &dev->bar->acq);
> 
>   	result = nvme_enable_ctrl(dev);

Hm, time / space tradeoff. I don't really have a strong preference
regarding this, I'd worry most about U-Boot code size (for which this
doesn't make much of a difference). However, I was under the impression
that during regular NVMe business a lot of those buffers and addresses
get allocated and the translations are required often. That's probably
only true once a full-blown operating system is running.

I'll check the allocations and assignments. Any other opinions?

	Torsten
