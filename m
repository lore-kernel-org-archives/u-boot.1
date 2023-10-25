Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90402C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 13:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D4F9874A2;
	Wed, 25 Oct 2023 15:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mul4vx8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D129486D94; Wed, 25 Oct 2023 15:06:28 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4AF1874A2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-457c2b6713fso564891137.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 06:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698239184; x=1698843984; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J+JR7r8j4eLjI7vZshQQb6Hevon//ADsLH0/ilz/ZB4=;
 b=mul4vx8Ae++08z9HNrfx+aU0C3I8rCdtzlwac+J3vjQfm65RMYAEaHpPNeg4gsoIwM
 v5euQxodkRJbaxRp1NMXICs6eJYoiw5Y6+mys56agYBQ41Nt2/ImFrLxDPTGEa44MC/Q
 IkhPWN0YPwNxrAyITfAihOx0TxKooIeSjWkfz6Z8EYvzzRnNdFQ3MsrYXEv1+Gd7JLYo
 UnhtMOGguGCAcsLU5KVCbp9gHDNuqCPFlGsLDaACVdmjxQ6WT4+aT98am3DbjwuRuw+H
 S+FljPiSsrMdGhjKuGVXTqaaOI85DFHLXlGYu1XGH8kPh9PVQ/7Xvnro37j0RoICr5T5
 2BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698239184; x=1698843984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J+JR7r8j4eLjI7vZshQQb6Hevon//ADsLH0/ilz/ZB4=;
 b=nfOOSHaoOO8PXw5zI4fjTxPkRUvoPo1hml6IawVvnFwrFG47/sWVGAYkvtc5aScFRf
 8V7jZeSlufvG5M5gQLHY8VrqjoBJ0EPyQirn4XQur2PXUGC8mh+FFEyKfDCrtVA51Do4
 77p+rVJHVASfYiQ6vkP7AE7xsKgTGPctlmV9w7lnWZF8yn5DiUQYcy7IVgr5GGhLmxpR
 /pt5tHsjngbNFkE/O6R8EdvZruf32u4tcv99ZgD/j0YYYu+HS5IJUCDYac27q5fipuQN
 VxZoLGSBKQMqDO6YLhr0Zskam0w6cj2mwtXXn1uPtZKMpM1JLShHhnd+hrw1u4a53iF0
 5OuA==
X-Gm-Message-State: AOJu0YwbnwVU1uLH1kd9+DvxNymzfnybzuTlMRrI9PgXtwpJPRpeqjAL
 4pwKwNch8X12RzUNa1VtMYMIHDpaG5Xnoyi9MZRgSw==
X-Google-Smtp-Source: AGHT+IFvCWTeGen+hQbnvjgKtIK1z/tF3bO0mbEfsbT1z0yKcl1Vw7CAiPQRryJ5dYY24D7uQfVh/SW6BPjvKjy7z34=
X-Received: by 2002:a67:f3cc:0:b0:44d:38d6:5cb8 with SMTP id
 j12-20020a67f3cc000000b0044d38d65cb8mr8526540vsn.10.1698239184352; Wed, 25
 Oct 2023 06:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
 <CAFA6WYObsw7M+j6miQWYLVxd97v-d-RGwtBK+Ygk9v0W41ygNw@mail.gmail.com>
 <c0a4af38-f7ca-4900-99c0-9eb0fb9f2f11@linaro.org>
In-Reply-To: <c0a4af38-f7ca-4900-99c0-9eb0fb9f2f11@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 25 Oct 2023 18:36:13 +0530
Message-ID: <CAFA6WYOm=2rdKk3QZxUh4Hu0h=gUhxzEg+atD5kuiEeUSABqtA@mail.gmail.com>
Subject: Re: [PATCH 0/8] arm: mach-snapdragon: Qualcomm clock driver cleanup
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
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

On Wed, 25 Oct 2023 at 18:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Sumit,
>
> On 25/10/2023 13:10, Sumit Garg wrote:
> > Hi Caleb,
> >
> > On Wed, 25 Oct 2023 at 01:54, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> This series begins making some headway towards cleaning up Qualcomm
> >> platform support in u-boot. The following is a rough overview of the
> >> changes:
> >>
> >> * Move the Qualcomm clock drivers out of mach-snapdragon and into clk/qcom
> >> * Introduce per-platform clock driver configs to decouple Qualcomm platform
> >>   support from mach-snapdragon targets.
> >> * Add the IPQ4019 clock driver, removing it from mach-ipq40xx and introducing
> >>   the reset map.
> >> * Merge the qcom reset driver is into clk/qcom and rework it to be
> >>   compatible with upstream devicetrees.
> >> * A callback model is added so that multiple clock drivers can be
> >>   compiled in at once.
> >> * SDM845 gains support for enabling/disabling all gate clocks (CBC's) by
> >>   way of a new "gate_clk" abstraction.
> >> * Preperatory cleanup work is done to simplify the bringup process for
> >>   new platforms.
> >
> > Thanks for your cleanup work. You should have at least CCed the board
> > maintainers (board/qualcomm/*/MAINTAINERS). Were you able to test this
> > series on all the existing Qcom platforms supported?
>
> Ah! I thought I had done but it seems not :/. Added them in now.
>
> I have only been able to test this series on db845c. I don't have access
> to qcs404, and no easy access to db820c or db410c (I'm unsure to what
> extent those two boards work at all with current upstream u-boot).

I can help to test on qcs404 and db410c (I have tested it recently so
it should work).

Jorge,

Do you still maintain db820c and can help with testing?

>
> I should have included this in the cover letter.
> >
> >>
> >> Further details are included in each commit.
> >
> > I will give this series a review.
>
> Thank you!
> >
> >>
> >> The primary goal of this series is to prepare for enabling several new
> >> Qualcomm platforms in u-boot as well as additional peripherals, while
> >> minimising the amount of copy/pasted board-specific code.
> >>
> >
> > I suppose this series would move us closer to directly importing DTs
> > from Linux. Do you plan to close the remaining gap (serial DT nodes
> > are on top of my head) before adding further platform support?
>
> Yes, I currently have patches to move pinctrl out of mach-snapdragon and
> fix support for upstream DT there, as well as fixes for a number of
> other drivers. The plan is then to import sdm845 devicetree from Linux
> and adjust db845c and starqltechn to use it. The three new platforms
> (QCM2290, SM6115 and SM8250) will all use upstream devicetree.
>

Good to see that coming.

-Sumit

> >
> >> This series conflicts with a previous series introducing support for the
> >> Qualcomm RB2 board [1], I plan to resend this initial support pending
> >> acceptance of this series and several other cleanups.
> >>
> >> [1]: https://lore.kernel.org/u-boot/20230324080418.3856409-1-bhupesh.sharma@linaro.org/
> >>
> >> ---
> >> Caleb Connolly (7):
> >>       clk/qcom: move from mach-snapdragon
> >>       clk/qcom: add per-platform configs
> >>       clk/qcom: move ipq4019 driver from mach-ipq40xx
> >>       clk/qcom: sdm845: add register map for simple gate clocks
> >>       clk/qcom: use function pointers for enable and set_rate
> >>       clk/qcom: add mnd_width to clk_rcg_set_rate_mnd()
> >>       clk/qcom: fix rcg divider value
> >>
> >> Konrad Dybcio (1):
> >>       clk/qcom: handle resets and clocks in one device
> >>
> >>  arch/arm/Kconfig                                   |   2 +
> >>  arch/arm/dts/qcom-ipq4019.dtsi                     |  14 +-
> >>  arch/arm/dts/qcs404-evb.dts                        |  19 +-
> >>  arch/arm/mach-ipq40xx/Makefile                     |   1 -
> >>  arch/arm/mach-ipq40xx/clock-ipq4019.c              |  88 ------
> >>  arch/arm/mach-snapdragon/Kconfig                   |   4 +
> >>  arch/arm/mach-snapdragon/Makefile                  |   5 -
> >>  arch/arm/mach-snapdragon/clock-sdm845.c            |  98 -------
> >>  arch/arm/mach-snapdragon/clock-snapdragon.c        | 181 ------------
> >>  arch/arm/mach-snapdragon/clock-snapdragon.h        |  48 ----
> >>  .../mach-snapdragon/include/mach/sysmap-sdm845.h   |   3 +
> >>  drivers/clk/Kconfig                                |   1 +
> >>  drivers/clk/Makefile                               |   1 +
> >>  drivers/clk/qcom/Kconfig                           |  52 ++++
> >>  drivers/clk/qcom/Makefile                          |  10 +
> >>  .../clk/qcom}/clock-apq8016.c                      |  41 ++-
> >>  .../clk/qcom}/clock-apq8096.c                      |  41 ++-
> >>  .../reset-qcom.c => clk/qcom/clock-ipq4019.c}      | 165 ++++-------
> >>  drivers/clk/qcom/clock-qcom.c                      | 303 +++++++++++++++++++++
> >>  drivers/clk/qcom/clock-qcom.h                      |  96 +++++++
> >>  .../clk/qcom}/clock-qcs404.c                       |  97 +++++--
> >>  drivers/clk/qcom/clock-sdm845.c                    | 265 ++++++++++++++++++
> >>  drivers/reset/Kconfig                              |   7 -
> >>  drivers/reset/Makefile                             |   1 -
> >>  24 files changed, 938 insertions(+), 605 deletions(-)
> >> ---
> >> base-commit: 30d01b582f2274eb8c808026c5fb4c33e9f2210d
> >>
> >> // Caleb (they/them)
> >>
>
> --
> // Caleb (they/them)
