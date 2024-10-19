Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635A2D3C906
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 11:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E3668924B;
	Sat, 19 Oct 2024 13:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eosEvxUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7BEB890BC; Sat, 19 Oct 2024 13:50:09 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6AE088F68
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 13:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cbe53a68b5so16618716d6.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729338606; x=1729943406; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F728wAigxfZ/rGbqY+9iysKfa839blUtNZew5Iq/Dds=;
 b=eosEvxURdEnmetWw2HxgWc1tYoVeh+NmplA0TgpaEpphgUgN4LQ+/X/mI5pFEIW7NA
 baK6sO6NtJZAgyQaQCdymqxtUUs0y6N/n2JaZW70Px0XxB02P0HN/RnF2MzUm2/WZfmK
 kUSPXsYas9YQY/f8AvE5Y8VtkvJ5qIcSq4GxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729338606; x=1729943406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F728wAigxfZ/rGbqY+9iysKfa839blUtNZew5Iq/Dds=;
 b=OWePyzkAaXnl9E+NtfyGSZHE9+Oofmb5hPDost4RXdjDxnBY7tQFlwtOrWE1CoW0Br
 owY9m8wcCFZDPhYmm0I+fTNGJO2wCe3Wa+6xhcwoK2pwjRP2++WgI8aBFdgVqV2LacGx
 gWGceBueNKi+2ENKchqIsXZU9Vrw1CNCIlLaeNm/Ko4hTesJHJ2kUQultcR2FXoynSC8
 NBkmSIFBT+0CEBX3isSaLtA54Ik0msvf2PMVMPkC7C6QAxjy86Aes5MLJba5aSpBOj1V
 FIxKfQwLm5YQ/oKv0qaAnSuHKmcqpgtqRZKRB4mjHQ0m9JdUdJ8qrWHrbat03z4SbPQ7
 8a5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjhDkOWAb9YW1Q8D1O1Y2i/5VaUdqkKnQFyNqJRR5AoouPwVeD6C9a7wdMO0u0KuB+0bMlf+M=@lists.denx.de
X-Gm-Message-State: AOJu0YwPlvPo4nH7U/UB/7R9anOXtwZg/+/9nvAx5EHyP+PKYnzI1iGV
 N3ccFQ0rLv27z40uUU2+k6dDzpXZx//5dRYRqJS/suIdDIa/2cZHYZehHezJEW1fyOHheWC5Wka
 lM7CMaLBPmjL6/mQ6ZSfklzt/OR/cGtx9LQh4
X-Google-Smtp-Source: AGHT+IGOabEwNZOTAhY+JT2PbSfWuG/j/OjC6vHPIMbbKO3PuTBRM3RtHxW+Lg4s3+li8hcx/66CzmiruXXKyJ9cpr4=
X-Received: by 2002:a05:6214:328e:b0:6cb:f561:2a83 with SMTP id
 6a1803df08f44-6cde1632fd2mr72824446d6.43.1729338606210; Sat, 19 Oct 2024
 04:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241019105957.54751-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241019105957.54751-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 19 Oct 2024 05:49:55 -0600
Message-ID: <CAFLszTj6QjZyE=cUhFFy9dQ9pBbQqQa63BpzWAtJSOOtBuUEmQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: fix CONFIG_EFI_HTTP dependencies
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

On Sat, 19 Oct 2024 at 05:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> CONFIG_CMD_DNS and CONFIG_CMD_WGET depend on CONFIG_CMD_NET.
> CONFIG_CMD_NET depends on CONFIG_NET or CONFIG_NET_LWIP.
>
> We shall only enable CONFIG_EFI_HTTP if there is network support.
> We have to select CONFIG_CMD_NET.
>
> Fixes: d7d07a8b508b ("efi_loader: support boot from URI device path")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 69b2c9360d8..066f0ca0da7 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -545,6 +545,8 @@ config EFI_BOOTMGR
>
>  config EFI_HTTP_BOOT
>         bool "EFI HTTP Boot support"
> +       depends on NET || NET_LWIP
> +       select CMD_NET
>         select CMD_DNS
>         select CMD_WGET
>         select BLKMAP
> --
> 2.45.2
>

At least conceptually, we should be able to get a file without needing
commands enabled. If we have to do this today, that's fine, but it is
something to improve.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
