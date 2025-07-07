Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE422C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 11:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447DF830CA;
	Mon,  7 Jul 2025 13:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HqUDwzCW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5610D8305C; Mon,  7 Jul 2025 13:41:27 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 139B2830CA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 13:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-714066c7bbbso27722467b3.3
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 04:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751888484; x=1752493284; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3dtDtL3VpEtr/Cot4D4pBhI7tTIZJtYH0PUs+/O7pmY=;
 b=HqUDwzCWk4VeJ4ooYLcscebav8MDFnBdLTyYeUi6jGPwX1lozQEvjKFnbakSRmOvXt
 69snZZROrM+HTWhW7lftxM8WTo33S5zO7TooqZAQbQ7ZjWiWqubQ2m/V0iyFd5Q3sxH3
 j5axGZoC7kV1qUVwTMjh8lS3Func0jHnztbi7O51dlsP2jJcCY6eRsWuLkV2ZkcKvg6Z
 2eerflBo+uiAE8OHrgRa2biZssa7cTNWzLjPCk1Kp/lXnKy3NC2H2WRGDfVjwBK10Jn4
 tHPalUBxXQ6I6siinJsermxFFcWSIhq1T5l17zY2rE3RhRR9Lr47NZkjz35l5BKsERtC
 lncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751888484; x=1752493284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3dtDtL3VpEtr/Cot4D4pBhI7tTIZJtYH0PUs+/O7pmY=;
 b=YMo6QTYRFR6+ORVRlw3PYVzqj/imCq1DsLGOykKT1JSPvI1yjReFSvQZtoDHXliEG1
 1/DZ0vWwAAzDu5NgHfGky2p+SUo0oUkvQRvU7HD73US20iIJUKPF1+0fdp+QTOG9vjB2
 d+soTTFivl0hPkKzH7AEddPnOgpOyIOgqvYfLd2fPX3ZlbnicYQwzvIC9GN3QfItyFj9
 Nsfw+UWyPus1gBQfjkpx1+Q2yNx5SQhEzTPpI3U4KcarkEwdrNOsiRYZdP4BHBS4NRK6
 rHQIdAY46lFTD9mHkC8sjBWa9QKAUZtRA+3casDVRHXUA+BQxeSOeuiOeMzDQCMgZDgC
 0s6w==
X-Gm-Message-State: AOJu0YzahnJoCCFUpYkNE4xYnbWIvQFHuYA3FXOIINrTb+5mfSiWZQk/
 iZubquD3/DW3AdsNK1QbsRbnEHJgqFBpxO8PYCpmNtnSA/HshDjvkulwou9fCkSdFYGOkLbIn/f
 ptMNDgdqVThYPx65xfwynoOdOGh6DHa2vt+a0H7+YcW3DmxnLnWJfpiiI5w==
X-Gm-Gg: ASbGnct8EXiAgIvzT4QaeLAg2LnSMohHiQHY6DPiOBaHPh0Ji8dARincjbeqEbvYjYA
 ck3/6rmO+C46PDnudbIPZPzw+S6cqEjDaY2WE1hqnA+RwnjKrpsfALV6WtKUHtSReY2HBE8cv06
 vAJbQ/Bs4HMirKygN9Nr/V5H57VbTuGCYOi2qr53ATrzw=
X-Google-Smtp-Source: AGHT+IG9Afh/koGrUVyiO6arkVEyM8+x3NBTfcGai/hA1PhwPQylokUluKEXYslN+9ElnzCJRNt0IuGmJbOmELqAbuk=
X-Received: by 2002:a05:690c:a95:b0:714:250:833a with SMTP id
 00721157ae682-7176ccd8658mr104172147b3.27.1751888483863; Mon, 07 Jul 2025
 04:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250707095322.30222-1-paulliu@debian.org>
 <20250707095322.30222-2-paulliu@debian.org>
In-Reply-To: <20250707095322.30222-2-paulliu@debian.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 7 Jul 2025 14:40:47 +0300
X-Gm-Features: Ac12FXwK4dUYuS7tPtXHC6EeJskezXySppd_0wtcaXweluDhRkKtkpbPbBhjpwQ
Message-ID: <CAC_iWjLnna4TMhZ5mEQp1_aKcazwmALkd_+aA21npU-aS0Y9Rw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi: turn on EFI_DEBUG_SUPPORT for qemu arm and arm64
 target
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Thanks Paul

On Mon, 7 Jul 2025 at 12:53, Ying-Chun Liu (PaulLiu) <paulliu@debian.org> wrote:
>
> Previously, EFI_DEBUG_SUPPORT was enabled across all platforms for
> CI build testing. With this commit, we are limiting its activation
> to qemu_arm64_defconfig and qemu_arm_defconfig only, which is
> sufficient for our current needs.
>
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paulliu@debian.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  configs/qemu_arm64_defconfig | 1 +
>  configs/qemu_arm_defconfig   | 1 +
>  lib/efi_loader/Kconfig       | 1 -
>  3 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 39afb837e41..54bf4646382 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -15,6 +15,7 @@ CONFIG_ENV_ADDR=0x4000000
>  CONFIG_PCI=y
>  CONFIG_DEBUG_UART=y
>  CONFIG_AHCI=y
> +CONFIG_EFI_DEBUG_SUPPORT=y
>  CONFIG_EFI_HTTP_BOOT=y
>  CONFIG_FIT=y
>  CONFIG_FIT_SIGNATURE=y
> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
> index 92ba48f6af9..b1c277a86c0 100644
> --- a/configs/qemu_arm_defconfig
> +++ b/configs/qemu_arm_defconfig
> @@ -18,6 +18,7 @@ CONFIG_ENV_ADDR=0x4000000
>  CONFIG_PCI=y
>  CONFIG_DEBUG_UART=y
>  CONFIG_AHCI=y
> +CONFIG_EFI_DEBUG_SUPPORT=y
>  CONFIG_FIT=y
>  CONFIG_FIT_SIGNATURE=y
>  CONFIG_FIT_VERBOSE=y
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 077466f01f0..fdabe9cc278 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -73,7 +73,6 @@ config EFI_SIGNATURE_SUPPORT
>
>  config EFI_DEBUG_SUPPORT
>         bool "EFI Debug Support"
> -       default y if !HAS_BOARD_SIZE_LIMIT
>         help
>           Select this option if you want to setup the EFI Debug Support
>           Table and the EFI_SYSTEM_TABLE_POINTER which is used by the debug
> --
> 2.39.5
>
