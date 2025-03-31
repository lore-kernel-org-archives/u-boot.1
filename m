Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7236BC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0876E81DE3;
	Mon, 31 Mar 2025 15:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KojKrOSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D54BE81E5B; Mon, 31 Mar 2025 15:53:32 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91FAA801FB
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e643f0933afso4336951276.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743429209; x=1744034009; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Klr/otqzgFrh3kC9rTKZtAVEnRNzPppsekAGuRmckQk=;
 b=KojKrOSd3SwZGpEuGlKJZb9WaOR6CH8SwPnoP69YWgu6faiBCIsuofVx+s2S/jlK71
 MHRYtwzYma9nWa/yA+ZY0NDuwzSjfWRkX0qAYw7pmNRHxCorfvqSqDsIfImyEtmgUwqB
 gHiXJMGdP8S/TZ9cjWxg/wUEoNYlu43n+ESq3tn/isxgcUdRhmT8dGAErCxZWE5455po
 jesDR8efCHdTrDI4eZUdxX5aJqMq7VKc8W+DqpS0f80rjLEoHQ1RHhNUdySxXYo3vH47
 KdEoDPF/qAIs7bkXsgsqe7wls1g12EmsyVwqDVpw8q9x03Kmm3vKxb4+QLNvvrCN4Ned
 JBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743429209; x=1744034009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Klr/otqzgFrh3kC9rTKZtAVEnRNzPppsekAGuRmckQk=;
 b=C81PYIVC2QanwykQ9D3d6+Y0rCKRz8Il/mLjHBl4O57pqikWt59w++8GMiRRpGvj3L
 xfGjoNgA8p1eSEkE+Ntg0OH4L8xKa5sr8BkWrrWHzVcQnhDtrm16H2WfiKbbA8shBRim
 BQK9A+WXKV8Cx3vjuMtpCZP1pCtIeM/7F7LOMOv3k+83G6NZTA9wCEvcaN+X+RcqoVW1
 ZxcGqpEAAD/IOiMruCMCwA0Z6ZVrCbsQm33eWWZVeCDDRrnS/mxh6/KBaKDRJ0/svBcq
 1GdYc+UYntIQa0eNSDDsUOMg6ax/J3X1Tl7eBD9Pouk3CWGyAU8JIS6XbYFoQ+rzWYJ7
 daCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSL08eGT9bABE1spks4wCTrbpk2lZpc3DHnkL91Xr+MA1+Qw+4WuKwbV4VBQz/1gRGRGOD3ek=@lists.denx.de
X-Gm-Message-State: AOJu0YyHQ9/+zilRfW83lFcmX/BD+ePwjjknb5EGCszWIgkffghggfjy
 IAWDOtc/cB4yMD1pruvsK3Q2JoZxQTZltR7D4RqxvIet1LLTmpt3VjHpwwKwehjQIECe82T2q8i
 4QrYwtGB6E5yvUh7de1iAvbhz7QFnJWnA4m2Htg==
X-Gm-Gg: ASbGncsSbCUipCCpOrEFu8rM/813/Z+UhyzUCUvnRQrZ1t784WdYmuErtWgIiCP59IU
 SfAMfUfwC9DizRgO6KyCDvsv/n1JOpYpwi7BrDN86eb1Ny+PCopviuFLOOLxwbeg0MKDtrmMUsP
 R3fTSAg4WV7I57ceaxe5x3Drnx
X-Google-Smtp-Source: AGHT+IFWWIVucf4qsgtI/DhltkVunVJeftCwbo7LtJaW28xd6Ua5dFLloi1MjqLy8R8EO6xEMqIKVOQePpbCLOR5GBM=
X-Received: by 2002:a05:6902:1b0b:b0:e63:3e25:d71a with SMTP id
 3f1490d57ef6-e6b736c2f35mr15277017276.15.1743429209372; Mon, 31 Mar 2025
 06:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
 <20250326-b4-qcom-capsule-update-improvements-v1-4-afe2e3696675@linaro.org>
In-Reply-To: <20250326-b4-qcom-capsule-update-improvements-v1-4-afe2e3696675@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 31 Mar 2025 16:52:53 +0300
X-Gm-Features: AQ5f1JoCyZqxG0x9lo2yK3uCK531csORGbu3DBa0xBYvw_EL-NgzdiYIySiFsUQ
Message-ID: <CAC_iWjJFj9eXrKtWGhkCytUaRDWT8AnvbqxrX2ynw=HJ4ZpUqA@mail.gmail.com>
Subject: Re: [PATCH 4/4] qcom_defconfig: enable capsule update support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Wed, 26 Mar 2025 at 19:41, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> We can now correctly identify which partition U-Boot is flashed to
> between uefi, xbl, and boot (including A/B support) so enable capsule
> update support for all boards.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  configs/qcm6490_defconfig | 6 ------
>  configs/qcom_defconfig    | 3 +++
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> index ba26924da161b1c4b5378955185f314b05cb1006..5ddc5ab3ef8cfe8f9cc09eb573c1a8130b394b43 100644
> --- a/configs/qcm6490_defconfig
> +++ b/configs/qcm6490_defconfig
> @@ -18,10 +18,4 @@ CONFIG_DEBUG_UART_CLOCK=14745600
>  CONFIG_TEXT_BASE=0x9fc00000
>  CONFIG_REMAKE_ELF=y
>
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
> -
> -# Enable capsule updates
> -CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> -CONFIG_EFI_CAPSULE_ON_DISK=y
> -CONFIG_EFI_IGNORE_OSINDICATIONS=y
> -CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index ba4d38d100e053e3708ee2623bf3530787b6b94f..d69185f3c2f0452e6757b785a023cf612bfa3839 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -5,8 +5,11 @@ CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
>  CONFIG_ARCH_SNAPDRAGON=y
>  CONFIG_NR_DRAM_BANKS=24
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
>  CONFIG_SYS_LOAD_ADDR=0xA0000000
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_ON_DISK=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>  CONFIG_BUTTON_CMD=y
>  CONFIG_FIT=y
>  CONFIG_FIT_VERBOSE=y
>  CONFIG_BOOTSTD_FULL=y
>
> --
> 2.49.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
