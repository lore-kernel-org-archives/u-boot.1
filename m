Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC16C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED3C387947;
	Fri, 12 Jan 2024 13:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="r41tedfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00EB2879E8; Fri, 12 Jan 2024 13:38:33 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC30C8760D
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CCcRQd123512;
 Fri, 12 Jan 2024 06:38:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705063107;
 bh=BN4geqQy4oCzwzYBkBj6v1guwu8qjcTREdYYKxEY1i0=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=r41tedfWfLp7z5vS+54fRfdTxXprtSojIcBcbLZXluoiCrTY7RtTGJNcfFZernE0d
 LGzK+d7XOPyURIK+2A3oTJVKob4c13MgM6k5ayIZ5V8n1reBCMQ+e6w5WoI9QbpRXH
 5OkLhR11WzvjJgHO0UKl0kqhuOSCg9R3evcRmFXw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CCcRsC005292
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 06:38:27 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 06:38:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 06:38:27 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CCcO1K036207;
 Fri, 12 Jan 2024 06:38:25 -0600
Message-ID: <0d8eceee-c76c-42cc-8a37-4bf3af054d3d@ti.com>
Date: Fri, 12 Jan 2024 18:08:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <trini@konsulko.com>, <sjg@chromium.org>, <afd@ti.com>, <vigneshr@ti.com>, 
 <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: Re: [PATCH 08/10] configs: am62: Add configs for enabling ETHBOOT in
 R5SPL
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-9-s-vadapalli@ti.com>
 <20240112123143.f5dqqfyphbcgnxju@recapture>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240112123143.f5dqqfyphbcgnxju@recapture>
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



On 12/01/24 18:01, Nishanth Menon wrote:
> On 12:17-20240112, Siddharth Vadapalli wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Add configs for enabling ETHBOOT in R5SPL. Adding a separate config
>> minimizes the risk of going past the R5-SPL size limit for any future
>> config additions.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>  configs/am62x_evm_r5_ethboot_defconfig | 110 +++++++++++++++++++++++++
> 
> NAK. use config fragments please.

Ok.

-- 
Regards,
Siddharth.
