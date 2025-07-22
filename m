Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1274EC83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DBAF83837;
	Tue, 22 Jul 2025 13:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uWXYIKBE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B097683847; Tue, 22 Jul 2025 13:57:03 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 388FE833D1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56MBurFW1486708;
 Tue, 22 Jul 2025 06:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753185413;
 bh=SFLD1APaKj6QEBTpuMookUmQ0l4sb3QKoro3UpksuyI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=uWXYIKBEwxB19rAVllmZfxOYtY+bM8CrJaWvUiz4IDjU+Ha0AUQGh2Ku5KdFSWlea
 awfB0sfZRG2aNuzHY5lylDFHlliZ79wskfvIHFTwB/S8qgCp2zOIBRtGk1exKlOwyA
 imYf52fDR+4oRrFK0HZdgBgnOT89FJudXiiz0N9o=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56MBurNp4077608
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 22 Jul 2025 06:56:53 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 22
 Jul 2025 06:56:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 22 Jul 2025 06:56:53 -0500
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.142])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56MBuphg1282248;
 Tue, 22 Jul 2025 06:56:52 -0500
Date: Tue, 22 Jul 2025 17:26:51 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom
 Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Vignesh R
 <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77Q51NW
Message-ID: <20250722115651.exaefgcx5vlnvo6o@prasanth-server>
References: <20250720195901.414083-1-marek.vasut+renesas@mailbox.org>
 <20250721120312.5kxfgbkpsn7336yf@prasanth-server>
 <15ad286d-dd84-4594-b7d7-2d79fcda4dc2@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <15ad286d-dd84-4594-b7d7-2d79fcda4dc2@mailbox.org>
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

On 18:17, Marek Vasut wrote:
> On 7/21/25 2:03 PM, Prasanth Mantena wrote:
> 
> Hi,
> 
> > > diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> > > index e7e97780d7c..0383175beb5 100644
> > > --- a/drivers/mtd/spi/spi-nor-ids.c
> > > +++ b/drivers/mtd/spi/spi-nor-ids.c
> > > @@ -591,6 +591,7 @@ const struct flash_info spi_nor_ids[] = {
> > >   	{ INFO("w25m512jw", 0xef6119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > >   	{ INFO("w25m512jv", 0xef7119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > >   	{ INFO("w25h02jv", 0xef9022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > > +	{ INFO("w77q51nw", 0xef8a1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> > 
> > Hi Marek,
> > 
> > Is there a place where we can refer to the datasheet.
> 
> Please ask Winbond .
> 
> > According to commit message, Its similar flash part W25Q512NWM seems
> > to have 4Byte address mode but capability is not seen in the code [0].
> > Is this some limitation that goes with this flash as well.
> > 
> > [0] https://elixir.bootlin.com/u-boot/v2025.07/source/drivers/mtd/spi/spi-nor-ids.c#L553
> W25Q512NWM should be updated with SPI_NOR_4B_OPCODES too, that's for
> separate patch, but someone would have to test such patch on that flash.
Understood.

Thanks,
Prasanth
