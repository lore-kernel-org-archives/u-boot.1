Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7C1CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C7783A3B;
	Tue, 28 Oct 2025 09:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a9S0dQb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D14D083A43; Tue, 28 Oct 2025 09:38:26 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92EBC839DD
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B7AB540805;
 Tue, 28 Oct 2025 08:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520A3C4CEE7;
 Tue, 28 Oct 2025 08:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761640702;
 bh=R3tzngHHmde2Ms8vsIAUv80XfFApqmcXvkceck8omS0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=a9S0dQb2UVvfWh4EYhu76lWCPluj/1VvG+oISBPz2vYR3aqmHzgE5DytxFVi3IPZ5
 c8WfjhyYzPQB5m0sMZcm+pgaQUoZZohdYNf3lndVOuzOuyjL+Gb8kLV8WkJpO4P1OI
 w/9MDrt897WSsFnL4wJ6azoZylj20DbfdTQueA2YzB0nuUQSnxxxD33/T91KMQZo78
 uhQXmv+aVLUnszuPx/o6VM84ARzk7GFwcUQAk42GKf5nAzbYqsS6zxmhBG7ExOcbPC
 Qjq7RSc9p7ne2MA3VZs5kyjJPv8l66ZHkO8L2I/73fvYZEO9yZVzCiKpBaEFUEc01b
 MVU0wCh2TaeBA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>,
 u-boot@lists.denx.de
Cc: George Chan <gchan9527@gmail.com>
Subject: Re: [PATCH] boot: bootmeth_android: Conditionally dependent on
 abootimg
In-Reply-To: <20251021-abootimg-minor-v1-1-88a12f53d8de@gmail.com>
References: <20251021-abootimg-minor-v1-1-88a12f53d8de@gmail.com>
Date: Tue, 28 Oct 2025 09:38:20 +0100
Message-ID: <87ms5bju9v.fsf@kernel.org>
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

Hi George,

Thank you for the patch.
Sorry I missed this, I was not cc'ed so it took me some time to notice
the patch.

On Tue, Oct 21, 2025 at 00:36, George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org> wrote:

> From: George Chan <gchan9527@gmail.com>
>
> If target u-boot img do not support androidboot v3 or greater,
> abootimg might not be necessary.
>
> aarch64-linux-gnu-ld.bfd: boot/bootmeth_android.o: in function `boot_android_normal':
> /home/user/sources/u-boot-next/boot/bootmeth_android.c:541:(.text.boot_android_normal+0xd0): undefined reference to `set_avendor_bootimg_addr'
> aarch64-linux-gnu-ld.bfd: /home/user/sources/u-boot-next/boot/bootmeth_android.c:543:(.text.boot_android_normal+0xd8): undefined reference to `set_abootimg_addr'
> Segmentation fault (core dumped)
>
> Signed-off-by: George Chan <gchan9527@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Cc: 
> ---
>  boot/bootmeth_android.c | 2 +-
>  include/image.h         | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 8c2bde10e17..d7740b86d67 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -534,7 +534,7 @@ static int boot_android_normal(struct bootflow *bflow)
>  	if (ret < 0)
>  		return log_msg_ret("read boot", ret);
>  
> -	if (priv->header_version >= 3) {
> +	if (IS_ENABLED(CONFIG_CMD_ABOOTIMG) && priv->header_version >= 3) {
>  		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
>  					     priv->vendor_boot_img_size, vloadaddr);
>  		if (ret < 0)
> diff --git a/include/image.h b/include/image.h
> index fc2f2487095..55a6af69b31 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -2039,7 +2039,7 @@ ulong get_abootimg_addr(void);
>   * Return: no returned results
>   */
>  void set_abootimg_addr(ulong addr);
> -
> +void __weak set_abootimg_addr(ulong addr) {}
>  /**
>   * get_ainit_bootimg_addr() - Get Android init boot image address
>   *
> @@ -2060,6 +2060,7 @@ ulong get_avendor_bootimg_addr(void);
>   * Return: no returned results
>   */
>  void set_avendor_bootimg_addr(ulong addr);
> +void __weak set_avendor_bootimg_addr(ulong addr) {}
>  
>  /**
>   * board_fit_config_name_match() - Check for a matching board name
>
> ---
> base-commit: 4e4a9de31de2a5f395ee25c59e4026422fbcb27e
> change-id: 20251021-abootimg-minor-17755894a376
>
> Best regards,
> -- 
> George Chan <gchan9527@gmail.com>
