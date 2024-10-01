Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC38CE7CE7
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 08:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1688389141;
	Tue,  1 Oct 2024 10:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S8oRgycL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 160DF89163; Tue,  1 Oct 2024 10:47:39 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8CF788B1F
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 10:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4918lZvt001341;
 Tue, 1 Oct 2024 03:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727772455;
 bh=Ji+pLdQf4Udcv3LFRLCuQf0M19hN1ylS6FaU90ntivU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=S8oRgycLTC5o4+pQkDfKaQiUDr4bioeIq1WtGs+9PNmv2Uydb9Eq/hSICG8Y25n6w
 kiGe3hO9UhFdyrtRnnfbBLFbbmnxlJvLv3IHNUZJxPtLqT+tm1qVlwYGRdzKBhqjiV
 knVpJUR4zmglW/fBlVZE5dEdUUCDh1qsaQx/rCbw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4918lZV8125273
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 1 Oct 2024 03:47:35 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Oct 2024 03:47:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Oct 2024 03:47:34 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4918lXQW082003;
 Tue, 1 Oct 2024 03:47:34 -0500
Date: Tue, 1 Oct 2024 14:17:33 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 4/7] drivers: misc: k3_avs: Extract MPU clk and dev ID
 from DT
Message-ID: <20241001084733.ktsjon3xmz6hjrae@uda0497581>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
 <20240813-b4-upstream-j721s2-avs-v3-4-5115d93cdeb2@ti.com>
 <32099394-56f3-4eeb-b4f1-f9c8786c84a6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <32099394-56f3-4eeb-b4f1-f9c8786c84a6@ti.com>
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

On 08:44-20240815, Kumar, Udit wrote:
> 
> On 8/13/2024 11:40 AM, Manorit Chawdhry wrote:
> > Different devices have different MPU clk and dev ID. Currently it had
> > been hardcoded. Move it to DT based extraction.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   drivers/misc/k3_avs.c | 37 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 37 insertions(+)
> > 
> > diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
> > index 568cf5b20d51..f94eee5b1c64 100644
> > --- a/drivers/misc/k3_avs.c
> > +++ b/drivers/misc/k3_avs.c
> > @@ -352,6 +352,9 @@ static int k3_avs_probe(struct udevice *dev)
> >   	struct k3_avs_privdata *priv;
> >   	struct vd_data *vd;
> >   	int ret;
> > +	ofnode node;
> > +	struct ofnode_phandle_args phandle_args;
> > +	int i = 0;
> >   	priv = dev_get_priv(dev);
> >   	priv->dev = dev;
> > @@ -367,6 +370,34 @@ static int k3_avs_probe(struct udevice *dev)
> >   		return -ENODEV;
> >   	for (vd = priv->vd_config->vds; vd->id >= 0; vd++) {
> > +		/* Get the clock and dev id for Jacinto platforms */
> > +		if (vd->id == J721E_VDD_MPU) {
> > +			node = ofnode_get_aliases_node("remoteproc1");
> 
> My suggestion will be to search node based upon compatible name am654-rproc

Yes, that seems like a good idea, let me try that.

> 
> 
> > +			if (!ofnode_valid(node))
> > +				return -ENODEV;
> > +
> > +			i = ofnode_stringlist_search(node, "clock-names", "core");
> > +			if (i < 0)
> > +				return -ENODEV;
> > +
> > +			debug("%s: i: %d\n", __func__, i);
> 
> I assume this was for your debug only, Please see if you can remove this

Ack.

Regards,
Manorit
