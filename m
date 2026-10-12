Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CE6CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAAE980CEC;
	Mon, 12 Oct 2026 14:30:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WjMM4XKnzG6u; Mon, 12 Oct 2026 14:30:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9865480CF1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791815421;
	b=hkYV3e8MopBNqr+Bm3aPS+5jTyKJUwS5v0vx5CzsTZL5bZkrQLHHlZ/Mt3wPOJ7RREoA
	 LPfhLE/FMiZ/mH9Zvnyv5JmQzukh5IblLCLIx/dmBA2ReMdxGT4cOXBIMvrSSpI6BnBoO
	 W2qbZDbef6c/6OSP9FXj7eV5jMBkfLZuk7KCF8xxWsJnFn2+mXNd9lGrjvJPlWOurJ1Ym
	 4MvSNojmSNs/z8Ah26KLtThyIDDa3CJblwsMcJSD0D9uQ0wxpFxLVkxJaTc/XBA7/fom+
	 vIKMwpq4ZrrnwcXzN4LijAk1c4r+nSFPtaB0qpPn3WDiyJ1FRTp9krkj//9LdUR4VAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791815421;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KSDmT+uZZjdS4TLQjlNO3WsNSBaFiZ2hcWOfIyEMhgM=;
	b=fv9DP91PDbm1DCXeMGHjUDr4S0TAwqLqOJ9G4gJgheM/WJKOpFooBp4JQob9/k+v4y+d
	 tOYXuihRwUC30VrIXkxmwOHxnsJDqFeyquJNFVy2Z4WxMuX99yHDbKSDKFEsTs5nw3VIE
	 6QX+mhkEnHZlJtsVp9xXluBbv0KJHuc6sJLBCD8UEw0DfiSEL1oP1XbJCdHKnzCrMTpRI
	 3kYdnfV7AUzMJaRI4KFMqcfXBrE6StDjDD1WT/Hl9KHJEF9y901PHhjXC2dRz6tFB2HmF
	 5Z1qYi62WZhOcEDhzXbaklA/sneVg6q20iJvNZSoFIYs2YdNwX+6UDPLIkmC586dgPA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791815421;
	bh=KSDmT+uZZjdS4TLQjlNO3WsNSBaFiZ2hcWOfIyEMhgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lwEyrXos07muRrjUUgdog92dfU9KOU3A+zUqyH9BHTML+i7oUMOOUNq0+qj/LPkA2
	 E1SG4+Tow8ATyELL48Kx3PRrgnLFUek1YPi/Ble1Ahh4MbQBH4F+v0MChwQBHqIhIT
	 bv+UiWsDY7A6lxMGUv1zljfHfMRdmLsuSW4j8N5cscKvhzRbT+mv1gSbCYg+rIUao+
	 rlPN2bcyMg/EDwMBFoFngMu0UNFAmpV4GCX7f3kOqO2BBDGYwBlJLoMD3aJljQeiG1
	 f9hjgmoTmcpilE/prQENQIqS2jzQVno2gx3ZcojD9e2QVgns9q+l4n/YX3fAmdj9Ge
	 4IGToOIuGipUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9865480CF1;
	Mon, 12 Oct 2026 14:30:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 64321380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55ABA4004D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:30:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VJauRtg2pQ5s for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:30:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6964740057
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791815418;
 b=jpSj4LcyXYxBYs5XQHV44NVleez1f1uawF+71xyypr5vgnhWCkd9qJ9tjJMIHzNr5xKs
 +zjc6WIrUgI+LzHLkd/9FHUlvH7AeY1JOd1UlUSypuj66+Uq8MtyrdYwQTm73f4iJG2b+
 tqd9dbwzM6A6z/m9lUdHQfR8ky/e23UUoSAyTUbDzAROfdz5G7E/CovNAUQfFxvX2lgzc
 QeYRXPY5V3CGBnDQIs3NBNlCGeb76pxwfwQ+Q7bFWIcIfRCwbb3JeF0RjTM+SUKvBYYqM
 imvkVmfNnIeCfo1FjIZ7p+JZtRqxUw2d9Gm1qebJBmSUKtZcsJwTZNG68sp/gHScWyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791815418;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=KSDmT+uZZjdS4TLQjlNO3WsNSBaFiZ2hcWOfIyEMhgM=;
 b=iHM5DeSVhU8MCU2ngg/fRKQ1oGGijGkMYG7kGgR8bFFcDU1tM/bbpz906gfB4kvG553a
 gh4u6YrNmx0FpHWPGohdL5dGDnldShKT0JXSi4wJXw1045TIymjhSqT3D6HKm5/tXtBNf
 tqKT1kwkIGnG6SZHLreUjjiX60VWMK0VhEaH4hgsEE08xFy0wytGbPpT4NgKyKlvvjbIB
 SFMpqaWUMB11HV51F/+cCcp34UYJQICUvB3YiCDFvbGOf2vk6IB+XLsL7fooQyOtrMFq8
 tF6UdbyeeA9vaSE6Ep5ClouBDA5nRINcuI5SRqA+1Laq/JuBwgHm9I2B9KQsxfG3y3g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dTEESfXR; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dTEESfXR
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6964740057
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:30:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87CD743FF1;
 Mon, 12 Oct 2026 14:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45821F0089B;
 Mon, 12 Oct 2026 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791815417;
 bh=KSDmT+uZZjdS4TLQjlNO3WsNSBaFiZ2hcWOfIyEMhgM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dTEESfXRZJZMky0OJONxCO+VQ1i3l4snO+coV4R/EbZjyjsKvAqdyFqkCEJN1zxnx
 c4MQrwziMCl9X9Bcz2VUcRjlWXT8wV9lzsrx7hCoJ2268HQoQj7typa7Kl+0euNR6J
 h6A4NoFcfUCbqzroJ/uAUubpwn/+6FCMGwN8aZAUaDqs6THXFESJo/eW5FqdDtZSYO
 3Iql4/eDw6ueScDctfmf4Wr35zGcvdDstciDqtIVnmRx1PjvazyImJdMH90GYJgUFQ
 4Jbh13LVOSKLKSVVDrPS2o2zm4nqlRz5PlD/H3gY3/ou1p/HXWssDJo8MWiDEXmz+9
 7Iw9+G1Zb6SJQ==
Date: Mon, 12 Oct 2026 14:30:13 +0000
From: Yixun Lan <dlan@kernel.org>
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Cc: Zixian Zeng <sycamoremoon376@gmail.com>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
Message-ID: <20261012143013-GKJ26088@kernel.org>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
 <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
 <b34530c2-2a90-4cca-94ae-207e503188ee@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b34530c2-2a90-4cca-94ae-207e503188ee@altera.com>
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

Hi Kathpalia, Zexian,

On 19:30 Mon 12 Oct     , Kathpalia, Tanmay wrote:
> 
> On 12-10-2026 18:45, Zixian Zeng wrote:
> > On 2026/10/11 22:31, Kathpalia, Tanmay wrote:
> >> Hi Zixian,
> >>
> >> Thanks for the logs.
> >>
> >> I hit the same pattern while testing the Cadence SD6HC driver.
> >> Multi-block reads failed and single-block reads worked. On that board
> >> the host and the card were in 1.8 V mode, but the I/O supply had been
> >> left at 3.3 V. A short transfer got through; a longer one failed on the
> >> data lines.
> >> Both stages on K1 use the same PIO loop, so a FIFO that drains slower
> >> than the card delivers would show up in U-Boot proper as well. Your
> >> SPL/proper split fits an electrical setup difference.
> >>
> >> The SPL failure is irq=408020. Bit 22 is the Data End Bit Error (EDEB,
> >> SD mode only): the controller detected 0 at the end-bit position of
> >> read data on DAT, or of the write CRC status. That is a bad edge on
> >> the data line during the transfer.
> >>
> >> On the Banana Pi F3, aldo1 is vqmmc-supply of &sdhci0. The U-Boot
> >> dtsi names it vdd_1v8_mmc, and the SPL prints "vdd_1v8_mmc,
> >> value:1800000" before MMC2. set_vdd_mmc() in board/spacemit/k1/spl.c,
> >> called from board_init_f(), writes 1800000. The dts leaves aldo1 at
> >> 0.5 V to 3.4 V. SD High Speed (mode=2) uses 3.3 V signaling; 1.8 V is
> >> only after a UHS switch. mmc1_cfg is power-source 3300, and
> >> mmc1_uhs_cfg is the 1.8 V state. For this mode the rail should be 3.3 V.
> >>
> >> CONFIG_SPL_MMC_IO_VOLTAGE is not set, so mmc_set_signal_voltage() is a
> >> stub and signal_voltage stays MMC_SIGNAL_VOLTAGE_000. aldo1 stays at
> >> 1.8 V. U-Boot proper has CONFIG_MMC_IO_VOLTAGE. mmc_set_initial_state()
> >> requests MMC_SIGNAL_VOLTAGE_330, so the driver writes 3300000 to the
> >> same vqmmc-supply and clears SDHCI_CTRL_VDD_180 before the transfer
> >> that succeeds.
> >>
> >> CONFIG_SPL_PINCTRL is not set either. The driver calls
> >> pinctrl_select_state() under IS_ENABLED(CONFIG_PINCTRL), but that
> >> function is a stub unless CONFIG_IS_ENABLED(PINCTRL), and the return
> >> is ignored. SPL never applies mmc1_cfg. Proper selects "default" for
> >> SD_HS, which is that state.
> >>
> >> Keeping the multi-block path, set_vdd_mmc() to 3300000, or enable
> >> CONFIG_SPL_MMC_IO_VOLTAGE. If the 32-block CMD18 still fails, enable
> >> CONFIG_SPL_PINCTRL so mmc1_cfg is applied. If either makes the read
> >> succeed, this is the F3 failure.
> >>
> >> Regards,
> >> Tanmay
> >
> > Hi Tanmay,
> >
> > Your diagnosis was right - it is the I/O voltage.
> > Enabling CONFIG_SPL_MMC_IO_VOLTAGE makes
> > the multi-block read work on the Banana Pi-F3:
> >
> > Based on previous commit, I patched the following changes:
> >
> > diff --git a/configs/spacemit_k1_defconfig 
> > b/configs/spacemit_k1_defconfig
> > index 9c15d96eae2..f5c717e5965 100644
> > --- a/configs/spacemit_k1_defconfig
> > +++ b/configs/spacemit_k1_defconfig
> > @@ -95,6 +95,7 @@ CONFIG_MMC=y
> >  CONFIG_MMC_SDHCI=y
> >  CONFIG_MMC_SDHCI_SPACEMIT=y
> >  CONFIG_MMC_IO_VOLTAGE=y
> > +CONFIG_SPL_MMC_IO_VOLTAGE=y
> >  CONFIG_MMC_HS200_SUPPORT=y
> >  CONFIG_MMC_HS400_SUPPORT=y
> >  CONFIG_MMC_HS400_ES_SUPPORT=y
> > diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> > index 23c655c6def..58374c482b3 100644
> > --- a/drivers/mmc/spacemit_sdhci.c
> > +++ b/drivers/mmc/spacemit_sdhci.c
> > @@ -251,6 +251,10 @@ static void spacemit_sdhci_set_voltage(struct 
> > sdhci_host *host)
> >                         bool ok;
> >                         int voltage_mv = to_180 ? 1800000 : 3300000;
> >
> > +                       printf("sdhci: voltage signal_voltage=%u 
> > vqmmc=%s -> %dmV\n",
> > +                              mmc->signal_voltage,
> > +                              mmc->vqmmc_supply ? 
> > mmc->vqmmc_supply->name : "none",
> > +                              voltage_mv);
> >                         if (spacemit_sdhci_set_vqmmc_voltage(mmc, 
> > voltage_mv))
> >                                 return;
> >                         if (!IS_SD(mmc))
> > @@ -274,7 +278,8 @@ static void spacemit_sdhci_set_voltage(struct 
> > sdhci_host *host)
> >                         break;
> >                 }
> >                 default:
> > -                       /* No signal voltage switch required */
> > +                       printf("sdhci: voltage signal_voltage=%u -> no 
> > switch\n",
> > +                              mmc->signal_voltage);
> >                         return;
> >                 }
> >         }
> >
> > Booting logs as follows:
> >
> > U-Boot SPL 2026.10-rc5-00643-g6a99fe92389a (Oct 12 2026 - 21:13:00 +0800)
> > Fail to detect board:-2
> > vdd_core, value:900000
> > vdd_1v8, value:1800000
> > vdd_1v8_mmc, value:1800000
> > DDR firmware: [0xc081d880]:0xf0227179, size:0x8d98
> > DDR is ready
> > No SPI controller (-19)
> > Trying to boot from MMC2
> > sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 
> > max_clk=204800000
> > sdhci: voltage signal_voltage=0 -> no switch
> > sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> > sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> > sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> > sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> > sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> > mmc: multi-blk blkcnt=32 clk=50000000 mode=2 width=4 caps=300207ef 
> > cmd23_host=1 scr0=2358043 cmd23_card=1
> > sdhci: multi cmd18 arg=2 blks=32 blksz=512 mode=32 dma=0
> > mmc: multi-blk blkcnt=1956 clk=50000000 mode=2 width=4 caps=300207ef 
> > cmd23_host=1 scr0=2358043 cmd23_card=1
> > sdhci: multi cmd18 arg=1000 blks=1956 blksz=512 mode=32 dma=0
> >
> > <debug_uart>
> >
> >
> > U-Boot 2026.10-rc5-00643-g6a99fe92389a (Oct 12 2026 - 21:13:00 +0800)
> >
> > DRAM:  4 GiB
> > Core:  338 devices, 22 uclasses, devicetree: separate
> > MMC:   sdhci: mmc@d4281000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 
> > max_clk=204800000
> > sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 
> > max_clk=204800000
> > mmc@d4280000: 1, mmc@d4281000: 0
> > Loading Environment from nowhere... OK
> > In:    serial@d4017000
> > Out:   serial@d4017000
> > Err:   serial@d4017000
> > Net:   No ethernet found.
> > =>
> >
> > With the voltage corrected, a single 1956 block PIO CMD18 loads
> > the whole FIT,so the controller is fine with the FIFO back pressure,
> > the slow SPL drain was a symptom, not the cause :-).
> >
> > Without the CONFIG_SPL_MMC_IO_VOLTAGE=y change the same driver printed
> > "sdhci: voltage signal_voltage=0 -> no switch".
> > Since mmc_set_signWith the voltage corrected, a single 1956 block PIO 
> > CMD18 loads
> > the whole FIT,so the controller is fine with the FIFO back pressure,
> > the slow SPL drain was a symptom, not the cause :-).
> >
> > Without the CONFIG_SPL_MMC_IO_VOLTAGE=y change the same driver printed
> > "sdhci: voltage signal_voltage=0 -> no switch".
> > Since mmc_set_signal_voltage() is a stub in SPL, so mmc->signal_voltage
> > stayed MMC_SIGNAL_VOLTAGE_000, spacemit_sdhci_set_voltage() took the
> > "no switch required" path, and aldo1 stayed at the initial 1800000 that
> > set_vdd_mmc() writes in pmic_init(). The 32 block CMD18 then failed
> > after ~20 of 32 blocks. Single block reads passed at 1.8 V, which is 
> > what hid it.
> >
> > On the pinctrl side I had already run the SPL with standalone
> > CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
> > mmc1_uhs_cfg plus their pin groups. I confirmed that
> > pinctrl_select_state() return successfully. The multi-block read still
> > failed the same way with the rail at 1.8V.
> >
> > Therefore, I suspect that configuring the MMC signal voltage to 1.8V
> > in pmic_init() may need to be modified.
> >
> > Thanks for your suggestions and guidance.
> >
> > Best regards,
> > Zixianal_voltage() is a stub in SPL, so mmc->signal_voltage
> > stayed MMC_SIGNAL_VOLTAGE_000, spacemit_sdhci_set_voltage() took the
> > "no switch required" path, and aldo1 stayed at the initial 1800000 that
> > set_vdd_mmc() writes in pmic_init(). The 32 block CMD18 then failed 
> > after ~20 of 32 blocks. Single block reads passed at 1.8 V, which is 
> > what hid it.
> >
> > On the pinctrl side I had already run the SPL with standalone
> > CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
> > mmc1_uhs_cfg plus their pin groups. I confirmed that
> > pinctrl_select_state() return successfully. The multi-block read still
> > failed the same way with the rail at 1.8V.
> >
> > Therefore, I suspect that configuring the MMC signal voltage to 1.8V
> > in pmic_init() may need to be modified.
> >
> > Thanks for your suggestions and guidance.
> >
> >
> 
> Hi Zixian,
> 
> Thank you for the quick testing and for posting detailed results. Your
> patience with the suggested tests helped us reach the root cause
> within two days.
> 
> With CONFIG_SPL_MMC_IO_VOLTAGE enabled, aldo1 is changed from its
> initial 1.8 V to 3.3 V and both the 32-block and 1956-block reads
> succeed.
> 
> I am still unsure why set_vdd_mmc() initializes this rail to 1.8 V.
I'm also looking into this..

It's definitely wrong here, and should be fixed in my opinion, refer
to SD spec, the initial IO should be 3.3v, and later may change to 1.8v
according to OCR report, the BROM code will set IO to 3.3v by default
since cold boot, and I've done a test on this, drop set_vdd_mmc() & without
CONFIG_SPL_MMC_IO_VOLTAGE enabled, the multi block read still works fine
on SPL stage

Also with Zexian's above test, it also prove that, enabling CONFIG_SPL_MMC_IO_VOLTAGE
will lead the mmc core calling set_voltage() which will set IO to 3.3v, which also
fix the problem

> Since we do not know the original hardware requirement, any change to
> that default should be reviewed by the code owner.
> 
> I suggest enabling both CONFIG_SPL_MMC_IO_VOLTAGE and
> CONFIG_SPL_PINCTRL. The former fixes the voltage issue, while the
> latter ensures SPL applies the defined MMC pad configuration instead
> of relying on the Boot ROM state.
> 
I agree, it's safe to do this

> Dave, I hope you are aligned with the changes discussed and tested.
> Could you please post a new version incorporating them?
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> 
> Regards,
> Tanmay
> 

-- 
Yixun Lan (dlan)
