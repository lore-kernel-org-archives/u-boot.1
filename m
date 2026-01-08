Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD22CF6A88
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 09:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A8C383B87;
	Thu,  8 Jan 2026 10:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="SC1MmXgm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E609A83B8A; Thu,  8 Jan 2026 10:04:35 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B00CC83B0D
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 6A7711FA75;
 Thu,  8 Jan 2026 10:04:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1767863072;
 bh=kyJNKUI3pLZ/HRUmByU+5tZ/OIsTRXfvejoBPfCRlXQ=; h=From:To:Subject;
 b=SC1MmXgmw0TEjCOA05yzp1DY0IA2I52UNx6LTMkGVFnHV4Iamtx1wckICVCAapS6q
 5vd4cDO76yS9XvFTqm/6e3WgAdQeJrZHtCgenRH+AhnsuoYKUqYwKYpb5q4TzqcRKa
 uTFj0EsVlQ7i/YpX6mUNJzs6IgOxBYgL+YByUnXNBQi8E5c4xLZ815WstBAv72brxk
 SpXrI4d0kZD3dNsTtPHCN3hB+b3L8y3TTriQVnPyK7x6rE+N5hK1x/HLWnUq1iLuBj
 sLFHVob8PuAtq240yOhJdFPO3xmYpn566luwd7SIduHvsULJC6ESWDOZWe0lRgmgvF
 fqY3YeV+sHxCA==
Date: Thu, 8 Jan 2026 10:04:28 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>,
 Vitor Soares <ivitro@gmail.com>, u-boot@lists.denx.de,
 vitor.soares@toradex.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
Message-ID: <20260108090428.GA5224@francesco-nb>
References: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
 <d9978b24-65d5-4f8f-8ef9-e551c5baf9b9@ew.tq-group.com>
 <6e24770b-ea18-4678-90ef-6338bd40b147@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e24770b-ea18-4678-90ef-6338bd40b147@altera.com>
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

On Thu, Jan 08, 2026 at 01:37:57PM +0530, Tanmay Kathpalia wrote:
> On 1/8/2026 12:32 PM, Max Merchel wrote:
> > Am 08.01.26 um 00:15 schrieb Vitor Soares:
> > > U-Boot 2026.01 fails to initialize MMC devices on multiple platforms
> > > with "unable to select a mode: -5" during mmc_select_mode().
> > > 
> > > Affected platforms:
> > > - Verdin iMX8M Mini (SPL boot failure - cannot boot at all)
> > > - Verdin iMX8M Plus (MMC init fails in U-Boot proper - cannot boot)
> > > - SMARC iMX8M Plus (MMC init fails in U-Boot proper)
> > > - Verdin AM62 (boot failure, no output)
> > > 
> > > All platforms use eMMC and worked correctly prior to this regression.
> > > 
> > > Bisect results:
> > > - Last known good commit: 228810d0bac3
> > > - Known bad commit: 36aeeb591b0d
> > > 
> > > Between these commits, several MMC-related changes were merged. These
> > > seem particularly relevant:
> > > commit aebb523a2381 ("mmc: mmc-uclass: Use max-frequency from device
> > > tree with
> > > default handling")
> > > commit 1e40e419aeb2 ("mmc: sdhci-cadence: Use max-frequency property
> > > from device
> > > tree")
> > > commit fa7e82127fad ("mmc: sdhci-cadence: Set controller and PHY
> > > speed modes for
> > > SD and eMMC cards")

...

> Thanks for the detailed report and bisect results. I've looked into the
> issue, and it appears the regression is introduced by commit aebb523a2381
> ("mmc: mmc-uclass: Use max-frequency from device tree with default
> handling").
> The problem stems from the probe function in the FSL eSDHC driver
> (fsl_esdhc_probe). Here's a breakdown:
> 
> First, fsl_esdhc_init is called, which sets cfg->f_max to the minimum of the
> controller's sdhc_clk and a hardcoded 200 MHz limit:
> cfg->f_max = min(priv->sdhc_clk, (u32)200000000);
> Subsequently, mmc_of_parse is invoked, where in the commit if the
> "max-frequency" property is not specified in the device tree node for the
> MMC controller, this function overrides cfg->f_max to 0.
> 
> This results in f_max being set to 0, which prevents proper mode selection
> during MMC initialization and leads to the "unable to select a mode: -5"
> error you're seeing across those platforms.
> 
> A potential fix could involve either:
> 
> Adding the "max-frequency" property to the relevant device tree nodes (e.g.,
> setting it to 200000000 or the appropriate value based on the hardware).

In general solving a regression in code, adjusting the DT is not ok in
Linux, not sure if the same reasoning would apply in the U-Boot
use case (considering that both U-Boot and DT are firmware).

Francesco

