Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0889FCAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 14:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F6C1835A2;
	Wed, 24 Sep 2025 16:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FBnHVnTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F098583447; Wed, 24 Sep 2025 16:05:44 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 762EB8359F
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 16:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58OE5PGr1712749;
 Wed, 24 Sep 2025 09:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758722725;
 bh=TJPwsGfJ1Yr7ypRWN8THwlr1gkdb7ajFml/48P4mNoQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=FBnHVnTxMavthiK4DkXki8+YHp9miLSnmg6JZu3zpdOpyRyzmrvJMDMLs3N9O+JNo
 eCKOgmAU+quanVwI3t0Ra0QerAr14HseX/jNcp9wmd7rd+zi2bWl+ehI0oP78LrUHe
 1Yw39IlRWUKqcmtzlClW+k/SS0Y6wN0j1XDEqqbw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58OE5OWi3619276
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 24 Sep 2025 09:05:24 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 24
 Sep 2025 09:05:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 09:05:24 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58OE5OoV2124020;
 Wed, 24 Sep 2025 09:05:24 -0500
Date: Wed, 24 Sep 2025 09:05:24 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: E Shattow <e@freeshell.de>, Aristo Chen <jj251510319013@gmail.com>,
 <u-boot@lists.denx.de>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <al.kochet@gmail.com>, <paul.henrys_ext@softathome.com>, <bb@ti.com>,
 <y.moog@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <n-francis@ti.com>, <afd@ti.com>, <d.schultz@phytec.de>,
 <d-gole@ti.com>, <ravi@prevas.dk>, <carlos.lopezr4096@gmail.com>,
 <quentin.schulz@cherry.de>, <alice.guo@nxp.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
Message-ID: <20250924140524.fy46p7ifr4oxh5mc@uncooked>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
 <20250924135139.GH197373@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924135139.GH197373@bill-the-cat>
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

On 07:51-20250924, Tom Rini wrote:
> On Wed, Sep 24, 2025 at 06:31:23AM -0700, E Shattow wrote:
> > Hi Aristo,
> > 
> > On 9/24/25 04:43, Nishanth Menon wrote:
> > > On 06:37-20250924, Nishanth Menon wrote:
> > >> On 10:59-20250914, Aristo Chen wrote:
> > >>> This patch series enhances FIT image robustness by adding **memory
> > >>> region overlap detection** to `mkimage` and fixing existing overlaps
> > >>> in DTS files and `binman` tests.
> > > 
> > > [...]
> > >>>
> > >>
> > >> Looks like i see a build regression in linux-next after this series.
> > > 
> > > I fat fingered that one.. sorry, I meant u-boot next.
> > > 
> > > 
> > > Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580f
> > > 
> > >>
> > >> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76
> > > 
> > > I  believe there are outstanding comments on V1 that have'nt been
> > > addressed either. Can we revert/drop this series for now while the
> > > comments are addressed?
> > > 
> > 
> > Similar to Nishanth, I am seeing a build regression, itb.map:
> 
> Sorry for the noise all, I've reverted this in next now.
> 

Thanks Tom.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
