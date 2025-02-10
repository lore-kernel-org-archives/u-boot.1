Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16E3C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 22:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D83880548;
	Mon, 10 Feb 2025 23:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Sx7cFive";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC088806FE; Mon, 10 Feb 2025 23:43:37 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B40D8043C
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 23:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51AMhWnF209581
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Feb 2025 16:43:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739227412;
 bh=lEbYJeExW7MQzruICXDGoFvXymbmd3eiMsSWWfCVM+0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Sx7cFivegTC2M0ZP4PpyySK3T+quu/pyw6SaLZzzOJsDXmd6g2Jpl4T3n1znKf/6l
 GJo2YRWtawiQBUm5haRR9RPEvYJdFeKXTmKNbiFWwRsMgn5Cgk/5vzRQ0iTV19usZa
 n1JvRJg1bmpHcL1ZOvl6IeeYrZeXs2IRdektK470=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51AMhWee020686
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Feb 2025 16:43:32 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 16:43:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 16:43:31 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51AMhV9Q013478;
 Mon, 10 Feb 2025 16:43:31 -0600
Message-ID: <af33ccc9-de0d-479b-9890-2c9c7f2996bb@ti.com>
Date: Mon, 10 Feb 2025 16:43:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] Introduce K3 remoteproc driver for M4 subsystem
To: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
References: <20250210202944.1071931-1-jm@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250210202944.1071931-1-jm@ti.com>
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

Hi Tom,

On 2/10/25 2:29 PM, Judith Mendez wrote:
> Some K3 devices like am62x and am64x have a M4 processor in the MCU
> voltage domain. This patch series introduces remoteproc M4 driver which
> will be used to load firmware into and start the M4 remote core.
> 
> This series also adds support for R5F cores on am64x SoCs in patch 2 and
> sets up environment to load FW in remote cores in patch 3,4,5.
> 
> This patch series also enables remoteproc drivers by default as per what
> remoteproc sybsystem is supported per SoC, thus all remoteproc options
> are now deleted in configs/* since they are no longer required.
> 
> This patch series was tested on am64x EVM, am62x SK, am62ax SK,
> am62px SK boards.
> 
> Any additional tested by's are welcome since I was not able to
> test any additional boards.
> 
> Tested by running the following commands in u-boot prompt:
> 
> => setenv dorprocboot 1
> => run boot_rprocs
> 
> Links:
> v4: https://lore.kernel.org/u-boot/20250206015406.2702944-1-jm@ti.com/
> v3: https://lore.kernel.org/u-boot/20250130223256.1944522-1-jm@ti.com/
> v2: https://lore.kernel.org/u-boot/20250129225233.467139-1-jm@ti.com/
> v1: https://lore.kernel.org/u-boot/20250123010759.810799-1-jm@ti.com/
> 


Forgot to add Andrew's Reviewed-by, apologies. If this series version
is picked up, could the tag be added? If not please let me know so I can
re-spin with Andrew's tag.

Thanks,

~ Judith
