Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815E2C021B2
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 01:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D6CA80F67;
	Fri, 21 Feb 2025 02:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jW84KoyA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F010A80F96; Fri, 21 Feb 2025 02:53:25 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52D138004F
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 02:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-abb81285d33so323396766b.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 17:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740102803; x=1740707603; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D6xvZ2Gc6UkvDTWrz+d+hgSe04GHCkhTICBkYFkFXTo=;
 b=jW84KoyABRmjk+K6Eh1kJv6EpctZM7rnAwQ01ns/M/htiUCRWqbg8L97EMiUjhCvlP
 4F6SAmzncHL7x0gGMl77VoRxiJ5Fg4EBNg1irDgrPmytnr0Ytj3uMF9yQhs4lKGYUYEy
 TXDUNrizj0N1my1w1ZzQF1CmGPbf/eZIZcKnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740102803; x=1740707603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6xvZ2Gc6UkvDTWrz+d+hgSe04GHCkhTICBkYFkFXTo=;
 b=IUkIHabbxyqC7orXCi1xRgekBYt8+vTAVyuRFfZt4V9vAvjzQ7Vsf2Tt6nZSuf+NGd
 jjU2b4dBM7L2nv3Vzzi+oKku3JGVxbnyDi8K07L6/Q0zKA0JQgec7473sht2VJc1DjzM
 H1UaUT1CcXOuBzTOVdQJwB/sHvP8YgvQcGOSFP04UtCHr0JCWgxBgslloxxnl2YD0z9b
 Z4UcSbI2btbv4D2L65ncAHjCTJeh6ELKY8MdUPH5Dw3N664S0dpSWRTtcgrGBaTnr9t/
 Tjy4KzuH6ajp8n0+1QQIw7Um4pA9xq3joRMPlIZp9KxtuaG8+Jn5e2p+FaH8zHZNiuQv
 2L0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8ZbXHe4UZ4u1lFVaImY+Z/XEp2qsSo7072f62WWxjqSL2BtSCIdnk92sMz8NRDxgdFSyGSgM=@lists.denx.de
X-Gm-Message-State: AOJu0YzhE3v3xq7i0l+q752cUXKZZjOsvCNZZm4Q1ZxS0D8WHfhuxTXd
 yVT9ArKLM9RAE+aKsIw7OO5hxgrr8NkJHdAY4PvFs6nR+bDwB2WifzKedCKgwVXlnaYYpgcJkJ5
 chfk0alUJPo7a2oEHWaale+oIE+hNZmx3c95n
X-Gm-Gg: ASbGncuACVTCzagz0ZxKYVpsclgcZNsFA262IBBHIvnMptIa/gcDx5ZKt8rOEfbkuTQ
 Ew8LCeu5YHpIZQMHXmZ6pwapDiYxHV96iKOc7xNnatJ90yLP6cbpDS2SrrgRkWltiKVSRSdYW7o
 ahAkErLMvi
X-Google-Smtp-Source: AGHT+IFRA4wX1uLkn0Szuc56WERCSBKFNK59hcZc3FHCPYpsFQ5Nkv+gQXrybDF+0D8xh0+jloXwQoltY9mwhfN/hJM=
X-Received: by 2002:a17:907:7754:b0:ab7:cccb:ae2b with SMTP id
 a640c23a62f3a-abc099b7f67mr142900566b.4.1740102802767; Thu, 20 Feb 2025
 17:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20250220-has_rom-u-boot-rockchip-spi-bin-v2-0-d1768ee87808@cherry.de>
 <20250220-has_rom-u-boot-rockchip-spi-bin-v2-3-d1768ee87808@cherry.de>
In-Reply-To: <20250220-has_rom-u-boot-rockchip-spi-bin-v2-3-d1768ee87808@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Feb 2025 18:53:08 -0700
X-Gm-Features: AWEUYZnH8aGEVYCEMoaJVKKpR--6TLXNdIpa7eHCk_LtIfVsCxqo-D8e290juz4
Message-ID: <CAFLszTgr+v1jXoGOv-Q4VXFa9g4DEdvE0z+7DEB+G0DLMoLvaQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rockchip: avoid rebuilding most binaries for
 u-boot-rockchip-spi.bin
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

On Thu, 20 Feb 2025 at 09:56, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Essentially the only differences between u-boot-rockchip.bin and
> u-boot-rockchip-spi.bin are the formatting of idbloader.img which is
> handled by mkimage (via -T rkspi/rksd) and the offset at which U-Boot
> proper is flashed, the content of the binaries are identical otherwise.
>
> This fixes some issues[1] where binman tries to find the symbols defined
> in the proper binary to install them in an xPL binary. However, because
> we use the binary for proper (on Aarch64) generated in simple-bin image
> node and not simple-bin-spi image node, binman doesn't have access to
> that symbol anymore. Therefore, let's depend entirely on binaries built
> by simple-bin in simple-bin-spi so those issues do not arise anymore as
> nothing is compiled essentially, just assembled.
>
> [1] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/dts/rockchip-u-boot.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-kevin
Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-bob
