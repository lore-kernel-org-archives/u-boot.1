Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A551FC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 07:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A3F780562;
	Wed,  5 Feb 2025 08:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wyECg2sG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F94805D7; Wed,  5 Feb 2025 08:43:40 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0F4580207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 08:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5157hZtd3312425
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 5 Feb 2025 01:43:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738741415;
 bh=HZi/TbFY99ToY1hj32N9axoyllX+LTiBbx0yjKNxUvM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wyECg2sGD6d0QebOnusNBMRCSNMepZXfybFTrjeCqIEaaLCgf6gJygSSJCIrIEsTJ
 y7tUtj5OfgnCe1iKcwf6dyJ10Hvsz95lB4etxBb3I1ZbX2j5KZjO8u8fMww765sA9u
 h9i5+qiXaUV5OmWUatXZWRnUdfd3c6P+0K9MpzU4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5157hZvj115401;
 Wed, 5 Feb 2025 01:43:35 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Feb 2025 01:43:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Feb 2025 01:43:35 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5157hVhf043125;
 Wed, 5 Feb 2025 01:43:31 -0600
Message-ID: <47e8441a-0843-4ff0-906e-524cadd4227b@ti.com>
Date: Wed, 5 Feb 2025 13:13:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drivers: misc: k3_bist: Add K3 BIST driver
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>
References: <20250204123147.939917-1-n-francis@ti.com>
 <20250204123147.939917-2-n-francis@ti.com>
 <c244f4af-20a9-4b52-841b-ed6435e25540@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <c244f4af-20a9-4b52-841b-ed6435e25540@ti.com>
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

On 04/02/25 19:38, Kumar, Udit wrote:
> 
> On 2/4/2025 6:01 PM, Neha Malcom Francis wrote:
>> Add a driver for the BIST module that support triggering of both PBIST
>> (Memory BIST) and LBIST (Logic BIST) tests. Also expose the relevant
>> operations and functions that would be required for an end user to
>> trigger the tests.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---

[...]

> Rest LGTM
> 
> 

Thanks for the review comments, will address them in v3.

-- 
Thanking You
Neha Malcom Francis
