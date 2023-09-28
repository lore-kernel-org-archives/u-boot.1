Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012EFE732DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE6786E51;
	Thu, 28 Sep 2023 16:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BYbJwlVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA1B86E52; Thu, 28 Sep 2023 16:30:58 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B68864C3
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38SEUswx093212;
 Thu, 28 Sep 2023 09:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695911454;
 bh=K+I0QrAs531OoY83wIe9yOHNA5NkZ3Nfb+copgCKOcs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=BYbJwlVDAXfkhQ39aezdir3/HIPMrZr1cgOFtKyLuemTFSpShNIwmISs++m1AK9Yz
 ff+694O1oP7ysDsP4mBnoq4SgkiEreVbE5s2wyfT0egMeUPbzmYBfm+nlb3eH2tixP
 lQfRmPg92dKIy4d9RTKUJJImpiPVyD2eHTIVDDOw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38SEUsfr001278
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Sep 2023 09:30:54 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 09:30:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 09:30:54 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38SEUsPT036340;
 Thu, 28 Sep 2023 09:30:54 -0500
Date: Thu, 28 Sep 2023 09:30:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/4] arm: dts: Refactor common dtsi file for R5 and A53 SPL
Message-ID: <20230928143054.35o7di4qhjwrlncb@fried>
References: <20230927082105.3729470-1-n-yadav@ti.com>
 <20230927082105.3729470-2-n-yadav@ti.com>
 <20230927115601.3gdv4mc2i76gh5rb@tycoon>
 <3f2ad43b-2c3a-3c00-124b-3cd1c3a5a49c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f2ad43b-2c3a-3c00-124b-3cd1c3a5a49c@ti.com>
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

On 15:09-20230928, Nitin Yadav wrote:
> 
> 
> On 27/09/23 17:26, Nishanth Menon wrote:
> > On 13:51-20230927, Nitin Yadav wrote:
> >> Add k3-am62x-r5-sk-common to include nodes common for R5
> >> SPL from k3-am625-r5-sk for AM62x SoC based boards. Add
> >> k3-am62x-sk-common-u-boot to move common nodes of A53 SPL
> >> stage from k3-am625-sk-u-boot.
> >>
> >> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> >> ---
> > [...]
> >> +#include "k3-am625-sk-binman.dtsi"
> > 
> > Might be a good time to refactor and squash sk-binman.dtsi to
> > u-boot.dtsi ?
> 
> IMO, I find this way looks more organized and readble.

NAK. it is already adding to the delta files we are having to manage.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
