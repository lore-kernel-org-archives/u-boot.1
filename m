Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1F5D29FA8
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 07:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 187EE8900E;
	Wed,  6 Nov 2024 08:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kefLyWJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2329789032; Wed,  6 Nov 2024 08:10:50 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDDFD88E43
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 08:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A67Aifx009349;
 Wed, 6 Nov 2024 01:10:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1730877044;
 bh=CHpmBFcnDSKcsfP1/fiNn1CXRqjgug8+Se3W5UVXX7M=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=kefLyWJeAAYrmMbj4eSDkE5dTqmGVZGzwRlRTBYpo2uYjKop/RmjqWuT8DgBYxbly
 v+Qf8kepv9fUIkrgSMR6X8XLbYDZ06BFOEg6X1Vt1OjnDeb9UProaRxr7A1/Rw7mLR
 PkyLu3DwwLbMnh8tCHKbqWaQkkHFjvZRs0chb7zo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A67AioD094387;
 Wed, 6 Nov 2024 01:10:44 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 01:10:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 01:10:43 -0600
Received: from [10.24.68.218] (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com
 [10.24.68.218])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A67AeXH119844;
 Wed, 6 Nov 2024 01:10:41 -0600
Message-ID: <1c23dd2c-f3b6-455e-bb78-123966c559c0@ti.com>
Date: Wed, 6 Nov 2024 12:40:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm: mach-k3: am62p: Add QoS support for DSS
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <bb@ti.com>
CC: <vaishnav.a@ti.com>, <afd@ti.com>, <n-francis@ti.com>, <seanga2@gmail.com>,
 <francesco.dolcini@toradex.com>, <sjg@chromium.org>,
 <w.egorov@phytec.de>, <devarsht@ti.com>
References: <20241106063930.59870-1-j-choudhary@ti.com>
 <20241106063930.59870-3-j-choudhary@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20241106063930.59870-3-j-choudhary@ti.com>
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

Hello All,

On 06/11/24 12:09, Jayesh Choudhary wrote:
> Enable Quality of Service (QoS) blocks for Display SubSystem (DSS), by
> servicing the DSS - DDR traffic from the Real-Time (RT) queue. This is
> done by setting the DSS DMA orderID to greater than 7.
> 
> The C7x and VPAC can overwhelm the DSS's access to the DDR because of

This part here is wrong as AM62P does not have C7x core.
So I will fix the commit message in the next revision appropriately.
Sorry about that!

(I will re-roll after sometime to see if there are any more comments)

> their higher frequency DDR accesses. This can cause flickering in
> display with certain edgeAI models running parallely if the DSS traffic
> is being serviced through non-RT queue.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---



[...]

Thanks,
Jayesh
