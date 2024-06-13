Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13263C27C6E
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 18:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 483C888928;
	Thu, 13 Jun 2024 20:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kV6b2Vtp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C00C88918; Thu, 13 Jun 2024 20:43:43 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BD9688910
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 20:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-35f089e35e7so986010f8f.0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 11:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718304220; x=1718909020;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mgBfreDILBnWEbiQRpWm4aJ5E2CjPqyOsSMy5VzFuSo=;
 b=kV6b2VtpI+rxGu9G8+JXu1lLhC9x+L5JBfZmt0C8JitNAZc486w02Q0yOA0M/PENAY
 GFH9IeeoBO4rKE6d/HKrDBg7gYWXfHL0oo1ty0Xm0KnP0ir/RrBfpfY1mxzH3S1tSqY9
 e4GmsOXDX+o5Brf0Ll+65dwGeNqfphd8HtslKe9Jic9pLx8ZYsUMnKILl9hOXrmI1mwe
 chvLwHk/XG9qgtXKNBBvsM4526vbvcHg1KLOsff7oLuGEJOu82nAj3snuTrLHB8pV+sr
 f2SeIXY6/da7drdmBw/ZuJMnM38+S2/6fvDJ56Ax7Y1VbOzcpnv/RQqp7C+wA+4BzIJI
 QK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718304220; x=1718909020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mgBfreDILBnWEbiQRpWm4aJ5E2CjPqyOsSMy5VzFuSo=;
 b=WRxxsbaMEa2aCl3CdG2Gd029aaZn4xC2JSEOiiLkPpZdVkMdkp+5kSUaSg+tt0v8+i
 sjJyZ7ssrhmg+a1m+yGJYsvnzrTDa/lY8Am9mMAUQeBUAjdkZ0ZGcMq86hN8pdy5kIRF
 v+5pNRA7LFtqmOflnFoefM0xtkAroUT6Ho9t1FGC/KV0v5mmHHKyCRqqq+ZwgZzaXyiz
 FsLnueMVSU74OXMORi2xVhg2rS25RJ3yB7F14I9BCsjSfBK96rKIXutEOxvvFKD19/nA
 oft0nSkYDy64hKICuoqdm4Q34BtgqV9dmhImQ1i1P98/Db6WYdoeTfBofqkZvkosC2wR
 UMCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHn76et3JAdaV/wSMc3fKm7YeJXBQSu+bzXVIYnYV0uPJA8SyHge82hoIKJux+rCTZgcwVOP0iVGLSBDYfVwqUmRdK9Q==
X-Gm-Message-State: AOJu0YyFQmTrhGmHKreWYYRCwERhkl3kEDyXYseao7SBE2awtRxbToCG
 WuB+G5jBpwqG2EZaLrrDxQ5E1oXkrs4QZUC3dnGB7XmefS8h54YqMu9v67ZN0LI=
X-Google-Smtp-Source: AGHT+IGlp3GXwe5F68mEBG7GfgN1z+/MJ8ySQsp1V88VQ4Bd1o6708EibwmmxdzeHCe4Xtuz4Wx8dg==
X-Received: by 2002:a5d:56d2:0:b0:360:76b4:6382 with SMTP id
 ffacd0b85a97d-3607a7b35b5mr350076f8f.4.1718304220461; 
 Thu, 13 Jun 2024 11:43:40 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:c6c5:f5c5:a789:215?
 ([2a05:6e02:10a5:e010:c6c5:f5c5:a789:215])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c79bsm2465335f8f.41.2024.06.13.11.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 11:43:40 -0700 (PDT)
Message-ID: <de8deb7f-7705-43b6-acfe-c031731f16eb@baylibre.com>
Date: Thu, 13 Jun 2024 20:43:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] boot: android: Provide vendor_bootimg_addr in
 boot_get_fdt()
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
 <20240613-bootmeth-android-v2-1-397f6e66eb29@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20240613-bootmeth-android-v2-1-397f6e66eb29@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi,

Le 13/06/2024 à 12:13, Mattijs Korpershoek a écrit :
> When calling android_image_get_dtb_by_index() using boot image v3+,
> we should also pass the vendor_boot ramdisk address.
>
> Use get_avendor_bootimg_addr() to do so.
>
> Notes: on boot image v2, this is harmless since get_avendor_bootimg_addr()
>         returns -1.
>         for legacy implementations that don't have CMD_ABOOTIMG, add a weak
>         implementation to avoid linking errors.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   boot/image-android.c | 5 +++++
>   boot/image-fdt.c     | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index ee626972c114..09c7a44e058a 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -56,6 +56,11 @@ static ulong add_trailer(ulong bootconfig_start_addr, ulong bootconfig_size)
>   	return BOOTCONFIG_TRAILER_SIZE;
>   }
>   
> +__weak ulong get_avendor_bootimg_addr(void)
> +{
> +	return -1;
> +}
> +
>   static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3 *hdr,
>   					       struct andr_image_data *data)
>   {
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 56dd7687f51c..8332792b8e80 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -502,7 +502,7 @@ int boot_get_fdt(void *buf, const char *select, uint arch,
>   		 * Firstly check if this android boot image has dtb field.
>   		 */
>   		dtb_idx = (u32)env_get_ulong("adtb_idx", 10, 0);
> -		if (android_image_get_dtb_by_index((ulong)hdr, 0,
> +		if (android_image_get_dtb_by_index((ulong)hdr, get_avendor_bootimg_addr(),
>   						   dtb_idx, &fdt_addr, &fdt_size)) {
>   			fdt_blob = (char *)map_sysmem(fdt_addr, 0);
>   			if (fdt_check_header(fdt_blob))
>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

