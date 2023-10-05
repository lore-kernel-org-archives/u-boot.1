Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45084E9370B
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 11:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992DD869DA;
	Thu,  5 Oct 2023 13:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Jnuyclo3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B3786B98; Thu,  5 Oct 2023 13:28:08 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28382869DA
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 13:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395BRYBL098946;
 Thu, 5 Oct 2023 06:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696505254;
 bh=m1PfeqraTC4SP/i5bWTkEePZbjteSiF2ZfN09Z5dR14=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Jnuyclo3l5VX0LL5nSWHgdBPX/0mcRXj4y7Iv7vXIiM02++UhCKm1jI1ojbef3liY
 PnwAmz/Q1QiASOx3ZaXhM+0cBEQIxTCxTCcRBDYNCC9yqOet0uzUC4yY9EMx1zL8fT
 xPFR+0oqLgqxNNlT1G4JGhbqro5fxEgmvoyqG8bg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395BRYnF076902
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 06:27:34 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 06:27:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 06:27:33 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395BRXlR079796;
 Thu, 5 Oct 2023 06:27:33 -0500
Date: Thu, 5 Oct 2023 06:27:33 -0500
From: Nishanth Menon <nm@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Roger Quadros <rogerq@kernel.org>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <m-chawdhry@ti.com>, <sjg@chromium.org>, <jonas@kwiboo.se>,
 <srk@ti.com>, <afd@ti.com>, <bb@ti.com>, <praneeth@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: dts: k3-am625-beagleplay: Fix boot
Message-ID: <20231005112733.yhnij365feqsfqdg@mobility>
References: <20230929134646.214781-1-rogerq@kernel.org>
 <c430c549-6c6d-4d32-a51b-e2bfa597bd4a@siemens.com>
 <20231004121546.uvvqcbewyt5s6kdx@extrude>
 <2f55c3f5-7867-4db1-a0cb-7bc6f78ba044@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2f55c3f5-7867-4db1-a0cb-7bc6f78ba044@siemens.com>
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

On 06:18-20231005, Jan Kiszka wrote:
> On 04.10.23 14:15, Nishanth Menon wrote:
> > On 22:26-20231003, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Since commit [1] A53 u-boot proper is broken. This is because nodes
> >> marked as 'bootph-pre-ram' are not available at u-boot proper before
> >> relocation.
> >>
> >> To fix this we mark all nodes as 'bootph-all'.
> >>
> >> [1] 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>
> >> This may overshoot, but at least the board boots again. Could it be that 
> >> [1] broke even more boards?
> > 
> > Jan: https://lore.kernel.org/all/b1c62a7d-a90e-4212-8972-9b622e147975@kernel.org/
> > 
> > I got boot without r5-beagleplay.dts modified. and it is in line with
> > the changes in linux-next commit 944adefc7f88 ("arm64: dts: ti:
> > k3-am625-beagleplay: Add boot phase tags marking")
> > 
> 
> Yeah, no problem, missed that.
> 
> Meanwhile, I can fix our IOT2050 because I was unfortunatenly right:
> more havoc in sight. Did anyone tried to look at the fallouts
> systematically already? Is it only affecting the TI family?
> 

I know all of TI K3 platforms are broken, but I don't think (based on
discussions on the list so far), anyone actually went around non-TI
platforms to identify the ones that are broken.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
