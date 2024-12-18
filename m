Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48696E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CBCC8021D;
	Wed, 18 Dec 2024 13:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P/NlblIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 823C080274; Wed, 18 Dec 2024 13:54:02 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00FC88021A
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 13:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BICrvJj010193;
 Wed, 18 Dec 2024 06:53:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734526437;
 bh=M/ikH2bUOwmDdtf19hYwuTMWWeP1unKc8Nepx8njcLE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=P/NlblIBtTNIHdiaCE+2e/G5gda7BlOJ11vqZ7FrXzTQycbCGm39so5pwPBrQAVD6
 qQyx3BSlobwtkN4uieoP236483g7Rcz8crTtzDMH23WEqoWDtM3Qif5iMGD+RPJM3C
 Jj9u0aqFfcFVqXXao4cthwP1hwXyQHvkYAtf/I64=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BICrvN5112874
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2024 06:53:57 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 06:53:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 06:53:57 -0600
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.142])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BICruXa075211;
 Wed, 18 Dec 2024 06:53:57 -0600
Date: Wed, 18 Dec 2024 18:23:56 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <n-francis@ti.com>,
 <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: Re: [PATCH 1/4] mailbox: k3-sec-proxy: Add DM to DMSC communication
 thread for J722S
Message-ID: <20241218125356.t3kohjuic4c5zmhy@prasanth-server>
References: <20241210135731.1043269-1-p-mantena@ti.com>
 <20241210135731.1043269-2-p-mantena@ti.com>
 <c5514e5e-e86b-4360-8600-7e1dc94cd453@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c5514e5e-e86b-4360-8600-7e1dc94cd453@ti.com>
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

On 21:01, Kumar, Udit wrote:
Hi Udit,
> 
> On 12/10/2024 7:27 PM, Prasanth Babu Mantena wrote:
> > From: Vaishnav Achath <vaishnav.a@ti.com>
> > 
> > J722S R5 SPL uses sec-proxy threads 28 and 29 for communication with
> > TIFS. Mark these as valid threads in the driver.
> 
> Please mention doc link also,
> 
> Also is this only for R5 SPL
> 

Yes this is only for R5, as DM is not active on dmsc, in R5 stage, use dm_tifs
whose sec-proxy threads are specified in documentation.
https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j722s/sec_proxy.html
Will add this doc link in v2.

Thanks,
Prasanth

> 
> > Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> > Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> > ---
> >   drivers/mailbox/k3-sec-proxy.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mailbox/k3-sec-proxy.c b/drivers/mailbox/k3-sec-proxy.c
> > index 5eafe46fd4d..6f5ad37919f 100644
> > --- a/drivers/mailbox/k3-sec-proxy.c
> > +++ b/drivers/mailbox/k3-sec-proxy.c
> > @@ -408,7 +408,7 @@ static int k3_sec_proxy_remove(struct udevice *dev)
> >   	return 0;
> >   }
> > -static const u32 am6x_valid_threads[] = { 0, 1, 4, 5, 6, 7, 8, 9, 11, 12, 13, 20, 21, 22, 23 };
> > +static const u32 am6x_valid_threads[] = { 0, 1, 4, 5, 6, 7, 8, 9, 11, 12, 13, 20, 21, 22, 23, 28, 29 };
> >   static const struct k3_sec_proxy_desc am654_desc = {
> >   	.thread_count = 90,
