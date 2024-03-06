Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D10C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26E3C86FB2;
	Wed,  6 Mar 2024 14:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WOu6H8kd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0CD687BFD; Wed,  6 Mar 2024 14:35:27 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBC0786308
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426DZHPs004666;
 Wed, 6 Mar 2024 07:35:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709732117;
 bh=UrFRdrLHyjIavkMOK9w4OSPmgE/FFWnTfmmtpP3XwE8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WOu6H8kd/oO2E+ph6h7vqEn3jwDohkF4lI/wU+V+P89hFdMZb94drsWe912WT4gbN
 KhjievRTrPeafyR7Hgw3fls+KguGodkttNbafhmUyQp/+Wdgpwi2LPwHVRuxGEgkIP
 gqRz8BSb9ATjkkosjDrTB1tMYgEE/5F/gGizN0P0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426DZHV8127180
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Mar 2024 07:35:17 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 07:35:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 07:35:17 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426DZHhj010532;
 Wed, 6 Mar 2024 07:35:17 -0600
Date: Wed, 6 Mar 2024 07:35:17 -0600
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/6] arm: mach-k3: am62: Fixup TF-A/OP-TEE
 reserved-memory node in FDT
Message-ID: <20240306133517.djtzqotxzour34ib@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-5-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240214163009.983034-5-afd@ti.com>
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

On February 14, 2024 thus sayeth Andrew Davis:
> The address we load TF-A and OP-TEE to is configurable by Kconfig
> CONFIG_K3_{ATF,OPTEE}_LOAD_ADDR, but the DT nodes reserving this memory
> are often statically defined. As these binaries are dynamically loadable,
> and in the case of OP-TEE may not even be loaded at all, hard-coding these
> addresses is not a hardware description, but rather a configuration.
> 
> If the address that U-Boot loaded TF-A or OP-TEE does not match the
> address in hard-coded in DT, then fix that node address. This also handles
> the case when no reserved memory for these is provided by DT, which is
> more correct as explained above.
> 
> Add this fixup function, and enable it for AM62.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Acked-by: Bryan Brattlof <bb@ti.com>

Does this mean we need to no-map these regions in the MMU as well? Right 
now it's just statically defined. I was looking into trying to read the 
reserved-memory{} node to see if we could dynamically build the MMU 
config but that would have to happen after this step right?

~Bryan
