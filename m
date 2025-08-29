Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732F1C8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 08:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B18D08354B;
	Fri, 29 Aug 2025 10:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FpEqTk2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EFA98359F; Fri, 29 Aug 2025 10:12:34 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F17388352B
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 10:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T8CU3M2200928;
 Fri, 29 Aug 2025 03:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756455150;
 bh=PBXq3jjykdKW5s3ayaLynPItflIF75kUdcFPHPr592Y=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=FpEqTk2uMqNrQ9h6vyIGa+wL+R5xVQwO131xfkrI+KoeQjCMB93po2vCbDknV8HaE
 xfoOb/lUNEyMj9w3Z6UA7InOYHpb2jVKJrwnytQN4Fm7n4qSTbjl3eryhwVITCgh92
 +Hr9pvsACSqy4XxwcGbvm82MZIxuKS2rjWZYKOEc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T8CUEm3870395
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 29 Aug 2025 03:12:30 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 03:12:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 03:12:29 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T8CQaT1753488;
 Fri, 29 Aug 2025 03:12:27 -0500
Message-ID: <94253c4e-185c-4ac1-9f76-711fe9a09952@ti.com>
Date: Fri, 29 Aug 2025 13:42:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: increase max resasg_entries
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 Jared McArthur <j-mcarthur@ti.com>, <u-kumar1@ti.com>
References: <20250823080615.1899597-1-u-kumar1@ti.com>
 <20250828173137.GQ124814@bill-the-cat>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250828173137.GQ124814@bill-the-cat>
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

On 8/28/2025 11:01 PM, Tom Rini wrote:
> On Sat, Aug 23, 2025 at 01:36:15PM +0530, Udit Kumar wrote:
>
>> Increase max resasg_entries to accommodate max size of
>> largest device J784S4[0].
>>
>> [0]: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j784s4/resasg_types.html
>>
>> Reported-by: Jared McArthur <j-mcarthur@ti.com>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> Is this for v2025.10 or v2026.01? Thanks.

v2026.01 should be ok for this

>
