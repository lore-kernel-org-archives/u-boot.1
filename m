Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D627FCDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 08:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB7087890;
	Mon, 23 Oct 2023 10:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IMy8Enry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F5D487894; Mon, 23 Oct 2023 10:23:18 +0200 (CEST)
Received: from mail-m12745.qiye.163.com (mail-m12745.qiye.163.com
 [115.236.127.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54351874A5
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=IMy8EnryMBtXOU/k8yHu9s0/QcGCwbB6Ot7gf+u6deCaVncfybox9Sr1FB6opTUmELr0znL9tYZC4Lz4BT9JKq3SMWCox/z8zmv3dVrysWx8TRrT8oUrqXNppLdTQB/naLAeGxjGMOgkEeHPt1DpLe3ebCKFoLogssGGwJhv6l8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=Pke2nLKrHilN/QgcEQaUzikNsofA2Wb/2bz6VSVqrGc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 861DD400443;
 Mon, 23 Oct 2023 16:22:31 +0800 (CST)
Message-ID: <845d776f-681f-4622-97ab-6c3b046bbc37@rock-chips.com>
Date: Mon, 23 Oct 2023 16:22:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] rockchip: block: blk-uclass: add bounce buffer
 flag to blk_desc
Content-Language: en-US
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 marex@denx.de, u-boot@lists.denx.de
References: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
 <ee332375-8812-8e12-da1c-9973d10a41af@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <ee332375-8812-8e12-da1c-9973d10a41af@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx9JQlZDHhoeTx9KGR4eHkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b5ba0e0202eb3kusn861dd400443
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhA6Dyo4PTwyITgBAj0#Mxwe
 DgNPCQFVSlVKTUJDS09CSE5JSUNIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSUtINwY+
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


On 2023/10/18 22:01, Johan Jonker wrote:
> Currently bounce buffer support is enabled for all block devices
> when available. Add a flag to blk_desc to enable only on demand.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> Changed V5:
>    New patch
> ---
>   drivers/block/blk-uclass.c | 4 ++--
>   drivers/scsi/scsi.c        | 4 ++++
>   include/blk.h              | 1 +
>   3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> index 30ad5bbb0024..77066da352a3 100644
> --- a/drivers/block/blk-uclass.c
> +++ b/drivers/block/blk-uclass.c
> @@ -441,7 +441,7 @@ long blk_read(struct udevice *dev, lbaint_t start, lbaint_t blkcnt, void *buf)
>   			  start, blkcnt, desc->blksz, buf))
>   		return blkcnt;
>
> -	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
> +	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && desc->bb) {
>   		struct blk_bounce_buffer bbstate = { .dev = dev };
>   		int ret;
>
> @@ -478,7 +478,7 @@ long blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
>
>   	blkcache_invalidate(desc->uclass_id, desc->devnum);
>
> -	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
> +	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && desc->bb) {
>   		struct blk_bounce_buffer bbstate = { .dev = dev };
>   		int ret;
>
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 7411660d465e..779a34bd2f1c 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -459,6 +459,9 @@ static void scsi_init_dev_desc_priv(struct blk_desc *dev_desc)
>   	dev_desc->product[0] = 0;
>   	dev_desc->revision[0] = 0;
>   	dev_desc->removable = false;
> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
> +	dev_desc->bb = true;
> +#endif	/* CONFIG_BOUNCE_BUFFER */
>   }
>
>   #if !defined(CONFIG_DM_SCSI)
> @@ -606,6 +609,7 @@ static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool verbose)
>   	bdesc->lun = lun;
>   	bdesc->removable = bd.removable;
>   	bdesc->type = bd.type;
> +	bdesc->bb = bd.bb;
>   	memcpy(&bdesc->vendor, &bd.vendor, sizeof(bd.vendor));
>   	memcpy(&bdesc->product, &bd.product, sizeof(bd.product));
>   	memcpy(&bdesc->revision, &bd.revision,	sizeof(bd.revision));
> diff --git a/include/blk.h b/include/blk.h
> index 76bd5baf9959..7c7cf7f2b102 100644
> --- a/include/blk.h
> +++ b/include/blk.h
> @@ -68,6 +68,7 @@ struct blk_desc {
>   	/* device can use 48bit addr (ATA/ATAPI v7) */
>   	bool	lba48;
>   	unsigned char	atapi;		/* Use ATAPI protocol */
> +	unsigned char	bb;		/* Use bounce buffer */
>   	lbaint_t	lba;		/* number of blocks */
>   	unsigned long	blksz;		/* block size */
>   	int		log2blksz;	/* for convenience: log2(blksz) */
> --
> 2.39.2
>
