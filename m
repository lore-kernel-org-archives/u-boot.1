Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F095CEDD9B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D13F289243;
	Wed,  9 Oct 2024 16:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U+ArcWjR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3854789245; Wed,  9 Oct 2024 16:18:52 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F99C8923F
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 499EIhU9058721;
 Wed, 9 Oct 2024 09:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728483523;
 bh=Nk7lDAz4Bg+hODun0rjvSB+4VxjGQRIuJftMZ7ZAOwE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=U+ArcWjRJ14DfZaPkuXIEGH5HVyb03VXYsn/q9AvjjSI7CE25LFA2lAywI5uOYxvy
 MiZ0IakXyprHKFKm7v0DArvP4XZ0p4i5xblzoe07s278imexbMJ2DkbGilPwXfz9sl
 yrPUpHYWvT/0mAJGhF7TlkvZmI7L0tlEmkkpayf0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 499EIhbK042523
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Oct 2024 09:18:43 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Oct 2024 09:18:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Oct 2024 09:18:43 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 499EIhD4086016;
 Wed, 9 Oct 2024 09:18:43 -0500
Date: Wed, 9 Oct 2024 09:18:43 -0500
From: Bryan Brattlof <bb@ti.com>
To: Bhavya Kapoor <b-kapoor@ti.com>
CC: <u-boot@lists.denx.de>, <afd@ti.com>, <rogerq@kernel.org>,
 <emanuele.ghidoli@toradex.com>, <hnagalla@ti.com>, <a-nandan@ti.com>,
 <trini@konsulko.com>
Subject: Re: [PATCH] arm: mach-k3: j784s4: Add clk and power support for
 wkup_uart
Message-ID: <20241009141843.mebh2pmpfpowimkz@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20241007110709.3335579-1-b-kapoor@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20241007110709.3335579-1-b-kapoor@ti.com>
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

On October  7, 2024 thus sayeth Bhavya Kapoor:
> Add clk and device data which can be used by wkup_uart driver
> to configure clocks and PSC.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

