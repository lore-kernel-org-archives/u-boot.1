Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1A0C6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 04:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE32A87F87;
	Wed, 20 Mar 2024 05:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kh7OI6EB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB7C48808F; Wed, 20 Mar 2024 05:56:00 +0100 (CET)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 317D087E13
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4760fe9c282so2097514137.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 21:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710910557; x=1711515357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=smk3up9AxLBklHIupCTbu8uJT2sUCHKng4ykA2aQUkg=;
 b=kh7OI6EBoHVNfKU3cBzzUgclmokVYKesUSZE4Mm6gOtFlqu8PDLydQ1BuDZa16Kw+v
 f70RMu7APSLjWefMcBaASe+U1FwLw71j06Bp8Epyiz/cjl4KaSf8qjLo5yPjYA+x8EKN
 n8antgSxdPVIjKU8pQQzhVHtwcIuDdCxznAKUoFOcxFZxKqoJ13uXljoEJL4ltf9++wT
 Ps/JZJDKnTGRXBpC7hN8HeGzeH+9sFddbtdegN22cN643JvkNYDRstjO6k5T2mE7CHI1
 gQucTUIGUIcUXrdAPo7a+lQAz1JCaNWQEuBv7Z8ZfBU/cxVM2pLDlfBlWT2irGA2bHbh
 LMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710910557; x=1711515357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=smk3up9AxLBklHIupCTbu8uJT2sUCHKng4ykA2aQUkg=;
 b=oCKyXn1G/DEv96MSjuqw52/H12U2xXtEOOe5wLTRRac+MiFJ3BA/7SEpF+tSyloLAo
 oH/yK6cw8wZGf1SODgXMZJCvg59K3ezahe+8c7USdkHNtdoysafDy7rUN7GON8IudGGG
 z07vwJZZSCZ9JHM8quN6eFVqeg3tjkIWX7LSDgoOb6F87q/UHfuKBSqGww46YNOai7I3
 l5dOi3kWPXGb2MuKLgmcFldWYhHGGLMKsyI3Xq+X65xh6XKrM5irp52KAYIoTncjGoTH
 WadiQJMYmDP/00c5fGxuefhbQVTnJE81vuSfn9aoAdGOW5kiWGU6L/TkKWhZLemvIR4/
 JRrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXewIJAf8lq8Eh8DpSK8uGOIbhLzDqnW02ZjdzbTYIldKsWF60BaS+diy5pMNPPOBjHnSFj8t+5AJ7avGjHw74dzPI1Mw==
X-Gm-Message-State: AOJu0YymtEnUq91axmF9tjEEyOaSaKKSnSqPDLk0qUFB3vFRGTTfZY61
 1U5eDIkNW2UZUcAFLJBryCArXuX1z7RMVqXf1aeq+i2zEjl26iOinVQMf7KOmN46jA8wKWIziDj
 /lTH8hN3dWuJDjUbD940Xo3OgruMCRMc2+SVCfQ==
X-Google-Smtp-Source: AGHT+IFo+MHDbN1CJ9nJUkPFmJv2aAUj7RK4xE+cQ+3go6N0AP+fyV453FUGvKPSfgyFxZ20PRRrvCFDT56duZrQcoQ=
X-Received: by 2002:a67:f5d9:0:b0:473:3431:4f78 with SMTP id
 t25-20020a67f5d9000000b0047334314f78mr14582697vso.10.1710910556719; Tue, 19
 Mar 2024 21:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
In-Reply-To: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Mar 2024 10:25:45 +0530
Message-ID: <CAFA6WYNax2GF3i3o4OzLXe=LqOB5HRS18LbNm-t_FOgwzORftg@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm: meson: Switch to using upstream DT for GXL, GXM, 
 AXG, G12A, G12B & SM1 SoCs
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
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

Hi Neil,

On Tue, 19 Mar 2024 at 20:13, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
> DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
> drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
> kept in arch/arm/dts directory for these boards.
>
> Keep A1 DTs locally since the architecture is still young.
>
> CI built & tested at:
> https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/pipelines/1219273552
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (4):
>       dts: meson: Switch GXL, GXM & AXG to using upstream DT
>       dts: meson: Drop redundant GXL, GXM & AXG devicetree files
>       dts: meson-g12a: Switch to using upstream DT
>       dts: meson: Drop redundant G12A, G12B & SM1 devicetree files
>
>  arch/arm/dts/Makefile                              |   36 +-
>  arch/arm/dts/meson-axg-jethome-jethub-j100.dts     |  361 ---
>  arch/arm/dts/meson-axg-s400.dts                    |  602 -----
>  arch/arm/dts/meson-axg.dtsi                        | 1957 ---------------
>  arch/arm/dts/meson-g12-common.dtsi                 | 2493 --------------------
>  arch/arm/dts/meson-g12.dtsi                        |  385 ---
>  arch/arm/dts/meson-g12a-radxa-zero.dts             |  405 ----
>  arch/arm/dts/meson-g12a-sei510.dts                 |  566 -----
>  arch/arm/dts/meson-g12a-u200.dts                   |  308 ---
>  arch/arm/dts/meson-g12a.dtsi                       |  140 --
>  arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts     |   33 -
>  arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   41 -
>  arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 --
>  arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     |  165 --
>  arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          |  388 ---
>  arch/arm/dts/meson-g12b-bananapi.dtsi              |  521 ----
>  arch/arm/dts/meson-g12b-gsking-x.dts               |  133 --
>  arch/arm/dts/meson-g12b-gtking-pro.dts             |  142 --
>  arch/arm/dts/meson-g12b-gtking.dts                 |  163 --
>  arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  107 -
>  arch/arm/dts/meson-g12b-odroid-go-ultra.dts        |  722 ------
>  arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |   31 -
>  arch/arm/dts/meson-g12b-odroid-n2.dts              |   15 -
>  arch/arm/dts/meson-g12b-odroid-n2.dtsi             |  303 ---
>  arch/arm/dts/meson-g12b-odroid-n2l.dts             |  125 -
>  arch/arm/dts/meson-g12b-odroid.dtsi                |  445 ----
>  arch/arm/dts/meson-g12b-radxa-zero2.dts            |  489 ----
>  arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts     |   14 -
>  arch/arm/dts/meson-g12b-s922x.dtsi                 |  139 --
>  arch/arm/dts/meson-g12b-w400.dtsi                  |  425 ----
>  arch/arm/dts/meson-g12b.dtsi                       |  146 --
>  arch/arm/dts/meson-gx-libretech-pc.dtsi            |  447 ----
>  arch/arm/dts/meson-gx-mali450.dtsi                 |   61 -
>  arch/arm/dts/meson-gx-p23x-q20x.dtsi               |  324 ---
>  arch/arm/dts/meson-gx.dtsi                         |  675 ------
>  arch/arm/dts/meson-gxl-mali.dtsi                   |   17 -
>  arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  319 ---
>  arch/arm/dts/meson-gxl-s805x.dtsi                  |   23 -
>  arch/arm/dts/meson-gxl-s905d-libretech-pc.dts      |   16 -
>  arch/arm/dts/meson-gxl-s905d.dtsi                  |   12 -
>  .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  247 --
>  arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  237 --
>  arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |  313 ---
>  arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  356 ---
>  arch/arm/dts/meson-gxl-s905x-p212.dts              |  134 --
>  arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  213 --
>  arch/arm/dts/meson-gxl-s905x.dtsi                  |   18 -
>  arch/arm/dts/meson-gxl.dtsi                        |  940 --------
>  arch/arm/dts/meson-gxm-gt1-ultimate.dts            |   91 -
>  arch/arm/dts/meson-gxm-khadas-vim2.dts             |  424 ----
>  arch/arm/dts/meson-gxm-s912-libretech-pc.dts       |   62 -
>  arch/arm/dts/meson-gxm-wetek-core2.dts             |   85 -
>  arch/arm/dts/meson-gxm.dtsi                        |  216 --
>  arch/arm/dts/meson-khadas-vim3.dtsi                |  534 -----
>  arch/arm/dts/meson-sm1-bananapi-m2-pro.dts         |   97 -
>  arch/arm/dts/meson-sm1-bananapi-m5.dts             |  221 --
>  arch/arm/dts/meson-sm1-bananapi.dtsi               |  435 ----
>  arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  113 -
>  arch/arm/dts/meson-sm1-odroid-c4.dts               |   48 -
>  arch/arm/dts/meson-sm1-odroid-hc4.dts              |  140 --
>  arch/arm/dts/meson-sm1-odroid.dtsi                 |  449 ----
>  arch/arm/dts/meson-sm1-sei610.dts                  |  616 -----
>  arch/arm/dts/meson-sm1.dtsi                        |  550 -----
>  arch/arm/mach-meson/Kconfig                        |    4 +
>  configs/bananapi-cm4-cm4io_defconfig               |    2 +-
>  configs/bananapi-m2-pro_defconfig                  |    2 +-
>  configs/bananapi-m2s_defconfig                     |    2 +-
>  configs/bananapi-m5_defconfig                      |    2 +-
>  configs/beelink-gsking-x_defconfig                 |    2 +-
>  configs/beelink-gt1-ultimate_defconfig             |    2 +-
>  configs/beelink-gtking_defconfig                   |    2 +-
>  configs/beelink-gtkingpro_defconfig                |    2 +-
>  configs/jethub_j100_defconfig                      |    2 +-
>  configs/jethub_j80_defconfig                       |    2 +-
>  configs/khadas-vim2_defconfig                      |    2 +-
>  configs/khadas-vim3_android_ab_defconfig           |    2 +-
>  configs/khadas-vim3_android_defconfig              |    2 +-
>  configs/khadas-vim3_defconfig                      |    2 +-
>  configs/khadas-vim3l_android_ab_defconfig          |    2 +-
>  configs/khadas-vim3l_android_defconfig             |    2 +-
>  configs/khadas-vim3l_defconfig                     |    2 +-
>  configs/khadas-vim_defconfig                       |    2 +-
>  configs/libretech-ac_defconfig                     |    2 +-
>  configs/libretech-cc_defconfig                     |    2 +-
>  configs/libretech-cc_v2_defconfig                  |    2 +-
>  configs/libretech-s905d-pc_defconfig               |    2 +-
>  configs/libretech-s912-pc_defconfig                |    2 +-
>  configs/odroid-c4_defconfig                        |    2 +-
>  configs/odroid-go-ultra_defconfig                  |    2 +-
>  configs/odroid-hc4_defconfig                       |    2 +-
>  configs/odroid-n2_defconfig                        |    2 +-
>  configs/odroid-n2l_defconfig                       |    2 +-
>  configs/p212_defconfig                             |    2 +-
>  configs/radxa-zero2_defconfig                      |    2 +-
>  configs/radxa-zero_defconfig                       |    2 +-
>  configs/s400_defconfig                             |    2 +-
>  configs/sei510_defconfig                           |    2 +-
>  configs/sei610_defconfig                           |    2 +-
>  configs/u200_defconfig                             |    2 +-
>  configs/wetek-core2_defconfig                      |    2 +-
>  include/dt-bindings/gpio/meson-axg-gpio.h          |  116 -
>  include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 -
>  include/dt-bindings/gpio/meson-gxbb-gpio.h         |  148 --
>  include/dt-bindings/gpio/meson-gxl-gpio.h          |  125 -
>  include/dt-bindings/power/meson-axg-power.h        |   14 -
>  include/dt-bindings/power/meson-g12a-power.h       |   13 -
>  include/dt-bindings/power/meson-gxbb-power.h       |   13 -
>  include/dt-bindings/power/meson-sm1-power.h        |   18 -
>  .../reset/amlogic,meson-axg-audio-arb.h            |   19 -
>  .../dt-bindings/reset/amlogic,meson-axg-reset.h    |  123 -
>  .../reset/amlogic,meson-g12a-audio-reset.h         |   53 -
>  .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  137 --
>  .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |  161 --
>  include/dt-bindings/sound/meson-aiu.h              |   18 -
>  include/dt-bindings/sound/meson-g12a-toacodec.h    |   10 -
>  include/dt-bindings/sound/meson-g12a-tohdmitx.h    |   13 -
>  116 files changed, 42 insertions(+), 21511 deletions(-)

Glad to see these diff stats, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> ---
> base-commit: b145877c22b391a4872c875145a8f86f6ffebaba
> change-id: 20240319-u-boot-of-upstream-46454fded5ea
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
>
