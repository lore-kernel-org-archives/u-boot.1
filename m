Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D71C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 13:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7E7A88758;
	Thu, 18 Jul 2024 15:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iqlWUbAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9797088A76; Thu, 18 Jul 2024 15:54:28 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A2728874C
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 15:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e026a2238d8so885318276.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721310865; x=1721915665; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=29751J7wtABTY0ZbYzFs6TMGQ7iTt9LYqCSc65bdd5w=;
 b=iqlWUbAycf3X0bGpj/84GdUhc1fzl33wOB/pwYZA3a2g5e+vfDwuANCgWOTbiTnQjh
 R0W9rDZEPRYnYybxSg41AHUc7ViQsfR4RvzoWQKQxj5m6zJbDlnwxoj1IblzV6tUxC4B
 OZjK4sKLQTjm9IBBlFbHEkwsDVKiavMbv50H4ybUDPLdDSbeBmXkEQCGNJA2ObdV+qn0
 lOyxNj4pfHicP1VfByZ8imCjtrmXedbLKohJpSEhe8mYVl+zv3TcHOCHSMe9Nn5K2Mhb
 5wpz2O1YeK/3KHsvg7YblwPl3GsZjPG3PUSD5fnmOSr7fbUSbX+PUYP/9Sb6l49ziqJJ
 +kVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721310865; x=1721915665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=29751J7wtABTY0ZbYzFs6TMGQ7iTt9LYqCSc65bdd5w=;
 b=wrq41VTUEeMdEGSnQcVjEKMyowHEv/lIhnkDx/9rCLtJx3T+c3QyoizN8HNtyIb6Bc
 RtyY0SabjC75oIU0aIWFk3H394XAUhlaROqtBbvLzN1y/1DinQ/qV0oIpf/qfJLGQbLh
 Ari3tYXS/L7dTgnECwz3Li/33mRtHKkvMtxrJfmybZu4dY+tEnKt/FoutZrriw3ebwPC
 gZuqxueXjW1GxYFwFZ2cjKOIDs4dNGEkLx6TmD2OOuBGKJmGjsyTxqEEAwWvAMoEGN+M
 8ItNBghoNz8cHHPVyPPFYOB73ntLE/h28Hjtwl7MQ7TJyRVj4pQ1lUlSbojF2LA3Daxx
 c+Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr4zWu/kVwjCNuk2IFGcIXTYWY39jvwuDQ6AEJyYew1mY+dPm1OkfWy9ug02tiAHl54chgKMLSEOkXPnKc8opeMjJ0xg==
X-Gm-Message-State: AOJu0YxYZlS9DTJfq1O7kDFiCaanFTZ3cGPwcyjFAe0ClMKp/p1saHrv
 MgIcSXsvYSb8OpNDk7V+6u+GAIihZg/ZdZVi3/i8WlRcB9I77Y1p
X-Google-Smtp-Source: AGHT+IF2bdl/vdAjf6n+by0U8HjhYCcz2Q+RHk5DlfYYW45MkU6gd815+Cb5U7T/vcSB+a2P9382hQ==
X-Received: by 2002:a05:6902:13c9:b0:e05:ff2a:aa49 with SMTP id
 3f1490d57ef6-e05ff2abefdmr3071876276.30.1721310865142; 
 Thu, 18 Jul 2024 06:54:25 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b79c66d305sm8151476d6.140.2024.07.18.06.54.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 06:54:24 -0700 (PDT)
Message-ID: <325e6cc7-8210-8e95-0267-10d84192a406@gmail.com>
Date: Thu, 18 Jul 2024 09:54:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 15/21] spl: Plumb in the Universal Payload handoff
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
References: <20240713070055.2172883-1-sjg@chromium.org>
 <20240713070055.2172883-16-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240713070055.2172883-16-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/13/24 03:00, Simon Glass wrote:
> Specify the FIT and include information about each loaded image, as
> required by the UPL handoff.
> 
> Write the UPL handoff into the bloblist before jumping to the next phase.
> 
> Control this using a runtime flag to avoid conflicting with other
> handoff mechanisms.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Hang when something goes wrong, to avoid a broken boot
> - Add a runtime flag to enable UPL
> 
>   common/spl/spl.c                  |  8 ++++++++
>   common/spl/spl_fit.c              | 22 ++++++++++++++++++++++
>   include/asm-generic/global_data.h |  4 ++++
>   3 files changed, 34 insertions(+)
> 
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 7794ddccade..d6a364de6ee 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -810,6 +810,14 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>   			printf(SPL_TPL_PROMPT
>   			       "SPL hand-off write failed (err=%d)\n", ret);
>   	}
> +	if (CONFIG_IS_ENABLED(UPL_OUT) && (gd->flags & GD_FLG_UPL)) {
> +		ret = spl_write_upl_handoff(&spl_image);
> +		if (ret) {
> +			printf(SPL_TPL_PROMPT
> +			       "UPL hand-off write failed (err=%d)\n", ret);
> +			hang();
> +		}
> +	}
>   	if (CONFIG_IS_ENABLED(BLOBLIST)) {
>   		ret = bloblist_finish();
>   		if (ret)
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 2a097f4464c..b288f675ae3 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -12,6 +12,7 @@
>   #include <memalign.h>
>   #include <mapmem.h>
>   #include <spl.h>
> +#include <upl.h>
>   #include <sysinfo.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> @@ -645,6 +646,8 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
>   		printf("%s: Cannot load the FPGA: %i\n", __func__, ret);
>   		return ret;
>   	}
> +	upl_add_image(node, fpga_image.load_addr, fpga_image.size,
> +		      fdt_getprop(ctx->fit, node, FIT_DESC_PROP, NULL));

Does load_addr even make sense for FPGAs?

And I noticed that you always call this after load_simple_fit/fit_image_load.
Could we call upl_add_image in those functions instead?

>   	return spl_fit_upload_fpga(ctx, node, &fpga_image);
>   }
> @@ -768,6 +771,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
>   	if (ret)
>   		return ret;
>   
> +	upl_add_image(node, spl_image->load_addr, spl_image->size,
> +		      fdt_getprop(ctx.fit, node, FIT_DESC_PROP, NULL));
> +
>   	/*
>   	 * For backward compatibility, we treat the first node that is
>   	 * as a U-Boot image, if no OS-type has been declared.
> @@ -811,6 +817,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
>   			       __func__, index, ret);
>   			return ret;
>   		}
> +		upl_add_image(node, image_info.load_addr, image_info.size,
> +			      fdt_getprop(ctx.fit, node, FIT_DESC_PROP, NULL));
>   
>   		if (spl_fit_image_is_fpga(ctx.fit, node))
>   			spl_fit_upload_fpga(&ctx, node, &image_info);
> @@ -847,6 +855,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
>   		spl_image->entry_point = spl_image->load_addr;
>   
>   	spl_image->flags |= SPL_FIT_FOUND;
> +	upl_set_fit_info(map_to_sysmem(ctx.fit), ctx.conf_node,
> +			 spl_image->entry_point);

I think this should be virt_to_phys, since we aren't really mapping it.

>   
>   	return 0;
>   }
> @@ -891,6 +901,9 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
>   	if (ret < 0)
>   		return ret;
>   
> +	upl_add_image(ret, fw_data, fw_len,
> +		      fdt_getprop((void *)header, ret, FIT_DESC_PROP, NULL));
> +
>   	spl_image->size = fw_len;
>   	spl_image->load_addr = fw_data;
>   	if (fit_image_get_entry(header, ret, &spl_image->entry_point))
> @@ -911,6 +924,9 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
>   	if (ret >= 0) {
>   		spl_image->fdt_addr = (void *)dt_data;
>   
> +		upl_add_image(ret, dt_data, dt_len,
> +		      fdt_getprop((void *)header, ret, FIT_DESC_PROP, NULL));
> +
>   		if (spl_image->os == IH_OS_U_BOOT) {
>   			/* HACK: U-Boot expects FDT at a specific address */
>   			fdt_hack = spl_image->load_addr + spl_image->size;
> @@ -940,7 +956,13 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
>   				     &img_data, &img_len);
>   		if (ret < 0)
>   			return ret;
> +		upl_add_image(ret, img_data, img_len,
> +		      fdt_getprop((void *)header, ret, FIT_DESC_PROP, NULL));
>   	}
>   
> +	spl_image->flags |= SPL_FIT_FOUND;

This change is unrelated and should be moved into a separate commit.

> +	upl_set_fit_info(map_to_sysmem(header), conf_noffset,
> +			 spl_image->entry_point);
> +
>   	return 0;
>   }
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> index 98d822530d8..37643a4bbb9 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -716,6 +716,10 @@ enum gd_flags {
>   	 * @GD_FLG_HUSH_MODERN_PARSER: Use hush 2021 parser.
>   	 */
>   	GD_FLG_HUSH_MODERN_PARSER = 0x2000000,
> +	/**
> +	 * @GD_FLG_UPL: Read/write a Universal Payload (UPL) handoff
> +	 */
> +	GD_FLG_UPL = 0x4000000,
>   };
>   
>   #endif /* __ASSEMBLY__ */

