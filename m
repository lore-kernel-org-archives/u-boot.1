Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8AFF4369B
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE39384353;
	Fri, 17 Apr 2026 14:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dtVdbNMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00B748407E; Thu, 16 Apr 2026 22:53:38 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B0A783EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 22:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so2620366b.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 13:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776372815; cv=none;
 d=google.com; s=arc-20240605;
 b=L47EMcUuv+WBzhGt9I5deNKGE9Y07aDbQ1aaJdtkLQn2bhrSnrViUu2cIMOUcRz5dA
 aM1Bacy9L7wMlrv20yJjTVG9gw3bc0Hd/IBDK1C+axLNHOTigh2R55TsA9W+asPDa1vF
 ihoq35pErbvoWpWyK67ciJxjK3SO4A/u0qyiZVjDzmAPWdSBdLbD4p5cHHjT3O2wDjbm
 ggZPmHbNnaC5t5YEdppQ5CSkrEvPIQkH+vClvLnif7FvfAhmjjLlvXgEiuHADN60GbwX
 lkM6q8j9xPHDokIwBVoqkFdgh6ojWj4SyXveWmwBN2uCWtxQe/ZIQetyR8+ij7Hew7CQ
 FIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gu4feCICSDPImOCHAm02vNn9Z4WEP3cVTBxFGL2ZEGc=;
 fh=hHTO6f4nuEnxFL3rCec6fxwnC5MEplwuDaj8wiynJ0E=;
 b=DpwwqRUMNj6g8tC7zph4e0vF5ZF3Nz97d2v0ALdyuLZzEdsCzZJOPYX5QpyGYLyg0A
 pzPxQQ0KXzg3BS0cKlWoNKzJVrNzeLWcGXA8A/qn4rXCv9Ao7Iyf6iShg6exWI6jtE4t
 DM+mRikKgoga0mphoHx9L2cTvCeKB9bjZf0VNKum0Aw+OSSO2URnEMpiE0KnoUvhJonM
 GuQyg4+jJWHg6l1e46MwjFBYITsiQmJwMsBhpLksAxHK6nluF5PsnERJUjXbIIEaoj0O
 HLE/qYuFzDAABEtWWc6ZJow1RPBs69SvC1OdANSOxpWMY3zRWhEw/1AmpRYVsXrCBbac
 TSZQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776372815; x=1776977615; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gu4feCICSDPImOCHAm02vNn9Z4WEP3cVTBxFGL2ZEGc=;
 b=dtVdbNMmQ3I3RSqu9E74Ba6VJI7p7J2e0CM0zvu5ae08mcdfLR8XIzLSrod5k8rcOT
 pQlfiHA+7MjDGu+q5Aewul/ByFIesv+SCzbUrLgJpZZSJ43HR9OMhoY8uJd4F+7141Dg
 /XyTiKBbkOLx4/1vW9LmJ3m4qCcmSQOeCvjRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776372815; x=1776977615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gu4feCICSDPImOCHAm02vNn9Z4WEP3cVTBxFGL2ZEGc=;
 b=oYh5+3eb3wrmgyd/YI9Xj5zFXMroB7rODCv9znQczMIHGoSN0yW87GnxVRiW8Sk1ul
 MecBNQrdWBGBnpoYilPUmc1cQGMijb3LyfyJhnVBjSlpnXZEYFaoJbu3OoQ7U+Aurg5I
 QToAZaUO00Isolj/lMLIPgl41sxPIcsMfsulL4ys0JHckWMuhdZp3M5A1Rh3ytVjU/OM
 Ejpv7hIAPW8+eDxzr+1G5QFPf+DJT/QqQ2eau+5gKH1D8K1qyH1XxWWmQTBRP6pk5HLn
 qQJRU6871NVPYuAyfKmreI0vJc6iX6mH8GB1ppG6yGjB0kBRYyvxhThwRN2t5N+/T18M
 DGsw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kxsF6p6IY4x4zaZg9LMfUFF/CwIvj5SDs80FBEofqu72iPt0yN+fWQZRRkQN/wLNagGMg2ek=@lists.denx.de
X-Gm-Message-State: AOJu0YwWiJB1E6GqpZIeam55J2v0XfOvr0avMDE2hS6CAkBu5wtprlgo
 YAHoAJjkeXra7zlZ0HraW2Z+yi4tlnS+B/y4b5yqqISG4C0QjI4U6sUPS9O+R7gMkfVJfEH7d5L
 g/I12yJdb+8E5nJEPAAI2D4HKkqY47QiO+J8y6JgN
X-Gm-Gg: AeBDietfmF8AQv+URSyTvjiHIqtqGZFGZBsYhPE2Rur/vdRecc69bsjnoEnLsyWx6Og
 gbQOIRiYO+nPhy6Tp6pcUmumAhKYbnOlxiJjYPRBO7jT/1k+fykrd/O568V4/jgTkuJcnh4VeQ3
 JX2GdNWhAIVP4DY5mY8pEF5GIDglFMqe9JCbzV5W8W05WHHXGAuk9srRG9J386HDBZHaYy/nFgf
 2+pIBfWMu5YOYnqPJLMTS/u94+o5rgM5vDpVRyO0222Cds5Tya9PYBufNGS2qBeOZmkyveLA02D
 nhjdyPfwYx2AkdxuCFRh
X-Received: by 2002:a17:906:8e14:b0:ba1:43cd:1b76 with SMTP id
 a640c23a62f3a-ba419171316mr6654266b.17.1776372814671; Thu, 16 Apr 2026
 13:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260416053928.2834699-5-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260416053928.2834699-5-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 08:53:22 +1200
X-Gm-Features: AQROBzBQYGf7jVh6t1WQoN3XN_xFDPUGwV_Aqc8QWBDHpHFKpT523VT9sOmQsvk
Message-ID: <CAFLszTibe3DYkKVWsf3b7j4oKsWBt236kUZxk2pz6f+HxM=wsQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] misc: qcom_geni: Add minicore support
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
> misc: qcom_geni: Add minicore support
>
> The qcom_geni driver reads an ELF from storage and configures a set of
> registers and programs the firmware to the GENI Serial Engine (GENI-SE)
> wrapper device for the expected functionality.
>
> Unlike the GENI-SE wrapper found in MSM SoCs, the IPQ5210's GENI-SE
> wrapper is pre-configured for one of the functions defined in 'enum
> geni_se_protocol_type'. Hence, the firmware download is not needed.
> Only the register configuration part is needed.
>
> Earlier, the boot stages before U-Boot would configure the GENI-SE (to
> access UART/SPI etc). Since for IPQ5210 U-Boot SPL, the previous stage
> (i.e. boot ROM) doesn't do that modify the driver to do the register
> configuration part alone without reading an ELF from the storage.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> drivers/misc/Kconfig              |   6 +++
>  drivers/misc/Makefile             |   1 +
>  drivers/misc/qcom_geni-minicore.c | 102 ++++++++++++++++++++++++++++++++++++++
>  drivers/misc/qcom_geni.c          |  94 ++++++++++++++++++++++++++++++-----
>  include/soc/qcom/geni-se.h        |   2 +
>  include/soc/qcom/qup-fw-load.h    |  15 ++++++
>  6 files changed, 208 insertions(+), 12 deletions(-)

> +config QCOM_GENI_MINICORE
> +     bool "Support minicores in Qualcomm Generic Interface (GENI) driver"
> +     depends on QCOM_GENI
> +     help
> +       Enable support for minicores in Qualcomm GENI and it's peripherals.

its

> +     } else if (IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)) {
> +             struct qup_mini_core_info *qmc = info;
> +
> +             for (; qmc->serial_protocol != GENI_SE_INVALID_PROTO; qmc++)
> +                     if (qmc->serial_protocol == rsc->protocol)
> +                             break;
> +
> +             tmp_hdr.magic = MAGIC_NUM_SE;

Please add an error return when no matching protocol is found.

> +#define QUPV3_SE_HW_PARAM_2          0xe2c
> +#define GENI_USE_MINICORES           BIT(12)

SE_HW_PARAM_2 is already added in geni-se.h in this same patch - maybe
use the one in geni-se.h and move the GENI_USE_MINICORES definition
there as well?

Regards,
Simon
