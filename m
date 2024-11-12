Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F54D42B83
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67BAB89426;
	Tue, 12 Nov 2024 14:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="qvLAYgty";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bY1EIKjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5883289431; Tue, 12 Nov 2024 14:57:48 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D444893C2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.spranger@linutronix.de
Date: Tue, 12 Nov 2024 14:57:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1731419866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ss90qWl/Qxk2e5xYh9eUgvPCBc3Di1ys9vJEXQY1FaI=;
 b=qvLAYgtypAwlfKhClKZlrzpWHyCwijpOyB2dr8FBHWwDoQFFtCt9FXOc6pvDqONyI6YuuC
 aHpokaW7pw5oBWMjMRP1m367cUvhWrPRit6BRszCJA12d6i8wHeEYQ98r5nPEJJjs6pjp8
 5rJlAL1CXgAf7VXC/0/zgZsvo0f/FPIgYAAzUeD8U8Suh5+umKKXmvOrnnxygc1gttmDdX
 g8BlpjTOhumcqoGu7uX9N2JDdQBjBkC2sfZihyj3EqNt6IMN4I0NRV4G2bsmMwfA8rouF/
 okLJp4pzYZ1C53zg6u7pERJ6eYFNntCa9DOFl+xKBkU+RdUR2loufRMWkV1l6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1731419866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ss90qWl/Qxk2e5xYh9eUgvPCBc3Di1ys9vJEXQY1FaI=;
 b=bY1EIKjU42/RVbQjsa4DJdVJI7qJq3cRJwQTf8XKW9Nmj3Y/g3VIJacFe6Boy+3Pz+fgHg
 NdexrtywwB/FdcAQ==
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: John Ogness <john.ogness@linutronix.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 4/5] mtd: nand: Update NAND manufacturer Ids
Message-ID: <20241112145745.72d14afc@mitra>
In-Reply-To: <56e48bdf-0dd0-469a-9acb-7c5b75c1a48e@linaro.org>
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018083006.10349-6-b.spranger@linutronix.de>
 <56e48bdf-0dd0-469a-9acb-7c5b75c1a48e@linaro.org>
Organization: Linutronix GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 12 Nov 2024 15:39:23 +0200
Eugen Hristev <eugen.hristev@linaro.org> wrote:

Hi Eugen,
> On 10/18/24 11:30, Benedikt Spranger wrote:
> > Align manufacturer Ids with the Id list from Linux kernel v6.11.
> > While at it, sort the entries in alphabetical order.
> > 
> > Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  drivers/mtd/nand/raw/nand_ids.c | 22 ++++++++++++----------
> >  include/linux/mtd/rawnand.h     | 23 +++++++++++++----------
> >  2 files changed, 25 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
> > index 4f46378ffe1..e40facf774c 100644
> > --- a/drivers/mtd/nand/raw/nand_ids.c
> > +++ b/drivers/mtd/nand/raw/nand_ids.c
> > @@ -180,20 +180,22 @@ struct nand_flash_dev nand_flash_ids[] = {
> >  
> >  /* Manufacturer IDs */
> >  struct nand_manufacturer nand_manuf_ids[] = {
> > -	{NAND_MFR_TOSHIBA, "Toshiba", &toshiba_nand_manuf_ops},
> > -	{NAND_MFR_SAMSUNG, "Samsung", &samsung_nand_manuf_ops},
> > +	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
> > +	{NAND_MFR_ATO, "ATO"},
> > +	{NAND_MFR_EON, "Eon"},
> > +	{NAND_MFR_EON, "ESMT"},
> 
> Did you mean NAND_MFR_ESMT here ?
Yes, fatfingered that...

Regards
    Benedikt Spranger
