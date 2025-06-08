Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53912C5B543
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 02:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D0C80C93;
	Sun,  8 Jun 2025 04:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="i5h1rL4I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D5680FA8; Sun,  8 Jun 2025 04:37:18 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B0B9808AF
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 04:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 52CE325B19;
 Sun,  8 Jun 2025 04:37:16 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id th4jf6mweHfE; Sun,  8 Jun 2025 04:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1749350235; bh=jBPUeXH0SZpsp2+hMxEeUEhSeTQ8x1dG3z8wBp23ieI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=i5h1rL4IDdnpTCx0RKF9pRfwaDif4qKwB+IwwjAfypNHYk7U03dUZtsTg2S+KF3gN
 dQOoaCc5Oc7TQ/52sgVl3kXa2TlLBQo1r367GIM2QsQ4PvzxoiOxmU858D0Qk3my0c
 8AVN2oNfBWGWDkex6pGQTZA/ePmGTahpLVR7IpWmH2tzoXIByMqPENZCFAQtMSeZp5
 0nPHH43EF5e6XEZc7G+PonvMCYj/ezBdZLrtz7txfRSqXhELg5E63OjI1FrkCRr08X
 wBiNuIEAOlX3AxWxwuF7c0yO8jP4Npw9aRnOkiZwfNilHbs0BJFwSKbgrzXs2IbqNq
 /T3XPOpd+XpLw==
Date: Sun, 8 Jun 2025 02:37:04 +0000
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>, Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [PULL] u-boot-riscv/next
Message-ID: <aET27PdD0VwuzOAB@pie>
References: <aD6aAdsMpatCgcIn@swlinux02>
 <20250605200506.GF1382132@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605200506.GF1382132@bill-the-cat>
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

On Thu, Jun 05, 2025 at 02:05:06PM -0600, Tom Rini wrote:
> On Tue, Jun 03, 2025 at 02:45:21PM +0800, Leo Liang wrote:
> 
> > Hi Tom,
> > 
> > The following changes since commit d45b1d4ac94710f88902adc2173d7930700e2869:
> > 
> >   Merge tag 'u-boot-dfu-next-20250602' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next (2025-06-02 08:43:10 -0600)
> > 
> > are available in the Git repository at:
> > 
> >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> > 
> > for you to fetch changes up to b911af6d60d3be570469b92df751874dc376336b:
> > 
> >   MAINTAINERS: riscv: cpu: th1520: Assign myself as maintainer (2025-06-03 14:17:46 +0800)
> > 
> > CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/26483
> > ----------------------------------------------------------------
> > - board: Convert Lichee Pi 4A to use S-Mode proper U-Boot
> > - RISC-V: configs: Raise SPL_SYS_MALLOC_SIZE to 8 MiB
> > - driver: Add SD card support to the Beagle-V-Fire
> > - MAINTAINERS: Add Yao Zi as maintainer for th1520
> > ----------------------------------------------------------------
> 
> This introduces a failure to build on microchip_mpfs_icicle currently in
> -next.

microchip_mpfs_icicle_defconfig fails to build in u-boot-riscv/next as
well. Reverting b73971dea9fed ("spi: coreqspi: add xfer function for
PolarFire SoC") fixes it.

Seems the patch doesn't adapt the multiple-cs-capable definition of
dm_slave_plat, which was introduced in commit 34da258bb04 ("spi:
spi-uclass: Read chipselect and restrict capabilities") in the last
year. Thus I doubt whether the patch has been built and tested against a
recent version of U-Boot.


> -- 
> Tom

Regards,
Yao Zi
