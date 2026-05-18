Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66797CD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 10:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCB4783FEE;
	Mon, 18 May 2026 12:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JhY4m8CM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E762984119; Mon, 18 May 2026 12:05:09 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8067483EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 12:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bcc2b199c17so263854166b.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779098707; cv=none;
 d=google.com; s=arc-20240605;
 b=gcJSBQL+j/YF3lko0Hsogd00A5aFwnBJVpniE2G8fo6HRfl5+gajHQ6NMceAKJWngv
 OTmxhgLaG2HGgWzSeYGs/JN6GO1/9R1v8M+0xQ1Qg9UA2zt0rQpXa38E1GH/Yjf/fWfc
 Mf9ZvULJSmMioodv2lB8jxC2ZogYutbaAn3xPD9WOo2Vcyu1kZuareJoErCKvfHW6D/V
 zhWknBVXV02JNr1W3D8R20QsRV5qPM3fnyCnkZoEg2VQSaun44JovyBOEtIbsXCRZDXp
 yuB/rN5qN5wm9+BrPSaBnQBP9EnP+2W1veBwgjGuxkpqNcuV/57Dl73Xw+vqEUuxiWSw
 74zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oP2e7rlXP5Np4CM+OoF23M34MJHJho5JrtKz+w+O+M4=;
 fh=BrrpNPkDd0i/VueCGJbvzk0uqjsVCXA6IyHZ+ESOfos=;
 b=I48TJ/GVBOpmBwO7PiQX1UW9UCt4q9uf5P+AYkbMBMjWGMRXnUV7P5mzTa8A9wvqBY
 pqNqfAOdwqPhpgWbkR81Daz8VW7SZ0wKcL90e9o+BmJ54wIzMsN9zsIRZniWZCxYIR5w
 EcHEYYOP/JqDA+7YuAzbWWVzgKKfT0pd0Fe42m700fa4e/KDmqKqGX286yNg/InCYWEt
 UvtFMof+ePitZs80ysgfIvMrId7UM4G8rWyfEKbKqzUBam8JAQW9/dDhmvZMYDW0v1hu
 Sf1zbq21zVRtXGkf4sFjscFlfwPoOSEWAyOU5bl2XidUCV8D3+zMmw9ejI0423+FWshe
 Y0Sg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779098707; x=1779703507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oP2e7rlXP5Np4CM+OoF23M34MJHJho5JrtKz+w+O+M4=;
 b=JhY4m8CMQbqCUHfzkdkFWP3sqeivthgGdV5KwCkd0znYHD2RZ+7QEPR0l7T3fHOlN+
 tmDB8bvIf+MsrnKbcZnr/H9f5vJtpWtedsQN6gdl0f8Doaz+ymTZ7AED6NQoXWsIjurv
 8K00fJ++mwBKLR37mY6mOeEKFFTFfolzq3MWv9h9sqeDuAZLuobjP032/FJmBqQq6pPA
 nAfI3HYBskW9osk5K+RyP2QO7RqW2yzPLZxEcOyry0ZK0VVHVMtH8zSPvFAA9EZV14+6
 GGmsqd185yh2VdWCKvd5WDXLQSZmwrJXW39UfJBRvkW26X7mfqHk5YHwPF3k3fJHU0Rp
 0s8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779098707; x=1779703507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oP2e7rlXP5Np4CM+OoF23M34MJHJho5JrtKz+w+O+M4=;
 b=IeLsCroNU5wQyB4z9rE2R7IPbamI3O5tPSIaJyCxwUVaIFTMLPVztw5i99YFqJ8nsX
 Opha+Ug5wYk7Ze1iuq4CM131TCssLsxbE9h7ZyxCw0k9DNFb0D4aDYoyzEGFwKpFHpR7
 s0cO6U6oqlxQZkLipnmnEpTF1/jQsQOfVLcYcEGoh8HKbR1RbqFi2fjczDzZ8Nb2x+mW
 DrT5Mf8fxwos0SuUXOvFBkmGIjCkcHpD1U5zOeAzrFu3vztARY7iJLbQ4PzOSVmHB8sZ
 ZEhrBoCH6ZPww+59aV0guVq1pSwdNqk4Rjm0GxelSNwo3TCHpCGm6rgbNDHdqZW0VW1a
 0G1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tkfvPdVi6EenfEhGNa2iitvCNT0w5ezlWmBMeWeuCt0fLRKQbCun5kPRCHX5PuYGIB0C2r3g=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2O8iV7VYaUZ1d0BiWPP9Q2rdWF+MzYnGbl2WIcrxIHuSZBb2V
 0Fpn2gKZ+n48GHpPOT1SIRnv2sdGIcb8rRLyt9/xycj4iv7Cm+p+0TK5+R0DlJFr7Omye6eXJsR
 D1zC21hIT2RA8uE09BUdp8kGnomv6gw8=
X-Gm-Gg: Acq92OFoNEE+L2P7mB9F7OoiDLzMIAohAgfm9K6RtoYd7GXqkI7CqW0+SYbBFCCOBHT
 7SXYYVUF3zC84icsE/JdkL76UVtEDAgui8Dz5BNaaMNpyUlaIK6Wjh7Zf3xV3gLU/l2YgsKeS1o
 gjRUEG5boLGYuR4Y6O6a6QJTwrXA/2LOxTSuLeMoGm1gz+WHM6dUoG4vBTR7fyCuMRihvTqHhTL
 GGqnPghfyLiTF7eHCt8RptHbdaiopRFNL/PCsAESpzuRmNpl05JKVoD5BFEe05iXD03H/2utpju
 88hC8aZnPw/exyoTRpFQJ1uMcdCNpT1z490knk/hNlvaEA3AOfzP4DDZVo3HRMEuSXdwHHbeeXu
 g3TV+G2FfFsOhNED0IvQnorsKrUWnKRdR3GxgUhefXfKUt2xM4suX2+KWm09jwpn51h+gfDtH7K
 id
X-Received: by 2002:a17:906:ef03:b0:bc5:111d:3c96 with SMTP id
 a640c23a62f3a-bd5177a9ba0mr728685466b.10.1779098657217; Mon, 18 May 2026
 03:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <ce82a3ab-0d89-4b1e-a598-b79f69e7ba5a@gmail.com>
In-Reply-To: <ce82a3ab-0d89-4b1e-a598-b79f69e7ba5a@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 18 May 2026 11:04:05 +0100
X-Gm-Features: AVHnY4L5aZL0PVWgwNQujwjp_ZP2lLQn8JaTU4qPI2buXRihJSSDpjhbLKdQNao
Message-ID: <CALeDE9MYT15KWuOqgpmz6WzVhEKVORM_z0RiUgho06a=XbXhpw@mail.gmail.com>
Subject: Re: [PATCH v1] rockchip: MAINTAINERS: upstream devicetree update
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu, 
 trini@konsulko.com, jagan@edgeble.ai, jonas@kwiboo.se, 
 frattaroli.nicolas@gmail.com, tom@tom-fitzhenry.me.uk, ehristev@kernel.org, 
 chenjh@rock-chips.com, zhangzj@rock-chips.com, jjriek@verizon.net, 
 u-boot@lists.denx.de, andyshrk@163.com, me@0upti.me, zhihong@nzhnb.com, 
 jiehui.he@foxmail.com, maximmosk4@gmail.com, gajjar04akash@gmail.com, 
 jagan@amarulasolutions.com, Tianling Shen <cnsztl@gmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>, nick@khadas.com,
 matwey.kornilov@gmail.com, 
 Chen-Yu Tsai <wens@csie.org>, mail@david-bauer.net, jacobe.zang@wesion.com
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

On Mon, 18 May 2026 at 00:33, Johan Jonker <jbx6244@gmail.com> wrote:
>
> Most Rockchip boards are now using the upstream device tree.
> Some MAINTAINERS files still contain a reference to
> no longer available files. Update and where possible
> streamline with '*' ending.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  .../neural-compute-module-6/MAINTAINERS       |  8 +---
>  board/hardkernel/odroid_m1/MAINTAINERS        |  3 +-
>  board/khadas/khadas-edge2-rk3588s/MAINTAINERS |  2 +-
>  board/pine64/quartz64_rk3566/MAINTAINERS      | 21 ++--------
>  board/pine64/quartzpro64-rk3588/MAINTAINERS   |  3 +-
>  board/radxa/rock5a-rk3588s/MAINTAINERS        |  3 +-
>  board/rockchip/evb_rk3328/MAINTAINERS         | 14 ++-----
>  board/rockchip/evb_rk3399/MAINTAINERS         |  7 +---
>  board/rockchip/evb_rk3568/MAINTAINERS         | 38 +++++++------------
>  board/rockchip/evb_rk3588/MAINTAINERS         | 21 ++++------
>  board/rockchip/toybrick_rk3588/MAINTAINERS    |  3 +-
>  board/turing/turing-rk1-rk3588/MAINTAINERS    |  4 +-
>  .../orangepi-5-ultra-rk3588/MAINTAINERS       |  2 +-
>  13 files changed, 37 insertions(+), 92 deletions(-)
>
> diff --git a/board/edgeble/neural-compute-module-6/MAINTAINERS b/board/edgeble/neural-compute-module-6/MAINTAINERS
> index 42e5df506bf3..97d8c96ae628 100644
> --- a/board/edgeble/neural-compute-module-6/MAINTAINERS
> +++ b/board/edgeble/neural-compute-module-6/MAINTAINERS
> @@ -5,9 +5,5 @@ F:      board/edgeble/neural-compute-module-6
>  F:     include/configs/neural-compute-module-6.h
>  F:     configs/neu6a-io-rk3588_defconfig
>  F:     configs/neu6b-io-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-edgeble-neu6a.dtsi
> -F:     arch/arm/dts/rk3588-edgeble-neu6a-io.dts
> -F:     arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> -F:     arch/arm/dts/rk3588-edgeble-neu6b.dtsi
> -F:     arch/arm/dts/rk3588-edgeble-neu6b-io.dts
> -F:     arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-edgeble-neu6a-io*
> +F:     arch/arm/dts/rk3588-edgeble-neu6b-io*
> diff --git a/board/hardkernel/odroid_m1/MAINTAINERS b/board/hardkernel/odroid_m1/MAINTAINERS
> index 165d2d96741d..8686a552d1c6 100644
> --- a/board/hardkernel/odroid_m1/MAINTAINERS
> +++ b/board/hardkernel/odroid_m1/MAINTAINERS
> @@ -4,5 +4,4 @@ S:      Maintained
>  F:     board/hardkernel/odroid_m1/
>  F:     include/configs/odroid_m1.h
>  F:     configs/odroid-m1-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-odroid-m1.dts
> -F:     arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-odroid-m1*
> diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> index 3f16923b0f25..c43f469589dd 100644
> --- a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> +++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> @@ -3,4 +3,4 @@ M:      Jacobe Zang <jacobe.zang@wesion.com>
>  S:     Maintained
>  F:     configs/khadas-edge2-rk3588s_defconfig
>  F:     include/configs/khadas-edge2-rk3588s.h
> -F:     dts/upstream/src/arm64/rockchip/rk3588s-khadas-edge2.dts
> \ No newline at end of file
> +F:     arch/arm/dts/rk3588s-khadas-edge2*
> diff --git a/board/pine64/quartz64_rk3566/MAINTAINERS b/board/pine64/quartz64_rk3566/MAINTAINERS
> index 37b8c1eb78b6..955cb5de0300 100644
> --- a/board/pine64/quartz64_rk3566/MAINTAINERS
> +++ b/board/pine64/quartz64_rk3566/MAINTAINERS
> @@ -9,26 +9,11 @@ F:    configs/quartz64-b-rk3566_defconfig
>  F:     configs/soquartz-blade-rk3566_defconfig
>  F:     configs/soquartz-cm4-rk3566_defconfig
>  F:     configs/soquartz-model-a-rk3566_defconfig
> -F:     arch/arm/dts/rk3566-quartz64-a.dts
> -F:     arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-quartz64-b.dts
> -F:     arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-soquartz.dtsi
> -F:     arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-soquartz-blade.dts
> -F:     arch/arm/dts/rk3566-soquartz-blade-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-soquartz-cm4.dts
> -F:     arch/arm/dts/rk3566-soquartz-cm4-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-soquartz-model-a.dts
> -F:     arch/arm/dts/rk3566-soquartz-model-a-u-boot.dtsi
> +F:     arch/arm/dts/rk3566-quartz64*
> +F:     arch/arm/dts/rk3566-soquartz*
>
>  PINETAB2-RK3566
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/pinetab2-rk3566_defconfig
> -F:     arch/arm/dts/rk3566-pinetab2.dtsi
> -F:     arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-pinetab2-v0.1.dts
> -F:     arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-pinetab2-v2.0.dts
> -F:     arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi
> +F:     arch/arm/dts/rk3566-pinetab2*
> diff --git a/board/pine64/quartzpro64-rk3588/MAINTAINERS b/board/pine64/quartzpro64-rk3588/MAINTAINERS
> index a7e944b74781..ff3500a32fc0 100644
> --- a/board/pine64/quartzpro64-rk3588/MAINTAINERS
> +++ b/board/pine64/quartzpro64-rk3588/MAINTAINERS
> @@ -4,5 +4,4 @@ S:      Maintained
>  F:     board/pine64/quartzpro64-rk3588
>  F:     include/configs/quartzpro64-rk3588.h
>  F:     configs/quartzpro64-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-quartzpro64.dts
> -F:     arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-quartzpro64*
> diff --git a/board/radxa/rock5a-rk3588s/MAINTAINERS b/board/radxa/rock5a-rk3588s/MAINTAINERS
> index afc9bf5706c9..d4cd82139d51 100644
> --- a/board/radxa/rock5a-rk3588s/MAINTAINERS
> +++ b/board/radxa/rock5a-rk3588s/MAINTAINERS
> @@ -5,5 +5,4 @@ S:      Maintained
>  F:     board/radxa/rock5a-rk3588s
>  F:     include/configs/rock5a-rk3588s.h
>  F:     configs/rock5a-rk3588s_defconfig
> -F:     arch/arm/dts/rk3588s-rock-5a.dts
> -F:     arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +F:     arch/arm/dts/rk3588s-rock-5a*
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
> index 8c9b42fe2bbf..d8748c1c2a26 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -4,8 +4,7 @@ S:      Maintained
>  F:      board/rockchip/evb_rk3328
>  F:      include/configs/evb_rk3328.h
>  F:      configs/evb-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-evb.dts
> -F:      arch/arm/dts/rk3328-evb-u-boot.dtsi
> +F:      arch/arm/dts/rk3328-evb*
>
>  GENERIC-RK3328
>  M:     Jonas Karlman <jonas@kwiboo.se>
> @@ -17,14 +16,12 @@ NANOPI-R2C-RK3328
>  M:      Tianling Shen <cnsztl@gmail.com>
>  S:      Maintained
>  F:      configs/nanopi-r2c-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-nanopi-r2c.dts
>  F:      arch/arm/dts/rk3328-nanopi-r2c-u-boot.dtsi
>
>  NANOPI-R2C-PLUS-RK3328
>  M:      Tianling Shen <cnsztl@gmail.com>
>  S:      Maintained
>  F:      configs/nanopi-r2c-plus-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-nanopi-r2c-plus.dts
>  F:      arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
>
>  NANOPI-R2S-RK3328
> @@ -32,7 +29,6 @@ M:      David Bauer <mail@david-bauer.net>
>  S:      Maintained
>  F:      configs/nanopi-r2s-rk3328_defconfig
>  F:      arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> -F:      arch/arm/dts/rk3328-nanopi-r2s.dts
>
>  NANOPI-R2S-PLUS-RK3328
>  M:      Jonas Karlman <jonas@kwiboo.se>
> @@ -44,14 +40,12 @@ ORANGEPI-R1-PLUS-RK3328
>  M:      Tianling Shen <cnsztl@gmail.com>
>  S:      Maintained
>  F:      configs/orangepi-r1-plus-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-orangepi-r1-plus.dts
>  F:      arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
>
>  ORANGEPI-R1-PLUS-LTS-RK3328
>  M:      Tianling Shen <cnsztl@gmail.com>
>  S:      Maintained
>  F:      configs/orangepi-r1-plus-lts-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts
>  F:      arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
>
>  ROC-RK3328-CC
> @@ -60,16 +54,14 @@ M:      Chen-Yu Tsai <wens@csie.org>
>  R:      Jonas Karlman <jonas@kwiboo.se>
>  S:      Maintained
>  F:      configs/roc-cc-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-roc-cc.dts
> -F:      arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> +F:      arch/arm/dts/rk3328-roc-cc*
>
>  ROCK64-RK3328
>  M:      Matwey V. Kornilov <matwey.kornilov@gmail.com>
>  R:      Jonas Karlman <jonas@kwiboo.se>
>  S:      Maintained
>  F:      configs/rock64-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-rock64.dts
> -F:      arch/arm/dts/rk3328-rock64-u-boot.dtsi
> +F:      arch/arm/dts/rk3328-rock64*
>
>  ROCKPIE-RK3328
>  M:      Banglang Huang <banglang.huang@foxmail.com>
> diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
> index 8319db2e976c..860dd0287597 100644
> --- a/board/rockchip/evb_rk3399/MAINTAINERS
> +++ b/board/rockchip/evb_rk3399/MAINTAINERS
> @@ -24,9 +24,7 @@ KHADAS-EDGE
>  M:     Nick Xie <nick@khadas.com>
>  S:     Maintained
>  F:     configs/khadas-edge-rk3399_defconfig
> -F:     arch/arm/dts/rk3399-khadas-edge.dts
> -F:     arch/arm/dts/rk3399-khadas-edge.dtsi
> -F:     arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
> +F:     arch/arm/dts/rk3399-khadas-edge*
>
>  KHADAS-EDGE-CAPTAIN
>  M:     Nick Xie <nick@khadas.com>
> @@ -56,8 +54,7 @@ NANOPI-M4
>  M:     Jagan Teki <jagan@amarulasolutions.com>
>  S:     Maintained
>  F:     configs/nanopi-m4-rk3399_defconfig
> -F:     arch/arm/dts/rk3399-nanopi-m4.dts
> -F:     arch/arm/dts/rk3399-nanopi-m4-u-boot.dtsi
> +F:     arch/arm/dts/rk3399-nanopi-m4*
>
>  NANOPI-M4-2GB
>  M:     Jagan Teki <jagan@amarulasolutions.com>
> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
> index 030cdbe6f3db..7e17a6a987a5 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -2,8 +2,7 @@ BANANAPI-BPI-R2-PRO
>  M:     Frank Wunderlich <frank-w@public-files.de>
>  S:     Maintained
>  F:     configs/bpi-r2-pro-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-bpi-r2-pro.dts
> -F:     arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-bpi-r2-pro*
>
>  EVB-RK3568
>  M:     Joseph Chen <chenjh@rock-chips.com>
> @@ -11,78 +10,67 @@ S:  Maintained
>  F:     board/rockchip/evb_rk3568
>  F:     include/configs/evb_rk3568.h
>  F:     configs/evb-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-evb-u-boot.dtsi
> -F:     arch/arm/dts/rk3568-evb.dts
> +F:     arch/arm/dts/rk3568-evb*
>
>  FASTRHINO-R66S-RK3568
>  M:     Tianling Shen <cnsztl@gmail.com>
>  R:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/fastrhino-r66s-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-fastrhino-r66s*
>
>  GENERIC-RK3568
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/generic-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-generic.dts
> -F:     arch/arm/dts/rk3568-generic-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-generic*
>
>  LUBANCAT-2
>  M:     Andy Yan <andyshrk@163.com>
>  S:     Maintained
>  F:     configs/lubancat-2-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-lubancat-2.dts
> -F:     arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-lubancat-2*
>
>  NANOPI-R3S
>  M:     Tianling Shen <cnsztl@gmail.com>
>  R:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/nanopi-r3s-rk3566_defconfig
> -F:     arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
> +F:     arch/arm/dts/rk3566-nanopi-r3s*
>
>  NANOPI-R5C
>  M:     Tianling Shen <cnsztl@gmail.com>
>  R:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/nanopi-r5c-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-nanopi-r5c.dts
> -F:     arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-nanopi-r5c*
>
>  NANOPI-R5S
>  M:     Tianling Shen <cnsztl@gmail.com>
>  R:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/nanopi-r5s-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-nanopi-r5s.dts
> -F:     arch/arm/dts/rk3568-nanopi-r5s.dtsi
> -F:     arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-nanopi-r5s*
>
>  RADXA-CM3-IO
>  M:     Jagan Teki <jagan@amarulasolutions.com>
>  R:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/radxa-cm3-io-rk3566_defconfig
> -F:     arch/arm/dts/rk3566-radxa-cm3.dtsi
> -F:     arch/arm/dts/rk3566-radxa-cm3-io.dts
> -F:     arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> +F:     arch/arm/dts/rk3566-radxa-cm3-io*
>
>  RADXA-E25
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/radxa-e25-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-radxa-cm3i.dtsi
> -F:     arch/arm/dts/rk3568-radxa-e25.dts
> -F:     arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-radxa-e25*
>
>  ROCK-3A
>  M:     Akash Gajjar <gajjar04akash@gmail.com>
>  R:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/rock-3a-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-rock-3a.dts
> -F:     arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-rock-3a*
>
>  ROCK-3B
>  M:     Jonas Karlman <jonas@kwiboo.se>
> @@ -94,11 +82,11 @@ ROCK-3C
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  M:     Maxim Moskalets <maximmosk4@gmail.com>
>  S:     Maintained
> -F:     arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
> +F:     arch/arm/dts/rk3566-rock-3c*
>  F:     configs/rock-3c-rk3566_defconfig
>
>  LCKFB-TaishanPi
>  M:     Jiehui He <jiehui.he@foxmail.com>
>  S:     Maintained
>  F:     configs/lckfb-tspi-rk3566_defconfig
> -F:     arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
> +F:     arch/arm/dts/rk3566-lckfb-tspi*
> diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
> index 8b11db43f5f6..b64dd4947ee2 100644
> --- a/board/rockchip/evb_rk3588/MAINTAINERS
> +++ b/board/rockchip/evb_rk3588/MAINTAINERS
> @@ -2,16 +2,13 @@ COOLPI-4B-RK3588S
>  M:     Andy Yan <andyshrk@163.com>
>  S:     Maintained
>  F:     configs/coolpi-4b-rk3588s_defconfig
> -F:     arch/arm/dts/rk3588s-coolpi-4b.dts
> -F:     arch/arm/dts/rk3588s-coolpi-u-boot.dtsi
> +F:     arch/arm/dts/rk3588s-coolpi-4b*
>
>  COOLPI-CM5-EVB-RK3588
>  M:     Andy Yan <andyshrk@163.com>
>  S:     Maintained
>  F:     configs/coolpi-cm5-evb-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-coolpi-cm5.dtsi
> -F:     arch/arm/dts/rk3588-coolpi-cm5-evb.dts
> -F:     arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-coolpi-cm5-evb*
>
>  EVB-RK3588
>  M:     Kever Yang <kever.yang@rock-chips.com>
> @@ -19,15 +16,13 @@ S:  Maintained
>  F:     board/rockchip/evb_rk3588
>  F:     include/configs/evb_rk3588.h
>  F:     configs/evb-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-evb1-v10.dts
> -F:     arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-evb1-v10*
>
>  GENERIC-RK3588
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/generic-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-generic.dts
> -F:     arch/arm/dts/rk3588-generic-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-generic*
>
>  MNT-REFORM2-RK3588
>  M:     Peter Robinson <pbrobinson@gmail.com>
> @@ -38,24 +33,22 @@ ORANGEPI-5-RK3588
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/orangepi-5-rk3588s_defconfig
> -F:     arch/arm/dts/rk3588s-orangepi-5.dts
>  F:     arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
>
>  ORANGEPI-5-MAX-RK3588
>  M:     Ilya Katsnelson <me@0upti.me>
>  S:     Maintained
>  F:     configs/orangepi-5-max-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-orangepi-5-max*
>
>  ORANGEPI-5-PLUS-RK3588
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/orangepi-5-plus-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-orangepi-5-plus.dts
> -F:     arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-orangepi-5-plus*
>
>  ORANGEPI-5-RK3588-ULTRA
>  M:     Niu Zhihong <zhihong@nzhnb.com>
>  S:     Maintained
>  F:     configs/orangepi-5-ultra-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-orangepi-5-ultra-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-orangepi-5-ultra*
> diff --git a/board/rockchip/toybrick_rk3588/MAINTAINERS b/board/rockchip/toybrick_rk3588/MAINTAINERS
> index cd4401c24f30..e2c76f80e9b8 100644
> --- a/board/rockchip/toybrick_rk3588/MAINTAINERS
> +++ b/board/rockchip/toybrick_rk3588/MAINTAINERS
> @@ -4,5 +4,4 @@ S:      Maintained
>  F:     board/rockchip/toybrick_rk3588
>  F:     include/configs/toybrick_rk3588.h
>  F:     configs/toybrick-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-toybrick-x0.dts
> -F:     arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-toybrick-x0*
> diff --git a/board/turing/turing-rk1-rk3588/MAINTAINERS b/board/turing/turing-rk1-rk3588/MAINTAINERS
> index 4f313732fa13..973ac68836cb 100644
> --- a/board/turing/turing-rk1-rk3588/MAINTAINERS
> +++ b/board/turing/turing-rk1-rk3588/MAINTAINERS
> @@ -4,6 +4,4 @@ S:      Maintained
>  F:     board/turing/turing-rk1-rk3588
>  F:     include/configs/turing-rk1-rk3588.h
>  F:     configs/turing-rk1-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-turing-rk1.dts
> -F:     arch/arm/dts/rk3588-turing-rk1.dtsi
> -F:     arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-turing-rk1*
> diff --git a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
> index be9c93f6b9d9..79981aa43f13 100644
> --- a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
> +++ b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
> @@ -3,4 +3,4 @@ M:      Niu Zhihong <zhihong@nzhnb.com>
>  S:     Maintained
>  F:     board/xunlong/orangepi-5-rk3588-ultra
>  F:     configs/orangepi-5-ultra-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-orangepi-5-ultra.dts
> +F:     arch/arm/dts/rk3588-orangepi-5-ultra*
> --
> 2.39.5
>
