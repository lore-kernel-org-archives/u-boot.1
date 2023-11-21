Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B36C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 20:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CC9487253;
	Tue, 21 Nov 2023 21:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XFN0vdth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01B68747E; Tue, 21 Nov 2023 21:27:12 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDB43871CD
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507cd62472dso174250e87.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700598430; x=1701203230; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2CegMM8P5WFDVtiQgWuqAKEjyya1Xvd3jPRM1KljiwI=;
 b=XFN0vdth1zjfZaOSodgwzbgfV67ApaNMkh8ct52CkDTHkKEngaGKrdcJcqymBUQG53
 p4QktydZE41wgJD5EkMixbKCnjVSHA0F7/2SBd4OBF26E/RB+CaFmZI5VpjiyJTAcACu
 g8mfacT/9coV8cako27dyyYfRvFm65/IQaw/9hksBKkIf8ofqx3mqhjJQ2qW01wiXTlP
 z34wFQC8voufS4huMo/nGIKXo7A7I29nBh4tfUuwuUBtfqvOtKysXPI6kWtilBIvLAIC
 gGYeDe2KUPv94OWhSP8cDoyrqGEqPS6JZC2MER25Pz4QkLpUCtdZsS22SemW1kPE8cR6
 mFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700598430; x=1701203230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2CegMM8P5WFDVtiQgWuqAKEjyya1Xvd3jPRM1KljiwI=;
 b=gH1atOA906Yf2Lq7vPzKmAxtnmpWmm5EawalU7g7LIwrmbb73GdbLCLBvmqWHfasO3
 JsU4q/N7TV1T+b+LNOasr8EzChG6GGGoggG5L64vMKRbn1l8sNt9xsYFrda9A7iJnpPm
 xqtlrtYMgnvjpl2JyVF2JGG7zXcxnPBn5M1+TheapdpG/kik4O+owYiPKTKRlo5gU54t
 jjMJRrYKcDtP9xJ9VB33jsS0karxMdXvyF3enax5CZTvOAjpaP9QQhkEFEIMBKAb2Gyr
 Nwe3k6rWqtiJmvsFAz2wsaPpQ7Su9SBIFKUszpOetBaAU/g8ZqEiNHITo2t+fSVc2KH+
 vA3w==
X-Gm-Message-State: AOJu0YxMYQQQq+7aApGxzoAA3g0ma7k6+c3R14KlCrKe1ltEUmExKQyB
 E9BuMPaWlJJcjUnNWD3uyE8tTb4Q3I3g1U2ZMtHbJQ==
X-Google-Smtp-Source: AGHT+IGeu10ZJCAVG6QQnBIZsQEmyvDKYtfyNlh8uqu6wFvw6Tp0CKQdy+1CdbdxGvvs0x3Nj14Hud26ZzAorgBqSsU=
X-Received: by 2002:a05:6512:124e:b0:4f9:dac6:2f3d with SMTP id
 fb14-20020a056512124e00b004f9dac62f3dmr178835lfb.13.1700598430069; Tue, 21
 Nov 2023 12:27:10 -0800 (PST)
MIME-Version: 1.0
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
 <20231121152740.24783-8-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231121152740.24783-8-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 Nov 2023 22:26:34 +0200
Message-ID: <CAC_iWj+jGQeOuf9obDwTiHY5X=4GagPT5ZLcXUpzFu_-WSTCGA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] configs: qemu: add config fragment for ACPI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, Miao Yan <yanmiaobest@gmail.com>, 
 Asherah Connor <ashe@kivikakk.ee>, Tom Rini <trini@konsulko.com>,
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

On Tue, 21 Nov 2023 at 17:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide a configuration fragment to enable ACPI on QEMU.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  MAINTAINERS                         |  1 +
>  board/emulation/configs/acpi.config |  3 +++
>  doc/board/emulation/acpi.rst        | 23 +++++++++++++++++++++++
>  doc/board/emulation/index.rst       |  1 +
>  4 files changed, 28 insertions(+)
>  create mode 100644 board/emulation/configs/acpi.config
>  create mode 100644 doc/board/emulation/acpi.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7c1cb2dc4d..9f443674cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -53,6 +53,7 @@ Maintainers List (try to look for most precise areas first)
>  ACPI:
>  M:     Simon Glass <sjg@chromium.org>
>  S:     Maintained
> +F:     board/emulation/configs/acpi.config
>  F:     cmd/acpi.c
>  F:     lib/acpi/
>
> diff --git a/board/emulation/configs/acpi.config b/board/emulation/configs/acpi.config
> new file mode 100644
> index 0000000000..b7ed811e33
> --- /dev/null
> +++ b/board/emulation/configs/acpi.config
> @@ -0,0 +1,3 @@
> +CONFIG_CMD_QFW=y
> +CONFIG_ACPI=y
> +CONFIG_GENERATE_ACPI_TABLE=y
> diff --git a/doc/board/emulation/acpi.rst b/doc/board/emulation/acpi.rst
> new file mode 100644
> index 0000000000..e1208ca51e
> --- /dev/null
> +++ b/doc/board/emulation/acpi.rst
> @@ -0,0 +1,23 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +ACPI on QEMU
> +============
> +
> +QEMU can provide ACPI tables on ARM, RISC-V, and x86.
> +
> +The following settings are needed::
> +
> +    CONFIG_CMD_QFW=y
> +    CONFIG_ACPI=y
> +    CONFIG_GENERATE_ACPI_TABLE=y
> +
> +On x86 these settings are already included in the defconfig files. ARM and
> +RISC-V default to use device-trees.
> +
> +Instead of updating the configuration manually you can add the configuration
> +fragment `acpi.config` to the make command for initializing the configuration.
> +E.g.
> +
> +.. code-block:: bash
> +
> +    make qemu-riscv64_smode_defconfig acpi.config
> diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
> index 932c65adeb..d3d6b8f3d8 100644
> --- a/doc/board/emulation/index.rst
> +++ b/doc/board/emulation/index.rst
> @@ -6,6 +6,7 @@ Emulation
>  .. toctree::
>     :maxdepth: 1
>
> +   acpi
>     blkdev
>     ../../usage/semihosting
>     qemu-arm
> --
> 2.40.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
