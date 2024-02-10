Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E057CC48260
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 17:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32AB887E5F;
	Sat, 10 Feb 2024 18:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="oKysg9e+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D12C387E98; Sat, 10 Feb 2024 18:21:49 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E248287E46
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 18:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707585707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yk+coqzx57maYwaEvJ98nIt+MY/WjzjD8ILsHuGyDG4=;
 b=oKysg9e+UKwWDWiwpslcOLHhyMcZXZjLMqxRy7n5RHQnoxfQDJy06uXGOKMuaXIb1GMvbs
 jXvGhwjsRsoNBCvYYxXyyOeM/s5Bnr+kNWMUbJtq1xdFEh3O12QWQoZPbmxZ0ON5a85J7h
 3Kz3t6fcW9SVIzp2wWNkwz4Ous32BEZnzBzpUsH46rrk3UpgHFmi8WbvVuM9mEcOGpXNXN
 8DbnyYWo3lNKbC3Aif5vnTzdYKooNeCtDbJ1FoAtsHTz5xHVLdtrEv57Bpfaf0lYrX+IPm
 vvkLWG7wkv2p6rzgR/YUlqwTz14idAjQpSN8NqQSOCJPuV8+55BMIunzSGxQhQ==
Date: Sat, 10 Feb 2024 18:21:46 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Da Xue <da@lessconfused.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 13/15] rockchip: rk3328: Add support to build bootable SPI
 image
In-Reply-To: <CACdvmAjfCWicRd=LKKyob7fZo79AFkUQKy0e1HBb0zyJuoO70g@mail.gmail.com>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-14-jonas@kwiboo.se>
 <72bd1e6d81755da0300a5da9a64b7408@manjaro.org>
 <CACdvmAjfCWicRd=LKKyob7fZo79AFkUQKy0e1HBb0zyJuoO70g@mail.gmail.com>
Message-ID: <19da82ff31e09e8014c2782c1d1e537c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Da Xue,

On 2024-02-09 02:57, Da Xue wrote:
> On Wed, Feb 7, 2024 at 10:53 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-02-07 01:02, Jonas Karlman wrote:
>> > Similar to RK35xx the BootRom in RK3328 can read all data and look for
>> > idbloader at 0x8000, same as on SD and eMMC.
>> >
>> > Use the rksd format and modify the mkimage offset to generate a
>> > bootable
>> > u-boot-rockchip-spi.bin that can be written to 0x0 of SPI NOR flash.
>> >
>> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> 
>> Could you, please, clarify a bit why the "rkspi" format isn't used
>> instead of "rksd"?
> 
> "The SPI code has a bug that means that the 2 KiB blocks in which the
> bootloader is loaded have a stride of 4KiB, leaving the 2KiB inbetween
> as unused padding."
> 
> RK3399 has the 2K SPI bug and necessitated the rkspi format. RK3328
> came after RK3399 and resolved this bug so the SPI and MMC formats are
> now the same.
> 
> I verified on a ROC-RK3328-CC-V2.

Thank you very much too, for refreshing my memory.  I somehow forgot 
about
the bug that the RK3399 BROM suffers from.


>> > ---
>> >  arch/arm/dts/rk3328-u-boot.dtsi        | 11 +++++++++++
>> >  arch/arm/mach-rockchip/rk3328/rk3328.c |  1 +
>> >  2 files changed, 12 insertions(+)
>> >
>> > diff --git a/arch/arm/dts/rk3328-u-boot.dtsi
>> > b/arch/arm/dts/rk3328-u-boot.dtsi
>> > index b90d78878d77..2a5dca97dd4b 100644
>> > --- a/arch/arm/dts/rk3328-u-boot.dtsi
>> > +++ b/arch/arm/dts/rk3328-u-boot.dtsi
>> > @@ -120,3 +120,14 @@
>> >  &usb20_otg {
>> >       hnp-srp-disable;
>> >  };
>> > +
>> > +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>> > +&binman {
>> > +     simple-bin-spi {
>> > +             mkimage {
>> > +                     args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
>> > +                     offset = <0x8000>;
>> > +             };
>> > +     };
>> > +};
>> > +#endif
>> > diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c
>> > b/arch/arm/mach-rockchip/rk3328/rk3328.c
>> > index b591d38fe412..b82b209de9e2 100644
>> > --- a/arch/arm/mach-rockchip/rk3328/rk3328.c
>> > +++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
>> > @@ -36,6 +36,7 @@
>> >
>> >  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>> >       [BROM_BOOTSOURCE_EMMC] = "/mmc@ff520000",
>> > +     [BROM_BOOTSOURCE_SPINOR] = "/spi@ff190000/flash@0",
>> >       [BROM_BOOTSOURCE_SD] = "/mmc@ff500000",
>> >  };
