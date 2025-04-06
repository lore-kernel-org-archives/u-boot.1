Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A86C3600C
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 09:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0DC182B2F;
	Sun,  6 Apr 2025 11:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Y1dmyLmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1073C82B32; Sun,  6 Apr 2025 11:52:28 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BC6582B12
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 11:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: d74f460e-12cc-11f0-a9b5-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d74f460e-12cc-11f0-a9b5-00505699b430;
 Sun, 06 Apr 2025 11:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=dXo2WWisL8NVo+UdQGfU0go5TJGFQNhBJITJ/dUrYKU=;
 b=Y1dmyLmkrHZBR7L2qZOLlsUtXpc1U/76TucS2XEzdUyPxMEq+UbaEsKz+KgiSQO4PD5ILtItTF6q4
 aHMKpjwx6JcRm5IKvllwiIrVqZM/0/KhPejbX7tR07A3R4PxgPxCckjxEjuGS/ELibRuRUHJrIN3tv
 Tt4ijw8yzNFP6KwuuWdnedAWSTbtL2USbbxDhG1hZaX0hQx1taLnn7LYqoXxPhFZca2LlCjGeh/Lvo
 ygv4iqVHSaGhvSg5Yo/1F7+lyF6pireDhYYsN3l88zDBc8ufE3eCeliZqEYsY3nLlJrL8T8yR5epf3
 9FK2nxgYtzQ8I3mIsYML1iGYpDvbcKQ==
X-KPN-MID: 33|0a9eSxIo0z526YV+2GJOjW6syPMJ4RswbAZ2QHYzPjq2HUYoEgqArFUEc9hPYNO
 2M3Q2MzD+65xkujutvWUdhA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|TBluFdVuCdq+fkTabG5aU6TeNcqL9VXrHj5iot5VQp9VBvHcKseDthhp5RtHCfw
 TrU9akrghwyfzdgLG8uUv4g==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d71760ca-12cc-11f0-af96-005056998788;
 Sun, 06 Apr 2025 11:52:24 +0200 (CEST)
Date: Sun, 06 Apr 2025 11:52:23 +0200
Message-Id: <87zfgtwrag.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, neil.armstrong@linaro.org,
 sjg@chromium.org, christian@kohlschutter.com, j@jannau.net
In-Reply-To: <20250405221308.498047-3-sjg@chromium.org> (message from Simon
 Glass on Sun, 6 Apr 2025 10:12:47 +1200)
Subject: Re: [PATCH 3/3] efi_loader: Move device-removal later in
 exit-boot-services
References: <20250405221308.498047-1-sjg@chromium.org>
 <20250405221308.498047-3-sjg@chromium.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> From: Simon Glass <sjg@chromium.org>
> Date: Sun,  6 Apr 2025 10:12:47 +1200

Hi Simon,

> This removal should be the last thing done, so that U-Boot does no more
> memory allocations afterwards. Move it and add a comment.

I really don't see what problem this is solving.  If DMA is stopped
before device driver memory is freed there is no problem with
overwriting memory.  And if DMA isn't stopped, it may overwrite memory
as soon as the OS starts using it.

All you're doing here is causing a conflict with the change that
Heinrich is proposing.

> Note that the TCG2 log is updated after this call, but I cannot see any
> allocations there.
> 
> Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  lib/efi_loader/efi_boottime.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index ffe43accd1e..e525662f82f 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -2250,14 +2250,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
>  			list_del(&evt->link);
>  	}
>  
> -	if (!efi_st_keep_devices) {
> -		bootm_disable_interrupts();
> -		if (IS_ENABLED(CONFIG_USB_DEVICE))
> -			udc_disconnect();
> -		board_quiesce_devices();
> -		dm_remove_devices_active();
> -	}
> -
>  	/* Patch out unsupported runtime function */
>  	efi_runtime_detach();
>  
> @@ -2279,6 +2271,19 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
>  	/* Give the payload some time to boot */
>  	efi_set_watchdog(0);
>  	schedule();
> +
> +	/*
> +	 * this should be the last thing done, to avoid memory allocations
> +	 * between removing devices and the OS taking over
> +	 */
> +	if (!efi_st_keep_devices) {
> +		bootm_disable_interrupts();
> +		if (IS_ENABLED(CONFIG_USB_DEVICE))
> +			udc_disconnect();
> +		board_quiesce_devices();
> +		dm_remove_devices_active();
> +	}
> +
>  out:
>  	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
>  		if (ret != EFI_SUCCESS)
> -- 
> 2.43.0
> 
> base-commit: bcfa94be955ef263d37918ef4b8f898ee8964c61
> branch: eth
> 
