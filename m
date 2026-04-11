Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31A0F3ED4D
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AD1F84154;
	Sat, 11 Apr 2026 15:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZRF4/edT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 542F384154; Sat, 11 Apr 2026 15:09:26 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC17C84118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b980b35534eso407884166b.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 06:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775912963; cv=none;
 d=google.com; s=arc-20240605;
 b=bzPoRTEiWAEV4lF2tUSKif91pCq7y3dd1oVNaRcYccaAY1iAxDHGCQv5t8FCS+jjll
 IwjQbJ0C1XRwEbZk2jQSCd1/JmWuUE6Vpv5EylCb3/dmkR/WpJS0TVwnGlGhRcVN+EM1
 8LzewR1XkwRxR1VP/PCRXWFrTFLYoCBxMxjrkqDdrkcJz1fuS2rBtYUETHuYo35P91Mn
 GCfeo0KDvVaIyuQsLTalwW7+sKKICYbMe5UlPegEUWGZ4jcI1zO+D4qjcu73H4da6W0I
 u5mfDe3OqDdMcuVbFfPJDesyTdCD58d0mkAYrUZvFPZu/XKWsU5z8hy33PA8Zm6X3epu
 tp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RSFprqyLstSFW2c0FRnsNVGyTvr1nQ+UtDl76u04Spo=;
 fh=wmhMQStyVefcLwKkpuDSOZfz4STwEw2wfLn14Ooks/Y=;
 b=LsFp0lJWzKCqpY57PBsne6j5AJ8UP3vp7jM7+Ug3N1jtN/3stVwncPAI1AxnZ6IdAA
 NWNWpjginrdMDUUD4kCAz2+CVLVkL01aFVjfhu0BwQWet2PJ7oSVFRnuvNye3rLmsQnm
 juSrZOxJFzWXP1yKHQyhzTAqDhnZEjw6IeUDvzMpKSO+na5EARmNAhdARpL6TQBqsitl
 4iPvwxhW6qalr3YfbE0WrEacAhEwvKb7IdTUH4txFw275V7qNyXy9kXH9WrzQzS5hfo0
 MgSMAoQQBy3krxxXzJNR3w09Q9IAMUnwEiqpz2RvClZHIC4GNH6115+qH18pGVp6l5bS
 72+w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775912963; x=1776517763; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RSFprqyLstSFW2c0FRnsNVGyTvr1nQ+UtDl76u04Spo=;
 b=ZRF4/edTFAnMgL9Hwl26TKUuIJGGITbOq1fc2+uAq2jH6IzvFbRm/cc71WyS6yIHr8
 zPnfexV6iHtUlAkUfSoo4BVc6iGwTvMUbN9NHPnomDiOrmVdEYsfaFwqAaxcFijNStaW
 SYR/uaQkYG/5MAcQPOhs6T7EF2a10vf0CQldQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775912963; x=1776517763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSFprqyLstSFW2c0FRnsNVGyTvr1nQ+UtDl76u04Spo=;
 b=IfDC5JF0Mej4VTEbj06bYvgNA847D8o7nL4lLP4f3EUDjg2t4gA5wDEjQZRFIaz0pr
 GEtcBZ+x4YMLLA9QC3+wBg/sluCkEmSnqhx3NBzbD6bcivF/yC5K0q2SgrKl4gKBo+Nb
 rU59LPeBPC9oA5HdzOq3hG8Au+rUfD3V/GUhZUjq9XDCFnr0OS5vxXRIBkYm7ZC2hWP1
 NB5+RU5YUc64W/JkZm22C3wltxXYNpjTiap4BxuNmkyRMbYdu88y+s/U4PxFCx+U5c/F
 MlWz42Y03PYdYiqoYq7ycdanTVE9vkVrzByz+z4Kv8ypzlYLVPtsK6JuEBXcbX9IlgNm
 IBuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr9Vy9RSPDMWy5wP/6xwhCQ0eWOS7YN7iunEVYGY2c6+E+n1vsV+iBtiIxWNYflnfDFXrtzaA=@lists.denx.de
X-Gm-Message-State: AOJu0YzvFh0ayrBeWWwrIlKI3n7OkWaB02j6flmS5PugcjjXji8RAOQJ
 65npwJxVZwllD6mTNSOlNrRcILPcpYgFnBOVLXhqHBV5GOZP8+LSVRDysGXzAK6C0SPOtGLtvc6
 CHTOuzgvKUIQu3lzMJDmjF/YJzbg9WQV8QgKW/+Vw
X-Gm-Gg: AeBDies2Bqi8JcVUo+0srqObBgMC7bhrxFl26YPZ4CeZroHaimi6OGRQI9LDMi4kbqR
 mxHo6j6NNecS8rGrUaFVpsSvykcpgdTUhL3ChiWMb7ERqbkje05KxeGepMxQIdP7hRcWYTKwGnF
 9O18hSif8o4X8ZRVL1KaoUPhcVWU7hGrOW0uDHcEmRPdGiT62nWsoh+ATlmAZR7p9PGzvPnXwS3
 hQPZmZknfgHPuoDIzsZzGYBBv9ZcS/E1YkewgGqtwNN0H7ahttpupO5MqZ7NcnWjWyvvF6nPm9s
 aV9FEw==
X-Received: by 2002:a17:907:6093:b0:b9b:171e:bae9 with SMTP id
 a640c23a62f3a-b9d76ec80b9mr343560366b.24.1775912963104; Sat, 11 Apr 2026
 06:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-6-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260410091154.1001021-6-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 07:09:09 -0600
X-Gm-Features: AQROBzCsRx_ciPAcDF-yODgZl47dDsYJ9crG4LTDd1KDAuRVAZCmpBLawQx9xe8
Message-ID: <CAFLszTij2Asndsdy4gdVgHWXqayKztvdV5mySX2A90+1xzOfdg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] misc: qcom_geni: Add minicore support
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com, 
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com, wens@kernel.org, 
 jamie.gibbons@microchip.com, david.wronek@mainlining.org, 
 alexeymin@postmarketos.org, james.hilliard1@gmail.com, 
 michael@amarulasolutions.com, richard.genoud@bootlin.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 11 Apr 2026 15:25:15 +0200
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

On 2026-04-10T09:11:45, Varadarajan Narayanan
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
>  drivers/misc/qcom_geni.c          |  90 ++++++++++++++++++++++++++++-----
>  include/soc/qcom/geni-se.h        |   2 +
>  include/soc/qcom/qup-fw-load.h    |  15 ++++++
>  6 files changed, 204 insertions(+), 12 deletions(-)

> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> @@ -163,16 +170,44 @@ static void geni_config_common_control(...)
> +static int load_se_firmware(struct qup_se_rsc *rsc, bool elf, void *info)
> +{
> +     ...
> +     if (elf) {
> +             hdr = info;
> +             ...
> +     } else if (IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)) {

If elf is false and CONFIG_QCOM_GENI_MINICORE is disabled some
variables are used uninitialised. Please add an else clause that
returns an error.

> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> @@ -377,15 +413,22 @@ int qcom_geni_load_firmware(...)
> +     if (IS_ELF(*(Elf32_Ehdr *)fw)) {
> +             ...
> +             elf = 1;
> +             info = hdr;
> +     } else {
> +             elf = 0;
> +             info = fw;
> +     }

Using 1/0 for a bool is a bit odd. Please use true/false.

> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> @@ -492,7 +540,11 @@ static int probe_children_load_firmware(...)
> +#if CONFIG_XPL_BUILD
> +int qcom_geni_fw_initialise(struct udevice *dev)
> +#else
> +int qcom_geni_fw_initialise(void)
> +#endif

Having two different function signatures based on a preprocessor
conditional makes future maintenance harder. Consider always passing
dev and ignoring it when unused.

Regards,
Simon
