Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891F3C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 12:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DA0C87EDA;
	Mon, 26 Feb 2024 13:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hJFQc/Rq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A69887EF3; Mon, 26 Feb 2024 13:39:24 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D6587BD6
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 13:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d130979108so1642484241.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 04:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708951161; x=1709555961; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lnXR8wzsTeYEaPN4ZscDSYInFvcIezuof3tAcRuC3dA=;
 b=hJFQc/RquAjLcckf/bx1fDDhLA+MV5t2tI95vyQuNmDsSbyUVItrfrVSN0wwWWT2Kx
 4YtuDeT7dZRAVuxVpzLMfiSsQkciwe7wsZrUSDFIQWWjacQexwFnmZZR2ri61MnYYYIW
 9YfiWPAsZ2ct77Xl79VOPBDGLQjSz426Xiijx6kHMYnWVJbwEJXBiuDTu43z/IpuCDhn
 NFZyKAdj1GCRD1Dau0RBf7zbBWWC1eFIZmSVbq4ooTzTUnof+XNJO1+qO55E1XGEfkxo
 ZQS8O+LNC0CoRdhK2NW3JsLuGjfUyiMrm6t2Q68zHylHvE+zy1Wgd+cpXL5eztzc+2uh
 cHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708951161; x=1709555961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lnXR8wzsTeYEaPN4ZscDSYInFvcIezuof3tAcRuC3dA=;
 b=wEtOB3h01zuUPBSjo+MQMLiixLtQ5t6Tnt8WNL4U3lm5rHoBb0FcnKFuaaDQM04LKK
 mta+LJBiLUALzK27oPtlSgkqCPO/x3PMpBz4nxm6NhFaIY4U+8Mcw5IFqxWzGiCtYX5e
 f/NZeTbSiKnaVAyXaqsZhDaHDiSgLp6l7oto8AZTiQxxrO5Y95sBc0riANRzXwU2V3eb
 ASBl0DPEL4Nt8f3/TqpXAZg1AclZLuq/Ad4CJ4HWW5q2R3iTwQwSqCuWSwNv7rhHgriF
 uFjps/skiY3WThLmub3in749zVm0d1RXRf4Gn5PPtYQYrAB1Sl0SW1kkuKNAPrrzKDLa
 v69w==
X-Gm-Message-State: AOJu0Yzn8xpX/rsCRO4PYATYroCyMPCEWbjU41y/XoAat5/1ZepsGf3z
 3PYpiWfTec8COUlIyrpiW1Wx5cUy328KLSoVEWThPaUHEDNik0CAdlucKnC6tP75Uf3HfqfPPH6
 7hEv7pI9LdwlHKpHaTIv4X3RlKNUtK94zSBtajQ==
X-Google-Smtp-Source: AGHT+IGL5H9jlJTN+V/My8Fqr0fOcOJOKf7zAfBKahzr5X2YiEd/Ni8RzSrjCAaNGlEJjGXxkg4sPILgLTmY8lGcNPg=
X-Received: by 2002:a67:fdc7:0:b0:471:b991:6cae with SMTP id
 l7-20020a67fdc7000000b00471b9916caemr4186250vsq.26.1708951160724; Mon, 26 Feb
 2024 04:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-5-sumit.garg@linaro.org>
 <8c36eac1-2b6b-4810-b4c9-1b8912bfe81e@denx.de>
In-Reply-To: <8c36eac1-2b6b-4810-b4c9-1b8912bfe81e@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Feb 2024 18:09:09 +0530
Message-ID: <CAFA6WYO2n-QG7TvSnKyk5O0Pzwcn0jd4iCeLbebbsVZiOq2fdQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] imx8mp: power-domain: Expose high performance PLL
 clock
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, 
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org, 
 peng.fan@nxp.com, aford173@gmail.com, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
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

On Mon, 26 Feb 2024 at 14:24, Marek Vasut <marex@denx.de> wrote:
>
> On 2/26/24 9:04 AM, Sumit Garg wrote:
> > Expose the high performance PLL as a regular Linux clock, so the
> > PCIe PHY can use it when there is no external refclock provided.
> >
> > Inspired from counterpart Linux kernel v6.8-rc3 driver:
> > drivers/pmdomain/imx/imx8mp-blk-ctrl.c
>
> Commit ID, please, see previous comments in this series.
>
> [...]
>
> > +static int hsio_pll_clk_enable(struct clk *clk)
> > +{
> > +     void *base = (void *)dev_get_driver_data(clk->dev);
> > +     u32 val;
> > +     int ret;
> > +
> > +     /* Setup HSIO PLL */
> > +     clrsetbits_le32(base + GPR_REG2,
> > +                     P_PLL_MASK | M_PLL_MASK | S_PLL_MASK,
> > +                     FIELD_PREP(P_PLL_MASK, 12) |
> > +                     FIELD_PREP(M_PLL_MASK, 800) |
> > +                     FIELD_PREP(S_PLL_MASK, 4));
>
> These magic numbers 12, 800, 4 could use explanation (why these
> numbers?) and a dedicated macro .
>

I can't find any information in TRM as to how HSIO PLL computation is
done. However, I can extend the comment above to say that this
configuration leads to a 100 MHz PHY clock as per
clk_hsio_pll_recalc_rate() in Linux kernel driver.

> > +     /* de-assert PLL reset */
> > +     setbits_le32(base + GPR_REG3, PLL_RST);
> > +
> > +     /* enable PLL */
> > +     setbits_le32(base + GPR_REG3, PLL_CKE);
> > +
> > +     /* Check if PLL is locked */
> > +     ret = readl_poll_sleep_timeout(base + GPR_REG1, val,
> > +                                    val & PLL_LOCK, 10, 100000);
> > +     if (ret)
> > +             dev_err(clk->dev, "failed to lock HSIO PLL\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static int hsio_pll_clk_disable(struct clk *clk)
> > +{
> > +     void *base = (void *)dev_get_driver_data(clk->dev);
> > +
> > +     clrbits_le32(base + GPR_REG3, PLL_CKE);
> > +     clrbits_le32(base + GPR_REG3, PLL_RST);
>
> Can you clear both at once, or do they have to be cleared in sequence ?

I generally follow the reverse sequence of how the configuration is
done during hsio_pll_clk_enable(). These bits have seperate functions
related to clock and reset. So I would prefer to keep them as they
are.

>
> [...]
>
> The series is starting to look much better compared to V1 btw , these ^
> are only nitpicks .

Thanks for your detailed review, I appreciate it.

-Sumit
