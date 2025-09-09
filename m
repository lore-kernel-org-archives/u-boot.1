Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D096FCA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 10:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A88883106;
	Tue,  9 Sep 2025 12:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GE58hu2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D7CE8312A; Tue,  9 Sep 2025 12:18:21 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085CC830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 12:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589AI8eo266935;
 Tue, 9 Sep 2025 05:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757413088;
 bh=71ubt+jCdSjjJSMXuW43PyH5PBYrA+QgjOrC65VC/II=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=GE58hu2y3UC474VbFcjErQGCNdEnGPVHj2RP0wjMsLXCrte603xHGYNylO1wXu/OM
 XCWq7PXgBlmkXZz+3v67zOcnUMpZ1GpSJE5iFuQFMpOnBYDnqmqFlAaCdYNJkwdGlF
 84BuvcXPl+KOvejVY+T7/2ufoJJNnR5Q1xVQ7Jtw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589AI8J93708571
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 9 Sep 2025 05:18:08 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 05:18:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 05:18:07 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589AI65h2482912;
 Tue, 9 Sep 2025 05:18:07 -0500
Date: Tue, 9 Sep 2025 15:48:06 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Maxim Kochetkov <fido_max@inbox.ru>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, Peng Fan
 <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 2/2] clk: scmi: add compatibility for clock version
 3.0 and onwards
Message-ID: <20250909101806.bymqunywxu6pe33o@lcpd911>
References: <20250819-b4-scmi-v1-v3-0-360145076b3b@ti.com>
 <20250819-b4-scmi-v1-v3-2-360145076b3b@ti.com>
 <ccf326ff-b4d3-43f0-92df-07a22bd5c60e@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ccf326ff-b4d3-43f0-92df-07a22bd5c60e@inbox.ru>
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

On Aug 25, 2025 at 16:49:30 +0300, Maxim Kochetkov wrote:
> 19.08.2025 10:33, Kamlesh Gurudasani wrote:
> > Clock version 3.0 specified in ARM SCMI Platform design document
> > v3.2, adds extended_config_val parameter in CLOCK_CONFIG_SET.
> > 
> > The SCMI server with clock version 3.0 rejects the message if
> > they don't have this field.
> > 
> > Add support so that both SCMI server with clock version 2.0 and 3.0
> > can be handled.
> > 
> > Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> > ---
> >   drivers/clk/clk_scmi.c   | 43 ++++++++++++++++++++++++++++++-------------
> >   include/scmi_protocols.h |  6 ++++++
> >   2 files changed, 36 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> > index 83ea7bb4286..b33cc05685d 100644
> > --- a/drivers/clk/clk_scmi.c
> > +++ b/drivers/clk/clk_scmi.c
> > @@ -131,19 +131,36 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
> >   static int scmi_clk_gate(struct clk *clk, int enable)
> >   {
> > -	struct scmi_clk_state_in in = {
> > -		.clock_id = clk_get_id(clk),
> > -		.attributes = enable,
> > -	};
> > +	struct scmi_clock_priv *priv = dev_get_priv(clk->dev);
> 
> struct scmi_clock_priv *priv = dev_get_priv(clk->dev->parent);
> 

Could you elaborate?
I think clk->dev should be fine, similar to other instances in the same
file. Maybe I am missing something?

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
