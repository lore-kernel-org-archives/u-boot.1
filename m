Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ACBE810D0
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 11:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6292386DED;
	Wed, 27 Sep 2023 13:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qhULDyG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 671C286DE9; Wed, 27 Sep 2023 13:56:05 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 598F086DC5
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 13:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RBu1LL059596;
 Wed, 27 Sep 2023 06:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695815761;
 bh=LTiMWleftssBX1mdHfcuMgWts2bVDQckmRZ2tqPrqLA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=qhULDyG1i7WtBIVDv1Q/NQpyojEgaH4qBjGmuka0qEl7RUZywps2EJFvu7HWO9lb4
 BB3iEP2nZk5en/ZcyxWXTafO2solQRPEKRb5vEFx0q0NVEUKLqSCbLiRUw+n5yPt3Y
 JHqYxNfQYCM+8lLZv5dVMJsD8mi0BBqKL9wYXDX4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RBu1VY025412
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 06:56:01 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 06:56:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 06:56:01 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RBu1Lf085361;
 Wed, 27 Sep 2023 06:56:01 -0500
Date: Wed, 27 Sep 2023 06:56:01 -0500
From: Nishanth Menon <nm@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/4] arm: dts: Refactor common dtsi file for R5 and A53 SPL
Message-ID: <20230927115601.3gdv4mc2i76gh5rb@tycoon>
References: <20230927082105.3729470-1-n-yadav@ti.com>
 <20230927082105.3729470-2-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230927082105.3729470-2-n-yadav@ti.com>
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

On 13:51-20230927, Nitin Yadav wrote:
> Add k3-am62x-r5-sk-common to include nodes common for R5
> SPL from k3-am625-r5-sk for AM62x SoC based boards. Add
> k3-am62x-sk-common-u-boot to move common nodes of A53 SPL
> stage from k3-am625-sk-u-boot.
> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
[...]
> +#include "k3-am625-sk-binman.dtsi"

Might be a good time to refactor and squash sk-binman.dtsi to
u-boot.dtsi ?

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
