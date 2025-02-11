Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9F1C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 15:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6253B80842;
	Tue, 11 Feb 2025 16:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TW+U0QyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B246180A55; Tue, 11 Feb 2025 16:52:13 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBDA4806FE
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 16:52:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51BFq8kX263365
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2025 09:52:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739289128;
 bh=On4Wbxp5BZlnWmDHvknLgTIP2PCmfBwmAVLeyUz+oFo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TW+U0QySQWQp8FKvj7olen5iMMI/jH5j82/UCitbFCPPTtQe2S4IX4yWqwzAEMFpg
 W+r1Ns6xbCMDe15MOuuMHi7pUNWxil8l31WtBdUcuubFj0F9fDwZ4OAjJtEC+ATjuB
 KeNqFz/KDxEUdenF5PLlYxT3uDBqJ0R2V80q/uBU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51BFq861129772
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Feb 2025 09:52:08 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Feb 2025 09:52:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Feb 2025 09:52:07 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51BFq7iR111143;
 Tue, 11 Feb 2025 09:52:07 -0600
Message-ID: <0ba5593c-8141-4955-9849-36de2905ec5c@ti.com>
Date: Tue, 11 Feb 2025 09:52:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] Introduce K3 remoteproc driver for M4 subsystem
To: Tom Rini <trini@konsulko.com>
CC: Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi
 <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
References: <20250210202944.1071931-1-jm@ti.com>
 <af33ccc9-de0d-479b-9890-2c9c7f2996bb@ti.com>
 <20250210233607.GV1233568@bill-the-cat>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250210233607.GV1233568@bill-the-cat>
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

On 2/10/25 5:36 PM, Tom Rini wrote:
> On Mon, Feb 10, 2025 at 04:43:31PM -0600, Judith Mendez wrote:
>> Hi Tom,
>>
>> On 2/10/25 2:29 PM, Judith Mendez wrote:
>>> Some K3 devices like am62x and am64x have a M4 processor in the MCU
>>> voltage domain. This patch series introduces remoteproc M4 driver which
>>> will be used to load firmware into and start the M4 remote core.
>>>
>>> This series also adds support for R5F cores on am64x SoCs in patch 2 and
>>> sets up environment to load FW in remote cores in patch 3,4,5.
>>>
>>> This patch series also enables remoteproc drivers by default as per what
>>> remoteproc sybsystem is supported per SoC, thus all remoteproc options
>>> are now deleted in configs/* since they are no longer required.
>>>
>>> This patch series was tested on am64x EVM, am62x SK, am62ax SK,
>>> am62px SK boards.
>>>
>>> Any additional tested by's are welcome since I was not able to
>>> test any additional boards.
>>>
>>> Tested by running the following commands in u-boot prompt:
>>>
>>> => setenv dorprocboot 1
>>> => run boot_rprocs
>>>
>>> Links:
>>> v4: https://lore.kernel.org/u-boot/20250206015406.2702944-1-jm@ti.com/
>>> v3: https://lore.kernel.org/u-boot/20250130223256.1944522-1-jm@ti.com/
>>> v2: https://lore.kernel.org/u-boot/20250129225233.467139-1-jm@ti.com/
>>> v1: https://lore.kernel.org/u-boot/20250123010759.810799-1-jm@ti.com/
>>>
>>
>>
>> Forgot to add Andrew's Reviewed-by, apologies. If this series version
>> is picked up, could the tag be added? If not please let me know so I can
>> re-spin with Andrew's tag.
> 
> b4 should grab them, thanks.
> 
Great thanks!

~ Judith
