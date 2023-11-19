Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEB1C2BB3F
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1384286F5E;
	Sun, 19 Nov 2023 01:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DzMZ2EL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5EFB87032; Sun, 19 Nov 2023 01:43:30 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0EE86EB8
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:43:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9f2a53704aaso420555266b.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700354601; x=1700959401; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lkn1InEA6DSrmfkoKAkdcHz0geUYdseFLgf7LvtxTcU=;
 b=DzMZ2EL2AfmaH+tsodyrkU3HimdeQIIgF0JyqbUcKCdXsa42sXRKKOtQpmoBQ8ZPnz
 O3WTlDdBn0KFGeBahPACumUc52nqOUeznAKih6g5RzFRtdFP6F/Te2YZX52BNKu09fuf
 5a7OzmLq/4VsxhYCJVk9sTfNIpQjySkYpfv3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700354601; x=1700959401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lkn1InEA6DSrmfkoKAkdcHz0geUYdseFLgf7LvtxTcU=;
 b=E94IG/inRzbqDdkLE+TeZv4JMF5/eFfeEeRCgsSgibnjUCC8RZiYKUde8BsKgF9kKW
 /b30BWFaC4Ys4BsDXFr2pTC/OIAZhVpDlI4ZVoiO/c72ZKLCVTnowAKVbFJLjmGJ+hJs
 Mzu99iLELgC1iyi+b5R0EfkQPucsYS+Vze9WXXP0VbW1DsTCP2+SXAbfPOyLIaBRBtqC
 TvWcoIqf0nZcv3azCSs1VbKQ7qKQ2AQlVOTi2RuGFPvcf8pR6Xq/SddS7l9RKLMzNuCr
 kzWtFWhjJDaIGmybHtvTBJGjF+0i29G+/vUQ9VfBITKvYnLDt4xeRLU/6U5CzHZcxnvb
 VLuw==
X-Gm-Message-State: AOJu0YwQXv6KwUZbbdUD1DzCypmUWDhd99gA8P0TfqjHfaFyVjBRy3gR
 soeyqFVPfRrDMaWNmCsdxaWj7PSxw7LHUyE4i9qyQVVW26Jx2nTaVyM=
X-Google-Smtp-Source: AGHT+IF6xkKUum11+VMENrvWcXP5sHFNEtnjF833jKaOOhY5xVbjmy+M04FmLgHEHVeQ1EagfJIzTidqjxfRQ8fuFJs=
X-Received: by 2002:a17:906:1848:b0:9ba:65e:7529 with SMTP id
 w8-20020a170906184800b009ba065e7529mr2673790eje.68.1700354601242; Sat, 18 Nov
 2023 16:43:21 -0800 (PST)
MIME-Version: 1.0
References: <CABEcMwWNxzvkkC6-OwUx7AedhctfT00fM-ubXVf9ec1RoMmgOQ@mail.gmail.com>
 <20231114203309.852289-1-i@shantur.com>
In-Reply-To: <20231114203309.852289-1-i@shantur.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 17:42:58 -0700
Message-ID: <CAPnjgZ1PBMCKj1unHXWHxvLo5Gy2pP207MxEnPoqzLik8nsGdg@mail.gmail.com>
Subject: Re: [PATCH v2] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Shantur Rathore <i@shantur.com>
Cc: jonas@kwiboo.se, u-boot@lists.denx.de, philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com
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

On Tue, 14 Nov 2023 at 13:34, Shantur Rathore <i@shantur.com> wrote:
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

But it needs a commit message



>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d812685c98..fca6ef6d7e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
>         imply CMD_DM
>         imply DEBUG_UART_BOARD_INIT
>         imply BOOTSTD_DEFAULTS
> +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
>         imply FAT_WRITE
>         imply SARADC_ROCKCHIP
>         imply SPL_SYSRESET
> --
> 2.40.1
>
