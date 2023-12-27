Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71310C47072
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 13:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C372987980;
	Wed, 27 Dec 2023 14:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GiaWVOVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7DA08794F; Wed, 27 Dec 2023 14:06:26 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9B787866
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 14:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BRD6I4V104340;
 Wed, 27 Dec 2023 07:06:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703682378;
 bh=usrPLwC9cijDZi/QtTpYIykeroiVA5MF6ArMI8THt5U=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=GiaWVOVy27/4asyx1dSaHJOxIdS0QVd49hXa67kflf1XHLlPUAYj0oreCj951Bms2
 GIM93GoqwuaPA2baUYaXMi4d+vmNl3gQqnksqkdPC1/wQPEOT/I5jDiVHSsBjAL1U/
 0y9ewZglp1HllqR7jB0+FnnaeY0fAibKCqa6M1YQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BRD6HZN101925
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Dec 2023 07:06:17 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Dec 2023 07:06:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Dec 2023 07:06:17 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BRD6H7H040233;
 Wed, 27 Dec 2023 07:06:17 -0600
Date: Wed, 27 Dec 2023 07:06:17 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <m-chawdhry@ti.com>,
 <bmeng.cn@gmail.com>, <sjg@chromium.org>, <afd@ti.com>,
 <mkorpershoek@baylibre.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <srk@ti.com>
Subject: Re: [PATCH] include: env: ti: ti_common: Run
 main_cpsw0_qsgmii_phyinit conditionally
Message-ID: <20231227130617.c4k32amcsyw447is@abide>
References: <20231211104209.1078892-1-s-vadapalli@ti.com>
 <20231221210657.GO2513409@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231221210657.GO2513409@bill-the-cat>
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

On 16:06-20231221, Tom Rini wrote:
> On Mon, Dec 11, 2023 at 04:12:09PM +0530, Siddharth Vadapalli wrote:
> 
> > From: Manorit Chawdhry <m-chawdhry@ti.com>
> > 
> > The main_cpsw0_qsgmii_phyinit command is defined only for certain TI
> > SoCs which have the do_main_cpsw0_qsgmii_phyinit variable set.
> > 
> > Add a check to ensure that the main_cpsw0_qsgmii_phyinit command is run
> > only for such SoCs.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> Applied to u-boot/next, thanks!

Shouldn't main_cpsw0_qsgmii_phyinit be part of the driver?? why are we
scripting up driver initialization?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
