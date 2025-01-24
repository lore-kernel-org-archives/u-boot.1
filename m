Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC17C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 03:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44DE480780;
	Fri, 24 Jan 2025 04:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qMaW8yLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6671807B4; Fri, 24 Jan 2025 04:52:30 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C4E8076E
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 04:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50O3qLpX1288569
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jan 2025 21:52:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737690741;
 bh=ngZ6JDzUv1y8XZscKIWinKhf8Wuo+giJN1cdvx6Bsf4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=qMaW8yLzciGPhjAlPA+CTND4rrE8Ekedxc5TattYZBZpiuB1Sfl6MlBx3nEFSV07p
 KQ2gMvtcmnf+MTHyR5IXNSXcZcKJw/cwRXsU7EjDz/nAQrG/6SieksEHtB5mVj/REi
 EGB/4EAAbp6rH3SNcHrCg/DXPX1fvs/XNvlDRod0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50O3qLvi016582
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Jan 2025 21:52:21 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Jan 2025 21:52:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Jan 2025 21:52:21 -0600
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50O3qGET104417;
 Thu, 23 Jan 2025 21:52:17 -0600
Message-ID: <cfd07651-98be-46c4-a273-392a8903277c@ti.com>
Date: Fri, 24 Jan 2025 09:22:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] arm: mach-k3: j721s2_init: Probe AM65 CPSW NUSS for
 R5/A72 SPL
To: Roger Quadros <rogerq@kernel.org>, Chintan Vankar <c-vankar@ti.com>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Nishanth Menon <nm@ti.com>, Simon
 Glass <sjg@chromium.org>, Neha Malcom Francis <n-francis@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>,
 Tom Rini <trini@konsulko.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <srk@ti.com>, <danishanwar@ti.com>, <u-boot@lists.denx.de>
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-5-c-vankar@ti.com>
 <d2c8cde1-891f-470a-abd9-598847a9078f@kernel.org>
 <73bcc845-d35b-4f3a-9529-41310cfe5707@ti.com>
 <8bf7f805-a7d5-4324-b939-319b5d12ba6d@kernel.org>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <8bf7f805-a7d5-4324-b939-319b5d12ba6d@kernel.org>
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



On 23/01/25 15:10, Roger Quadros wrote:
>> Hello Roger,
>>
>> The driver is defined as UCLASS_MISC which should be probed explicitly,
> The driver was originally built without UCLASS_MISC, but
> 
> commit 38922b1f4acc ("net: ti: am65-cpsw: Add support for multi port independent MAC mode")
> 
> Added UCLASS_MISC and states there that 
> " Since top level driver is now UCLASS_MISC, board files would need to
>   instantiate this driver explicitly."
> 
> Not an elegant solution. So we need to fix something in the am65-cpuss driver.
> 
> Looking at drivers/net/mvpp2.c we can see a possible solution.
> 1) don't define .probe for the parent driver (UCLASS_MISC). Instead define .bind
> that will scan the device tree for ports and bind the port device and driver.
> e.g. see mvpp2_base_bind()
> 2) in port driver .probe (UCLASS_ETH), if parent has not been probed
> then call the parent probe (am65_cpsw_probe_nuss) . Also set a flag so parent probe
> only gets called once.
> 3) update all board files no not explicitly probe the am65-cpsw UCLASS_MISC driver.
> 
> Siddharth / Vignesh do you see any issues with this solution?

I like this idea. It may need bit more than moving probe to bind as
there are some reg accesses which shouldn't ideally be done at bind
phase. But should be feasible to drop them.

-- 
Regards
Vignesh
https://ti.com/opensource

