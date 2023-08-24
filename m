Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42509C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 12:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A979847C3;
	Thu, 24 Aug 2023 14:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WIablz2K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8CE885DD2; Thu, 24 Aug 2023 14:08:10 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9462B846EE
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 14:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OC7wex012527;
 Thu, 24 Aug 2023 07:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692878878;
 bh=PamHFnIAgzFdVjmJPuCzm50fd6Isp/YsmbYJKGEYog4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WIablz2KQuc8qzn7ZSSKBI+6qkmc1YSnESHdgbb1XzAP5mFn7z743bxtH4zUWtueo
 R6+Qz0X0FPUVELOuWdFBolqvA33WNcbcC+9kf5VcL0qmnGojsBy6uZqFDyuZEXYyAG
 z6zoJsNwr2/nW1DgxTeU1NN6wU87XKZkWLga0Bks=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OC7wfj039329
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 07:07:58 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 07:07:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 07:07:58 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OC7wCT092505;
 Thu, 24 Aug 2023 07:07:58 -0500
Date: Thu, 24 Aug 2023 07:07:58 -0500
From: Nishanth Menon <nm@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: Simon Glass <sjg@google.com>, Tom Rini <trini@konsulko.com>, Neha Francis
 <n-francis@ti.com>, Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew
 <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh
 <vigneshr@ti.com>, <u-boot@lists.denx.de>, Jan Kiszka
 <jan.kiszka@siemens.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
Message-ID: <20230824120758.gwmqphu4s36ytxu5@crushable>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
 <20230823171502.GQ3953269@bill-the-cat>
 <CAPnjgZ2t2aUnreA8Hzg11moQ2Z5hqW1r-16WTF0PRMjK3iXe_A@mail.gmail.com>
 <20230824001848.vgzl7rcphic3gu2n@carnival>
 <CAPnjgZ2qxm0KGFp5dM2Jzzcuib5npXodhYQ6u+dbO3oSBHA55A@mail.gmail.com>
 <20230824032709.phneggflsw2ps2dv@reanalyze>
 <87fs48rgto.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87fs48rgto.fsf@baylibre.com>
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

On 10:21-20230824, Mattijs Korpershoek wrote:
[...]

> >> Some other minor feedback:
> >> 
> >> - The 'make' lines should really have -j $(nproc) added
> >
> > Different styles of shells..
> >
> >> - The $ signs at the start of each command in the docs are a pain
> >> since it stops me copying the commands into the terminal - can you
> >> remove them?
> >
> > hehe.. "dont" let people blindly copy paste without understanding what is
> > going on argument?
> >
> > If folks are OK, I sure can send a different patch series for that.. (or
> > maybe motivate someone to do that instead of me ;))
> 
> Have we considered using the .. prompt:: extension ?
> 
> https://pypi.org/project/sphinx-prompt/
> 
> The prompt extension automatically adds a prompt (like $) in front of
> each line and disallows copying it when copying from the html generated page.

That does look like a very interesting option. This could very well be a
different series of it's own, if Heinrich is OK with it..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
