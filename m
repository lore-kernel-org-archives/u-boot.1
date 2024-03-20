Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAECCD11DB
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 07:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1889E880D5;
	Wed, 20 Mar 2024 08:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V9R964d6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B549880A6; Wed, 20 Mar 2024 08:16:41 +0100 (CET)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0779F880D5
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 08:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4766537b40fso1500960137.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 00:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710918997; x=1711523797; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ypr2giHmPRKJECMXzvHgr6612/RPGthhTSLopno0N/c=;
 b=V9R964d6uL+OMXRzpuOBV4uDDHT7UU+kzDxukhWWc7e4Xyr1erBluUXQYtkuCHo6mH
 1IbJaE5bN2UXQcntWtaCNeiiM5FaoinjVWZvX2ePx2A7Ac2JPYJJUeR/CI0hs/85clYw
 dihRBoBYxKGJpqEBkCqIKeUDrNi1qHXf0E9SQMPqom1Xs5jb0P4SpTp266FD1T69fE5o
 8Tpn5DPGz9FwbBMa5Qgbtp9SFJsjZHtjBFa8RlX6iTGBsbkHpakLSv41ICmx62TS5W1r
 vcXQap5jlyawqXJ0AzmIDRthNqPhNt4wBQUdkF5lvCGWnWIwo2zcLmL+cZgUPoKaUqwE
 d4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710918997; x=1711523797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ypr2giHmPRKJECMXzvHgr6612/RPGthhTSLopno0N/c=;
 b=BFioQH9wBJVo9cLWGYvSqxVQN+r1Mm5kkj65hz30AkS8+0zBvEKNTWNOQDvRcq7qwG
 jwudQHQAQqjBFYZX6Hnas/iTh1E7ftaV8CxV/gRfJuS+oLSeywndRv3k31C5zXmvgmOi
 nCRxy02NSjtelvcSA4xr9i9FTBC2YAAFYdKekMwnlnPuez61r/Wq3NQpH/rEuHgTgqvF
 38LhfyaaKTpXTFfVWnJdLmHlxYxKQmLS36CN5EESvt/PhUV9TntCCkAGEXm9DYLY3oyx
 fJxQhTadDlkGT/RiAgwMB/jztXl7oaWoA4Mh6CfcNVLfwtizcz0NGzC2TWsbeitRSLqz
 R3SA==
X-Gm-Message-State: AOJu0Yxq2sY1dBnicFh7E7rgX85bzPEtogdgWw11Vc8Klq27r9+YHrsZ
 Rb8+oyDDAGn4iV8rNaYx5N0s96ge8juyEr5fT5FKMxaEmrjUm1te6U0ATvYpHRpL60AprmPd/iZ
 cEoirVSd585fO2bfzCukW/ajz/fChhmRWWxt1OQ==
X-Google-Smtp-Source: AGHT+IGKWiXaex2PNYIvZSyqXy3lvUkv1rdjL7svWyace7faUUCV7arth6C3uOtNv5Ysc3BqeUIYxM8Ai/9YCFhDvUc=
X-Received: by 2002:a05:6102:549e:b0:473:27fd:d897 with SMTP id
 bk30-20020a056102549e00b0047327fdd897mr5441902vsb.22.1710918996801; Wed, 20
 Mar 2024 00:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-5-sumit.garg@linaro.org>
 <dbd4f385-d93f-48db-a7e9-88b86f3d7445@denx.de>
 <CAFA6WYO8k=qyexUSRs_X-YMtKZTAzM5ZeSCNEO+sJ7z91z7ohg@mail.gmail.com>
 <f789292a-7c46-4b98-935f-86bfea39ab05@denx.de>
 <CAFA6WYPHqdWiL=8foFDD9Rs+_L+E-=D+VMC=FZrnKeQdcooNMQ@mail.gmail.com>
In-Reply-To: <CAFA6WYPHqdWiL=8foFDD9Rs+_L+E-=D+VMC=FZrnKeQdcooNMQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Mar 2024 12:46:25 +0530
Message-ID: <CAFA6WYOExXZFxQgGkW_S0Z296pbjgY0pLoMkSr1JpUi0HSWMxg@mail.gmail.com>
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

Gentle ping..

On Fri, 15 Mar 2024 at 16:11, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 15 Mar 2024 at 14:53, Marek Vasut <marex@denx.de> wrote:
> >
> > On 3/15/24 6:31 AM, Sumit Garg wrote:
> > > On Thu, 14 Mar 2024 at 09:45, Marek Vasut <marex@denx.de> wrote:
> > >>
> > >> On 3/12/24 8:03 AM, Sumit Garg wrote:
> > >>> power_domain_on/off() isn't refcounted and power domain bus shouldn't be
> > >>> turned off for a single peripheral domain as it would negatively affect
> > >>> other peripheral domains. So lets just skip turning off bus power
> > >>> domain.
> > >>
> > >> What exactly is the issue and how did you trigger it ?
> > >>
> > >> Details please.
> > >
> > > I suppose the issue can be triggered via the "=> usb start => usb
> > > stop" sequence where one of the USB controllers is configured in
> > > peripheral mode.
> >
> > 'usb start ; usb stop' causes no problems on MX8MP , maybe the test case
> > is more extensive ?
> >
> > Please, write down the necessary steps to reproduce this problem, and
> > what happens when that problem occurs.
>
> After digging in more, it looks like dev_power_domain_off() is never
> (U-Boot life-cycle) invoked for USB controller devices derived from
> DT. So this USB power domain sequence is never reachable.
>
> BTW, dev_power_domain_on() is invoked when USB controller devices are
> added based on DT.
>
> >
> > >>> Fixes: 898e7610c62a ("imx: power-domain: Add i.MX8MP HSIOMIX driver")
> > >>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > >>> ---
> > >>>    drivers/power/domain/imx8mp-hsiomix.c | 6 +-----
> > >>>    1 file changed, 1 insertion(+), 5 deletions(-)
> > >>>
> > >>> diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
> > >>> index e2d772c5ec7..448746432a2 100644
> > >>> --- a/drivers/power/domain/imx8mp-hsiomix.c
> > >>> +++ b/drivers/power/domain/imx8mp-hsiomix.c
> > >>> @@ -50,7 +50,7 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
> > >>>
> > >>>        ret = power_domain_on(domain);
> > >>>        if (ret)
> > >>> -             goto err_pd;
> > >>> +             return ret;
> > >>>
> > >>>        ret = clk_enable(&priv->clk_usb);
> > >>>        if (ret)
> > >>> @@ -63,8 +63,6 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
> > >>>
> > >>>    err_clk:
> > >>>        power_domain_off(domain);
> > >>> -err_pd:
> > >>> -     power_domain_off(&priv->pd_bus);
> > >>>        return ret;
> > >>
> > >> Why not add counter into imx8mp_hsiomix_priv structure in this driver ?
> > >
> > > Sure I can do that but do you think the current approach can have any
> > > side effects?
> >
> > Bus domain not getting cycled (which can leave it in some odd state),
> > and increased power consumption if the next stage doesn't turn the
> > domain off.
>
> Given above, would you like me to drop power domain off path entirely
> here? I think if people are concerned about power consumption then it
> should be implemented properly in U-Boot to remove all the DT based
> devices before passing on control to the next stage.

How would you like me to proceed here?

-Sumit
