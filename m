Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FF6C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 05:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF3388271;
	Mon,  1 Jul 2024 07:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HspQFgQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 731F188657; Mon,  1 Jul 2024 07:00:13 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 377A48824C
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 07:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 461508QP048200;
 Mon, 1 Jul 2024 00:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719810008;
 bh=N/Raqkz26edRWw/G289z4f4wh3zLoOUvWagS+S0I+wA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=HspQFgQB7cuV1Eg5E4GW4cwuqAKidNXIXVrlJrkNdC+lwckex9nV/4a1XTsNgobFn
 6cZKEzj1ICOazjdvuPjXQDTAExoD4SmqPLtRc9XDfBb3M/8S813u6fMiCb6xURwxoq
 5tM4so9RWBUSW6T8kSevf1M64grtzelEWboy3G0k=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 461507AX073937
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Jul 2024 00:00:08 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 00:00:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 00:00:07 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4615061a027619;
 Mon, 1 Jul 2024 00:00:07 -0500
Date: Mon, 1 Jul 2024 10:30:06 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, <u-boot@lists.denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH 0/3] Fix findfdt for j722s and am62p
Message-ID: <20240701050006.4rkdmhflfhsf2c4r@uda0497581>
References: <20240628-b4-upstream-streamline-platform-v1-0-17659af992c1@ti.com>
 <20240628130647.slzitudem52xf5f3@wobble>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240628130647.slzitudem52xf5f3@wobble>
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

Hi Nishanth,

On 08:06-20240628, Nishanth Menon wrote:
> On 13:53-20240628, Manorit Chawdhry wrote:
> > findfdt wasn't being populated in these boards, add the code in evm.c
> > for the same.
> 
> why not just drop findfdt? I am ok with #2,3 more or less, but keeping

typo... should've written fdtfile. When all the boards migrate to your
series for pulling in fdtfile from ti_set_fdt_env itself, I think findfdt can
be dropped for k3 boards at that point. This series moves am62px and
j722s to that.

Regards,
Manorit

> findfdt alive is just a bad direction when we are moving to stdboot
> flow.
> 
> 
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> > Manorit Chawdhry (3):
> >       include: env: ti: mmc: Change name_fdt usage to fdtfile
> >       board: ti: am62p|j722s: Add ti_set_fdt_env for findfdt
> >       configs: am62p|j722s_a53: Add CONFIG_BOARD_LATE_INIT
> > 
> >  board/ti/am62px/evm.c            | 9 +++++++++
> >  board/ti/j722s/evm.c             | 9 +++++++++
> >  configs/am62px_evm_a53_defconfig | 1 +
> >  configs/j722s_evm_a53_defconfig  | 1 +
> >  include/env/ti/mmc.env           | 2 +-
> >  5 files changed, 21 insertions(+), 1 deletion(-)
> > ---
> > base-commit: 899b088674b6905710ce546f0a8848662904852a
> > change-id: 20240628-b4-upstream-streamline-platform-f0d7453637b2
> > 
> > Best regards,
> > -- 
> > Manorit Chawdhry <m-chawdhry@ti.com>
> > 
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
