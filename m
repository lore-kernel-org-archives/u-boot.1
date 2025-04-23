Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCC5C369D1
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0111809A5;
	Wed, 23 Apr 2025 14:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D/vJYmui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 472A5809D4; Wed, 23 Apr 2025 14:28:20 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DE5780050
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aca99fc253bso906510566b.0
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745411298; x=1746016098; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WwvWMajdewv4SjfHRz3ZWAJM3mU2nA8RHBL7ntODlEw=;
 b=D/vJYmui2cF0ij+QWXHODj20jEPuQSi5kD2qPpHBH15WVg9j/m4cAFpy7q4DCF+1iP
 gDHAu4igPR+NjU2S2NIgfT2k1dHDB/eUB6W2PwwmQn0sW6/KoW8mxQamMdOlqDzLiDpi
 +aljx8xhf2lRa+w1u1htY4BcRWlrXhDZkg6mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745411298; x=1746016098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WwvWMajdewv4SjfHRz3ZWAJM3mU2nA8RHBL7ntODlEw=;
 b=Kr+FPMCKPyLigOTsT47JnwHqlCcQN/YvVLdlOWutIDjNZU67CQFKD23hA5s4xGyACW
 hB8N7nz5XA6e1j4yn0XcnugSvGie4+3g8UqxYyBOrRA4Alg+C5uELzOBUKo3iCywL+M/
 sKNm2T5NVRON7Faol2LcYwNfZU8GB9wL6WJ0y7DAE13IIouZsdGPmU5QovKO6fr9TMbx
 fTYifLlby8DWSFV4k9pngzYWYa6bALxb2HnSRNZZ/61ok1pP7IG+sDU2JU0uDvmPwto2
 D48S+7aiaQDMnBDSGvQLdDYpQzTMjUzv3pShkvh7bEWHf99nyAvEjXV+6bWe325RFfZz
 f6dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvSunMXHf3n5iOY1btKpWsO7LatsksaOClDM7U7D0XL+hbVSTva/IhDtc0uJJXo7rZSU4JYXQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxmUArgjcNKJQLZkrgdrN2YRCIPqWFUzUQEZ39/mknoQrl0JWC2
 cMkKl2BtfiIVRbobyGjSQUHxL/F5u5D8dzuiL5WAR8z8+kVWi6gg/OsA2fVUsBmX4V2dCNySvwi
 ah/xG4RhjXlJuZCevS2wkMsIPwnXirQg07ujD
X-Gm-Gg: ASbGncv8Av1tci9CTzad7madPP4lr+oe5rHzpjbXNfKvj5rya1vc/TdKrEM830J7QWC
 uc53Wub3FNaRh0FAS74Hv+gjQEY0Opq+tIkm6JPq5YBuWuMp9gkraYzI+9XNgXUzBD5a3J1XVqq
 zMqMPjwRDFHYsZZSfkwCwzUpc=
X-Google-Smtp-Source: AGHT+IGjqOZQ8xwAdGGF2Y80veEiINL1XiGEnga+9omEBcJCjkwH8JJI2sywLVHwS4aZ1aA8XwbgtzLPzMU8k1rbrao=
X-Received: by 2002:a17:907:d716:b0:ac3:8d34:1d73 with SMTP id
 a640c23a62f3a-acb74ac515dmr1501347066b.8.1745411297765; Wed, 23 Apr 2025
 05:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250421094310.764765-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250421094310.764765-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Apr 2025 06:28:05 -0600
X-Gm-Features: ATxdqUEtwhVqAzrCqN9FggW9o478xexLM6AMna-KK0nx0vrH89x-pOI-0Wn_RIk
Message-ID: <CAFLszTgeJ_kvdUrBC=btzKAQGVZDtyJzk1LuD4t58n0zMmvU8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: BOOTMETH_DISTRO should select
 BOOTMETH_EFI_BOOTMGR
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

Hi Heinrich,

On Mon, 21 Apr 2025 at 03:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Distros expect the EFI boot manager to run. It falls back to launching
> EFI\BOOT\BOOT<ARCH>.EFI from the ESP.
>
> BOOTMETH_EFILOADER is obsolete.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index fb37d912bc9..89076220adb 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -597,6 +597,9 @@ config BOOTMETH_EFILOADER
>         imply CMD_TFTPBOOT if CMD_NET
>         default y
>         help
> +         This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
> +         launching EFI\BOOT\BOOT<ARCH>.EFI if no boot option matches.
> +
>           Enables support for EFI boot using bootdevs. This makes the
>           bootdevs look for a 'boot<arch>.efi' on each filesystem
>           they scan. The resulting file is booted after enabling U-Boot's
> @@ -648,7 +651,7 @@ config BOOTMETH_DISTRO
>         select BOOTMETH_SCRIPT if CMDLINE # E.g. Armbian uses scripts
>         select BOOTMETH_EXTLINUX  # E.g. Debian uses these
>         select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
> -       select BOOTMETH_EFILOADER if EFI_BINARY_EXEC # E.g. Ubuntu uses this
> +       select BOOTMETH_EFI_BOOTMGR if EFI_BINARY_EXEC # E.g. Ubuntu uses this
>
>  config SPL_BOOTMETH_VBE
>         bool "Bootdev support for Verified Boot for Embedded (SPL)"
> --
> 2.48.1
>

I don't want to make this bootmeth obsolete. What is the motivation for that?

Regards,
Simon
