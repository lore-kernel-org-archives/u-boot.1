Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7192C83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 11:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0068C82F6F;
	Tue, 15 Jul 2025 13:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X7Zx5Ws+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C4AB82F8F; Tue, 15 Jul 2025 13:20:07 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4BEB82BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 13:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56FBJirV2600831;
 Tue, 15 Jul 2025 06:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752578384;
 bh=cP6KVHdK3glbpzP/BsCbvm5PUgaMNWg5LToGlWmkXGE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=X7Zx5Ws+ArpEPyftO1YTFkG2tKQ0YxgvZrtwfUOi4jbr3m0lzQEyxhsasxu28kJ8G
 ElN+symYOrH80faG1C9qn/++EP4SBoehQC8kqdjOs5mUDctnDouKEc+x6DXOwrNOmH
 hw4cO9d/HB5qtZZq5vljZ+Epqc3My8FcuPLuSQj8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56FBJi6x1221320
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 15 Jul 2025 06:19:44 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 06:19:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 06:19:44 -0500
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.142])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56FBJhcY2464882;
 Tue, 15 Jul 2025 06:19:43 -0500
Date: Tue, 15 Jul 2025 16:49:42 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
CC: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, 
 <marex@denx.de>, <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <trini@konsulko.com>,
 <seanga2@gmail.com>, <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <git@amd.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Subject: Re: [PATCH v2] spi: cadence_qspi: Fix odd byte write issue in STIG
 mode
Message-ID: <20250715111942.hjk5vjapxa5yrf47@prasanth-server>
References: <20250704040444.671604-1-venkatesh.abbarapu@amd.com>
 <20250709082136.aiq63w4br3cyjxao@prasanth-server>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250709082136.aiq63w4br3cyjxao@prasanth-server>
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

On 13:51, Prasanth Mantena wrote:
> On 09:34, Venkatesh Yadav Abbarapu wrote:
> > Starting from 'commit <8077d296adff> ("spi: cadence-quadspi: Use STIG
> > mode for all ops with small payload") the utilization of STIG mode
> > has been implemented for read and write operations involving less
> > than 8 bytes of data.
> > 
> > However, following this commit, encountering timeout issues occurs when
> > writing odd bytes of data in DDR mode, as indicated below:
> > "jedec_spi_nor flash@0: flash operation timed out
> > SF: 3 bytes @ 0x0 Written: ERROR -110"
> > 
> > To resolve this issue, the number of bytes to write has been updated
> > specifically for DDR mode.
> > 
> > Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> > ---
> > Changes in v2:
> > -Modified the logic from using modulus and changed to use "logical and" 
> > operator to check the odd bytes.
> > ---
> >  drivers/spi/cadence_qspi_apb.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> > index b579699d2eb..76569a8019b 100644
> > --- a/drivers/spi/cadence_qspi_apb.c
> > +++ b/drivers/spi/cadence_qspi_apb.c
> > @@ -554,6 +554,9 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
> >  	void *reg_base = priv->regbase;
> >  	u8 opcode;
> >  
> > +	if (priv->dtr)
> > +		txlen += txlen & 1;
> > +
> 
> Hi Venkatesh,
> 
> 1> Is this not a generic problem, having a DTR write in stig mode. If so,
> shouldn't this be handled at the spi-nor core level.
> 
> 2> You are just increasing the number of bytes here, aren't we writing
> an unwanted extra data ? Where did we pad the buffer ?
>

NACK. Considering the issues that this can cause, referring the above comments.
Michal Simek, my request is to please wait for some comment / review for
the common code like this, considering this merge was quick.

Thanks,
Prasanth
 
> 
> Thanks,
> Prasanth
> 
> >  	if (priv->dtr)
> >  		opcode = op->cmd.opcode >> 8;
> >  	else
> > -- 
> > 2.34.1
> > 
