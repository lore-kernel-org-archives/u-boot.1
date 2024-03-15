Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493AFC54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 05:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A52987F5E;
	Fri, 15 Mar 2024 06:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S8Ed6UXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F47487E2C; Fri, 15 Mar 2024 06:31:54 +0100 (CET)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC1E87F5A
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 06:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7db36dbd474so695904241.2
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 22:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710480709; x=1711085509; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4qMVu2/aTlu0oZllwHJwdbYyhTnf18lvDWmfnE5ALzI=;
 b=S8Ed6UXm7yAfbZiZFp4RK+yLaJzvYEFgv55HKRzRjKe02P1IJ3+7cAE0owcxZP3hWY
 NjbH2+PMTL8HuMztroGeaJ0vte3ASHB51KklRs1j05TrHgdDyvbiKa7ImdyQbvdpGRS5
 abckx5yI7BoM9YX/B2x4jqgVyJihOJDuCa0+6A9BN2FYt0AjYwqMpw7WN2eZ68fs6fry
 oCPfUzqhZjF9voq0AtBkfYZw2ZB5OxmB80Lv5nLUxLMr7CPECwMsdmb4saCo8jxEnazP
 3Eeye/NQWsi5+7HRIiXWQhBKDlXqqswcxyZLLw+Ok2FrFSB3l6jyHnkx+IoAxtD/VIpH
 QPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710480709; x=1711085509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4qMVu2/aTlu0oZllwHJwdbYyhTnf18lvDWmfnE5ALzI=;
 b=OY+axlADOymWvtlZ/Qa3h7YvM1dx8ihPWxuHIRPQvwiF0eO16/lPMdd7byJW48grJi
 qzLyG7FB0mcaNF+4cIzlKgJKxv0mQdgis957WOQCSX5ZLS7EyEDouYoKyPmtjk27yNZr
 d6Gl4r5zFYHlQ4e3iI7nxKGzaYRMBkeqrebs2icvoOzVmNbyDI8dGISUvV/zAIjJD1ON
 3KdzWON9M2c6UE+31cRTslaiH0W5xYmcfHkqrlHciwu55xugdG9HgmgmIMS+6Ek22vew
 qWyTTrvN7ga5xhP66AZcNi/S/LvruY1aucVNw/9+wQClOxTDCeAh8fzBJXBMJ+F4FIpr
 B7yg==
X-Gm-Message-State: AOJu0Yx6ni5s8dtDCJcTG8OOMkexumG6FD4ptr9icbXcDgfexdYJfcuY
 17HNA8I635cwjssiHKSaN5i+UXnY87FVcxAbOAZWG4Xtcy90REzdB/tUUlYYYWVN/j7Vn+krXU2
 Dsh1n5CRrJlHlUXj62/Tuv2W3ey1foRbgngGcLg==
X-Google-Smtp-Source: AGHT+IGA66suOh0SjUlbJAmFCyhQCKf6jru3geGId6w+Xv2Y2y4pGq5xdimFN/reA3W6n6OHmysf4dUohIaioJ5gI4o=
X-Received: by 2002:a05:6102:291f:b0:473:1fa1:53d9 with SMTP id
 cz31-20020a056102291f00b004731fa153d9mr3043635vsb.9.1710480709028; Thu, 14
 Mar 2024 22:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-5-sumit.garg@linaro.org>
 <dbd4f385-d93f-48db-a7e9-88b86f3d7445@denx.de>
In-Reply-To: <dbd4f385-d93f-48db-a7e9-88b86f3d7445@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Mar 2024 11:01:36 +0530
Message-ID: <CAFA6WYO8k=qyexUSRs_X-YMtKZTAzM5ZeSCNEO+sJ7z91z7ohg@mail.gmail.com>
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

On Thu, 14 Mar 2024 at 09:45, Marek Vasut <marex@denx.de> wrote:
>
> On 3/12/24 8:03 AM, Sumit Garg wrote:
> > power_domain_on/off() isn't refcounted and power domain bus shouldn't be
> > turned off for a single peripheral domain as it would negatively affect
> > other peripheral domains. So lets just skip turning off bus power
> > domain.
>
> What exactly is the issue and how did you trigger it ?
>
> Details please.

I suppose the issue can be triggered via the "=> usb start => usb
stop" sequence where one of the USB controllers is configured in
peripheral mode.

>
> > Fixes: 898e7610c62a ("imx: power-domain: Add i.MX8MP HSIOMIX driver")
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >   drivers/power/domain/imx8mp-hsiomix.c | 6 +-----
> >   1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
> > index e2d772c5ec7..448746432a2 100644
> > --- a/drivers/power/domain/imx8mp-hsiomix.c
> > +++ b/drivers/power/domain/imx8mp-hsiomix.c
> > @@ -50,7 +50,7 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
> >
> >       ret = power_domain_on(domain);
> >       if (ret)
> > -             goto err_pd;
> > +             return ret;
> >
> >       ret = clk_enable(&priv->clk_usb);
> >       if (ret)
> > @@ -63,8 +63,6 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
> >
> >   err_clk:
> >       power_domain_off(domain);
> > -err_pd:
> > -     power_domain_off(&priv->pd_bus);
> >       return ret;
>
> Why not add counter into imx8mp_hsiomix_priv structure in this driver ?

Sure I can do that but do you think the current approach can have any
side effects?

-Sumit
