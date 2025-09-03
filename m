Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037DDCA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 04:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29AFF83420;
	Wed,  3 Sep 2025 06:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p8ZAP3Be";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A01F83438; Wed,  3 Sep 2025 06:08:41 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDC5983403
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 06:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58348bL53176629
 for <u-boot@lists.denx.de>; Tue, 2 Sep 2025 23:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756872517;
 bh=qRTR1e3RJgIVe1WwNxssJpE9cacDdsOcBAKeb5fnj2c=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=p8ZAP3BeWFTz8D9efzRveGHtGhAIaOBnrvVwEahLz4fuGTpDXHeH1VxESjTddnWVM
 EgZkT0WbLol82qXMGPGzwHGcZ4dlaeND5Pg5ygcHP96VY2u0RLndq5BWqHNg2G2qQ5
 RDYNbKDlZl8+RDULcrswlXLuYG9cc6qABqmmWfF8=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58348bWi3990354
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 2 Sep 2025 23:08:37 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 23:08:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 23:08:37 -0500
Received: from [172.24.17.2] (lt5cg1457vgj.dhcp.ti.com [172.24.17.2])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58348Xsw664239;
 Tue, 2 Sep 2025 23:08:34 -0500
Message-ID: <3a89ef19-a612-49b3-96d4-92cf096e76b7@ti.com>
Date: Wed, 3 Sep 2025 09:38:33 +0530
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [RFC PATCH 0/5] Add initial support for AM62D2-EVM
To: Paresh Bhagat <p-bhagat@ti.com>, <praneeth@ti.com>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <bb@ti.com>, <khasim@ti.com>, <v-singh1@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>
References: <20250902060703.191688-1-p-bhagat@ti.com>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250902060703.191688-1-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On 9/2/2025 11:36 AM, Paresh Bhagat wrote:

[...]

> 
> Branch used-next
> 
> Kernel Patch
> https://lore.kernel.org/all/20250708085839.1498505-1-p-bhagat@ti.com/
> 
> Boot Logs
> https://gist.github.com/paresh-bhagat12/6e169340c222427c7648b1ef3ca5067f
> 
> Paresh Bhagat (5):
>   board: ti: Introduce the basic files needed to support am62d
>   board: ti: am62dx: Add board configs for am62d
>   configs: Introduce configs for the AM62D2-EVM
>   arch: mach-k3: Introduce support for AM62D2-EVM
>   arm: dts: Introduce AM62D2-EVM dtbs

Whats your rational for choosing above patch order?

Regards
Vignesh


