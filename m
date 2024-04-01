Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953A3CD1283
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 04:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14E7D882CE;
	Mon,  1 Apr 2024 06:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LTM0dVZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C2D9882CE; Mon,  1 Apr 2024 06:47:50 +0200 (CEST)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AF68882CC
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 06:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4785c788ba6so206952137.0
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 21:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711946864; x=1712551664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OsBHUNLukU2UhkNaiavLjD/3gDRSLKjgy97546XRa4A=;
 b=LTM0dVZFpP/od5Mh981ocyCwoI6PeLSNhx1Q8nDm2mheMhZGldAzC2fwWnY/QxybH7
 WK0OX+q5sf7uTFh/dwRdyu5km22BD4cRsFjYp53D7sCGOhVHyRiWLOlpLGShasli2bDB
 moop05CWcmSbRktBQgx932Jpq1m1TtBpJSKJ+1sslAaQBLaZMjxxkL8b3ysea1ciOz2O
 huKpsh/Z1D3y6/5TMylWAOLZPxFdoh55qvAoOyxJf8Sd9QhNZHjqumM4KSCHU0FaUhBw
 1PkWphp+cie/oKSZUJf4qBKBiTzE9s+wUIg/BBzXsD2ZkiYg6CRZTfyI4MPwj/hacTqG
 lcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711946864; x=1712551664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OsBHUNLukU2UhkNaiavLjD/3gDRSLKjgy97546XRa4A=;
 b=xEjEzqiC6sPGnVKexfyFlRlcDJ2uOYuSagSEZ6OLee/dUvsBXw9I88X++7dkzS7ZKo
 DF5OOZOXSnh88x0rq7aajBh158XTQLITROJ57HT1b/tD5G277LOvgXUo+3SM/7XyLDIX
 9XVPLfA9BjDTnrJmvimcRRMbKaOGEDOkayv5bDoAY9QhL/76RS2TQSjnnbvogmAuBpTu
 1H00khReuNovoaPcucXLr9XeKR3NwZ9dCuRNUp+l3ebtMpFQVFe94EUA/MLKSEixGfZy
 8p5FENn7hT3SXLy5U1tu9LLy8JLHKJarLfe+Rqlg2JjBaUMJo8R5j23HciEOafl33RWe
 xz6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4j6m6vf3gDv7LkS0p2QidGlDdI5j79sRc4SAH77FniOZZ7z+jsQIZJD0ZL32Hv3EChAjPwuvZkpfZaHXKAYS/oNxD0w==
X-Gm-Message-State: AOJu0YwBFkM/wT0CghQ8cfJo1qusl+VliAJ+cImW7fZqNHdPkvIoCaCb
 T6rg6GqC9fbZi/MDphhPKcWlsn2aBtpYXRfFGfyaVBbCybqhbTmDwdH3+WK8sG4Se9serhUvWj8
 MjCNKaVzpydcdM9qxyJ/DrIQSfVMSuWvWdl0yyQ==
X-Google-Smtp-Source: AGHT+IG1LDks4DObNdH9UsEuE5zes0ze1eQ/lfzVBnVFEYvVigpC41d7ITDiCYPwSrawnq7HL2lMt/lcsPdn687CRIw=
X-Received: by 2002:a05:6102:810:b0:478:224b:5aae with SMTP id
 g16-20020a056102081000b00478224b5aaemr3439946vsb.11.1711946862813; Sun, 31
 Mar 2024 21:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-11-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-11-4e98228b3d03@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 1 Apr 2024 10:17:31 +0530
Message-ID: <CAFA6WYP1oUmFQEibzRs05=nxgHU_2mgSKv=V4M8rmwMRfhLVLw@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] mach-snapdragon: fixup power-domains
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de
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

On Thu, 28 Mar 2024 at 23:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> We don't support the RPM(h)PD power domains in U-Boot, and we don't need
> to - the necessary resources are on, and we aren't going to enter any
> low power modes.
>
> We could try using a no-op device, but this requires adding a compatible
> for every platform, and just pollutes the driver model. So instead let's
> just remove every "power-domains" property that references the RPM(h)pd
> power controller. This takes <1ms as we're using OF_LIVE.
>
> Of note, this only applies to drivers which are loading post-relocation.
> Drivers loaded pre-reloc that reference the rpm(h)pd still need
> DM_FLAG_DEFAULT_PD_CTRL_OFF in their flags.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/of_fixup.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 4fdfed2dff16..3f7ac227bd09 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -21,8 +21,9 @@
>  #include <dm/of_access.h>
>  #include <dm/of.h>
>  #include <fdt_support.h>
>  #include <linux/errno.h>
> +#include <stdlib.h>
>  #include <time.h>
>
>  /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
>   * USB controllers. Rather than requiring source level DT changes, we fix up
> @@ -109,8 +110,38 @@ static void fixup_usb_nodes(void)
>                         log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
>         }
>  }
>
> +/* Remove all references to the rpmhpd device */
> +static void fixup_power_domains(void)
> +{
> +       struct device_node *pd = NULL, *np = NULL;
> +       struct property *prop;
> +       const __be32 *val;
> +
> +       /* All Qualcomm platforms name the rpm(h)pd "power-controller" */
> +       for_each_of_allnodes(pd) {
> +               if (pd->name && !strcmp("power-controller", pd->name))
> +                       break;
> +       }
> +
> +       /* Sanity check that this is indeed a power domain controller */
> +       if (!of_find_property(pd, "#power-domain-cells", NULL)) {
> +               log_err("Found power-controller but it doesn't have #power-domain-cells\n");
> +               return;
> +       }
> +
> +       /* Remove all references to the power domain controller */
> +       for_each_of_allnodes(np) {
> +               if (!(prop = of_find_property(np, "power-domains", NULL)))
> +                       continue;
> +
> +               val = prop->value;
> +               if (val[0] == cpu_to_fdt32(pd->phandle))
> +                       of_remove_property(np, prop);
> +       }
> +}
> +
>  #define time_call(func, ...) \
>         do { \
>                 u64 start = timer_get_us(); \
>                 func(__VA_ARGS__); \
> @@ -119,5 +150,6 @@ static void fixup_usb_nodes(void)
>
>  void qcom_of_fixup_nodes(void)
>  {
>         time_call(fixup_usb_nodes);
> +       time_call(fixup_power_domains);
>  }
>
> --
> 2.44.0
>
