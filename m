Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55287C8302F
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 23:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A7E81FFC;
	Tue,  1 Jul 2025 01:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lW7dzKBw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B68782ADA; Tue,  1 Jul 2025 01:02:09 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85E8581FEE
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 01:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55UN1sOD3464906;
 Mon, 30 Jun 2025 18:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751324514;
 bh=MPz0Np3DaROTZs5/Fviq8ttQQqhrvZqLjl2La7JZKrk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=lW7dzKBwZUeNuRbzo5uYTwcYRiB8/XFN72uuJzIQjUx6tMhmbWIGeAf5cpk76S5qE
 Js7vYl7FhpAQVQ04NLq6k+ShAu63eW+QKhn7PRfi6P+PQw6PC7oAdtTfKbrT4HZNif
 Q1Odb7Fq9Wk5iuGJ/JN6+UWqEycXcQgI+DGzUogM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55UN1s972321548
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 30 Jun 2025 18:01:54 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 30
 Jun 2025 18:01:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 30 Jun 2025 18:01:54 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55UN1soH486874;
 Mon, 30 Jun 2025 18:01:54 -0500
Message-ID: <9732f199-2078-431a-9b0a-2118f0b98df6@ti.com>
Date: Mon, 30 Jun 2025 18:01:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] board: ti: am33xx: Add Ethernet support for
 Beaglebone Green Eco
To: Romain Gantois <romain.gantois@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>
CC: "Bajjuri, Praneeth" <praneeth@ti.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Miguel Gazquez <miguel.gazquez@bootlin.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
References: <20250626-bbge-ethernet-v1-0-5b544fb1898f@bootlin.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250626-bbge-ethernet-v1-0-5b544fb1898f@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Romain,

On 6/26/25 11:20 AM, Romain Gantois wrote:
> Hello everyone,
> 
> This is version one of my series which enables Ethernet support on the BBGE
> board. This requires three main changes:
> 
>   - Describing the MAC<->PHY link and DP83867 PHY accurately in the device
>     tree
>   - Enabling the RGMII1 pinmux configuration
>   - Enabling the DP83867 driver
> 
> These changes are all applied in patch 2.
> 
> Patch 1 enables excluding the DP83867 driver from SPL. This is done to
> avoid size issues when adding the DP83867 driver to the am335x-evm
> defconfig.
> 

TFTP commands worked for me, for the series:

Tested-by: Judith Mendez <jm@ti.com>

