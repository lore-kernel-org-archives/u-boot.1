Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72F8CF6499
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3353188E19;
	Mon, 30 Sep 2024 14:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Udiv6XNQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF1A588B27; Mon, 30 Sep 2024 14:05:56 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE09D88E3F
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-710dead5d2aso2629077a34.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727697953; x=1728302753; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vBU7M9VQ55Y/qRVJdGBBQoPfvQ+CtZ8Jj/f9RtQSyhM=;
 b=Udiv6XNQFxno1bKlzHAbYxt8ZN+GC+Snf8nym5SjTM9xNWB94Q7pIxystwlThC9B7X
 /Rji14HQIkSam4EynmH2x7r3xd4LzIPgB0o0V+0Y7YHyF/KS+N9Tkj8lsdo5xiYf3RYn
 RMOCLSytFqRKKfw4Z8Tlk41Ka4tuArmhf5wWjMKVPAjnOyUgnZuTIfyW+evlTImHHHE5
 UPn2N7oaKDnyuVKZ721ubVnZqadRN/MNZTzabywX75HJ9E4S8t6dgIMy9cjBhxhZUV5L
 qd44Qt/VWoquFuxhPf6Hg1NBI708WIwYWDVS4sYsvLb64C2rN/gG3WZuJlByDh24c5xv
 Rd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727697953; x=1728302753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vBU7M9VQ55Y/qRVJdGBBQoPfvQ+CtZ8Jj/f9RtQSyhM=;
 b=FdCapEQQBCd8k3XuCnCT5xdWaYKvRTBoUwhkSyesn/tTuH09ZNM0UjDNbCNLPbn4wH
 C76hRDFz4CGyZfXBSJB/vIM8La2gkJwuym/ZskyvpY+bkDEf/srv2WneaCpJxf+WoQjK
 NCW8ancnhpQd+y+68MZjrVhDXqhBhFxPbNYY2C5deyN1K0LRF0xY5x3dMKY2npgPubiE
 MYRcOnz839kgg/z9R1qino+CSjDxI1JdPzZLufKNAb4ARsb6VC5l59sc/WPvcbdi+vn2
 66oFqruvQDM3khRRedLzCaYaTgoUkCsertmIQgGOBcKTkDbE6rf5CS+FWmzc9X4XosCG
 +Q3A==
X-Gm-Message-State: AOJu0Yx33QT6vtnVakBP/rn05pLbCoUWJfzybb2xjz/Y5dU5bOpnu9Cy
 PKrs73yr+I4uNy5ATNJTatmilhu+GY8V9vAWpvUpOX64KmUDo/GlFpDGpfPPJ5LKpdalNm6+LUc
 h8vA41ytOT8Crs3b2NOTFa/m1SXQf7KiAosn2cw==
X-Google-Smtp-Source: AGHT+IE5caeJREp0CtJr7MGYkroBPva2rGIslSg7llZSdEPpNp9WwOVja0oFY+4emTMtRvzWJQA44lZYFWCMRcO0Az4=
X-Received: by 2002:a05:6830:6e96:b0:710:f0bf:9799 with SMTP id
 46e09a7af769-714fbeff96dmr7040743a34.21.1727697952603; Mon, 30 Sep 2024
 05:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <a54b501a-9a98-426c-a5ca-faf547411a30@siemens.com>
In-Reply-To: <a54b501a-9a98-426c-a5ca-faf547411a30@siemens.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 30 Sep 2024 17:35:41 +0530
Message-ID: <CAFA6WYOAYQ26vAT8=Z74N6EJ3HcvqmiwshxGkMVe5oQyAfFrrw@mail.gmail.com>
Subject: Re: [PATCH] Extend usage for OF_OVERLAY_LIST beyond SPL
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Frank Wunderlich <frank-w@public-files.de>,
 Jonas Karlman <jonas@kwiboo.se>, Nishanth Menon <nm@ti.com>, "Li,
 Hua Qian (DI FA CTR IPC CN PRC4)" <huaqian.li@siemens.com>
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

On Mon, 30 Sept 2024 at 15:50, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Allow to use OF_OVERLAY_LIST also for the case that the overlays just
> need be built, e.g. when they will be picked up by binman as artifacts
> of the final U-Boot image. The IOT2050 boards have such a need when
> switching to OF_UPSTREAM.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> While waiting for the merge of v6.12-rc1-dts and while seeing related
> but different attempts to address the overlay topic. See the patch
> in use here:
>
> https://github.com/siemens/u-boot/commits/jan/iot2050
>
>  dts/Kconfig          | 4 ++--
>  scripts/Makefile.dts | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/dts/Kconfig b/dts/Kconfig
> index 569d4be338e..7ea4fd5a79b 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -226,11 +226,11 @@ config OF_LIST
>
>  config OF_OVERLAY_LIST
>         string "List of device tree overlays to include for DT control"
> -       depends on SPL_LOAD_FIT_APPLY_OVERLAY
>         help
>           This option specifies a list of device tree overlays to use for DT
>           control. This option can then be used by a FIT generator to include
> -         the overlays in the FIT image.
> +         the overlays in the FIT image or by binman when assembling an image
> +         that uses overlays during DT fixup.
>
>  choice
>         prompt "OF LIST compression"
> diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
> index 790f3c508f1..dc181240a21 100644
> --- a/scripts/Makefile.dts
> +++ b/scripts/Makefile.dts
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0+
>
>  dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
> +dtb-y += $(patsubst %,%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
>
>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
>  ifeq ($(CONFIG_ARM64),y)
> --
> 2.43.0
