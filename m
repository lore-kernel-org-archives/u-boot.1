Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFA2EE021A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 05:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB224864F0;
	Fri, 15 Sep 2023 07:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QMH8HA51";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B338684C; Fri, 15 Sep 2023 07:11:54 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76C01864F0
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 07:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-501be2d45e0so2946484e87.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 22:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694754712; x=1695359512; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sRdyvRPaNVoToIKd9QWa6d6rh+h8LSKR6yY66jCu9kI=;
 b=QMH8HA51OC59TF3OhQWYYLJmEGOHKodgh0w4wzACDnHNrfSpBrUjXIkhuOMnK5pFm/
 4WMK6F7q3//fptkdIOhes1Q/cFcPNpwSRGlnV6K7UtcnjyGj97kzRoks+7jGCd5qP/tL
 Op0sZyJ3XNzKc8TfA7GXP2BVy5r/7sWXs0ajrzuMcXGclTHJS0NMtm63NMkFLC+ervFr
 6G/7z7ZJA5wPFqXqg2Vwe7Qr7fCH12CntzqA4kaTEeMl07TDA0frIxlWZdqtxnUAWz96
 PuQ66AtD0yIQyk/m9m65cJhdJIamdR8+AV9JuBBGBsSDOFJamIEaM5lV5jsxe8QgVvgy
 AYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694754712; x=1695359512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sRdyvRPaNVoToIKd9QWa6d6rh+h8LSKR6yY66jCu9kI=;
 b=N0flAsmZ85Z/nAbWKbEmSS/lAwXXve9ghT4Ju5Cp2ykxlC270s02i8evTAcdD5Egp3
 ko1WqY6EHS98hWTeL18U1MKEdRjtZrxH0kGbbhN0xt7dKRWVpE8XGtMMMbw4aGr0J9Ad
 jnnA2oVz9KGbPs7pjpqsMtjv4nVT7J10Mj9D/9H/S51jcUl0EeFsJGRymXVAM53PBdjI
 cg65NzCMJqQmtNdoFLitHcN/Dge2iycx7zl9aYdoXzWQuF9fpdEBPueEXPculSKSbQvF
 xWytXN2e8GILqHGXp3bGA2W2nTVln1V+tP/o6Mi1G3NyXy57TyZn/fXbZhi+XQxT5jvY
 skHw==
X-Gm-Message-State: AOJu0Yzk5D7s4ewn0T9Hpx/DMTMaX91um4Zt4wWL8uqbQsMHlGIy5UIq
 qWFCoRhOffRBQcagzrezzXskaOKTLdsmuJGzF34QTw==
X-Google-Smtp-Source: AGHT+IEml86uJnzWPZKpMXBqVQaM/2scuGkGoonY+qSyqixlkz+5T9EYLBTqNWqyCVVzf6knKaVhXohvbG/RinMjdIA=
X-Received: by 2002:a19:4f59:0:b0:500:9a45:636 with SMTP id
 a25-20020a194f59000000b005009a450636mr512856lfk.13.1694754711061; Thu, 14 Sep
 2023 22:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230914165615.1058529-1-sjg@chromium.org>
 <20230914165615.1058529-5-sjg@chromium.org>
In-Reply-To: <20230914165615.1058529-5-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 Sep 2023 08:11:15 +0300
Message-ID: <CAC_iWj+uCm8vk4SB6=UcHLqDX+RN0bPUuYJR+XFMP5ENH8c9YA@mail.gmail.com>
Subject: Re: [PATCH v5 05/21] FWU: Avoid showing an unselectable menu option
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Brandon Maier <brandon.maier@collins.com>, 
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
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

On Thu, 14 Sept 2023 at 19:56, Simon Glass <sjg@chromium.org> wrote:
>
> Use a menuconfig to avoid showing a menu which cannot be selected in many
> cases.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Drop comment about an update/ directory
>
> Changes in v2:
> - Fix FMU typo in the subject
> - Drop now-unnecessary depends on FWU_MULTI_BANK_UPDATE
>
>  lib/Kconfig             | 4 ----
>  lib/fwu_updates/Kconfig | 9 +++++----
>  2 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 9addcfab373..bfab2f3165a 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1118,8 +1118,4 @@ config PHANDLE_CHECK_SEQ
>
>  endmenu
>
> -menu "FWU Multi Bank Updates"
> -
>  source lib/fwu_updates/Kconfig
> -
> -endmenu
> diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
> index 71f34793d92..d35247d0e5d 100644
> --- a/lib/fwu_updates/Kconfig
> +++ b/lib/fwu_updates/Kconfig
> @@ -1,4 +1,4 @@
> -config FWU_MULTI_BANK_UPDATE
> +menuconfig FWU_MULTI_BANK_UPDATE
>         bool "Enable FWU Multi Bank Update Feature"
>         depends on EFI_CAPSULE_ON_DISK
>         select PARTITION_TYPE_GUID
> @@ -10,24 +10,25 @@ config FWU_MULTI_BANK_UPDATE
>           multiple banks(copies) of the firmware images. One of the
>           bank is selected for updating all the firmware components
>
> +if FWU_MULTI_BANK_UPDATE
> +
>  config FWU_NUM_BANKS
>         int "Number of Banks defined by the platform"
> -       depends on FWU_MULTI_BANK_UPDATE
>         help
>           Define the number of banks of firmware images on a platform
>
>  config FWU_NUM_IMAGES_PER_BANK
>         int "Number of firmware images per bank"
> -       depends on FWU_MULTI_BANK_UPDATE
>         help
>           Define the number of firmware images per bank. This value
>           should be the same for all the banks.
>
>  config FWU_TRIAL_STATE_CNT
>         int "Number of times system boots in Trial State"
> -       depends on FWU_MULTI_BANK_UPDATE
>         default 3
>         help
>           With FWU Multi Bank Update feature enabled, number of times
>           the platform is allowed to boot in Trial State after an
>           update.
> +
> +endif
> --
> 2.42.0.459.ge4e396fd5e-goog
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
