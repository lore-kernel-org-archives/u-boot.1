Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6398BF46C59
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8796E83F98;
	Mon,  6 Apr 2026 18:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Oyo0o1MS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA2983936; Mon,  6 Apr 2026 17:47:58 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1C9A8341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 17:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so623045666b.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 08:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775490475; cv=none;
 d=google.com; s=arc-20240605;
 b=MBpmtdDD6XV4iknxWVwI0OROCuaxllcxIjCvCXDjXHqZtqdyiSlsRSWK+3840UaeA9
 MGfWgKrOy9ydk+WC7uQzmKKaMk/qO3BbF8rwRSNscHMDsPevcHUh72CmNjKEfz1nuVCW
 FxIl9tEJEI98FzpY4c6fuN1uDrn6Zj5bqs6ctI3iNLRFNl56b6AwwNI3WfK5MBa2qRu0
 y1ZbcsjbuWUpZIkpJlsOqcy1ICPzHfo4WjsMh+4Zt1vN2EskYsYr9msrkTX4SMKV/GgO
 f1+ahgLC9AcAaRhTTT1YTNO9OLx0sSSn5ezdKZLmb7zH70Id1G92x30uPyQWivlC+sTR
 ASeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vC30gAlxhbkoONZB560oEoysJdu2OhtU1qSAT2Gzzvw=;
 fh=lajVl/IeoACZS/6yuLfZkN/hPyImAZ81vhSDRfkAdyk=;
 b=eJJrz7MRQMgzmVowoY+fmGnYyXEbli1tJ43o5YqXZuAlvNO2cZg0fFSlqvPobuqNZT
 ohsdSayEA/CWUFdk51UVqsy1QQYVhEvOdrXq8UQJrveI8KaPPq6+aG1JjFN5/dAN5M97
 Z6de6DQbVkFr1c8sbvqwjTvzQVmc7JSW+hEiP5CoyzKT6xpJtscq0hqSLFrKVIEu33XH
 /30YbtUhD9k17Xv+t5RBai9mwNFOFcgqP9Hx3hItmZD1gsUjXdg7k80OMbAKNkCTlCnb
 +02+NiEjZmXM6kP2Y+8jR0X3xQxUTJxG+ihCyFPAHnlt8DtCCx/VoeKeaahF0r6GhRC6
 7A0Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775490475; x=1776095275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vC30gAlxhbkoONZB560oEoysJdu2OhtU1qSAT2Gzzvw=;
 b=Oyo0o1MSKGubApEtQlD+g4NpvwZrkWtgLcNN/xEOe1cVu0e+hH7EOKX6RXmkgm8MKE
 OFhyTKoAIZxa+OF8hoVmOkC8xAroh52OZO02RhTkIcbZfjGw5zIEr2bMCumnia+Ci6/m
 gu+FoecJCWBsgDBntgCrtClA+AgIpLgprujA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775490475; x=1776095275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vC30gAlxhbkoONZB560oEoysJdu2OhtU1qSAT2Gzzvw=;
 b=bqTom+6UB+Yx3SSrVwaEu0duo+WOgbCZ8NAosEqISjj6zexBk5YWMOiKlAScDZrzKw
 A6GICKagJ7aEBMajCpiOdyAG4uwNZ2umoETgkSGA6QwFz4DikAHTU/Y2yALwrNpwH3Q8
 OnMsKxxhMa8R49ULgR4UF/bqeKJdmWq/wx2u5h5/Sjhj28TQbcOpbrcLavrlEFMH2+TR
 7sq5agtAl/KOKy0nduvBzCxn9z7mYgBiNPHXVdVfQNqniQz5rGYW39o5NBF9c9v4eTXy
 ihsypJCv6Ar9mb6EVwQojES1d8jsLnKwf8D55Gubm9p5g4Gs/j1y6XC4rrwm8GsH4Xsf
 bLMQ==
X-Gm-Message-State: AOJu0YwDocMvqlkF24AFzvuEp2qslMsSkpNsRLpg+6/BpPN0ocFU/9Cf
 WMzhQ9iADORFakszyGylBwujwgXMLU3N0fypyY9nV5/d9KXT4/RsP+04ZREK9xwLVUTFJEyHNkg
 D1xLoe710JBRoMt1TEuQ1A8vm7DVdiS32j//P/RXr
X-Gm-Gg: AeBDievPOy5/X30/3jcHU/CUbd7CmomdB0bEvKrg5a3yY3o1nnHJrdFDGIzqDNMGs0m
 Je4Jo/j2Q9Fzj3FJ5yoMUpvPoRvJ1n13msKvHVOluEtk6zzP5foVzaqmc5tFPEvKJiXfplNmhJU
 i+lwgaLmABGhN1ywz/3CglV/vOU6axgYtv2X8aW+a4BuGPbzGuFMIAc0pA6lzFHPZm1Zk61+g+8
 ywttZ0ULoEdofluP7OPSpHJ6/zO2DVwKk9GmWvx6Vy08PFO/5K4M+Tk1v05/iBpBld9uDBlK98p
 uUkJXAtElRXPRTJZ
X-Received: by 2002:a17:907:a0d3:b0:b9b:3a1b:e2ed with SMTP id
 a640c23a62f3a-b9c67957cc9mr669302366b.24.1775490475024; Mon, 06 Apr 2026
 08:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-4-9e6c2ac66587@seznam.cz>
In-Reply-To: <20260404-qcom_spl-v1-4-9e6c2ac66587@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Apr 2026 09:47:43 -0600
X-Gm-Features: AQROBzC5WBKftU5Gr4GTpl9txtzxILj6aQ5tlgHHjnXJE62qS2SgZpyVxIImBpU
Message-ID: <CAFLszTi=CUiXU5PD4aw_Mei+YMzJRE11RF8QhLEZHDJ=AcvWHQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] mach-snapdragon: support building SPL
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 06 Apr 2026 18:50:33 +0200
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

On 2026-04-03T23:18:18, Michael Srba <michael.srba@seznam.cz> wrote:
> mach-snapdragon: support building SPL
>
> Initially sdm845 support is added, and only usb boot
> is supported for the next stage.
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> ---
>  arch/arm/Kconfig                                   |   6 +-
>  arch/arm/dts/sdm845-u-boot.dtsi                    |  16 +++
>  arch/arm/mach-snapdragon/Kconfig                   |  98 +++++++++++++++-
>  arch/arm/mach-snapdragon/board.c                   |  26 +++++
>  arch/arm/mach-snapdragon/include/mach/boot0.h      |  61 ++--------
>  .../mach-snapdragon/include/mach/msm8916_boot0.h   |  54 +++++++++
>  .../include/mach/sdm845_spl_boot0.h                | 120 +++++++++++++++++++
>  arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds |  25 ++++
>  board/qualcomm/sdm845_spl.env                      |   1 +
>  configs/sdm845_spl_defconfig                       | 130 +++++++++++++++++++++
>  doc/board/qualcomm/index.rst                       |   1 +
>  doc/board/qualcomm/spl.rst                         |  70 +++++++++++
>  12 files changed, 554 insertions(+), 54 deletions(-)

Please can you split this? E.g.

- boot0.h refactoring and msm8916 header extraction
- sdm845-specific boot0.h with the EL3 escalation code
- Kconfig additions for QCOM_SPL and SPL_TARGET_SDM845
- board.c SPL support functions
- defconfig and documentation

> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> @@ -1,6 +1,24 @@
> +config SYS_MALLOC_LEN
> +     default 0x10000000
> +     default $(shell, printf "0x%x\n" "$(dollar)(($(SDM845_OCIMEM_SIZE) / 2))") if SPL_TARGET_SDM845

There are three definitions of SYS_MALLOC_LEN in this file. Only the
first matching default takes effect, so the conditional default for
SPL_TARGET_SDM845 will never be used. Please can you reorder these so
the conditional default comes first, or consolidate them.

> diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
> @@ -1,54 +1,11 @@
> +#if defined(CONFIG_SPL_BUILD)
> +#if CONFIG_SPL_TARGET_SDM845

Please can you use defined(CONFIG_SPL_TARGET_SDM845) here for
consistency with the line above and to avoid relying on the value of
an undefined symbol.

> diff --git a/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h b/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h
> @@ -0,0 +1,120 @@
> +     movl    x0, CONFIG_SPL_TEXT_BASE
> +     add     x0, x0, el3_ret_point
> +     br      x0

The el3_ret_point label is an absolute address, but you are adding it
to CONFIG_SPL_TEXT_BASE. Don't you want the offset of el3_ret_point
relative to some base, e.g. (el3_ret_point - _start) ? If not, please
can you add a comment?

> diff --git a/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h b/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h
> +     /*  */
> +     movl    x0, CONFIG_SPL_TEXT_BASE

Empty comment looks like a leftover - please remove or fill in.

> diff --git a/arch/arm/dts/sdm845-u-boot.dtsi b/arch/arm/dts/sdm845-u-boot.dtsi
> +&rpmhcc: clock-controller {
> +     bootph-all;
> +};

This syntax is incorrect - you cannot redefine a label when
referencing a node. Try:

&rpmhcc {
  bootph-all;
};

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> @@ -749,3 +757,21 @@ void enable_caches(void)
> +__weak void reset_cpu(void)
> +{
> +     /* TODO */
> +     while (1) {
> +             /* loop forever */
> +     };
> +}

This function is not guarded by CONFIG_SPL_BUILD, so it will be
compiled for U-Boot proper as well. Since the defconfig enables
CONFIG_SYSRESET_QCOM_PSHOLD, there could be multiple reset_cpu()
implementations. Please can you wrap this in #ifdef CONFIG_SPL_BUILD
or move it to a separate SPL-specific file.

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> @@ -757,3 +757,21 @@ void enable_caches(void)
> +u32 spl_boot_device(void)
> +{
> +     /* TODO: check boot reason to support UFS and sdcard */
> +     u32 boot_device = BOOT_DEVICE_DFU;
> +
> +     return boot_device;
> +}

Same here - please guard with #ifdef CONFIG_SPL_BUILD

Regards,
Simon
