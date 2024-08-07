Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF35CC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D98788D12;
	Wed,  7 Aug 2024 16:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aVVJkwBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B547F88D09; Wed,  7 Aug 2024 16:36:35 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A99AD88D14
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b796667348so8088476d6.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723041392; x=1723646192; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jiec+5QpsQwybJGoln8rssYLmvPYmgVdzhAp5ndgE5k=;
 b=aVVJkwBkIZZeVD0xRk5b3m99WpRaMB+2ZZa+Bmj0yrXRg4tAYWJX9Mda+oydVuzK1b
 PhoFYifdVTTiaeXeoceLB61tpkRoHxh92pZ9/QipSI7NNeSg7gAGiwaGyyPisOEeY0oA
 vavQzzK+7gj9iMUzbr6TsIuLnyGWSB5/33ztU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723041392; x=1723646192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jiec+5QpsQwybJGoln8rssYLmvPYmgVdzhAp5ndgE5k=;
 b=szWEr9c7J5N2ulQiKhQtsHXvsYKOdJT6UNdZ3YZsFX7wXB/+/1k1AUF9pD1N951HPv
 sw+qDp7onSyrLsUlU9b1zNdJxbmri3rT69qVl4dwxXMdBXiH76LStJmOv7ptPLAhkvbi
 mHQ2XLWGrk8PlfcrYbwyTXRUpehk1qAX2D4Wo+9uhUdGgjeszD5YHZS+ZULFCJ438bRq
 0sU9NiGZhLnATOWTZKltNuEbQ3GoIeFrRfq7nrx8Db2UOu0Z6F/QKl9zoAp/f+JBHp7H
 A8V8Fw8kckDZJt40L0Ygnwgpa0jbmXvOkvNqEoJbHGfAa2BfSc08cjcZP/iViNGfotZz
 hWbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2f32gM/b44k84R6vRT+E502iBo8inG/zsW5XdUe6Qi2IS1U0Vnn8fyA62z59kCki+tvHuoeKofyoIGmWByVzn0Bq6hg==
X-Gm-Message-State: AOJu0YymiQJvyxg6Qh55FeEvigKdtoccyZM+db706FUufCQdXjxRrEGb
 aKEbVQ8vn4r0g1kmRUDP0aiaCkkx5qeDEw0J1r5VsEELULiN7eOmQICs41dIycfXCJeMzG2n/K4
 EAjVwsMr738dEI1sSTXt4AOzGeTH5D9ZSbtAi
X-Google-Smtp-Source: AGHT+IEzpMwEaK1BGYudBIs0spMRQkzAe0zPijppTSvhpVpBVHCnVIDOmK8oaXwY0rHVkpIJ8v4zkYjUbwl+dhFxoZY=
X-Received: by 2002:a05:6214:11aa:b0:6b5:101c:6473 with SMTP id
 6a1803df08f44-6bbbbd978d4mr42501666d6.2.1723041392496; Wed, 07 Aug 2024
 07:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240807130010.407399-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240807130010.407399-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Aug 2024 08:36:22 -0600
Message-ID: <CAFLszTiV7ieq_hgYS4XQeq5pssu0zZ89q5-VNbyVq-1cstx3Vw@mail.gmail.com>
Subject: Re: [PATCH] configs: enable efidebug and EFI http boot on QEMU aarch64
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Anton.Antonov@arm.com, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tom Rini <trini@konsulko.com>, 
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
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

On Wed, 7 Aug 2024 at 07:00, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> EFI HTTP is a useful option to have by default and is working reliably on
> QEMU. Let's enable it by default, since we have no size limitations.
> While at it enable 'efidebug' as well, which is currently needed to
> configure the EFI HTTP boot options.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  configs/qemu_arm64_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 7e166f439087..088ba39f18e1 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -33,6 +33,7 @@ CONFIG_CMD_NVEDIT_EFI=y
>  CONFIG_CMD_DFU=y
>  CONFIG_CMD_MTD=y
>  CONFIG_CMD_PCI=y
> +CONFIG_CMD_EFIDEBUG=y
>  CONFIG_CMD_TPM=y
>  CONFIG_CMD_MTDPARTS=y
>  CONFIG_ENV_IS_IN_FLASH=y
> @@ -68,3 +69,4 @@ CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_PCI=y
>  CONFIG_SEMIHOSTING=y
>  CONFIG_TPM=y
> +CONFIG_EFI_HTTP_BOOT=y
> --
> 2.45.2
>
