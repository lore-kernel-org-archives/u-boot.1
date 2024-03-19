Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B643BC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 13:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 201C988080;
	Tue, 19 Mar 2024 14:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rn3gn81L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D37988081; Tue, 19 Mar 2024 14:51:36 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C1F88064
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 14:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7e0a3da1d61so20590241.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 06:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710856293; x=1711461093; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZVgtZtOZt6qscLYzh69eapSI76Ewow1iBNYkrca/ic=;
 b=Rn3gn81LFWVdeOuCiP20MARXEXEUYOTjmxxddeCk1KMkSexFkiahdkm8vc2Bqm5YbG
 a/Ub4c4ZkxjxHXZXd9VKvALVNGGUYnowgAWq16XM9KV9iV6cVFlILxhib+W90Y8Wg04t
 HAwL2MwwG5yV1Rj3dBmZPqfJlTnpw86qNkMBac7oi1pvYDMnvMDCWUWNpMA1B3mP/2Kw
 tuoQNePjua/4QrYyZhhSvRv5wULek8tFgVgabpqTkLg0WzdcRCF9lTxQTcxMjymp/Eis
 29IRfExX3CDe+kNNin2W2ZMg8yw36qPY/tx9kq8XJucZgZT3GB5z4aRjkeF/ubMRWs1B
 2shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710856293; x=1711461093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ZVgtZtOZt6qscLYzh69eapSI76Ewow1iBNYkrca/ic=;
 b=hwFsGWfemqQqCVEsv2mNxMDPcuosrACEjSA3Rtzqmed4uYYd7mSTnviFR3pkT3+ouZ
 WFQH/UKFja7cysEmeK1SpbBDejvd8T+a78QhOIiVEnkqzxOloAKPIGMZ47Dc2hXSZyp9
 ZYo5c03de9NqNVkWSQCy03xKkcYzm11CVPIdHfHiwFBk4UCkwjuwVTkCzTWjPVVRp4aL
 2jHHz3luoYQxknpAFJOPomJfkBN5UK0LvR+vE57x+BqdGaKfqRWJwwdFvRJF1VOL2qDX
 MoV2UZdnUGLKNGA4dKzcbERimJvRuH0BiveVsgQ/0/QWH+adv/a2zrGRH8qDCZMvfyzI
 EZlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHm8NtWuzUO5q9/p3lUoQK44KMbiSBQDwm0045keQjDixStMWaJ1MmiN7gBCG4e4qQ0xh5goS0LahMdIMuCv0L3nk9Vw==
X-Gm-Message-State: AOJu0YxN9iLgmezNAbpYfcDbvTC99hTdsvjnl824OninQ/B6z68h1aqZ
 PcgDvdZgidq29+B970jDGV0LAsFN7X15oldcofU3IyqPepFdYZQaGELLcXyXjiN1upx2yBx3IlQ
 +G/+X+mII5tSMmNToEO3j51JlHHXzsz6tCTczEQ==
X-Google-Smtp-Source: AGHT+IGh4MHYdDLm+yOMqdpxKcIfryh8mdpH/pcRPb1o59Z+AfjZbwyQMyXSc377VomFLU72X1pZqOIoHeY05SF8HN8=
X-Received: by 2002:a05:6102:c4:b0:475:c159:2bc3 with SMTP id
 u4-20020a05610200c400b00475c1592bc3mr11401813vsp.5.1710856293077; Tue, 19 Mar
 2024 06:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-11-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-11-e1b38d9b4fa4@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Mar 2024 19:21:22 +0530
Message-ID: <CAFA6WYNCTkV2+ucWfiduFDn95J1X0sf5WHVZqkB-Z+VXrToQzA@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] mach-snapdragon: fixup power-domains
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

On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> We don't support the RPM(h)PD power domains in U-Boot, and we don't need
> to - the necessary resources are on, and we aren't going to enter any
> low power modes.
>
> We could try using a no-op device, but this requires adding a compatible
> for every platform, and just pollutes the driver model. So instead let's
> just remove every "power-domains" property that references the RPM(h)pd
> power controller. This takes <1ms as we're using OF_LIVE.

Similar reasoning here as on patch #10, it would be better if we can
handle it via a no-op device.

-Sumit

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
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 6810c8617cc0..49f1fc1948f3 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -21,8 +21,9 @@
>  #include <dm/of_access.h>
>  #include <dm/of.h>
>  #include <fdt_support.h>
>  #include <linux/errno.h>
> +#include <stdlib.h>
>
>  /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
>   * USB controllers. Rather than requiring source level DT changes, we fix up
>   * DT here. This improves compatibility with upstream DT and simplifies the
> @@ -108,8 +109,39 @@ static void fixup_usb_nodes(void)
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
>  void qcom_of_fixup_nodes(void)
>  {
>         fixup_usb_nodes();
> +       fixup_power_domains();
>  }
>
> --
> 2.44.0
>
