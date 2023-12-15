Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F98AC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 06:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46CF787B35;
	Fri, 15 Dec 2023 07:25:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xWRJ+H5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3FF587A93; Fri, 15 Dec 2023 07:25:30 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AFA087B25
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 07:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BF6PMx3079537;
 Fri, 15 Dec 2023 00:25:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702621522;
 bh=t8btuuAPStPG5gMlYSKZ6tePxyu4FBbOF18CANvw+94=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=xWRJ+H5Lue1BAJFNpJtb1lp3L5qlaG4DDLmwXaKkMnT6HZBwmRHN5U/s+f//Al6dh
 32rUn2hIxKwrYQ6B7bZQR3BD38LWLVqPS1aUOcUAL4rmpRgYjQS4PuduOTzWVZPYNP
 y62OUtOoy9xilQsWYe1dwDUES3VMSs0zKa1npMuY=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BF6PMKn086684
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Dec 2023 00:25:22 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Dec 2023 00:25:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Dec 2023 00:25:21 -0600
Received: from localhost (uda0496754.dhcp.ti.com [172.24.227.218])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BF6PLoH122203;
 Fri, 15 Dec 2023 00:25:21 -0600
Date: Fri, 15 Dec 2023 11:55:20 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <matwey.kornilov@gmail.com>, <jkridner@beagleboard.org>,
 <robertcnelson@gmail.com>, <u-boot@lists.denx.de>, <nm@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-nandan@ti.com>
Subject: Re: [PATCH v3] board: ti: common: board_detect: Fix EEPROM offset
 read for 1-byte
Message-ID: <20231215062519.5yb2x7ecek2imrbu@uda0496754>
References: <20231030170458.21668-1-p-mantena@ti.com>
 <9f562302-3fb5-4b79-acec-5bf6f201f29f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9f562302-3fb5-4b79-acec-5bf6f201f29f@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 15:15-20231107, Neha Malcom Francis wrote:
> Hi Prasanth,
> 
> On 30/10/23 22:34, Prasanth Babu Mantena wrote:
> > EEPROM detection logic in ti_i2c_eeprom_get() involves reading
> > the total size and the 1-byte size with an offset 1. The commit
> > 9f393a2d7af8 ("board: ti: common: board_detect: Fix EEPROM read
> > quirk for 2-byte") that attempts to fix this uses a wrong pointer to
> > compare.
> > 
> > The value with one offset is read into offset_test, but the pointer
> > used to match was still ep, resulting in an invalid comparison of the
> > values. The intent is to identify bad 2-byte addressing eeproms that
> > get stuck on the successive reads.
> > 
> > Fixes: 9f393a2d7af8 (board: ti: common: board_detect: Fix EEPROM read quirk for 2-byte)
> > Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> > Tested-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
> > ---
> > v3 <--> v2:
> > Improved and concise commit description.
> > 
> > v2 <--> v1:
> > Fix inplace for the else condition of CONFIG_IS_ENABLED(DM_I2C).
> > Improved commit message.
> > 
> >   board/ti/common/board_detect.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
> > index 9a53884c98..869f7a47f8 100644
> > --- a/board/ti/common/board_detect.c
> > +++ b/board/ti/common/board_detect.c
> > @@ -128,7 +128,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int bus_addr, int dev_addr,
> >   	rc = dm_i2c_read(dev, 0x1, &offset_test, sizeof(offset_test));
> > -	if (*((u32 *)ep) != (header & 0xFF))
> > +	if (offset_test != ((header >> 8) & 0xFF))
> >   		one_byte_addressing = false;
> >   	/* Corrupted data??? */
> > @@ -180,7 +180,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int bus_addr, int dev_addr,
> >   	rc = i2c_read(dev_addr, 0x1, byte, &offset_test, sizeof(offset_test));
> > -	if (*((u32 *)ep) != (header & 0xFF))
> > +	if (offset_test != ((header >> 8) & 0xFF))
> >   		one_byte_addressing = false;
> >   	/* Corrupted data??? */
> 
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> 

Can this patch be considered for merge considering no further comments.

Regards,
Prasanth



> -- 
> Thanking You
> Neha Malcom Francis
