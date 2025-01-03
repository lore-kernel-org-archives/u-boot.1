Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B3DE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 12:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00DB380275;
	Fri,  3 Jan 2025 13:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YuLPZMuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA9980295; Fri,  3 Jan 2025 13:54:53 +0100 (CET)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC276801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 13:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-85c5a913cffso5436923241.0
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 04:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735908890; x=1736513690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1gzOv8nMcVOMiLsFM+1yKV6diT/e4H1bjU+ky5dZCf4=;
 b=YuLPZMuDwyXcIlIrohSYB0ASVfJkcpFhuqk/IZ92GiKpIagqzk8G9ibc3a62vAAVTm
 dejgj4E3j16XKNPIDdQ4SYf3CQsfiMVlOAn7Xt/qpc9qDQIoZPVngnKBvgSD3VGnwoDm
 5KNcncSKFZ6HRnSvqsCFJRO4qA8QRKCHLR/R5ht0b/2jsjVpgyN2IvvEShTHYfm5AfE4
 DT2Tv25jpGXs7foRp0+K8IIuQtR78ZaXhvNbrD4zlHfhoFojN1OUzhkKQCNI66JtLLxQ
 Lw9mNTOUPNgauA3xgqu8+KwbOQ1+28UXrDBGvTkJnmFaloMSilNnoVW91h3c3vwgswhn
 aJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735908890; x=1736513690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1gzOv8nMcVOMiLsFM+1yKV6diT/e4H1bjU+ky5dZCf4=;
 b=h7l9lrb4rQlxKxuGecgRCkmlVss+QjXBsz42r7g9O5Tq3C8SmMWTZiTRGLaFsf2aOB
 X5XWkshZCwzeZdWY8MqKNzyywJioX9ReuAS6vhTgvp2nUxnwY6zPCd6qC/3gdalGecv8
 Bf14CSIjgorG6y63YhLioc/Z3+sB4DveaBbgT5UhySvhli8qwbUg2gYEA6HnTvTuk4M7
 8VEQU3a8+4I60PpzqQF2cBIl61ZEOw+O9HTMETLfROn10PHHSfMXhvwkxnvXnzbbRHcK
 aPP3NV5vNNbmAFCxQwXGLyzrNlNap478AxAKx9X79/hZtHkRNqAyA3bvG0LDQUseemnh
 ZzOA==
X-Gm-Message-State: AOJu0Yxc9miBg6gI+1XazItjpDSUgHiN30uUlR+MN5cobZ9Aw0OQSGbY
 JnBo+BFUvpNZVp6+ynM6Zfgq6u897tc/M5L9xIZBHNgmPPSLTcFoemJQklLkpU3/yzkYqSH5yVv
 20mSMu8qOt3TaL7Ft5ie1fZl3gdlAWahhchnQCw==
X-Gm-Gg: ASbGnctTCxh1MRUbLAQOwN1dNFAcBZ0c1nWa9McXHqsLTtlpGnXECsU2G0mP6I1m/gn
 V1gtUvbVjttLOBvgopNFgkYvhw+tmSambuQag6Q==
X-Google-Smtp-Source: AGHT+IGZR8rTmC6KvYFMtH3lFQRuvz95SR5eVWR6DdHx/8EfPWIOkq24aB2iOSpY0tP0oobdfwYsbC+ut4r8s1QqIR0=
X-Received: by 2002:a05:6102:3a0b:b0:4af:f8b9:bea3 with SMTP id
 ada2fe7eead31-4b2cc38561bmr35391468137.15.1735908889618; Fri, 03 Jan 2025
 04:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20250103123052.110350-1-naoki@radxa.com>
 <20250103123052.110350-3-naoki@radxa.com>
In-Reply-To: <20250103123052.110350-3-naoki@radxa.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 3 Jan 2025 18:24:37 +0530
Message-ID: <CAFA6WYMNMz0HYkF6T_=4H8v41MJb7o3TM287rKSgcRz4t6X7BQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] arm64: dts: rockchip: Split up RK3588's PCIe
 pinctrls
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

On Fri, 3 Jan 2025 at 18:02, FUKAUMI Naoki <naoki@radxa.com> wrote:
>
> From: Sam Edwards <cfsworks@gmail.com>
>
> These pinctrls manage the low-speed PCIe signals:
> - CLKREQ#: An output on the RK3588 (both RC or EP modes), used to
>   request that external clock-generation circuitry provide a clock.
> - PERST#: An input on the RK3588 in EP mode, used to detect a reset
>   signal from the RC. In RC mode, the hardware does not use this signal:
>   Linux itself generates it by putting the pin in GPIO mode.
> - WAKE#: In EP mode, this is an output; in RC mode, this is an input.
>
> Each of these signals serves a distinct purpose, and more importantly,
> PERST# should not be muxed when the RK3588 is in the RC role. Bundling
> them together in pinctrl groups prevents proper use: indeed, almost none
> of the current board-specific .dts files make any use of them.
> (Exception: Rock 5A recently had a patch land that misuses _pins; this
>  patch corrects that.)
>
> However, on some RK3588 boards, the PCIe 3 controller will indefinitely
> stall the boot if CLKREQ# is not muxed (details in the next patch).
> This patch unbundles the signals to allow them to be used.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> Link: https://lore.kernel.org/r/20240912025034.180233-2-CFSworks@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> (cherry picked from commit 4294e32111781b3de4d73b944cbd1bc1662a9a7a)

Ditto here:

$ ./tools/update-subtree.sh pick dts 4294e32111781b3de4d73b944cbd1bc1662a9a7a
From https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing
 * branch                    master     -> FETCH_HEAD
fatal: bad object 4294e32111781b3de4d73b944cbd1bc1662a9a7a

-Sumit

> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  .../arm64/rockchip/rk3588-base-pinctrl.dtsi   | 271 ++++++++++++++----
>  .../src/arm64/rockchip/rk3588s-rock-5a.dts    |   6 +-
>  2 files changed, 228 insertions(+), 49 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-base-pinctrl.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-base-pinctrl.dtsi
> index 30db12c4fc82..b12562e9a985 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-base-pinctrl.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-base-pinctrl.dtsi
> @@ -1612,23 +1612,43 @@
>
>         pcie20x1 {
>                 /omit-if-no-ref/
> -               pcie20x1m0_pins: pcie20x1m0-pins {
> +               pcie20x1m0_clkreqn: pcie20x1m0-clkreqn {
>                         rockchip,pins =
>                                 /* pcie20x1_2_clkreqn_m0 */
> -                               <3 RK_PC7 4 &pcfg_pull_none>,
> +                               <3 RK_PC7 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie20x1m0_perstn: pcie20x1m0-perstn {
> +                       rockchip,pins =
>                                 /* pcie20x1_2_perstn_m0 */
> -                               <3 RK_PD1 4 &pcfg_pull_none>,
> +                               <3 RK_PD1 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie20x1m0_waken: pcie20x1m0-waken {
> +                       rockchip,pins =
>                                 /* pcie20x1_2_waken_m0 */
>                                 <3 RK_PD0 4 &pcfg_pull_none>;
>                 };
>
>                 /omit-if-no-ref/
> -               pcie20x1m1_pins: pcie20x1m1-pins {
> +               pcie20x1m1_clkreqn: pcie20x1m1-clkreqn {
>                         rockchip,pins =
>                                 /* pcie20x1_2_clkreqn_m1 */
> -                               <4 RK_PB7 4 &pcfg_pull_none>,
> +                               <4 RK_PB7 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie20x1m1_perstn: pcie20x1m1-perstn {
> +                       rockchip,pins =
>                                 /* pcie20x1_2_perstn_m1 */
> -                               <4 RK_PC1 4 &pcfg_pull_none>,
> +                               <4 RK_PC1 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie20x1m1_waken: pcie20x1m1-waken {
> +                       rockchip,pins =
>                                 /* pcie20x1_2_waken_m1 */
>                                 <4 RK_PC0 4 &pcfg_pull_none>;
>                 };
> @@ -1654,52 +1674,127 @@
>
>         pcie30x1 {
>                 /omit-if-no-ref/
> -               pcie30x1m0_pins: pcie30x1m0-pins {
> +               pcie30x1m0_0_clkreqn: pcie30x1m0-0-clkreqn {
>                         rockchip,pins =
>                                 /* pcie30x1_0_clkreqn_m0 */
> -                               <0 RK_PC0 12 &pcfg_pull_none>,
> +                               <0 RK_PC0 12 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m0_0_perstn: pcie30x1m0-0-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x1_0_perstn_m0 */
> -                               <0 RK_PC5 12 &pcfg_pull_none>,
> +                               <0 RK_PC5 12 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m0_0_waken: pcie30x1m0-0-waken {
> +                       rockchip,pins =
>                                 /* pcie30x1_0_waken_m0 */
> -                               <0 RK_PC4 12 &pcfg_pull_none>,
> +                               <0 RK_PC4 12 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m0_1_clkreqn: pcie30x1m0-1-clkreqn {
> +                       rockchip,pins =
>                                 /* pcie30x1_1_clkreqn_m0 */
> -                               <0 RK_PB5 12 &pcfg_pull_none>,
> +                               <0 RK_PB5 12 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m0_1_perstn: pcie30x1m0-1-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x1_1_perstn_m0 */
> -                               <0 RK_PB7 12 &pcfg_pull_none>,
> +                               <0 RK_PB7 12 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m0_1_waken: pcie30x1m0-1-waken {
> +                       rockchip,pins =
>                                 /* pcie30x1_1_waken_m0 */
>                                 <0 RK_PB6 12 &pcfg_pull_none>;
>                 };
>
>                 /omit-if-no-ref/
> -               pcie30x1m1_pins: pcie30x1m1-pins {
> +               pcie30x1m1_0_clkreqn: pcie30x1m1-0-clkreqn {
>                         rockchip,pins =
>                                 /* pcie30x1_0_clkreqn_m1 */
> -                               <4 RK_PA3 4 &pcfg_pull_none>,
> +                               <4 RK_PA3 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m1_0_perstn: pcie30x1m1-0-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x1_0_perstn_m1 */
> -                               <4 RK_PA5 4 &pcfg_pull_none>,
> +                               <4 RK_PA5 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m1_0_waken: pcie30x1m1-0-waken {
> +                       rockchip,pins =
>                                 /* pcie30x1_0_waken_m1 */
> -                               <4 RK_PA4 4 &pcfg_pull_none>,
> +                               <4 RK_PA4 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m1_1_clkreqn: pcie30x1m1-1-clkreqn {
> +                       rockchip,pins =
>                                 /* pcie30x1_1_clkreqn_m1 */
> -                               <4 RK_PA0 4 &pcfg_pull_none>,
> +                               <4 RK_PA0 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m1_1_perstn: pcie30x1m1-1-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x1_1_perstn_m1 */
> -                               <4 RK_PA2 4 &pcfg_pull_none>,
> +                               <4 RK_PA2 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m1_1_waken: pcie30x1m1-1-waken {
> +                       rockchip,pins =
>                                 /* pcie30x1_1_waken_m1 */
>                                 <4 RK_PA1 4 &pcfg_pull_none>;
>                 };
>
>                 /omit-if-no-ref/
> -               pcie30x1m2_pins: pcie30x1m2-pins {
> +               pcie30x1m2_0_clkreqn: pcie30x1m2-0-clkreqn {
>                         rockchip,pins =
>                                 /* pcie30x1_0_clkreqn_m2 */
> -                               <1 RK_PB5 4 &pcfg_pull_none>,
> +                               <1 RK_PB5 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m2_0_perstn: pcie30x1m2-0-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x1_0_perstn_m2 */
> -                               <1 RK_PB4 4 &pcfg_pull_none>,
> +                               <1 RK_PB4 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m2_0_waken: pcie30x1m2-0-waken {
> +                       rockchip,pins =
>                                 /* pcie30x1_0_waken_m2 */
> -                               <1 RK_PB3 4 &pcfg_pull_none>,
> +                               <1 RK_PB3 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m2_1_clkreqn: pcie30x1m2-1-clkreqn {
> +                       rockchip,pins =
>                                 /* pcie30x1_1_clkreqn_m2 */
> -                               <1 RK_PA0 4 &pcfg_pull_none>,
> +                               <1 RK_PA0 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m2_1_perstn: pcie30x1m2-1-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x1_1_perstn_m2 */
> -                               <1 RK_PA7 4 &pcfg_pull_none>,
> +                               <1 RK_PA7 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x1m2_1_waken: pcie30x1m2-1-waken {
> +                       rockchip,pins =
>                                 /* pcie30x1_1_waken_m2 */
>                                 <1 RK_PA1 4 &pcfg_pull_none>;
>                 };
> @@ -1721,45 +1816,85 @@
>
>         pcie30x2 {
>                 /omit-if-no-ref/
> -               pcie30x2m0_pins: pcie30x2m0-pins {
> +               pcie30x2m0_clkreqn: pcie30x2m0-clkreqn {
>                         rockchip,pins =
>                                 /* pcie30x2_clkreqn_m0 */
> -                               <0 RK_PD1 12 &pcfg_pull_none>,
> +                               <0 RK_PD1 12 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x2m0_perstn: pcie30x2m0-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x2_perstn_m0 */
> -                               <0 RK_PD4 12 &pcfg_pull_none>,
> +                               <0 RK_PD4 12 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x2m0_waken: pcie30x2m0-waken {
> +                       rockchip,pins =
>                                 /* pcie30x2_waken_m0 */
>                                 <0 RK_PD2 12 &pcfg_pull_none>;
>                 };
>
>                 /omit-if-no-ref/
> -               pcie30x2m1_pins: pcie30x2m1-pins {
> +               pcie30x2m1_clkreqn: pcie30x2m1-clkreqn {
>                         rockchip,pins =
>                                 /* pcie30x2_clkreqn_m1 */
> -                               <4 RK_PA6 4 &pcfg_pull_none>,
> +                               <4 RK_PA6 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x2m1_perstn: pcie30x2m1-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x2_perstn_m1 */
> -                               <4 RK_PB0 4 &pcfg_pull_none>,
> +                               <4 RK_PB0 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x2m1_waken: pcie30x2m1-waken {
> +                       rockchip,pins =
>                                 /* pcie30x2_waken_m1 */
>                                 <4 RK_PA7 4 &pcfg_pull_none>;
>                 };
>
>                 /omit-if-no-ref/
> -               pcie30x2m2_pins: pcie30x2m2-pins {
> +               pcie30x2m2_clkreqn: pcie30x2m2-clkreqn {
>                         rockchip,pins =
>                                 /* pcie30x2_clkreqn_m2 */
> -                               <3 RK_PD2 4 &pcfg_pull_none>,
> +                               <3 RK_PD2 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x2m2_perstn: pcie30x2m2-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x2_perstn_m2 */
> -                               <3 RK_PD4 4 &pcfg_pull_none>,
> +                               <3 RK_PD4 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x2m2_waken: pcie30x2m2-waken {
> +                       rockchip,pins =
>                                 /* pcie30x2_waken_m2 */
>                                 <3 RK_PD3 4 &pcfg_pull_none>;
>                 };
>
>                 /omit-if-no-ref/
> -               pcie30x2m3_pins: pcie30x2m3-pins {
> +               pcie30x2m3_clkreqn: pcie30x2m3-clkreqn {
>                         rockchip,pins =
>                                 /* pcie30x2_clkreqn_m3 */
> -                               <1 RK_PD7 4 &pcfg_pull_none>,
> +                               <1 RK_PD7 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x2m3_perstn: pcie30x2m3-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x2_perstn_m3 */
> -                               <1 RK_PB7 4 &pcfg_pull_none>,
> +                               <1 RK_PB7 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x2m3_waken: pcie30x2m3-waken {
> +                       rockchip,pins =
>                                 /* pcie30x2_waken_m3 */
>                                 <1 RK_PB6 4 &pcfg_pull_none>;
>                 };
> @@ -1774,45 +1909,85 @@
>
>         pcie30x4 {
>                 /omit-if-no-ref/
> -               pcie30x4m0_pins: pcie30x4m0-pins {
> +               pcie30x4m0_clkreqn: pcie30x4m0-clkreqn {
>                         rockchip,pins =
>                                 /* pcie30x4_clkreqn_m0 */
> -                               <0 RK_PC6 12 &pcfg_pull_none>,
> +                               <0 RK_PC6 12 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x4m0_perstn: pcie30x4m0-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x4_perstn_m0 */
> -                               <0 RK_PD0 12 &pcfg_pull_none>,
> +                               <0 RK_PD0 12 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x4m0_waken: pcie30x4m0-waken {
> +                       rockchip,pins =
>                                 /* pcie30x4_waken_m0 */
>                                 <0 RK_PC7 12 &pcfg_pull_none>;
>                 };
>
>                 /omit-if-no-ref/
> -               pcie30x4m1_pins: pcie30x4m1-pins {
> +               pcie30x4m1_clkreqn: pcie30x4m1-clkreqn {
>                         rockchip,pins =
>                                 /* pcie30x4_clkreqn_m1 */
> -                               <4 RK_PB4 4 &pcfg_pull_none>,
> +                               <4 RK_PB4 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x4m1_perstn: pcie30x4m1-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x4_perstn_m1 */
> -                               <4 RK_PB6 4 &pcfg_pull_none>,
> +                               <4 RK_PB6 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x4m1_waken: pcie30x4m1-waken {
> +                       rockchip,pins =
>                                 /* pcie30x4_waken_m1 */
>                                 <4 RK_PB5 4 &pcfg_pull_none>;
>                 };
>
>                 /omit-if-no-ref/
> -               pcie30x4m2_pins: pcie30x4m2-pins {
> +               pcie30x4m2_clkreqn: pcie30x4m2-clkreqn {
>                         rockchip,pins =
>                                 /* pcie30x4_clkreqn_m2 */
> -                               <3 RK_PC4 4 &pcfg_pull_none>,
> +                               <3 RK_PC4 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x4m2_perstn: pcie30x4m2-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x4_perstn_m2 */
> -                               <3 RK_PC6 4 &pcfg_pull_none>,
> +                               <3 RK_PC6 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x4m2_waken: pcie30x4m2-waken {
> +                       rockchip,pins =
>                                 /* pcie30x4_waken_m2 */
>                                 <3 RK_PC5 4 &pcfg_pull_none>;
>                 };
>
>                 /omit-if-no-ref/
> -               pcie30x4m3_pins: pcie30x4m3-pins {
> +               pcie30x4m3_clkreqn: pcie30x4m3-clkreqn {
>                         rockchip,pins =
>                                 /* pcie30x4_clkreqn_m3 */
> -                               <1 RK_PB0 4 &pcfg_pull_none>,
> +                               <1 RK_PB0 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x4m3_perstn: pcie30x4m3-perstn {
> +                       rockchip,pins =
>                                 /* pcie30x4_perstn_m3 */
> -                               <1 RK_PB2 4 &pcfg_pull_none>,
> +                               <1 RK_PB2 4 &pcfg_pull_none>;
> +               };
> +
> +               /omit-if-no-ref/
> +               pcie30x4m3_waken: pcie30x4m3-waken {
> +                       rockchip,pins =
>                                 /* pcie30x4_waken_m3 */
>                                 <1 RK_PB1 4 &pcfg_pull_none>;
>                 };
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> index a385e0991990..d6a0b559edca 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> @@ -310,7 +310,7 @@
>  };
>
>  &pcie2x1l2 {
> -       pinctrl-0 = <&pcie20x1m0_pins>;
> +       pinctrl-0 = <&pcie2_reset>, <&pcie20x1m0_clkreqn>, <&pcie20x1m0_waken>;
>         pinctrl-names = "default";
>         reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
>         vpcie3v3-supply = <&vcc3v3_wf>;
> @@ -328,6 +328,10 @@
>                 pow_en: pow-en {
>                         rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
>                 };
> +
> +               pcie2_reset: pcie2-reset {
> +                       rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
>         };
>
>         power {
> --
> 2.43.0
>
