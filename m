Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C6BF43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 557C084368;
	Fri, 17 Apr 2026 14:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I3MRrME3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B7E88407E; Thu, 16 Apr 2026 22:54:21 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 899A283EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 22:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b9c745e18a0so3470566b.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 13:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776372858; cv=none;
 d=google.com; s=arc-20240605;
 b=TxTwGuJuu7Bv+Kiws9PRyNQoNPskTD9hqa8BITnF2/JPLQJY1K/UrjgyFEMREbj/Qe
 XMP5pnauJGsm0z/0C/2SDKeglyp8dPx4PTlqHBYPubAdFtaZmqpGS5Pjzfl/L43sJcdL
 zPPbVlHfaiYfjOrGMu7F/EzEzLlwNXoeMUuz6cdUdBbfBURMl6xBM7/ZNCsUbD9p70Te
 2m3Sn0TNISk3igR+CI0EGB1hK0hnkafjVDabdoGrMcGgaAvVZcN54DxWreIpiGoFEXyc
 nYTt89xjRfyn3FPY8s/9nEFojRPauZAWlnCc834GCrxy+AMz4cAwIf9O88aSaGJqzg0w
 5AYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2cCOY6qlTIZNLRiUAOtWtSm5VVh9LTxPa1jSFexVE+0=;
 fh=qhe+P1zBU0548ejKTaXQcQfiQCbxOitDwCoR2S/jUHY=;
 b=WgkBx4NkAU8prGizpXndkFBcFYowQ0CxfRMRQrelvHl4/2KOsGqmOXN2LxCDs/rmT5
 0OO0AkcbEBnmgaiNnZNs/FItu+3mULV6EYfXEQ5SHgLtxyLcbJRkQ6xigVrNVrA/kIet
 1kHTewHH0asWFjPRc9pZc0zG1j8DtGuljdQ40okNhAyr0Zz9lv1H7TaU75rMteSs87Wr
 SQ90KjXqVlblPZOvssLs5fyMNASUI779++JakV2R+5WeAGskEnOKmjUW+QrtX6xZIGA7
 FDSqAKHKluAjOMz1eCjJKbTvb+Y8eSyoNk+9klXG9dMUKc1Z0kkRhTPfi1U03dWg2BW1
 mD0Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776372858; x=1776977658; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2cCOY6qlTIZNLRiUAOtWtSm5VVh9LTxPa1jSFexVE+0=;
 b=I3MRrME3iroLcmFmeAmlJyKe+J+0dLBYYqkZo/c9HEtJ6ARCDT3LWp5pK79ADCpr85
 kn80C6YzeRCsZ3zPUgbLh1xYIXiMJN1a6G29R9rNuxdxF1mlY5PNfj9II3AlWmep/EjD
 LLW2NY/DsNvzIA+G6J/nxnLyOTglhbbrD6KjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776372858; x=1776977658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cCOY6qlTIZNLRiUAOtWtSm5VVh9LTxPa1jSFexVE+0=;
 b=IWuvaDOn0lRl63/rGqcYNuxnShcHJlhYobDh1b6PR3cdRaK+uLf8NB6yJTZTHJa5yr
 435OG3r5W7IFjAo1p8BOg855hredCdX3O0lV97XALH7dHU0s/HAI17mxdjS4jIGsCAaA
 Vi5+GXQEuCBkTEI7qsqefx/pFAauW2ZGMmG0J/oivX89n9U9HnlHWYUCNREFXtLpnDgS
 9Mtr5178RLUgnMJWwA04+cjIg46T6/jj3n03L6IzX9UvPMxlNfDQ5VtYjIqqIQpqw1Ib
 h2tEUWF16LBL2cLVzmDBbA87PkhpJfL3ZRaUN2FChwRzAQ6AQbBI8s70T7f+dFxv171N
 qPqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ//4XivdQ7dMfHYDTuQjk43ICMUZkzxGrx/PxAsom1iZuawy/iIhdNwNLEEYCy2Gt0NRilQjdE=@lists.denx.de
X-Gm-Message-State: AOJu0YyCBeQFq/UllaOKOHbqBX2b6Uy6AIAnc99JBOyhA0INHi+ngm6l
 ef9bO2OTBowPfIQnrmqHFGDEOqtAeBpLAbpLvgq6fEjt8CsGO8FAswt82jHZHdGnwUvm/IZDgW3
 eVjs+clXD/DWb6TlyYzRLIo/d3O0uH1By7+SAQl7J
X-Gm-Gg: AeBDievEGSSMKiXJ8nht+lL+P4tG2b+iirU97nGk5k5lt++0VwnIvJV+CMfzEz8qGqT
 jj4MxoIXG3LCqcUP/BT9Bruf9mVOMjsF+Nbl6wymMr4fn3irfexecSsV5jJqhOi2tsBjOaGcsx3
 r861ATgVi34m6taMPLF5E5tsV9eK55RGkjAC1/eflnB2GAk+4FEl/8wiD12YkHDvnR8ibZJ+jRE
 4aq+P1hY10FQocLJp2XwAp9XCr7MimJ/SEc3hf9fu06uutRHyRTg4r9+KxA2mJ54hEUMMkyiMEp
 JLbyu+V/hzYG9P4tscIf
X-Received: by 2002:a17:907:a088:b0:ba0:9335:b133 with SMTP id
 a640c23a62f3a-ba422add0eamr98466b.11.1776372857908; Thu, 16 Apr 2026 13:54:17
 -0700 (PDT)
MIME-Version: 1.0
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260416053928.2834699-8-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260416053928.2834699-8-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 08:54:05 +1200
X-Gm-Features: AQROBzDgqrrAsvIk3ZLUZBoNK1ElplIj1h2MmRPITeUsVAx6l-y86UZI8fSDO6U
Message-ID: <CAFLszTiWEDVwCFhQ9eMcYVeE3GkkFKOEw=Cif4HFT_LzJweQuQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] mach-snapdragon: spl: Update SMEM with boot
 details
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, tingting.meng@altera.com, anshuld@ti.com, 
 alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, dinesh.maniyam@altera.com, 
 luca.weiss@fairphone.com, danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com, 
 balaji.selvanathan@oss.qualcomm.com, adrian@mainlining.org, n-francis@ti.com, 
 wens@kernel.org, jamie.gibbons@microchip.com, justin@tidylabs.net, 
 ycliang@andestech.com, david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 richard.genoud@bootlin.com, michael@amarulasolutions.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Hi Varadarajan,

On 2026-04-16T05:39:18, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> mach-snapdragon: spl: Update SMEM with boot details
>
> Update SMEM with the storage medium from which the system booted.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> arch/arm/mach-snapdragon/spl.c | 65 ++++++++++++++++++++++++++++++++++++++++++
>  include/smem.h                 |  3 ++
>  2 files changed, 68 insertions(+)

> +     if (IS_ENABLED(CONFIG_SPL_MMC))
> +             *fltype = SMEM_BOOT_MMC_FLASH;
> +     return 0;
> +}

If CONFIG_SPL_MMC is not enabled, fltype is left uninitialised. The
function should either set a default value or return an error when no
boot medium matches.

> +}
> +#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
> +/**

Missing blank line between the #endif and the next function comment.

> +void spl_board_prepare_for_boot(void)
> +{
> +     int ret;
> +
> +     /*
> +      * Populate SMEM in coldboot (Dload bit not set)
> +      */
> +     if (!QCOM_SPL_IS_DLOAD_BIT_SET) {
> +             printf("Populating SMEM\n");

This printf() is user-visible during every coldboot - try log_debug() etc.

Regards,
Simon
