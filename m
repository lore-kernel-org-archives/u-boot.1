Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49B1C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 16:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E70F887CF9;
	Fri,  1 Mar 2024 17:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UhEkAiV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE19E87CF2; Fri,  1 Mar 2024 17:25:43 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CD9D87D06
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 17:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412a9e9c776so20856135e9.0
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 08:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709310339; x=1709915139; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=prlSbpiMtm57a8t7ChOB1UYLtQc2myNCamlUNsF1ILs=;
 b=UhEkAiV2hDCTHtA5PwUGqeLrsbT7H9bEIBX/gE9lfjQmsKEXCFhVpVjD3dJh8Ooa9u
 LMQUbMG/LQzMpg6DpCMd77a2+HdEvSMQfIIUf9WiocC77PJ3prndt5aCc1BE5ekR9oMn
 y7+09e+vL5PNPk/Xm39WWAOrIzEBqBExx78vY55lzPUPB8oBNlEp6l8w+yqAKAygR1zu
 mJSypM6pcaZWdnsttbpH3mePfwYBWBsD8wz3zgqDtGAMLteuheZ7VlF2T1594u1jJvw9
 Oao0TkWHrASW2Jk2ibf0YKvtk6nw4nhpiAcl7qOmRZdCaOeq55npHEjKWTmq/PTy67Oy
 tSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709310339; x=1709915139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=prlSbpiMtm57a8t7ChOB1UYLtQc2myNCamlUNsF1ILs=;
 b=uPyXQWP+ywzAcCXgym7bAdwWq2xt/xr9PuXzaGaHeZkWL4Vk9sVhbYPEnbyeH3Uhq9
 z/hhudUBykGf20w6JfTMKProahMlAV8i9HX2Q8LdmV7nyUI5hgvP8NKfihubPFbsBgj1
 31yRtjZsDJFIEE805WcDeiBCxS8isF0ylOG40XG0SVRjmhipmDgYWbxt3qrIxEgL7vee
 fA/SHo8i7zddR40HAdd8dmyZD1jvWRiawcENw6nTe6ZU94zLW1xEzTx+wCgYSy5Y+glm
 bJ4YKtI2HSjKiCx8a/F7/I7tJa09gHGGWCCmTB0fr//VgrwERgu/FTIXP/+dSnyqT9KB
 xjtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2ExoNCRsD/dzLY3c2X8uiaVsCT+AKtceFQwPDbQa32NMrHfH39bngayuzCsUS4WtxMhEK3kXptVL72ugxeuKr/QSKkA==
X-Gm-Message-State: AOJu0YyedOqjvwjuuBkPgTHf4u93dceQAP7+0iylxADDq7LGhLRDwUOu
 ZsqTBUkzbs13ELyRWwgcFMcG9xxotH1x5mHikaY+2PTPNtAO23dY+Z5CszrY2/Q=
X-Google-Smtp-Source: AGHT+IEzTR4Hd07DTn9rUoaVOfs6bLwOHKH8ii2ZnUSNRfph5c/C1ZJYMjBP1db6OqNPg3Yhr/iWWg==
X-Received: by 2002:a05:600c:3544:b0:412:9434:fa38 with SMTP id
 i4-20020a05600c354400b004129434fa38mr2364658wmq.7.1709310338987; 
 Fri, 01 Mar 2024 08:25:38 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c458900b00412b3bf811bsm5877494wmo.8.2024.03.01.08.25.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 08:25:38 -0800 (PST)
Message-ID: <dc97490e-4029-41e2-bbbd-b1351f5cf9eb@linaro.org>
Date: Fri, 1 Mar 2024 16:25:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Add support for Qualcomm SA8155-ADP board
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Elmar Psilog <epsi@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>, Lukasz Majewski
 <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
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



On 29/02/2024 14:21, Volodymyr Babchuk wrote:
> 
> This patch series adds support for Qualcomm SA8155-ADP development
> board. Main motivation for this series is to allow running
> virtualization software on this board and U-Boot is a good way to
> break Qualcomm's boot chain at EL2 with more convenient ways for
> uploading and running the code. With this patches applied it is
> possible to upload and run Xen on this board. KVM probably should work
> too.

This is really cool! I've experimented with this on SDM845 and SM8250
but never really did anything with it... I'd love to take a look at your
Xen branch?
> 
> I added myself as a maintainer for this board, but my abilities to
> maintain it are quite limited as I have no access to Qualcomm
> documentation. I used mostly Linux drivers as the source for
> device-specific information, like register addresses and offsets.
> If anyone wants to maintain this, I will gladly agree.
> 
> 
> Volodymyr Babchuk (8):
>   clk: qcom: clear div mask before assigning new divider
>   dts: qcom: import device trees and bindings for SA8155P-ADP
>   net: dw_eth_qos: add support for Qualcomm SM8150 SoC
>   clk: qcom: add support for power domains uclass
>   clk: qcom: add driver for SM8150 SoC
>   pinctr: qcom: pass pin number to get_function_mux callback
>   pinctrl: qcom: add driver for SM8150 SoC
>   board: add support for Qualcomm SA8155P-ADP board
> 
>  arch/arm/dts/pmm8155au_1.dtsi                 |  135 +
>  arch/arm/dts/pmm8155au_2.dtsi                 |  108 +
>  arch/arm/dts/sa8155p-adp-u-boot.dtsi          |   30 +
>  arch/arm/dts/sa8155p-adp.dts                  |  606 ++
>  arch/arm/dts/sa8155p.dtsi                     |   40 +
>  arch/arm/dts/sm8150.dtsi                      | 5293 +++++++++++++++++
>  arch/arm/mach-snapdragon/Kconfig              |   14 +
>  arch/arm/mach-snapdragon/Makefile             |    2 +
>  arch/arm/mach-snapdragon/init_sa8155p.c       |   30 +
>  arch/arm/mach-snapdragon/sysmap-sm8150.c      |   31 +
>  board/qualcomm/sa8155p-adp/Kconfig            |   12 +
>  board/qualcomm/sa8155p-adp/MAINTAINERS        |    6 +
>  configs/sa8155p_adp_defconfig                 |   33 +
>  doc/board/qualcomm/index.rst                  |    1 +
>  doc/board/qualcomm/sa8155p-adp.rst            |   94 +
>  drivers/clk/qcom/Kconfig                      |    8 +
>  drivers/clk/qcom/Makefile                     |    1 +
>  drivers/clk/qcom/clock-qcom.c                 |   96 +-
>  drivers/clk/qcom/clock-qcom.h                 |    7 +
>  drivers/clk/qcom/clock-sm8150.c               |  234 +
>  drivers/net/dwc_eth_qos.c                     |    4 +
>  drivers/net/dwc_eth_qos.h                     |    2 +
>  drivers/net/dwc_eth_qos_qcom.c                |   47 +-
>  drivers/pinctrl/qcom/Kconfig                  |    7 +
>  drivers/pinctrl/qcom/Makefile                 |    1 +
>  drivers/pinctrl/qcom/pinctrl-apq8016.c        |    3 +-
>  drivers/pinctrl/qcom/pinctrl-apq8096.c        |    3 +-
>  drivers/pinctrl/qcom/pinctrl-ipq4019.c        |    3 +-
>  drivers/pinctrl/qcom/pinctrl-qcom.c           |    4 +-
>  drivers/pinctrl/qcom/pinctrl-qcom.h           |    3 +-
>  drivers/pinctrl/qcom/pinctrl-qcs404.c         |    3 +-
>  drivers/pinctrl/qcom/pinctrl-sdm845.c         |    3 +-
>  drivers/pinctrl/qcom/pinctrl-sm8150.c         |  589 ++
>  include/configs/sa8155p_adp.h                 |   25 +
>  .../dt-bindings/clock/qcom,dispcc-sm8150.h    |   76 +
>  include/dt-bindings/clock/qcom,gcc-sm8150.h   |  252 +
>  include/dt-bindings/clock/qcom,gpucc-sm8150.h |   33 +
>  include/dt-bindings/clock/qcom,rpmh.h         |   37 +
>  include/dt-bindings/dma/qcom-gpi.h            |   11 +
>  include/dt-bindings/firmware/qcom,scm.h       |   39 +
>  include/dt-bindings/iio/qcom,spmi-vadc.h      |  303 +
>  .../dt-bindings/interconnect/qcom,osm-l3.h    |   15 +
>  .../dt-bindings/interconnect/qcom,sm8150.h    |  159 +
>  include/dt-bindings/phy/phy-qcom-qmp.h        |   20 +
>  include/dt-bindings/power/qcom-rpmpd.h        |  412 ++
>  .../regulator/qcom,rpmh-regulator.h           |   36 +
>  include/dt-bindings/soc/qcom,rpmh-rsc.h       |   14 +
>  47 files changed, 8866 insertions(+), 19 deletions(-)
>  create mode 100644 arch/arm/dts/pmm8155au_1.dtsi
>  create mode 100644 arch/arm/dts/pmm8155au_2.dtsi
>  create mode 100644 arch/arm/dts/sa8155p-adp-u-boot.dtsi
>  create mode 100644 arch/arm/dts/sa8155p-adp.dts
>  create mode 100644 arch/arm/dts/sa8155p.dtsi
>  create mode 100644 arch/arm/dts/sm8150.dtsi
>  create mode 100644 arch/arm/mach-snapdragon/init_sa8155p.c
>  create mode 100644 arch/arm/mach-snapdragon/sysmap-sm8150.c
>  create mode 100644 board/qualcomm/sa8155p-adp/Kconfig
>  create mode 100644 board/qualcomm/sa8155p-adp/MAINTAINERS
>  create mode 100644 configs/sa8155p_adp_defconfig
>  create mode 100644 doc/board/qualcomm/sa8155p-adp.rst
>  create mode 100644 drivers/clk/qcom/clock-sm8150.c
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8150.c
>  create mode 100644 include/configs/sa8155p_adp.h
>  create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm8150.h
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8150.h
>  create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8150.h
>  create mode 100644 include/dt-bindings/clock/qcom,rpmh.h
>  create mode 100644 include/dt-bindings/dma/qcom-gpi.h
>  create mode 100644 include/dt-bindings/firmware/qcom,scm.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-vadc.h
>  create mode 100644 include/dt-bindings/interconnect/qcom,osm-l3.h
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8150.h
>  create mode 100644 include/dt-bindings/phy/phy-qcom-qmp.h
>  create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
>  create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h
>  create mode 100644 include/dt-bindings/soc/qcom,rpmh-rsc.h
> 

-- 
// Caleb (they/them)
