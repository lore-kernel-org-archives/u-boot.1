Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF71DC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 08:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E2C886FCE;
	Tue, 12 Mar 2024 09:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rodfDn/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D5D87DB0; Tue, 12 Mar 2024 09:20:48 +0100 (CET)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F92487F00
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 09:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-47265b3ca14so1279979137.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 01:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231645; x=1710836445; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wO8m+IER8OJUKSZpEs445iQ77jxwCtQchC+owB0uszg=;
 b=rodfDn/SW46TGH09WHoOlAL0jklWY4s/Yo+xkB5S3yFHOzFKF4FB3ek26zNgpAT9+p
 l5GmqkDDWVk7iVDszACw88gMTyn5hCn45byCcwPSxuqhM/BS2BWIJw3sIJiBFuXbjHo0
 sbhqk/S7s287Ilzmb51HRXGCN49KR7BpXXqv8THNw5BfylcoYqqkSm5d5RUfSzw3gzHU
 ZxNacK9KrxbeyxpqkS4I6LD+p8/WEC3XIMg3h/VqgL/kymC0iBsrEaaB9idvT/jtsP44
 d+JTc+VxojzrZ7nRCmdHnwzo+QOENEIicExohAgvxSaJK+b1Bc2o0DdRTxgWRfuk6Wl/
 icow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231645; x=1710836445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wO8m+IER8OJUKSZpEs445iQ77jxwCtQchC+owB0uszg=;
 b=YCL/COdBl40/syKMp89WWxapEzcGc5AFbEGTGe/quNnCjD0BafHzUQ3vhbanlyDnjt
 PSBbIICs2pUrEEuSi+QIZyL4nLpWXaJLxnr+abndHkBFQDoquUkVaT+6dFpjfOMZuZB8
 biwfpVX8zPTcF1X+Cycd+Vszt5NHXGRIkZZIEt3fqYzbQN2n0IyTQk3ANrhSjMxrPula
 5Gw8XpuJ2L6Z+xzOVN9XCGiYG96knPEMNh/lx3Ue7v8r42ylF9tBSf84ZJe7psRnq1X/
 0QH5ZIiIA48EDm3VIc8YcZ/bTTym4hG4EdkgyUmNiXct1UgIqi5jKEDM+wy/ya6hYNfK
 CteQ==
X-Gm-Message-State: AOJu0YwAkeDUGqL07vIjYpPdcLv7rzqK+8eygRgYzZxL3xA6pj/ekD8w
 XkzAUU2pqtBSt2p2jWkT/KBviW/8nu4MCaExQ8XQIwdmxqaWWQtVELG9ylXgD0DA9bTyYN4dYNt
 lOtY1cx5jOBIiM48s+kdbXGntjMcfvOCdYai4fg==
X-Google-Smtp-Source: AGHT+IFf5l6yGeSNnQde731DXgYMHmH/gNjCSM91Q97k4RkC6Dci/BVffQat67Hn03rP6sXj3gtsca+7GrfuEpyOz/Y=
X-Received: by 2002:a05:6102:3203:b0:474:5f25:58a3 with SMTP id
 r3-20020a056102320300b004745f2558a3mr561932vsf.19.1710231644822; Tue, 12 Mar
 2024 01:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240311111027.44577-1-sumit.garg@linaro.org>
 <20240311111027.44577-3-sumit.garg@linaro.org>
 <0867ce89-b6db-482c-a0f6-e2d2535dad30@linaro.org>
In-Reply-To: <0867ce89-b6db-482c-a0f6-e2d2535dad30@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 12 Mar 2024 13:50:33 +0530
Message-ID: <CAFA6WYOipEiRKtKEQH1vtoYNFdN7kT_w=fpf0qoGTJmPtC4a0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] apq8016: Add support for UART1 clocks and pinmux
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com, 
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org, 
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com, 
 jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
 stephan@gerhold.net
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

On Mon, 11 Mar 2024 at 17:57, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Sumit,
>
> On 11/03/2024 11:10, Sumit Garg wrote:
> > SE HMIBSC board uses UART1 as the main debug console, so add
> > corresponding clocks and pinmux support. Along with that update
> > instructions to enable clocks for debug UART support.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/clk/qcom/clock-apq8016.c       | 50 +++++++++++++++++++++-----
> >  drivers/pinctrl/qcom/pinctrl-apq8016.c |  1 +
> >  drivers/serial/serial_msm.c            |  6 ++--
> >  3 files changed, 47 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> > index e6647f7c41d..a620a10a520 100644
> > --- a/drivers/clk/qcom/clock-apq8016.c
> > +++ b/drivers/clk/qcom/clock-apq8016.c
> > @@ -43,6 +43,14 @@
> >  #define BLSP1_UART2_APPS_N           (0x3040)
> >  #define BLSP1_UART2_APPS_D           (0x3044)
> >
> > +#define BLSP1_UART1_BCR                      (0x2038)
> > +#define BLSP1_UART1_APPS_CBCR                (0x203C)
> > +#define BLSP1_UART1_APPS_CMD_RCGR    (0x2044)
> > +#define BLSP1_UART1_APPS_CFG_RCGR    (0x2048)
> > +#define BLSP1_UART1_APPS_M           (0x204C)
> > +#define BLSP1_UART1_APPS_N           (0x2050)
> > +#define BLSP1_UART1_APPS_D           (0x2054)
> > +
> >  /* GPLL0 clock control registers */
> >  #define GPLL0_STATUS_ACTIVE BIT(17)
> >
> > @@ -77,7 +85,7 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
> >  };
> >
> >  /* SDHCI */
> > -static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
> > +static int apq8016_clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
> This seems like an unrelated change, I don't think we need to namespace
> this function as it's static.

We should follow the same naming convention within a driver to avoid confusion.

[snip]

> > diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> > index ac4280c6c4c..eaf024a55b0 100644
> > --- a/drivers/serial/serial_msm.c
> > +++ b/drivers/serial/serial_msm.c
> > @@ -248,12 +248,14 @@ static struct msm_serial_data init_serial_data = {
> >  #include <debug_uart.h>
> >
> >  /* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
> Please update the comment to offer some hints about which UART should be
> enabled.

Okay I can add a hint for UART to be board specific.

-Sumit

> > -//int apq8016_clk_init_uart(phys_addr_t gcc_base);
> > +//int apq8016_clk_init_uart1(phys_addr_t gcc_base);
> > +//int apq8016_clk_init_uart2(phys_addr_t gcc_base);
> >
> >  static inline void _debug_uart_init(void)
> >  {
> >       /* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
> > -     //apq8016_clk_init_uart(0x1800000);
> > +     //apq8016_clk_init_uart1(0x1800000);
> > +     //apq8016_clk_init_uart2(0x1800000);
> >       uart_dm_init(&init_serial_data);
> >  }
> >
>
> --
> // Caleb (they/them)
