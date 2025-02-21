Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE44EC021B2
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 01:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26EA580F6F;
	Fri, 21 Feb 2025 02:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pq+PDxmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89ACB80F5C; Fri, 21 Feb 2025 02:53:22 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E6188004F
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 02:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-abb90c20baeso215092466b.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 17:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740102799; x=1740707599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b3aZhXNQISgTymBZIowYCu7gGTi4lS0RHCPOUoA8U7w=;
 b=Pq+PDxmVBxlCSSqG5SahlLYt5apcLQBNWLq+E93OVxSnMnIRNgOIKpTrhESf1zPETd
 6jbonOKoDD3kSKL06Kxg4I6xrtz2EFjl72iw28lqv8Kgzc8KUJGdQLtaQFP4MFv74X+S
 YC/B30o9XUKqwoTKRMlBacV5Qq13bggultlvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740102799; x=1740707599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b3aZhXNQISgTymBZIowYCu7gGTi4lS0RHCPOUoA8U7w=;
 b=ltvJ8jzllH2eHWt/wxdAg9fsH0vlWxVJhT9ji8urzPfgigE3CeBgge9lEfN3xHB1iJ
 gICT46LUZlGJ6Sw++TWpB7PuTCwybWbJ9vwy0SnzqSHrdHJak4pzERcoNS8YCZ9PinmV
 Z8ny1fV0umZ+3CieWCjg4plhCMyIeQf/SYGuPQc5MLZUmspeb8CCEBzOzkXvvwHnNPm9
 gPNMbnOlhkjZt+sgbpRuasvIzkvQXYCT/dklXpimkoNnCXynrw84L/AKt4VOMUmeK4xf
 SKrykalKd1FKSwddk4P9HozOJDgPmrAdOvMU14xDDc+erM/EVqruMKNBvWHqYQPEluem
 j/Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl3429UfkUxDfz24rQ58qsjHT2AgjtT4U8upx6nuS+H4V6IA+vEi1MyEBPMPhVuBzTFYlJIF8=@lists.denx.de
X-Gm-Message-State: AOJu0YwbJa+1Wau8rddioc7fwk4r1Mmhb3hWzCRuSTn6ca8qLGIhzPMD
 mmav3zA0Dc+uxPVfWlNft6CbzPjMMXHjdEctPkiOhULuV59NP21bqhb5G427gU9NpQlQrXJkVcp
 Fr4JH7nML/AzSmQ1GOL7zpfv7C/aTBSgMxBbl
X-Gm-Gg: ASbGncvoxAMSy5XUFr/sJhMw3Occn+q1JlggN54fm/I5BtzAm6rsGyA3KaxnTWBhw/O
 DKbWkQcSRxFs+ePfpXESEQSnIbvlZVoCuZ56WtJ4GkLT/vZOvTcWc3z6WyUDd2WLxcnRXUz8bmC
 i1LkwjNBoE
X-Google-Smtp-Source: AGHT+IFvlSRX4+mzASrrY8Snp0SMOLJsZN1+0ce2M/bK97Ka4ptmWoD9WZptZ4nS6eIiQJnl9eXtIyx2cc7/RV5tdMg=
X-Received: by 2002:a17:907:7705:b0:ab3:4b0c:ea44 with SMTP id
 a640c23a62f3a-abc0d97c783mr81957266b.9.1740102799544; Thu, 20 Feb 2025
 17:53:19 -0800 (PST)
MIME-Version: 1.0
References: <20250220-has_rom-u-boot-rockchip-spi-bin-v2-0-d1768ee87808@cherry.de>
 <20250220-has_rom-u-boot-rockchip-spi-bin-v2-2-d1768ee87808@cherry.de>
In-Reply-To: <20250220-has_rom-u-boot-rockchip-spi-bin-v2-2-d1768ee87808@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Feb 2025 18:53:06 -0700
X-Gm-Features: AWEUYZlvlpy22tIpSZ3rQKpn876q9C1ER-RRnpqhCcIoiI_a06oqltA2RBG267A
Message-ID: <CAFLszThAGyN4X4qDE5VJQ56oaxZ9tQ7MsdOs4i+iWZ5895CTqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rockchip: rk3288: do not generate u-boot.rom
 anymore
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
> This was only used on RK3288 Chromebooks and the EVB.
>
> If it follows the same pattern as for RK3399 Chromebooks where their
> maintainer (Simon) agreed[1] to removal of u-boot.rom on the basis that
> the generic u-boot-rockchip-spi.bin is now enough, let's do the same for
> RK3288 and remove the last Rockchip users of u-boot.rom (and HAS_ROM
> symbol).
>
> At the same time, remove HAS_ROM symbol from the RK3288 Chromebooks and
> EVB configs since they were used only for that.
>
> SYS_SPI_U_BOOT_OFFS offset in rockchip-u-boot.dtsi for the u-boot-img
> node of simple-bin-spi binman image matches the one used in u-boot.rom
> except for the EVB.
> The EVB doesn't have ROCKCHIP_SPI_IMAGE symbol enabled, so HAS_ROM had
> no effect anyway. Even if it had, this would not have been enough
> considering that SPL_SPI_LOAD symbol is not set, so U-Boot proper could
> not be loaded from SPI even if SPL/TPL does.
>
> Make sure u-boot-rockchip-spi.bin has the same size of u-boot.rom for
> Chromebooks as that seems to be important.
>
> [1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com/
>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/dts/rk3288-u-boot.dtsi        | 24 ------------------------
>  arch/arm/dts/rk3288-veyron-u-boot.dtsi |  8 ++++++++
>  arch/arm/mach-rockchip/rk3288/Kconfig  |  5 -----
>  3 files changed, 8 insertions(+), 29 deletions(-)

Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-kevin
Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-bob
