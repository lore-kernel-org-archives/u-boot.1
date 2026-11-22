Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC72606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 00:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jAcITRhf;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7wUPhAN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF1CF406CD;
	Sun, 22 Nov 2026 00:38:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ECbl7uLxI76; Sun, 22 Nov 2026 00:38:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7E2C3406AF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795307900;
	b=Mfi1/FvdpEJy7gMIiL6/n/0+JrVZr+RR9G1SjtERT9TziPuIBYBq4QzLF9ERn/8OOZkF
	 EA3A375579NF0jYuTdb1x/RWBgz8P0HB4qUg1vtw8orREsQSA8oYPKRgy4bCIXsk7v7i8
	 ePHTildK22JGvYYM60Iqby/bH6fMpuXAujIYjX2XAsDuEUdam917RcdOvKKmbzC7Mgju/
	 RXTnFmxRXHxDutfjhuCt87iKAxG4e2uClbHPLGD79i5bnwZSzcrvEP5lhh8OcIeIqotCo
	 WYkYLu/p1beeo0EVKlQ4h+LJ/WtGoPGgqws05L+I1p33yYFTW+wZuU9KfWK/lXCFnog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795307900;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yjPFEqIqbj4ot/b+dAbdMId5n72bCQE8rOB8aVvpoPY=;
	b=Z62X5FAy5SMra0I1O/4xIVX6b8FUw2GGsoSY088xCQ9FY9gmALWE1AcDhiybde2DOFwn
	 6Tfl5Y0qI7b1arLckmN4F976y1umURYBN4ZdqMuyd4r003SB5uMIWDJQaO0LbOdhh9/0R
	 7n5a8yBeNsGiEckjI33hNWL7ZQxdqWuioYovC+qCcLpSn1sdIe6+kFLA4y6vSwIJ7Kiir
	 Og50mluIFtMCCl9v66UK+okCZu0aBmhQymdObe4+QNIE3864qj/7IS8rZHO8YwixSxQwm
	 3Np138267ewXIMr0WyTVspu6cR5TloqJP60dOOrsw8uS6vYjRzWFOLXsKSY1nG5WZcA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795307900;
	bh=yjPFEqIqbj4ot/b+dAbdMId5n72bCQE8rOB8aVvpoPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jAcITRhfzEFxlwoYHzJDZBMKdaiUUgQa/TDMuX4oGnKDu+Dlih/sY3rRDti6X6AKX
	 fMMs1brlSLc6Ag+8DNRvWgsAXxen73OJxR4hNgSpE/SJad+mHGQpRQfgraGDC1gAFi
	 Fm52Ghdk4xwZBUNsJPvMLCltP+1acupzcJmDUV87XnhKbZPoXwdT3zgBmkUrHxgBcu
	 8MZ3V+x5+zjTfvk1Ji+/wT7SE26brIUxSJdDttxRZCu7iEYBy3aXaTPHU60mB16NVS
	 L6OJHw1nA7+G+PWyAFvN5hUGK6XjfMnIjPga+rcdlUqhJb9qgyrBwUf2QHCbMDzUtp
	 Q5feIKWiwRQ8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E2C3406AF;
	Sun, 22 Nov 2026 00:38:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E28B2759
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 00:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8CCF40097
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 00:38:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lsnDMieSqLYN for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 00:38:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9E54A400AB
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=P7wUPhAN
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E54A400AB
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 00:38:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D1E960D76;
 Sun, 22 Nov 2026 00:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA9E1F000C6;
 Sun, 22 Nov 2026 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795307896;
 bh=yjPFEqIqbj4ot/b+dAbdMId5n72bCQE8rOB8aVvpoPY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=P7wUPhAN5Jbpc9TwFveq3i/1ZHcHSFs08WAiuN5pC98pPTEK+gQVC9dSDbZnW+6+w
 kQ9RcEPK6fKVh09whZllCmvrTeQShiM+hTYdCOM/Ibw2BneOuhbVQvCkbx5TlgwKe6
 I3fKG9fbi0vl0KvIimGidyqGbYgThETdJkoVbhGT9hZdhK54ANJWhZhmk2Hg48+ZRl
 +ObLPRLeAY31Ciwr7cZJQRCas45mLuWXauoIu69nN4rilUa0oBoHJ4iHHIDj3IjscK
 txXfnKvs6J0yzHEB6e/PIsSJLbQlVtF4Dwb0zUvSBVdV/gqgnAqrqIQXxIIuzf0Lir
 3FqsH0T22qxqA==
Date: Sun, 22 Nov 2026 00:38:13 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH] spi: fsl_qspi: Add optional clock support
Message-ID: <20261122003813-GKB203137@kernel.org>
References: <20261120-05-fsl-qspi-clock-v1-1-bacea4ebd54b@kernel.org>
 <03d87c74-de4b-4335-85d2-869ad8d83a31@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03d87c74-de4b-4335-85d2-869ad8d83a31@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E Shattow, 

On 14:14 Sat 21 Nov     , E Shattow wrote:
> Hi Yixun,
> 
> On 11/20/26 06:43, Yixun Lan wrote:
> > The clock required by QSPI controller may not be enabled by default,
> > So explicitly get and enable the clocks described by the DT node, due
> > to keep compatibility reason, keep the clock optional for platforms if
> > there is no clock framework support or no clocks property provided.
> > 
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> > While testing in SpacemiT K3 Platform, we found the QSPI clock need to
> > be explicitly enabled if boot from USB fastboot mode. While there is no
> 
> I observe that BootROM SPL Loader "USB" mode allows an vendor SPL with
> SPI and clocks support enabled (and otherwise reduced options; as
> "bsp-spi"[1]) to then load (via UART) u-boot.itb where mainline u-boot
> main app "sf probe" is successful.
> 
> This same vendor SPL and mainline u-boot main app "sf probe" action does
> fail if it was instead loaded from BootROM SPL Loader "UART" mode. I
> regard the "UART" mode as a baseline for testing since it apparently is
> doing the least in terms of peripheral setup. The software must do this
> setup and not depend on features of any previous peripheral setup by
> BootROM SPL Loader.
> 
> Either mode "USB" or "UART" results in probe failure from mainline
> u-boot main app if the vendor SPL is build without SPI and clocks
> support (as "bsp-nospi"[1]). From this I conclude there is a difference
> in handling setup between BootROM SPL Loader "UART" and "USB" modes in
> this way that can be tested for.
> 
> I did not yet test "SPI" mode because I assume if BootROM SPL Loader can
> access the peripheral then it will also work for SPL software to access
> the same.
> 
> 1: Guide to build reduced SpacemiT K3 vendor BSP:
> https://lore.kernel.org/u-boot/20261029001555.1890775-1-e@freeshell.de/
> 
> To be clear my above reply remarks are while *not* applying this "spi:
> fls_qspi: Add optional clock support" patch to mainline u-boot. I think
> it is interesting that "USB" mode does allow successful "sf probe" in my
> testing and that in your description it was not successful.
> 
The test environment is different, I'm testing "USB" mode without vendor SPL

> > problem in booting from SPI nor flash mode which the clock already
> > enabled by BROM code.
Yes, that's right

> > 
> > In order to not break other platforms, try to set the clock optional,
> > so it won't abort if there is no clock framework support, or no clock
> > device tree property.
> 
> The compatible "spacemit,k1-spi" is in the SpacemiT K3 SoC dtsi include:
> 
It's spacemit,k1-qspi (s/spi/qspi/) which SPI NOR connect to..

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/boot/dts/spacemit/k3.dtsi
> 
> Matched from driver wrapper:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-spacemit-k1.c
> 
> Where it then appears the clock setup is branched to from k1_spi_probe()
> function.
> 
> In all situations I have tested I do observe that Linux kernel probes
> SPI NOR flash on SpacemiT K3 Pico-ITX board properly with FSL SPI driver
> and the wrapper driver matching "spacemit,k1-spi" compatible. That seems
> to me properly vetted as being correct because it always works even if
> no setup was done by SPL or u-boot main app.
> 
..
> There are some updates to the FSL SPI driver itself that should be
> sync'd from the Linux FSL SPI driver, and then I observe one improvement
> to u-boot FSL SPI driver which should probably be sent upstream to Linux.
> 
I'm not aware of this, feel free to send patches or link?

> I guess that it is preferable to sync with the Linux driver(s) for less
> maintenance troubles. Does this patch break the DM model the way it is
> now? What do the other maintainers think?
> 
I don't think it break DM model..

> > ---
> >  drivers/spi/fsl_qspi.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/drivers/spi/fsl_qspi.c b/drivers/spi/fsl_qspi.c
> > index 5692510a558..454dfaf1814 100644
> > --- a/drivers/spi/fsl_qspi.c
> > +++ b/drivers/spi/fsl_qspi.c
> > @@ -23,6 +23,7 @@
> >   * Transition to spi-mem in spi-fsl-qspi.c
> >   */
> >  
> > +#include <clk.h>
> >  #include <dm.h>
> >  #include <dm/device_compat.h>
> >  #include <log.h>
> > @@ -716,6 +717,29 @@ static int fsl_qspi_adjust_op_size(struct spi_slave *slave,
> >  	return 0;
> >  }
> >  
> > +static int fsl_qspi_clock_setup(struct fsl_qspi *q)
> > +{
> > +	struct clk_bulk clks;
> > +	int ret;
> > +
> > +	ret = clk_get_bulk(q->dev, &clks);
> > +
> > +	/* Ignore if no DT clock property or no clock framework support */
> > +	if (ret == -ENOENT || ret == -ENOSYS)
> > +		return 0;
> > +
> > +	if (ret) {
> > +		dev_err(q->dev, "Failed to get clocks: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = clk_enable_bulk(&clks);
> > +	if (ret)
> > +		dev_err(q->dev, "Failed to enable clocks: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> >  static int fsl_qspi_default_setup(struct fsl_qspi *q)
> >  {
> >  	void __iomem *base = q->iobase;
> > @@ -829,6 +853,7 @@ static int fsl_qspi_probe(struct udevice *bus)
> >  	dm_bus->max_hz = fdtdec_get_int(blob, node, "spi-max-frequency",
> >  					66000000);
> >  
> > +	fsl_qspi_clock_setup(q);
> >  	fsl_qspi_default_setup(q);
> >  
> >  	return 0;
> > 
> > ---
> > base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
> > change-id: 20261120-05-fsl-qspi-clock-e3df6b72ab8a
> > 
> > Best regards,
> > --  
> > Yixun Lan <dlan@kernel.org>
> > 
> 
> With this patch on mainline u-boot main branch from today and the
> intermediary "bsp-spi"[1] or "bsp-nospi"[1] reduced vendor SPL
> previously mentioned, on Sipeed K3 Pico-ITX 32G board as BootROM SPL
> Loader "UART" mode:
> 
> => sf probe
> SF:    Detected w25q64dw with page size 256 Bytes, erase size 4 KiB,
> total 8 MiB
> 
> => sf erase 0 800000
> SF: 8388608 bytes @ 0x0 Erased: OK
> 
> It works as-is, but I think it probably should not work unless matching
> a compatible. Obviously there are valid concerns for SpacemiT K3 SPL
> environment being memory-constrained, but what I'm testing is S-mode
> u-boot main app and this does not seem like the correct approach. Do I
> not understand correctly the driver model?
> 
what do you mean by "not work unless matching a compatible", is
"spacemit,k1-qspi" of fsl_qspi.c the one?  I see no problem of
your testing, such like U-Boot S-mode and "sf" commands

-- 
Yixun Lan (dlan)
