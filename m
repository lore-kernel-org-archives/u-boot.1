Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8997AC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0976A80819;
	Sun,  9 Feb 2025 15:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wdp+bJPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998C880836; Sun,  9 Feb 2025 15:27:20 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A830A80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso5125990a91.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111236; x=1739716036; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=801/2bYUPOVHClBsrVU2lijCsp2DOaX5Cl82zPypOYc=;
 b=Wdp+bJPUOoDN9qdA1uextWMm7wsysmVWBRLB+s2fsiNjfE8xPzhZNOMlo488rWijpW
 Fre8H5pPBxr9V2zTENJ5ID/N0wGQHuHSBVxxbA9e/HMEzkM50r4pcNYJ/B5Ux/b6VmK5
 fMW6/z6+eTo94y8bbM2/geK//46EhUTZQ2S0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111236; x=1739716036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=801/2bYUPOVHClBsrVU2lijCsp2DOaX5Cl82zPypOYc=;
 b=M9Z/q8GDN5G9S8OnawElEylsl7WJSms2rp/oDpW9IfhBOuPcMWF3JZNN1lPQvajKG0
 3L5LVJU5gpULc+UOSkBGcxN3rQqPsEPzhTiIjv+P1Ac4viAvsLu0GCvdXrY/bvtU6vax
 a7Q1YAq5BTm+c1fb9qPHvqsZ1Dn6qtAxZoRH4A4+ukw1dTlnEWqGdERQwemws35hjlpG
 wepHPNhNgs39zoEusjkN2/mbyRin0w7fd2yjX9itCe6HRVW4R3YjsbSPuLfU2j+BCtah
 Y2VO5EMVE8Uu5bHua5J2mdlRs3RgYbSDswNA/oE+m9E8CulUBnsTUNKaSzHdbBVt0qXu
 Y8rQ==
X-Gm-Message-State: AOJu0YwRGM5IjTGhKCHiYJf3xRmSDKeYTHpTk+xVpSdXDWVd0bX1q95c
 uNHyb+pkDuE1cwdHlgY3ledtI4PNzfk+APmMAdDpDZGMukfmWr2PKm9EQvl8sjBbJAWNPKJws1/
 KQ3Dkk9BZADSMvGyMGP/0dOfvEkipO00R8tkZ
X-Gm-Gg: ASbGncvPpL3DFblY3BrLcOYgyVo9w41gdE5K11X7KFS+mlZeONx9MS0u+uqm8RO1umf
 fzfZ5Aodcwuu9vP70t9pxa3QQ5cr55YG0QgNN8D2qwecbtUksb6zEp9AbW3f32OGvn0Lrxx+p/g
 ==
X-Google-Smtp-Source: AGHT+IEUVY28/Ts21MTvFBNDDoE+t2EbB5BQPvOR08O/BC3Wckptmq24BpMZqeKzLVos0sIexabl38a9vh6qYwRsKQw=
X-Received: by 2002:a17:90b:184d:b0:2ee:9d65:65a7 with SMTP id
 98e67ed59e1d1-2fa2450d0abmr15372638a91.29.1739111236171; Sun, 09 Feb 2025
 06:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-17-sjg@chromium.org>
 <a35be74c-5a16-40ef-b330-b6ff75b24999@kwiboo.se>
In-Reply-To: <a35be74c-5a16-40ef-b330-b6ff75b24999@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:26:50 -0700
X-Gm-Features: AWEUYZmyjKRCxHKtZkPmjXajCKNZlhqmr4WuY47pcCgsuhI8OJrNdfwpUuFgq8g
Message-ID: <CAFLszThZVN=Y4jCM19=PP1rKH0dbuW=an0RNavX4n-St4vs2eg@mail.gmail.com>
Subject: Re: [PATCH 16/29] rockchip: Set the skip-at-start property correctly
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
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

Hi Jonas,

On Wed, 5 Feb 2025 at 08:32, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-05 02:55, Simon Glass wrote:
> > The rockchip image is written to the media at block 64, which is a 32K
> > offset, so set the skip-at-start property to 0x8000
> >
> > Update CONFIG_SPL_PAD_TO to point to the offset in the image, since
> > Binman is dealing with the 'missing' 32K now.
>
> I see lots of calculation with +/- 0x8000 in your new VPL binman images,
> are they there to counteract this change?

I count two (for A and B) and no, they are not related.

>
> Please drop this mass change and use a <(CONFIG_SPL_PAD_TO + 0x8000)>
> or similar for binman, and if needed do a mass change at the end or in a
> separate follow-up patch/series.

OK, I'll move this to later and separate out the clean-ups so you can
see the impact.

>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/arm/dts/rockchip-u-boot.dtsi             | 2 ++
> >  configs/anbernic-rgxx3-rk3566_defconfig       | 2 +-
> >  configs/bpi-r2-pro-rk3568_defconfig           | 2 +-
> >  configs/chromebit_mickey_defconfig            | 2 +-
> >  configs/chromebook_bob_defconfig              | 2 +-
> >  configs/chromebook_jerry_defconfig            | 2 +-
> >  configs/chromebook_kevin_defconfig            | 2 +-
> >  configs/chromebook_minnie_defconfig           | 2 +-
> >  configs/chromebook_speedy_defconfig           | 2 +-
> >  configs/cm3588-nas-rk3588_defconfig           | 2 +-
> >  configs/coolpi-4b-rk3588s_defconfig           | 2 +-
> >  configs/coolpi-cm5-evb-rk3588_defconfig       | 2 +-
> >  configs/coolpi-cm5-genbook-rk3588_defconfig   | 2 +-
> >  configs/eaidk-610-rk3399_defconfig            | 2 +-
> >  configs/evb-px30_defconfig                    | 2 +-
> >  configs/evb-px5_defconfig                     | 2 +-
> >  configs/evb-rk3036_defconfig                  | 2 +-
> >  configs/evb-rk3229_defconfig                  | 2 +-
> >  configs/evb-rk3288_defconfig                  | 2 +-
> >  configs/evb-rk3308_defconfig                  | 2 +-
> >  configs/evb-rk3328_defconfig                  | 2 +-
> >  configs/evb-rk3399_defconfig                  | 2 +-
> >  configs/evb-rk3568_defconfig                  | 2 +-
> >  configs/evb-rk3588_defconfig                  | 2 +-
> >  configs/ficus-rk3399_defconfig                | 2 +-
> >  configs/firefly-px30_defconfig                | 2 +-
> >  configs/firefly-rk3288_defconfig              | 2 +-
> >  configs/firefly-rk3399_defconfig              | 2 +-
> >  configs/generic-rk3568_defconfig              | 2 +-
> >  configs/generic-rk3588_defconfig              | 2 +-
> >  configs/jaguar-rk3588_defconfig               | 2 +-
> >  configs/khadas-edge-captain-rk3399_defconfig  | 2 +-
> >  configs/khadas-edge-rk3399_defconfig          | 2 +-
> >  configs/khadas-edge-v-rk3399_defconfig        | 2 +-
> >  configs/kylin-rk3036_defconfig                | 2 +-
> >  configs/leez-rk3399_defconfig                 | 2 +-
> >  configs/lubancat-2-rk3568_defconfig           | 2 +-
> >  configs/miqi-rk3288_defconfig                 | 2 +-
> >  configs/mk808_defconfig                       | 2 +-
> >  configs/nanopc-t4-rk3399_defconfig            | 2 +-
> >  configs/nanopc-t6-rk3588_defconfig            | 2 +-
> >  configs/nanopi-m4-2gb-rk3399_defconfig        | 2 +-
> >  configs/nanopi-m4-rk3399_defconfig            | 2 +-
> >  configs/nanopi-m4b-rk3399_defconfig           | 2 +-
> >  configs/nanopi-neo4-rk3399_defconfig          | 2 +-
> >  configs/nanopi-r2c-plus-rk3328_defconfig      | 2 +-
> >  configs/nanopi-r2c-rk3328_defconfig           | 2 +-
> >  configs/nanopi-r2s-plus-rk3328_defconfig      | 2 +-
> >  configs/nanopi-r2s-rk3328_defconfig           | 2 +-
> >  configs/nanopi-r4s-rk3399_defconfig           | 2 +-
> >  configs/nanopi-r5c-rk3568_defconfig           | 2 +-
> >  configs/nanopi-r5s-rk3568_defconfig           | 2 +-
> >  configs/nanopi-r6c-rk3588s_defconfig          | 2 +-
> >  configs/nanopi-r6s-rk3588s_defconfig          | 2 +-
> >  configs/neu2-io-rv1126_defconfig              | 2 +-
> >  configs/neu6a-io-rk3588_defconfig             | 2 +-
> >  configs/neu6b-io-rk3588_defconfig             | 2 +-
> >  configs/nova-rk3588s_defconfig                | 2 +-
> >  configs/odroid-go2_defconfig                  | 2 +-
> >  configs/odroid-m1-rk3568_defconfig            | 2 +-
> >  configs/odroid-m1s-rk3566_defconfig           | 2 +-
> >  configs/odroid-m2-rk3588s_defconfig           | 2 +-
> >  configs/orangepi-3b-rk3566_defconfig          | 2 +-
> >  configs/orangepi-5-plus-rk3588_defconfig      | 2 +-
> >  configs/orangepi-5-rk3588s_defconfig          | 2 +-
> >  configs/orangepi-r1-plus-lts-rk3328_defconfig | 2 +-
> >  configs/orangepi-r1-plus-rk3328_defconfig     | 2 +-
> >  configs/orangepi-rk3399_defconfig             | 2 +-
> >  configs/phycore-rk3288_defconfig              | 2 +-
> >  configs/pinebook-pro-rk3399_defconfig         | 2 +-
> >  configs/pinephone-pro-rk3399_defconfig        | 2 +-
> >  configs/pinetab2-rk3566_defconfig             | 2 +-
> >  configs/popmetal-rk3288_defconfig             | 2 +-
> >  configs/powkiddy-x55-rk3566_defconfig         | 2 +-
> >  configs/puma-rk3399_defconfig                 | 2 +-
> >  configs/px30-core-ctouch2-of10-px30_defconfig | 2 +-
> >  configs/px30-core-ctouch2-px30_defconfig      | 2 +-
> >  configs/px30-core-edimm2.2-px30_defconfig     | 2 +-
> >  configs/qnap-ts433-rk3568_defconfig           | 2 +-
> >  configs/quartz64-a-rk3566_defconfig           | 2 +-
> >  configs/quartz64-b-rk3566_defconfig           | 2 +-
> >  configs/quartzpro64-rk3588_defconfig          | 2 +-
> >  configs/radxa-cm3-io-rk3566_defconfig         | 2 +-
> >  configs/radxa-e25-rk3568_defconfig            | 2 +-
> >  configs/radxa-zero-3-rk3566_defconfig         | 2 +-
> >  configs/roc-cc-rk3308_defconfig               | 2 +-
> >  configs/roc-cc-rk3328_defconfig               | 2 +-
> >  configs/roc-pc-mezzanine-rk3399_defconfig     | 2 +-
> >  configs/roc-pc-rk3399_defconfig               | 2 +-
> >  configs/rock-3a-rk3568_defconfig              | 2 +-
> >  configs/rock-3b-rk3568_defconfig              | 2 +-
> >  configs/rock-3c-rk3566_defconfig              | 2 +-
> >  configs/rock-4c-plus-rk3399_defconfig         | 2 +-
> >  configs/rock-4se-rk3399_defconfig             | 2 +-
> >  configs/rock-5-itx-rk3588_defconfig           | 2 +-
> >  configs/rock-pi-4-rk3399_defconfig            | 2 +-
> >  configs/rock-pi-4c-rk3399_defconfig           | 2 +-
> >  configs/rock-pi-e-rk3328_defconfig            | 2 +-
> >  configs/rock-pi-e-v3-rk3328_defconfig         | 2 +-
> >  configs/rock-pi-n10-rk3399pro_defconfig       | 2 +-
> >  configs/rock-pi-n8-rk3288_defconfig           | 2 +-
> >  configs/rock-pi-s-rk3308_defconfig            | 2 +-
> >  configs/rock-s0-rk3308_defconfig              | 2 +-
> >  configs/rock2_defconfig                       | 2 +-
> >  configs/rock5a-rk3588s_defconfig              | 2 +-
> >  configs/rock5b-rk3588_defconfig               | 2 +-
> >  configs/rock64-rk3328_defconfig               | 2 +-
> >  configs/rock960-rk3399_defconfig              | 2 +-
> >  configs/rock_defconfig                        | 2 +-
> >  configs/rockpro64-rk3399_defconfig            | 2 +-
> >  configs/sige7-rk3588_defconfig                | 2 +-
> >  configs/sonoff-ihost-rv1126_defconfig         | 2 +-
> >  configs/soquartz-blade-rk3566_defconfig       | 2 +-
> >  configs/soquartz-cm4-rk3566_defconfig         | 2 +-
> >  configs/soquartz-model-a-rk3566_defconfig     | 2 +-
> >  configs/tiger-rk3588_defconfig                | 2 +-
> >  configs/tinker-rk3288_defconfig               | 2 +-
> >  configs/tinker-s-rk3288_defconfig             | 2 +-
> >  configs/toybrick-rk3588_defconfig             | 2 +-
> >  configs/turing-rk1-rk3588_defconfig           | 2 +-
> >  configs/vyasa-rk3288_defconfig                | 2 +-
> >  121 files changed, 122 insertions(+), 120 deletions(-)
> >
> > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> > index 67cb2c3d165..6871260574d 100644
> > --- a/arch/arm/dts/rockchip-u-boot.dtsi
> > +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> > @@ -209,6 +209,7 @@
> >       simple-bin {
> >               filename = "u-boot-rockchip.bin";
> >               pad-byte = <0xff>;
> > +             skip-at-start = <0x8000>;
> >
> >               mkimage {
> >                       filename = "idbloader.img";
> > @@ -244,6 +245,7 @@
> >       simple-bin-spi {
> >               filename = "u-boot-rockchip-spi.bin";
> >               pad-byte = <0xff>;
> > +             skip-at-start = <0x8000>;
>
> This is not correct, as stated in the documentation [1]:
>
>   Write u-boot-rockchip-spi.bin to offset 0 of SPI flash.
>
> [1] https://docs.u-boot.org/en/latest/board/rockchip/rockchip.html#spi

OK, thanks, will fix.

>
> Regards,
> Jonas
>
> >
> >               mkimage {
> >                       filename = "idbloader-spi.img";
>
> [snip]

Regards,
Simon
