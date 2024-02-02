Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64C5C47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 05:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C45B87D38;
	Fri,  2 Feb 2024 06:42:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o/YyKuM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 567BE87CEA; Fri,  2 Feb 2024 06:42:28 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02D3787D63
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 06:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7ce603b9051so871059241.2
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 21:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706852544; x=1707457344; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zrv1uHB8+MWS/SjvNnzNXUaXTd2rYYBUPHShc3L8pHo=;
 b=o/YyKuM3XNlg/kWzAAWKMUAFfuUfxknyX3Llt3ZDQWGxjjrqCag51MmbaWqlquerJR
 j93dEU2PP6DrQgelSwyNuus6P+t7toZOc9nV++j6etDSu3oO5p+haRBXxK++rkpoqTPy
 RHc8++IfJxHlRgiie/2/GpScXeXR0+DHBve8O8nJbwtTWch+iCFg4fImmehhP4tuSE4x
 4k3ylJBTNP3ugBfFbawEBhayLCngE4brT1G3oyDCs2r86tYIfSJFnMnyY8QHygG34QJg
 OniuEUx2bHNEn4F5l95h6S6lrWSRv1p5bmxx4CChS6nC8XfQ9IjhndWKfxEPE8BF6Evu
 v37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706852544; x=1707457344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zrv1uHB8+MWS/SjvNnzNXUaXTd2rYYBUPHShc3L8pHo=;
 b=NIjQ4AwdjZ7mmKm7B0vF9duo8FKABbWxbcAz7MnWCs7lr47yYcGO4qiVkrkDL9ln1j
 RnyCJbkG/OCLHTgzeug1iYULu077+Az2y2LhPpNVLvCadjJldqmzMcU1zpH5+SlqPWMj
 vqg83G3FTaupGf2Uw3wpidIxQNbxCnrKMus52e0hTeITIf0G0vIR6CE7p3l1iaNb67V0
 YQ3RPC63AzsVl8NW9a43GMBg9xqi2Cri2RwIJj5DMcSGMEwc+Ov+cHhuzAhxzjyxoEdw
 eVzU9Ep5svNWprJNRgngrbhF/6jq3I+tTx8FwaxQ0zMw8T+YyrB70TwlbNdARPurZuE0
 +yMg==
X-Gm-Message-State: AOJu0Yx33Hgz4Wde9uh6MJNERqoyZnlewJ6eN5WVxzoi0GT5aXMzqIRL
 0dhL82CRhYOnCe1153s1vLI/bCDQNAnSYKTHttMxtnDoZQ0qMJeG1Fem71yv6uWJnrFfE2qNltj
 FAki9xaKimOnkpWpfbNUOJ6UylG9MPBr2W7NleQ==
X-Google-Smtp-Source: AGHT+IFN2oZ8+8aG+LJtc22mIFPsRVuYqTZwTAB0ZWXiynsk75lQlIkGMgbPpZp6y5vMl7ptwxPopWOmk1iU6xQytJA=
X-Received: by 2002:a05:6102:518:b0:46a:faf9:9bd3 with SMTP id
 l24-20020a056102051800b0046afaf99bd3mr1135391vsa.29.1706852544641; Thu, 01
 Feb 2024 21:42:24 -0800 (PST)
MIME-Version: 1.0
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
 <20240130-b4-qcom-common-target-v3-3-e523cbf9e556@linaro.org>
 <CAFA6WYPveDeXdq70-jRV7ZM80g6kZN2=45gFgy92qv49xirfAw@mail.gmail.com>
 <cefe7d3b-876e-4680-b9e2-6b612579b803@linaro.org>
In-Reply-To: <cefe7d3b-876e-4680-b9e2-6b612579b803@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 2 Feb 2024 11:12:13 +0530
Message-ID: <CAFA6WYNLGcLn+9S-m98by6Ym8nxna3yYnFDtH0frfgdnKWjznw@mail.gmail.com>
Subject: Re: [PATCH v3 03/36] mmc: msm_sdhci: use modern clock handling
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
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

On Thu, 1 Feb 2024 at 20:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 01/02/2024 08:19, Sumit Garg wrote:
> > On Tue, 30 Jan 2024 at 19:35, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Use the clk_* helper functions and the correct property name for clocks.
> >
> > This still doesn't handle fixed clocks like in case of QCS404, upstream DT says:
> >
> >                 sdcc1: mmc@7804000 {
> >                         compatible = "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5";
> >                         ...
> >                         clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> >                                  <&gcc GCC_SDCC1_APPS_CLK>,
> >                                  <&xo_board>;
> >                         clock-names = "iface", "core", "xo";
> >                         ...
> >                 };
> >
> > Due to that "xo" fixed clock we get:
> >
> > MMC:   clk_set_rate(clk=00000000ffaf7348, rate=19200000)
> > Unknown clock id 0
> > clk_set_rate(clk=00000000ffaf7598, rate=19200000)
> > Unknown clock id 0
> > clk_set_rate(clk=00000000ffb08868, rate=400000)
> > mmc@7804000: 0
>
> Does MMC work? This doesn't look like a probe failure to me.
>

Yeah it's not a breaking change for MMC but rather an annoying one.
MMC works with following DT hack (as per my comments on the other
patch) and defconfig change as follows:

diff --git a/arch/arm/dts/qcs404.dtsi b/arch/arm/dts/qcs404.dtsi
index 2721f32dfb71..5e6705e82837 100644
--- a/arch/arm/dts/qcs404.dtsi
+++ b/arch/arm/dts/qcs404.dtsi
@@ -730,9 +730,7 @@

                tlmm: pinctrl@1000000 {
                        compatible = "qcom,qcs404-pinctrl";
-                       reg = <0x01000000 0x200000>,
-                             <0x01300000 0x200000>,
-                             <0x07b00000 0x200000>;
+                       reg = <0x01300000 0x200000>;
                        reg-names = "south", "north", "east";
                        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
                        gpio-ranges = <&tlmm 0 0 120>;
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 3c6bdc2071b2..3596bc650b41 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -43,6 +43,8 @@ CONFIG_BUTTON_KEYBOARD=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_MSM=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_QCOM_QCS404=y

> But yes this does look odd, somehow qcs404_clk_set_rate() is being
> called with clk->id == 0. The xo_board clock uses a different driver so
> it can't be that...
>
> Could you try and add some more logging around here? I can't see what
> might be causing this.

I tried to dump the call chain as follows. It starts with clk_get_bulk().

clk_get_bulk()
clk_get_by_index()
clk_get_by_index_nodev()
clk_get_by_index_tail()
clk_set_defaults(clock-controller@1800000)
clk_set_default_rates()
clk_get_by_indexed_prop(dev=00000000ffb05d70, index=0, clk=00000000ffaf7588)
clk_get_by_index_tail()
clk_set_defaults(clock-controller@1800000)
clk_set_default_rates()
clk_get_by_indexed_prop(dev=00000000ffb05e50, index=0, clk=00000000ffaf7328)
clk_get_by_index_tail()
clk_set_defaults(clock-controller@1800000)
clk_set_default_rates()
clk_get_by_indexed_prop(dev=00000000ffb05e50, index=0, clk=00000000ffaf7318)
clk_get_by_index_tail()
clk_set_rate(clk=00000000ffaf7318, rate=19200000)
Unknown clock id 0
clk_set_rate(clk=00000000ffaf7588, rate=19200000)
Unknown clock id 0

-Sumit
