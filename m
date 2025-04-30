Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3635C3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 15:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE1A8215F;
	Wed, 30 Apr 2025 17:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fdOh6Ywd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD9782B81; Wed, 30 Apr 2025 17:24:41 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C38E482153
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 17:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53UFOa0M3415650
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 10:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746026676;
 bh=897DjcWutkvJRYYWXlCxYo2XT0bvmPACiS1/wvt7jMc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fdOh6Ywd4B6pvSZSfj5oChRMja9z2yJO4gv6X2aI96VG8uPvriiNvxlDYmKMPRUA2
 dwJtIo2jJ/pdW1I/kiTX3+HaESVC3q1kLbNDMaj7FcWFnwgkVqXQYsRnP1mPhSnXNO
 RBMgJKGJjGZQwHNfU678i6tqc/7ikqMbK/HiH1bk=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53UFOa0F081504
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Apr 2025 10:24:36 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Apr 2025 10:24:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Apr 2025 10:24:36 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53UFOabQ087575;
 Wed, 30 Apr 2025 10:24:36 -0500
Date: Wed, 30 Apr 2025 10:24:36 -0500
From: Bryan Brattlof <bb@ti.com>
To: Aparna Patra <a-patra@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <afd@ti.com>,
 <d-gole@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <nm@ti.com>
Subject: Re: [PATCH 0/3] Add fdt-fixups for AM62A variants
Message-ID: <20250430152436.qkzbuvqsds7jkn66@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250430104236.2611089-1-a-patra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250430104236.2611089-1-a-patra@ti.com>
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

On April 30, 2025 thus sayeth Aparna Patra:
> This series implements fdt fixups, by reading hardware
> information from registers and accordingly delete/modify
> the DT nodes, at run-time.
> 
> Aparna Patra (3):
>   arm: mach-k3: am62a: Fixup CPU core, DSS, CAN-FD and Video-codec nodes
>     in fdt
>   arm: mach-k3: am62a: Fixup thermal zone critical points
>   arm: mach-k3: am62a: Fixup a53 max cpu frequency by speed-grade
> 

Minus the pinmux node all of this looks great

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
