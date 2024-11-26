Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6100D5A6E2
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 05:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BEC3896C1;
	Tue, 26 Nov 2024 06:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g0ZcMseZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4AA389634; Tue, 26 Nov 2024 06:08:25 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C5D889634
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 06:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ589Sg117680;
 Mon, 25 Nov 2024 23:08:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732597689;
 bh=yzm0n7Ti0BggBq9yhBuqsrsWGLHnAxX988XyzlIFm1o=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=g0ZcMseZkiVTmLsQMf1nLUKEH7qIF1kcdAerYdpNFnzLOxyeks2AA3IxarwPVrg2g
 nEgYQn/0JqH+QgrGYou93NZBm7g/Ryq25g9id+/rEYKIyfZYHW5gwrun4P3Btfziz0
 TkRHqz5tm8E6V01uMAt1pERVGL5HQUBtfhw7l+n4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ5897v031325;
 Mon, 25 Nov 2024 23:08:09 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Nov 2024 23:08:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Nov 2024 23:08:09 -0600
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ588Hv078909;
 Mon, 25 Nov 2024 23:08:09 -0600
Date: Tue, 26 Nov 2024 10:38:08 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "j-humphreys@ti.com"
 <j-humphreys@ti.com>, "Simek, Michal" <michal.simek@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>, "git
 (AMD-Xilinx)" <git@amd.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: Re: [PATCH] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
 flashes
Message-ID: <20241126050808.yvezx37spuxnxucu@prasanth-server>
References: <20241122092619.1376234-1-venkatesh.abbarapu@amd.com>
 <20241125084919.e3mr4nwmoecqj3y7@prasanth-server>
 <SA1PR12MB8697E660E054185666B19C17982E2@SA1PR12MB8697.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8697E660E054185666B19C17982E2@SA1PR12MB8697.namprd12.prod.outlook.com>
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

On 09:12, Abbarapu, Venkatesh wrote:
Hi Venkatesh,

> Hi Prasanth,
> 
> > -----Original Message-----
> > From: Prasanth Mantena <p-mantena@ti.com>
> > Sent: Monday, November 25, 2024 2:19 PM
> > To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>
> > Cc: u-boot@lists.denx.de; j-humphreys@ti.com; Simek, Michal
> > <michal.simek@amd.com>; jagan@amarulasolutions.com; vigneshr@ti.com; u-
> > kumar1@ti.com; trini@konsulko.com; seanga2@gmail.com;
> > caleb.connolly@linaro.org; sjg@chromium.org; william.zhang@broadcom.com;
> > stefan_b@posteo.net; quentin.schulz@cherry.de; tudor.ambarus@linaro.org;
> > Takahiro.Kuwano@infineon.com; git (AMD-Xilinx) <git@amd.com>; Ashok Reddy
> > Soma <ashok.reddy.soma@amd.com>
> > Subject: Re: [PATCH] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
> > flashes
> > 
> > On 14:56, Venkatesh Yadav Abbarapu wrote:
> > Hi Venkatesh,
> > > Enable mt35xu512aba_fixups for all mt35 series flashes to work in DTR
> > > mode, and return after nor->fixups is updated, otherwise it will get
> > > overwritten with macronix_octal_fixups.
> > > This flash works in DTR mode only if CONFIG_SPI_FLASH_MT35XU is
> > > enabled and SPI_NOR_OCTAL_DTR_READ flag is set in id table.
> > >
> > > Additionally, a new flag, "SPI_XFER_SET_DDR", has been introduced to
> > > instruct the OSPI controller driver to switch to DDR mode.
> > >
> > > Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> > > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> > > ---
> > >  drivers/mtd/spi/spi-nor-core.c | 8 +++++++-
> > >  include/spi.h                  | 1 +
> > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mtd/spi/spi-nor-core.c
> > > b/drivers/mtd/spi/spi-nor-core.c index ec841fb13b..8d201433d5 100644
> > > --- a/drivers/mtd/spi/spi-nor-core.c
> > > +++ b/drivers/mtd/spi/spi-nor-core.c
> > > @@ -4073,6 +4073,7 @@ static int spi_nor_micron_octal_dtr_enable(struct
> > spi_nor *nor)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > +	nor->spi->flags |= SPI_XFER_SET_DDR;
> > >  	buf = SPINOR_MT_OCT_DTR;
> > >  	op = (struct spi_mem_op)
> > >
> > 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
> > @@ -4404,8
> > > +4405,13 @@ void spi_nor_set_fixups(struct spi_nor *nor)  #endif
> > >
> > >  #ifdef CONFIG_SPI_FLASH_MT35XU
> > > -	if (!strcmp(nor->info->name, "mt35xu512aba"))
> > > +	if (!strcmp(nor->info->name, "mt35xu512aba") ||
> > > +	    !strcmp(nor->info->name, "mt35xl512aba") ||
> > > +	    !strcmp(nor->info->name, "mt35xu01g") ||
> > > +	    !strcmp(nor->info->name, "mt35xu02g")) {
> > >  		nor->fixups = &mt35xu512aba_fixups;
> > > +		return;
> > > +	}
> > >  #endif
> > >
> > >  #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
> > > diff --git a/include/spi.h b/include/spi.h index
> > > 6944773b59..d7fef36662 100644
> > > --- a/include/spi.h
> > > +++ b/include/spi.h
> > > @@ -164,6 +164,7 @@ struct spi_slave {
> > >  #define SPI_XFER_U_PAGE		BIT(4)
> > >  #define SPI_XFER_STACKED	BIT(5)
> > >  #define SPI_XFER_LOWER		BIT(6)
> > > +#define SPI_XFER_SET_DDR	BIT(7)
> > 
> > Are we using this anywhere in the Controller driver ? What is the significance of this
> > flag, when we can send the DDR info through the ops.
> Yes...we will be checking this 
> If (spi->flags & SPI_XFER_SET_DDR) && op->cmd.dtr) then 
> 	setup the DDR mode in controller driver.

Is this change going to be for every read/write exec op or in some init
function. Current driver has this setup dtr mode on checking the opcode.
Curious to know, what does this extra flag bring something new to the driver.

Prasanth

> 
> I need to send the controller change series.
> 
> Thanks
> Venkatesh
> > 
> > >
> > >  	/*
> > >  	 * Flag indicating that the spi-controller has multi chip select
> > > --
> > > 2.25.1
> > >
> > >
