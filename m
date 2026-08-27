Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED85C61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 13:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5B2C6079B;
	Thu, 27 Aug 2026 13:30:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9yVVi6x24epP; Thu, 27 Aug 2026 13:30:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787837434;
	bh=lmwE5Q+XeaCbgVe3oF/lvIN3X3AktY5mGh0UqJGUrMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YbROU0JDCIvpZYD2Pty4gUL67LCRFBdroYWNc6JaQcmq1KtiOiMKhNoUqRv9w8WR2
	 TjD+JDAaBQ+g53SzHyDQ6Kv1JGLZtxHsIwlmEwdUHbEQ+3fgqUhswlLCmshr83Dqe8
	 waMrwsVXYG2/uHbQ111qrahmQ5UCTbjO28WtLk90V+Ftczd5nUeaWHD7ZHccYZI2ln
	 8sub79gvRHgEP+GV6lyLSHOdxhWwajFc2UgAMYSLGjHgNQBgjUn/OpFz0yi8JQBVGW
	 EAYK4CqGjyYTOOfsY9V4dGcqCvOssu4nLH5JIyDXZ4ANlhvVsOq40elDx9k7gY+Wj+
	 tmPcu6WW3BH3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDB9060792;
	Thu, 27 Aug 2026 13:30:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 02C2839E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8D0A40308
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:30:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GmwdE46NlUDl for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 13:30:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a30; helo=mail-vk1-xa30.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=asmBaHrd
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81A4F40304
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:30:29 +0000 (UTC)
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5bf94664327so1240007e0c.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787837428; x=1788442228;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lmwE5Q+XeaCbgVe3oF/lvIN3X3AktY5mGh0UqJGUrMQ=;
 b=asmBaHrd0YxE89buzl+hQd5eSYLDm8mMjBAKT6UYp9hFtqP5kNlFYnFNjagcuJ284Z
 Ip9Y1zkCyL3mEYHmM+0wtFt13d3fQE7kNVip6GLAYBWMz+d0pwqKHbNw371BR69wCKvf
 AXEQsFIzEY29fJ745pjzfS055f4mFU6wymHFKvHKHYSTQSSwhLxKnPtF01Ele2tYGKHB
 IXTzGwQp47kHZpvOdKsoeq5BaXad6b3XewAtokdMyrzYNgvQ7x/KZonpAqtbCgLcKSS2
 m/89bcfFQ6QQCZh4uSwLUKPWs227MBMxSwNXGFbRykKnpagniV3BGgrhbJ3LzXc3DIPX
 1GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787837428; x=1788442228;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lmwE5Q+XeaCbgVe3oF/lvIN3X3AktY5mGh0UqJGUrMQ=;
 b=izdcNtDlK3HpiipX20IFuAwNm9cd2j3QBzM0oxFo2eLsHvtgzutWOIwaHVjRs0M/Uq
 XfpIXoIMP2AMswqYkV/YV7P2a5twWIHf82CfyOWgvpqzFlUYtu+CMOEzYZSzUYjMVkaE
 U8wMrSLor0BifDgpJ/J8ad8bA+z/TuYkVC745tnj7ork8YPPEEmgUifC773JobhWYSkk
 F0L0UP4r5834htinnAzXT0Hb6khIUDJ/kMEPIX0zvKETAOV+7p3pq+Qmv0A9ntxzzyWp
 M6P0hacnMPbmEPFzhuIxFBV1lnr7ZoTjD1mEdzxotG8nJV6JvXjup/Ad5eEIsLMhPn1V
 sDtg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhMi9z/1ceWcDRCkqFosmo7ojgP+t8O6GT75MAHFJfkdEEK2VOOkWhB2ZWHO9e+t9pI0kpY6s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++na5L4iHwEKf/QchvypnF3YImg1N6BkznUTkEnSw5uwrJMhuwt4
 wm5mOfmxrP7j02tQUuDfq9m5SYYp1REuFeK9b3y5nfIqfJhPWa6VXUrismQ8ZMk7cGA=
X-Gm-Gg: AR+sD10IJtd0ete4qCX69wAx0sJeFVsCoIKUH2ENxmrUy52naknAkhNwvDBTpQSlt8p
 UV8GxG0lywuXiwxosL9Aw0pFakxyP/xyGGFyLU3iWNSGgqO0vlMJHvUGgDR5zdEP9FnEVW2huyP
 xow6AzcV8fl8roj/A01GBbdTW1Nv7SXtWHEXJ/KjLEdOq/y28rRZIDNp4B3phcZcUZ4IzFBDh9O
 o0puW/PhZ90r6+9I7tQ2OR1M8hlKHUPRywCsIskWBi410kbKF7V6u8euSqOzTdj2krfy9JE2A+j
 9TJgZ+Xk+GbiH1SWCVeZWNF9kj3Zryx9YwbYc4VfsHksBhPIcNVVU/Vvrxg/0PLAmGmzSsvHabe
 UWq81uThL6YQmW7fNPKDylMXS8mXUYLS7rbHmzm9y+38yr5Bjy8Lu+U+D3g77A+NNCmJPpXMHE7
 6vChv+w4EEvS8H7LkStN6waYP3WbfJgq72TVP3QvRQus1q+a7dvfQQKho61gXcWdqGGPUgzKxcj
 5fAOnNGf6il7O51nFLKusON
X-Received: by 2002:a05:6122:3285:b0:5c6:4d41:e99f with SMTP id
 71dfb90a1353d-5c65c3d9e40mr5422083e0c.5.1787837428203; 
 Thu, 27 Aug 2026 06:30:28 -0700 (PDT)
Received: from hiagonb ([2804:14c:4c5:9534::f35c])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c65fe7bd68sm3653555e0c.5.2026.08.27.06.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 06:30:27 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:30:23 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Andrei Lalaev <andrey.lalaev@gmail.com>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/2] board: sophgo: add support for Milk-V Duo 256M
Message-ID: <apA3hSs_P_NYkOCM@hiagonb>
References: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
 <20260822091510.3253162-1-andrey.lalaev@gmail.com>
 <ao2Iqsq-Xp4dQK4c@hiagonb>
 <e3ac37d0-be2a-470a-aaa1-0cdcb3b7b45b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3ac37d0-be2a-470a-aaa1-0cdcb3b7b45b@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Andrei,

On Tue, Aug 25, 2026 at 08:01:37PM +0200, Andrei Lalaev wrote:
> On 25.08.26 14:24, Hiago De Franco wrote:
> > Hi Andrei,
> > 
> > On Sat, Aug 22, 2026 at 11:15:10AM +0200, Andrei Lalaev wrote:
> >> Hi Hiago,
> >>
> >> Thank you for the patches.
> >>
> >> From your cover letter I understood that SD card is supported.
> >> However whatever I try, I always get the following error:
> >>
> >>     U-Boot 2026.07-00002-gbd5e3de2ed6a (Aug 22 2026 - 10:27:48 +0200)milkv_duo_256m
> >>
> >>     DRAM:  256 MiB
> >>     Core:  20 devices, 13 uclasses, devicetree: separate
> >>     MMC:   mmc@4310000: 0
> >>     Loading Environment from nowhere... OK
> >>     In:    serial@4140000
> >>     Out:   serial@4140000
> >>     Err:   serial@4140000
> >>     Net:
> >>     Warning: ethernet@4070000 (eth0) using random MAC address - 16:21:8c:10:cd:96
> >>     eth0: ethernet@4070000
> >>     Hit any key to stop autoboot: 0
> >>     milkv_duo_256m# mmc info
> >>     Card did not respond to voltage select! : -110
> >>     milkv_duo_256m# mmc rescan
> >>     Card did not respond to voltage select! : -110
> >>
> >>
> >> I tried 2 different SD cards and got the same result.
> >>
> >> Am I doing something wrong, or is there something else I need to configure?
> > 
> > You are most likely missing this patch:
> > 
> > https://lore.kernel.org/all/20260507234836.284918-1-hfranco@baylibre.com/
> > 
> > This is needed in order to make the SD card work. This patch is already
> > merged on main branch, as commit 3a4a8963aace ("mmc: cv1800b_sdhci:
> > honor 'no-1-8-v' DT property").
> > 
> > Check this patch and let me know if it works now ;)
> 
> Thank you for your response:)
> 
> I also tried the latest main branch (so all patches are definitely included)
> and had the same problem.
> 
> I guess I somehow managed to fix the problem, so below I'll describe what I did
> and would like to hear your thoughts about it.
> 
> 
> When I generated `fip.bin` using precompiled binaries from fiptool repo [1],
> it started working most of the time. Previously I was using an FSBL manually generated
> using official SDK [2]. However, I would still occasionally get
> voltage select error and timeouts.
> 
> So I started comparing FSBL and U-boot from Sophgo (2021.10) and
> I couldn't find any differences that could explain this behaviour.
> 
> Today I found out that the kernel DTS configures the SD0_CLK pin to a different value [3].
> By default, we have 0x48 in IOBLK_G10_REG_SD0_CLK register, but if I set it to 0x84
> like kernel does, it magically starts to work all the time.
> 
> I understand why increasing the drive strength fixed timeout issues, but I don't understand
> why I don't see the same problem with the U-Boot from Sophgo (2021.10).
> 
> 1 - https://github.com/sophgo/fiptool
> 2 - https://github.com/milkv-duo/duo-buildroot-sdk-v2/tree/main
> 3 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/boot/dts/sophgo/sg2002-milkv-duo256m.dts#n68

Thanks for digging into this.

I made some tests here on my milkv-duo 256M and I might have the answer
you are looking for, hopefully.

0x48 is SoC reset value, based on the TRM. This is what I read on my
U-Boot (main branch, like yours):

0x03001a00 SD0_CLK = 0x48 pull-down, 10800 uA  <-- reset value

So on my board the BootROM already does everything Sophgo's
cvi_sdio0_pad_setting() does. SD0_CLK is the single register nobody
programs, exactly as you found. I also checked the FSBL and it never
touches SD0 and never touches drive strength, from what I could see.

I am not able to reproduce your issue, it works every time for me. I
suspect there is a difference on the hardware here: maybe your board has
less margin for the drive strength than mine, it works at the stock
50MHz even with the CLK drive strength at its minimum.

To trigger the issue, I had to force SDHCI divider from N=4 to N=2, so
doubling the clock. With that, I triggered your issue. Of course I am
not sure if this is the same issue that is triggering your, but at least
now with the double clock I was able to increase the drive strength by
writing 0x84 (the kernel value) and it fixed the issue (which makes
sense).

I was not able to properly answer the reason why Sophgo U-Boot works, so
I used Claude to look at the code for me and compare the differences,
here is what it found out:

"It is the PHY. cvi_sdhci_set_ios_post() has a DS/HS branch that does:

    PHY_CONFIG    (0x24c) |= BIT(0)          /* TX_BPS */
    PHY_TX_RX_DLY (0x240)  = 0x01000100

The kernel does the same thing, unconditionally, in
cv18xx_sdhci_reset() (drivers/mmc/host/sdhci-of-dwcmshc.c):

    val |= CV18XX_PHY_TX_BPS;                     /* PHY_CONFIG bit 0 */
    val = TX_DLY(0) | TX_SRC(INVERT_CLK_TX)
        | RX_DLY(0) | RX_SRC(INVERT_RX_CLK);      /* == 0x01000100 */

Upstream U-Boot does neither. cv1800b_sdhci.c only writes
SDHCI_PHY_TX_RX_DLY from cv1800b_execute_tuning(), reached only through
platform_execute_tuning - and that never runs on this board, because
no-1-8-v caps us at High Speed 50MHz / 3.3V and tuning only happens in
UHS modes."

I am not 100% convinced by that, but I will take a look, we might need a
patch here on upstream to configure the PHY properly as the downstream
u-boot and kernel does. Anyway, is funny that I can only reproduce your
issue on this conditions, but these boards might not be something we can
blindly trust ;)

Could you dump these on your board, at the U-Boot prompt on unmodified
upstream main, before touching anything?

    md.l 0x03001a00 8      # SD0_CLK / CMD / D0-D3 pad config
    md.l 0x03001900 4      # SD0_CD, SD0_PWR_EN
    md.l 0x030001f4 1      # sd_pwrsw_ctrl
    md.l 0x0300101c 8      # SD0 pin mux
    md.l 0x04310240 1      # PHY_TX_RX_DLY
    md.l 0x0431024c 1      # PHY_CONFIG

Meanwhile I will be able to investigate this further in a couple of
days.

> 
> >>
> >>
> >> Best regards,
> >> Andrei Lalaev
> > 
> > Regards,
> > Hiago.
> 
> 
> -- 
> Best regards,
> Andrei Lalaev

Regards,
Hiago.
