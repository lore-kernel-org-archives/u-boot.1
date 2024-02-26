Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91975C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 13:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0368487A09;
	Mon, 26 Feb 2024 14:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bgw5j4Rx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84F8A877B1; Mon, 26 Feb 2024 14:50:14 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7600687DEF
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 14:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-47044462962so347106137.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 05:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708955409; x=1709560209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c0zliVdHwlRcFauJpf5Fnewz4tPLOXmX04maTixWGwY=;
 b=bgw5j4RxI3Y1orDq9tf9+KfVzTfJeWKK3NaUpYpasEV479W+5TLMNMsPdDnbvTRMnP
 Zqflo7fNGYjQ+1CiASXjB08be6ywqhJflVKDIkXmcguTOSFcaxqNBgo3VEZY0a77Vgr/
 s3pyTp170MqVNaoxFoScsJalFt2TgRJ53O7Lm31PibJ4z91I+u/AQ1B/2AUCLTnuV+DF
 m9hpakddavbxLDnXdV47r5LBf805hSk4V+HC4MuEAvlWO3oijOTpG+Wp5+dLA45nero2
 8L2nCRpOw4dvhnQ02ct62aO8rXSbhOQzLB4ZFUdU7gc6dA26Ef7gdYBH6+AncHbHwtU3
 7mvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708955409; x=1709560209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c0zliVdHwlRcFauJpf5Fnewz4tPLOXmX04maTixWGwY=;
 b=ip/Y65D+vcZLlukHrcPef05MuCHNLy8GH35EevJwBrLuyghz7SKt8z7K4M88bk7HV6
 GZVL6FjNW5Wn3YShR//fTU9ntg3KT0dVMoiQszFLDuplIxeEqkHernevwqb2OWcO+ffT
 pMzdRZu9bC840x9GTU6TtCebkSXZQ2EyGWFC5f9tJkhPHVyhw9M3F7tLcH2leVHI7cZY
 26T1SMqDaACzCF1Rlhlw+EV+gMzFYZiDP7lV8epWwc11qscLF4f9g63qJRz+gUxgwv/1
 y8nQezF4OfVtZXRKFOHlnbJ3zqUHM1IAgq5wqD+FZrgSRj+pImVQJQpx3vwIYeOnmTKn
 rqEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXojqCxtPk/Au5rC1pSIzg2wz/j/YcxPPBokxdux0LGdWRSfuoyxz5hQ+9Mo8ApPmMny/CRZsIBinYf5kX9Opd3PZ25qA==
X-Gm-Message-State: AOJu0YyPNfAPcsIZSm32cP/jAd9bFqjRtCu/fBaqyKbPAP4OiZ8heS0d
 um/f6ljikwKQjt54XtOa3I9mJwJkv79uOkrXf1bPS9UUQAQwMX9TubDPCPrW+N5jR78pV2IhHHB
 ffngjF9A3Bo8ZzgcQ24qDK29ofn9kLlSoGqp9hQ==
X-Google-Smtp-Source: AGHT+IFr4/pIYfWSsGyNnuTvLOSe20gLPOAQXqumH8Gwd4x7DxmTN1Tb0T4aVKYctCrsfeYmxuamWjGydj0yDidNRjg=
X-Received: by 2002:a05:6102:3943:b0:471:e2fa:1f1f with SMTP id
 f3-20020a056102394300b00471e2fa1f1fmr1798500vsu.9.1708955409143; Mon, 26 Feb
 2024 05:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-6-sumit.garg@linaro.org>
 <609581c7-d221-4eff-862b-6f172ba9d4e8@denx.de>
 <CAFA6WYPdqsD7Xy1EwX7R_+A3UiskvxaTyvR6D9qP45WhUxxA6A@mail.gmail.com>
 <180d7078-ac13-4d56-8ef5-2b64f7f41937@denx.de>
 <CAFA6WYOGzrM076RJv6Mp_Qaa7Z8h3hUC4mRf8CerkVUB7Ac3oA@mail.gmail.com>
 <9a747aba-df77-405c-b179-4d5e5ee3234e@denx.de>
In-Reply-To: <9a747aba-df77-405c-b179-4d5e5ee3234e@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Feb 2024 19:19:58 +0530
Message-ID: <CAFA6WYNhS7Z=3kfOsXmmo1hCUEUMQgwHFVR0vZ8aWFOnBecQTg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
To: Marek Vasut <marex@denx.de>
Cc: lukma@denx.de, seanga2@gmail.com, u-boot@lists.denx.de, 
 marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com, 
 jh80.chung@samsung.com, festevam@denx.de, andrejs.cainikovs@toradex.com, 
 sjg@chromium.org, peng.fan@nxp.com, aford173@gmail.com, 
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

On Mon, 26 Feb 2024 at 19:06, Marek Vasut <marex@denx.de> wrote:
>
> On 2/26/24 2:30 PM, Sumit Garg wrote:
> > On Mon, 26 Feb 2024 at 18:34, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 2/26/24 1:50 PM, Sumit Garg wrote:
> >>
> >> [...]
> >>
> >>>>> +     ret = reset_get_by_name(dev, "pciephy", &imx8_phy->reset);
> >>>>> +     if (ret) {
> >>>>> +             dev_err(dev, "Failed to get PCIEPHY reset control\n");
> >>>>> +             return ret;
> >>>>> +     }
> >>>>
> >>>> Some clk_put() and co. fail path is missing here.
> >>>
> >>> Ditto for clk_put() not being available. However, I can add the fail
> >>> path for the other reset.
> >>
> >> Oh, maybe reset_free() and clk_release*() then ?
> >
> > AFAICS, clk_release*() APIs are internally only a wrapper around
> > clk_disable(). So actually those APIs don't seem to do anything useful
> > in the fail path here.
> >
> > However, I will let clock tree maintainers chime in here if they plan
> > to remove clk_release*() APIs on similar lines as with clk_free().
>
> Maybe they should be in place so in case in the future clock should be
> torn down, it wouldn't be necessary to fix so many drivers ?

See the following comparison:

$ git grep -nr clk_get_by_name | wc -l
229

$ git grep -nr clk_release | wc -l
59

There are already many driver instances which don't use clk_release*() APIs.

-Sumit
