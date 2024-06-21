Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A564C2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 07:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E09880A3;
	Fri, 21 Jun 2024 09:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E46PFY4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DF1F880A5; Fri, 21 Jun 2024 09:36:13 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BEC878E2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 09:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-62cddff7f20so16390867b3.3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718955370; x=1719560170; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y5gXyTRVlnYh6BN8wovezBtp8iMNFvsfBs03XTgzx1s=;
 b=E46PFY4r5xUd+jrbiD/dqWeSxT5B37qZrwQzRvOlPc1c2jSkmjlPGUDX2IZw/n5NRK
 st5e4iDLLKZBVbtEFOaHHuc27c7z6U1vwRkDZexVGgesm/8wurHUl7sLJvnJbbEhmLmv
 +WrharRgbaJLEmAqFbKF7HFAK8sToxY2BVILmC6+LbiWZk+YBWsK5OrIRaQWybi3Of+j
 4G3IZDEoUDy7RZjqECoII3BdgyGjQG3A/3tfq6x8REqEIOfU+0lqVF28mOGDqoOmcZs3
 JC/lIh7NKzY9ggsUgAvp192nxwYhPw3p9Pe5aL4pNFQNYYp4Jl9I7Yycax6RR9njJsoo
 Am4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718955370; x=1719560170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y5gXyTRVlnYh6BN8wovezBtp8iMNFvsfBs03XTgzx1s=;
 b=DGJKqgLmatFBHFil3B6Ska8wABSx4ifc8aC2jY9fKd1TywItbdHZ0mPSEAiitRxJSv
 pfBn2FUM7A7drw8WkZagA+F5vD8Xp+UA84LlIHW3RLSn0/p5S4yj8KruFIhzTthuOL2C
 g60ArPMKKqYgMGOUKslU2+sBYgZ/hPA5P4lKfwPqMbqzidOfRF7lTGBZHJetLmAoBkFn
 WXPDF9PXC+uTNekR+Qe3sxqIswkmR4JdlrBB9DVUkJVCyvfPCVMQDw/Yzg7BSyfSU5NC
 S33XAPmvb5sHba8PhY+C6gYMIP7n0/YnY0v4Th1dv54p6E6/a/j0OIXfQn7UcmjWo14Y
 T8Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGB66Bam5vk+o11Id90tZQGW1iithQfHzBu7hoaB7ADbKufsViGCkJViHoJwOmUPNvvRl3oMuTGxIlwYa65Hsr0+xKUw==
X-Gm-Message-State: AOJu0YxQpy9H43CBuIBc3Qc6jxqaK76BTvTXt7IZD8gw2MEm/d9Qld2v
 BkNvtue4hK62jfzMbBGY0qMU/hc2QbYMHl/cFbpnXaNFKkw6iumf01Sc/I0plF5h8bVbY8qplNF
 n4FxiPOsPgPLluIWpTPrlKgt/YkAYYLVE14bplg==
X-Google-Smtp-Source: AGHT+IH44Fy22PxgHkdj+rgmylsiPagNFbNudq6ahuCg5KMjoMFnwTJNUTgNlksRAXIRYFE07EHKlQBLAst3DOmoylg=
X-Received: by 2002:a0d:c1c2:0:b0:627:778f:b0a8 with SMTP id
 00721157ae682-63a8fddc0a0mr79103697b3.42.1718955369793; Fri, 21 Jun 2024
 00:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240617085629.1744017-1-caleb.connolly@linaro.org>
In-Reply-To: <20240617085629.1744017-1-caleb.connolly@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 21 Jun 2024 13:05:58 +0530
Message-ID: <CAFA6WYM1Rah1=Ktxk-64YhhwLQV7m9D0ixvErcMh7DDv7ssgVg@mail.gmail.com>
Subject: Re: [PATCH] mach-snapdragon: move default environment to a file
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Mon, 17 Jun 2024 at 14:26, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Make use of CONFIG_DEFAULT_ENV_FILE and move the default qcom
> environment to a file under board/qualcomm.
>
> This is much cleaner and means we don't need to recompile on changing
> the environment.
>
> Additionally, extend the environment to include a boot menu and
> auto-boot using EFI instead of bootm. Since we now support MMC and USB
> on most platforms, these are much more useful defaults.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  board/qualcomm/default.env | 12 ++++++++++++
>  configs/qcom_defconfig     |  2 ++
>  include/configs/qcom.h     |  7 -------
>  3 files changed, 14 insertions(+), 7 deletions(-)
>  create mode 100644 board/qualcomm/default.env
>
> diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
> new file mode 100644
> index 000000000000..243aede77be7
> --- /dev/null
> +++ b/board/qualcomm/default.env
> @@ -0,0 +1,12 @@
> +stdin=serial,button-kbd
> +stdout=serial,vidconsole
> +stderr=serial,vidconsole
> +bootfile=/extlinux/extlinux.conf

Is this file used to perform EFI boot or is it redundantly copied from
somewhere?

-Sumit

> +preboot=scsi scan; usb start
> +fastboot=fastboot -l $fastboot_addr_r usb 0
> +do_boot=bootefi bootmgr
> +bootmenu_0=Boot first available device=run do_boot
> +bootmenu_1=Enable fastboot mode=run fastboot
> +bootmenu_2=Reset device=reset
> +menucmd=bootmenu
> +bootcmd=run do_boot
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 80ad3b32e139..a9e3797bb39a 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -35,8 +35,10 @@ CONFIG_CMD_BMP=y
>  CONFIG_CMD_LOG=y
>  CONFIG_OF_LIVE=y
>  CONFIG_OF_BOARD_SETUP=y
>  CONFIG_BUTTON_QCOM_PMIC=y
> +CONFIG_USE_DEFAULT_ENV_FILE=y
> +CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
>  CONFIG_CLK=y
>  CONFIG_CLK_QCOM_QCM2290=y
>  CONFIG_CLK_QCOM_QCS404=y
>  CONFIG_CLK_QCOM_SDM845=y
> diff --git a/include/configs/qcom.h b/include/configs/qcom.h
> index e50b3bce5cdd..5b5ebbd844df 100644
> --- a/include/configs/qcom.h
> +++ b/include/configs/qcom.h
> @@ -10,12 +10,5 @@
>  #define __CONFIGS_SNAPDRAGON_H
>
>  #define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
>
> -/* Load addressed are calculated during board_late_init(). See arm/mach-snapdragon/board.c */
> -#define CFG_EXTRA_ENV_SETTINGS \
> -       "stdin=serial,button-kbd\0"     \
> -       "stdout=serial,vidconsole\0"    \
> -       "stderr=serial,vidconsole\0" \
> -       "bootcmd=bootm $prevbl_initrd_start_addr\0"
> -
>  #endif
> --
> 2.45.0
>
