Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6720DE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 13:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC70B80275;
	Fri,  3 Jan 2025 14:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eAovOoA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CFB580295; Fri,  3 Jan 2025 14:01:25 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B2CD801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 14:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so213144645ad.0
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 05:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735909281; x=1736514081; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hB+d4zHTauKRBbBnHPYDznyZkxvPC2LS8/U0oTXbQfA=;
 b=eAovOoA2bkE3ItkehIIQKTzX0v6VTjv6WykFU8wJoP68SJpDZ7TdZjtZO4wRzL6kYw
 AJoEXu9kmM6gih/PibqtWITsx7427OtdJYNopVfjVP/Q0oXGg6zarm0/07oDYAsrrOV8
 2MES1dnKI0Ks6NcEFTQOFKuQ4ea7NNocYRZwBTxm2LRGyUcMIqDhFpyZrpl4argBEncP
 DMU8M3C3macUDEIpaAgvbhv/jA8eN+OP4vdWSK37mgpf15+C0NHlFkVHqtJOIqjwSsrl
 wSRAQZOQ+arfvEjhPUfkW9DdGbSruUhqHXC1qop2kT8eTS8yxIvAVT9Enu6Ra2GMOCvH
 1v3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735909281; x=1736514081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hB+d4zHTauKRBbBnHPYDznyZkxvPC2LS8/U0oTXbQfA=;
 b=RQGsXzjlVCvFiPdk+eVkWfxgj3MBlq22PfZ7/279n24AvYmXrsPcV7WXc5Q8P/pm9X
 v0yLoILDtcsqescTpE8mTEKqXjAD8fEHfW3qgEcvYPqW3p62Ahw8dRW8b0YDA412HNeZ
 bWvnhVSEe8rtl2hJQBdOc/jRFbB5gGvDb0uGqfip3OTMBbj7pjLjeseMx+3fyEk1z4/j
 4VWaQfA1zJ4LOWzbLza83hhZ4TZOthe2E635z+TEn2lMVquEBkqSLSqT9O8G++zFSxWe
 dawlktZMQmt1J5aXVzJHavoCcArJB7hVWDkmUbRn5JhL/AtBqdtZCKnI/wOuklkCO9vL
 w1nw==
X-Gm-Message-State: AOJu0YyfWlwUTkk5a/t3rjGRpxrQhqYee/4OdfBvLoZdRtH/Y7BARn8X
 5v4vydxDSNHvequ2msnfcCLCUv+eK7nG5UngowFUE59+vgR7DG2q7WMbzTS16CSxLQdPT9Tg/9j
 QaQ/n2j4rO1rd2qDghusib8Rzz5C3ET5LVAFgbyfom282w2Ms
X-Gm-Gg: ASbGncuk7rr2CF2uMolQ19y7plf7NT7q02Os7PG8X5yJTOnOT/maTcQFzfw97NNCp2q
 VbEbNpxYnjulxBbcA93NZeWZOSndsn0t8cnlJrw==
X-Google-Smtp-Source: AGHT+IE+DKjxfykmhSBq+O3yv9M+/wK9Z3w8PglVyIukv6cWtyIioo+1ycI/g6DY8ddrtvPCndkMwjbFBCfKeQ3AFJw=
X-Received: by 2002:a05:6102:3a0b:b0:4b1:2894:1048 with SMTP id
 ada2fe7eead31-4b2cc351e2bmr39526532137.10.1735909269462; Fri, 03 Jan 2025
 05:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20250103123052.110350-1-naoki@radxa.com>
 <20250103123052.110350-2-naoki@radxa.com>
 <CAFA6WYMerej_EZouy7OWtmYH1upObTWeh_FaKXNr7aqMT_YqzQ@mail.gmail.com>
 <20786146C3D31F40+35f2b982-a1b3-446d-9b4e-1ff006107c69@radxa.com>
In-Reply-To: <20786146C3D31F40+35f2b982-a1b3-446d-9b4e-1ff006107c69@radxa.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 3 Jan 2025 18:30:58 +0530
Message-ID: <CAFA6WYOmfxhHhvmyCGziMDzX-V9FbP4zq4p1sHGT_SAg_S1gKA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] arm64: dts: rockchip: enable PCIe on M.2 E key for
 Radxa ROCK 5A
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, jonas@kwiboo.se, eugen.hristev@linaro.org, 
 quentin.schulz@cherry.de, michal.simek@amd.com, seb-dev@mail.de, 
 liujianfeng1994@gmail.com, heiko@sntech.de, zhangzj@rock-chips.com, 
 dsimic@manjaro.org, pbrobinson@gmail.com, macromorgan@hotmail.com, 
 cfsworks@gmail.com, sebastian.reichel@collabora.com, cassel@kernel.org, 
 didi.debian@cknow.org, boris.brezillon@collabora.com, jing@jing.rocks
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

On Fri, 3 Jan 2025 at 18:28, FUKAUMI Naoki <naoki@radxa.com> wrote:
>
> Hi Sumit,
>
> On 1/3/25 21:53, Sumit Garg wrote:
> > Hi FUKAUMI,
> >
> > On Fri, 3 Jan 2025 at 18:02, FUKAUMI Naoki <naoki@radxa.com> wrote:
> >>
> >> Enable pcie2x1l2 and related combphy/regulator routed to M.2 E key
> >> connector on Radxa ROCK 5A.
> >>
> >> Tested with Radxa Wireless Module A8:
> >>
> >> $ lspci
> >> 0004:40:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
> >> 0004:41:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
> >>
> >> $ ip l
> >> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
> >>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> >> 2: end0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
> >>      link/ether c2:58:fc:70:55:86 brd ff:ff:ff:ff:ff:ff
> >> 3: wlP4p65s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
> >>      link/ether 2c:05:47:65:5b:ed brd ff:ff:ff:ff:ff:ff
> >>
> >> $ lsusb
> >> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> >> Bus 001 Device 002: ID 1a40:0101 Terminus Technology Inc. Hub
> >> Bus 001 Device 003: ID 0bda:b85b Realtek Semiconductor Corp. Bluetooth Radio
> >> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> >> Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> >> Bus 004 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> >> Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> >> Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> >> Bus 006 Device 002: ID 0789:0336 Logitec Corp. LMD USB Device
> >> Bus 007 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> >> Bus 008 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> >>
> >> $ hciconfig
> >> hci0:   Type: Primary  Bus: USB
> >>          BD Address: 2C:05:47:65:5B:EE  ACL MTU: 1021:6  SCO MTU: 255:12
> >>          UP RUNNING
> >>          RX bytes:2698 acl:0 sco:0 events:329 errors:0
> >>          TX bytes:69393 acl:0 sco:0 commands:329 errors:0
> >>
> >> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> >> Link: https://lore.kernel.org/r/20240826080456.525-1-naoki@radxa.com
> >> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >> (cherry picked from commit b728d4c51f0ce9207daf502f3a85073785c46319)
> >
> > This doesn't seems to be a clean cherry pick from devicetree-rebasing,
>
> It's weird, but I'd do it all again

Just double check if these commits already landed in dts/upstream
after recent v6.12.dts sync.

-Sumit

> Thanks for your review.
>
> Best regards,
>
> --
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
>
> > I get following error:
> >
> > $ ./tools/update-subtree.sh pick dts b728d4c51f0ce9207daf502f3a85073785c46319
> >  From https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing
> >   * branch                    master     -> FETCH_HEAD
> > fatal: bad object b728d4c51f0ce9207daf502f3a85073785c46319
> >
> > -Sumit
> >
> >> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> >> ---
> >>   .../src/arm64/rockchip/rk3588s-rock-5a.dts    | 30 +++++++++++++++++++
> >>   1 file changed, 30 insertions(+)
> >>
> >> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> >> index 03ed48246d36..a385e0991990 100644
> >> --- a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> >> +++ b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> >> @@ -65,6 +65,18 @@
> >>                  regulator-max-microvolt = <12000000>;
> >>          };
> >>
> >> +       vcc3v3_wf: vcc3v3-wf-regulator {
> >> +               compatible = "regulator-fixed";
> >> +               regulator-name = "vcc3v3_wf";
> >> +               regulator-min-microvolt = <3300000>;
> >> +               regulator-max-microvolt = <3300000>;
> >> +               enable-active-high;
> >> +               gpio = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
> >> +               pinctrl-0 = <&pow_en>;
> >> +               pinctrl-names = "default";
> >> +               vin-supply = <&vcc5v0_sys>;
> >> +       };
> >> +
> >>          vcc5v0_host: vcc5v0-host-regulator {
> >>                  compatible = "regulator-fixed";
> >>                  regulator-name = "vcc5v0_host";
> >> @@ -114,6 +126,10 @@
> >>          };
> >>   };
> >>
> >> +&combphy0_ps {
> >> +       status = "okay";
> >> +};
> >> +
> >>   &combphy2_psu {
> >>          status = "okay";
> >>   };
> >> @@ -293,6 +309,14 @@
> >>          };
> >>   };
> >>
> >> +&pcie2x1l2 {
> >> +       pinctrl-0 = <&pcie20x1m0_pins>;
> >> +       pinctrl-names = "default";
> >> +       reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
> >> +       vpcie3v3-supply = <&vcc3v3_wf>;
> >> +       status = "okay";
> >> +};
> >> +
> >>   &pinctrl {
> >>          leds {
> >>                  io_led: io-led {
> >> @@ -300,6 +324,12 @@
> >>                  };
> >>          };
> >>
> >> +       pcie {
> >> +               pow_en: pow-en {
> >> +                       rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> >> +               };
> >> +       };
> >> +
> >>          power {
> >>                  vcc_5v0_en: vcc-5v0-en {
> >>                          rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> >> --
> >> 2.43.0
> >>
> >
>
