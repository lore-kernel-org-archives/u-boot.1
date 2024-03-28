Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B94DC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 08:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 758C7880F5;
	Thu, 28 Mar 2024 09:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sqUMIeHl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35922880FB; Thu, 28 Mar 2024 09:27:15 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E658880D6
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 09:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d4a8bddc21so8138861fa.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711614432; x=1712219232;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JweTZVvSpPUteSNqpDRHoXLnsplJ+dsir54YbpRS9TI=;
 b=sqUMIeHlHhCydqlsTTAW2GhoCeXTn259tN72xGV+zEv7RufnFNrjOhQtOges7mrqst
 09dMi6FY4OkuoJ7NYc0u1IS7c9OFvl04mvPB6N558ajcOynrg6kdc65V9o/HFeGALxN0
 IYL2IiEjOV0ti/oSvGAAz3u/x7morIddKTvyPmXHJi5Wci2cw5Eqg7XEPVkWzry6nm93
 vaTkJ1GJo8mJkF/UjO3SFTQU16UVdxa9uoNKor4xZ8Bt0dMRWTBun3t8hLvU5r2hlv74
 Id4F2ysLgi7Z3/LjKl/DPRaF5sfFTVI8+hkc3ObEMwwyIVriID+FO71NkfMwGVriv6EZ
 kFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711614432; x=1712219232;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JweTZVvSpPUteSNqpDRHoXLnsplJ+dsir54YbpRS9TI=;
 b=tvzfXSs3l4h0Cx7o5tDYDhVatSvMnU9nsCDBPjG9xTo2hWVlZ+2WB6Se5OnYDEYjzW
 fP48dnx5kiRDt3WRu+hDurKw+mJckrEEjHHTP893iH3A0SS+an+WgCa4flgSbnpTLvxL
 g+FryGAnbXuWe3hvEoOviqde3VOG+ovkJhurej+c9pB0CF7ECThCQr9ZrhJT+7eGyo+7
 SxP8A1pvDAmHfLCsHJR7YtQCMsTQ7QKNABZKbx27NxtY1Oox6JiS8knH7ke2tXxXS2Wg
 TTuH7TbGJ/r+TAdBWSudWNZVkMrwYQouaT1fElat8PR5m8XzS5XS21uTFONzPf5DFhDU
 5yOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlhvTj9d4PesDz+5bQ4WhJuMhC6omcQwHDyT8BciYf4jQinNxV174XsFHjbiFMebBx32TNwAQT4+krvma+xaWcO1gKbw==
X-Gm-Message-State: AOJu0Yzyqk0HoXGbQ64KWM4yMuGHxlsUPPmlDHCLPzJg9eU6lJMA9Eu9
 GWvo3X+KfXLy7WpMDCKkrY0380ezSfT813mD8qIZvJkoZy22sKcHHubHCzll4ag=
X-Google-Smtp-Source: AGHT+IFqmu0qjEVGYkdJ0z6cFcKdJZXwjG5FKh3rDyCkR3Cs7r92Ew75a9jTzbx+FIDHCM49BUKf8w==
X-Received: by 2002:a05:651c:221f:b0:2d6:bbab:8301 with SMTP id
 y31-20020a05651c221f00b002d6bbab8301mr2051420ljq.0.1711614431610; 
 Thu, 28 Mar 2024 01:27:11 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31]) by smtp.gmail.com with ESMTPSA id
 o12-20020a5d4a8c000000b0033e7b05edf3sm1099917wrq.44.2024.03.28.01.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 01:27:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: neil.armstrong@linaro.org
Cc: Christian Hewitt <christianshewitt@gmail.com>, Vyacheslav Bocharov
 <adeep@lexina.in>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, Sumit Garg
 <sumit.garg@linaro.org>
Subject: Re: [PATCH 0/4] arm: meson: Switch to using upstream DT for GXL,
 GXM, AXG, G12A, G12B & SM1 SoCs
In-Reply-To: <625e06c4-0410-4067-8ead-5142373bc1ee@linaro.org>
References: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
 <625e06c4-0410-4067-8ead-5142373bc1ee@linaro.org>
Date: Thu, 28 Mar 2024 09:27:05 +0100
Message-ID: <8734sag3s6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi,

On jeu., mars 28, 2024 at 09:21, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi Mattijs,
>
> On 19/03/2024 15:42, Neil Armstrong wrote:
>> Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
>> DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
>> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
>> drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
>> kept in arch/arm/dts directory for these boards.
>> 
>> Keep A1 DTs locally since the architecture is still young.
>> 
>> CI built & tested at:
>> https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/pipelines/1219273552
>
> Can you check it doesn't break android boot ?

Sorry for the delay. I will test this early next week (Tuesday)

Thank you !

>
> Neil
>
>> 
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Neil Armstrong (4):
>>        dts: meson: Switch GXL, GXM & AXG to using upstream DT
>>        dts: meson: Drop redundant GXL, GXM & AXG devicetree files
>>        dts: meson-g12a: Switch to using upstream DT
>>        dts: meson: Drop redundant G12A, G12B & SM1 devicetree files
>> 
>>   arch/arm/dts/Makefile                              |   36 +-
>>   arch/arm/dts/meson-axg-jethome-jethub-j100.dts     |  361 ---
>>   arch/arm/dts/meson-axg-s400.dts                    |  602 -----
>>   arch/arm/dts/meson-axg.dtsi                        | 1957 ---------------
>>   arch/arm/dts/meson-g12-common.dtsi                 | 2493 --------------------
>>   arch/arm/dts/meson-g12.dtsi                        |  385 ---
>>   arch/arm/dts/meson-g12a-radxa-zero.dts             |  405 ----
>>   arch/arm/dts/meson-g12a-sei510.dts                 |  566 -----
>>   arch/arm/dts/meson-g12a-u200.dts                   |  308 ---
>>   arch/arm/dts/meson-g12a.dtsi                       |  140 --
>>   arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts     |   33 -
>>   arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   41 -
>>   arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 --
>>   arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     |  165 --
>>   arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          |  388 ---
>>   arch/arm/dts/meson-g12b-bananapi.dtsi              |  521 ----
>>   arch/arm/dts/meson-g12b-gsking-x.dts               |  133 --
>>   arch/arm/dts/meson-g12b-gtking-pro.dts             |  142 --
>>   arch/arm/dts/meson-g12b-gtking.dts                 |  163 --
>>   arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  107 -
>>   arch/arm/dts/meson-g12b-odroid-go-ultra.dts        |  722 ------
>>   arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |   31 -
>>   arch/arm/dts/meson-g12b-odroid-n2.dts              |   15 -
>>   arch/arm/dts/meson-g12b-odroid-n2.dtsi             |  303 ---
>>   arch/arm/dts/meson-g12b-odroid-n2l.dts             |  125 -
>>   arch/arm/dts/meson-g12b-odroid.dtsi                |  445 ----
>>   arch/arm/dts/meson-g12b-radxa-zero2.dts            |  489 ----
>>   arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts     |   14 -
>>   arch/arm/dts/meson-g12b-s922x.dtsi                 |  139 --
>>   arch/arm/dts/meson-g12b-w400.dtsi                  |  425 ----
>>   arch/arm/dts/meson-g12b.dtsi                       |  146 --
>>   arch/arm/dts/meson-gx-libretech-pc.dtsi            |  447 ----
>>   arch/arm/dts/meson-gx-mali450.dtsi                 |   61 -
>>   arch/arm/dts/meson-gx-p23x-q20x.dtsi               |  324 ---
>>   arch/arm/dts/meson-gx.dtsi                         |  675 ------
>>   arch/arm/dts/meson-gxl-mali.dtsi                   |   17 -
>>   arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  319 ---
>>   arch/arm/dts/meson-gxl-s805x.dtsi                  |   23 -
>>   arch/arm/dts/meson-gxl-s905d-libretech-pc.dts      |   16 -
>>   arch/arm/dts/meson-gxl-s905d.dtsi                  |   12 -
>>   .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  247 --
>>   arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  237 --
>>   arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |  313 ---
>>   arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  356 ---
>>   arch/arm/dts/meson-gxl-s905x-p212.dts              |  134 --
>>   arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  213 --
>>   arch/arm/dts/meson-gxl-s905x.dtsi                  |   18 -
>>   arch/arm/dts/meson-gxl.dtsi                        |  940 --------
>>   arch/arm/dts/meson-gxm-gt1-ultimate.dts            |   91 -
>>   arch/arm/dts/meson-gxm-khadas-vim2.dts             |  424 ----
>>   arch/arm/dts/meson-gxm-s912-libretech-pc.dts       |   62 -
>>   arch/arm/dts/meson-gxm-wetek-core2.dts             |   85 -
>>   arch/arm/dts/meson-gxm.dtsi                        |  216 --
>>   arch/arm/dts/meson-khadas-vim3.dtsi                |  534 -----
>>   arch/arm/dts/meson-sm1-bananapi-m2-pro.dts         |   97 -
>>   arch/arm/dts/meson-sm1-bananapi-m5.dts             |  221 --
>>   arch/arm/dts/meson-sm1-bananapi.dtsi               |  435 ----
>>   arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  113 -
>>   arch/arm/dts/meson-sm1-odroid-c4.dts               |   48 -
>>   arch/arm/dts/meson-sm1-odroid-hc4.dts              |  140 --
>>   arch/arm/dts/meson-sm1-odroid.dtsi                 |  449 ----
>>   arch/arm/dts/meson-sm1-sei610.dts                  |  616 -----
>>   arch/arm/dts/meson-sm1.dtsi                        |  550 -----
>>   arch/arm/mach-meson/Kconfig                        |    4 +
>>   configs/bananapi-cm4-cm4io_defconfig               |    2 +-
>>   configs/bananapi-m2-pro_defconfig                  |    2 +-
>>   configs/bananapi-m2s_defconfig                     |    2 +-
>>   configs/bananapi-m5_defconfig                      |    2 +-
>>   configs/beelink-gsking-x_defconfig                 |    2 +-
>>   configs/beelink-gt1-ultimate_defconfig             |    2 +-
>>   configs/beelink-gtking_defconfig                   |    2 +-
>>   configs/beelink-gtkingpro_defconfig                |    2 +-
>>   configs/jethub_j100_defconfig                      |    2 +-
>>   configs/jethub_j80_defconfig                       |    2 +-
>>   configs/khadas-vim2_defconfig                      |    2 +-
>>   configs/khadas-vim3_android_ab_defconfig           |    2 +-
>>   configs/khadas-vim3_android_defconfig              |    2 +-
>>   configs/khadas-vim3_defconfig                      |    2 +-
>>   configs/khadas-vim3l_android_ab_defconfig          |    2 +-
>>   configs/khadas-vim3l_android_defconfig             |    2 +-
>>   configs/khadas-vim3l_defconfig                     |    2 +-
>>   configs/khadas-vim_defconfig                       |    2 +-
>>   configs/libretech-ac_defconfig                     |    2 +-
>>   configs/libretech-cc_defconfig                     |    2 +-
>>   configs/libretech-cc_v2_defconfig                  |    2 +-
>>   configs/libretech-s905d-pc_defconfig               |    2 +-
>>   configs/libretech-s912-pc_defconfig                |    2 +-
>>   configs/odroid-c4_defconfig                        |    2 +-
>>   configs/odroid-go-ultra_defconfig                  |    2 +-
>>   configs/odroid-hc4_defconfig                       |    2 +-
>>   configs/odroid-n2_defconfig                        |    2 +-
>>   configs/odroid-n2l_defconfig                       |    2 +-
>>   configs/p212_defconfig                             |    2 +-
>>   configs/radxa-zero2_defconfig                      |    2 +-
>>   configs/radxa-zero_defconfig                       |    2 +-
>>   configs/s400_defconfig                             |    2 +-
>>   configs/sei510_defconfig                           |    2 +-
>>   configs/sei610_defconfig                           |    2 +-
>>   configs/u200_defconfig                             |    2 +-
>>   configs/wetek-core2_defconfig                      |    2 +-
>>   include/dt-bindings/gpio/meson-axg-gpio.h          |  116 -
>>   include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 -
>>   include/dt-bindings/gpio/meson-gxbb-gpio.h         |  148 --
>>   include/dt-bindings/gpio/meson-gxl-gpio.h          |  125 -
>>   include/dt-bindings/power/meson-axg-power.h        |   14 -
>>   include/dt-bindings/power/meson-g12a-power.h       |   13 -
>>   include/dt-bindings/power/meson-gxbb-power.h       |   13 -
>>   include/dt-bindings/power/meson-sm1-power.h        |   18 -
>>   .../reset/amlogic,meson-axg-audio-arb.h            |   19 -
>>   .../dt-bindings/reset/amlogic,meson-axg-reset.h    |  123 -
>>   .../reset/amlogic,meson-g12a-audio-reset.h         |   53 -
>>   .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  137 --
>>   .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |  161 --
>>   include/dt-bindings/sound/meson-aiu.h              |   18 -
>>   include/dt-bindings/sound/meson-g12a-toacodec.h    |   10 -
>>   include/dt-bindings/sound/meson-g12a-tohdmitx.h    |   13 -
>>   116 files changed, 42 insertions(+), 21511 deletions(-)
>> ---
>> base-commit: b145877c22b391a4872c875145a8f86f6ffebaba
>> change-id: 20240319-u-boot-of-upstream-46454fded5ea
>> 
>> Best regards,
