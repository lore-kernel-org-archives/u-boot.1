Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29085C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 807B3839AD;
	Thu, 10 Apr 2025 11:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pJY3icQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6423A83A6B; Thu, 10 Apr 2025 11:58:22 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E6F2830E4
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53A9wGAd1745204
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 04:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744279097;
 bh=/U8aAH1bpwMRupshzfPO3iBQRqwV04gm1WnH3T/3VXk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=pJY3icQrjV961RRKMEOq3kPChaJVlSk8woz7WV+HtCUo8yrgEpy4s7U+p+hjJl2xw
 sH/h5mlB1mHGZDlyPKZIcMjnp7WO8XJad9rdEaDBDTeZSviTOt2kimqqctCgmpd/E4
 lhptHQ5ajPZimQOc+yU5vnLHJoC1Hczyq0hVXr4Q=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53A9wGaL038694
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Apr 2025 04:58:16 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Apr 2025 04:58:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Apr 2025 04:58:16 -0500
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53A9wFPc088391;
 Thu, 10 Apr 2025 04:58:16 -0500
Date: Thu, 10 Apr 2025 15:28:15 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>, Jagan
 Teki <jagan@amarulasolutions.com>, <j-humphreys@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>
Subject: Re: [PATCH] mtd: spi-nor-core: Fixup SNOR_F_IO_MODE_EN_VOLATILE for
 MT35X
Message-ID: <20250410095815.a7ozc6mjakp4q4ai@prasanth-server>
References: <20241125104947.1324824-1-p-mantena@ti.com>
 <ea5abd4c-1f18-44f2-b44c-1b4014ceb5cb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ea5abd4c-1f18-44f2-b44c-1b4014ceb5cb@ti.com>
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

On 21:57, Kumar, Udit wrote:
> Thanks for fix
> 
> On 11/25/2024 4:19 PM, Prasanth Babu Mantena wrote:
> > From: Vaishnav Achath <vaishnav.a@ti.com>
> > 
> > MT35XU512ABA has only BFPT and 4-Byte Address Instruction Table
> > in  SFDP. commit bebdc237507c ("mtd: spi-nor: Parse SFDP SCCR Map")
> > added checks in spi_nor_octal_dtr_enable() to bail out if the 22nd DWORD
> > in SCCR does not indicate DTR Octal Mode Enable, since MT35XU512ABA device
> > supports octal DTR mode, add this property in SFDP fixup.
> > 
> > Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> > Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> > ---
> > 
> > Test results : https://gist.github.com/PrasanthBabuMantena/678cbd7a230a4e2d19e22d20dfeb1235
> > 
> >   drivers/mtd/spi/spi-nor-core.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> > index ec841fb13bd..6364d91fac0 100644
> > --- a/drivers/mtd/spi/spi-nor-core.c
> > +++ b/drivers/mtd/spi/spi-nor-core.c
> > @@ -4109,6 +4109,12 @@ static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor,
> >   	params->rdsr_dummy = 8;
> >   	params->rdsr_addr_nbytes = 0;
> > +	/*
> > +	 * SCCR Map 22nd DWORD does not indicate DTR Octal Mode Enable
> > +	 * for MT35XU512ABA but is actually supported by device.
> > +	 */
> > +	nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
> > +
> 
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> 
> + jagan@amarulasolutions.com, not sure, if this needs to go through SPI
> branch

Jagan, Tom Any more updates needed for this patch regarding the branch ?

Regards,
Prasanth

> 
> 
> >   	/*
> >   	 * The BFPT quad enable field is set to a reserved value so the quad
> >   	 * enable function is ignored by spi_nor_parse_bfpt(). Make sure we
