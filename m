Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9DDC3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 14:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F6F088427;
	Thu, 18 Jul 2024 16:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O012jtm8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5945F882FA; Thu, 18 Jul 2024 16:12:57 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA2A8827D
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 16:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-44d1eb90522so1454741cf.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721311974; x=1721916774; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wxWw5dv1enFXWP4IBvpSJ1dxirxT7EtX8Zn1ZGJhpJg=;
 b=O012jtm8q+E6V9rlIxP35IM/k7466ETF3JoRrzY3lct7s0AqtJHHnBZxEGP9ZBbFAo
 54ur+xpmSabHWbXVNvYGgACfGpxgtfW+yUwoO6nJV2cdfwOVkXRgV57S3ZjHtGElhiZt
 l0hshLf8RHjVHg0hQ4IT87y7CPmsdLla9yGWRVHUFAiRvsNyOsBygOTiljKX/2SK8BY5
 z2OKgow15tFn18rr7vWjyGVQnpP1Qim15qkZ47dCNXBJqyANGWSMOXYdsA38rYxr+F81
 zuFepbNJCxpaclGwQt07qLdISfG/x9YFLsk8l/CjH4qI8nbIb9RZc8KnfCS+5ykd1OiT
 CmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721311974; x=1721916774;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wxWw5dv1enFXWP4IBvpSJ1dxirxT7EtX8Zn1ZGJhpJg=;
 b=dXM0DUVahome576Ac62sDeOJZl0RqYC9c9gYa0+NLiuv3dqSICM0LpJhXBYQ2IrX61
 FEKEC5lOykY+7mnKZAQTN2SkFF5PGc7AtG0E+tHpkhYW0TWUb7VdVg6lUL+cbYnh0aj+
 S/tKcpXEeb2lkAo6kB1Vjj73X4H6GPPfUdLuSjGPyFRwvfqez6R6coWZKyZ0tvbOFrUC
 kJ8zg2XB6NWlGmRGdxRyeHbqW9ziwF5YcOBtK0ph0fvneluAmQd7tDKfhu5fMMIldRfL
 PUncsPzDOE7Mi7dUsuf7zkK2ZmgoW8bRTAgdTITpEuWHuGIc1aEEUcNp7rwMFBp/iEB8
 fZMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYIo48qT/4ba76vXuM92dwnoOfbv/Z3nA2LJ5+o7BYR8yp0AHCHf+TXgdg+G2rvvvNM/R1RTf/2reUUkbUttfGyNPDFQ==
X-Gm-Message-State: AOJu0YyjsTxt7Cf+bHnmiSBjMlEN8PazV3DkyNI5lI+B4W1jR6cMn0t2
 AeUTQuOjDyGJXaiKw3vovBl88j/oGzJsAe4UAmeVPWDYF5E8PMbh
X-Google-Smtp-Source: AGHT+IG6pt+mTTgVQmisTccfNH1SQeo4D6iE9eger6qBVL99nar1UTEBaOg9smrfRz7gVW2ItPhAGw==
X-Received: by 2002:ac8:7c43:0:b0:447:eac6:3873 with SMTP id
 d75a77b69052e-44f969a0cbemr12807971cf.5.1721311973673; 
 Thu, 18 Jul 2024 07:12:53 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f96a9d9dfsm2698341cf.67.2024.07.18.07.12.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 07:12:53 -0700 (PDT)
Message-ID: <ea2af812-f6a5-478d-5069-ee918bf507a8@gmail.com>
Date: Thu, 18 Jul 2024 10:12:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 20/21] sandbox: Add an SPL loader for UPL
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
References: <20240713070055.2172883-1-sjg@chromium.org>
 <20240713070055.2172883-20-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240713070055.2172883-20-sjg@chromium.org>
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
> Add support for loading a UPL image from SPL. This uses the simple FIT
> implementation, but also loads the full FIT just to permit more testing.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   arch/sandbox/cpu/spl.c         | 49 +++++++++++++++++++++++++++++++++-
>   arch/sandbox/include/asm/spl.h |  1 +
>   2 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
> index 39869f27a7b..f665f86d64c 100644
> --- a/arch/sandbox/cpu/spl.c
> +++ b/arch/sandbox/cpu/spl.c
> @@ -3,14 +3,18 @@
>    * Copyright (c) 2016 Google, Inc
>    */
>   
> +#define LOG_CATEGORY	LOGC_BOOT
> +
>   #include <dm.h>
>   #include <hang.h>
>   #include <handoff.h>
>   #include <image.h>
>   #include <init.h>
>   #include <log.h>
> +#include <mapmem.h>
>   #include <os.h>
>   #include <spl.h>
> +#include <upl.h>
>   #include <asm/global_data.h>
>   #include <asm/spl.h>
>   #include <asm/state.h>
> @@ -52,7 +56,8 @@ void board_init_f(ulong flag)
>   void board_boot_order(u32 *spl_boot_list)
>   {
>   	spl_boot_list[0] = BOOT_DEVICE_VBE;
> -	spl_boot_list[1] = BOOT_DEVICE_BOARD;
> +	spl_boot_list[1] = BOOT_DEVICE_UPL;
> +	spl_boot_list[2] = BOOT_DEVICE_BOARD;
>   }
>   
>   static int spl_board_load_file(struct spl_image_info *spl_image,
> @@ -246,3 +251,45 @@ int sandbox_spl_load_fit(char *fname, int maxlen, struct spl_image_info *image)
>   
>   	return 0;
>   }
> +
> +static int upl_load_from_image(struct spl_image_info *spl_image,
> +			       struct spl_boot_device *bootdev)
> +{
> +	long long size;
> +	char *fname;
> +	int ret, fd;
> +	ulong addr;
> +
> +	if (!CONFIG_IS_ENABLED(UPL_OUT))
> +		return -ENOTSUPP;
> +
> +	spl_upl_init();
> +	fname = os_malloc(256);
> +
> +	ret = sandbox_spl_load_fit(fname, 256, spl_image);
> +	if (ret)
> +		return log_msg_ret("fit", ret);
> +	spl_image->flags = SPL_SANDBOXF_ARG_IS_BUF;
> +	spl_image->arg = map_sysmem(spl_image->load_addr, 0);
> +	/* size is set by load_simple_fit(), offset is left as 0 */
> +
> +	/* now read the whole FIT into memory */

Why do we have to do this? Didn't we just load the FIT in sandbox_spl_load_fit?

> +	fd = os_open(fname, OS_O_RDONLY);
> +	if (fd < 0)
> +		return log_msg_ret("op2", -ENOENT);
> +	if (os_get_filesize(fname,  &size))
> +		return log_msg_ret("fis", -ENOENT);
> +
> +	/* place it after the loaded image, allowing plenty of space */
> +	addr = ALIGN(spl_image->load_addr + size, 0x1000);
> +	log_debug("Loading whole FIT to %lx\n", addr);
> +	if (os_read(fd, map_sysmem(addr, 0), size) != size)
> +		return log_msg_ret("rea", -EIO);
> +	os_close(fd);
> +
> +	/* tell UPL where it is */
> +	upl_set_fit_addr(addr);
> +
> +	return 0;
> +}
> +SPL_LOAD_IMAGE_METHOD("upl", 4, BOOT_DEVICE_UPL, upl_load_from_image);
> diff --git a/arch/sandbox/include/asm/spl.h b/arch/sandbox/include/asm/spl.h
> index d50d9ad6b48..d824b2123a2 100644
> --- a/arch/sandbox/include/asm/spl.h
> +++ b/arch/sandbox/include/asm/spl.h
> @@ -18,6 +18,7 @@ enum {
>   	BOOT_DEVICE_NOR,
>   	BOOT_DEVICE_SPI,
>   	BOOT_DEVICE_NAND,
> +	BOOT_DEVICE_UPL,
>   };
>   
>   /**

