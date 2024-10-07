Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5EACFB442
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 05:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 850D6888EB;
	Mon,  7 Oct 2024 07:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Tl/6qLgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C33388CF3; Mon,  7 Oct 2024 07:48:54 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7624B888B2
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 07:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4975moP2037081;
 Mon, 7 Oct 2024 00:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728280130;
 bh=Frig44lMpQjwwG80Th0orZrZhE244ByCjfCk49N7A18=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Tl/6qLgnq3pgpd/jmtQ+qpdGXALSbp6XvJFFG0jGif48mpLL+Eu+QbbPjQL6W6lBP
 mSd6qbJPYPpHvJTSZqBaYFs+GP4BhFDtGkGvFAlOEmFk4X23Ko/Xp3Be0fDR/4YbU/
 UXlv7PRfhtuP5wamal01LZNJ4hK9M9NNGnPmtbOY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4975mol1017066
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Oct 2024 00:48:50 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Oct 2024 00:48:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Oct 2024 00:48:49 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4975mnUp050818;
 Mon, 7 Oct 2024 00:48:49 -0500
Date: Mon, 7 Oct 2024 11:18:48 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>
Subject: Re: [PATCH v4 3/7] arm: dts: k3-j7*-r5: Add MPU clock in clocks
 property
Message-ID: <20241007054848.ci5tls5wqrozxqnm@uda0497581>
References: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
 <20241004-b4-upstream-j721s2-avs-v4-3-6d71c6bab9f4@ti.com>
 <20241004113001.h4cshh74q2bqfhqj@frolic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241004113001.h4cshh74q2bqfhqj@frolic>
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

Hi Nishanth,

On 06:30-20241004, Nishanth Menon wrote:
> On 11:54-20241004, Manorit Chawdhry wrote:
> > MPU clock had been missing. Distinguish multiple clocks with clock-names
> > and add MPU clock as well.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> 
> We have been a bit hacky with GTC - do we want to pull it out as a
> separate IP?

Could you explain it a bit more..

> > ---
> >  arch/arm/dts/k3-am69-r5-sk.dts                 | 3 ++-
> >  arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 3 ++-
> >  arch/arm/dts/k3-j721e-r5.dtsi                  | 3 ++-
> >  arch/arm/dts/k3-j721s2-r5.dtsi                 | 3 ++-
> >  arch/arm/dts/k3-j784s4-r5-evm.dts              | 3 ++-
> >  5 files changed, 10 insertions(+), 5 deletions(-)
> 
> What about other boards? I think it might be time we refactor r5 view as
> a include file?
> 

Yeah, that makes sense. Will update the other boards with the following.

R5 is already include file for j721e and j721s2, other boards do require
that refactor but that can be taken up as a separate series ig.

Regards,
Manorit
