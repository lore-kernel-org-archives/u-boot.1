Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32870CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 18:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B90086D9C;
	Tue, 17 Oct 2023 20:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pjiygLi3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F62886C6E; Tue, 17 Oct 2023 20:53:45 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB61786EE2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39HIrd65126448;
 Tue, 17 Oct 2023 13:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697568819;
 bh=GxPCUDVT59cLmqdsh/sA9Q2ZxOxjGUoFKTQkV0KZZqc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=pjiygLi3JylWpKU1N5Cw2lzf1lsrfbE7dT5HaLeqXXfPuHbU6CpD3afelqrfAdl6G
 uMrusMu/lN3dC4lMu9IT9ZBbdbyoQAPznvo8Wx6ykmsGsxErky8pfkcpijWV75b27r
 ZQl2sXGHmKoj0hr/l8NcHqE+fCQOWi9fb0cv4XNU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39HIrd5n029148
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Oct 2023 13:53:39 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Oct 2023 13:53:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Oct 2023 13:53:38 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39HIrc0N063759;
 Tue, 17 Oct 2023 13:53:38 -0500
Date: Tue, 17 Oct 2023 13:53:38 -0500
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
Subject: Re: [PATCH] arm: dts: k3-j721e-mcu-wakeup: Add MCU domain ESM instance
Message-ID: <20231017185338.yeetp7iwn52o756e@snazzy>
References: <20231013102941.548209-1-n-francis@ti.com>
 <454562f1-d120-9719-62c3-7ef64861307c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <454562f1-d120-9719-62c3-7ef64861307c@ti.com>
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

On 16:35-20231013, Kumar, Udit wrote:
> 
> On 10/13/2023 3:59 PM, Neha Malcom Francis wrote:
> > Currently J721E defines only the main_esm in DTS. Add node for mcu_esm
> > as well.
> > 
> > According to J721E TRM (12.11.2.2 ESM Environment) [1], we see that the
> > interrupt line from ESMi (main_esm) is routed to MCU_ESM (mcu_esm). This
> > is MCU_ESM0_LVL_IN_95 with interrupt ID 95. Configure mcu_esm
> > accordingly so that errors from main_esm are routed to mcu_esm and
> > handled.
> > 
> > [1] https://www.ti.com/lit/zip/spruil1
> > 
> > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > ---
> > Upstream kernel effort:
> > https://lore.kernel.org/lkml/20230926142810.602384-1-n-francis@ti.com/
> 
> 
> should part of next u-boot, kernel sync, no?
> 

That is correct, this should come in via upstream kernel sync.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
