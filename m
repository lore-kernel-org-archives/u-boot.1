Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFC4C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 15:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 189BB8206E;
	Fri,  4 Jul 2025 17:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Si5SyXKB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E4278277D; Fri,  4 Jul 2025 17:34:04 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA36803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 17:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60867565fb5so1716708a12.3
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751643240; x=1752248040; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dcwEFlG2BzurLgTlS1TynmqJwRgUeG6tKXB21J93T8Q=;
 b=Si5SyXKBernwa28LQTINfmzOY5WuXjTRaUbuEVJEP3FFgbrei8zzuBh2PcGlx+pjVG
 uT9xkAxfWEv0XdMakpP0ANYBvOtBOr4XyB53zQ1sgJ2KUaYqFNsfmOijhSnofFtBZKGn
 9w8LuxYLMw3RlUv4caP5jOcrTz+MltgxlSq8uaDFDgd9bQpYLxEqa2nT993QlNkRH4fz
 vLnjkF9GaBu2nXGyTm7khHW3J7zWe0t1qfvxA4Rm26d19hqJYsT5jHUxXQB0Zz6KOHMw
 7x7831pPMJYP2SFQ3H9Je8BTyj+9044yHv6+/jKmTo7WE8vjRiKlqtQ3c64+wQZuYTI+
 0H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751643240; x=1752248040;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dcwEFlG2BzurLgTlS1TynmqJwRgUeG6tKXB21J93T8Q=;
 b=fzYDJAYxkOcUPKCDXrJc6is5lYJwHdE7Qa0K8r4tNa71xhDA/9aXnwcIJWrT2Uhgsm
 cPQT/F3JxMgVVTfG4v9XMVTPQFRpJWhbnvnfisEhUoZ3KD6oi4U9SVIQWgYEVcbzQZpV
 P3j+hxjwe5BI9iTBNrZfGSj6lsCKOrfB1ze3EYt4NErRswCmutbPMFmE3v6+toegWx8F
 OZ+PRAOfSLRjXrhHIPx4JCfR1IMSBIobqYMsYOixQ0wEXm+EJUsOc0WgLOm6xun6yHe6
 p83yi34aGQ2l20Jd5NMI/amPRb+G6FrLLzjsnIk5268bLv2u7h+r/BxixwrKieAdJG2+
 DCmw==
X-Gm-Message-State: AOJu0YwTn8OJmln6Nt5pbOLiBesBuxTMPrFHDVjzfnRBVwMurfgAJfVe
 ypIsS30yeW1D6NSRb7fULCKOFF8lyB2MWM8AXLX5Fx2PMeYY39JkXK/M/jeYStgvLX5FF2EZ1e8
 UdfAY0/9AOQ==
X-Gm-Gg: ASbGncuwSw1q2qX1ANUgjiO15mixDHu937gF64JZTfis7iOy6jxFVIo4I3bSC57H0o0
 U5zK1l275JU6g4rKp7YFlj3q5SC4AILE4fVm2XweAYKTn9OHbt2GFeYPxoRdD88UqF8a2sXyASW
 cTaG5t5xjAjLXU5XbsJGOkT7GO81K7nwuLMb3YderSKPEllUAZ+/73sGFx5IwWA5kWzeRbt+0Io
 0NK3DY/upvMkObMsmduzeF+UxgBKUec7UMS4W0AZAmQCOZAMYt3Zo/x9h2QxUhyXVrRIsfwc6/O
 cvsIhQWdQ2J7Mz8ALhCCPpiQD7k/LKCb9S1aZLXgD6GiR8bYXd2PqcLpe0/m3rofZByq+XjBdCB
 m4ZUP8qxgVFfCeM7bERoukR7z1WjUvVZ6F6xmjJHjeQ==
X-Google-Smtp-Source: AGHT+IG9N/Qnf+tdWx1kmJlAAMEnsl/1n3BVxyTz38aKhX0BOvXRix506EZmyBieMA3q+gt5r16m4A==
X-Received: by 2002:a17:907:3f07:b0:ae0:b3be:f214 with SMTP id
 a640c23a62f3a-ae3fbc56d8bmr311175766b.9.1751643240226; 
 Fri, 04 Jul 2025 08:34:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:713c:93e8:d764:c0f8?
 ([2a01:e0a:3cb:7bb0:713c:93e8:d764:c0f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6ac67bbsm192936166b.96.2025.07.04.08.33.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 08:34:00 -0700 (PDT)
Message-ID: <a310530f-7768-41fe-abda-91ef5fda9c4a@linaro.org>
Date: Fri, 4 Jul 2025 17:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mx6sabresd: Reduce U-Boot proper size to fix boot
 regression
To: Fabio Estevam <festevam@gmail.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de, otavio@ossystems.com.br,
 michael@amarulasolutions.com, uboot-imx@nxp.com
References: <20250704144022.3946416-1-festevam@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250704144022.3946416-1-festevam@gmail.com>
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

Hi Fabio,

On 7/4/25 16:40, Fabio Estevam wrote:
> The mx6sabresd U-Boot proper binary size has grown beyond the 
> CONFIG_BOARD_SIZE_LIMIT.
> 
> Reduce its size by removing the CONFIG_MULTI_DTB_FIT, BOOTM_PLAN9 and
> BOOTM_RTEMS options.

FWIW, I'm working on a better fix than commit 410d59095a9f ("arm: kirkwood:
fix freeze on boot") for the LTO link issue that appeared when I made the
static initcalls series. Instead of disabling LTO for common/board_{f,r}.c
I will instead move th e problematic inline assembly code to separate .S
files. The idea is to get rid of the selective LTO disabling (there are
others places which do that) and at the same time to not force -marm on
some C files that could totally be compiled in Thumb/Thumb2 mode if it
weren't for this inline assembly with mrc/mcr instructions. In other words,
let the compiler and linker do their job. While it could cost a few bytes
in some cases compared to inlining, I also expect meaningful reductions in
other cases. It will all depend on arm vs. thumb and LTO vs. no LTO.

Anyway, I looked at the impact of my series on the binary size for mx6sabresd.
Good news, it does save 1702 bytes:

$ git log --oneline -n 4
306a6f7adf8 (HEAD -> lto-fixes-tmp2) arm: do not force -marm on some C files and allow LTO everywhere
1680ed4cbb2 arm: move inline assembly CP15 instructions to separate .S files
018263f9278 Revert "arm: asm/system.h: mrc and mcr need .arm if __thumb2__ is not set"
7027b445cc0 Merge tag 'efi-2025-07-rc6' of https://source.denx.de/u-boot/custodians/u-boot-efi
$ tools/buildman/buildman -b lto-fixes-tmp2 -c 4 --step -0 mx6sabresd
$ tools/buildman/buildman -b lto-fixes-tmp2 -c 4 --step 0 -sSd mx6sabresd
Summary of 2 commits for 1 boards (1 thread, 24 jobs per thread)
01: Merge tag 'efi-2025-07-rc6' of https://source.denx.de/u-boot/custodians/u-boot-efi
04: arm: do not force -marm on some C files and allow LTO everywhere
       arm: (for 1/1 boards) all -1702.0 data -4.0 rodata -514.0 text -1184.0
            mx6sabresd     : all -1702 data -4 rodata -514 text -1184
(no errors to report)

So stay tuned for more on this. When the series is ready I will post it for
review with a link to the buildman size stats for all plaforms. It should
happen next week.

Regards,
-- 
Jerome

> According to doc/README.multi-dtb-fit:
> 
> "Usually the DTB is selected by the SPL and passed down to U-Boot. But some
> platforms don't use the SPL. In this case MULTI_DTB_FIT can used to provide
> U-Boot with a choice of DTBs"
> 
> mx6sabresd uses SPL, so MULTI_DTB_FIT can be safely dropped as the DTB
> selection in SPL is done by board_fit_config_name_match().
> 
> Tested boot on the imx6dl and imx6q variants.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  configs/mx6sabresd_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
> index f041f1fd1a3b..312af2f57fde 100644
> --- a/configs/mx6sabresd_defconfig
> +++ b/configs/mx6sabresd_defconfig
> @@ -40,6 +40,8 @@ CONFIG_SPL_WATCHDOG=y
>  CONFIG_HUSH_PARSER=y
>  CONFIG_SYS_MAXARGS=32
>  CONFIG_CMD_BOOTZ=y
> +# CONFIG_BOOTM_PLAN9 is not set
> +# CONFIG_BOOTM_RTEMS is not set
>  CONFIG_CMD_SPL=y
>  CONFIG_CMD_SPL_WRITE_SIZE=0x20000
>  CONFIG_CMD_GPIO=y
> @@ -65,7 +67,6 @@ CONFIG_EFI_PARTITION=y
>  # CONFIG_SPL_EFI_PARTITION is not set
>  CONFIG_OF_CONTROL=y
>  CONFIG_OF_LIST="imx6q-sabresd imx6qp-sabresd imx6dl-sabresd"
> -CONFIG_MULTI_DTB_FIT=y
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_ENV_IS_IN_MMC=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
