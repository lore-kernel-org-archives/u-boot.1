Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029F1E8B386
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 00:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C654583E63;
	Wed,  4 Feb 2026 01:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jN26jxDD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4074F83BC7; Wed,  4 Feb 2026 01:23:04 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 232AD83E48
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b8871718b00so1065170266b.3
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 16:23:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164580; cv=none;
 d=google.com; s=arc-20240605;
 b=DFqSkjR+/cM1CC432TSNr3fyeLJdsP71BkdCyXOM+plkwfs2Dohc3139LsesNga3+R
 GXvVYFE33EKfBZwuW3gRWUdZVGwlKTTdjpgL/qZwhZUlZ2TdfVte8RdIF1bUhsbPrPas
 5EeqlKlma/i+1tEv1ExOz/uiARoUjE0pQ/rR6knVhayr+tpGcYE7To3Ulxy3mOSAVkaL
 nTPtB4AptnWtydGBlYfyrn+mwnKMcfF6r7xiccG2Bm6bkxoW/bnd+r2jHpBNsZZjco8b
 CkbKPmJ2Jps5Shh9tkaJdR5cC+xVCteYuLVEFAFDBq5nyqIDV9yjhOtu0ltVVKUBaPvY
 WWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AXreGsgfdAyNb3pU8dq48K2UjFuLatFRPIlz3J3xYFY=;
 fh=jqt9JMp+v4MWTifdk6dKphd8aNcKwAuxbmthys6m9iw=;
 b=bmdRZ9RZZpD8TH7wnvTo5R9dDOVAZLLF61f2rl2tUtz1Rpk2ciTTFLYhxejhkKs+Xz
 23EM+wpTjIiVRxfYbPC5ZCJ7OhO+5mhgjmvZ37262aPOQ9NSzPvJ5dL08Ohe9+SZQ+pF
 4ltJm6Bpqodg8N/jumDOhVuFpieOwsMa0sHUVFmFBGg4NUAv3Fgm0BkSf0s8uDbdSOwE
 X+M3vV75NqmAo9t8fcminTjhnr31+2ydV5VF6I5jWBEzPxhg6ZqFOjjKLsCLmimwEV0f
 QVu99PR1g0OXJz/eqo7vfbY/Zt6Eo77nUnaZuM92iWjVQVdqgMm9daJwy4rEWvI5O+Wj
 2xxA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770164580; x=1770769380; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AXreGsgfdAyNb3pU8dq48K2UjFuLatFRPIlz3J3xYFY=;
 b=jN26jxDDuA93yADsJfzoH/9MSXb4dD0cS0Q9jqU1lzVMoVT3ZKRF58jZDEQNRnBIv8
 X28qvHpKz54PYxsmimtgeh+5sm5CckHnh8g6Va6O+qRQSCj8UhL18ig60bC9rX7wl/gR
 Za/ZJ3aIrKXx6LIYgvCVlIww3kv+XN8feSQSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770164580; x=1770769380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXreGsgfdAyNb3pU8dq48K2UjFuLatFRPIlz3J3xYFY=;
 b=vm4HgC5z5aTY/9linesRBhhiStXOdMIqOJnEcTe8svLUU+GZBIzCRxUQKT7//M/A5Y
 vR6QncEqKjGy4yAOkCvGzOvCBLOWf79yUO57zVzANgi7KYQEbjpx3X5+wIP2MicL1F0q
 PRjgG6CrPcOTnyBId5Wqc5t8YxfWk6SBYWaQSdIqcEj+kFGUQHlun1TpAQPGDBV3CMfR
 i3rZQAbYIHcIEwktDT9ead0UUoixi8LSKTXL3Azf1Jj4Z7sFyhT8xP4iuxAi1mwm+8nb
 /1SZL+o1sTwuCuDhvlX0srD0oyNIKfpPi4r1YPzyKOgcXV+lufZpH/jRANBhLI7wZqBw
 B10Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4H7vbzR4YZ1t6P0BXW9vMqGWXCoAJDTz1Ul75pcDRnm/GSpEeyWm2dahc2dvcILPuGXV7Frc=@lists.denx.de
X-Gm-Message-State: AOJu0YxNwxle7UuOdpBjJpCWWppZoQcFNKJwF9rGvCibAVSmkMEukP5W
 Jw5HNRA/RW53X6mVIzRmVc1NBs9BEjN6tJLIo+2Sf9jA9kgVqS4KcrbYNyvpvteGiiz5qyZZGg/
 dw8WTF99kXMkvHua8/LKYWUGyXJz1kgOd67Yede4e
X-Gm-Gg: AZuq6aIYOst7AIglNlPRMoHhvAWXHQbBvHPWnH/T94gE0SBLSjLrJdDny89oIQKplm8
 6LRE1lZN0ykMHWULOvYoSN4UuzbGMG4zCU5JkpvKRCPwiT/GwOuZX8nowLrjtHU50HqtHjvYwwX
 MNKeU5a7ZG+FeZo8UjSkekF4sryIm04x8tmlm1uJ5IlLDOKn82L++NRmkAtsGtCzA0DynokdURD
 qaRNJ/9xGrY6Jf13SJAB+z/1r9D+cLfyeYiwDAqq8XUcMjf98Djdb2J8Cu/ukN9frmnjk2Q
X-Received: by 2002:a17:907:72c7:b0:b88:7093:3ca3 with SMTP id
 a640c23a62f3a-b8e9f04ca7dmr85563466b.23.1770164580574; Tue, 03 Feb 2026
 16:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-15-marex@denx.de>
 <f6b85cb6-509c-46a8-984e-3881374ceb02@canonical.com>
 <9dbccbf2-39a7-48a0-9d2c-79de220c07f3@canonical.com>
 <CAFLszTh7-9a7F9h+knc1CMNvm8C=gXLZhLZ+W5eJDEZ_e5pc2A@mail.gmail.com>
 <cb4bdf54-35cd-4638-8ce0-3fa9c0b5260d@freeshell.de>
In-Reply-To: <cb4bdf54-35cd-4638-8ce0-3fa9c0b5260d@freeshell.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 13:23:00 +1300
X-Gm-Features: AZwV_Qj5Ti8wk0Aws8J7hKpVqXY2QH0z97PbCgZkQ_06LGHU96rD_gI9c41Uv64
Message-ID: <CAFLszTijQe-+sxxowGUahG=rtQMJ0RHHkcfagybiPJHxA=-azQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/24] clk: clk-composite: Resolve parent clock by name
To: E Shattow <e@freeshell.de>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Marek Vasut <marex@denx.de>, 
 Hal Feng <hal.feng@starfivetech.com>, Minda Chen <minda.chen@starfivetech.com>,
 Adam Ford <aford173@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, 
 Fabio Estevam <festevam@denx.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 uboot-imx@nxp.com, u-boot@lists.denx.de
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

Hi E,

On Tue, 27 Jan 2026 at 17:36, E Shattow <e@freeshell.de> wrote:
>
> Hi Simon,
>
> On 1/26/26 18:55, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 31 Mar 2025 at 05:14, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 30.03.25 17:15, Heinrich Schuchardt wrote:
> >>> On 23.03.25 16:58, Marek Vasut wrote:
> >>>> Use clock-names property which is accessible via parent clock OF node
> >>>> to look up the parent clock by name instead of depending on unreliable
> >>>> global clock name to perform look up.
> >>>>
> >>>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>>
> >>> This patch breaks booting starfive_visionfive2_defconfig in the SPL stage.
> >>>
> >>> To dig a bit deeper I enabled the debug UART for SPL with these setting
> >>> on origin/master (5e74863ad6613df):
> >>>
> >>> CONFIG_DEBUG_UART=y
> >>> CONFIG_DEBUG_UART_NS16550=y
> >>> CONFIG_DEBUG_UART_BASE=0x10000000
> >>> CONFIG_DEBUG_UART_CLOCK=24000000
> >>> CONFIG_SPL_DEBUG_UART_BASE=0x10000000
> >>> CONFIG_DEBUG_UART_SHIFT=2
> >>>
> >>> clk_register: failed to get pll0_out device (parent of perh_root)
> >>> clk_register: failed to get pll0_out device (parent of qspi_ref_src)
> >>> clk_register: failed to get pll0_out device (parent of usb_125m)
> >>> clk_register: failed to get pll0_out device (parent of gmac_src)
> >>> clk_register: failed to get pll0_out device (parent of gmac1_gtxclk)
> >>> clk_register: failed to get pll0_out device (parent of gmac0_gtxclk)
> >>>
> >>> Marek assumes that property bootph-pre-ram might be missing for some
> >>> clocks in arch/riscv/dts/jh7110-u-boot.dtsi.
> >>
> >> This change suggested by Marek resolves the issue:
> >>
> >> diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi
> >> b/arch/riscv/dts/jh7110-u-boot.dtsi
> >> index ce7d9e16961..4ed764393bb 100644
> >> --- a/arch/riscv/dts/jh7110-u-boot.dtsi
> >> +++ b/arch/riscv/dts/jh7110-u-boot.dtsi
> >> @@ -113,3 +113,7 @@
> >>   &sys_syscon {
> >>          bootph-pre-ram;
> >>   };
> >> +
> >> +&pllclk {
> >> +       bootph-pre-ram;
> >> +};
> >
> > I just hit this as well, thanks for the post.
> >
> > However, -master still does not boot for me on vf2:
> >
> > U-Boot SPL 2026.04-rc1 (Jan 26 2026 - 19:52:48 -0700)
> > DDR version: dc2e84f0.
> > Trying to boot from MMC2
> > spl: partition error
> > Error: -38
> > SPL: Unsupported Boot Device!
> > SPL: failed to boot from all boot devices
> > ### ERROR ### Please RESET the board ###
> >
> > Regards,
> > Simon
>
> Is this to be expected? ref:
> https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html#zero-stage-bootloader
>
> The JH-7110 has enough SRAM to contain the unfiltered devicetree if you
> would like to experiment without filtering to reduce size for the SPL.
>
> Meanwhile though the uses of "sd card image" for U-Boot SPL to access
> MMC are not anymore supported; transition to instead use the remaining
> supported methods SPI Flash or UART Serial.

I'm not sure that I can make that work in my lab. I have a SPI-flash
emulator for some boards, but it requires a special probe.

What is wrong with putting U-Boot on the SD card?

Regards,
Simon
