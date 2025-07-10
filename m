Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B69C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 20:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863F5835C9;
	Thu, 10 Jul 2025 22:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RmBPmDRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9AF683666; Thu, 10 Jul 2025 22:30:37 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A503835C9
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 22:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56AKUHPW1835337;
 Thu, 10 Jul 2025 15:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752179418;
 bh=pS05TqDPRV7+1NIh81moftcBBXWGWME6NVd5U0X/kYs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=RmBPmDRExwMTKE/61Ifnw4j/4K8DiuLkSd4pywskikU0I+yG/U+OWfYRSvuQffkhM
 2LJcs0ZhsUSKGKlDaA2FmZPkt9Py0XfsJisPbcjzvwCF8NUCNVHwXMaQ3ADavTTJZL
 ZStK2TAcaQWlIM08oUin+tYTSfmF5B9euCHNlXas=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56AKUHj81561784
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 10 Jul 2025 15:30:17 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 10
 Jul 2025 15:30:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 10 Jul 2025 15:30:16 -0500
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.142])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56AKUGG01957935;
 Thu, 10 Jul 2025 15:30:16 -0500
Date: Fri, 11 Jul 2025 02:00:15 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Michal Simek <michal.simek@amd.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>,
 <j-humphreys@ti.com>, <marex@denx.de>, <jagan@amarulasolutions.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <trini@konsulko.com>,
 <seanga2@gmail.com>, <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <git@amd.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: Re: [PATCH] spi: cadence_qspi: Set tshsl_ns to at least one sclk_ns
Message-ID: <20250710203015.ocrira24b2la2or2@prasanth-server>
References: <20250702065717.3871435-1-venkatesh.abbarapu@amd.com>
 <98275d4d-0644-4fc8-9ff6-8d5b8622fd9f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <98275d4d-0644-4fc8-9ff6-8d5b8622fd9f@amd.com>
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

On 15:07, Michal Simek wrote:
> 
> 
> On 7/2/25 08:57, Venkatesh Yadav Abbarapu wrote:
> > tshsl_ns is the clock delay for chip select deassert. This is the delay in
> > master reference clocks for the length that the master mode chip select
> > outputs are de-asserted between transactions.
> > 
> > The minimum delay is always SCLK period to ensure the chip select is never
> > re-asserted within one SCLK period.
> > 
> > That is why tshsl_ns delay should be at least one sclk_ns value. If it is
> > less than sclk_ns, set it equal to sclk_ns.
> > 
> > Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> > ---
> >   drivers/spi/cadence_qspi_apb.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> > index 65fb2d8f9fb..4696c09f754 100644
> > --- a/drivers/spi/cadence_qspi_apb.c
> > +++ b/drivers/spi/cadence_qspi_apb.c
> > @@ -303,6 +303,10 @@ void cadence_qspi_apb_delay(void *reg_base,
> >   		tshsl_ns -= sclk_ns + ref_clk_ns;
> >   	if (tchsh_ns >= sclk_ns + 3 * ref_clk_ns)
> >   		tchsh_ns -= sclk_ns + 3 * ref_clk_ns;
> > +
> > +	if (tshsl_ns < sclk_ns)
> > +		tshsl_ns = sclk_ns;
> > +

Hi Venkatesh,

Just referring to the Controller datasheet, I found this in the
register map for the tshsl delay register field.

Ref : 2.3.4. Device Delay Register
"
The minimum delay for chip select to be de-asserted (CSDA=0)
is:
1 sclk_out + 1 ref_clk to ensure the chip select is never re-
asserted within an sclk_out period.

"
if this delay configured is exactly equals to sclk_out, and if sclk_out
roundsup exactly to ref_clk without a headroom, then the next
transaction would start right after next spike, unless if the controller
adds any delay apart from whats configured in this register.
May be thats why it is having that one ref_clk tick extra added acc to reg map.
Please help me understand this.

Thanks,
Prasanth


> >   	tshsl = DIV_ROUND_UP(tshsl_ns, ref_clk_ns);
> >   	tchsh = DIV_ROUND_UP(tchsh_ns, ref_clk_ns);
> >   	tslch = DIV_ROUND_UP(tslch_ns, ref_clk_ns);
> 
> Applied.
> M
