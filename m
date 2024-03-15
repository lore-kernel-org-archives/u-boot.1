Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AB5C54E66
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 05:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B0387F75;
	Fri, 15 Mar 2024 06:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WxUHSMOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C485587D6B; Fri, 15 Mar 2024 06:38:54 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4C587FBC
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 06:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7d5cbc4a585so462028241.3
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 22:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710481131; x=1711085931; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CGLRXqXXNtU+Df0vQJ6GhCSconaAYLNJjF0OfHIXZv8=;
 b=WxUHSMOWr1xjbWXUDb3p5nwy39cspwD+L1Omn5Wnm4d4qOOw8ssD6rR+wYGVUn/u0W
 WhRFZyKdw6DGlmi49aTnmo4XQH2wEiL9qkjxy2k4smO9dL3naxwlZci72guHfYsw6uCL
 AnS1Ru8Zb3tXuNAvP4hIabattBYZxdzBv2qpUITgO+c7pblyFwV+PqXl5eZDGGvR7FBX
 1nZWnIGRyNy8rTvAbPYICg1SynFEFZLhqhiJ+ku5yW/lDqd3D/kbe56heFwLuRC4E/3q
 btQZVfeHMoBodhEA//0RxwD15JBInpfPD9sKL86m6s5oUZt4ALHzC9GYJXPeDk/Uz91P
 +77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710481131; x=1711085931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CGLRXqXXNtU+Df0vQJ6GhCSconaAYLNJjF0OfHIXZv8=;
 b=ReFT4bf/YkD1sQF1dzPOuYHaEUKwM9HbsnisJc6aoHvdN69zwaRsr+c7ZseUqaXmf+
 +FSiOlEnIs9e0DwwE+FXXEolsBEuLZWcfG9xmTaHWRPKFPhq3QlpMwWjCiGb/sYzrgNI
 PvIi+SRgt/u+WJ1FO3bWs9otMyMMtF0u/f0QWDRachIjJ11W0xRMeafMF+F6ZEGqZxRo
 4In0/x3XzKaDUP7hHUFyVqteO5Kmq7Ita0qO4ruyBQtVtcHC0kikoFlRVQTyja3o0aB6
 l1xlQI/tu4Mf134hMO/KWIRhgIL5f57C/lcmaBcCUInzHCh9kN3bnn+D6jgG9D23OIIv
 rz3Q==
X-Gm-Message-State: AOJu0Yw/GvUAomlcviharTnUABzy3dcC5dXUBuIQbKuplkZwqWbaB6UO
 zAuEkz1yjRbGxP1vF93DWT5OXxjitjZjV5JN6TihH+HscpwxQuJKXHp0mH0FY6bK5mZ9v1PhZzh
 GQkXdgyW/l0c7HRJw2K+qsERnHHmFGFSec0ZndQ==
X-Google-Smtp-Source: AGHT+IHZ/dtU3aiTnNC5dDFyslmNZ+OKHtqse9eWEYAbxxbDpejmGA9jctETmAlgUGbuZ6ckj2xZwo2JkzqqQuyJgIA=
X-Received: by 2002:a05:6102:180d:b0:474:42e1:9d3a with SMTP id
 jg13-20020a056102180d00b0047442e19d3amr3989261vsb.34.1710481131454; Thu, 14
 Mar 2024 22:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-7-sumit.garg@linaro.org>
 <ab5388ef-20b6-47c2-bd9f-32c40a157272@denx.de>
In-Reply-To: <ab5388ef-20b6-47c2-bd9f-32c40a157272@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Mar 2024 11:08:39 +0530
Message-ID: <CAFA6WYOM4jGeZqnZd=vNjnO8qyvawKW-VDKru=31fRDBUJ67eA@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] imx8mp: power-domain: Expose high performance
 PLL clock
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
> > Expose the high performance PLL as a regular Linux clock
>
> ... as clock framework clock ...
>

Ack.

> > , so the
> > PCIe PHY can use it when there is no external refclock provided.
> >
> > Inspired from counterpart Linux kernel v6.8-rc3 driver:
> > drivers/pmdomain/imx/imx8mp-blk-ctrl.c. Use last Linux kernel driver
> > reference commit 7476ddfd36ac ("pmdomain: imx8mp-blk-ctrl: Convert to
> > platform remove callback returning void").
>
> With that fixed:
>
> Reviewed-by: Marek Vasut <marex@denx.de>

Thanks.

-Sumit
