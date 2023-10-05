Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0C8E9271D
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 17:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 955EE86CA7;
	Thu,  5 Oct 2023 19:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FstbfqW0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24AE08692B; Thu,  5 Oct 2023 19:14:20 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFF908692B
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 19:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395HE7If081773;
 Thu, 5 Oct 2023 12:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696526047;
 bh=5FA+noIrZJP99J4MYZ4QdopGNZoodPY099CWwgTIRbU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=FstbfqW0EXQ5DTQDvHkcMr0mR8iT/GWt8dadaRRPhOOITuxQw0aRwaaf14DE2MKHk
 40FAQI6ES5SeELIYGrVqb8dDjQXunc7WuAwYxRBImSnOzCd9nIQtWiYuL/puiZEyJs
 1zrE6nvmVsHlnqI2tL67C3ktnybKOrf6hOozniIY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395HE7HE052595
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 12:14:07 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 12:14:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 12:14:07 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395HE7eb008582;
 Thu, 5 Oct 2023 12:14:07 -0500
Date: Thu, 5 Oct 2023 12:14:07 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>,
 <vigneshr@ti.com>, <m-chawdhry@ti.com>, <jonas@kwiboo.se>,
 <srk@ti.com>, <afd@ti.com>, <bb@ti.com>, <praneeth@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/2] board: ti: am64x: Switch to standard boot flow
Message-ID: <20231005171407.jijjxbt66vakivap@chemicals>
References: <20231005130642.21402-1-rogerq@kernel.org>
 <20231005130642.21402-3-rogerq@kernel.org>
 <CAPnjgZ0uMLFdqvpcDMKnXQDL-m1ecUB33gat4EZK7jm=UeEB4g@mail.gmail.com>
 <20231005163148.GR8465@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231005163148.GR8465@bill-the-cat>
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

On 12:31-20231005, Tom Rini wrote:
[...]

> > >  /* Now for the remaining common defines */
> > >  #include <configs/ti_armv7_common.h>
> > 
> > It looks like this file still includes distro_bootcmd and defines all
> > the BOOT_TARGET things. Can they be dropped? Perhaps for now they
> > could be put behind an #ifdef if other boards need them?
> > 
> > I suspect that with your patch as is, the environment is still full of scripts?
> 
> There's a lot of TI platforms, so I'm not sure what "#if" you're
> thinking of might make it cleaner?  We could / should move some of the
> still relevant content and comments from that file to
> include/env/ti/ti_armv7_common.env as I do think some of the K3
> platforms could just drop <configs/ti_armv7_common.h> at this point.

Is'nt the header distro_bootcmd.h and related stuff under #ifdef
CONFIG_DISTRO_DEFAULTS already?

So, all we are picking up in effect is really CFG_SYS_SDRAM_BASE - which
is consistent across platforms.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
