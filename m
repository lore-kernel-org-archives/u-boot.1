Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A553CC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 14:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 152AE88321;
	Thu,  2 May 2024 16:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IjgvWW7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 877D488323; Thu,  2 May 2024 16:18:00 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 059E28830F
 for <U-Boot@lists.denx.de>; Thu,  2 May 2024 16:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 442EHha8033909;
 Thu, 2 May 2024 09:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714659463;
 bh=TkbLQasRpBjVRO6nq2LGn/+cMZ7FUWgEEWf14RIO3Nw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=IjgvWW7hPui5DZyUR/bUY5Cchc60ByjafLaOFZMi9+dHGuHjvWMHOl6o9Jw/mTuHE
 2dQkdTawLuvo8RYO1Ud8oxUvl7xTWrr94I0zQqWjCSBnNG1gU+qZNpToOpb+kQnav/
 KGi9S2pAfjd7lKHOcpb0AB8ToW6P4exISrmxItk4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 442EHhxf094952
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 May 2024 09:17:43 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 May 2024 09:17:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 May 2024 09:17:43 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 442EHh8b007178;
 Thu, 2 May 2024 09:17:43 -0500
Message-ID: <55bd217a-07ee-4eb4-a9d6-ff810be8bd21@ti.com>
Date: Thu, 2 May 2024 09:17:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Please pull u-boot-mmc master
To: Greg Malysa <greg.malysa@timesys.com>, Francesco Dolcini
 <francesco@dolcini.it>
CC: Jae hoon Chung <jh80.chung@gmail.com>, Ian Roberts
 <ian.roberts@timesys.com>, Tom Rini <trini@konsulko.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, U-Boot Mailing List <U-Boot@lists.denx.de>,
 <maximilian.brune@9elements.com>, <curtis.machida@intel.com>, Jonas Karlman
 <jonas@kwiboo.se>, "ian.roberts@timesys.com Peng Fan" <peng.fan@nxp.com>,
 <sheng.tan@9elements.com>
References: <CGME20240426103830epcas1p3720a09dd50c8ef3d16de0a6ff2ff514b@epcas1p3.samsung.com>
 <e6c74bd0-de66-42ef-a6af-0d5c058b12a0@samsung.com>
 <20240426155154.GK1054907@bill-the-cat>
 <33db14f4-f3f0-4e5f-a256-2ce9b5c505fd@ti.com>
 <20240430074221.GA10438@francesco-nb>
 <CAAjXUaqCWHVmqHT7iMoHOir5PH1E6fhOFoZHBLJ4obdW6bHw4Q@mail.gmail.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <CAAjXUaqCWHVmqHT7iMoHOir5PH1E6fhOFoZHBLJ4obdW6bHw4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Greg,

On 5/1/24 9:40 PM, Greg Malysa wrote:
> On Tue, Apr 30, 2024 at 3:42 AM Francesco Dolcini <francesco@dolcini.it> wrote:
>>
>> On Mon, Apr 29, 2024 at 03:39:53PM -0500, Judith Mendez wrote:
>>> A patch in this series caused a regression for AM62x SK with the
>>> following error:
>>
>> +1, this affects also Verdin AM62.
> 
> Hi, please try https://patchwork.ozlabs.org/project/uboot/patch/20240501185331.1189647-1-alexander.sverdlin@siemens.com/
> as this should explain the issue and also fix it.

The fix fixes my issuu on AM62x, thanks.

~ Judith
