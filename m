Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E631EC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 05:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA4D9880A1;
	Mon, 27 May 2024 07:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DR96M0R0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F9CC8817B; Mon, 27 May 2024 07:11:21 +0200 (CEST)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 895B3874AC
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 07:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-804cb027cc6so904896241.2
 for <u-boot@lists.denx.de>; Sun, 26 May 2024 22:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716786677; x=1717391477; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kFQ08jO/OvbaZkGLwpHSgEz/E1sgH2baNPWYD/bREf8=;
 b=DR96M0R0UPOMTAyl6u+kakmNfXXfPUmDxouqDCPaVENUW4Jvzm34ENxPZVnWB9GJXy
 w+DZmdtMoaVK9uEOMlwautMdQKGSI02avuraVsMlsvsNHltO4iSxJ3dZTuZQVJtRMCV0
 3u1UwUgszUiAzX5O7lGNrS4INPWy9KXWK2mqfjlvRyuVyGnKpvxo8C/QHIGuuJBEeC6t
 DaCDzK3Y0gSnEJYWt7jqdfQIFJImL6GTlhGggGs2KhiwabKCu+RleG7la3x/W3u0udB9
 XrkN7sGccEtayiEr+wOwcd3MaIufrnl0yNiKAx00DnB65kPUzovha8R7ccoByWqwlyHr
 go6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716786677; x=1717391477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kFQ08jO/OvbaZkGLwpHSgEz/E1sgH2baNPWYD/bREf8=;
 b=Vqw+1Eo6tEY0A83nUtQgmE50RsMmf5e761Qu1g+9md0G5lM/XRZuH3bBZgLEorUZ7P
 wHOpJrGThMQG2D7CvItFsqXCZt23c0OMPHp80V7YlGvnjUaQ+gyKa34NLU/+WoF97zqV
 tnrcwVRyWoCG1tIz64Kfxlc4lu6FSRIVIbsG3beDcX6SzmISveLwD/8eDYgLKw6BQpai
 V9JtsT8cJPyWNHGyT7eirQJ/T0uv6gafxxNwYJna4XldVmv5B6+dj7jGrqmojCuM9Zal
 oWUbEITx2K0AW44AhljjVxM8ItwO4VGGvTUHzvB9OEX8NTdctLVehCSFshbcxsuGtHEK
 2FAQ==
X-Gm-Message-State: AOJu0Yy85ESAsA1UapsV7zbHVu2PvInAmMQiVJntkn8R9xhQfNVtGM3s
 7tcDcDkOp8XfUsLfH45H7ecCIZXy1aUYK084ZD5xvEK9K2hO7Gc4L/D04o5SvjRzZB61BzyXd8z
 nbj/hPaw/8D9G7DuBBu/+9i1hSLcF93aR0Xvpbw==
X-Google-Smtp-Source: AGHT+IHb0jemvyxpxNoDfWiObW4cdktfZgXUfg2QSb204iyTQduuVfbrKOTunXHv6TC/V0ejR+nodor5Aw/kRtfzUUs=
X-Received: by 2002:a05:6102:134b:b0:48a:35fb:5bc6 with SMTP id
 ada2fe7eead31-48a3865388fmr7469413137.23.1716786676432; Sun, 26 May 2024
 22:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240526180128.2807306-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240526180128.2807306-1-marek.vasut+renesas@mailbox.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 27 May 2024 10:41:05 +0530
Message-ID: <CAFA6WYO7Osw+zomN+p9rQ5virwN+3W3fuWUx-Pgy3CTnrB9c-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: renesas: Switch to using upstream DT on
 Renesas R8A779H0 V4M
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Tom Rini <trini@konsulko.com>
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

On Sun, 26 May 2024 at 23:31, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Enable OF_UPSTREAM to use upstream DT and add renesas/ prefix to the
> DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory.
>
> This patch finalizes OF_UPSTREAM conversion of R8A779H0 V4M which DTs
> landed in Linux 6.9 .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Hai Pham <hai.pham.ud@renesas.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  configs/r8a779h0_grayhawk_defconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayhawk_defconfig
> index 6bd872f063f..a986a09b8e0 100644
> --- a/configs/r8a779h0_grayhawk_defconfig
> +++ b/configs/r8a779h0_grayhawk_defconfig
> @@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_OFFSET=0xFFFE0000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a779h0-gray-hawk"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779h0-gray-hawk-single"
>  CONFIG_RCAR_GEN4=y
>  CONFIG_TARGET_GRAYHAWK=y
>  CONFIG_SYS_MONITOR_LEN=1048576
> @@ -39,7 +39,6 @@ CONFIG_CMD_EXT4_WRITE=y
>  CONFIG_CMD_FAT=y
>  CONFIG_CMD_FS_GENERIC=y
>  CONFIG_OF_CONTROL=y
> -# CONFIG_OF_UPSTREAM is not set
>  CONFIG_ENV_IS_IN_MMC=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_SYS_MMC_ENV_PART=2
> --
> 2.43.0
>
