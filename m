Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E252C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C84984027;
	Fri, 11 Apr 2025 16:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FlEQJUyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E03298405F; Fri, 11 Apr 2025 16:06:13 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1641883E72
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BE68Ia1584495
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 09:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744380368;
 bh=NK/BKNRtD6cpMY9AXTJBgn9xJ5mch9GxugD/yzATWOU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=FlEQJUyRdPjVX5Q8f6YbXwKM/hunbsHMGJxn3ZRqbzINPlQBgZukptTcXlHNOuXYJ
 NjG4WYxuCcljKi200CwWZ60wHxeIS/PTgflq0vtHOgQRHDv3rZcHBhLo/PKykb9I4l
 DIvq2o9DIfNdAnl3V2B39EnPNTgB6mFK1xkK0BNM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BE68WA100609
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Apr 2025 09:06:08 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 09:06:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 09:06:07 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BE63Aa026184;
 Fri, 11 Apr 2025 09:06:04 -0500
Message-ID: <2b790ab1-7ddf-4e81-922e-a36aaf1645e2@ti.com>
Date: Fri, 11 Apr 2025 19:36:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] firmware: ti_sci: Scan all device instances when
 releasing exclusive devices
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andrew Davis <afd@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Jonas Wood <jw@ti.com>,
 <praneeth@ti.com>, <u-boot@lists.denx.de>, Dhruva Gole <d-gole@ti.com>,
 <u-kumar1@ti.com>
References: <20250407121554.1010490-1-nm@ti.com>
 <c7aeedc9-3786-4d1f-b68d-22252d9c3197@ti.com>
 <20250411112317.4pzjdotqe4iefdfk@fiscally>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250411112317.4pzjdotqe4iefdfk@fiscally>
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


On 4/11/2025 4:53 PM, Nishanth Menon wrote:
> On 11:04-20250411, Kumar, Udit wrote:
>> Hi Nishanth,
>>
>> Sorry for basic question
>>
>> On 4/7/2025 5:45 PM, Nishanth Menon wrote:
>>> [..] This creates a problem when Device Manager(DM) firmware starts up later
>>> on in the boot process and identifies that this instance of i2c is
>> Do we need to do clean up, where DM is loaded as different binary .
>>
>> As I understand this cleanup is needed, where DM is running along with
>> SPL/R5
>>
>> or I am missing something
> The cleanup makes sense whether we use split or unified DM. The

Its good to do clean up. But IMO, problem you described mainly will be seen

in unified DM case.

> resources R5SPL uses may or may not be used further down the chain of
> software (eeprom was an example where we read and cache the data for
> further downstream steps to use). We should never be leaving a messy
> system behind (and consequences as a result). This is the reason we
> cleanup the exclusively held devices during the boot phase before remote
> cores are started up.
>
> We already do this cleanup. which is good, the trouble with multi-DTB
> FIT image is that the cleanup is partial, which is what this patch
> attempts to solve.


Anyway, patch LTGM irrespective of DM type


Thanks

