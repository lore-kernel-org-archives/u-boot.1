Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3351C61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 09:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8C79807B1;
	Fri, 13 Jun 2025 11:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GYEMqV7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A93808AF; Fri, 13 Jun 2025 11:57:20 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F2D5800C1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 11:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id AAD33A50B86;
 Fri, 13 Jun 2025 09:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0CFC4CEE3;
 Fri, 13 Jun 2025 09:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749808637;
 bh=5c6+FpngIeyNIUTqyzP9GpGSM3hClPHaorW0PlU8pOc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=GYEMqV7Hyib8GWCT7htedCQ6np9LiFwzAiBzxK7di9nQY7NunART9cOybx6w94R9c
 AGOTPTPiTPWQaR12XW+wBu3nWdRHqxEMZSB6f/S+nfj9wEmsUWVrX3Uu882EsOdPzf
 utZ7pgSQeTLD1b47GIaThJhrg53THuQqzGN9hR7JKqlpIQ/23PFsKeVtxZ9taqU22l
 whgkc8yryaxoo5d+vYcD7UA5FhCmg6SzWnogQ9h48LEKkjXzKJWGDLKjT096sPv58A
 ZxcOSN+eMwnVDMZ0Hog5hNVu2IZddd9PlKp176hkODNYvQHThk5jESyn4fU3mfhttm
 uqa3lUMX/pbuQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ivan Pang <ipman@amazon.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>
Cc: Ivan Pang <ipman@amazon.com>, Casey Connolly
 <casey.connolly@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] dfu: fix dev_part_str for file operations
In-Reply-To: <20250611050127.38011-1-ipman@amazon.com>
References: <20250611050127.38011-1-ipman@amazon.com>
Date: Fri, 13 Jun 2025 11:57:14 +0200
Message-ID: <877c1g0xs5.fsf@kernel.org>
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

Hi Ivan,

Thank you for the patch, nice catch!

On Wed, Jun 11, 2025 at 05:00, Ivan Pang <ipman@amazon.com> wrote:

> The third_arg for a dfu alt is read as an integer and is overloaded for
> different supported backends. For ext4 and fat, this third_arg
> represents the partition and forms the dev part string, which should
> have its partition in hex. This commit fixes dfu ext4/fat usage for
> devices with ten or more partitions.
>
> Signed-off-by: Ivan Pang <ipman@amazon.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
>  drivers/dfu/dfu_mmc.c  | 2 +-
>  drivers/dfu/dfu_scsi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dfu/dfu_mmc.c b/drivers/dfu/dfu_mmc.c
> index c19eb919388..a91671755e1 100644
> --- a/drivers/dfu/dfu_mmc.c
> +++ b/drivers/dfu/dfu_mmc.c
> @@ -117,7 +117,7 @@ static int mmc_file_op(enum dfu_op op, struct dfu_entity *dfu,
>  		return -1;
>  	}
>  
> -	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d",
> +	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%x",
>  		 dfu->data.mmc.dev, dfu->data.mmc.part);
>  
>  	ret = fs_set_blk_dev("mmc", dev_part_str, fstype);
> diff --git a/drivers/dfu/dfu_scsi.c b/drivers/dfu/dfu_scsi.c
> index 9f95194784c..7ec34a8f7e3 100644
> --- a/drivers/dfu/dfu_scsi.c
> +++ b/drivers/dfu/dfu_scsi.c
> @@ -96,7 +96,7 @@ static int scsi_file_op(enum dfu_op op, struct dfu_entity *dfu, u64 offset, void
>  		return -1;
>  	}
>  
> -	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d", dfu->data.scsi.dev,
> +	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%x", dfu->data.scsi.dev,
>  		 dfu->data.scsi.part);
>  
>  	ret = fs_set_blk_dev("scsi", dev_part_str, fstype);
> -- 
> 2.47.1
