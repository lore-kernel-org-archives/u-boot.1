Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A82BCE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 19:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843C086AA6;
	Tue, 19 Sep 2023 21:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kuTnqxLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A308D869AC; Tue, 19 Sep 2023 21:26:58 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382FC86B35
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 21:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JJQpAm005532;
 Tue, 19 Sep 2023 14:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695151611;
 bh=rt3jTU/XQsSVNFbvz3O7AzYJ62qD3aRNFxKoD8zAmVc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=kuTnqxLUpCL24MLvoem4xrhDUc/FUKcbqvz7ySJILsuYqgliSxOwY5rvpCXcSG3CA
 gzKti/kgullCO3wb3ZSF1fZu4Yh8zB9kYUxjJdo/LSB43zV1W6GssACMDRDelsB1nb
 wN6ubE1Pl0m70aygGnvee6e8ZWIPIKbN3bv26fEk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JJQpwK007721
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 14:26:51 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 14:26:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 14:26:50 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JJQoZF044644;
 Tue, 19 Sep 2023 14:26:50 -0500
Date: Tue, 19 Sep 2023 14:26:50 -0500
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: <vigneshr@ti.com>, <seanga2@gmail.com>, <u-boot@lists.denx.de>,
 <lukma@denx.de>, <bb@ti.com>, Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2] clk: ti: Notify AVS driver upon setting clock rate
Message-ID: <20230919192650.rvzjc5oo4vnsxo73@pliable>
References: <20230919140408.2608521-1-u-kumar1@ti.com>
 <20230919153720.6ydod4wicqwvz3tp@stegosaur>
 <19d60924-8b72-dd74-8836-5493bb17c7d3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19d60924-8b72-dd74-8836-5493bb17c7d3@ti.com>
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

On 22:58-20230919, Kumar, Udit wrote:
> Hi Nishanth,
> 
> On 9/19/2023 9:07 PM, Nishanth Menon wrote:
> > On 19:34-20230919, Udit Kumar wrote:
> > > AVS is enabled at R5 SPL stage, on few platforms like J721E
> > > and J7200 clk-k3 is used instead if clk-sci driver.
> > > 
> > > Add support in clk-k3 driver as well to notify AVS driver
> > > upon setting clock rate so that voltage is changed accordingly.
> > > 
> > > Cc: Keerthy <j-keerthy@ti.com>
> > > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> > > ---
> > > Change log:
> > > Changes in v2:
> > > - Kept clk-sci.c as is because this is used by
> > > AM64 and AM65 platforms
> > > - v1 link
> > > https://lore.kernel.org/all/20230919060649.2518147-1-u-kumar1@ti.com/
> > > 
> > >   drivers/clk/ti/clk-k3.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
> > > index ba925fa3c4..8016c3784a 100644
> > > --- a/drivers/clk/ti/clk-k3.c
> > > +++ b/drivers/clk/ti/clk-k3.c
> > > @@ -11,6 +11,7 @@
> > >   #include <errno.h>
> > >   #include <soc.h>
> > >   #include <clk-uclass.h>
> > > +#include <k3-avs.h>
> > >   #include "k3-clk.h"
> > >   #define PLL_MIN_FREQ	800000000
> > > @@ -339,6 +340,10 @@ static ulong ti_clk_set_rate(struct clk *clk, ulong rate)
> > >   		}
> > >   	}
> > > +	if (IS_ENABLED(CONFIG_K3_AVS0))
> > > +		k3_avs_notify_freq(data->map[clk->id].dev_id,
> > > +				   data->map[clk->id].clk_id, rate);
> > > +
> > Don't you want to do this prior to actual clock change?
> 
> Not really, As i see new freq to be less than current one.
> 
> > F1, V1 -> F2, V2
> > 
> > Seq 1:
> > F1, V1
> > F2, V1
> > F2, V2
> > 
> > Seq 2:
> > F1, V1
> > F1, V2
> > F2, V2
> > 
> > If V2 < V1 (implying F2 < F1), then Seq 1 is valid. But if V2 > V1 (F2 >
> > F1) Seq 2 is valid.
> > 
> > We seem to ignore this constraint. Can you explain this in the commit
> > message?
> 
> Sure, will do , Below is reasoning, Please see if make sense
> 
> On J7 devices,  In default device tree, A72 freq is set to 2Ghz, few SOCs
> can operate at lower freq.
> 
> So while setting OPP freq (which is less than default one), First freq needs
> to set
> 
> before changing voltage.
> 
> 
> On other hand, I am thinking to fix properly for both cases, irrespective of
> seq 1 is
> 
> valid for current use case.

Thanks.

> > 
> > clk-sci.c seems to use Seq 2, vs this patch seems to take Seq 1.
> 
> I think, something to be fixed for clk-sci.c as well.
> As I see three freq point
> https://elixir.bootlin.com/u-boot/latest/source/drivers/misc/k3_avs.c#L339
> 
> So we can choose either way new-freq > current-freq or new-freq <
> current-freq,
> 
> Based upon new-freq , voltage to be set before/after clock change.

We should handle both cases, ideally.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
