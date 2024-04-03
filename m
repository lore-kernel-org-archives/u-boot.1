Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B366CCD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 05:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35A6587A4B;
	Wed,  3 Apr 2024 07:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="v6xtUIlN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B909881E3; Wed,  3 Apr 2024 07:56:10 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55129879F3
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 07:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4335u3tG051693;
 Wed, 3 Apr 2024 00:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712123763;
 bh=8qBHyLxr6DHyMMcBj7lo0hyE6i266DTdZ1GzKDpszws=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=v6xtUIlN4E55cVQdx/0moX5n7ztvWES+hIleDKyTBahQFeZqjY7GBMDsvxHA4MG3Y
 JzQFZB0iOOXljk6NRaMhQv27XUmcVjmdWzYydLxUohPpTZbDcBPqI5rJ2DHyfbRLGy
 KzKF6zjdq0U7QQlde1v8pmxhayxtHExgfnmx28/s=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4335u38E077801
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 00:56:03 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 00:56:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 00:56:02 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4335tsYk095473;
 Wed, 3 Apr 2024 00:55:55 -0500
Message-ID: <21b78abe-230f-8847-ed3e-d6326cbeac38@ti.com>
Date: Wed, 3 Apr 2024 11:25:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/5] net: ti: icssg: Add icssg queues APIs and macros
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Maxime Ripard <mripard@kernel.org>, Nishanth Menon
 <nm@ti.com>, Roger Quadros <rogerq@kernel.org>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Devarsh Thakkar <devarsht@ti.com>, Aradhya
 Bhatia <a-bhatia1@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240327052841.1692469-1-danishanwar@ti.com>
 <20240327052841.1692469-4-danishanwar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240327052841.1692469-4-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
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



On 3/27/24 10:58 AM, MD Danish Anwar wrote:
> Add icssg_queue.c file. This file introduces macros and APIs related to
> ICSSG queues. These will be used by ICSSG Ethernet driver.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ti/icssg_prueth.h |  5 ++++
>  drivers/net/ti/icssg_queues.c | 51 +++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>  create mode 100644 drivers/net/ti/icssg_queues.c
> 

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi
