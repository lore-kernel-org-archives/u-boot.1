Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74045C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 05:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F2B87F9F;
	Fri, 15 Mar 2024 06:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oi4dwVSv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 841A087FAA; Fri, 15 Mar 2024 06:36:08 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3552187F5A
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 06:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-476605ec78bso84685137.2
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 22:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710480965; x=1711085765; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KQnK+SIgzfBFJd6m4fxwuD1zPElKCAhlBdwQliceuTY=;
 b=oi4dwVSvh5EjXn4BjBwYSNw+47hKawVy3DaDNMZJRkvsDCRa6TKtYmA6ndzUcK3Lf2
 yMW+wA18/5bjfoM2Dd+DNZL/9dBosVslasyS33x1PjvQNV5qD2QIywOv0nirNLxc68mA
 siWQOFC1jPWHVUZPvkVzDMTc1bkW8hlM8fk3cJ1HQ7dYCVooQl5i6wcNxOWGxVgHMJX4
 GjcZkURWBeFc6udgYUt1l4gVPpUPy6cDzZaKoDPzQSmUnm/kXnw4WXMxmWT+4+1uIQVi
 f1mf+aj6gdo5NNA1ag5D/msH0g0UiiVtxjo7GUqPHh4IXHCCMKNV7GOCflj+X+i4P7a9
 pt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710480965; x=1711085765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KQnK+SIgzfBFJd6m4fxwuD1zPElKCAhlBdwQliceuTY=;
 b=Jp5OCAXU3ETSDDMzRWhQb5YHMz5TtQFxJlrR83pD/cA59QxIrQEV2+vZLi6v68pNB1
 rnujMps0mdsE3hfoE3oACQnDEOTCUeAFeW2bi8BBgh2WLG4wzh/kHyA0pqa9kxlzJx4/
 IHYljUG+GV75p83BLaY6GHAOEs2IWCGMzsIrKZXkl43m0wWcQTOh74On+Odpxrzuix0Y
 TenVlfRPBcm6XhZfX3QCp+fCubs94mZSSzfvRqwIYa4PAkbnNzcf/TUAvv3o8ENir76r
 42/6gx8qaoh9myAR/SslqoavRQDOgbgym0DlRtySTAQA7sJcqzAIFyTXHCmO51dkv8ux
 1PMA==
X-Gm-Message-State: AOJu0YyIav2SxfRQuEHBRjGhQ6hS2/pCznoztXBecOEFqLsDsA/JQVeS
 u4JwIRsd7+rT7OrX51FzSNa77D6HCRYvUI4vvZIo9LQN6IH7q6oO79/zKyLKtqXqWa+qWKVocbx
 WIguxatuGX2Kt48BFYSyH/KHYIAPDiY3/hdQgzIIxDwGu1ELpSxA=
X-Google-Smtp-Source: AGHT+IG39sb3UmQ0fV1vnE5kPGoyUxg+69HiMdYCK3JLmfiBmMJ9thCHWN2cPtmBCkMvw7vBwQbu+KkFhS+sRVx4vQY=
X-Received: by 2002:a67:eb0a:0:b0:473:18d9:caf5 with SMTP id
 a10-20020a67eb0a000000b0047318d9caf5mr3897259vso.24.1710480965015; Thu, 14
 Mar 2024 22:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-4-sumit.garg@linaro.org>
 <c86c5713-97c7-4ce6-bb75-15dcb3fcdcee@denx.de>
In-Reply-To: <c86c5713-97c7-4ce6-bb75-15dcb3fcdcee@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Mar 2024 11:05:53 +0530
Message-ID: <CAFA6WYNkYUN3sG5Xdy=MwydFs==RFeLxkgptHsmxnBeGqtuavQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] reset: imx: Add support for i.MX8MP reset
 controller
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com, 
 marcel.ziswiler@toradex.com, francesco@dolcini.it, lukma@denx.de, 
 seanga2@gmail.com, jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com, 
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, fathi.boudra@linaro.org, 
 remi.duraffort@linaro.org, daniel.thompson@linaro.org
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

On Thu, 14 Mar 2024 at 09:45, Marek Vasut <marex@denx.de> wrote:
>
> On 3/12/24 8:03 AM, Sumit Garg wrote:
> > Add support for i.MX8MP reset controller, it has same reset IP inside
> > as the other iMX7 and iMX8 variants but with different module layout.
>
> iMX8M , iMX8 is a different SoC .

Ack.

>
> > Inspired from counterpart Linux kernel v6.8-rc3 driver:
> > drivers/reset/reset-imx7.c. Use last Linux kernel driver reference
> > commit bad8a8afe19f ("reset: Explicitly include correct DT includes").
> >
> > Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mp-venice*
> > Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >   drivers/reset/reset-imx7.c | 101 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 101 insertions(+)
> >
> > diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> > index 4c7fa19d495..90d3d75255e 100644
> > --- a/drivers/reset/reset-imx7.c
> > +++ b/drivers/reset/reset-imx7.c
> > @@ -10,6 +10,7 @@
> >   #include <dm.h>
> >   #include <dt-bindings/reset/imx7-reset.h>
> >   #include <dt-bindings/reset/imx8mq-reset.h>
> > +#include <dt-bindings/reset/imx8mp-reset.h>
>
> Keep the list sorted (P is before Q).

Ack.

>
> >   #include <reset-uclass.h>
> >   #include <linux/bitops.h>
> >   #include <linux/delay.h>
> > @@ -252,6 +253,102 @@ static int imx8mq_reset_assert(struct reset_ctl *rst)
> >       return 0;
> >   }
> >
> > +enum imx8mp_src_registers {
> > +     SRC_SUPERMIX_RCR        = 0x0018,
> > +     SRC_AUDIOMIX_RCR        = 0x001c,
> > +     SRC_MLMIX_RCR           = 0x0028,
> > +     SRC_GPU2D_RCR           = 0x0038,
> > +     SRC_GPU3D_RCR           = 0x003c,
> > +     SRC_VPU_G1_RCR          = 0x0048,
> > +     SRC_VPU_G2_RCR          = 0x004c,
> > +     SRC_VPUVC8KE_RCR        = 0x0050,
> > +     SRC_NOC_RCR             = 0x0054,
> > +};
> > +
> > +static const struct imx7_src_signal imx8mp_src_signals[IMX8MP_RESET_NUM] = {
> > +     [IMX8MP_RESET_A53_CORE_POR_RESET0]      = { SRC_A53RCR0, BIT(0) },
> > +     [IMX8MP_RESET_A53_CORE_POR_RESET1]      = { SRC_A53RCR0, BIT(1) },
> > +     [IMX8MP_RESET_A53_CORE_POR_RESET2]      = { SRC_A53RCR0, BIT(2) },
> > +     [IMX8MP_RESET_A53_CORE_POR_RESET3]      = { SRC_A53RCR0, BIT(3) },
> > +     [IMX8MP_RESET_A53_CORE_RESET0]          = { SRC_A53RCR0, BIT(4) },
> > +     [IMX8MP_RESET_A53_CORE_RESET1]          = { SRC_A53RCR0, BIT(5) },
> > +     [IMX8MP_RESET_A53_CORE_RESET2]          = { SRC_A53RCR0, BIT(6) },
> > +     [IMX8MP_RESET_A53_CORE_RESET3]          = { SRC_A53RCR0, BIT(7) },
> > +     [IMX8MP_RESET_A53_DBG_RESET0]           = { SRC_A53RCR0, BIT(8) },
> > +     [IMX8MP_RESET_A53_DBG_RESET1]           = { SRC_A53RCR0, BIT(9) },
> > +     [IMX8MP_RESET_A53_DBG_RESET2]           = { SRC_A53RCR0, BIT(10) },
> > +     [IMX8MP_RESET_A53_DBG_RESET3]           = { SRC_A53RCR0, BIT(11) },
> > +     [IMX8MP_RESET_A53_ETM_RESET0]           = { SRC_A53RCR0, BIT(12) },
> > +     [IMX8MP_RESET_A53_ETM_RESET1]           = { SRC_A53RCR0, BIT(13) },
> > +     [IMX8MP_RESET_A53_ETM_RESET2]           = { SRC_A53RCR0, BIT(14) },
> > +     [IMX8MP_RESET_A53_ETM_RESET3]           = { SRC_A53RCR0, BIT(15) },
> > +     [IMX8MP_RESET_A53_SOC_DBG_RESET]        = { SRC_A53RCR0, BIT(20) },
> > +     [IMX8MP_RESET_A53_L2RESET]              = { SRC_A53RCR0, BIT(21) },
> > +     [IMX8MP_RESET_SW_NON_SCLR_M7C_RST]      = { SRC_M4RCR, BIT(0) },
> > +     [IMX8MP_RESET_OTG1_PHY_RESET]           = { SRC_USBOPHY1_RCR, BIT(0) },
> > +     [IMX8MP_RESET_OTG2_PHY_RESET]           = { SRC_USBOPHY2_RCR, BIT(0) },
> > +     [IMX8MP_RESET_SUPERMIX_RESET]           = { SRC_SUPERMIX_RCR, BIT(0) },
> > +     [IMX8MP_RESET_AUDIOMIX_RESET]           = { SRC_AUDIOMIX_RCR, BIT(0) },
> > +     [IMX8MP_RESET_MLMIX_RESET]              = { SRC_MLMIX_RCR, BIT(0) },
> > +     [IMX8MP_RESET_PCIEPHY]                  = { SRC_PCIEPHY_RCR, BIT(2) },
> > +     [IMX8MP_RESET_PCIEPHY_PERST]            = { SRC_PCIEPHY_RCR, BIT(3) },
> > +     [IMX8MP_RESET_PCIE_CTRL_APPS_EN]        = { SRC_PCIEPHY_RCR, BIT(6) },
> > +     [IMX8MP_RESET_PCIE_CTRL_APPS_TURNOFF]   = { SRC_PCIEPHY_RCR, BIT(11) },
> > +     [IMX8MP_RESET_HDMI_PHY_APB_RESET]       = { SRC_HDMI_RCR, BIT(0) },
> > +     [IMX8MP_RESET_MEDIA_RESET]              = { SRC_DISP_RCR, BIT(0) },
> > +     [IMX8MP_RESET_GPU2D_RESET]              = { SRC_GPU2D_RCR, BIT(0) },
> > +     [IMX8MP_RESET_GPU3D_RESET]              = { SRC_GPU3D_RCR, BIT(0) },
> > +     [IMX8MP_RESET_GPU_RESET]                = { SRC_GPU_RCR, BIT(0) },
> > +     [IMX8MP_RESET_VPU_RESET]                = { SRC_VPU_RCR, BIT(0) },
> > +     [IMX8MP_RESET_VPU_G1_RESET]             = { SRC_VPU_G1_RCR, BIT(0) },
> > +     [IMX8MP_RESET_VPU_G2_RESET]             = { SRC_VPU_G2_RCR, BIT(0) },
> > +     [IMX8MP_RESET_VPUVC8KE_RESET]           = { SRC_VPUVC8KE_RCR, BIT(0) },
> > +     [IMX8MP_RESET_NOC_RESET]                = { SRC_NOC_RCR, BIT(0) },
> > +};
> > +
> > +static int imx8mp_reset_set(struct reset_ctl *rst, bool assert)
> > +{
> > +     struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
>
> It wouldn't hurt to rename imx7_reset_priv to imx_reset_priv in 2/11 too.
>

Ack.

> With the include sorting fixed:
>
> Reviewed-by: Marek Vasut <marex@denx.de>

Thanks.

-Sumit
