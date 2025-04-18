Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D2DC369CB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 19:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D7798329F;
	Fri, 18 Apr 2025 21:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pT/Mm9QF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB90382AA8; Fri, 18 Apr 2025 21:07:09 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3088E82A81
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 21:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53IJ71v71062642
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Apr 2025 14:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745003222;
 bh=nYcFcTsFYQ/LFDQI7IiEYvXgLdjoLuwZ+x0ut8J4SCA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=pT/Mm9QFnU1zSVmaWHTb91ecO27hohM6fNz04ovU5FnjUqa2S0BrvmXOwST5hqArn
 hcTgsjnsPhpHuChWCepSfZXToQoFpjsHFJXLxj93GWhtwvrzALNuYNeK553O2vbcm3
 gOUirv2hm4ETSdh0inkmeU5VRs4X7MSsZSQ5EqrU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53IJ71lA086516
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 18 Apr 2025 14:07:01 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Apr 2025 14:07:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Apr 2025 14:07:01 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53IJ717G128817;
 Fri, 18 Apr 2025 14:07:01 -0500
Date: Fri, 18 Apr 2025 14:07:01 -0500
From: Nishanth Menon <nm@ti.com>
To: Jon Humphreys <j-humphreys@ti.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/9] board: beagle: beagley-ai: Cleanups and
Message-ID: <20250418190701.22ctug3xcriyp3r7@gaming>
References: <20250411225717.3117370-1-nm@ti.com>
 <86ldryl77h.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86ldryl77h.fsf@udb0321960.dhcp.ti.com>
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

On 18:05-20250417, Jon Humphreys wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Just happened to get a BeagleY-AI at desk and happened to test master
> > branch (7dd49a9264a6 drivers: scsi: Add 'erase' support), noticed a few
> > issues which were rather easy to solve.. so, here we go:
> >
> > Bootlog: https://gist.github.com/nmenon/a3a18825a783c0c3798cc72506cfead2
> >
> > I tried to enable efi capsules, but I lost patience rather too soon. So
> > probably some other time or perhaps someone else would like to contribute.
> >
> 
> Nishanth, since the BeagleY-AI does not have any on-board non-volatile
> storage, I don't think efi capsule update makes any sense anyway.

Thanks for clarifying. I was not aware of this limitation.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
