Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ABDD1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 223508426E;
	Thu,  8 Jan 2026 18:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O1uX/zn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F5784198; Thu,  8 Jan 2026 18:42:09 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 152EB8425F
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b802d5e9f06so497003466b.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767894126; x=1768498926; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cAdj5Kfb2WErzVrltw//+0He2X8vp6Mm8Ul4d7adYD0=;
 b=O1uX/zn1BhB3cMMafzf2FaGkg1bT0r0ryxpmqWXqfVmUzOMGqrjKF+UxxbFHzXtljn
 HAgmOvX0cidDo5G+wGv91atVsSEi67LTxKc8sSzr63VJGkicaRgP2ug7naguyzis0605
 bN0I9ZOL2bQiWXDwkx6+DXHY+yFyPOKGxv/WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767894126; x=1768498926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAdj5Kfb2WErzVrltw//+0He2X8vp6Mm8Ul4d7adYD0=;
 b=SCkjT6i2Re9T149V1xDIfXW6hY/NWS+cbRGUvQ7Ff8kNlGKG71ApqQKO6nm2Z8uUYW
 Ri+dYyTqejgEFP+beVFvEB0vaE3tnLkrWO3MMzBgScjwmGyZ9+DP+EWS8VOlv+20z0nJ
 X9ht7KLToGUDxmh16dEF7b5vi2gVBXkwfUgwxvhQLOAgceXYOpvQ+XWPUAKjQ+k9ovG+
 IeSrjpcgyG1ycRuAgyqE059DTExiHFgkp0RBkezLpBqDtujj/nsxxjtsQVyApgJsUff9
 dgJ/X1ajEBPIRbBLDobVc6iWO4TsE6HvAEoLyp1+dBYi80+pCnkCdDDyUpl8KBN0rwx2
 aG9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP9IFn/Aa3xjsN61CesHWqPCbclyYlI7PPUmgMcnimE9HNQgWeJGoFip9ScEhDLSIrd99J7bU=@lists.denx.de
X-Gm-Message-State: AOJu0YwP4znxrpMt6h1QYTS7YSezboTdVEyZJXFNuwi0RYpO3SYdm3M+
 7B6yxcOpPttw09lf8/wK7Lg+4WQUTNKADVv8n6/YSk8xW8y9eAduocqT5blpuuN+qpOTTIn7rzJ
 giEpvqjVXTut98yfRHH/GKGwX4ma99iiQHIfwQ3Og
X-Gm-Gg: AY/fxX44p28HcWX5y2Fg2pkhWSdqPLlpBQ7lOhTH1GJk75UyQtt5rLdMZBThnjFRPeQ
 eOa74zVI5TgZb8+RHl+RVi/9erURa7XuS6Y461RK0BYfYaSI0SUY8z9oDUsOzJ9mwjzituU8qVd
 ilBaPIS7l5yk1dliH3+DPj7A28VeGwgFDIlAgvLgTDnNryPTCIcfXNml7GVmViX/zfTvFtg/RmR
 +fbj6JOWLrYkhBiMvU1wCp4Zbe1zI+qO7JtLMkuv8viDG/gHh1DJNAAow40wAKFirvyEA==
X-Google-Smtp-Source: AGHT+IFxbSg+4EwPvkpg7azRRkmWShFaBuF5V+xTS5i4ino14QMw5RBfun0gTrKhNNFSnivUkVXLn/Z+DcvaTqkNYHc=
X-Received: by 2002:a17:907:3d02:b0:b83:c81a:197e with SMTP id
 a640c23a62f3a-b84451c5fc6mr699935866b.24.1767894126410; Thu, 08 Jan 2026
 09:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20260108101721.3411854-1-balaji.selvanathan@oss.qualcomm.com>
 <20260108101721.3411854-3-balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260108101721.3411854-3-balaji.selvanathan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Jan 2026 10:41:52 -0700
X-Gm-Features: AQt7F2o9GMKbuvdI9xsjJACQOt3D1IQR7lMzzw9cprp9GPUrSCNep5oS-F4xt_o
Message-ID: <CAFLszTj8GeL8AfM9AatVDtc+B2nXObNKeL86SOKBmhZNn53FOA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] arm: snapdragon: Add RPMH cleanup in
 board_quiesce_devices()
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, me@samcday.com, sughosh.ganu@linaro.org, 
 gchan9527@gmail.com, aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Balaji,

On Thu, 8 Jan 2026 at 03:17, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Implement board_quiesce_devices() to cleanup RPMH controllers
> before booting the kernel. This ensures all RPMH TCS hardware
> state is cleared, preventing timeout errors during kernel RPMH
> driver initialization.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/board.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5fb3240acc5..194318af228 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -32,6 +32,7 @@
>  #include <usb.h>
>  #include <sort.h>
>  #include <time.h>
> +#include <soc/qcom/rpmh.h>
>
>  #include "qcom-priv.h"
>
> @@ -709,6 +710,19 @@ static void carve_out_reserved_memory(void)
>         }
>  }
>
> +/**
> + * board_quiesce_devices() - Quiesce devices before booting kernel
> + *
> + * Called by U-Boot before booting the kernel to ensure all devices
> + * are in a clean state. This is critical for RPMH to prevent kernel
> + * timeout issues during initialization.
> + */
> +void board_quiesce_devices(void)
> +{
> +       /* Clear RPMH TCS configurations before kernel boot */
> +       rpmh_rsc_cleanup_all();
> +}
> +
>  /* This function open-codes setup_all_pgtables() so that we can
>   * insert additional mappings *before* turning on the MMU.
>   */
> --
> 2.34.1
>

What are RPMH and TCS? Can you add a dummy driver for this hardware
and mark it with DM_FLAG_OS_PREPARE ?

Regards,
Simon
