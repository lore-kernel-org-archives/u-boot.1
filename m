Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408A5C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 11:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6EB83FBE;
	Fri, 11 Apr 2025 13:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CgO5f4eV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52DD283FBF; Fri, 11 Apr 2025 13:23:22 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DACB483FBD
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 13:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BBNHHm2060032
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 06:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744370598;
 bh=yFNCNRNS9X0szCvdcraWTFs2acUb2ownH+43FuMWS4I=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=CgO5f4eV0ecY92L5kQDH1b5u1gBKVtAtvX76EaJOgT4BL/45ZlvXQ5p7iJBl4ZnqU
 XIY/DcMw5wJcF6S5gjLqcUszOFxy40l0zQAE/zpW5R/gJKnVJzMaqZ9dBF7iULXone
 iydklv9Bglis0wnWgVh/2n2WwjLDOxz78MZKR6ZA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BBNHdp128714
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Apr 2025 06:23:17 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 06:23:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 06:23:17 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BBNHAp067702;
 Fri, 11 Apr 2025 06:23:17 -0500
Date: Fri, 11 Apr 2025 06:23:17 -0500
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andrew Davis <afd@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Jonas Wood <jw@ti.com>,
 <praneeth@ti.com>, <u-boot@lists.denx.de>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH V2] firmware: ti_sci: Scan all device instances when
 releasing exclusive devices
Message-ID: <20250411112317.4pzjdotqe4iefdfk@fiscally>
References: <20250407121554.1010490-1-nm@ti.com>
 <c7aeedc9-3786-4d1f-b68d-22252d9c3197@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c7aeedc9-3786-4d1f-b68d-22252d9c3197@ti.com>
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

On 11:04-20250411, Kumar, Udit wrote:
> Hi Nishanth,
> 
> Sorry for basic question
> 
> On 4/7/2025 5:45 PM, Nishanth Menon wrote:
> > [..] This creates a problem when Device Manager(DM) firmware starts up later
> > on in the boot process and identifies that this instance of i2c is
> 
> Do we need to do clean up, where DM is loaded as different binary .
> 
> As I understand this cleanup is needed, where DM is running along with
> SPL/R5
> 
> or I am missing something

The cleanup makes sense whether we use split or unified DM. The
resources R5SPL uses may or may not be used further down the chain of
software (eeprom was an example where we read and cache the data for
further downstream steps to use). We should never be leaving a messy
system behind (and consequences as a result). This is the reason we
cleanup the exclusively held devices during the boot phase before remote
cores are started up.

We already do this cleanup. which is good, the trouble with multi-DTB
FIT image is that the cleanup is partial, which is what this patch
attempts to solve.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
