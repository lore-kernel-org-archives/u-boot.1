Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EC7C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 12:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 474ED8059D;
	Thu,  1 May 2025 14:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TicfFQXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC484809A5; Thu,  1 May 2025 14:31:09 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC4F98056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 14:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 541CV5Za004127
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 May 2025 07:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746102665;
 bh=06lomxD3Fg7ON/UNgvLQwujEdUhS7Ts2asdED8OWIgA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TicfFQXQsc3ZYI7hPWKrO9lEhEv8zs5zdOJxfh2vvaNCYYJ1/kjRFxi+fqptRYpt0
 t0yQ0nDt/WHXBp7hiDBbkZDIqYF9nmC82WFYLJF40f1whdkqLxCHZsPHId/bz2+wUd
 uzKpaHTWN98NCoIjcJJdzLxK0EZAVDHMpwQLhtlw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 541CV5Hg000569
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 1 May 2025 07:31:05 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 May 2025 07:31:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 May 2025 07:31:04 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 541CV4UO075459;
 Thu, 1 May 2025 07:31:04 -0500
Date: Thu, 1 May 2025 07:31:04 -0500
From: Nishanth Menon <nm@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Aparna Patra <a-patra@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <afd@ti.com>, <d-gole@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>
Subject: Re: [PATCH 0/3] Add fdt-fixups for AM62A variants
Message-ID: <20250501123104.en56d7wu5qldngcs@hedge>
References: <20250430104236.2611089-1-a-patra@ti.com>
 <20250430152436.qkzbuvqsds7jkn66@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250430152436.qkzbuvqsds7jkn66@bryanbrattlof.com>
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

On 10:24-20250430, Bryan Brattlof wrote:
> On April 30, 2025 thus sayeth Aparna Patra:
> > This series implements fdt fixups, by reading hardware
> > information from registers and accordingly delete/modify
> > the DT nodes, at run-time.
> > 
> > Aparna Patra (3):
> >   arm: mach-k3: am62a: Fixup CPU core, DSS, CAN-FD and Video-codec nodes
> >     in fdt
> >   arm: mach-k3: am62a: Fixup thermal zone critical points
> >   arm: mach-k3: am62a: Fixup a53 max cpu frequency by speed-grade
> > 
> 
> Minus the pinmux node all of this looks great
> 
> Reviewed-by: Bryan Brattlof <bb@ti.com>
> 
> ~Bryan


This is a ton of fixups being done in u-boot. I am not sure this is
going to sustain across multiple platforms.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
