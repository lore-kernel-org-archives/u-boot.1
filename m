Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631FFC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 13:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CAFA86481;
	Mon, 28 Aug 2023 15:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GfhMKZQD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D2248648E; Mon, 28 Aug 2023 15:03:16 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B2B58645E
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 15:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SD2obc009252;
 Mon, 28 Aug 2023 08:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693227770;
 bh=sSTYPjVOFen8c2pIL3nkwvpX3VlX539n58LJ/0JPIn8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=GfhMKZQD8Mk1bniyC4PWPT5L7dVZSo6hNNnnkwD/XAGc2oyh64MCAk2aP2BhGUUul
 tYemJe0Jlb96pIvsnl6GNZRBOuewlvk+RCfDrmMnwuk94Xh9EsBjltkfvVZUeck/0V
 JkDWnO176Q6Scov3BhCQwrKFcS38Il7QQV62XhLw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SD2oHc019931
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 08:02:50 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 08:02:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 08:02:49 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SD2ncb005112;
 Mon, 28 Aug 2023 08:02:49 -0500
Date: Mon, 28 Aug 2023 08:02:49 -0500
From: Nishanth Menon <nm@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Neha Francis
 <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [RFC PATCH 2/2] doc: board: ti: k3: Convert to sphinx-prompt
Message-ID: <20230828130249.elassqketddnif5x@lunchbox>
References: <20230824154036.3650607-1-nm@ti.com>
 <20230824154036.3650607-3-nm@ti.com> <87v8czwpwk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87v8czwpwk.fsf@baylibre.com>
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

On 10:07-20230828, Mattijs Korpershoek wrote:
[...]

> > -.. code-block::
> > +.. prompt:: bash
> > +  :prompts: =>
> 
> nitpick: This can be a one-liner by using the "prompts" positional argument
> 
>  .. prompt:: bash =>
> 
> 
> >  
> > -  => env export -t $loadaddr <list of variables>
> > -  => fatwrite mmc ${mmcdev} ${loadaddr} ${bootenvfile} ${filesize}
> > +  env export -t $loadaddr <list of variables>
> > +  fatwrite mmc ${mmcdev} ${loadaddr} ${bootenvfile} ${filesize}
> >  
> >  **Reading from MMC/EMMC**
> >  
> > @@ -486,10 +487,11 @@ mmcdev) and set the environments.
> >  If manually needs to be done then the environment can be read from the
> >  filesystem and then imported
> >  
> > -.. code-block::
> > +.. prompt:: bash
> > +  :prompts: =>
> 
> nitpick: Same here

Thanks for catching, will fixup in a follow on series.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
