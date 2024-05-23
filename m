Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E8EC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 17:23:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D337A87DB0;
	Thu, 23 May 2024 19:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mcXQeRf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0BF387DC7; Thu, 23 May 2024 19:23:00 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B496D87C75
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 19:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44NHMvRk059448;
 Thu, 23 May 2024 12:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716484977;
 bh=0iu/wtCXkTC1tJ7vYqzczJ3SO0JE0w8ZyKDqHgmkaKo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=mcXQeRf390qN4fZRs4WzNhjseOL9t1g12IZfta3RGPtIWx9+Zd/tGAjoVtEgenQfK
 1LsBOmAnyrlXnU3xiPgyGlw0Ccdy2E70D3mdKLQZt4e9i4jof5UDRR+D5iwR9MCnSQ
 u9tm1nk1jli2qvZts5Z3TxFPEzKcEwvm7yfGnHTc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44NHMvrc092675
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 May 2024 12:22:57 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 12:22:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 12:22:56 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44NHMuqp123529;
 Thu, 23 May 2024 12:22:56 -0500
Date: Thu, 23 May 2024 12:22:56 -0500
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: mach-k3: am62p: Fixup TF-A/OP-TEE reserved-memory
 node in FDT
Message-ID: <20240523172256.4mciukajb5g2uizc@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240520-am62p-fdt-fix-v1-1-49845dcb3667@ti.com>
 <82b2503d-fda4-45fd-a576-2a5f3606587a@ti.com>
 <20240523171224.b3oi5hhngok7webk@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240523171224.b3oi5hhngok7webk@bryanbrattlof.com>
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

On May 23, 2024 thus sayeth Bryan Brattlof:
> On May 23, 2024 thus sayeth Andrew Davis:
> > On 5/23/24 11:43 AM, Bryan Brattlof wrote:
> > > The address we load TFA and OPTEE is configurable by the
> > > CONFIG_K3_{ATF,OPTEE)_LOAD_ADDR, but the DT node reservations remain
> > > static which can cause some confusion about where exactly these firmware
> > > are exactly. Fix this by updating the reserved-memory{} nodes when the
> > > loaded address does not match the address in DT.
> > > 
> > > Reported-by: Andrew Davis <afd@ti.com>
> > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > > ---
> > > Hello everyone,
> > > 
> > > This is a little fixup to avoid any confusion once we're in the kernel.
> > > Because TF-A can be configured in U-Boot to be anywhere we want, we need
> > > up update the reserved-memory{} node with this change.
> > > 
> > > Thanks for reviewing
> > > ~Bryan
> > > ---
> > >   arch/arm/mach-k3/Makefile       |  1 +
> > >   arch/arm/mach-k3/am62p5_fdt.c   | 16 ++++++++++++++++
> > 
> > You'll want to rebase this on -next, these _fdt.c files all got moved
> > into directories for each SoC.
> > 
> 
> Ah! my bad, you're right this belongs in -next. v2 incoming momentarily
> 

Wait no on second thought, this needs to be in v2024.07 also. I'll leave 
this for Tom for -master and maybe send out another version for -next to 
preempt the merge conflict for v2024.10?

~Bryan
