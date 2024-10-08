Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758C2CED266
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 04:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFEAC88210;
	Tue,  8 Oct 2024 06:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="L7xIbXKR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA93388DBA; Tue,  8 Oct 2024 06:48:32 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 933B7881A2
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 06:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4984mRqF093006;
 Mon, 7 Oct 2024 23:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728362907;
 bh=PPzGFKtwDIpvWLAmqm3xYmkMet2ip8DKszOugfZcmis=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=L7xIbXKReUI2Pdrh1bfYNOdhlM/6j5fNJZNq3oUjZDlRc7sA+YcEYmas/SGbYqudt
 q6bCoR+PWZJigo2ZkVdzbG+oxXwibBfn0EIqfkxVDSrk1spNuFqkXe4Wc7uxFLw+Vt
 ZvuKfQbusCHP83avQp+3+jJQa9bP+1Yt7xTtJfZA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4984mRVw095347;
 Mon, 7 Oct 2024 23:48:27 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Oct 2024 23:48:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Oct 2024 23:48:26 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4984mQkw066134;
 Mon, 7 Oct 2024 23:48:26 -0500
Date: Tue, 8 Oct 2024 10:18:25 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 0/7] Add AVS support for J721S2
Message-ID: <20241008044825.w6ldvvoibk5zrk32@uda0497581>
References: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
 <CAFLszThMT+kN_u=ch-6m+3Ja615PwYjHd_La2KRhOzktXD21jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLszThMT+kN_u=ch-6m+3Ja615PwYjHd_La2KRhOzktXD21jg@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Simon,

On 09:23-20241007, Simon Glass wrote:
> Hi Manorit,
> 
> On Fri, 4 Oct 2024 at 00:24, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> >
> > This series adds support for AVS on J721S2.
> 
> What is AVS? You should write an abbreviation out in full at least
> once in the series.

Totally missed this part, let me take that up in the next revision!

But basically it is Adaptive voltage scaling. This allows us to run
our CPU with the optimal voltage for that particular silicon which would
have been written in efuse during manufacturing itself. This helps in
saving power during runtime [0]

[0]: https://www.ti.com/lit/pdf/spruj28 (Section 5.2.4.1 AVS Support)

Regards,
Manorit

> 
> >
> > AVS Test for J721S2: https://gist.github.com/manorit2001/b2fd9f6764a863294d4aa0755c83c84f
> > Boot Test results: https://gist.github.com/manorit2001/15e45f6c421aeeb93effde023a537762
> >
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> > Changes in v4:
> >
> > * Udit
> > - Use the compatible for finding the node rather than alias.
> > - Remove debug print
> > - Add ret value in error prints
> >
> > - Link to v3: https://lore.kernel.org/r/20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com
> >
> > ---
> > Manorit Chawdhry (7):
> >       power: pmic: tps65941: Add DM_PMIC dependency
> >       drivers: misc: k3_avs: Check return code while programming AVS
> >       arm: dts: k3-j7*-r5: Add MPU clock in clocks property
> >       drivers: misc: k3_avs: Extract MPU clk and dev ID from DT
> >       arm: mach-k3: j721s2_init: Initialize AVS Class 0
> >       arm: dts: j721s2: Add VTM node in R5
> >       configs: j721s2_evm_r5_defconfig: Add AVS Configs
> >
> >  arch/arm/dts/k3-am69-r5-sk.dts                  |  3 +-
> >  arch/arm/dts/k3-j7200-r5-common-proc-board.dts  |  3 +-
> >  arch/arm/dts/k3-j721e-r5.dtsi                   |  3 +-
> >  arch/arm/dts/k3-j721s2-r5-common-proc-board.dts |  9 ++++++
> >  arch/arm/dts/k3-j721s2-r5.dtsi                  |  3 +-
> >  arch/arm/dts/k3-j784s4-r5-evm.dts               |  3 +-
> >  arch/arm/mach-k3/j721s2/j721s2_init.c           | 10 +++++++
> >  configs/am68_sk_r5_defconfig                    |  4 +++
> >  configs/j721s2_evm_r5_defconfig                 |  6 ++++
> >  drivers/misc/k3_avs.c                           | 40 ++++++++++++++++++++++++-
> >  drivers/power/pmic/Kconfig                      |  1 +
> >  11 files changed, 79 insertions(+), 6 deletions(-)
> > ---
> > base-commit: 3a0b829efc35227b1079a444f00e0729502197ad
> > change-id: 20240130-b4-upstream-j721s2-avs-8c187d3fe26a
> >
> > Best regards,
> > --
> > Manorit Chawdhry <m-chawdhry@ti.com>
> >
> 
> Regards,
> Simon
