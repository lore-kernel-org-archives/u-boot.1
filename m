Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1250C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 11:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D9282A76;
	Tue,  1 Jul 2025 13:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Eqj+0pfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73FDA82F42; Tue,  1 Jul 2025 13:50:54 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF7282F49
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 13:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 561BogOW3622916;
 Tue, 1 Jul 2025 06:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751370642;
 bh=cFy8JCbPLsDvbYRb9RafeAmoPv88CLunRmCLGEUnmSE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Eqj+0pfMeKc9VW3soFG8J9N1HdV+TvIDcEZJRkNXdIYWDmEIuAFOPQgPjY4FWZI1q
 3oGZV308djUEm/lcXza7bTYyG9hq4TDr8Gl71qLm7kwiL+KUhm/eQ4z/E3Jh82nSlM
 7DdyF0n9TS4gF/jtAg23vcHsvlZqED+CqwxMiolQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 561Bog7k185376
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 1 Jul 2025 06:50:42 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 1
 Jul 2025 06:50:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 1 Jul 2025 06:50:42 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 561BogZs1218434;
 Tue, 1 Jul 2025 06:50:42 -0500
Date: Tue, 1 Jul 2025 06:50:42 -0500
From: Bryan Brattlof <bb@ti.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
CC: <rfried.dev@gmail.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <danishanwar@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] pci_endpoint: pci_cdns_ti_ep: Fix the include path for
 header file
Message-ID: <20250701115042.b5rpewesmxtml7b7@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250627055546.3706770-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250627055546.3706770-1-h-salunke@ti.com>
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

On June 27, 2025 thus sayeth Hrushikesh Salunke:
> The commit under fixes tag includes "pcie-cadence.h" using angle
> brackets. Since the header file is not in standard include path change
> it to double quotes to ensure proper inclusion and avoid build issues,
> especially on older compilers.
> 
> Fixes: a4a0edc6046 ("pci_endpoint: Add TI K3 Cadence PCIe Endpoint Controller driver")
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
