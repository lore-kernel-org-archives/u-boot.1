Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D27CD37B4
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 14:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FC5B880A5;
	Wed,  4 Sep 2024 16:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wskoVI7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F11E28876E; Wed,  4 Sep 2024 06:19:28 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A42DA88C7C
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 06:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4844JOI4114669;
 Tue, 3 Sep 2024 23:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725423564;
 bh=S0O8fdebdbPUbmdhRMT3U9Qr9OWN+FHswgaIjLfYSdY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wskoVI7Oja/lRBTFbzZqL3y9gAf77hMx4njuJ7/ZIr6jFdGds2zqBaQSVcrSHZXVA
 RD4nmyqVvIuddukAHOTfPwzebA9CRpDeJ1HRGecCwmkCkU3nBXfFGS6Wo07x1pS8e6
 wZ63yhnuOl2lc6Jze+q6orYkKNqGvlRR9Vqvx1qE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4844JO9w063718
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Sep 2024 23:19:24 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 23:19:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 23:19:23 -0500
Received: from [172.24.23.68] (lt5cd2489kgj.dhcp.ti.com [172.24.23.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4844JJao071177;
 Tue, 3 Sep 2024 23:19:20 -0500
Message-ID: <63af3c3c-2314-45fe-9922-e60a432f711d@ti.com>
Date: Wed, 4 Sep 2024 09:49:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] arm: mach-k3: j784s4: Add clk and power support
 for MAIN_R5_2_x PBIST
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20240903114402.2155740-1-n-francis@ti.com>
 <20240903114402.2155740-2-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240903114402.2155740-2-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 04 Sep 2024 16:09:57 +0200
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


On 9/3/2024 5:13 PM, Neha Malcom Francis wrote:
> Add clock and power domains for MAIN_R5_2_0, MAIN_R5_2_1 and PBIST_14.


Please keep provision for other R core as well, BIST may be needed in 
future on those

>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm/mach-k3/r5/j784s4/clk-data.c | 13 +++++++++++++
>   arch/arm/mach-k3/r5/j784s4/dev-data.c |  7 +++++++
>   2 files changed, 20 insertions(+)
> [..]
