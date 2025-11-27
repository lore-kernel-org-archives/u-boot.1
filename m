Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9EED11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 13:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80BC38439C;
	Thu, 27 Nov 2025 14:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QRQ5cp3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48699843AF; Thu, 27 Nov 2025 14:01:22 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C49A28438A
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 14:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-640b0639dabso1506902a12.3
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 05:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764248479; x=1764853279; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sbzlwyx5vWZwHDSTfaY5mgV4B5vXP4roTU9PY74N2QI=;
 b=QRQ5cp3lLrPZL4GTvWEv75dn1mVo4rnpcZlTXwz1FneSJEDCpshk0a0pj33rW/FHWA
 +XI7JxXxjI9JZhBw5GWurXXVDkynnYOGXze4fIR/3nKR9TJDmnOcj0VvbzbIf8Rak7Zq
 wCMjJZwPsJzYB7XeNOzBqBhQ0XrXxQy60wG7JIRBkWgd9vhV4Gc74XUofrtISjKKkie0
 wJcUH+uL9tGDQWZLsLS8alTfiJNjiiOaLayJ6T5r/2A8puBp1i9th4fkZjPjEcEi7wRG
 /WOe6i1AHXALQyf7pugzEo2jJLnbadXGittOKYlnAyREvKoGBd3eF6kbiL8d0MslA9L/
 RaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764248479; x=1764853279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sbzlwyx5vWZwHDSTfaY5mgV4B5vXP4roTU9PY74N2QI=;
 b=Wq2qZnw/GuA1JbIqf+uxMhj2Y5xYmalpaxFrs9izdqk3BvVxiU+e9iPhu0uWQ76zBN
 5OGlWvvi+FaLK5prRkhrme0QaSy2papnlD7/rwMnHbrEIXD5/dWaJJu9PGkzCAmc6LnH
 kMMm1AaIygG8xCQD4bHo90k5lHmVFQTVHQhZhKJYRicMBr04YVCIwh5M2ijlW7gffvPb
 qRKe11q9KYoc7m30i7/BR7eHEzUmbCiCHIw8ae90KfcEBJ2P7ya1BGyjKq9d+LjNbtm8
 wnT+cmlEkgu8wSI37kEBX5D/qNdP0w01y+2MADrjG/HQQMbESwpPtzoTd/fBa8iGpiS+
 8rrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/stZR7eUHpsYNoEHKu7QeVr3s1IYe2UzzjeZjlRXDgz2J9B0rCjrtf8tZxrqKccanwKnuZEY=@lists.denx.de
X-Gm-Message-State: AOJu0YzsQQQ6Uz9XFK49hPVcKZwY4EzIp3xQZEmnN07OPNF2oOfX+pvF
 zCWx34blmN8Gj7r21o/qBy5NMks0rA97vMxl0U8DUmIr87WiCV+YK3fKWK8MfsCW5viD7XhahzA
 bo5DvOLzziHkCQDGIxzAW77NS4Gkr6y8=
X-Gm-Gg: ASbGnctOIYih7MKVWlxW2lY3Z/vC/4AJQ3V/jYRf4ltaVrISn/fhzyY6diiFr1qRpn2
 Vs6BuLHfyQa9Kac1ApwTu92KrGIICTQesybOCTxOmOu62HcWTlMO/cRdUQpys5O56MeY0o+4Mm2
 4sb3XSzlFF3Kt7Oefk8a0RmkNOsmBbomdpeVqQ+QWfFoIWyQlpJJedvwfCIxocAB8wl9v1BN+8u
 CD7WxHX0y5JownrplRv60Cms2+15pT2V51IbbfD1HPAlvCtnrmZe9kDaZdFv+jHxzjfqg==
X-Google-Smtp-Source: AGHT+IFNDA1mPaSSiiiaBKJzgadUseNdH3wOQ448ZuOq6L0AA8obuzgJSjxxp8Sfdymrrt82v/ANyGgKWz+dhzJnUpc=
X-Received: by 2002:a05:6402:50d2:b0:641:3d64:b120 with SMTP id
 4fb4d7f45d1cf-64554674f26mr21523371a12.18.1764248478650; Thu, 27 Nov 2025
 05:01:18 -0800 (PST)
MIME-Version: 1.0
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
In-Reply-To: <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 27 Nov 2025 18:31:01 +0530
X-Gm-Features: AWmQ_bnjVKkh9bdI5LUsWHyj2VR8cqTb7ld_GQRSKnu6LmK1Tv7mcmebo7QVK3o
Message-ID: <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>, 
 Heiko Stuebner <heiko@sntech.de>
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

Hi Quentin,

On Thu, 27 Nov 2025 at 16:24, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> On 11/27/25 11:35 AM, Quentin Schulz wrote:
> > Hi Heinrich,
> >
> > On 11/26/25 5:46 PM, Heinrich Schuchardt wrote:
> >> On 11/26/25 16:00, Quentin Schulz wrote:
> >>> Hi Heinrich,
> >>>
> >>> On 11/25/25 7:02 PM, Heinrich Schuchardt wrote:
> >>>> Hello Jagan, hello Heiko,
> >>>>
> >>>> When testing U-Boot origin/master on my Raxda Rock Pi 4A serial
> >>>> console output stops after "PMIC:  RK808". The same can be observed
> >>>> with v2025.01.
> >>>>
> >>>> The serial console works as expected if I disable
> >>>> CONFIG_ROCKCHIP_IODOMAIN.
> >>>>
> >>>
> >>> It is I believe implied here but asking for confirmation. The board
> >>> doesn't actually boot right? It's not that the serial console is
> >>> gone, it's that the device is stuck?
> >>
> >> Hello Quentin,
> >>
> >> Thank you for looking into this.
> >>
> >> The device boots I. But the serial console output becomes mute and I
> >> cannot send keystrokes via the serial console.
> >>
> >
> > Uh. That is *weird*.
> >
> >>>
> >>>> The problem seems to be specifically related to the bt656-supply.
> >>>> Removing the line below also fixes serial console output:
> >>>>
> >>>> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/
> >>>> rockchip- io-domain.c
> >>>> index a0573c52193..b0d78f2d4b4 100644
> >>>> --- a/drivers/misc/rockchip-io-domain.c
> >>>> +++ b/drivers/misc/rockchip-io-domain.c
> >>>> @@ -239,7 +239,7 @@ static const struct rockchip_iodomain_soc_data
> >>>> soc_data_rk3328 = {
> >>>>   static const struct rockchip_iodomain_soc_data soc_data_rk3399 = {
> >>>>          .grf_offset = 0xe640,
> >>>>          .supply_names = {
> >>>> -               "bt656-supply",         /* APIO2_VDD */
> >
> > Reading the code and this diff again, this you shouldn't do at all. The
> > offset in the array is the bit offset for the IO domain setting in the
> > GRF at offset 0xe640. So by removing this line, you configured APIO2 IO
> > domain with APIO5 settings (audio-supply).
> >
> > It would be better to write NULL instead, so that the others are tried
> > and we can pinpoint the faulty one.
> >
> >>>>
> >>>
> >>> The UART2 (which I assume is the serial you're using for the console)
> >>> isn't on that IO domain. And there doesn't seem to be anything
> >>> important to booting on APIO2 domain according to Rock 4A schematics[1].
> >>>
> >>> bt656-supply also doesn't seem to be anything special. LDO5 (vcc_3v0)
> >>> on RK808, which is using VCC10 (vcc10-supply) which is a fixed
> >>> regulator whose parent supply is also a fixed regulator. So I am not
> >>> sure what could be going wrong there.
> >>
> >> In the schema LD05 on the RK808 is connected to VCC_1V5.
> >>
> >
> > Sorry, I meant to say LDO8.
> >
> >> With any of the following values I can enter commands via serial
> >> console but still get no output. So none of the voltages seems to be
> >> the correct one.
> >>
> >> diff --git a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi b/
> >> dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
> >> index 046dbe32901..f15b5b63815 100644
> >> --- a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
> >> +++ b/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
> >> @@ -517,7 +517,7 @@
> >>
> >>   &io_domains {
> >>          audio-supply = <&vcca1v8_codec>;
> >> -       bt656-supply = <&vcc_3v0>;
> >> +       bt656-supply = <&vcc_1v5>;
> >> or
> >> +       bt656-supply = <&vcc_0v9>;
> >> or
> >> +       bt656-supply = <&vcc_1v8>;
> >>
> >>>
> >>> RK3399 Puma and RockPro64 have APIO2 set to 1.8V vs 3.0V for Radxa
> >>> Rock 4A. Puma boots master reaches U-Boot CLI with the IO domain
> >>> driver compiled in.
> >>>
> >>> Can you check the error paths (all the ones with a continue;) in
> >>> rockchip_iodomain_probe()? Which ones do you enter for which supply?
> >>>
> >>> Not sure where to start debugging tbh.
> >>
> >> I found the driver by setting CONFIG_LOG=y and log level 7.
> >>
> >> Here is how the console output ends. Do you have access to a board or
> >> do you need further debug output?
> >>
> >> ofnode_find_subnode: regulator-state-mem: regulator-state-mem:
> >> regulator-state-mem
> >> regulator-state-mem
> >> ofnode_read_bool: regulator-off-in-suspend: true
> >> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index:
> >> regulator-suspend-microvolt: (not found)
> >> ofnode_read_prop: assigned-clock-rates: <not found>
> >> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index:
> >> regulator-min-microvolt: (not found)
> >> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index:
> >> regulator-max-microvolt: (not found)
> >> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index:
> >> regulator-init-microvolt: (not found)
> >> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index:
> >> regulator-min-microamp: (not found)
> >> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index:
> >> regulator-max-microamp: (not found)
> >> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index:
> >> regulator-ramp-delay: (not found)
> >> ofnode_read_bool: regulator-force-boot-off: false
> >> ofnode_find_subnode: regulator-state-mem: regulator-state-mem:
> >> regulator-state-mem
> >> regulator-state-mem
> >> ofnode_read_bool: regulator-off-in-suspend: true
> >> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index:
> >> regulator-suspend-microvolt: (not found)
> >> ofnode_read_prop: assigned-clock-rates: <not found>
> >> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index:
> >> regulator-min-microvolt: (not found)
> >> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index:
> >> regulator-max-microvolt: (not found)
> >> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index:
> >> regulator-init-microvolt: (not found)
> >> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index:
> >> regulator-min-microamp: (not found)
> >> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index:
> >> regulator-max-microamp: (not found)
> >> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index:
> >> regulator-ramp-delay: (not found)
> >> ofnode_read_bool: regulator-force-boot-off: false
> >> ofnode_find_subnode: regulator-state-mem: regulator-state-mem:
> >> regulator-state-mem
> >> regulator-state-mem
> >> ofnode_read_bool: regulator-off-in-suspend: true
> >> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index:
> >> regulator-suspend-microvolt: (not found)
> >> ofnode_read_prop: assigned-clock-rates: <not found>
> >> ofnode_read_prop: assigned-clock-rates: <not found>
> >> ofnode_read_u32_index: bt656-supply: of_read_u32_index: bt656-supply:
> >> 0x7a (122)
> >> rockchip_iodomain io-domains: bt656-supply: Regulator LDO_REG8 at
> >> 3000000 uV
> >> ofnode_read_u32_index: audio-supply: of_read_u32_index: audio-supply:
> >> 0x91 (145)
> >> rockchip_iodomain io-domains: audio-supply: Regulator LDO_REG1 at
> >> 1800000 uV
> >> ofnode_read_u32_index: sdmmc-supply: of_read_u32_@L@@p0b@HHb```Hp0 p0   $
> >>
> >
> > This seems to highlight the issue is rather audio-supply.
> >
> > And indeed, audio-supply should be vcc_3v0 and not vcca1v8_codec.
> >
>
> Mmmmmm, upstream kernel has 8240e87f16d1 ("arm64: dts: rockchip: fix
> audio-supply for Rock Pi 4"). So it seems it "fixed" something.
>
> So before I send a revert to the kernel and start an endless thread, can
> you test locally that the following indeed fixes it?
>
> diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> index 4861574636e..dccc469a507 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> @@ -14,6 +14,10 @@
>         };
>   };
>
> +&io_domains {
> +       audio-supply = <&vcc_3v0>;
> +};
> +
>   &sdhci {
>         cap-mmc-highspeed;
>         mmc-ddr-1_8v;
>
Thanks. I am having the same issue with my Radxa Rock Pi 4 B Plus.

But I am booting from SPI flash, so I cannot stop this board in the
U-Boot prompt.

Is there any other way to flash the SPI flash u-boot-rockchip-spi.bin image
in the user space to spi flash? using dd coammnd

From the schematics, it has W25Q64FWZPIG

[1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf

I have tried to enable SPI flash, but it is not getting detected on
the board in userspace.

$ git diff arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
index 9c741d1a3047..d18b59ddaa1d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
@@ -42,6 +42,16 @@ &sound {
        hp-det-gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
 };

+&spi1 {
+       status = "okay";
+
+       flash@0 {
+               compatible = "winbond,w25q64", "jedec,spi-nor";
+               reg = <0>;
+               spi-max-frequency = <108000000>;
+       };
+};
+
 &uart0 {
        status = "okay";

Can you share some input on how to resolve this issue?

>
> Cheers,
> Quentin

Thanks
-Anand
