Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1354C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 20:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46A5F8785E;
	Wed,  6 Mar 2024 21:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TlVbjn6I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6621C8786C; Wed,  6 Mar 2024 21:55:26 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36CB9877FB
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 21:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426KtL93078923
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 14:55:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709758521;
 bh=JuEup4646VnO+GHepFywt3bydRDZN6Cry+hx3Hff7JE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TlVbjn6IYeGPpQFtYPLpWRdWNslQwz7XsRMdHmqiG98Rs0b+9WJ1dTr9S3f/w7zY3
 JnBx3jVyY32hlKkgQqLsgv421rQ7b2fiYJ2aC6AHobDgp8/x/vCFLegqJ8J67AQ9yS
 v4R7A+r6lsfe4aNZ76XheJ6DiTGar38OzGBt4fiI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426KtLSF026548
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 14:55:21 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 14:55:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 14:55:21 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426KtLZc059758;
 Wed, 6 Mar 2024 14:55:21 -0600
Date: Wed, 6 Mar 2024 14:55:21 -0600
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Aniket Limaye <a-limaye@ti.com>, <u-boot@lists.denx.de>,
 <vaishnav.a@ti.com>, <a-nandan@ti.com>
Subject: Re: [PATCH 1/4] configs: j7200_evm_*_defconfig: Enable OSPI configs
Message-ID: <20240306205521.zen2keqovwpukfnb@emptiness>
References: <20240306063749.1411176-1-a-limaye@ti.com>
 <20240306063749.1411176-2-a-limaye@ti.com>
 <3dd9a6b3-7b89-4694-adba-dd86f1d990a9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3dd9a6b3-7b89-4694-adba-dd86f1d990a9@ti.com>
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

On 18:41-20240306, Kumar, Udit wrote:
> 
> On 3/6/2024 12:07 PM, Aniket Limaye wrote:
> > Add the necessary configs required for OSPI functionality.
> > Also update the ospi flash partition offsets as per the devicetree.
> > 
> > Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> > ---
> >   configs/j7200_evm_a72_defconfig | 10 ++++++++--
> >   configs/j7200_evm_r5_defconfig  |  9 +++++++--
> >   2 files changed, 15 insertions(+), 4 deletions(-)
> > 

Could we not do fragments?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
