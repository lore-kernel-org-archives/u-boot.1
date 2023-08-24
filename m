Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFC2C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 12:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04067805C2;
	Thu, 24 Aug 2023 14:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oUY0kxG6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 093CB803AE; Thu, 24 Aug 2023 14:05:25 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C30805C2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 14:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OC596K127077;
 Thu, 24 Aug 2023 07:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692878709;
 bh=BKBOES8uoiOj0jLQlfH0n1nQDUvZLj5a4bO10NwY0UI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=oUY0kxG6uJIuoZFBmTnnqr8SnSB+gWDtf+YDszcBZn9thSRPm5GJmnw8cxZGj49gy
 /fj+N4T3r+dTGY5oD3embqpNtJ0DTnWQ3VQkKyAchfhpscIEcyXspNVmcJu6y0N9an
 AdRUH9QCj3kreqF4bUHsI+lSxDMl2lRiZdgEWi0o=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OC59VO001723
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 07:05:09 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 07:05:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 07:05:09 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OC59J6014608;
 Thu, 24 Aug 2023 07:05:09 -0500
Date: Thu, 24 Aug 2023 07:05:09 -0500
From: Nishanth Menon <nm@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Francesco Dolcini
 <francesco@dolcini.it>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Jan Kiszka <jan.kiszka@siemens.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH V5 02/17] include: configs: am62x_evm: Drop unused SDRAM
 address
Message-ID: <20230824120509.72xvy5n2hpl5uh4q@landside>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-3-nm@ti.com> <87il94rh6x.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il94rh6x.fsf@baylibre.com>
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

On 10:13-20230824, Mattijs Korpershoek wrote:
> Hi Nishanth,
> 
> On mer., août 23, 2023 at 22:10, Nishanth Menon <nm@ti.com> wrote:
> 
> > Drop unused macro. This was meant for a second region of DDR which we
> > do not need for AM62x evm configurations.
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > New patch (part of bootstd transition)
> >
> >  include/configs/am62x_evm.h | 3 ---
> >  1 file changed, 3 deletions(-)
> 
> What about include/configs/verdin-am62.h ?
> 
> It seems that that board, which is am62x based, also has the un-needed
> include.
> 
> Since i'm not 100% sure, I have added Marcel (who posted the verdin am62
> support) here.

Toradex team, Can you handle that cleanup? I stayed focussed on am62x_evm side
of things.

> 
> >
> > diff --git a/include/configs/am62x_evm.h b/include/configs/am62x_evm.h
> > index 44180dc7687b..379e0c13a395 100644
> > --- a/include/configs/am62x_evm.h
> > +++ b/include/configs/am62x_evm.h
> > @@ -12,9 +12,6 @@
> >  #include <config_distro_bootcmd.h>
> >  #include <env/ti/mmc.h>
> >  
> > -/* DDR Configuration */
> > -#define CFG_SYS_SDRAM_BASE1		0x880000000
> > -
> >  /* Now for the remaining common defines */
> >  #include <configs/ti_armv7_common.h>
> >  
> > -- 
> > 2.40.0

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
