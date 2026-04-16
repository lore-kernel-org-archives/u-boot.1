Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B90F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5979184332;
	Fri, 17 Apr 2026 14:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mKFnpgMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23278407E; Thu, 16 Apr 2026 22:52:26 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E08DC83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 22:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b9910707d82so345366b.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 13:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776372744; cv=none;
 d=google.com; s=arc-20240605;
 b=jcxyuMm5nsBIDtlk2t1itf1dBLtcnSokvRm7/LGvcZ0c/SMNJI1IIk3V9IWZRewGRr
 WPYhyUAdviLPW+W3Aa1WbEoHxNY2z0b+i/eAE6CVNliW/JjiLoNag/frgmD6H8c5xVMR
 ThLYMxAw8jwWuCss8I9IOeFX58kYTMekOu5nXLDG07v3oPXtnyUtfn6VLEw33YrMMlyk
 dM/D/TXL/ePt6nTQkQOzXbys1/oohR5t/Xpg8IhAjhCioN2UI1MAeERUqXDd+tiis3Vx
 txaQB7fEUzWs0/D2U5aBsjZrO2y0hr8bzzdnO+wPNUr85hYJa8pDsCqDk1L5u+mIr1sm
 0WdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=srVDOUhev8QJnVpl1futru5agXzcinhCiCfNtACUqr0=;
 fh=PzcHDHniSDSnSUoX2MAnjnpEO0mAOzqNIR7VgfcIVrA=;
 b=KTSwSF4quu5Xq8JBUko6dzakpgF340B/sllyy5JU+1KhxDouMah/c1SxwLQc83bWHj
 hE/Z+Hsvth++ruDf4Sgk9EOZy99oeebj0L+V/lIj9dzc8sNvS73TO2VDtZXYOhnJ+rHO
 TUibN78jdzLlTs4OqSMZB/HB8FCSi5CA5x6R1n/Hr3UIunnppYnnD3Y67m+AsF71qIpR
 Yqs8UEwdSO6XilTGmM3iqPPqiAA03jBXWe21boqBLJBuMyRPFEthUf0wc2VvR4cMOyZK
 eEfHcWCRwrw0vXF5bVk1a8trRc6Bw3dy4MZFbDA1leaPRi/lOQn929E0qdU3DdvT5XhO
 U/bQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776372744; x=1776977544; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=srVDOUhev8QJnVpl1futru5agXzcinhCiCfNtACUqr0=;
 b=mKFnpgMCKzkTIE7qmo2SVBM9dC1ieyJXh42KcPHSpT4HlmA90W6RDebIhpwAG1nALx
 KUWCR1PLp/lukh1EngkoaalOvy00fkeNB2GA0BOgPqcuiuK97vRnx9k9SFC3p91K2GXV
 mhG508I1EXRj0nZOXsB7AUZ6L4ZeR1519HCh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776372744; x=1776977544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srVDOUhev8QJnVpl1futru5agXzcinhCiCfNtACUqr0=;
 b=UvMA2J+05YFoLFSEhsJQfjjVg3ydeWc5fV/CqAisECraC9YiYwecxPChA7oNlJuUoQ
 xsVyTddCIj8dAT8jmp9yl1nwfo4N4SuS0kWGT6096nGDmycL2o+D9RiXYpzhyZQRkPkF
 9Tu/P9vlsi+Hjt/pNq+gzVJKbst3Tq7uBQk5unxC8rJFOJN2qBR4gWD5jr1ibnwl3wZz
 Gq27D6B7Ll3amOID5x0NC6U3ZbNlmqXy/lGxtD7aV3QnAmNiSMU7PtNJAY+C09v3F1uW
 uabA6JTN/9jGkX83mSlwQ1RaCggr5K1sQy5zst5njJe84ISrghjx+ynbLkzAhKyZr+UV
 akgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fRICzM0x9OGMFZrGCpaFOKPyt3DrTmmAaD476ijvBMsVrWyVwARRQ4EjO6/HtzGgKbPJ+/4E=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3kyaRxn3Sho5LrC81X3S04lcKksT6sgQFsd1su2aBqxkfqDB5
 ow+tqcvtjfOsXcDso2bm5HK1Qxu3aKfQV2R5WNSTApiZzT4RdOSeRRXsRRWQMBWdwkNpTK+EBNQ
 XeEk2dPH8iW4ygCUv3nme4xHYqsPsIe0b82zGsSyp
X-Gm-Gg: AeBDiesX947HDAn7HuMErd0/Kq6KYrt82pT3uy76ZDe+wMTfJDPmaa64xDIV86U61rx
 zvmKUOGsx7XAp4Ak0qV508jPW8JVtFc1DCltGCZ9Y6JZ7PiIbeJ5aZbnfa3eY+k0b5aGaKIu4Eu
 h7WdGaBIGETeTjkBdAz9K2xr5Ci2IVUu7amgxlIFEAQywPD94qJdx7ltD9jrv8kScNcrHOhgnUh
 YqTzGytz4t8tLJdElnm8RgTmcQWcKhzPN+jUp6gOabHmdrSDg2Ynrc22cv21iCVpLIH83VnFzOR
 LmZafA1MqPj1oDCeIIqhNOvG/zV3S5A=
X-Received: by 2002:a17:907:a602:b0:b9c:c3ca:a724 with SMTP id
 a640c23a62f3a-ba418982fd2mr6495966b.8.1776372743799; Thu, 16 Apr 2026
 13:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260416053928.2834699-3-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260416053928.2834699-3-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 08:52:10 +1200
X-Gm-Features: AQROBzDkZZ76zcjyuMXk5-yahlHPcHsLk7S0U9WQnAe7jDOandTxNACJMYHMdNI
Message-ID: <CAFLszTj=iQO73XC8+d83Um8sw-QPd0ceTDLN6zU53GDD8B3aSQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] clk/qcom: add initial clock driver for ipq5210
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
> clk/qcom: add initial clock driver for ipq5210
>
> Add initial set of clocks and resets for enabling U-Boot on ipq5210
> based RDP platforms.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> drivers/clk/qcom/Kconfig         |  8 ++++
>  drivers/clk/qcom/Makefile        |  1 +
>  drivers/clk/qcom/clock-ipq5210.c | 97 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+)

> +#include <dm/device-internal.h>

Is this needed?

> +static ulong ipq5210_set_rate(struct clk *clk, ulong rate)
> +{
> +     struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +     switch (clk->id) {
> +     case GCC_QUPV3_WRAP_SE1_CLK:
> +             clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,

cbcr_reg is a bit confusing since that name suggests a CBCR register -
see the ipq5424 driver which uses 'reg'. What do you think about using
reg consistently, or maybe add a comment explaining this?

> +static int ipq5210_enable(struct clk *clk)
> +{
> +     struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +     if (priv->data->num_clks <= clk->id) {
> +             debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +             return 0;
> +     }

Shouldn't the comparison be <  ?

Also, should return an error, not 0.

> +     qcom_gate_clk_en(priv, clk->id);
> +
> +     return 0;

Should return any error from qcom_gate_clk_en()

Regards,
Simon
