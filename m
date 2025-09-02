Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E7FCA1007
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 05:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B8483443;
	Tue,  2 Sep 2025 07:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sPqbOiLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29E083965; Tue,  2 Sep 2025 07:09:28 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 504F08311B
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 07:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-71d605a70bdso31406817b3.3
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 22:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756789764; x=1757394564; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=og4N23PVfaxajRfRHRMpnrRk3KBl3Nm8zlkV4KxExSc=;
 b=sPqbOiLeGhlXmgD4jMvrlzMJNfTdwUsOVFpyqdLWwwDVTxg4lg/h8A9RGPYHAzgq+o
 AnIdyJxM9iyoUGYawMIT1uw97MWR3+KuMCSVKJ9tQZ1R6gNefMlk8yrXV4KnWeenywCo
 UQnRdH0MReX5VXccNwACIP4aQOMbpnNrWvZbFTVKa4Filqvoy4Hq9hYRwefSjwGlH+es
 sK9b9NuDDtnEjtN0pir4f3oVFjbOAYDZcwdkroDRCp6ZtKb8h9Xg6VwxU8CFwQvWIs9I
 0Nt/dga5/RH2UCTdYb/URwNDAmZM1nVpn5U5V09Jq2uAJuGk0sr/M02pJOUSoXyWiugL
 +k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756789764; x=1757394564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=og4N23PVfaxajRfRHRMpnrRk3KBl3Nm8zlkV4KxExSc=;
 b=JT520uHk5+k1lJefVw4cHlZSGLmIs/i2fcsC1uHO4mVfIRAN8Js+utZvp2Y/t9reTi
 /RA5mgc9ovN/7CtoN8jrk1q6IOQ0YyJQO6GlM4qDq2kBxFHGWketwIGvSjW8gWYCEuFh
 1vik0GFq8dHxBkvaLBaaWAHrKYceRxIkdZkahHAaezwdpxnKGRtLEsbNRLAXKbut7UmI
 MTxBWEZ5D0bjvglanQxwkUxEJcF3lTnGjnWy77rFgdh67ZRoaAhdg8pxNc3uaHP27CgO
 QI6t04aCkeQ1i6+ZKQMzxuK1RvfgEo7R/z0Qsp5k34GLKa67mfKm7uKpZfPX9fGWCsKR
 BjIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEgE2piPZ+pT9VHfzDxCF5vtMBkKuSq+TVBbHcVkNXnrbmJ/a8uLg7BCLoj6j6+NDAfeIX7G8=@lists.denx.de
X-Gm-Message-State: AOJu0YwlHnK/HloLQXCb0z6Ji+s6rFgMUOqY8YF2kSj7VL+puT/Whl/m
 xXmdalfoRFOWAnP74ATzfQbVBwo/muQoJKD6mLaDrobww5+7isUpfDNt0gbLhOlX4gw0T91WtdB
 IBKis8FGRwmAFZN+QB1zzxZetdDHDNIFY7atCNWnFZg==
X-Gm-Gg: ASbGncu0jWWp8KhL/KwMuWcf+YRyDRuKdgB7X1DZKJYVQ0vBNcgaSP8ABEyF2Z7h2eR
 6LWgL7E5NphA/FD/510UYAdU7iN59b1y6WdqQ2phARLIUqYdjUjrONVdCULqXvXDLX/ew6u5a+h
 d0tZbPITon/wR3weSANFzzRddeDEY8nd1Y2IDrS9YHUH+TakQHLIBUyPHgRYIJ/6nmpWyH2LWfa
 uviUhSMSNX5HnB4Eu68sJkj15k+CuHi+bZy90zo5wz2XlUvBOQxH0LO+9sTzJMyjAM0BmPcLycb
 znZy+26U6lWCHBk9g0KybUpjVkTbEUIPNqPtDf96O07++ksWLwCGEMTZ4DsIcqVwBxti2b+3
X-Google-Smtp-Source: AGHT+IFAeQDtothIMJmqGtAncwqvg1MfeotRYeP8C4HTaWFlkr3CDUVWQwkIpb7x2F6deJyxnl1mwWQR/J/ziYhdN9c=
X-Received: by 2002:a05:690c:6803:b0:720:73:1a11 with SMTP id
 00721157ae682-722764fe1a4mr99517467b3.34.1756789764036; Mon, 01 Sep 2025
 22:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250901170308.805653-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250901170308.805653-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 2 Sep 2025 08:08:48 +0300
X-Gm-Features: Ac12FXwHdoPPsjUJTeqs-6a0ioKY1DQ4uBAvsTlGjya--FG3FbZDi5Jh48dPBgc
Message-ID: <CAC_iWjKSMvp_4Ep1ANyoSuMPtiEHPeJj3=0+yWOCy=mYbs_Bjw@mail.gmail.com>
Subject: Re: [PATCH] bloblist: adjust default bloblist size after reloc
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Harrison Mutai <harrison.mutai@arm.com>, 
 Alex Shumsky <alexthreed@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
 Raymond Mao <raymond.mao@linaro.org>, Joshua Watt <jpewhacker@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
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

On Mon, 1 Sept 2025 at 20:03, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If neither CONFIG_BLOBLIST_FIXED NOR CONFIG_BLOBLIST_ALLOC is set,
> currently CONFIG_BLOBLIST_SIZE_RELOC defaults to 0 except if
> * CONFIG_ARM=y && CONFIG_EFI_LOADER=y && GENERATE_ACPI_TABLE=y.
>
> A size of zero never makes sense for a bloblist.
>
> When using QFW we need more than 64 KiB to host the ACPI table.
> In this case CONFIG_BLOBLIST_ALLOC is used.
>
> Set a reasonable default.
>
> Remove the CONFIG_BLOBLIST_SIZE_RELOC in ARM QEMU defconfigs which are
> not compatible with ACPI tables passed from QEMU.
>
> Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Fixes: 6f9b015c138b ("common: Enable BLOBLIST_TABLES on arm")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/Kconfig               | 4 ++--
>  configs/qemu_arm64_defconfig | 1 -
>  configs/qemu_arm_defconfig   | 1 -
>  3 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/common/Kconfig b/common/Kconfig
> index a2f653f7e72..7af438a91e7 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1121,8 +1121,8 @@ config BLOBLIST_SIZE
>
>  config BLOBLIST_SIZE_RELOC
>         hex "Size of bloblist after relocation"
> -       default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
> -       default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
> +       default BLOBLIST_SIZE if BLOBLIST_FIXED
> +       default 0x20000
>         help
>           Sets the size of the bloblist in bytes after relocation. Since U-Boot
>           has a lot more memory available then, it is possible to use a larger
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 358bb1aeeb9..12ed6b61239 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>  CONFIG_KVM_VIRT_INS=y
>  CONFIG_ARCH_QEMU=y
>  CONFIG_SYS_MALLOC_LEN=0x1000000
> -CONFIG_BLOBLIST_SIZE_RELOC=0x2000
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
>  CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_SECT_SIZE=0x40000
> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
> index d5890bf87fb..e6d4414cf0d 100644
> --- a/configs/qemu_arm_defconfig
> +++ b/configs/qemu_arm_defconfig
> @@ -3,7 +3,6 @@ CONFIG_KVM_VIRT_INS=y
>  CONFIG_ARM_SMCCC=y
>  CONFIG_ARCH_QEMU=y
>  CONFIG_SYS_MALLOC_LEN=0x1000000
> -CONFIG_BLOBLIST_SIZE_RELOC=0x2000
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
>  CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_SECT_SIZE=0x40000
> --
> 2.50.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
