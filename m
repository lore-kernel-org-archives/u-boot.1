Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765C2C54E69
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 10:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C97D87F6F;
	Fri, 15 Mar 2024 11:41:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R+xqQNXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9DDC878E9; Fri, 15 Mar 2024 11:41:25 +0100 (CET)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B528087F74
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 11:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7de0f269c45so832640241.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 03:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710499280; x=1711104080; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=exuXAfQwdMmHhFBIu4QaBb4gjq55jZ5mRBUMUaiMLts=;
 b=R+xqQNXZkQmzfE0tlRT8kaLi5SvSLzKErYPOpWKE9fJKMADDJwOqDNXSAi7psOSOBV
 G9yl9gXJ6urfR2lko5XbUh9iE1lHnDzb1RwVAdU8fy+nLLS83zImKnfhEIVlWapdN/0w
 Ei7BoN4pQ9zqXsZxqgVL7UOvkcZIod8kY97ThQK6yhMnWK3F+Kdn4joekr6OSu9x5y6u
 VbjJv1AdSQ2MYKwlcwXwLaXV1Lb/dPX/FTFJDHtwVdxhOLD+Y3fvXrlQ6g/GM6seSnHw
 oWYPfdzm6EuWPlsl/ylXAP3ZRH9qBIp3+/tb0K/Olu/fETCKyEKhaqcl2NyLyVtmxJ2n
 Ep4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710499280; x=1711104080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=exuXAfQwdMmHhFBIu4QaBb4gjq55jZ5mRBUMUaiMLts=;
 b=Za/4qes5QNndQeXeS3PgCvs1WpUywG2khit0y3ecoC4nPsZSe170ncSpZ/sdXV6ie0
 pFQdgeSy49dD05ZOwzqMUNP0FGGSShvsd+BIkJNd6TPsrsmTRNuytKvp+EcCzH1G6RKT
 RtdqW7d0eGLTxDXk3XhT8HsH5bgtHOtGBSo0JZhoicYNd2fZNTYC61P4Dlkf4zKcCbEv
 xu2+HW3H7cYIaBy0MXjYSrEdb4mxzDNbxatGB3S+HkZ6H2jlt980eax78LUukpIOtvEq
 +dQO226CJkyja2sHg791FYe49jMJ03rgQST8s7HSXt6CenXZdDglDsF3HAxRaKv/J1P9
 duuw==
X-Gm-Message-State: AOJu0YxRutwyDCIF2Ql+Sk0KRsVEHgnP6LirO+jbL6hlnRHYvc9LvV6h
 LGX/IUezzz4+ehMs0KaHY52WUZ6xuA20XC7Z4Xyqv0ih1Vu9MrjesT065ABkEtMGEpPANEkEkD4
 tZWWQBp/YmrJGkEPh/XjarKfgaFybenIquAGIKA==
X-Google-Smtp-Source: AGHT+IE7YDEOIBpA3Zl6L1mtc+GX+X97Eg1cTGSro51seHKmG0pSKzqNoyTnrhuNO3PZoHY9smahs5gokl6Q+7J5g2I=
X-Received: by 2002:a05:6102:2434:b0:476:552f:39e8 with SMTP id
 l20-20020a056102243400b00476552f39e8mr3756714vsi.10.1710499280439; Fri, 15
 Mar 2024 03:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-5-sumit.garg@linaro.org>
 <dbd4f385-d93f-48db-a7e9-88b86f3d7445@denx.de>
 <CAFA6WYO8k=qyexUSRs_X-YMtKZTAzM5ZeSCNEO+sJ7z91z7ohg@mail.gmail.com>
 <f789292a-7c46-4b98-935f-86bfea39ab05@denx.de>
In-Reply-To: <f789292a-7c46-4b98-935f-86bfea39ab05@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Mar 2024 16:11:09 +0530
Message-ID: <CAFA6WYPHqdWiL=8foFDD9Rs+_L+E-=D+VMC=FZrnKeQdcooNMQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] imx8mp: power-domain: Don't power off pd_bus
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

On Fri, 15 Mar 2024 at 14:53, Marek Vasut <marex@denx.de> wrote:
>
> On 3/15/24 6:31 AM, Sumit Garg wrote:
> > On Thu, 14 Mar 2024 at 09:45, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 3/12/24 8:03 AM, Sumit Garg wrote:
> >>> power_domain_on/off() isn't refcounted and power domain bus shouldn't be
> >>> turned off for a single peripheral domain as it would negatively affect
> >>> other peripheral domains. So lets just skip turning off bus power
> >>> domain.
> >>
> >> What exactly is the issue and how did you trigger it ?
> >>
> >> Details please.
> >
> > I suppose the issue can be triggered via the "=> usb start => usb
> > stop" sequence where one of the USB controllers is configured in
> > peripheral mode.
>
> 'usb start ; usb stop' causes no problems on MX8MP , maybe the test case
> is more extensive ?
>
> Please, write down the necessary steps to reproduce this problem, and
> what happens when that problem occurs.

After digging in more, it looks like dev_power_domain_off() is never
(U-Boot life-cycle) invoked for USB controller devices derived from
DT. So this USB power domain sequence is never reachable.

BTW, dev_power_domain_on() is invoked when USB controller devices are
added based on DT.

>
> >>> Fixes: 898e7610c62a ("imx: power-domain: Add i.MX8MP HSIOMIX driver")
> >>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >>> ---
> >>>    drivers/power/domain/imx8mp-hsiomix.c | 6 +-----
> >>>    1 file changed, 1 insertion(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
> >>> index e2d772c5ec7..448746432a2 100644
> >>> --- a/drivers/power/domain/imx8mp-hsiomix.c
> >>> +++ b/drivers/power/domain/imx8mp-hsiomix.c
> >>> @@ -50,7 +50,7 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
> >>>
> >>>        ret = power_domain_on(domain);
> >>>        if (ret)
> >>> -             goto err_pd;
> >>> +             return ret;
> >>>
> >>>        ret = clk_enable(&priv->clk_usb);
> >>>        if (ret)
> >>> @@ -63,8 +63,6 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
> >>>
> >>>    err_clk:
> >>>        power_domain_off(domain);
> >>> -err_pd:
> >>> -     power_domain_off(&priv->pd_bus);
> >>>        return ret;
> >>
> >> Why not add counter into imx8mp_hsiomix_priv structure in this driver ?
> >
> > Sure I can do that but do you think the current approach can have any
> > side effects?
>
> Bus domain not getting cycled (which can leave it in some odd state),
> and increased power consumption if the next stage doesn't turn the
> domain off.

Given above, would you like me to drop power domain off path entirely
here? I think if people are concerned about power consumption then it
should be implemented properly in U-Boot to remove all the DT based
devices before passing on control to the next stage.

-Sumit
