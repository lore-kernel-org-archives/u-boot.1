Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96359C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B4B480658;
	Thu, 16 Jan 2025 02:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QMW2KhN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B1FD8069D; Thu, 16 Jan 2025 02:27:12 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B6BD80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so70639766b.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990829; x=1737595629; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fMZwGnskwGRy17v7FGG7grrpKqPw351xDtm5IRu2K/0=;
 b=QMW2KhN7rr3yBaETsccyp4gGN5fZ879BU5GxTHac/5Yk9UI2CDH/OXw1YoyYOZ9ZeG
 1o2FRmfDxs01Y5dv83Ov62ZvviqTaPTClyCD4mPjdAKpeIgcF6HcwVOqPyLc5JE5+gn1
 3Ki/MgXMToNVGcc+QnAQvBgLC7CkYjQUlSRXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990829; x=1737595629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fMZwGnskwGRy17v7FGG7grrpKqPw351xDtm5IRu2K/0=;
 b=Uh10XddKeuWdXGrpzNRT41aY37yGROp8yzfLCIFiv/KoeN7Au17kFhv/n03F2OsGm0
 5Rh3xqGYtc7XJn8pLIeCCTzbG5XcQAb32r/OvAWK3UGX0/rzlOVqKnqsdJKljAnvjlqH
 3l3CsCNGYhgKGx8gX+cNxw9MOj8Uv9nD0zoNSF/kU/5yFd53BBHVfi+X+3JZZugtQUsA
 7tSIgS0pb5rMzgdt06WMRd/xEaAn9q2jltThdiAsSuwuTKvLFEdc9N3BN5Cq1E/tlAWZ
 H7HsGv1rRvi5jBcuaksSn1btw9WfxqUt/e3CClu8PoNkBQZQ464sW83gB4QfM2f+jh12
 CdPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHYCaoFP4sKedrhpazP7Fc6oSF3rHrff2TQcGL/5fio/kRZ5Ji6Z0vMh1GZxX9wLg+DRTY3GU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7MVVy4rt5ppsm3MtFars5lUWM7AAX/srBwIEKtK5i/8KqwS8P
 VkuRvgseUHTcOChGHkpxqiiZJ9YtG6skU06Q2INnb/iKBhtSpD4ygl4mEUvMtAl36TLWix53Liu
 JPr3jZv3yKJJc100Sl9pagDPf6v1HgxZy2oWYja/Zz3C/ZB8=
X-Gm-Gg: ASbGnctlBCe0gxs368azF9uVxzicI7Tm6cTxtLKZMf4sN1WlNXlPoms4inHEMOcM0IW
 Q7XwdkoxxSL6dxFf87IVL9VWGPlcOV/CM/slH8f0=
X-Google-Smtp-Source: AGHT+IG4bGURoEDesF5L8guC/DS1xcfdEbTzrc2Aapl2KxnGoyzQjBv8I9o7cu2eTyc2TinHT1R+TR1NZxH4C1SEki8=
X-Received: by 2002:a17:907:c588:b0:ab2:c208:732d with SMTP id
 a640c23a62f3a-ab2c2087cbbmr2599519666b.40.1736990829498; Wed, 15 Jan 2025
 17:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-3-harrison.mutai@arm.com>
In-Reply-To: <20250115135209.13946-3-harrison.mutai@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jan 2025 18:26:57 -0700
X-Gm-Features: AbW1kvYcflTP5pS9LkNiEdCvjClIgop54a89S6Ol5Vr2NPygzfy8qVsC9Zh_gYo
Message-ID: <CAFLszTjS2mY1FrWM9dLAwOZ1soiOBP6GgMOYWwYQP6XPw9L9EA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] board: vexpress64: default to hardware device tree
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: Liviu Dudau <liviu.dudau@foss.arm.com>, Tom Rini <trini@konsulko.com>,
 nd@arm.com, 
 andre.przywara@arm.com, manish.pandey2@arm.com, u-boot@lists.denx.de
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

Hi Harrison,

On Wed, 15 Jan 2025 at 06:52, Harrison Mutai <harrison.mutai@arm.com> wrote:
>
> When booting into the Linux kernel with semi-hosting, use the device
> tree provided by hardware unless one is provided in the current
> directory.
>
> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
> ---
>  include/configs/vexpress_aemv8.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>

Thinking about standard boot, could we add a bootdev for hostfs? Then
we could drop these scripts.

> diff --git a/include/configs/vexpress_aemv8.h b/include/configs/vexpress_aemv8.h
> index 8020689e39..2341b3a938 100644
> --- a/include/configs/vexpress_aemv8.h
> +++ b/include/configs/vexpress_aemv8.h
> @@ -169,12 +169,14 @@
>                 "  if load hostfs - ${kernel_addr_r} ${kernel_name}; then"      \
>                 "    setenv fdt_high 0xffffffffffffffff;"               \
>                 "    setenv initrd_high 0xffffffffffffffff;"            \
> -               "    load hostfs - ${fdt_addr_r} ${fdtfile};"                   \
> +               "    if test -n load hostfs - ${fdt_addr_r} ${fdtfile}; then"                   \
> +               "        fdt move $fdtcontroladdr $fdt_addr_r;"                 \
> +               "    fi;"                       \
>                 "    load hostfs - ${ramdisk_addr_r} ${ramdisk_name};" \
>                 "    fdt addr ${fdt_addr_r};"                           \
>                 "    fdt resize;"                                       \
>                 "    fdt chosen ${ramdisk_addr_r} ${filesize};" \
> -               "    booti $kernel_addr_r - $fdt_addr_r;"               \
> +               "    booti $kernel_addr_r - ${fdt_addr_r};"             \
>                 "  fi;"                                                 \
>                 "fi\0"
>  #define BOOTENV_DEV_NAME_SMH(devtypeu, devtypel, instance) "smh "
> --
> 2.46.2
>

Regards,
Simon
