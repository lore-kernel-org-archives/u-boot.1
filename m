Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCD1CF2560
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 11:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64DE888A1C;
	Sat, 12 Oct 2024 13:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xBB6sT4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DE8788B0A; Sat, 12 Oct 2024 13:02:53 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD7088901
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 13:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-430f6bc9ca6so21460925e9.2
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 04:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728730971; x=1729335771;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GWAWoBCHJnxRn52Hpf9Hg5abaWAn1l1/6xV3j1HmW2U=;
 b=xBB6sT4OIQB+9JlaF0oxQH5lzqJCrlEz6zZviTOxb3hcndCpU5vfI9ja7NlvzCf4h8
 mRh5uDM8IMEht72ArFC6Za7dLDLEspYStVk1XuQr2uq6oKBKVq+4rzUTtidcVPp5yVtS
 ReS2G12nyUb+Is+k+vCOnLlqKhUe46I5e9rrT6rSk2XEJSHLgXZVlKXWjFBHebhTeepH
 +7atRDJG4PK0xeed9jg1wcgxrw1VnC8L4OON1K0txZLwlw27YBNRTtnVDM/2xnphQqU7
 7mZv+4n7IoWayWmovr9nF6Jc8EWSV0tWhDxODFCL5FvpsT7c1kAnYXgoOqRkWzJpEkgd
 tZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728730971; x=1729335771;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GWAWoBCHJnxRn52Hpf9Hg5abaWAn1l1/6xV3j1HmW2U=;
 b=DitSUaMh6cQ/HxWNqoI1clCr8WsT520vujUI3pgjrKfrK172Oxpu9P0k6hawGtal8u
 tJLBlEkZdopHPiLP3sk+Uv3e1P/pPsXL6Z5e2+uybd9+QCvfnHWzWkARotP/UvEuchYt
 SmZwP6PltkenLZ2Wz9gYddHS8hUTLOBphjWNbTN35ujeOuwsMvaV2v0t+rqY2KHVr6ER
 CARi+XPyMFZTjeRmFzJn0+yHZ83/hHLJzW18lFtHGyiuXBMudrcm22XpEUmiShUovlrJ
 mJPTRq0S1WM8lAM2QGLgBx8ygUOf6vaXSdWEjTvLadJiAlYZnMZ73tr97vWSzw2Jz/4Z
 wUjw==
X-Gm-Message-State: AOJu0Yw6a+yx5ZV8/0CpllSFVfzzokMtm8L2QUdx2EktdsdloiZ2oVzM
 VvuBpExaMMgMVESIi5senxBiBItXlZOg/0sLjsW9Xb4Nx+gSgXJNnMFKOCkTVAk=
X-Google-Smtp-Source: AGHT+IGrUg5TxOrAxBXZeSB2JzXkNarik7rUhCa92BrjygbdI6M1rl0U8U4LE9wzR1ySJWKT5wxOtg==
X-Received: by 2002:a05:600c:3551:b0:42f:7717:ac04 with SMTP id
 5b1f17b1804b1-431255e2ca4mr20896035e9.16.1728730970439; 
 Sat, 12 Oct 2024 04:02:50 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:e40:30d4:b1ee:f034?
 ([2a05:6e02:10a5:e010:e40:30d4:b1ee:f034])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf45df4sm96997195e9.13.2024.10.12.04.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 04:02:50 -0700 (PDT)
Message-ID: <66b14071-50e6-4354-b398-028c99c60b06@baylibre.com>
Date: Sat, 12 Oct 2024 13:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: meson64_android: Remove dtbo support
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
References: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
 <20241011-yukawa-aosp-parts-v1-2-7d74aa13ff8e@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20241011-yukawa-aosp-parts-v1-2-7d74aa13ff8e@baylibre.com>
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


Le 11/10/2024 à 17:51, Mattijs Korpershoek a écrit :
> The device tree overlays are not part of the
> Android Common Kernel code [1]
>
> Historically, they existed to enable some Android specific
> features but they have been removed.
>
> Remove the dtbos logic since these files do no longer exist.
>
> [1] https://android.googlesource.com/kernel/common/+/ac2ea0bb91a3b5f5e71eba66c441e58beca6767e/arch/arm64/boot/dts/amlogic/
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   include/configs/meson64_android.h | 26 +-------------------------
>   1 file changed, 1 insertion(+), 25 deletions(-)
>
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index c0e977abb01f..fa520265800c 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -116,31 +116,7 @@
>   	"fi; " \
>   	"abootimg get dtb --index=$dtb_index dtb_start dtb_size; " \
>   	"cp.b $dtb_start $fdt_addr_r $dtb_size; " \
> -	"fdt addr $fdt_addr_r  0x80000; " \
> -	"if test $board_name = sei510; then " \
> -		"echo \"  Reading DTBO for sei510...\"; " \
> -		"setenv dtbo_index 0;" \
> -	"elif test $board_name = sei610; then " \
> -		"echo \"  Reading DTBO for sei610...\"; " \
> -		"setenv dtbo_index 1;" \
> -	"elif test $board_name = vim3l; then " \
> -		"echo \"  Reading DTBO for vim3l...\"; " \
> -		"setenv dtbo_index 2;" \
> -	"elif test $board_name = vim3; then " \
> -		"echo \"  Reading DTBO for vim3...\"; " \
> -		"setenv dtbo_index 3;" \
> -	"else " \
> -		"echo Error: Android boot is not supported for $board_name; " \
> -		"exit; " \
> -	"fi; " \
> -	"part start mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_start; " \
> -	"part size mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_size; " \
> -	"mmc read ${dtboaddr} ${p_dtbo_start} ${p_dtbo_size}; " \
> -	"echo \"  Applying DTBOs...\"; " \
> -	"adtimg addr $dtboaddr; " \
> -	"adtimg get dt --index=$dtbo_index dtbo0_addr; " \
> -	"fdt apply $dtbo0_addr;" \
> -	"setenv bootargs \"$bootargs androidboot.dtbo_idx=$dtbo_index \";"\
> +	"fdt addr $fdt_addr_r  0x80000; "
>   
>   #define BOOT_CMD "bootm ${loadaddr} ${loadaddr} ${fdt_addr_r};"
>   
>

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>



