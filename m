Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE011C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B35A80F9C;
	Wed, 23 Apr 2025 14:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NuWctJdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCDCA810EB; Wed, 23 Apr 2025 14:29:18 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F79980050
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3081fe5987eso5590109a91.3
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745411355; x=1746016155; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YrERGhAbJOhg9FAihLz7YCBLT9Ww06wf5GutdSSl3xQ=;
 b=NuWctJduB4hWGnHTaeuINBZVEaIhWT/RwgepJZO1h4IFJkNiHggHOGCiv1v91PtCwg
 XbmrSlTZ6s2ZKHlYAlhpa+2ugKmRxuO350HWZvtL3XeMvLuImWqH6dXuYnKWZq6YcyAz
 J8/jdRheid6dTISB//FkynMn8QoKllH9vxwTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745411355; x=1746016155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YrERGhAbJOhg9FAihLz7YCBLT9Ww06wf5GutdSSl3xQ=;
 b=h/LHgKdUV9pV9zw78sKcEcRIun3n8kwzoQlXikvdBmojo7IgQkpWtRSn8D/HqraeES
 c85weR3N5uCEurjV7F37jGA+m92JITKgDTmNE5Qkr8sd8OnqYMfXu04FFvR0zfZoDBoe
 piuPzuzXFgoRY4msF2PpQ09iRo6KO/rYcQXk3My8xjBs3UDrR3FJwlA57oEHHZ5B/WjV
 Qny+RXjNNIPxjGD3ocLmvEWTWaGoAo0FaItaLH/OiA7fOXrMDOXoSAQ++31+UKT7MkVn
 givFfUdEN8h4d/anlNoZyHZGRaSltsvqkHz219B+yZzp1+mPgne3SRdWwfa6GRR/E57D
 XiQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/vEbmenyWOzEcXd3BlMwE1+96OEEd7OynKzSgptqBlGz2V84MbfzuLFyB/eVUI5UhM5Yq5H8=@lists.denx.de
X-Gm-Message-State: AOJu0YyZY80c2cxnZiEXDVR2OmWNEqA7Nb1nlbjvxxYH5DK63rIB9rxl
 TdBFzWWQP2UUNPHvcUUKP4Uyg8XPBX8ybTZcBBjf/PxZIXFlpkfTygaoAMwUylCON9JpeiADy81
 wkHu5asQNdHQhE0oFyxyNJivgE1VYQSif8NfM
X-Gm-Gg: ASbGnctK/6qhaO7yQuapHG78oEqM+t4crcQyoak/ge8RaCycLeBeOlvuVyakw244M2T
 6pDaMURZ3r3oG/p+Oc3LdMxLFjQkJHXrNUdJbkc8W/+LY8B8jMNvhPUb5iNXpXqlUgmDxMA+BGd
 Z5l2OK3ELwOxn/c1WoTpl0DOs=
X-Google-Smtp-Source: AGHT+IEJhhM5RUyCICl6naK62aSEHAOCb9SqKFOiTJovMvL9NHZGjlkkuXjkL8+m3EAiXI77L29stwm9SdaQf94aS5s=
X-Received: by 2002:a17:90b:5646:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-3087bcc8a9dmr30573894a91.33.1745411355064; Wed, 23 Apr 2025
 05:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250421162555.1200687-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Apr 2025 06:28:38 -0600
X-Gm-Features: ATxdqUFfUIs-wZ9rmZHnU8oRBNPS9oR4lVAT5HfWRNzYpW6Nd4Nw8Jlc_tgOPLA
Message-ID: <CAFLszTgn3kXFrbsfbQCpJ0pHmgAvF2Df_V7_tTZ732k3Q4UVew@mail.gmail.com>
Subject: Re: [RFC 2/8] boot: BOOTMETH_DISTRO should select BOOTMETH_EFI_BOOTMGR
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
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
> index fb37d912bc9..71ddb37f6bb 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -597,6 +597,9 @@ config BOOTMETH_EFILOADER
>         imply CMD_TFTPBOOT if CMD_NET
>         default y
>         help
> +         This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
> +         launching EFI\BOOT\BOOT<ARCH>.EFI if not boot option matches.
> +

I don't agree with marking this as obsolete and your commit message
doesn't explain why it should be.

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

Regards,
Simon
