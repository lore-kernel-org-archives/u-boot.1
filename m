Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B466C83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 05:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73B948211F;
	Mon, 14 Jul 2025 07:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l7Jq5YBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00AD82B07; Mon, 14 Jul 2025 07:38:02 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AAD081FEE
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 07:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56E5bU361946408;
 Mon, 14 Jul 2025 00:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752471450;
 bh=/TRLE9fcIAvUV7XSSLl36+Rduf04XVWOEXiVe+4zmNc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=l7Jq5YBpqDg4V07ym6vV+KeYK2max5y/vbYfDkBsvS4MXMOvPaoLkpSERRP51IaZn
 wdp0nnAZebLh8G4t8ao7VvcWocUE/yNqF6FZOD5/78sXJQlbXQ5HgMMSthd+5wMUhc
 GEaZUrFOUhmsc8iuSiIXvvU75YBrGsMMJvAu331Y=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56E5bUCW2962429
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 14 Jul 2025 00:37:30 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 14
 Jul 2025 00:37:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 14 Jul 2025 00:37:29 -0500
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.142])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56E5bS2N4094567;
 Mon, 14 Jul 2025 00:37:29 -0500
Date: Mon, 14 Jul 2025 11:07:28 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "tudor.ambarus@linaro.org"
 <tudor.ambarus@linaro.org>, "j-humphreys@ti.com" <j-humphreys@ti.com>,
 "marex@denx.de" <marex@denx.de>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>, "git
 (AMD-Xilinx)" <git@amd.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: Re: [PATCH] spi: cadence_qspi: Set tshsl_ns to at least one sclk_ns
Message-ID: <20250714053728.be6v7vhyb6vmyrpi@prasanth-server>
References: <20250702065717.3871435-1-venkatesh.abbarapu@amd.com>
 <98275d4d-0644-4fc8-9ff6-8d5b8622fd9f@amd.com>
 <20250710203015.ocrira24b2la2or2@prasanth-server>
 <SA1PR12MB8697C766FADC9E623BE769C3984BA@SA1PR12MB8697.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8697C766FADC9E623BE769C3984BA@SA1PR12MB8697.namprd12.prod.outlook.com>
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

On 15:12, Abbarapu, Venkatesh wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Prasanth,
> 
> > -----Original Message-----
> > From: Prasanth Mantena <p-mantena@ti.com>
> > Sent: Friday, July 11, 2025 2:00 AM
> > To: Simek, Michal <michal.simek@amd.com>
> > Cc: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.de;
> > tudor.ambarus@linaro.org; j-humphreys@ti.com; marex@denx.de;
> > jagan@amarulasolutions.com; vigneshr@ti.com; u-kumar1@ti.com;
> > trini@konsulko.com; seanga2@gmail.com; caleb.connolly@linaro.org;
> > sjg@chromium.org; william.zhang@broadcom.com; stefan_b@posteo.net;
> > quentin.schulz@cherry.de; Takahiro.Kuwano@infineon.com; git (AMD-Xilinx)
> > <git@amd.com>; Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> > Subject: Re: [PATCH] spi: cadence_qspi: Set tshsl_ns to at least one sclk_ns
> >
> > On 15:07, Michal Simek wrote:
> > >
> > >
> > > On 7/2/25 08:57, Venkatesh Yadav Abbarapu wrote:
> > > > tshsl_ns is the clock delay for chip select deassert. This is the
> > > > delay in master reference clocks for the length that the master mode
> > > > chip select outputs are de-asserted between transactions.
> > > >
> > > > The minimum delay is always SCLK period to ensure the chip select is
> > > > never re-asserted within one SCLK period.
> > > >
> > > > That is why tshsl_ns delay should be at least one sclk_ns value. If
> > > > it is less than sclk_ns, set it equal to sclk_ns.
> > > >
> > > > Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> > > > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> > > > ---
> > > >   drivers/spi/cadence_qspi_apb.c | 4 ++++
> > > >   1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/spi/cadence_qspi_apb.c
> > > > b/drivers/spi/cadence_qspi_apb.c index 65fb2d8f9fb..4696c09f754
> > > > 100644
> > > > --- a/drivers/spi/cadence_qspi_apb.c
> > > > +++ b/drivers/spi/cadence_qspi_apb.c
> > > > @@ -303,6 +303,10 @@ void cadence_qspi_apb_delay(void *reg_base,
> > > >                   tshsl_ns -= sclk_ns + ref_clk_ns;
> > > >           if (tchsh_ns >= sclk_ns + 3 * ref_clk_ns)
> > > >                   tchsh_ns -= sclk_ns + 3 * ref_clk_ns;
> > > > +
> > > > + if (tshsl_ns < sclk_ns)
> > > > +         tshsl_ns = sclk_ns;
> > > > +
> >
> > Hi Venkatesh,
> >
> > Just referring to the Controller datasheet, I found this in the register map for the tshsl
> > delay register field.
> >
> > Ref : 2.3.4. Device Delay Register
> > "
> > The minimum delay for chip select to be de-asserted (CSDA=0)
> > is:
> > 1 sclk_out + 1 ref_clk to ensure the chip select is never re- asserted within an
> > sclk_out period.
> >
> > "
> > if this delay configured is exactly equals to sclk_out, and if sclk_out roundsup exactly
> > to ref_clk without a headroom, then the next transaction would start right after next
> > spike, unless if the controller adds any delay apart from whats configured in this
> > register.
> > May be thats why it is having that one ref_clk tick extra added acc to reg map.
> > Please help me understand this.
> >
> > Thanks,
> > Prasanth
> 
> If the calculated tshsl_ns value (after potentially subtracting the inherent delay) falls below sclk_ns, this forces it up to sclk_ns. This ensures that even if your initial request or the controller's base delay logic could result in a shorter actual delay, the minimum 1 SCLK idle time is always guaranteed by overriding it. Ensures CS# remains asserted long enough for the slave device to properly latch data. Avoids signal integrity issues due to too short hold times.
> 
> Thanks
> Venkatesh

Hi Venkatesh,

I understood the purpose of the override that is being done here. When
you are overriding it equal to sck_ns, what I understand is it should
have been with one more ref_clk_ns along with the sclk_out_ns
considering the data/next transaction has been given a ref_clk_ns
buffer. I have put the quoted text in previous reply, where the register
map of the controller states it to be minimum "1 sclk_out + 1 ref_clk".
Thats straight out of the controller document. Can you please justify,
why is ref_clk_ns would not be needed.

Thanks
Prasanth

> >
> >
> > > >           tshsl = DIV_ROUND_UP(tshsl_ns, ref_clk_ns);
> > > >           tchsh = DIV_ROUND_UP(tchsh_ns, ref_clk_ns);
> > > >           tslch = DIV_ROUND_UP(tslch_ns, ref_clk_ns);
> > >
> > > Applied.
> > > M
