Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6E7C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 06:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC16E8091A;
	Thu,  5 Jun 2025 08:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Mj6LdhVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3F3B81E25; Thu,  5 Jun 2025 08:25:11 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B73768003E
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 08:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5556P70c4006141;
 Thu, 5 Jun 2025 01:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749104707;
 bh=yZGeOAXzznQz/fNS9QrGr/oPyUd5EbQlEDpLsoqrFoI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Mj6LdhVztohBMQEF2bqfngGuY7cOlRC8BfDQpsZlPogpnEG63vttcqssJhY4dKbfi
 qHD/5YtjsEyg3RcvAU3a07sSc40/306kOC4xHSzi+csmjL2sOkHcL1lsm+rTcRK5k8
 9SW8wAo2RZa1Vl2SUayM4S4/FtOzv4u2nYjiugA0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5556P70W616846
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 5 Jun 2025 01:25:07 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Jun 2025 01:25:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Jun 2025 01:25:06 -0500
Received: from [172.24.227.136] (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5556P3JR3255764;
 Thu, 5 Jun 2025 01:25:04 -0500
Message-ID: <8a1baa4f-8d0d-42ec-ab14-6f2b50c9a508@ti.com>
Date: Thu, 5 Jun 2025 11:55:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm: mach-k3: Print version of DM firmware during
 boot process
To: Bryan Brattlof <bb@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <d-gole@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20250528080519.677750-1-m-shah@ti.com>
 <20250528080519.677750-7-m-shah@ti.com>
 <20250603133334.yr5lpzd65gukiegu@bryanbrattlof.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20250603133334.yr5lpzd65gukiegu@bryanbrattlof.com>
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

Hey Bryan,

On 03/06/25 19:03, Bryan Brattlof wrote:
> On May 28, 2025 thus sayeth Moteen Shah:
>> Print DM firmware's version in the boot up process of K3 devices.
>>
>> Signed-off-by: Moteen Shah <m-shah@ti.com>
>> ---
>>   arch/arm/mach-k3/am62ax/am62a7_init.c | 4 ++++
>>   arch/arm/mach-k3/am62px/am62p5_init.c | 4 ++++
>>   arch/arm/mach-k3/am62x/am625_init.c   | 4 ++++
>>   arch/arm/mach-k3/am64x/am642_init.c   | 4 ++++
>>   arch/arm/mach-k3/am65x/am654_init.c   | 4 ++++
> The AM64 and AM65 use DMSC firmware. Can they ever have a different DM
> version than what is reported by the SYSFW call?

No actually. So the way patch series is designed, for platforms like 
AM64 and AM65 having no DM capability, we don't print anything, 
essentially the changes this series makes in am64 and am65 init files 
are redundant and can be removed. I will remove the mentioned platforms 
in the revision.

Thanks for the review.

Regards,
Moteen

>
>>   arch/arm/mach-k3/j721e/j721e_init.c   | 4 ++++
>>   arch/arm/mach-k3/j721s2/j721s2_init.c | 4 ++++
>>   arch/arm/mach-k3/j722s/j722s_init.c   | 4 ++++
>>   arch/arm/mach-k3/j784s4/j784s4_init.c | 4 ++++
> ~Bryan
