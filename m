Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C626C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 11:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 296948816A;
	Thu, 28 Mar 2024 12:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MgbtSosa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9077A880C0; Thu, 28 Mar 2024 07:46:58 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90245880BB
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 07:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42S6ksW6047806;
 Thu, 28 Mar 2024 01:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711608414;
 bh=B5iAl00c1LTj9+86/byRh60l7GUDyLXJUXwsbw61d0w=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=MgbtSosa0uF3pSqR2fI7/iaBCo6Bz2Q3irOInVpv7tSV/QBJlpqO8dFPfZ1oNKlbN
 yfomB446TJaF/f0ZQZj92OZYy/StWyvfNqMvMhWHdsXCon7Ik16iPGm8+fMyB6lQ3Q
 xkqVA1Nf0ZktrmBN6/y4w4ua2Hs03cSGloqE2Uaw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42S6ksrL016152
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Mar 2024 01:46:54 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 01:46:54 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 01:46:54 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
 by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42S6kr7C081371;
 Thu, 28 Mar 2024 01:46:54 -0500
Date: Thu, 28 Mar 2024 12:16:53 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
CC: <u-boot@lists.denx.de>, Joe Hershberger <joe.hershberger@ni.com>, Ramon
 Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2] net: ti: am65-cpsw-nuss: handle missing PHY in
 am65_cpsw_phy_init() gracefully
Message-ID: <9cb0cf67-799d-4e09-b923-495217c85685@ti.com>
References: <20240328062914.486999-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240328062914.486999-1-alexander.sverdlin@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 28 Mar 2024 12:43:31 +0100
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

On Thu, Mar 28, 2024 at 07:29:10AM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> am65_cpsw_ofdata_parse_phy() tries to handle the case when PHY is not
> specified in DT gracefully:
> 
> am65_cpsw_nuss_port ethernet@8000000port@1: can't parse phy-handle port 1 (-2)
> 
> am65_cpsw_mdio_init() in turn is prepared for this, checks
> if priv->has_phy == 0 and bails out (leaving cpsw_common->bus == NULL).
> 
> am65_cpsw_phy_init() however is not prepared for this and calls
> phy_connect(cpsw_common->bus, ...) unconditionally, which leads to:
> 
> "Synchronous Abort" handler, esr 0x8600000d, far 0x0
> elr: ffffffff808ab000 lr : 000000008083bde4 (reloc)
> 
> where lr points to the instruction right after bus->read() in get_phy_id().
> 
> Fixes: 9d0dca1199d1 ("net: ethernet: ti: Introduce am654 gigabit eth switch subsystem driver")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
