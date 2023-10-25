Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DBEC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 12:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E744187A94;
	Wed, 25 Oct 2023 14:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o375Yh9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D6287A9B; Wed, 25 Oct 2023 14:47:47 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9FD3879AB
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 14:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5079f9675c6so8828886e87.2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 05:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698238063; x=1698842863; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7RxZiF2e0YHRiLVxZJ9d5TyND+K3E3HDt1kT0vXu66w=;
 b=o375Yh9TQQtRmP+Q3/9iASMlxQ9Eyojk8Le16Y43OI1JYInSZYyM3r0NjmsrVWv7pk
 LO75qQtCEK+eEVnIPX3xCz7ijADkfuQ/QzP0Mlnak9yMD/4QZ1igrnhk7OQyhgFbihDM
 /FHEZLDk4nb4g+zRfTNvCkYFL1G0gvzpgXpWxOjFpL7sjQU91YnkUJkjXSaBYwX7tlIA
 ouqI0TZO4+AVxAdd7OJPiUWb1X3w6Y3cdoow2665B8RJYBIUtuAqGUDiuqf/LRyRvDQx
 uaFtntj2q4melDORMxiUJ5myKXJtUzzzj2CWuial3Lfl2r5ExiJGtBRa8Br5TXyJ17IG
 OI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698238063; x=1698842863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7RxZiF2e0YHRiLVxZJ9d5TyND+K3E3HDt1kT0vXu66w=;
 b=EIeUQP7V8INlooFsYOC7mxQdIf6LmKWphcRFsLvugINe4hF1jTHUwSnTPi0rT6/uqf
 qogA1WWOKLJDhfih3pn09k1jI/MxQ08oeAg75arRFjQxq3mveLca5nUqyEYrOh2NM/t9
 xRUxvhKjGQGnViOGa4mwIwJP/vRduu9yd81eZB97sEy8HB6gONaiUEKzM4wJUHlhXUfU
 cARDaXYYOMRDbOXt79ajPaRArDoKa+HAjinuKSfyejpPMJM5cVt04IFU7Mu/CVrXFEu6
 FksnfNVzEpqi9b0279RD8bH+4flLfJTpJJmb52jA0g/bi2hoaqU3QNhc9Vw7BF9nlWrY
 G5/A==
X-Gm-Message-State: AOJu0Yw+UYS97KZoDVQnTgEn8Cu7J7SwbwDtIffM8hwFxXJ6opm2lYoZ
 xYpDDZlSfFRHjo8qMgnybtz6Ew==
X-Google-Smtp-Source: AGHT+IFDwbjMRWBd85h1LzgjZPvoOM8JEW/e2rx6T/Wxrruc9H7mH1eny8dv8mEFRCiiY4xdGJ6N5g==
X-Received: by 2002:a05:6512:3a8e:b0:507:a1e5:74fe with SMTP id
 q14-20020a0565123a8e00b00507a1e574femr13139817lfu.54.1698238063056; 
 Wed, 25 Oct 2023 05:47:43 -0700 (PDT)
Received: from [192.168.1.15] (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 ay20-20020a05600c1e1400b00407460234f9sm14613093wmb.21.2023.10.25.05.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 05:47:42 -0700 (PDT)
Message-ID: <c0a4af38-f7ca-4900-99c0-9eb0fb9f2f11@linaro.org>
Date: Wed, 25 Oct 2023 13:47:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] arm: mach-snapdragon: Qualcomm clock driver cleanup
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>, Luka Perkov
 <luka.perkov@sartura.hr>, Vladimir Zapolskiy
 <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
 <CAFA6WYObsw7M+j6miQWYLVxd97v-d-RGwtBK+Ygk9v0W41ygNw@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYObsw7M+j6miQWYLVxd97v-d-RGwtBK+Ygk9v0W41ygNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Sumit,

On 25/10/2023 13:10, Sumit Garg wrote:
> Hi Caleb,
> 
> On Wed, 25 Oct 2023 at 01:54, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> This series begins making some headway towards cleaning up Qualcomm
>> platform support in u-boot. The following is a rough overview of the
>> changes:
>>
>> * Move the Qualcomm clock drivers out of mach-snapdragon and into clk/qcom
>> * Introduce per-platform clock driver configs to decouple Qualcomm platform
>>   support from mach-snapdragon targets.
>> * Add the IPQ4019 clock driver, removing it from mach-ipq40xx and introducing
>>   the reset map.
>> * Merge the qcom reset driver is into clk/qcom and rework it to be
>>   compatible with upstream devicetrees.
>> * A callback model is added so that multiple clock drivers can be
>>   compiled in at once.
>> * SDM845 gains support for enabling/disabling all gate clocks (CBC's) by
>>   way of a new "gate_clk" abstraction.
>> * Preperatory cleanup work is done to simplify the bringup process for
>>   new platforms.
> 
> Thanks for your cleanup work. You should have at least CCed the board
> maintainers (board/qualcomm/*/MAINTAINERS). Were you able to test this
> series on all the existing Qcom platforms supported?

Ah! I thought I had done but it seems not :/. Added them in now.

I have only been able to test this series on db845c. I don't have access
to qcs404, and no easy access to db820c or db410c (I'm unsure to what
extent those two boards work at all with current upstream u-boot).

I should have included this in the cover letter.
> 
>>
>> Further details are included in each commit.
> 
> I will give this series a review.

Thank you!
> 
>>
>> The primary goal of this series is to prepare for enabling several new
>> Qualcomm platforms in u-boot as well as additional peripherals, while
>> minimising the amount of copy/pasted board-specific code.
>>
> 
> I suppose this series would move us closer to directly importing DTs
> from Linux. Do you plan to close the remaining gap (serial DT nodes
> are on top of my head) before adding further platform support?

Yes, I currently have patches to move pinctrl out of mach-snapdragon and
fix support for upstream DT there, as well as fixes for a number of
other drivers. The plan is then to import sdm845 devicetree from Linux
and adjust db845c and starqltechn to use it. The three new platforms
(QCM2290, SM6115 and SM8250) will all use upstream devicetree.

> 
> -Sumit
> 
>> This series conflicts with a previous series introducing support for the
>> Qualcomm RB2 board [1], I plan to resend this initial support pending
>> acceptance of this series and several other cleanups.
>>
>> [1]: https://lore.kernel.org/u-boot/20230324080418.3856409-1-bhupesh.sharma@linaro.org/
>>
>> ---
>> Caleb Connolly (7):
>>       clk/qcom: move from mach-snapdragon
>>       clk/qcom: add per-platform configs
>>       clk/qcom: move ipq4019 driver from mach-ipq40xx
>>       clk/qcom: sdm845: add register map for simple gate clocks
>>       clk/qcom: use function pointers for enable and set_rate
>>       clk/qcom: add mnd_width to clk_rcg_set_rate_mnd()
>>       clk/qcom: fix rcg divider value
>>
>> Konrad Dybcio (1):
>>       clk/qcom: handle resets and clocks in one device
>>
>>  arch/arm/Kconfig                                   |   2 +
>>  arch/arm/dts/qcom-ipq4019.dtsi                     |  14 +-
>>  arch/arm/dts/qcs404-evb.dts                        |  19 +-
>>  arch/arm/mach-ipq40xx/Makefile                     |   1 -
>>  arch/arm/mach-ipq40xx/clock-ipq4019.c              |  88 ------
>>  arch/arm/mach-snapdragon/Kconfig                   |   4 +
>>  arch/arm/mach-snapdragon/Makefile                  |   5 -
>>  arch/arm/mach-snapdragon/clock-sdm845.c            |  98 -------
>>  arch/arm/mach-snapdragon/clock-snapdragon.c        | 181 ------------
>>  arch/arm/mach-snapdragon/clock-snapdragon.h        |  48 ----
>>  .../mach-snapdragon/include/mach/sysmap-sdm845.h   |   3 +
>>  drivers/clk/Kconfig                                |   1 +
>>  drivers/clk/Makefile                               |   1 +
>>  drivers/clk/qcom/Kconfig                           |  52 ++++
>>  drivers/clk/qcom/Makefile                          |  10 +
>>  .../clk/qcom}/clock-apq8016.c                      |  41 ++-
>>  .../clk/qcom}/clock-apq8096.c                      |  41 ++-
>>  .../reset-qcom.c => clk/qcom/clock-ipq4019.c}      | 165 ++++-------
>>  drivers/clk/qcom/clock-qcom.c                      | 303 +++++++++++++++++++++
>>  drivers/clk/qcom/clock-qcom.h                      |  96 +++++++
>>  .../clk/qcom}/clock-qcs404.c                       |  97 +++++--
>>  drivers/clk/qcom/clock-sdm845.c                    | 265 ++++++++++++++++++
>>  drivers/reset/Kconfig                              |   7 -
>>  drivers/reset/Makefile                             |   1 -
>>  24 files changed, 938 insertions(+), 605 deletions(-)
>> ---
>> base-commit: 30d01b582f2274eb8c808026c5fb4c33e9f2210d
>>
>> // Caleb (they/them)
>>

-- 
// Caleb (they/them)
