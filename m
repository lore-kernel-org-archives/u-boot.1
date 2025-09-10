Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E79CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 14:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16EBD830B4;
	Wed, 10 Sep 2025 16:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zVworByz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDBB8318E; Wed, 10 Sep 2025 16:57:10 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02690830A0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 16:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58AEuv1D160520;
 Wed, 10 Sep 2025 09:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757516217;
 bh=Dnni1o16LMSK/TQtHPP7jElTTxCiguCxGC7dJQzxHIk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=zVworByzz3PMwYg8VvzjqyCZwq6izUNNqFd0cXTvZ2cbbR8ycPja5FQ6UK3Yat6Zr
 wdCbCSptL9ZvwFS81EIZM+ABi4ZnKMjVqv8zcueKbJZ0ek80yEl2+6djGXfbvLxgUH
 VaXzfEbN5Yrtq0lvAV6NMbwwF1eB18BgAsPoeDVk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58AEuv9Q3997867
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 09:56:57 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 09:56:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 09:56:57 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58AEuvA1648504;
 Wed, 10 Sep 2025 09:56:57 -0500
Date: Wed, 10 Sep 2025 09:56:56 -0500
From: Bryan Brattlof <bb@ti.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <jm@ti.com>, <s-k6@ti.com>,
 <quentin.schulz@cherry.de>, <afd@ti.com>, <j-humphreys@ti.com>,
 <anshuld@ti.com>, <n-francis@ti.com>, <danishanwar@ti.com>,
 <rogerq@kernel.org>, <w.egorov@phytec.de>, <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <s-vadapalli@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v2 0/3] Add PCIe boot support on TI AM64X SoC
Message-ID: <20250910145656.5lesv67c5tq5tvar@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250616165638.632089-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250616165638.632089-1-h-salunke@ti.com>
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

On June 16, 2025 thus sayeth Hrushikesh Salunke:
> This patch series adds support for booting over PCIe on TI AM64X SoC.
> 
> AM64X contains single instance of PCIe controller, which can operate in
> endpoint mode to support PCIe boot. This series:
> 
> - Adds PCIe as a valid boot media for AM64X.
> - Enables necessary config options to support PCIe boot.
> 
> This feature has been tested on AM64X EVM. Following are the logs
> corresponding to this feature.
> https://gist.github.com/hrushikesh221/bb11746d4325a27f209028573f3255a1
>
> Program used to copy bootloaders from PCIe Root-Complex to Endpoint:
> https://gist.github.com/hrushikesh221/6dc406b72f38762357b8e7f81a47db56
> 

We need to find a way to put this sequence or this example code in the 
board docs. I don't want to have to rely on your Github account or my 
memory when we need to revisit this in a year or two. 

~Bryan
