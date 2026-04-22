Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B184AF94CBB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 02:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06EEB84286;
	Wed, 22 Apr 2026 04:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bBKP6em6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D9918352B; Wed, 22 Apr 2026 03:13:26 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62CDE805D7
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ba3b9601b97so693894566b.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776820404; cv=none;
 d=google.com; s=arc-20240605;
 b=D4vvATHoerrGIyKLtdeVZLE7ludt5ImH+st4esM6qs74/exo/9t+xs+B0P12tVYrx+
 xrGX67fi8wmsZxYuKGPkjqJG9PVvgvJGI1px4nNtzKtG78g5rzavJaNDglRUzmT0MzWF
 fnK1wYb9xagodTwjYZo/DNhJmkYso2kCSNxbKqMihbzS7X/yagsMFszzJW3NuCEs4dks
 CUh3mprwGUm1i9ppT7Zru1T2PPhmR8UJ1u36YGA2cGhgz/FWQW0R1yakcaKNPhbN7NEF
 UP+EnTglEjxF36dAeC4+eAL+wDZh0RgrzJUu/bgHmtWLYuiSLbS7t/NqWfEgacIXqjgV
 cyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lJujimYNTDFFvBgXY9lC36+7PecrWVLWFW0o9Skg9hk=;
 fh=CcNfW6dIjL9WUdVhhW/ZJ0mqXisjz2Ordk1F8mJ+6zw=;
 b=YrdbCL6ZzvSKgIaGsHdSes4jxGPQvGUuUvTEYcwgcl7K0/lllHfk4kETpi7sqFuCQw
 1ApTOM4H1zFNPMEvE+duKoSgmsZaawFBM0PXpzrJOVS4C3YjXwp2vaCdhaHvyinJb7SJ
 +M/Go/HeHsDDDqSO+nawH16Nezog47QcWoSKyyr5PtzLzUMNJ5t6A1SVgAAY+j8frjrB
 gqMrdLLnky931nn/x3sFOE7AynyWfyygr6vp8yIOjP/g6+Fm6IxTKy7SyWT35wW9HhkM
 yZcD1MCKDrJ6fOqRzmkZMyNWMotEHAHsq4Igjwk7qATes7xuHI5lf9Qe6nJUhSPpjr9Y
 zrDQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776820404; x=1777425204; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lJujimYNTDFFvBgXY9lC36+7PecrWVLWFW0o9Skg9hk=;
 b=bBKP6em6xqb8T0qhlsJKKyiB+kJae5BFuoQLQO08Q4Fbpuj/wugYgO04X1L+8/dHD4
 lN7OYyxUetyixfV/OpGlKf1QFVAZNIIo5ngEqslqOcFUwSPJ0TaO40AN3R/EaFCkgxlR
 35iy4g6CiyOA1Ng6sUMIMH+Dr02PsiTQ3M1Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776820404; x=1777425204;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJujimYNTDFFvBgXY9lC36+7PecrWVLWFW0o9Skg9hk=;
 b=StxZpFMAmy6YDuAjkUnqoI0MUgGRd6az2i329g06z+1ljH1qy0dka/ezZsdguVBrkr
 SwdvBvF3B7hoJQa5FTa3iA4fSodsMTEcZerOmxPcd0G0lxr2FYqdCIV0BMUZCvdVu1tJ
 EXy+O1MxTPSEoUaeNKhfUfU9A9SG7uHiDPNtcAyEbhy840pX1rx7s6wYNlS6W1AZ9H6s
 Lp06aPE7kmYD5GKL6vC3AZZ3mZrH8OTcEoMZAUKbkSINihf0lt/1y8TQo0ENqfSZgQMm
 rAVQY9nGJkRnDDkGs8hgWg+2EM/9i6891RwuTDU9vQag3g5Lk7TpF+wsKTkEipIzL4Dl
 ONdw==
X-Gm-Message-State: AOJu0YwxYDXqhWlQ1HjnCyYu0WWi3IIGFz8V7hC4uhWzopC+BMOjEwps
 owwcD4RpBaBdXrA7se9M4GGpHXS/XB/Y2axJm4ULr3T4GssoHqpo3AeaKmVhHPSltrue2sYx67n
 6Yrkg+0yMu/6qKDTj6Gz+nlVgp0Km3kJ2Cux/w6rr
X-Gm-Gg: AeBDievkR7KuWjC+N4nyYIEUfyDmBuzHZQVhisMa9rJYwmx+2sArn0Ger5nAEcWQ8dU
 Si4GiI6LqK7+bAJAuxMoHpc4FObzv2+r+YV9e9rt+u2MloUIFogok2hK+2Z/P33EiPpz/+DfieK
 r58PsVyXlgy+ARNojUo1z4iPWePItMUC0mTxg/eRiZ1BhhuzZgRawcCLvq/gFZhICNxg6cVW4N5
 WOaxRwRKrsvTKvIyLTzjlu5/6ZQU46ehT12o3eyJRnVrzmUtAMyVTHzoldnJ9fl0xszahE8NM9A
 wBFfundcRwMsJ9D8zVHs
X-Received: by 2002:a17:906:6a19:b0:ba7:7f6d:be4a with SMTP id
 a640c23a62f3a-ba77f6dcc54mr650421566b.26.1776820403723; Tue, 21 Apr 2026
 18:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
 <20260421-qcom_spl-v3-7-efee3f76754d@seznam.cz>
In-Reply-To: <20260421-qcom_spl-v3-7-efee3f76754d@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 13:13:12 +1200
X-Gm-Features: AQROBzBAf5K7XY0os5AJFU1Z5GJTqJYU35XC8jvf5pouHCKYvdxn971yxOSyg88
Message-ID: <CAFLszTjxiGJga1d6pUCmoiRf9sUea8jJjN_yHRhsFDPoSPNGqg@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] mach-snapdragon: Kconfig: changes / additions to
 support SPL
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 22 Apr 2026 04:42:51 +0200
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

Hi Michael,

On 2026-04-21T19:43:46, Michael Srba <michael.srba@seznam.cz> wrote:
> mach-snapdragon: Kconfig: changes / additions to support SPL
>
> An SoC to target has to be selected, e.g. SPL_TARGET_SDM845.
> This will select reasonable defaults and enable per-SoC linker
> script (if required).
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> arch/arm/Kconfig                 | 33 ++++++++++++++++++++++++++++++++-
>  arch/arm/mach-snapdragon/Kconfig | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 60 insertions(+), 4 deletions(-)

> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> @@ -42,4 +39,32 @@ config SYS_CONFIG_NAME
> +config TARGET_SDM845
> +     bool "SPL targeting the sdm845 SoC"
> +     help
> +       Select this if you are bulding u-boot SPL for sdm845.

Typo: 'bulding' should be 'building'.

> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> @@ -42,4 +39,32 @@ config SYS_CONFIG_NAME
> +choice
> +     prompt "Qualcomm SoC select"
> +     default TARGET_NONE if !SPL
> +     help
> +       While U-Boot on Qualcomm platforms doesn't generally need compile-time
> +       adjustment based on the target SoC, there are a few exceptions to this.
> +       Currently this concerns boot0.h discrimination.
> +
> +config TARGET_NONE
> +     bool "Generic build"

The commit message says 'e.g. SPL_TARGET_SDM845' but the actual config
symbol is TARGET_SDM845. Please fix the commit message.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> @@ -1124,6 +1124,7 @@ config ARCH_SNAPDRAGON
> +     select SPL_SPMI_MSM if SPL

SPL_SPMI_MSM depends on SPL_SPMI (from patch 3), but SPL_SPMI is not
selected here. It might be cleaner to also explicitly select SPL_SPMI
if SPL

Regards,
Simon
