Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C585EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 11:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD105864B4;
	Wed, 23 Aug 2023 13:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g4/XKbcN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 937D4864B6; Wed, 23 Aug 2023 13:38:28 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43773864B3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37NBcHRT094414;
 Wed, 23 Aug 2023 06:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692790697;
 bh=udsDkkHdl3PbcpDyxZ3+3QQFICMjokiNy/DBhj1uKRE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=g4/XKbcNgDmbJ5PZNSCmNapLRExmd0W+ljvg8Jlwvm5KTET2yJJngcvLN3dERfya6
 Qj7r4ELWvoHeM7dZPiAIZ7LW84cmt9tQWJtiVyny7xtf18k1sV2zlxB5bGV3v6tKdk
 hxEgCY6Kzi4EnTf2Z9vqlBNQIZJQSQLP5YkkLxwc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37NBcH1U019168
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 06:38:17 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 06:38:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 06:38:16 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37NBcGpU077226;
 Wed, 23 Aug 2023 06:38:16 -0500
Date: Wed, 23 Aug 2023 06:38:16 -0500
From: Nishanth Menon <nm@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Neha Francis
 <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V4 4/8] drivers: mmc: am654_sdhci: Update OTAP/ITAP delay
Message-ID: <20230823113816.b5qrst4ut77e4d5r@lucid>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-5-nm@ti.com> <87r0nufaik.fsf@baylibre.com>
 <9ffa96cd-df18-d298-41c2-080a187b7410@ti.com>
 <caab6d37-199a-7d1c-6b60-9297e3838fd5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caab6d37-199a-7d1c-6b60-9297e3838fd5@ti.com>
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

On 15:48-20230823, Nitin Yadav wrote:
[...]

> > > > -    for (i = MMC_HS; i <= MMC_HS_400; i++) {
> > > > +    for (i = MMC_LEGACY; i <= MMC_HS_400; i++) {
> > > 
> > > I'm not super familiar with mmc drivers in general, but it feels like
> > > this bit does not really belong in this patch. >
> > > Is this another bugfix for removing otap-del-sel for MMC_LEGACY devices
> > > or does U1 UHS SD cards are considered to be of MMC_LEGACY type ?
> > yes, its two different fix. Internally I posted two patches for them.
> > can be referred in below links:
> > 
> > https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-6.1.y-cicd&id=b5a2f7972fd142df03a15ba58829aa068c891abf
> > 
> > https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-6.1.y-cicd&id=527095165281cbc60a1b42995c1e55e6756cbe93
> > 
> For uboot somehow it got merged as single patch as It was one of my first
> fix :) .

Thanks for the pointer. I will pick the latest up for V5.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
