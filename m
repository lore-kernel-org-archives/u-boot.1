Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95BFD2C544
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA4788F4B;
	Tue, 22 Oct 2024 14:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="peQEOXf8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E914E88F4D; Tue, 22 Oct 2024 14:25:35 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA8888E78
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so5358804f8f.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729599933; x=1730204733;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BN1cq1ezvaxG8SfZXlwBk9V9+LLKWRfaF8sFXT4q+VI=;
 b=peQEOXf8lus7vkNhw1oL3RNBTNJTpzGDWCJuIzlap5VTcAFeogx7iFHmSQs9wos7IQ
 pNfPKYQWDP7K2V+6WARgvtsqKW/Uw1yqUt+EhFcZC4OKvBXrPU8Dtc35DjDJTQKliOW0
 nFeR6YKy0t08DBlPoOAa7Tc3becZasbz4r53VFM538PYxUPXyj0dbCKC1KBzgE0tecwc
 iHpNvxJ+yPOvM24GxU2oIVjJsba4Mto4p2PDn2Ln1ZodDyix1OGM+cvIudI94VBVUK5Q
 YmhLl/dBs4aozRTfw0OsxSuPdVcyLR5MTl7Xzn3QAjcMP2jjP3t2q4qPc1ytcrKLc/+B
 0/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729599933; x=1730204733;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BN1cq1ezvaxG8SfZXlwBk9V9+LLKWRfaF8sFXT4q+VI=;
 b=SIACoOMf2iVuGI53mZvhMRs3jvd1houh4nOGG/LmPySpL5D1yOG3DUEj567Plr5yvj
 WeD7XJWiq8sON6rOQG0dLuflJLRHO92FqOgXZ2aBdyMXd8GZiAt3ZfgRVIImg9LALLIF
 eWWdkY8NjTdNeqqUBQ0j8xwHgWORHAd6mbzal4FPH9g9jDAi+Tw7LJ8PXkWcoydARup3
 L/qNS9CnzUQY2ldV8jub8fJqk51HrHE8CWsiuPlOInEHB34sPSeyNvmzbfD8HgtsGVUr
 YFi0uhSFsouY5+DbDPh/Bx7JhPMWTMmhNAk/lkllO1cmee4R+n9CQkrT1D12ltklMFg5
 Ypog==
X-Gm-Message-State: AOJu0YzQDmiv/33/gPTSl+Ql4LIkDYTVNqtA2uMvS5HgkrgDgj34oC7p
 XhsFY5p34YYiJu/zQatbQQmwS7S9yi3ZtOBYezu5j8WhYX+yruPoZKMo2meqFsI=
X-Google-Smtp-Source: AGHT+IFHRoAkrwpTQgIZQ6fMn3C8qngS1fJEMk+tgfz0Pm4NBpc+T2sVMEupX+2OQyEbLkF8FDdJFA==
X-Received: by 2002:a5d:4f84:0:b0:37d:46fa:d1d7 with SMTP id
 ffacd0b85a97d-37eb486acc3mr12691485f8f.57.1729599933201; 
 Tue, 22 Oct 2024 05:25:33 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d6ef1sm330077566b.38.2024.10.22.05.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 05:25:32 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Guillaume La Roque
 <glaroque@baylibre.com>,
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com,
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
Subject: Re: [PATCH 3/6] configs: khadas-vim3{l}: fix userdata size
In-Reply-To: <20241017-adnroidv2-v1-3-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-3-781c939902c9@baylibre.com>
Date: Tue, 22 Oct 2024 14:25:26 +0200
Message-ID: <874j54wci1.fsf@baylibre.com>
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

Hi Guillaume,

Thank you for the patch.

On jeu., oct. 17, 2024 at 18:10, Guillaume La Roque <glaroque@baylibre.com> wrote:

> After increase boot and recovery partition userdata was not resize.
> so on VIM3 16GB and VIM3L `fastboot oem format` or `gpt write mmc 2
> $partitions` fail because end of last partition is outside of eMMC
> size.
>
> Remove 64MB on userdata partitions to fix it.
>
> Fixes: ce138d9742bf ("configs: khadas-vim3{l}: Increase boot/recovery
> partition size")

nitpick: Fixes should be a single line.

> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

When making the patch, I was not aware that VIM3 had 2 models with
different eMMC sizes:
- VIM3 (Basic) with 16GB of eMMC
- VIM3 Pro with 32GB of eMMC

I of course have the VIM3 pro so I did not notice this regression.

Sorry about this.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  include/configs/khadas-vim3_android.h  | 4 ++--
>  include/configs/khadas-vim3l_android.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
> index fc89efb4c36e..0e2953fe71b3 100644
> --- a/include/configs/khadas-vim3_android.h
> +++ b/include/configs/khadas-vim3_android.h
> @@ -24,7 +24,7 @@
>  	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
>  	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
>  	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
> -	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
> +	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  #else
>  #define PARTS_DEFAULT \
> @@ -37,7 +37,7 @@
>  	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
>  	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
>  	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
> -	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
> +	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  #endif
>  
> diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
> index 5b2aed1cf62a..f39a3782d663 100644
> --- a/include/configs/khadas-vim3l_android.h
> +++ b/include/configs/khadas-vim3l_android.h
> @@ -24,7 +24,7 @@
>  	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
>  	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
>  	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
> -	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
> +	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  #else
>  #define PARTS_DEFAULT \
> @@ -37,7 +37,7 @@
>  	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
>  	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
>  	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
> -	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
> +	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  #endif
>  
>
> -- 
> 2.34.1
