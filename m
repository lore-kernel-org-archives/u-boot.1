Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1972C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 15:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7371388781;
	Fri, 19 Apr 2024 17:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FpkP6LB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2631188775; Fri, 19 Apr 2024 17:25:00 +0200 (CEST)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61ED288780
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7eb7f35b0c0so665100241.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713540295; x=1714145095; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VxDbpcPJ1UpFn9kvgi0jwqu4aRWic2C9lAlFzDtWuE4=;
 b=FpkP6LB45685uhjbd+hylkL6GlKzoi28cKwTMov243tuLKBB0Tlbt4x1dthn0gREfJ
 u201JeEAUB7tPiMYkAA6KVIoGdsvQjP9tl5MbIsbrSzXDzTGwEjeAQsWw0yXGz+07d6q
 Ultzk7fzZVaGUs3p9Vkhko8e/beVme/XSYgNiI0yHG1rmbLJGeGWmi7Z85xD7AdEaf0+
 Ss9RN8ZarWAZCxN5EUzQC9bujiUuTTa4rsz4w6gpX4QqwdvtVPZoxWCTbaou+wlKLh4Q
 C90GThq82hh3+GqT/3eZi2NlridIgIG35JrDp0A5qo8I286ZvRkh4hT/B6Nk0ACJCcv9
 rnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713540295; x=1714145095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VxDbpcPJ1UpFn9kvgi0jwqu4aRWic2C9lAlFzDtWuE4=;
 b=vn4IOWyCaMKzzSrnQRdejMwflZNm/X9lOF80CslqBN1Q4A6kUMVz3xaJ6iJ426Prle
 aHDspetXWhdgt02MYR4YmNY8bpKg+j0OTJB+/BWq2iuO0SKEfr7L3TradtnaqdVhief4
 cMwPOhaE5wJpkkOC3r9fSaVz6kcoXtCLe1uBE+U6CVfuhaRsP/Rb/oNNoI9Z6lJvfyKw
 4Qfa05lf32pNmlziZvk4qrslC8PjJFoJs01RTSMxI+WM6HTTjSftI1q2GTi0JW+vS+W/
 HdMApHcZGUOb/U2DIDglud/BN7nrml092ruJ0njANblHXMY86LwfmNBACced7m2G85Aw
 ktuA==
X-Gm-Message-State: AOJu0Yz7GPinA78ah/9Hw82EpLeE/VDDIkkXgP2WxMxdpPbSgnkKEENN
 JXm52fACreT9wWMfw80Q/0AdkcYTflDWbsRpClkDkaSnJuhJhjNYiogEJjZsa0+T1OU5o+uL4Tj
 lVKbDlAhZgYmkH1Jrnc0U6z0DMwq66Gwig90RpEPbtcSHreY+
X-Google-Smtp-Source: AGHT+IH7OQ/aRvBZGo1ZrTFdNg2OTAaF71S0GO1vJ1kiktPhAXBCFF9f/x0zZ7TMtSHL1OjQBuC/og8cp9NJa9wNvt0=
X-Received: by 2002:a67:f810:0:b0:47b:c52b:7cd1 with SMTP id
 l16-20020a67f810000000b0047bc52b7cd1mr2638261vso.2.1713540294977; Fri, 19 Apr
 2024 08:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240412095438.410570-1-sumit.garg@linaro.org>
In-Reply-To: <20240412095438.410570-1-sumit.garg@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 19 Apr 2024 08:24:41 -0700
Message-ID: <CAFA6WYNLLZUeM8GFtjyTvKhmCAk+6dmzef0ejAkYyTOm1nwBEw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Add SE HMBSC board support
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com, 
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

Hi Caleb,

On Fri, 12 Apr 2024 at 02:54, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> SE HMIBSC board is based on Qcom APQ8016 SoC. One of the major
> difference from db410c is serial port where HMIBSC board uses UART1 as
> the debug console with an RS232 port, patch #2 - #5 adds corresponding
> driver support.
>
> Patch #6 adds main HMIBSC board specific bits, features:
> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> - 2GiB RAM
> - 64GiB eMMC, SD slot
> - WiFi and Bluetooth
> - 2x Host, 1x Device USB port
> - HDMI
> - Discrete TPM2 chip over SPI
>
> Features enabled in U-Boot:
> - RAUC updates (refer [2] for more details)
> - Environment protection
> - USB based ethernet adaptors
>
> Feedback is very much welcome.
>
> Changes in v4:
> - Rebased on top of qcom-main [4].
> - Split out board DTS patch as #6.
> - Convert to text based environment as hmibsc.env.
> - MMC regression has been reported for qcom-main branch here [5].
> - Collected further review tag.

I haven't seen any further comments on this series. Can you help pick it up?

-Sumit

>
> Changes in v3:
> - Rebased on top of qcom-next [1].
> - Collected some review tags.
> - Incorporated misc. comments from Caleb and Stephen.
> - Split patch#4 as requested.
> - Linux HMIBSC board DTS has already been reviewed here [3], I have
>   incorporated that for U-Boot too.
>
> Changes in v2:
> - Rebased on top on qcom-next [1].
> - Added patch#1 as a fix for generic qcom board support.
> - Added patch#4 to enable driving GPIO pins based on pinctrl
>   configuration. This replaces the custom GPIO configuration.
> - Added proper DTS file for HMIBSC board based on Linux DT pattern.
> - Merged board support patches into a single patch#5.
>
> [1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/qcom-next?ref_type=heads
> [2] https://rauc.readthedocs.io/en/latest/
> [3] https://lore.kernel.org/linux-kernel/20240403043416.3800259-4-sumit.garg@linaro.org/
> [4] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/qcom-main/?ref_type=heads
> [5] https://lore.kernel.org/all/CAFA6WYO+3VroUdFUVH390taViQX8pMQrOQDTSn0yU6BD5YY53A@mail.gmail.com/
>
> Sumit Garg (7):
>   qcom: Don't enable LINUX_KERNEL_IMAGE_HEADER by default
>   apq8016: Add support for UART1 clocks and pinmux
>   serial_msm: Enable RS232 flow control
>   pinctrl: qcom: Add support for driving GPIO pins output
>   pinctrl: qcom: apq8016: Add GPIO pinctrl function
>   arm: dts: qcom: Add Schneider HMIBSC board dts
>   board: add support for Schneider HMIBSC board
>
>  arch/arm/Kconfig                          |   2 +-
>  arch/arm/dts/apq8016-schneider-hmibsc.dts | 491 ++++++++++++++++++++++
>  board/schneider/hmibsc/MAINTAINERS        |   6 +
>  board/schneider/hmibsc/hmibsc.env         |  40 ++
>  configs/hmibsc_defconfig                  |  87 ++++
>  doc/board/index.rst                       |   1 +
>  doc/board/schneider/hmibsc.rst            |  45 ++
>  doc/board/schneider/index.rst             |   9 +
>  drivers/clk/qcom/clock-apq8016.c          |  38 +-
>  drivers/pinctrl/qcom/pinctrl-apq8016.c    |   2 +
>  drivers/pinctrl/qcom/pinctrl-qcom.c       |  25 +-
>  drivers/serial/serial_msm.c               |  24 +-
>  include/configs/hmibsc.h                  |  16 +
>  13 files changed, 760 insertions(+), 26 deletions(-)
>  create mode 100644 arch/arm/dts/apq8016-schneider-hmibsc.dts
>  create mode 100644 board/schneider/hmibsc/MAINTAINERS
>  create mode 100644 board/schneider/hmibsc/hmibsc.env
>  create mode 100644 configs/hmibsc_defconfig
>  create mode 100644 doc/board/schneider/hmibsc.rst
>  create mode 100644 doc/board/schneider/index.rst
>  create mode 100644 include/configs/hmibsc.h
>
> --
> 2.34.1
>
