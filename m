Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1731C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 12:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32DA3885A3;
	Tue, 23 Apr 2024 14:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DpGpbhvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EA7884FD; Tue, 23 Apr 2024 14:23:31 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D199F885A3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 14:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-479dd0261c8so2941487137.0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 05:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713875007; x=1714479807; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZvEfAYTracAn0sv7e00wEJ4lgGDkMJrdaaUOE5wLCsM=;
 b=DpGpbhvZfj/2jfo8f8jTG5NHAPCax5W+aA5dCoSYkDmrBFB+QoX6E52lxuN7QPz2ul
 NLsfMu6atkgyOQBqHl1pQ2A6+lYjXfO8keAtHi6YPqTgg3EGxgKX8j4QxLfkxMyrRsBY
 4zZ8qXDvOQ62AAM/X7Tead1L7EglL2zvT6ETpt8vL/Q4yr75htfzIDWU3bJy0KYdcU68
 /kAxXrrkCv+E8SnsiRj1DhchDvLyUSk5K4sycfQzMclTnu+VkeYT53WjyP5rDu7oyRDZ
 gf0fc3MkXJZrgdwEt43jNs4zYugYHhaQmVSLNErbw1tLkLq/5HmPssBWU+9DH7SBcRqJ
 nc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713875007; x=1714479807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZvEfAYTracAn0sv7e00wEJ4lgGDkMJrdaaUOE5wLCsM=;
 b=t8g23+HjL9+8Q79yf9Oy6U8+V068i3G/Kbtz0Tl0/6ofvIMmHw4UGL6zg0vRUnSmy4
 cQwwVFwA/d6t1kxFWpT3XU7ZP5uq5r7kb99zYnwFcg9WAcfoW25UVV4z/3BTDdxJ1Tzw
 1MyIcnEzR0+jc+DFeeISJwiVFU/M1l/5HzweA676ah4DdPHIwKrBvv2OkB3Wa3SOmh86
 YLt4tlstT18Faj5XJcsGCo5rGOSnZHyKvff+cXuVhMmjxZ8r4ffNu2zlMTFfMPXFam+P
 AkhdNi3wEC4724EKDNEJAuZ+bXPW26B026BoOIGW7GYv3TY3baJ4TXNnvNYB+jR2H0DA
 HR3Q==
X-Gm-Message-State: AOJu0YyQhZK/bYZxwCqq0S4rrxemfjebW+0XklX4U803aWNNq+is2ggn
 ayQxqCIRSllePKl5q0QpCaK32QrMiOW0gvNt0dE1AVB7U3nb64G/XucZUvYLgi+o1Znug7YeYMt
 hKX1RUn+aaKVs+iS8MvR3ePqe6HFtgU3ixzFkPQ==
X-Google-Smtp-Source: AGHT+IFJy/dr8lLWGudRbYvvdz1ujBC+HjuIgTvWSiJSk/BVOYyOS67Xm7zYP9Kt4eXuQhV6mX7brcuI2Ge+cbNNexw=
X-Received: by 2002:a67:f447:0:b0:47b:af16:39bc with SMTP id
 r7-20020a67f447000000b0047baf1639bcmr3798498vsn.17.1713875007623; Tue, 23 Apr
 2024 05:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240412095438.410570-1-sumit.garg@linaro.org>
 <99a5b32b-7be8-4a8b-a522-cc75dd92055d@linaro.org>
In-Reply-To: <99a5b32b-7be8-4a8b-a522-cc75dd92055d@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 23 Apr 2024 17:53:16 +0530
Message-ID: <CAFA6WYMk7Hor0c2jiX3T0yEbk1brNE+zOUgPE_XwKP49AoAY+Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Add SE HMBSC board support
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

On Tue, 23 Apr 2024 at 17:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Applied, thanks.

Thanks.

>
> (b4 didn't seem to detect this series properly, hence the manual mail).
>

Switching my workflow to b4 is on my ToDo list. I hope to do it sooner
rather than later.

-Sumit

> On 12/04/2024 11:54, Sumit Garg wrote:
> > SE HMIBSC board is based on Qcom APQ8016 SoC. One of the major
> > difference from db410c is serial port where HMIBSC board uses UART1 as
> > the debug console with an RS232 port, patch #2 - #5 adds corresponding
> > driver support.
> >
> > Patch #6 adds main HMIBSC board specific bits, features:
> > - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > - 2GiB RAM
> > - 64GiB eMMC, SD slot
> > - WiFi and Bluetooth
> > - 2x Host, 1x Device USB port
> > - HDMI
> > - Discrete TPM2 chip over SPI
> >
> > Features enabled in U-Boot:
> > - RAUC updates (refer [2] for more details)
> > - Environment protection
> > - USB based ethernet adaptors
> >
> > Feedback is very much welcome.
> >
> > Changes in v4:
> > - Rebased on top of qcom-main [4].
> > - Split out board DTS patch as #6.
> > - Convert to text based environment as hmibsc.env.
> > - MMC regression has been reported for qcom-main branch here [5].
> > - Collected further review tag.
> >
> > Changes in v3:
> > - Rebased on top of qcom-next [1].
> > - Collected some review tags.
> > - Incorporated misc. comments from Caleb and Stephen.
> > - Split patch#4 as requested.
> > - Linux HMIBSC board DTS has already been reviewed here [3], I have
> >    incorporated that for U-Boot too.
> >
> > Changes in v2:
> > - Rebased on top on qcom-next [1].
> > - Added patch#1 as a fix for generic qcom board support.
> > - Added patch#4 to enable driving GPIO pins based on pinctrl
> >    configuration. This replaces the custom GPIO configuration.
> > - Added proper DTS file for HMIBSC board based on Linux DT pattern.
> > - Merged board support patches into a single patch#5.
> >
> > [1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/qcom-next?ref_type=heads
> > [2] https://rauc.readthedocs.io/en/latest/
> > [3] https://lore.kernel.org/linux-kernel/20240403043416.3800259-4-sumit.garg@linaro.org/
> > [4] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/qcom-main/?ref_type=heads
> > [5] https://lore.kernel.org/all/CAFA6WYO+3VroUdFUVH390taViQX8pMQrOQDTSn0yU6BD5YY53A@mail.gmail.com/
> >
> > Sumit Garg (7):
> >    qcom: Don't enable LINUX_KERNEL_IMAGE_HEADER by default
> >    apq8016: Add support for UART1 clocks and pinmux
> >    serial_msm: Enable RS232 flow control
> >    pinctrl: qcom: Add support for driving GPIO pins output
> >    pinctrl: qcom: apq8016: Add GPIO pinctrl function
> >    arm: dts: qcom: Add Schneider HMIBSC board dts
> >    board: add support for Schneider HMIBSC board
> >
> >   arch/arm/Kconfig                          |   2 +-
> >   arch/arm/dts/apq8016-schneider-hmibsc.dts | 491 ++++++++++++++++++++++
> >   board/schneider/hmibsc/MAINTAINERS        |   6 +
> >   board/schneider/hmibsc/hmibsc.env         |  40 ++
> >   configs/hmibsc_defconfig                  |  87 ++++
> >   doc/board/index.rst                       |   1 +
> >   doc/board/schneider/hmibsc.rst            |  45 ++
> >   doc/board/schneider/index.rst             |   9 +
> >   drivers/clk/qcom/clock-apq8016.c          |  38 +-
> >   drivers/pinctrl/qcom/pinctrl-apq8016.c    |   2 +
> >   drivers/pinctrl/qcom/pinctrl-qcom.c       |  25 +-
> >   drivers/serial/serial_msm.c               |  24 +-
> >   include/configs/hmibsc.h                  |  16 +
> >   13 files changed, 760 insertions(+), 26 deletions(-)
> >   create mode 100644 arch/arm/dts/apq8016-schneider-hmibsc.dts
> >   create mode 100644 board/schneider/hmibsc/MAINTAINERS
> >   create mode 100644 board/schneider/hmibsc/hmibsc.env
> >   create mode 100644 configs/hmibsc_defconfig
> >   create mode 100644 doc/board/schneider/hmibsc.rst
> >   create mode 100644 doc/board/schneider/index.rst
> >   create mode 100644 include/configs/hmibsc.h
> >
>
> --
> // Caleb (they/them)
