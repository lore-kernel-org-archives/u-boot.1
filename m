Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3ADCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCDC74051D;
	Mon, 12 Oct 2026 15:22:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wk7HSR1YEn1O; Mon, 12 Oct 2026 15:22:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9D854404F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791818558;
	b=QuRSgJiFdjfFPhfHrH3iXvUflAreCCRkPNvMb+uozHnEB9zatxsTRJ2XgV96/f0PiNHZ
	 sMxdK78PbnkG6RmseHa6LXX2m7gr7De54YsiUQXsdJayt7juY5DxR7AmrQ87uH/xO147F
	 ZG+n136zblechP3GaADBw6zR/hVjQDdEaHNKPUDQdfrL6/XAnIuPC9W5mYYYihaZuVVbt
	 vvLjMW4cneqMviPpSIG4t0G0JFcHsLjyPWYdZsTg3q5DjzrOM6kN5wBkZXQUUfw4SyzHP
	 Kbfs1NFwU6SS6f+gQWaSxwN/p0BFA8xvyZlAOo+YDy9FGHiJcewz3708B99bx3upEmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791818558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5+BDNnQNfdf39OUbMAJAsu4JGdhNhM4YiDowEuu0zFM=;
	b=R50UCS0HcPg5ok1t2HvTohTgRxPd5LtNeyTZWrxToBl/RvYhQMEYwms2L3Khv+jpNBlu
	 1li8HGv7icDhJ5Ql+fopSP+jqfI/Haf8fovNrgMF0i7F1M8CCqZasKXlsKIo4/F7mb+VX
	 eIuRcetW5BU8K1FxRb514IPsyUlS3sOUuBmH+bk6GNANX7o16rI1CKzN9kW8TY02mXcKM
	 znL3FLC/f42oufbOWkuXJmi3ZNgNjVDy0wL8gydPLhhtLyaTIBAUYPzIKJXtFIj0wT6Ni
	 hjxZBlQSSLYBhKLXstFX5IDyRyJVFzViHs4fjff5Te44KuNTzCXRLw5skDNZdsXnF3w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791818558;
	bh=5+BDNnQNfdf39OUbMAJAsu4JGdhNhM4YiDowEuu0zFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xJDLpMODnPUWhvrZWQGxJfGLgvqY3NWD/y/WCCDpVKztSC/DKqu1Hyqgyd+b6yawM
	 JFpemclghqKg97V9QXB0370nq2/eHjUEvog8MQzV8GpKn9oqZVR9D6BYUHM1zm5TV5
	 VNLGWtnAB+5c3RML3iDfZyQDg0gAP/aAA0yrFQrNnQJEYgfuZRRFLmDpZx9DAtotSp
	 cvgb+pfVFtR7qZuXgOAjdHAh61AHR1KvRsLDqiQlOx9ORcZe9XdknJJiwav6ZjTN3S
	 KaUFnz0r71FqtWQsMl3MVYwdYp7aFpadq0j0ZHHQkY1P/pfDveIcC0jTQ1K/F8KpZN
	 PECFp+amey8CA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D854404F4;
	Mon, 12 Oct 2026 15:22:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 72EDE194
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58ADF401EF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:22:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vIHwsqOXOWmE for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 15:22:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 570BF4010F
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791818556;
 b=sLJ4b2JAGZdCU6CKxtIS5rROSvuAyPnshZ0jflLNdhAqtu5c9vX7TeHRvMZDDKSwPDe3
 4D/0AOvjy562zbdnYCn2T+oMEL+lgvDyoRFCB9BkRBHl8YgO6Z1i/L9JPHSpD+yh2F5fo
 2naeapKFqJdaWR3uaIu2EDE2JU2p+1dligwFSicuE/I+fRQdnsGeygNWce00v9xzuZbsm
 YWmHoIh0DE8NJVbHWXsnS/MMp6HjHw4O2f3lHtRk/XK3IjOlaWLBimYy2IzZvs8Nx3S5R
 nYiIkMhantY42/ezpgb7nmdzPii4qfpXXlqtNuZMK6feD0OlKpgq+xWfGcG/d4ITJ1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791818556;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=5+BDNnQNfdf39OUbMAJAsu4JGdhNhM4YiDowEuu0zFM=;
 b=N30fmSIk9usvXWOXglhQcYqKt7KPfRGqnsLvNTE3wwCFWhb0z6exuU8yS3KrSSQdAAE1
 tfxz5ilsbq6fE6aZcRmcDvHFTcax+5vK34wiawsK1F+xXhg+N24thFagOPj6KR+rhZjHA
 WN40DBAg8voBaCuU3X5to2hwgFr90y+1pWw2iH+SzZeY5oaHvRmv2/jqQl7NDQzDBRzo/
 fA9SxRq3BajALXYx2pT2IFe0eTfYkhb7cJsDe/HXrH75hPPA0tPhkl5m0UkjwmxqFPvn2
 Cs5Wqycke0Ts+ChnNWRM2zRJP7LNpeYzkx2WeDSOyr8swJGylCSGxN6q/XBvdzW7E6w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=biJ2RUaF; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=biJ2RUaF
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 570BF4010F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:22:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA00441FA3;
 Mon, 12 Oct 2026 15:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF791F0089B;
 Mon, 12 Oct 2026 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791818554;
 bh=5+BDNnQNfdf39OUbMAJAsu4JGdhNhM4YiDowEuu0zFM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=biJ2RUaFGCkZaAUp/CpvI5EjAIaB9EGRPptTf9cGVnclHlycpLwyjcQvo2wGXO5ja
 F+sva+vKbfz3KOKZ9MbZoEhaJzG/qsmsd3Jpcufj9BZRiVOcto/q9G9epxTiz9VgMm
 lm3WKP/UKKSxaq6tM2d3XZ5NIqWPFM74qMtXDw3mEDProClRTWzLrlYWsv+r8oCtkZ
 9xubLf9iSxPxgrQcNFWGcvaH+a2sNaw6iZIN1detbNAfWzIixbmxP1Vw+/s+5eScKu
 /8eODq6AGxFnh60oPk3pPny3/FuiIJOZ1XMFiw3luzvc1xtek9DbTko9WiKhGB9/l+
 sFrATZhzovg4A==
Date: Mon, 12 Oct 2026 15:22:32 +0000
From: Yixun Lan <dlan@kernel.org>
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Cc: Zixian Zeng <sycamoremoon376@gmail.com>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
Message-ID: <20261012152232-GKK26088@kernel.org>
References: <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
 <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
 <b34530c2-2a90-4cca-94ae-207e503188ee@altera.com>
 <20261012143013-GKJ26088@kernel.org>
 <a677e019-dd28-420b-a9d7-808808b56264@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a677e019-dd28-420b-a9d7-808808b56264@altera.com>
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

Hi Kathpalia,

On 20:20 Mon 12 Oct     , Kathpalia, Tanmay wrote:
> Hi Yixun,
> 
> On 12-10-2026 20:00, Yixun Lan wrote:
> > Hi Kathpalia, Zexian,
> >
> > On 19:30 Mon 12 Oct     , Kathpalia, Tanmay wrote:
> >> On 12-10-2026 18:45, Zixian Zeng wrote:
> >>> On 2026/10/11 22:31, Kathpalia, Tanmay wrote:
> >>>> Hi Zixian,
> >>>>
> >>>> Thanks for the logs.
> >>>>
> >>>> I hit the same pattern while testing the Cadence SD6HC driver.
> >>>> Multi-block reads failed and single-block reads worked. On that board
> >>>> the host and the card were in 1.8 V mode, but the I/O supply had been
> >>>> left at 3.3 V. A short transfer got through; a longer one failed on the
> >>>> data lines.
> >>>> Both stages on K1 use the same PIO loop, so a FIFO that drains slower
> >>>> than the card delivers would show up in U-Boot proper as well. Your
> >>>> SPL/proper split fits an electrical setup difference.
> >>>>
> >>>> The SPL failure is irq=408020. Bit 22 is the Data End Bit Error (EDEB,
> >>>> SD mode only): the controller detected 0 at the end-bit position of
> >>>> read data on DAT, or of the write CRC status. That is a bad edge on
> >>>> the data line during the transfer.
> >>>>
> >>>> On the Banana Pi F3, aldo1 is vqmmc-supply of &sdhci0. The U-Boot
> >>>> dtsi names it vdd_1v8_mmc, and the SPL prints "vdd_1v8_mmc,
> >>>> value:1800000" before MMC2. set_vdd_mmc() in board/spacemit/k1/spl.c,
> >>>> called from board_init_f(), writes 1800000. The dts leaves aldo1 at
> >>>> 0.5 V to 3.4 V. SD High Speed (mode=2) uses 3.3 V signaling; 1.8 V is
> >>>> only after a UHS switch. mmc1_cfg is power-source 3300, and
> >>>> mmc1_uhs_cfg is the 1.8 V state. For this mode the rail should be 3.3 V.
> >>>>
> >>>> CONFIG_SPL_MMC_IO_VOLTAGE is not set, so mmc_set_signal_voltage() is a
> >>>> stub and signal_voltage stays MMC_SIGNAL_VOLTAGE_000. aldo1 stays at
> >>>> 1.8 V. U-Boot proper has CONFIG_MMC_IO_VOLTAGE. mmc_set_initial_state()
> >>>> requests MMC_SIGNAL_VOLTAGE_330, so the driver writes 3300000 to the
> >>>> same vqmmc-supply and clears SDHCI_CTRL_VDD_180 before the transfer
> >>>> that succeeds.
> >>>>
> >>>> CONFIG_SPL_PINCTRL is not set either. The driver calls
> >>>> pinctrl_select_state() under IS_ENABLED(CONFIG_PINCTRL), but that
> >>>> function is a stub unless CONFIG_IS_ENABLED(PINCTRL), and the return
> >>>> is ignored. SPL never applies mmc1_cfg. Proper selects "default" for
> >>>> SD_HS, which is that state.
> >>>>
> >>>> Keeping the multi-block path, set_vdd_mmc() to 3300000, or enable
> >>>> CONFIG_SPL_MMC_IO_VOLTAGE. If the 32-block CMD18 still fails, enable
> >>>> CONFIG_SPL_PINCTRL so mmc1_cfg is applied. If either makes the read
> >>>> succeed, this is the F3 failure.
> >>>>
> >>>> Regards,
> >>>> Tanmay
> >>> Hi Tanmay,
> >>>
> >>> Your diagnosis was right - it is the I/O voltage.
> >>> Enabling CONFIG_SPL_MMC_IO_VOLTAGE makes
> >>> the multi-block read work on the Banana Pi-F3:
> >>>
> >>> Based on previous commit, I patched the following changes:
> >>>
> >>> diff --git a/configs/spacemit_k1_defconfig
> >>> b/configs/spacemit_k1_defconfig
> >>> index 9c15d96eae2..f5c717e5965 100644
> >>> --- a/configs/spacemit_k1_defconfig
> >>> +++ b/configs/spacemit_k1_defconfig
> >>> @@ -95,6 +95,7 @@ CONFIG_MMC=y
> >>>   CONFIG_MMC_SDHCI=y
> >>>   CONFIG_MMC_SDHCI_SPACEMIT=y
> >>>   CONFIG_MMC_IO_VOLTAGE=y
> >>> +CONFIG_SPL_MMC_IO_VOLTAGE=y
> >>>   CONFIG_MMC_HS200_SUPPORT=y
> >>>   CONFIG_MMC_HS400_SUPPORT=y
> >>>   CONFIG_MMC_HS400_ES_SUPPORT=y
> >>> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> >>> index 23c655c6def..58374c482b3 100644
> >>> --- a/drivers/mmc/spacemit_sdhci.c
> >>> +++ b/drivers/mmc/spacemit_sdhci.c
> >>> @@ -251,6 +251,10 @@ static void spacemit_sdhci_set_voltage(struct
> >>> sdhci_host *host)
> >>>                          bool ok;
> >>>                          int voltage_mv = to_180 ? 1800000 : 3300000;
> >>>
> >>> +                       printf("sdhci: voltage signal_voltage=%u
> >>> vqmmc=%s -> %dmV\n",
> >>> +                              mmc->signal_voltage,
> >>> +                              mmc->vqmmc_supply ?
> >>> mmc->vqmmc_supply->name : "none",
> >>> +                              voltage_mv);
> >>>                          if (spacemit_sdhci_set_vqmmc_voltage(mmc,
> >>> voltage_mv))
> >>>                                  return;
> >>>                          if (!IS_SD(mmc))
> >>> @@ -274,7 +278,8 @@ static void spacemit_sdhci_set_voltage(struct
> >>> sdhci_host *host)
> >>>                          break;
> >>>                  }
> >>>                  default:
> >>> -                       /* No signal voltage switch required */
> >>> +                       printf("sdhci: voltage signal_voltage=%u -> no
> >>> switch\n",
> >>> +                              mmc->signal_voltage);
> >>>                          return;
> >>>                  }
> >>>          }
> >>>
> >>> Booting logs as follows:
> >>>
> >>> U-Boot SPL 2026.10-rc5-00643-g6a99fe92389a (Oct 12 2026 - 21:13:00 +0800)
> >>> Fail to detect board:-2
> >>> vdd_core, value:900000
> >>> vdd_1v8, value:1800000
> >>> vdd_1v8_mmc, value:1800000
> >>> DDR firmware: [0xc081d880]:0xf0227179, size:0x8d98
> >>> DDR is ready
> >>> No SPI controller (-19)
> >>> Trying to boot from MMC2
> >>> sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1
> >>> max_clk=204800000
> >>> sdhci: voltage signal_voltage=0 -> no switch
> >>> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> >>> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> >>> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> >>> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> >>> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> >>> mmc: multi-blk blkcnt=32 clk=50000000 mode=2 width=4 caps=300207ef
> >>> cmd23_host=1 scr0=2358043 cmd23_card=1
> >>> sdhci: multi cmd18 arg=2 blks=32 blksz=512 mode=32 dma=0
> >>> mmc: multi-blk blkcnt=1956 clk=50000000 mode=2 width=4 caps=300207ef
> >>> cmd23_host=1 scr0=2358043 cmd23_card=1
> >>> sdhci: multi cmd18 arg=1000 blks=1956 blksz=512 mode=32 dma=0
> >>>
> >>> <debug_uart>
> >>>
> >>>
> >>> U-Boot 2026.10-rc5-00643-g6a99fe92389a (Oct 12 2026 - 21:13:00 +0800)
> >>>
> >>> DRAM:  4 GiB
> >>> Core:  338 devices, 22 uclasses, devicetree: separate
> >>> MMC:   sdhci: mmc@d4281000 path=PIO flags=0 caps_sdma=1 caps_adma2=1
> >>> max_clk=204800000
> >>> sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1
> >>> max_clk=204800000
> >>> mmc@d4280000: 1, mmc@d4281000: 0
> >>> Loading Environment from nowhere... OK
> >>> In:    serial@d4017000
> >>> Out:   serial@d4017000
> >>> Err:   serial@d4017000
> >>> Net:   No ethernet found.
> >>> =>
> >>>
> >>> With the voltage corrected, a single 1956 block PIO CMD18 loads
> >>> the whole FIT,so the controller is fine with the FIFO back pressure,
> >>> the slow SPL drain was a symptom, not the cause :-).
> >>>
> >>> Without the CONFIG_SPL_MMC_IO_VOLTAGE=y change the same driver printed
> >>> "sdhci: voltage signal_voltage=0 -> no switch".
> >>> Since mmc_set_signWith the voltage corrected, a single 1956 block PIO
> >>> CMD18 loads
> >>> the whole FIT,so the controller is fine with the FIFO back pressure,
> >>> the slow SPL drain was a symptom, not the cause :-).
> >>>
> >>> Without the CONFIG_SPL_MMC_IO_VOLTAGE=y change the same driver printed
> >>> "sdhci: voltage signal_voltage=0 -> no switch".
> >>> Since mmc_set_signal_voltage() is a stub in SPL, so mmc->signal_voltage
> >>> stayed MMC_SIGNAL_VOLTAGE_000, spacemit_sdhci_set_voltage() took the
> >>> "no switch required" path, and aldo1 stayed at the initial 1800000 that
> >>> set_vdd_mmc() writes in pmic_init(). The 32 block CMD18 then failed
> >>> after ~20 of 32 blocks. Single block reads passed at 1.8 V, which is
> >>> what hid it.
> >>>
> >>> On the pinctrl side I had already run the SPL with standalone
> >>> CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
> >>> mmc1_uhs_cfg plus their pin groups. I confirmed that
> >>> pinctrl_select_state() return successfully. The multi-block read still
> >>> failed the same way with the rail at 1.8V.
> >>>
> >>> Therefore, I suspect that configuring the MMC signal voltage to 1.8V
> >>> in pmic_init() may need to be modified.
> >>>
> >>> Thanks for your suggestions and guidance.
> >>>
> >>> Best regards,
> >>> Zixianal_voltage() is a stub in SPL, so mmc->signal_voltage
> >>> stayed MMC_SIGNAL_VOLTAGE_000, spacemit_sdhci_set_voltage() took the
> >>> "no switch required" path, and aldo1 stayed at the initial 1800000 that
> >>> set_vdd_mmc() writes in pmic_init(). The 32 block CMD18 then failed
> >>> after ~20 of 32 blocks. Single block reads passed at 1.8 V, which is
> >>> what hid it.
> >>>
> >>> On the pinctrl side I had already run the SPL with standalone
> >>> CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
> >>> mmc1_uhs_cfg plus their pin groups. I confirmed that
> >>> pinctrl_select_state() return successfully. The multi-block read still
> >>> failed the same way with the rail at 1.8V.
> >>>
> >>> Therefore, I suspect that configuring the MMC signal voltage to 1.8V
> >>> in pmic_init() may need to be modified.
> >>>
> >>> Thanks for your suggestions and guidance.
> >>>
> >>>
> >> Hi Zixian,
> >>
> >> Thank you for the quick testing and for posting detailed results. Your
> >> patience with the suggested tests helped us reach the root cause
> >> within two days.
> >>
> >> With CONFIG_SPL_MMC_IO_VOLTAGE enabled, aldo1 is changed from its
> >> initial 1.8 V to 3.3 V and both the 32-block and 1956-block reads
> >> succeed.
> >>
> >> I am still unsure why set_vdd_mmc() initializes this rail to 1.8 V.
> > I'm also looking into this..
> >
> > It's definitely wrong here, and should be fixed in my opinion, refer
> > to SD spec, the initial IO should be 3.3v, and later may change to 1.8v
> > according to OCR report, the BROM code will set IO to 3.3v by default
> 
> Agreed. The host and I/O signaling rail should initially be at 3.3 V,
> and the card powers up using 3.3 V signaling. It may switch to 1.8 V
> later only when entering a supported UHS timing mode.
> 
Currently, the spacemit_k1_defconfig does not enable UHS config, so no
1.8v switching will happen, but I think that's another problem which
should investigate later..

> > since cold boot, and I've done a test on this, drop set_vdd_mmc() & without
> > CONFIG_SPL_MMC_IO_VOLTAGE enabled, the multi block read still works fine
> > on SPL stage
> 
> Thanks for testing the multi-block operation after dropping
> set_vdd_mmc() and without CONFIG_SPL_MMC_IO_VOLTAGE. Since the BootROM
> leaves the I/O rail at 3.3 V after a cold boot, the successful result is
> expected and confirms that set_vdd_mmc() incorrectly changes it to
> 1.8 V.
> 
> >
> > Also with Zexian's above test, it also prove that, enabling CONFIG_SPL_MMC_IO_VOLTAGE
> > will lead the mmc core calling set_voltage() which will set IO to 3.3v, which also
> > fix the problem
> 
> I think both changes should be made:
> 
> 1. Initialize the MMC I/O rail to 3.3 V instead of 1.8 V.
For how to achieve on this, I'd suggest drop set_vdd_mmc() from spl.c
and the leave spacemit_sdhci.c to config the I/O rail accordingly

> 2. Enable CONFIG_SPL_MMC_IO_VOLTAGE so the MMC core can manage any
>     subsequent signal-voltage transitions correctly.
> 
I agree on this

> >> Since we do not know the original hardware requirement, any change to
> >> that default should be reviewed by the code owner.
> >>
> >> I suggest enabling both CONFIG_SPL_MMC_IO_VOLTAGE and
> >> CONFIG_SPL_PINCTRL. The former fixes the voltage issue, while the
> >> latter ensures SPL applies the defined MMC pad configuration instead
> >> of relying on the Boot ROM state.
> >>
> > I agree, it's safe to do this
> >
> >> Dave, I hope you are aligned with the changes discussed and tested.
> >> Could you please post a new version incorporating them?
> >>
> >> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> >>
> >> Regards,
> >> Tanmay
> >>

-- 
Yixun Lan (dlan)
