Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6910AC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 16:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF58F8842F;
	Tue, 16 Apr 2024 18:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f69ZpomU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3547F88426; Tue, 16 Apr 2024 18:23:08 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2320588431
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 18:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43GGN2Ee046348;
 Tue, 16 Apr 2024 11:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713284582;
 bh=xJfcXWhnMUDhceTM5b66PiZEcbMwW3XurDnY5gh+Czs=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=f69ZpomU8dviqU0nFvi2M7hidcPm33K43tQrQ1ccbbDRensfWIZQEcz1FP+tMcnEn
 w/TodjTvycDqEHjoQigqmrryzcqhVlzb876rY15qIXb/iRsIFGBzoYwU9ItzhVDZYL
 Ly98xTjjQvsCuLqRM6l5mz8MOQY8ES7Sm2v4yi/k=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43GGN2CD095845
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Apr 2024 11:23:02 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 11:23:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 11:23:02 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43GGN2DQ056251;
 Tue, 16 Apr 2024 11:23:02 -0500
Message-ID: <465712ed-38d7-4364-b14e-e17f8febb0c4@ti.com>
Date: Tue, 16 Apr 2024 11:23:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: am62px_evm_a53_defconfig: Enable MMC UHS config
 option
From: Judith Mendez <jm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
References: <20240408160136.1325821-1-jm@ti.com>
Content-Language: en-US
In-Reply-To: <20240408160136.1325821-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi all,

On 4/8/24 11:01 AM, Judith Mendez wrote:
> Enable MMC UHS support for to allow to enter the UHS
> modes for MMC0.
> 

I have sent v2 for this patch since there was a typo in
the patch description.

~ Judith

