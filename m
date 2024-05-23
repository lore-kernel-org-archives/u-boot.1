Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6942EC25B7C
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 17:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C488C87F69;
	Thu, 23 May 2024 19:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h70Z/CJ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C9E3880DE; Thu, 23 May 2024 19:12:30 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE62E87E0B
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 19:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44NHCO6L057617;
 Thu, 23 May 2024 12:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716484344;
 bh=pm9Ya0epcAn9dq/vn3jM2xwihLIlKmB67hxfKAEkq0I=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=h70Z/CJ4t8oj9IzUtO5cZytWrgN48b/v0jIbs8X0GXxNhYTXPBJvy7Jat7SHsw1Zi
 uP6psicZg/8ifMtrRNxrPzpJlQ2vEr4QPxonzhhv+F1wdhDEiPP11VRIdcejGTbgjL
 G3rsjHm7lSX0qasppzaUtgoXzUuvTYN+Lo+dH0BI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44NHCOud030263
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 May 2024 12:12:24 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 12:12:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 12:12:23 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44NHCOJv116877;
 Thu, 23 May 2024 12:12:24 -0500
Date: Thu, 23 May 2024 12:12:24 -0500
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: mach-k3: am62p: Fixup TF-A/OP-TEE reserved-memory
 node in FDT
Message-ID: <20240523171224.b3oi5hhngok7webk@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240520-am62p-fdt-fix-v1-1-49845dcb3667@ti.com>
 <82b2503d-fda4-45fd-a576-2a5f3606587a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <82b2503d-fda4-45fd-a576-2a5f3606587a@ti.com>
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

On May 23, 2024 thus sayeth Andrew Davis:
> On 5/23/24 11:43 AM, Bryan Brattlof wrote:
> > The address we load TFA and OPTEE is configurable by the
> > CONFIG_K3_{ATF,OPTEE)_LOAD_ADDR, but the DT node reservations remain
> > static which can cause some confusion about where exactly these firmware
> > are exactly. Fix this by updating the reserved-memory{} nodes when the
> > loaded address does not match the address in DT.
> > 
> > Reported-by: Andrew Davis <afd@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> > Hello everyone,
> > 
> > This is a little fixup to avoid any confusion once we're in the kernel.
> > Because TF-A can be configured in U-Boot to be anywhere we want, we need
> > up update the reserved-memory{} node with this change.
> > 
> > Thanks for reviewing
> > ~Bryan
> > ---
> >   arch/arm/mach-k3/Makefile       |  1 +
> >   arch/arm/mach-k3/am62p5_fdt.c   | 16 ++++++++++++++++
> 
> You'll want to rebase this on -next, these _fdt.c files all got moved
> into directories for each SoC.
> 

Ah! my bad, you're right this belongs in -next. v2 incoming momentarily

Thanks Andrew
~Bryan
