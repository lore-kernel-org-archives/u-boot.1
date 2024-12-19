Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459A3E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B968021D;
	Thu, 19 Dec 2024 19:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734633304;
	bh=K4yg0wmRaIMvuL1gtSipNVG/dzK2j2fvqiR4bdKmjb0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RsEDDyftB778b0GqQKhEjaI/t0TjVELqCZY+Js5FnZCxuVXDMiYCjYmYXNImGf9+n
	 GuniqnkSv3WohzG8u9lakpNkZsuaOoF+B2+aZowQQ9/Ifl9TEpuLXch0CycW/K6b6d
	 odmEw4pJFcEsWiIhm5nEkLU6j9NJ3NvtcynPPsPba82VBlYjU+Yn6GRFhMSx9A3Mlj
	 CFZk4LvEE9VWxzXd7+LWgK974YaCCuQBcoDuyN2xbBVUq92UmZ4tBP1kzab3xyCRXh
	 9TtDR2JkNDlzA+qzPx+q+FodPuai8mdaiUuKmyf4vaLdgTpPpTmdqgeqtOB33OnJ1N
	 EzVt03EkoHIOw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33AA58022B; Thu, 19 Dec 2024 19:35:03 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB6B28021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ON0HnKqe"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BC7F3101ECB02; Thu, 19 Dec 2024 19:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734633295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4yg0wmRaIMvuL1gtSipNVG/dzK2j2fvqiR4bdKmjb0=;
 b=ON0HnKqeP2xPy2b/0kwUKSluRQ4b6JT2fVGaUkZAfcJbTLbyFGGLCSkx81n/+86uViKDBE
 vGk6ghUpyx/992uFym1EZRnU7P9WHJn7sX5e63XKMWWnQkTkhKbcCvqFOTqClgsjIhEAr7
 J8agmdcCiDCl8FK7L1pD9tsY3P3zXv5xvwp1zilEqGq7bUKY2FZELBpTX2Y3wmO+lzpgo1
 HQG19O1sjBvMvShSxi1nvWw4Tewdf/6F+ugst5zB0P9Y4aSFTx7jlkAUuve+txLJ4tYWra
 C9AZCfccmWPsC80oXkvqVIJjkmUgij5w+uxQyx1Ggh89HDIk1HZOGs6imgqJ6g==
Message-ID: <fd67183b-c1a6-4e93-9b07-ac5fb8196d2b@denx.de>
Date: Thu, 19 Dec 2024 19:26:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] image: apply FDTOs on FDT image node without a load
 property
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>
References: <20241219-extlinux-relocate-dtb-when-dtbo-v1-1-fe5eeb8fd4f1@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241219-extlinux-relocate-dtb-when-dtbo-v1-1-fe5eeb8fd4f1@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 12/19/24 4:03 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> A FIT image which is NOT using -E when created by mkimage - that is with
> image data within the FIT - will fail to apply FDTO if the base FDT
> image node does not specify a load property (which points to an address
> in DRAM). This is because we check that the FDT address we want to apply
> overlay to (i.e. modify and likely increase in size) is not inside the
> FIT and give up otherwise. This is assumed necessary because we may then
> overwrite other data when applying in-place.
> 
> However, we can do better than giving up: relocating the FDT in another
> place in DRAM where it's safe to increase its size and apply FDTOs.
> 
> Suggested-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Tested with extlinux with:
> - conf node with multiple fdt entries
> - conf node with base fdt + conf node with fdto (stored in fdt property)
> - FDT image node with load property (behavior unchanged)
> - FDT image node without load property
> 
> I'll be frank, I don't really know what I'm doing here and I'm on
> holidays for a month in a few hours, so take this with a bigger grain of
> salt than usual (hence the RFC). It works (tm) for now.
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> ---
>   boot/image-fit.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 7d56f0b5e6ed39a75e029b09dc95d605835c0f91..088482c4d5d2e194cce66f10b0acd9e586f826b2 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2392,13 +2392,18 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>   	image_end = addr + fit_get_size(fit);
>   	/* verify that relocation took place by load address not being in fit */
>   	if (load >= image_start && load < image_end) {

This has to be updated to handle the mkimage -E case too. Basically, if 
the FDT is outside of the fitImage tree area, but still in the trailing 
blob area at the end of fitImage generated with mkimage -E, then any 
modification to the DT which would result in resize may either fail or 
corrupt the surrounding blobs.

The safe but heavy handed option would be to relocate unconditionally .

> -		/* check is simplified; fit load checks for overlaps */
> -		printf("Overlayed FDT requires relocation\n");
> -		fdt_noffset = -EBADF;
> -		goto out;
> -	}
> +		/* Cannot overlay an FDT stored inside the fitImage, so let's relocate */
> +		char *of_flat_tree = map_sysmem(load, len);
>   
> -	base = map_sysmem(load, len);
> +		len = ALIGN(fdt_totalsize(load), SZ_4K);
> +		if (boot_relocate_fdt(&of_flat_tree, &len)) {

Please print the error value in case of failure here, it is useful for 
debugging.

> +			printf("Required FDT relocation for applying overlays failed...");
> +			fdt_noffset = -EBADF;
> +			goto out;
> +		}
> +
> +		load = (ulong)of_flat_tree;
> +	}
