Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D635C8303C
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 07:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95BAA806D8;
	Fri, 11 Jul 2025 09:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nWZt8u6E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9330280836; Fri, 11 Jul 2025 09:48:44 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01527805D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 09:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C20A45C5D2D;
 Fri, 11 Jul 2025 07:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D3DC4CEED;
 Fri, 11 Jul 2025 07:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752220120;
 bh=VpWcYLBUJP91b9w0GAtFgfHwf71fQmDgk6+kVSuRv7c=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=nWZt8u6EbU99yhrr+HMOQcsUwSmddFxjCmnL7cRTRh99f8AahCNknfbqX4hb+gA0G
 9EuC/y6RZsdVADG+TAvpjDHfN3mr8vyLHHZMzTBUsCwlhl/xVMQndCUfjQhwW6O3t4
 xnxsfd+MtTHv9lG1WE3flDzpSNZodVLRs9YDd/HjF2mCjaqB/SkfYyRBhyVbVyIXS0
 4lKZQtuf2RdrDm3kTg2fxRoFlNLmGFW80lztVu/9TbfCquV20xe6Y7SyY8NUIf34c4
 feJuKAJdpiLl//HNHPFPJeEHH5gipRXtLg3aea/QQxj+T6s0eVe76LAtR53rER3RbQ
 mg673n1HB2pgg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Chance Yang <chance.yang@kneron.us>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, morgan.chang@kneron.us, Chance Yang
 <chance.yang@kneron.us>
Subject: Re: [PATCH] fastboot: fb_mmc: Fix write/erase logic when buffer
 address is zero
In-Reply-To: <20250708-master-v1-1-f97e40dd395b@kneron.us>
References: <20250708-master-v1-1-f97e40dd395b@kneron.us>
Date: Fri, 11 Jul 2025 09:48:36 +0200
Message-ID: <877c0fjhgr.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Chance,

Thank you for the patch.

On Tue, Jul 08, 2025 at 08:59, Chance Yang <chance.yang@kneron.us> wrote:

> When CONFIG_FASTBOOT_BUF_ADDR is set to 0x0, the buffer pointer becomes
> NULL, causing fb_mmc_blk_write() to incorrectly perform erase operations
> instead of write operations. This happens because the function uses
> buffer pointer NULL check to determine whether to write or erase.
>
> Add an explicit is_erase parameter to fb_mmc_blk_write() to clearly
> distinguish between write and erase operations, removing the ambiguity
> when buffer address is zero.
>
> Signed-off-by: Chance Yang <chance.yang@kneron.us>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Unfortunately, this patch is not publicly available on the mailing list:
http://lore.kernel.org/all/20250708-master-v1-1-f97e40dd395b@kneron.us

Neither on patchwork:
https://patchwork.ozlabs.org/project/uboot/list/?submitter=91223&state=%2A&series=&q=&delegate=&archive=both

Is it possible that you are not subscribed to the u-boot mailing list?

Maybe it got (wrongly) filtered out as spam.

If possible, please re-send it so that it gets properly tracked on the
public mailing list.

Thanks
Mattijs

> ---
>  drivers/fastboot/fb_mmc.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
> index dca7c222f35659b22d327541b245760a6a6d7b35..65305c55eb9b70627e6ac5a3f0933b9cebb18a9d 100644
> --- a/drivers/fastboot/fb_mmc.c
> +++ b/drivers/fastboot/fb_mmc.c
> @@ -120,10 +120,11 @@ static int part_get_info_by_name_or_alias(struct blk_desc **dev_desc,
>   * @block_dev: Pointer to block device
>   * @start: First block to write/erase
>   * @blkcnt: Count of blocks
> - * @buffer: Pointer to data buffer for write or NULL for erase
> + * @buffer: Pointer to data buffer for write
> + * @is_erase: Set to true to force erase operation
>   */
>  static lbaint_t fb_mmc_blk_write(struct blk_desc *block_dev, lbaint_t start,
> -				 lbaint_t blkcnt, const void *buffer)
> +				 lbaint_t blkcnt, const void *buffer, bool is_erase)
>  {
>  	lbaint_t blk = start;
>  	lbaint_t blks_written;
> @@ -133,15 +134,15 @@ static lbaint_t fb_mmc_blk_write(struct blk_desc *block_dev, lbaint_t start,
>  
>  	for (i = 0; i < blkcnt; i += FASTBOOT_MAX_BLK_WRITE) {
>  		cur_blkcnt = min((int)blkcnt - i, FASTBOOT_MAX_BLK_WRITE);
> -		if (buffer) {
> +		if (is_erase) {
> +			if (fastboot_progress_callback)
> +				fastboot_progress_callback("erasing");
> +			blks_written = blk_derase(block_dev, blk, cur_blkcnt);
> +		} else {
>  			if (fastboot_progress_callback)
>  				fastboot_progress_callback("writing");
>  			blks_written = blk_dwrite(block_dev, blk, cur_blkcnt,
>  						  buffer + (i * block_dev->blksz));
> -		} else {
> -			if (fastboot_progress_callback)
> -				fastboot_progress_callback("erasing");
> -			blks_written = blk_derase(block_dev, blk, cur_blkcnt);
>  		}
>  		blk += blks_written;
>  		blks += blks_written;
> @@ -155,7 +156,7 @@ static lbaint_t fb_mmc_sparse_write(struct sparse_storage *info,
>  	struct fb_mmc_sparse *sparse = info->priv;
>  	struct blk_desc *dev_desc = sparse->dev_desc;
>  
> -	return fb_mmc_blk_write(dev_desc, blk, blkcnt, buffer);
> +	return fb_mmc_blk_write(dev_desc, blk, blkcnt, buffer, false);
>  }
>  
>  static lbaint_t fb_mmc_sparse_reserve(struct sparse_storage *info,
> @@ -183,7 +184,7 @@ static void write_raw_image(struct blk_desc *dev_desc,
>  
>  	puts("Flashing Raw Image\n");
>  
> -	blks = fb_mmc_blk_write(dev_desc, info->start, blkcnt, buffer);
> +	blks = fb_mmc_blk_write(dev_desc, info->start, blkcnt, buffer, false);
>  
>  	if (blks != blkcnt) {
>  		pr_err("failed writing to device %d\n", dev_desc->devnum);
> @@ -204,7 +205,7 @@ static int fb_mmc_erase_mmc_hwpart(struct blk_desc *dev_desc)
>  
>  	debug("Start Erasing mmc hwpart[%u]...\n", dev_desc->hwpart);
>  
> -	blks = fb_mmc_blk_write(dev_desc, 0, dev_desc->lba, NULL);
> +	blks = fb_mmc_blk_write(dev_desc, 0, dev_desc->lba, NULL, true);
>  
>  	if (blks != dev_desc->lba) {
>  		pr_err("Failed to erase mmc hwpart[%u]\n", dev_desc->hwpart);
> @@ -248,7 +249,7 @@ static void fb_mmc_boot_ops(struct blk_desc *dev_desc, void *buffer,
>  
>  		debug("Start Flashing Image to EMMC_BOOT%d...\n", hwpart);
>  
> -		blks = fb_mmc_blk_write(dev_desc, 0, blkcnt, buffer);
> +		blks = fb_mmc_blk_write(dev_desc, 0, blkcnt, buffer, false);
>  
>  		if (blks != blkcnt) {
>  			pr_err("Failed to write EMMC_BOOT%d\n", hwpart);
> @@ -696,7 +697,7 @@ void fastboot_mmc_erase(const char *cmd, char *response)
>  	printf("Erasing blocks " LBAFU " to " LBAFU " due to alignment\n",
>  	       blks_start, blks_start + blks_size);
>  
> -	blks = fb_mmc_blk_write(dev_desc, blks_start, blks_size, NULL);
> +	blks = fb_mmc_blk_write(dev_desc, blks_start, blks_size, NULL, true);
>  
>  	if (blks != blks_size) {
>  		pr_err("failed erasing from device %d\n", dev_desc->devnum);
>
> ---
> base-commit: d1d53c252a4a746db5ebcdf0d6de3aa0feec504e
> change-id: 20250708-master-1ada88b99b35
>
> Best regards,
> -- 
> Chance Yang <chance.yang@kneron.us>
