Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC73DCA0ED4
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 12:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398D786E78;
	Tue, 12 Sep 2023 14:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lZu9GOZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F4386E90; Tue, 12 Sep 2023 14:44:31 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5350986E6E
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 14:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38CCiH5R129545;
 Tue, 12 Sep 2023 07:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694522657;
 bh=1RcrNSJo5T8Hkgu4UcHjKPdraVQtyEmqbNZN/34h52s=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lZu9GOZp2D/JGWU0Z7n673/b8X6v+P7Yk23MObns0i93+vMKkDXB6ixW48Ol2NKAO
 j0p6spnqBZg1z/3HFOadN+4Fgvx6EPRp1yiarmmtVdfyjea1rgqqfaugLSs2lH+3QY
 RQjsYbW7N5oS52ndNcwZCnKKNkOPgWRx9I0qRTz8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38CCiHWT075950
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 07:44:17 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 07:44:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 07:44:16 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38CCiGwX055143;
 Tue, 12 Sep 2023 07:44:16 -0500
Date: Tue, 12 Sep 2023 07:44:16 -0500
From: Nishanth Menon <nm@ti.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>, "j-kacines@ti.com"
 <j-kacines@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "n-francis@ti.com" <n-francis@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "afd@ti.com" <afd@ti.com>,
 "a-nandan@ti.com" <a-nandan@ti.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "lukma@denx.de" <lukma@denx.de>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "j-choudhary@ti.com"
 <j-choudhary@ti.com>, "yanhong.wang@starfivetech.com"
 <yanhong.wang@starfivetech.com>, "christian.gmeiner@gmail.com"
 <christian.gmeiner@gmail.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "rasmus.villemoes@prevas.dk"
 <rasmus.villemoes@prevas.dk>, "sabiya.d@ti.com" <sabiya.d@ti.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "bb@ti.com" <bb@ti.com>, "rogerq@kernel.org"
 <rogerq@kernel.org>
Subject: Re: [PATCH v3 13/16] arm: dts: Introduce am69-sk u-boot dts files
Message-ID: <20230912124416.ulli4gnkeostcwjm@linguini>
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-14-a-nandan@ti.com>
 <c404a39ce71abe4e4fb3a7cc143cb62e7779f802.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c404a39ce71abe4e4fb3a7cc143cb62e7779f802.camel@toradex.com>
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

On 12:20-20230912, Marcel Ziswiler wrote:
[...]

> > diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
> > new file mode 100644
> > index 0000000000..8c789c4f28valuation module (EVM) is a pl
> > --- /dev/null
> > +++ b/arch/arm/dts/k3-am69-r5-sk.dts
> > @@ -0,0 +1,105 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> Should be:
> 
> GPL-2.0-only
Indeed https://spdx.org/licenses/GPL-2.0-only.html

Should be fixed in kernel across the board for K3 devices. Thanks for catching.


> BTW: Why is TI not releasing their device trees with a more permissive license like GPL-2.0-or-later OR MIT
> like most others do?

We can check again, but some sort of corporate policy thing, I suspect.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
