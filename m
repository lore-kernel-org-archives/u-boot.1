Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEF1CE7CE7
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 08:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 822CA89161;
	Tue,  1 Oct 2024 10:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Cvi8K88r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA48789167; Tue,  1 Oct 2024 10:48:57 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C92589141
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 10:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4918mrnd048245;
 Tue, 1 Oct 2024 03:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727772533;
 bh=knawTMkff8HDjJW0O1iLjsxK44iWYXTw/USRs2SLQHY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Cvi8K88rNHq2Lnjh/5KkhgYj/yZfckSm6Ip8OLxQe1yjLJ0H3n/LtDUE4iLvPNMeS
 wv204X7a2jk1G0xNeH0LEdBB++rJG9aKkQXWw9S6FcMYaMgR4QqeVXPuxSyV5M/fUm
 sBB5ao6n7QsCJyItx6PLaN6eol12a7w0nwJqlaoE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4918mrZG023087
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 1 Oct 2024 03:48:53 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Oct 2024 03:48:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Oct 2024 03:48:53 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4918mqrp049477;
 Tue, 1 Oct 2024 03:48:52 -0500
Date: Tue, 1 Oct 2024 14:18:52 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 5/7] arm: mach-k3: j721s2_init: Initialize AVS Class 0
Message-ID: <20241001084852.c4xc6y4c4gyunzmp@uda0497581>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
 <20240813-b4-upstream-j721s2-avs-v3-5-5115d93cdeb2@ti.com>
 <9ea12c2e-3fbf-4d32-9702-a97852a8ccde@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9ea12c2e-3fbf-4d32-9702-a97852a8ccde@ti.com>
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

Hi Udit,

On 08:46-20240815, Kumar, Udit wrote:
> 
> On 8/13/2024 11:40 AM, Manorit Chawdhry wrote:
> > Initialize AVS Class 0.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   arch/arm/mach-k3/j721s2/j721s2_init.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
> > index 05453fcad41a..5f5961a2c17a 100644
> > --- a/arch/arm/mach-k3/j721s2/j721s2_init.c
> > +++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
> > @@ -315,6 +315,9 @@ void do_dt_magic(void)
> >   #ifdef CONFIG_SPL_BUILD
> >   void board_init_f(ulong dummy)
> >   {
> > +	struct udevice *dev;
> > +	int ret;
> > +
> >   	k3_spl_init();
> >   #if defined(CONFIG_SPL_OF_LIST) && defined(CONFIG_TI_I2C_BOARD_DETECT)
> >   	do_dt_magic();
> > @@ -325,6 +328,13 @@ void board_init_f(ulong dummy)
> >   		setup_navss_nb();
> >   	setup_qos();
> > +
> > +	if (IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_AVS0)) {
> > +		ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(k3_avs),
> > +						  &dev);
> 
> Can we remove this ret, Something like

I would say we can let this remain, general convention of this file is
to have ret itself, I know it's only used in one place as of now but I
feel keeping it consistent is better IMO.

Regards,
Manorit
