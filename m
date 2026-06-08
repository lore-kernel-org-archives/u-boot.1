Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F73CD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44C338405A;
	Mon,  8 Jun 2026 10:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nZllNJXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 164B7846A7; Mon,  8 Jun 2026 10:41:53 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF30683EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:41:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 12C2D43AA0;
 Mon,  8 Jun 2026 08:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC231F00893;
 Mon,  8 Jun 2026 08:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780908109;
 bh=lqzIfyNNrsJFYXEAhvAj/JrLJ+68SdZs83ZczopYldM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=nZllNJXCF6IMa6kN+WVxp+D36EMye1tmEWS8+IOL658n7LkrtGDVPAtwDBXme5gcF
 suEGcGTnHAcNcEd+/EbmMyek8mDzF9kFmfxJ/PJEEGD9+d8HLUS/0VpgVeO5uCoyg0
 FECRF++TEntAwU9/LydMAVFUe7VilhHsrqgNfcaSW+9Uq94ZSCZD7zq6ASdedqbs7e
 y0HsrBMkggvi4+4w/QzWXpgAyIZwHh6Pvdu7bj2H0dKF3/OEyhmrDzDGhRl7XMFQrb
 8LL/L8yd0soS3ivrpMh+vUQN1ZbQ8sx2oz830ki0pQMTFjSzqfEJonEKNZW0E1Nqm2
 zQ20ed4V3eNeA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 10/11] sandbox: Find disk images in the
 persistent-data directory
In-Reply-To: <20260523085455.750591-11-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
 <20260523085455.750591-11-sjg@chromium.org>
Date: Mon, 08 Jun 2026 10:41:46 +0200
Message-ID: <87ldcpxw39.fsf@kernel.org>
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

Hi Simon,

Thank you for the patch.

On Sat, May 23, 2026 at 02:54, Simon Glass <sjg@chromium.org> wrote:

> The sandbox mmc, scsi and usb-flash drivers open their backing files
> from plat->pathname as given. Test images are about to move out of
> the source tree into the persistent-data directory, so the drivers
> need to find them there.
>
> Try the persistent-data directory first via os_persistent_file() and
> fall back to the original pathname when the lookup fails, so absolute
> paths and files already in the current directory keep working.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  drivers/mmc/sandbox_mmc.c        | 13 +++++++++++--
>  drivers/scsi/sandbox_scsi.c      | 15 ++++++++++++---
>  drivers/usb/emul/sandbox_flash.c | 14 +++++++++++---
>  3 files changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/sandbox_mmc.c b/drivers/mmc/sandbox_mmc.c
> index a24520f2e78..42a80c7499c 100644
> --- a/drivers/mmc/sandbox_mmc.c
> +++ b/drivers/mmc/sandbox_mmc.c
> @@ -170,11 +170,20 @@ static int sandbox_mmc_probe(struct udevice *dev)
>  	int ret;
>  
>  	if (plat->fname) {
> -		ret = os_map_file(plat->fname, OS_O_RDWR | OS_O_CREAT,
> +		const char *fname = plat->fname;
> +		char buf[256];

Why 256? Can't we use a define/constant for this?
I see that fname ends up coming from ofnode_read_string() but it's
unclear to me if there is a build-time constant size we could use instead.

> +
> +		/*
> +		 * Try persistent data directory first, then fall back to the
> +		 * filename as given (for absolute paths or current directory)
> +		 */
> +		if (!os_persistent_file(buf, sizeof(buf), plat->fname))
> +			fname = buf;
> +		ret = os_map_file(fname, OS_O_RDWR | OS_O_CREAT,
>  				  (void **)&priv->buf, &priv->size);
>  		if (ret) {
>  			log_err("%s: Unable to map file '%s'\n", dev->name,
> -				plat->fname);
> +				fname);
>  			return ret;
>  		}
>  		priv->csize = priv->size / SIZE_MULTIPLE - 1;
> diff --git a/drivers/scsi/sandbox_scsi.c b/drivers/scsi/sandbox_scsi.c
> index 544a0247083..97afeddc2e9 100644
> --- a/drivers/scsi/sandbox_scsi.c
> +++ b/drivers/scsi/sandbox_scsi.c
> @@ -104,9 +104,18 @@ static int sandbox_scsi_probe(struct udevice *dev)
>  	info->block_size = SANDBOX_SCSI_BLOCK_LEN;
>  
>  	if (priv->pathname) {
> -		priv->fd = os_open(priv->pathname, OS_O_RDONLY);
> -		if (priv->fd != -1) {
> -			ret = os_get_filesize(priv->pathname, &info->file_size);
> +		const char *pathname = priv->pathname;
> +		char buf[256];
> +
> +		/*
> +		 * Try persistent data directory first, then fall back to the
> +		 * pathname as given (for absolute paths or current directory)
> +		 */
> +		if (!os_persistent_file(buf, sizeof(buf), priv->pathname))
> +			pathname = buf;
> +		priv->fd = os_open(pathname, OS_O_RDONLY);
> +		if (priv->fd >= 0) {

I've noticed that the error handling gets updated here (from != -1 to >=
0).
Any reason for doing that? If so, can you please mention it in
the commit message?

os_open()'s docstring seems to mention:

 * Return:	file descriptor, or -1 on error

> +			ret = os_get_filesize(pathname, &info->file_size);
>  			if (ret)
>  				return log_msg_ret("sz", ret);
>  		}
> diff --git a/drivers/usb/emul/sandbox_flash.c b/drivers/usb/emul/sandbox_flash.c
> index b5176bb30ce..82aa7062865 100644
> --- a/drivers/usb/emul/sandbox_flash.c
> +++ b/drivers/usb/emul/sandbox_flash.c
> @@ -339,11 +339,19 @@ static int sandbox_flash_probe(struct udevice *dev)
>  	struct sandbox_flash_plat *plat = dev_get_plat(dev);
>  	struct sandbox_flash_priv *priv = dev_get_priv(dev);
>  	struct scsi_emul_info *info = &priv->eminfo;
> +	const char *pathname = plat->pathname;
> +	char buf[256];
>  	int ret;
>  
> -	priv->fd = os_open(plat->pathname, OS_O_RDWR);
> -	if (priv->fd != -1) {
> -		ret = os_get_filesize(plat->pathname, &info->file_size);
> +	/*
> +	 * Try persistent data directory first, then fall back to the
> +	 * pathname as given (for absolute paths or current directory)
> +	 */
> +	if (!os_persistent_file(buf, sizeof(buf), plat->pathname))
> +		pathname = buf;
> +	priv->fd = os_open(pathname, OS_O_RDWR);
> +	if (priv->fd >= 0) {

Same here.

> +		ret = os_get_filesize(pathname, &info->file_size);
>  		if (ret)
>  			return log_msg_ret("sz", ret);
>  	}
> -- 
> 2.43.0
