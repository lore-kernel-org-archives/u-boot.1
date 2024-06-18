Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B610C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 18:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E46728839C;
	Tue, 18 Jun 2024 20:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RSkDRpBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB218839C; Tue, 18 Jun 2024 20:54:24 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39373882F9
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 20:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IIsHHi022564;
 Tue, 18 Jun 2024 13:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718736857;
 bh=fbuV0zCQXaIPIrseJSVhpwTapKlA9dnJ+K9xcqGgYq0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=RSkDRpBbaX7qpyAKjxIapyqTTVWdceYKHs1SIZOa0HBdC5amy7FUcAIUkjJIucemz
 LfaGKbK9bxc5sO4gBLrBVFoAeDdCBuAO9kbibpuCoUsU2N8KYAcSpBgAvT3kP3Cuqd
 SJQkSoFaKaV2AJ3CbkVsSybIY1ILpvATGLsy6Drw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IIsHCG088896
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Jun 2024 13:54:17 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 13:54:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 13:54:17 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IIsHB2055842;
 Tue, 18 Jun 2024 13:54:17 -0500
Date: Tue, 18 Jun 2024 13:54:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Hari Nagalla <hnagalla@ti.com>
CC: <trini@konsulko.com>, <devarsht@ti.com>, <afd@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: Re: [PATCH 0/3] Add M4 remoteproc driver for TI K3 SoCs
Message-ID: <20240618185417.cjzqmtzrqf5adwul@drapery>
References: <20240618184636.30642-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618184636.30642-1-hnagalla@ti.com>
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

On 13:46-20240618, Hari Nagalla wrote:
> This series adds support for M4 remoteproc driver for K3 devices.
> 
> Logs: https://paste.sr.ht/~hnagalla/62811c4003c27ada83bc1c94500f7714ab30092a

Obviously - this cannot work with out an M4F node in dts, correct? you
should have mentioned that in your email.

> 
> Hari Nagalla (3):
>   remoteproc: k3-m4: Introduce K3 remote proc driver for M4 subsystem
>   configs: am62x_evm_a53_defconfig: Enable M4 remote proc driver
>   board: ti: am62x: Add remote proc env variables
> 
>  board/ti/am62x/am62x.env            |   4 +
>  configs/am62x_evm_a53_defconfig     |   2 +
>  drivers/remoteproc/Kconfig          |  10 +
>  drivers/remoteproc/Makefile         |   1 +
>  drivers/remoteproc/ti_k3_m4_rproc.c | 421 ++++++++++++++++++++++++++++
>  5 files changed, 438 insertions(+)
>  create mode 100644 drivers/remoteproc/ti_k3_m4_rproc.c
> 
> -- 
> 2.34.1
> 

I know we are close[1], but do wait for upstream kernel to accept
the bindings before using the same in driver etc. the dts has no m4
support atm.

[1] https://lore.kernel.org/r/33550e82-4fd3-4066-b78d-27534584fa5b@ti.com
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
