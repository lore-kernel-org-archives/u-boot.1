Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113B5C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 10:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4351587C1F;
	Mon, 12 Feb 2024 11:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nOy8JynZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 898FA87BED; Mon, 12 Feb 2024 11:28:11 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BA387C93
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 11:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33b5bc9fdabso739334f8f.0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 02:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707733688; x=1708338488; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7Uf/bPWaXxmP4NCM20OY8pz/seJRydGGW8gS9Ety0Q=;
 b=nOy8JynZ47iMi+AeW8PqTS/5B+sUqI1Lef5/rGnHGCN96t6opZo7G6/pnPyheDjxSc
 BpZYwfSv4K7QW55JTERX6YsIqxV10F9aOnSeV5sUi+rp1qaDT6m/wGSkMMkKhODQaMR4
 JOAhZrMA378DW3Qu50cOexHwL3X+bw/8w/7ukY3vPxazmTYn9XQbHi+l9i3G1c5SFwj+
 FD/BFan0be8XMDHoxW+B3s3XoVPTA+a8Ajvkp1pntDyoN8jM5RNY9PKUmT9/mZ6f0/CY
 WTiwwp98Xrf/LJ1K7GzaICE+NSa8AbB3nz16gNa421VuGKdD/eLTCG+onlgda769J8Le
 Tgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707733688; x=1708338488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7Uf/bPWaXxmP4NCM20OY8pz/seJRydGGW8gS9Ety0Q=;
 b=VCH3hg601TrqiKiZxkXtAxVhNsSG0LAbCE4NHtsRdK0+5gv09PvqT2adWy2DQXlwPr
 sXoRyfsi28OOoRLSdhFI7rpk5jKBtovsvPx19Uoabcy+VchB8zyfCKNYw3WmH+yIhB1Y
 4vWiK4sHdFlBBXKE40GL/Cnd+pWeIjIccMyLOYI0Qxdbt/++T1Blr2ow78+16imH/pFA
 z8J4WiI3CX8q6olRHgCWjQwKecKJJsd7ROkMxBaYBUhmCzQneT2CAZy8j5bY/Acm10C2
 IEObgYOyqrnclzO2d703j2hQBHCnsuQT2zhUDUWPfyDFToRlYregNRMnrDdQh08nd3tu
 nnfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVhsyphEAZZfmNiLwzK+xWRE7xLXWbLnKQZ1kgQ578aEUT+SuRjqV5TvAgQaO26eHpdCxiwcjFU4j+x0Hf2PfVWPS6HA==
X-Gm-Message-State: AOJu0YxIMLlluRA/DwiFs5he8quWBnPpgVOy8J3k1Ij9NR9RMnno6aYD
 fiEH9JJ2iyA9UOkXYZtwmIJn5oRL5Fs9e939Mgpw2qDQLRSdn32UUG9c9fcAi9hJLqwHQCV5rwA
 aw5Xd7ONfrikCeGdH5HrVAuA47xE=
X-Google-Smtp-Source: AGHT+IFAwjSK5rYmHcGkRN64gMzQiu+w9KBbRmle6rR0dTje7PzOlQcm58r0X40+WIU0Jhh9At63Zj8xzjBIjaf41jg=
X-Received: by 2002:a05:6000:1e05:b0:33b:43d9:7ec7 with SMTP id
 bj5-20020a0560001e0500b0033b43d97ec7mr5951619wrb.3.1707733688436; Mon, 12 Feb
 2024 02:28:08 -0800 (PST)
MIME-Version: 1.0
References: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
In-Reply-To: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 12 Feb 2024 11:27:56 +0100
Message-ID: <CAByghJYa1TpEO9kWdy9w1vKBMVp5TkMxQ9dbkmOYPaXzAJFwOw@mail.gmail.com>
Subject: Re: [PATCH] configs: khadas-vim3*_android: fix AVB oom error
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Feb 9, 2024 at 10:07=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> When booting Android with AVB enabled, an OOM is observed:
>
>   =3D> avb init ${mmcdev}
>   =3D> avb verify _a
>   ## Android Verified Boot 2.0 version 1.1.0
>   read_is_device_unlocked not supported yet
>   read_rollback_index not supported yet
>   avb_util.c:182: ERROR: Failed to allocate memory.
>   OOM error occurred during verification
>
> A custom malloc length of 128MB is required as documented in
> commit 285a83b12bdf ("configs: meson64_android: increase SYS_MALLOC_LEN t=
o 128M for AVB")
>
> However, this 128M custom malloc length was not ported to Kconfig in
> commit 7cfbba36e9f8 ("Convert CONFIG_SYS_MALLOC_LEN to Kconfig")
>
> Add it back to fix AVB verification on VIM3/VIM3L.
>
> Fixes: 7cfbba36e9f8 ("Convert CONFIG_SYS_MALLOC_LEN to Kconfig")
> Co-developed-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  configs/khadas-vim3_android_ab_defconfig  | 1 +
>  configs/khadas-vim3_android_defconfig     | 1 +
>  configs/khadas-vim3l_android_ab_defconfig | 1 +
>  configs/khadas-vim3l_android_defconfig    | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vi=
m3_android_ab_defconfig
> index b41c2660fff0..ee62fe36d414 100644
> --- a/configs/khadas-vim3_android_ab_defconfig
> +++ b/configs/khadas-vim3_android_ab_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD=3D"vim3"
>  CONFIG_SYS_CONFIG_NAME=3D"khadas-vim3_android"
>  CONFIG_ARCH_MESON=3Dy
>  CONFIG_TEXT_BASE=3D0x01000000
> +CONFIG_SYS_MALLOC_LEN=3D0x08000000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_=
android_defconfig
> index 88197f5f5e99..cecbe5061793 100644
> --- a/configs/khadas-vim3_android_defconfig
> +++ b/configs/khadas-vim3_android_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD=3D"vim3"
>  CONFIG_SYS_CONFIG_NAME=3D"khadas-vim3_android"
>  CONFIG_ARCH_MESON=3Dy
>  CONFIG_TEXT_BASE=3D0x01000000
> +CONFIG_SYS_MALLOC_LEN=3D0x08000000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-v=
im3l_android_ab_defconfig
> index 3381d2e92701..ec4e0dc72e22 100644
> --- a/configs/khadas-vim3l_android_ab_defconfig
> +++ b/configs/khadas-vim3l_android_ab_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD=3D"vim3"
>  CONFIG_SYS_CONFIG_NAME=3D"khadas-vim3l_android"
>  CONFIG_ARCH_MESON=3Dy
>  CONFIG_TEXT_BASE=3D0x01000000
> +CONFIG_SYS_MALLOC_LEN=3D0x08000000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3=
l_android_defconfig
> index 3fa587ef1db5..206f8defca6b 100644
> --- a/configs/khadas-vim3l_android_defconfig
> +++ b/configs/khadas-vim3l_android_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD=3D"vim3"
>  CONFIG_SYS_CONFIG_NAME=3D"khadas-vim3l_android"
>  CONFIG_ARCH_MESON=3Dy
>  CONFIG_TEXT_BASE=3D0x01000000
> +CONFIG_SYS_MALLOC_LEN=3D0x08000000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
>
> ---
> base-commit: 076529725f16f07a5cb2d5feba25d62b5f5a5872
> change-id: 20240209-vim3-avb-malloc-aa3de534d6a0
>
> Best regards,
> --
> Mattijs Korpershoek <mkorpershoek@baylibre.com>
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
