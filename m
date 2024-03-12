Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1980BC54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 08:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A96487DE3;
	Tue, 12 Mar 2024 09:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HF7DL51w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B5B87ABC; Tue, 12 Mar 2024 09:16:01 +0100 (CET)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72DFF87C86
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 09:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4d36196a7f7so1026545e0c.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231356; x=1710836156; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GEdPdwh3BqFqRrzuLUNEcj7aykXhs8W6gVAZP5EXsuY=;
 b=HF7DL51whXtTN3M2f+FS9aunppTyo3snw5hpgFSaxp4hhqSQgiACp0ZAXVVtw9HA/b
 IReo8jACBwyhDt4Pz/MAjCp3s2LKUYscC8PMv98qEDfEyZOYiet5Rnfy71MfwYueRQRb
 coP+B6jqLPyAZ+xUDj5Bfoj0LryUebMmvSmXKq3rojCT3E0WdDLZZ6tCd9iJLLgj9CZ3
 3TYi/eoC5zx8pTFS8U0JHRLP1TWOvHdDuT6w4QcXgmQ4Ak0seKwOSvm4rwRnxzABOSiU
 //1la3zQnjFgtuL54B4l78Bb0L9OVu6GhSKGb1u+ppptTkNxu+WgtUkAxm5gKJ6PCRVU
 wDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231356; x=1710836156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GEdPdwh3BqFqRrzuLUNEcj7aykXhs8W6gVAZP5EXsuY=;
 b=f04+Fi+pN+ixqU33ztSoFCAtlJXGHlG0QQzFL4ZL+iXWY3uStMeV1gFzKrjnk0//5k
 aGhgsQOz3qJ3Joznl/tQPPDinQzJ1kmTftrzIrlP3fwfLYnxKBtnepkYyrwd/aksnDLK
 uC40K1ttyTjt6Uokcr8qUeZbu7r1AtcIRqIWRxBGtWUhgtSJbs8wwVWEc1Hd7BdWYN4Z
 7eG9ED+ZzIXTpGCG7c/A+5Ks1Thif9w+UJxsLjLBiFmqNnAmpk1YDcReD/zFZezJta1Z
 RiyuZ/QoHei4AMJAskjjoguvLa1nlZqoPs7d/G1nFt2ztUf/TUE8kdfh7P31R6Pi0kh3
 b9rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5viE2rUoZccvA+1L1sbuUSEQfzggMWv/IHECvv+fQPcYep8w4FujxXm/vMrDY+/3fa+0vT69ZSoZ2jUkm79Zug5xNow==
X-Gm-Message-State: AOJu0YydswE/1Cga0er0stkh5SqadgvuPSGRdVMpzoiKp2E28I5l9OFb
 vBxX32CNUXdGzSJkd+dbkx/SnDke6u8ve+bZj77KCZHIv2ap22CuTL2TqFvDvWO0kt18BylFLhp
 zmO6e4uGZqlK2nd9Ycv6cWcFp4PtPH2sOPWrlzg==
X-Google-Smtp-Source: AGHT+IEuRi1xEmcpZ1Pbl17XWWTqbAxAY7fPQlRr4BxdH9U6AGRGzbOI3BS4vLaHB8loRRUSuK9j3E7Sdn2GrjPufII=
X-Received: by 2002:a05:6102:5112:b0:473:45a0:d138 with SMTP id
 bm18-20020a056102511200b0047345a0d138mr3726938vsb.2.1710231356073; Tue, 12
 Mar 2024 01:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240311111027.44577-1-sumit.garg@linaro.org>
 <20240311111027.44577-3-sumit.garg@linaro.org>
 <0867ce89-b6db-482c-a0f6-e2d2535dad30@linaro.org>
 <Ze8H8CyriUP2qjsD@gerhold.net>
 <66ebb408-ec94-4fb9-9479-a4fc6465ceab@linaro.org>
In-Reply-To: <66ebb408-ec94-4fb9-9479-a4fc6465ceab@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 12 Mar 2024 13:45:45 +0530
Message-ID: <CAFA6WYMzz3tAjVJT+-_dbmC_8epRdkG1dvUxNaf+CiS0xR6btA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] apq8016: Add support for UART1 clocks and pinmux
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, u-boot@lists.denx.de,
 neil.armstrong@linaro.org, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com, sjg@chromium.org, 
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com, 
 jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org
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

On Mon, 11 Mar 2024 at 20:20, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 11/03/2024 13:32, Stephan Gerhold wrote:
> > On Mon, Mar 11, 2024 at 12:27:11PM +0000, Caleb Connolly wrote:
> >> On 11/03/2024 11:10, Sumit Garg wrote:
> >>> SE HMIBSC board uses UART1 as the main debug console, so add
> >>> corresponding clocks and pinmux support. Along with that update
> >>> instructions to enable clocks for debug UART support.
> >>>
> >>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >>> ---
> >>>  drivers/clk/qcom/clock-apq8016.c       | 50 +++++++++++++++++++++-----
> >>>  drivers/pinctrl/qcom/pinctrl-apq8016.c |  1 +
> >>>  drivers/serial/serial_msm.c            |  6 ++--
> >>>  3 files changed, 47 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> >>> index e6647f7c41d..a620a10a520 100644
> >>> --- a/drivers/clk/qcom/clock-apq8016.c
> >>> +++ b/drivers/clk/qcom/clock-apq8016.c
> >>> @@ -43,6 +43,14 @@
> >>>  #define BLSP1_UART2_APPS_N         (0x3040)
> >>>  #define BLSP1_UART2_APPS_D         (0x3044)
> >>>
> >>> +#define BLSP1_UART1_BCR                    (0x2038)
> >>> +#define BLSP1_UART1_APPS_CBCR              (0x203C)
> >>> +#define BLSP1_UART1_APPS_CMD_RCGR  (0x2044)
> >>> +#define BLSP1_UART1_APPS_CFG_RCGR  (0x2048)
> >>> +#define BLSP1_UART1_APPS_M         (0x204C)
> >>> +#define BLSP1_UART1_APPS_N         (0x2050)
> >>> +#define BLSP1_UART1_APPS_D         (0x2054)
> >>> +
> >>>  /* GPLL0 clock control registers */
> >>>  #define GPLL0_STATUS_ACTIVE BIT(17)
> >>>
> >>> [...]
> >>> @@ -94,6 +102,33 @@ static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
> >>>     return rate;
> >>>  }
> >>>
> >>> +static const struct bcr_regs uart1_regs = {
> >>> +   .cfg_rcgr = BLSP1_UART1_APPS_CFG_RCGR,
> >>> +   .cmd_rcgr = BLSP1_UART1_APPS_CMD_RCGR,
> >>> +   .M = BLSP1_UART1_APPS_M,
> >>> +   .N = BLSP1_UART1_APPS_N,
> >>> +   .D = BLSP1_UART1_APPS_D,
> >>> +};
> >>> +
> >>> +/* UART: 115200 */
> >>> +static int apq8016_clk_init_uart1(phys_addr_t base)
> >>
> >> I know we're still dealing with some tech debt here, but I'm not a big
> >> fan of this approach. I notice that the RCG and CBCR registers are all
> >> offset by exactly 0xff0 between UART1 and UART2, what about adding a
> >> second "index" parameter to apq8016_clk_init_uart() and then offsetting
> >> the addresses by (0xff0 * index)?
> >>
> >
> > This would work for MSM8916 where you have just two UARTs, but it might
> > be misleading since the UART blocks are actually separated in 4 KiB
> > (0x1000) blocks and not offset by 0xff0. UART2 is a special case that
> > has different offsets within the 4 KiB block, for some weird reason.
> >
> > If you want to calculate the register offsets properly you would need
> > special handling for UART2, e.g. I have the following (admittedly rather
> > ugly) define in the TF-A port for MSM8916 and similar [1]:
> >
> > #define GCC_BLSP1_UART_APPS_CBCR(n)   (GCC_BASE + \
> >       (((n) == 2) ? (0x0302c) : (0x0203c + (((n) - 1) * 0x1000))))
> >
> > where n is the UART number (here 1 or 2). As a different example,
> > MDM9607 has 5 UARTs (1 to 5) and there only UART2 is special-cased,
> > while all others follow the standard offset with 0x1000 offset.
>
> fwiw I would also be fine with just treating it like a binary switch and
> only allowing UART1 or UART2 to be selected if that's simpler.

Let me rather pass GCC_BLSP1_UART1_APPS_CLK/GCC_BLSP1_UART2_APPS_CLK
as an argument to the apq8016_clk_init_uart().

-Sumit

> >
> > Thanks,
> > Stephan
> >
> > [1]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/qti/msm8916/msm8916_setup.c?h=v2.10#n40
>
> --
> // Caleb (they/them)
