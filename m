Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03931E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 12:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E7180275;
	Fri,  3 Jan 2025 13:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KfintZjT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1199280295; Fri,  3 Jan 2025 13:55:41 +0100 (CET)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74999801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 13:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4b1279ca1d2so3207708137.3
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 04:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735908937; x=1736513737; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3LBY5oRzGJLXzb7M53r5omOhttpKWvnDsMwcv3Ag7H8=;
 b=KfintZjTMq0uICUX2HtFiNDqx466sg5Ny+NMsQ8PlJlCijlWCvKc75tj7Z+XM3HDrG
 T++mugkV6hgSfHCy/1Ohe04Uff6CY4gFeXzUpQzcrR72c2RcIVww4TF8yGR3wG3rNLLX
 cTBhhwsnAD4oI7zn+tlXMsmDzjFUMNpf16qMnfLPrz2oL/YEn8WBVIj63BXyTB1wFTDn
 HefsKN5evea7Z3aXJekoBuT8/1lHSLSjE+wiap0IPQZBRInQNXSdBs+IvcDqS8icfqEG
 ZfKoQBI/1V8Mei4W/hIx5JY2aB8HuyRiXf35pA4wrga5GAL0uthxIwsIA20G0xrA9c8o
 09mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735908937; x=1736513737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3LBY5oRzGJLXzb7M53r5omOhttpKWvnDsMwcv3Ag7H8=;
 b=HNgnqKIkMF65CjG20N5fiy8RwNztDCyIr986CJaDXil3pIWjbCYJ1UNOCZrWSalr07
 H+K18zPcP3Y0ON0vXWwMqp9CxqM0eyVwYB3jQhKzIMTuLFecxFSFkcmOxem3uyugIpMb
 AITWdu5CucjQO1Dtw+dlUxPusEymOfx29tB//oBnC9VU9npFwdP2+aPr3v9MC+42XzgD
 X05gjvD/RHgkZszibvZnwaK9FiWIPBF0RorarH7yl6aBclJaCRq4JvDcBh6aCB2DAWYC
 WT+I/C9MtpDOWKc/rAg79lDV2P9U7FPJ/qCVEih7UYxe/OXPhwFwuuK5Jp8nt9JQ/ksM
 ZgzQ==
X-Gm-Message-State: AOJu0YzBMItxrozdX+UatS58n9A7vCOh3F8eX/rs0UQN53VAuheIPRHE
 FqcbWT41J6pK4ueqDMrbfTIvMLJ+XbEa5xtXMwkf8dZ+D8T9JYqHvO6Hx+3pTzf0hHt7ZOkJYo5
 rQuMtEztiLvgdi9jpH9JxG3rvfd2T7tDD71zU9Q==
X-Gm-Gg: ASbGnctC/2CUbJY4sk+q4aw2T78wHDjAjjJrFYQnKvX3MPMXBtP1DIsY3QIXjxC1NLu
 8cxAPk7yXxs2+1fs951EUHjLVdfwyg8N1t2ctmQ==
X-Google-Smtp-Source: AGHT+IHntLGuRiQ5Hxpe6WhGBhld16NZVjxG93gjTqiL0alPp3oWDn+OlkhsschfPTKW+dKJwNRQNhVy9Pm698c5Syk=
X-Received: by 2002:a05:6102:41a5:b0:4af:fa1b:d8f9 with SMTP id
 ada2fe7eead31-4b2cc35dd44mr40546332137.7.1735908937215; Fri, 03 Jan 2025
 04:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20250103123052.110350-1-naoki@radxa.com>
 <20250103123052.110350-4-naoki@radxa.com>
In-Reply-To: <20250103123052.110350-4-naoki@radxa.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 3 Jan 2025 18:25:26 +0530
Message-ID: <CAFA6WYNnnBySCp0D+M_WzDThCnV=NStxKHOeoMMm5gRtfDEhRQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] arm64: dts: rockchip: Add HDMI0 node to rk3588
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, jonas@kwiboo.se, eugen.hristev@linaro.org, 
 quentin.schulz@cherry.de, michal.simek@amd.com, seb-dev@mail.de, 
 liujianfeng1994@gmail.com, heiko@sntech.de, zhangzj@rock-chips.com, 
 dsimic@manjaro.org, pbrobinson@gmail.com, macromorgan@hotmail.com, 
 cfsworks@gmail.com, sebastian.reichel@collabora.com, cassel@kernel.org, 
 didi.debian@cknow.org, boris.brezillon@collabora.com, jing@jing.rocks, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
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

On Fri, 3 Jan 2025 at 18:02, FUKAUMI Naoki <naoki@radxa.com> wrote:
>
> From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>
> Add support for the HDMI0 output port found on RK3588 SoC.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Link: https://lore.kernel.org/r/20241019-rk3588-hdmi0-dt-v2-1-466cd80e8ff9@collabora.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> (cherry picked from commit d7bb71e69f58c1b3665a9f926bf8d3855111bf8e)

Same here:

$ ./tools/update-subtree.sh pick dts d7bb71e69f58c1b3665a9f926bf8d3855111bf8e
From https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing
 * branch                    master     -> FETCH_HEAD
fatal: bad object d7bb71e69f58c1b3665a9f926bf8d3855111bf8e

-Sumit

> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  .../src/arm64/rockchip/rk3588-base.dtsi       | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> index ee99166ebd46..3064ecf1e22a 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> @@ -1254,6 +1254,47 @@
>                 status = "disabled";
>         };
>
> +       hdmi0: hdmi@fde80000 {
> +               compatible = "rockchip,rk3588-dw-hdmi-qp";
> +               reg = <0x0 0xfde80000 0x0 0x20000>;
> +               clocks = <&cru PCLK_HDMITX0>,
> +                        <&cru CLK_HDMITX0_EARC>,
> +                        <&cru CLK_HDMITX0_REF>,
> +                        <&cru MCLK_I2S5_8CH_TX>,
> +                        <&cru CLK_HDMIHDP0>,
> +                        <&cru HCLK_VO1>;
> +               clock-names = "pclk", "earc", "ref", "aud", "hdp", "hclk_vo1";
> +               interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
> +                            <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
> +                            <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
> +                            <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
> +                            <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>;
> +               interrupt-names = "avp", "cec", "earc", "main", "hpd";
> +               phys = <&hdptxphy_hdmi0>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&hdmim0_tx0_cec &hdmim0_tx0_hpd
> +                            &hdmim0_tx0_scl &hdmim0_tx0_sda>;
> +               power-domains = <&power RK3588_PD_VO1>;
> +               resets = <&cru SRST_HDMITX0_REF>, <&cru SRST_HDMIHDP0>;
> +               reset-names = "ref", "hdp";
> +               rockchip,grf = <&sys_grf>;
> +               rockchip,vo-grf = <&vo1_grf>;
> +               status = "disabled";
> +
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       hdmi0_in: port@0 {
> +                               reg = <0>;
> +                       };
> +
> +                       hdmi0_out: port@1 {
> +                               reg = <1>;
> +                       };
> +               };
> +       };
> +
>         qos_gpu_m0: qos@fdf35000 {
>                 compatible = "rockchip,rk3588-qos", "syscon";
>                 reg = <0x0 0xfdf35000 0x0 0x20>;
> --
> 2.43.0
>
