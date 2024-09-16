Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0017C3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 13:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C9B888E43;
	Mon, 16 Sep 2024 15:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s54v6Owl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E3C88E77; Mon, 16 Sep 2024 15:29:23 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C694885F4
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 15:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48GDTFVA034698;
 Mon, 16 Sep 2024 08:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1726493355;
 bh=TaO1hc9N4zsnFuRaQb9MsCX5lGaurCMuc5ZAzQ49X7o=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=s54v6Owl059dZ43IJfQxbnXHAomutt+g7wTPJABZ4UKO+//BcdleuTiqZ+46Czhsf
 IwGquHBUemL1P7CoJUQlwWpOpKrFRG37urZr5QTWzz2OdhB2btgucv/i3N7oJwLozF
 zuM6+D78oiAVi/RmVRB8u3xDM+XCnNm8Di1hdDb0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48GDTFmi003871
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Sep 2024 08:29:15 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Sep 2024 08:29:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Sep 2024 08:29:14 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48GDTEBE059694;
 Mon, 16 Sep 2024 08:29:14 -0500
Date: Mon, 16 Sep 2024 08:29:14 -0500
From: Bryan Brattlof <bb@ti.com>
To: Guillaume La Roque <glaroque@baylibre.com>
CC: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Vishal Mahaveer <vishalm@ti.com>
Subject: Re: [PATCH v2 0/3] Add Android 14 bootflow support for AM62X and
 AM62P board
Message-ID: <20240916132914.2z2pycuod5xtcm3m@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240912-sitaraupstream-v2-0-2101323d3fa5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240912-sitaraupstream-v2-0-2101323d3fa5@baylibre.com>
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

On September 12, 2024 thus sayeth Guillaume La Roque:
> Ths patchset add support of Android 14 with boot image version 4
> for :
> - AM62X-SK EVM: https://www.ti.com/tool/SK-AM62B
> - BeaglePlay: https://beagleplay.org/
> - AM62PX-SK EVM: https://www.ti.com/tool/SK-AM62P-LP
> 
> Android Images use to test this series are on the Official TI website:
> - AM62x/BeaglePlay: https://www.ti.com/tool/PROCESSOR-SDK-AM62X
> - AM62PX: https://www.ti.com/tool/PROCESSOR-SDK-AM62P
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> Changes in v2:
> - Remove uneeded part in android fragment
> - Update commit message.
> - Link to v1: https://lore.kernel.org/r/20240902-sitaraupstream-v1-0-0c478c33c08b@baylibre.com
> 
> ---
> Guillaume La Roque (1):
>       board: ti: am62x_evm: Add android bootflow
> 
> Mattijs Korpershoek (2):
>       board: beagle: beagleplay: Add android bootflow support
>       board: ti: am62px: Add android bootflow support
> 

Looks great and thank you for the upstream Android support!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

