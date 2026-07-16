Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5383C4450A
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 08:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C82784B06;
	Thu, 16 Jul 2026 10:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QRl6QByh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21B584C2A; Thu, 16 Jul 2026 10:25:18 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D766D849A1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 10:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493d92b7db3so22777615e9.2
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 01:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784190316; x=1784795116; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QSljYgkPRjNRTWEyMdZyOi4lELrikwgg7IwL+em0dW4=;
 b=QRl6QByh/v5SKQOUWYBmRmHlNvpseQA19n//Mh40/jBJoWqKnINsTdVWO9C47SYajb
 WG7carnX/d6dtQ2s+ps3yUtWAhmqsGMNoXY4ODjMi11R5g8/gn1ifaPrj1URg3y58zgD
 CIzDThSVIb4UFtMwG1byITfIYQhbHtvFi0lwPVpZRJIzaTnXILVbKo9HM2ET6m2bKj+G
 eVH5yR6NMYol6v+J+E5iOiuHhobqPKvarGuDrbrQYko/Wna1vi3K4Y8gJJy9Fcrjuuwh
 tMR8WKvVp1n04ACKd7p4OMmvN+5+4zy3JR/gbgEPmWW0VO8SDBaxTc16AlJGih+q4ZdQ
 fM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784190316; x=1784795116;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QSljYgkPRjNRTWEyMdZyOi4lELrikwgg7IwL+em0dW4=;
 b=mBvjjoMdboRCc4N/gqt/QC+B11MbIimdiFQQNQhyVWaRmsKITBTXuh/vzaAnGANB7O
 SLRGTTjQKlfPWVmIITZms+ug0ejUGuZY3jstBe27PVTeaYOUPbnxz4pkOo5VQ9qHwkcu
 je+y+L9NcDQGjCzO9Ga1qFUcp+WTh75SONg4xZLjELL9ICmSVqqTL/mvHzq5lE5pNaCQ
 8yoOHtEHn2v1JOYy/M9GcxSeDKIMJ/IK+19PFpUXDAzkMDbXv9Kcee130k7I/f2TTDwX
 rLRz0iP+oRbgX8Z2MZj4PNSc7P9n349Vy8ZJjfIBHIr4E6+IgbqLY5IJlz8s3gqI0Rkh
 bpmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXXVbbxaza0xnIQYx4ca6VX1gecfnZM8jv3/HZ6D3x4hmaz/aWpITHDpTFU8S2DXG4qOYNMEg=@lists.denx.de
X-Gm-Message-State: AOJu0YwrFz2Kgq7x1zf7wycGuI2/PxhJ96JJwPLnNCsIQonYBex40TCG
 423Amjz4+Yj3HIG1cwaEm8zkaDvpT97zAyfAhkJVGcYi5BaePhQdbt5c
X-Gm-Gg: AfdE7cmYjwGfJgS39s7eleR2/ziIG6OqH3xCpMVgGCDmJIzNFiJndWfYbVAX3mHLWjn
 5+OmHv5LAzthCov3/PJr8dkT3FI05J6ff2zkF0jz99jWkAaznOqt5cj3BMtS24Jf82P1r34FAZb
 /NJznZSyAc8BUbVZrUf2ma6H0RDLS98lMvwrSwoaJNLANPERsCM8vacjWobqnUmGToKu8JavnyO
 t1STAaszqxKF1rmNuDCLzVQcFobI7b5Sm5ChrUQUh0FUXDu28UnBEKGUg6UTk1sp3fglP4YTm0y
 ftaReBgPfRH1Hi3+R/bVnGlVWvOC4XlD9tNnO3Od5i43uEHFaoLt0YH8SXWn9LrnWaMqVYdAUcJ
 Kmou5oNMKQaeBfxmTZdapvroSq84e19UiP/SRNfK3jCk09kAOs2y9vADSjPcVqOLknhMBMgGWtp
 FadYUeB3bsfzKQQerGP4sFyCbqqumK/oeWRHDn0Dz2mfKIaf+KaJzLNOQ=
X-Received: by 2002:a05:600c:a03:b0:495:4572:21af with SMTP id
 5b1f17b1804b1-4954572224dmr1636375e9.9.1784190316064; 
 Thu, 16 Jul 2026 01:25:16 -0700 (PDT)
Received: from [10.251.229.160] (93-33-47-40.ip42.fastwebnet.it. [93.33.47.40])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541e9ee07sm44964345e9.15.2026.07.16.01.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 01:25:15 -0700 (PDT)
Message-ID: <e1a26574-4f7d-46f0-b757-55f419df326b@gmail.com>
Date: Thu, 16 Jul 2026 10:25:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: image-fdt: downgrade -EINVAL reservation failure to
 debug
To: Joseph Guo <qijian.guo@nxp.com>, Simon Glass <sjg@chromium.org>,
 Randolph Sapp <rs@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
References: <20260713-downgrade-v1-1-183a2300741b@nxp.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <20260713-downgrade-v1-1-183a2300741b@nxp.com>
Content-Type: text/plain; charset=UTF-8
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



On 7/13/26 10:45, Joseph Guo wrote:
> When boot_fdt_handle_region() attempts to reserve a DTS reserved-memory
> region via lmb_alloc_mem(), it may receive -EINVAL if the region's
> physical address falls outside the LMB-managed memory range (i.e.
> below PHYS_SDRAM on platforms where U-Boot does not manage the lower
> DRAM window).
> 
> A typical example is platforms like i.MX95 where PHYS_SDRAM starts at
> 0x90000000, but remoteproc/rpmsg carveouts (vdev vrings, vdev buffer,
> resource table) are placed at 0x88xxxxxx by hardware convention. Those
> addresses are unreachable by U-Boot's allocator anyway, so failing to
> mark them reserved has no practical consequence -- U-Boot will never
> accidentally place the initrd or FDT blob there.
> 
> Printing ERROR for a condition that is harmless and expected on many
> platforms is misleading. Downgrade the -EINVAL case to debug() to
> suppress the spurious output while preserving full visibility under
> DEBUG/log builds.
> 
> Real failures (e.g. -EEXIST from an overlapping reservation) continue
> to be reported as ERROR.
> 
> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
> ---
>  boot/image-fdt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 9e0e0f93edd34ae9056926883b1a802858e179d9..2175fa338f55110862100fa9f491a0957e85ce56 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -95,6 +95,9 @@ static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
>  		debug("   %s fdt memory region: addr=%llx size=%llx flags=%x\n",
>  		      free ? "freed" : "reserved", (unsigned long long)addr,
>  		      (unsigned long long)size, flags);
> +	} else if (ret == -EINVAL) {
> +		debug("   skipping fdt memory region outside LMB range (addr=%llx size=%llx flags=%x)\n",
> +		      (unsigned long long)addr, (unsigned long long)size, flags);
>  	} else {
>  		printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
>  		       free ? "freeing" : "reserving", (unsigned long long)addr,
> 
> ---
> base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
> change-id: 20260713-downgrade-f8319ab2d75b
> 
> Best regards,

Hi Joseph,

Tested on Toradex Aquila iMX95, which has reserved-memory regions for
the Cortex-M7 (vrings, vdev buffer, resource table) below PHYS_SDRAM.
The spurious ERROR messages are gone and boot is unaffected.

Kind regards,
Emanuele

Tested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
