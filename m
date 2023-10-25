Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65156C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 15:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58B3D87AFF;
	Wed, 25 Oct 2023 17:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EAC4r2oX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE26187B00; Wed, 25 Oct 2023 17:59:17 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E8E870D4
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 17:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39PFxDKU011469;
 Wed, 25 Oct 2023 10:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698249553;
 bh=w5u55CUhuYROxV9pdf18JwKPSjbbUv0p8VApbACgJH8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=EAC4r2oXaAvU5FtExHiqJ5W0ZUwpQxEQofV5siICzSzf7KF/5mV91CWkhtLVNdvye
 G1vkkoUkz+X+puEUnbs+eND8V38Lfz74Shf4duqjqBIV2jRPzi0+FO03Y1eISYHT8V
 6N7PWxF6J939qcf3ezyj6sdvsNgMRl4AhAX1slWs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39PFxDxI027993
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 25 Oct 2023 10:59:13 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Oct 2023 10:59:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Oct 2023 10:59:12 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39PFxCTW022294;
 Wed, 25 Oct 2023 10:59:12 -0500
Date: Wed, 25 Oct 2023 10:59:12 -0500
From: Nishanth Menon <nm@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/4] arm: dts: Add support for AM62x LP SK
Message-ID: <20231025155912.4p36rhqswbqbs5is@parameter>
References: <20230927082105.3729470-1-n-yadav@ti.com>
 <20230927082105.3729470-3-n-yadav@ti.com>
 <20230927115231.i3kg3wvpvqmmexnd@dazzling>
 <94ae9feb-0cc1-13f9-fbd9-d921717b45f7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <94ae9feb-0cc1-13f9-fbd9-d921717b45f7@ti.com>
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

On 16:15-20231025, Nitin Yadav wrote:
[...]

> >> +#include "k3-am62x-sk-common-u-boot.dtsi"
> >> +
> >> +#include "k3-am62-lp-sk-binman.dtsi"
> > 
> > Are you sure you don't need the dt phase properties for regulators for
> > mmc to work?
> you have added bootph-* flags to those nodes too .?

I have no idea what I am supposed to be doing.. So: default answer:
read the code?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
