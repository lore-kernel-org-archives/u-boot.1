Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B51EC47077
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 16:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2825B877D9;
	Tue,  9 Jan 2024 17:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j2HkhHav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5220386EB9; Tue,  9 Jan 2024 17:31:12 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D47B8877D9
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 17:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409GUtij090240;
 Tue, 9 Jan 2024 10:30:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704817855;
 bh=LP3/DMA/aOG3MiqAyRfZ6foGf17AiCOjOxHZiXyz4Zk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=j2HkhHavY5IyqWo9Fnyxxo2jp3hfbvuUdTF/HhStfojSkW7PQIkkXWQR3vsUJkbaG
 A+Vr2wy+h1DEI+j3dikxg9BCfs2B49dqIbwElfqcI+JYZIC3r2AGsUrMi0WCY3rAyV
 Qx+FIlJo0D/AK+hsDlq+oOGlInpQY6CfVgiKXpdU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409GUt32088918
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 10:30:55 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 10:30:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 10:30:55 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409GUteZ120528;
 Tue, 9 Jan 2024 10:30:55 -0600
Date: Tue, 9 Jan 2024 10:30:55 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Tom Rini <trini@konsulko.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu
 Raja <sinthu.raja@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nikhil M Jain
 <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof
 <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH 06/10] board: ti: j721e: Set fdtfile from C code instead
 of findfdt script
Message-ID: <20240109163055.efiivfkx5w7fed7v@unloving>
References: <20240108173301.2692332-1-nm@ti.com>
 <20240108173301.2692332-7-nm@ti.com>
 <b72e518a-dc63-4e98-ad3b-20c589e3ae8d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b72e518a-dc63-4e98-ad3b-20c589e3ae8d@kernel.org>
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

On 18:20-20240109, Roger Quadros wrote:
> 
> 
> On 08/01/2024 19:32, Nishanth Menon wrote:
> > We now can provide a map and have the standard fdtfile variable set from
> > code itself. This allows for bootstd to "just work".
> > 
> > While at this, replace findfdt in environment with a warning as it is no
> > longer needed.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  board/ti/j721e/evm.c     |  8 ++++++++
> >  board/ti/j721e/j721e.env | 10 ----------
> >  2 files changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> > index c541880107ec..ad6ef4553e04 100644
> > --- a/board/ti/j721e/evm.c
> > +++ b/board/ti/j721e/evm.c
> > @@ -16,6 +16,7 @@
> >  #include <dm.h>
> >  
> >  #include "../common/board_detect.h"
> > +#include "../common/fdt_ops.h"
> >  
> >  #define board_is_j721e_som()	(board_ti_k3_is("J721EX-PM1-SOM") || \
> >  				 board_ti_k3_is("J721EX-PM2-SOM"))
> > @@ -424,6 +425,12 @@ void configure_serdes_sierra(void)
> >  }
> >  
> >  #ifdef CONFIG_BOARD_LATE_INIT
> > +static struct ti_fdt_map ti_j721e_evm_fdt_map[] = {
> > +	{"j721e", "k3-j721e-common-proc-board.dtb"},
> > +	{"j721e-sk", "k3-j721e-sk.dtb"},
> 
> You missed "j721e-eaik"

Nope, it is intentional - eaik (the older name) is handled as sk in
setup_board_eeprom_env board_name[1] ==> board_is_j721e_sk  provides
that abstraction[2]


[1] https://github.com/u-boot/u-boot/blob/master/board/ti/j721e/evm.c#L427
[2] https://github.com/u-boot/u-boot/blob/master/board/ti/j721e/evm.c#L23
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
