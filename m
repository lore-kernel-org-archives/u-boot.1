Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9BCC48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 05:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E05E87DDD;
	Wed, 21 Feb 2024 06:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X3FnscPv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3605987DDD; Wed, 21 Feb 2024 06:40:52 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5904C87DD4
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 06:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d2e1832d4dso2540054241.2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 21:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708494036; x=1709098836; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wCnpZCXGc66eTrbrYa+lxFBtj6akthQ0iV3B93GlxSY=;
 b=X3FnscPv2OhT2ahkIOQa+ihv/g4za040kuAaTYvVxGzyRJiXce3tDXp4xloUGqJGOH
 7Sm6nHRghQsTeZm2aU+bfDer7m5td3mWUKqZDmPewRNCBVfPRq2CgV/h0Fvg7tdU0E8s
 sTKKqKQ7fczk2XxI5u+EOEqlMLL9oC9yq/ENvYAFmFQxvAnTAGXrIcy5udX3BS0uDvGJ
 MYXU9VSy16wTv5PydF/knfbIuKfC927MD8cOj3g7yHSOOCroUaE3ZaA7E3CB7+g0HoN9
 7bsAERtv1g2QgP9Jgv8ptv00DrMIEr3n3qQiRxK95OP5VPYDfjnx4Znhi+e0CkLeAcpy
 LF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708494036; x=1709098836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wCnpZCXGc66eTrbrYa+lxFBtj6akthQ0iV3B93GlxSY=;
 b=lXTZKN2XZMvODsuS61Ts8elACCiHBiHxIjtaobXZ58q1srXs6iv37WsON63Hc2zYWE
 3dLPMvIvjOVnoF6kH73tVsVdBzBY09T2Y+bWf/b14xoJFcbbVjeg2Om2hW1nrR08cYDC
 lcXZ2c0S8YqhuLKjmk/yzTZI5TClFpVXZlW2ZK8hkfxL54lIsS2bRrrBiCt79CaZ45w+
 Z0O+qs5EUsO6VIglqg3p55XDFhUCMUW7UN2o8cGnJvvST/z3lmQa444ooui2KZfycq8E
 idi4t5y8TqIz2K9sO21LYobrOToFZ5S9ilXOVK0lD9yekDsI2fg3BbDJHkOiNoS0/D5j
 HGOg==
X-Gm-Message-State: AOJu0YyDB79/Fdk2B08NoxAgoSvLvMOzFlBcgF/Bok3GC9XVvRD/TisD
 QoEvpDd4DQGtes9fFCasT7+j+PlreThuNPONqDXwN3RGlhgz4pwEOSuOfSGpfS4GA8CCBggyGuJ
 ZfJRE6mfj3IKsFVZ6H/EWgLjFw2PTULNn1Byglw==
X-Google-Smtp-Source: AGHT+IGbaeYqLRYmw09jxclmFbHOXcXZo3sPa/QvbFS5jzkM09ZhmeE0it8ShK0zu6mmmjPpWIsmtN76VKESTJK0SmU=
X-Received: by 2002:a67:c902:0:b0:46d:2b65:aa16 with SMTP id
 w2-20020a67c902000000b0046d2b65aa16mr11099120vsk.34.1708494036644; Tue, 20
 Feb 2024 21:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-3-sumit.garg@linaro.org>
 <314b12f0-7b5d-44f4-bcf1-69a287a9005d@denx.de>
In-Reply-To: <314b12f0-7b5d-44f4-bcf1-69a287a9005d@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 21 Feb 2024 11:10:25 +0530
Message-ID: <CAFA6WYPwHdSZwcHQaszVG_0++DRU4ykmsLcxO3m4PJhyGRcy3A@mail.gmail.com>
Subject: Re: [PATCH 2/7] reset: imx: Add support for i.MX8MP reset controller
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com, 
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com, 
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, 
 fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Tue, 20 Feb 2024 at 21:02, Marek Vasut <marex@denx.de> wrote:
>
> On 2/20/24 14:10, Sumit Garg wrote:
> > Pre-requisite to enable PCIe support on iMX8MP SoC.
>
> Please write a proper commit message .
>

How about the following?

    Add support for i.MX8MP reset controller. It is required
    to enable PCIe support on the iMX8MP SoC.

> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >   drivers/reset/reset-imx7.c | 114 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 114 insertions(+)
> >
> > diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> > index eaef2cc2cdf..c1de84dea8b 100644
> > --- a/drivers/reset/reset-imx7.c
> > +++ b/drivers/reset/reset-imx7.c
> > @@ -10,6 +10,7 @@
> >   #include <dm.h>
> >   #include <dt-bindings/reset/imx7-reset.h>
> >   #include <dt-bindings/reset/imx8mq-reset.h>
> > +#include <dt-bindings/reset/imx8mp-reset.h>
> >   #include <reset-uclass.h>
> >   #include <linux/bitops.h>
> >   #include <linux/delay.h>
> > @@ -252,6 +253,115 @@ static int imx7_reset_assert_imx8mq(struct reset_ctl *rst)
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
>
> This seems copied from Linux, include Linux commit ID as of which this
> was imported from in commit message.

Do you expect imx8mp_src_registers to change? I expect them to be the
same, so does Linux commit ID add any value here?

-Sumit
