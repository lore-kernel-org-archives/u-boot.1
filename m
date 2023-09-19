Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AA2CD5BA0
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 12:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 240B386B38;
	Tue, 19 Sep 2023 14:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vLI5GALH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C678986B1D; Tue, 19 Sep 2023 14:06:05 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0242F86B38
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 14:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JC5wkq126880;
 Tue, 19 Sep 2023 07:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695125158;
 bh=5lcuPcpu7LXUkYM2sHIuNp1uZs1iRU61q1NYtKGVHCo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=vLI5GALHlKMVSRfpDl0CWjsGrc2QiSYZVkgaHRYozCgHgMWiQkkbpy45JYCw/BIc6
 Y1jwVzOZhJ1Sw52LHr3WcVeGKzsx+Oun9QCQoa/VEuQjSnIF5p8XIjY34sUqr7xCAQ
 vhl9f0kvw96qcR0yYMdcNLckcLdP7DAQdkAfzTmU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JC5wZC101793
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 07:05:58 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 07:05:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 07:05:58 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JC5wvc027360;
 Tue, 19 Sep 2023 07:05:58 -0500
Date: Tue, 19 Sep 2023 07:05:57 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>,
 Andrew Davis <afd@ti.com>, Nikhil M Jain <n-jain1@ti.com>
Subject: Re: [PATCH] J721S2 DTS Sync from v6.6-rc1 to u-boot
Message-ID: <20230919120557.p5ascjqffqo4jlja@famine>
References: <20230919-b4-upstream-j721s2-r5-pinmux-v5-0-a54d6ee26310@ti.com>
 <20230919111314.aumeucsnla6bk6zn@librarian>
 <20230919112053.g2dwnssl7s7hqjo5@ula0497581>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230919112053.g2dwnssl7s7hqjo5@ula0497581>
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

On 16:50-20230919, Manorit Chawdhry wrote:
[...]

> > 
> > Not sure what happened to your patches, but they are missing sequence
> > numbering and versioning info.
> > 
> 
> Am not sure either.. I had been using b4 for all the patches and I still
> see that my next revision queued by b4 also has the same problem. Not
> exactly sure what went wrong with b4 but would be careful next time.
> Thanks for pointing it out.

Please resubmit.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
