Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35A3C10F04
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 15:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7595386C8E;
	Tue,  5 Dec 2023 16:22:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Vr6paKVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4AFC87441; Tue,  5 Dec 2023 16:22:30 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9508868BF
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 16:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FMQCW020164;
 Tue, 5 Dec 2023 09:22:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701789746;
 bh=ED3DV++prW1KAMeP08byRDle7f+rIKl5F0zN97bWICQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Vr6paKVT6wwtPpSMNSvpaM11BIULxHhwy1aWcogBFy+Wf96rrNqjRFVMXRPCVkbJJ
 YPhUDgSpTgJFRJbkxeq/cwIdN59fNBsZPB4JMcq5pdAGuQlDCSReMLqSmhK6dFUoNo
 NY8HowU6uwEkA8qDBAxbqVVkXBNwLQ5Mcl5j5xGQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5FMQGI104419
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 09:22:26 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 09:22:26 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 09:22:26 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FMQSZ104122;
 Tue, 5 Dec 2023 09:22:26 -0600
Date: Tue, 5 Dec 2023 09:22:26 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Dhruva Gole <d-gole@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] doc: board: beagle: am62x_beagleplay: Delete SW_PRNG
 flag for OPTEE
Message-ID: <20231205152226.krqb3i7s3yo2zsab@extrovert>
References: <20231201102954.47582-1-d-gole@ti.com>
 <20231201102954.47582-2-d-gole@ti.com>
 <20231204192940.yfeqv7fewj6izrpk@tightly>
 <9bed6378-56f9-4a76-98a4-3516687a6033@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9bed6378-56f9-4a76-98a4-3516687a6033@ti.com>
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

On 08:46-20231205, Andrew Davis wrote:
> On 12/4/23 1:29 PM, Nishanth Menon wrote:
> > On 15:59-20231201, Dhruva Gole wrote:
> > > Delete the flag CFG_WITH_SOFTWARE_PRNG as it's not necessary/ boot
> > > requirement for this SoC
> > > 
> > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > > ---
> > >   doc/board/beagle/am62x_beagleplay.rst | 1 -
> > >   1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
> > > index 7784e62b0b71..50d7d3c620d7 100644
> > > --- a/doc/board/beagle/am62x_beagleplay.rst
> > > +++ b/doc/board/beagle/am62x_beagleplay.rst
> > > @@ -63,7 +63,6 @@ Set the variables corresponding to this platform:
> > >     # we dont use any extra TFA parameters
> > >     unset TFA_EXTRA_ARGS
> > >     export OPTEE_PLATFORM=k3-am62x
> > > -  export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
> > >   .. include::  ../ti/am62x_sk.rst
> > >       :start-after: .. am62x_evm_rst_include_start_build_steps
> > > -- 
> > > 2.34.1
> > > 
> > NAK. RNG is needed to seed standard distros.
> 
> You have this backwards, setting WITH_SOFTWARE_PRNG=y forces the SW
> RNG, disabling the HW RNG. Without this line the HW RNG is the default.


That is not the rationale with which the series was posted. I would
prefer we use HW RNG by default. but as I understand there are a bunch
of f/w bugs preventing us from doing so. if they are resolved, then the
commit message argument should be that the bugs are fixed, so we can
easily use then with f/w version x.y.z onwards.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
