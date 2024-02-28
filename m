Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1B3C54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 09:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2189879F2;
	Wed, 28 Feb 2024 10:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PToPPrf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B6D08804F; Wed, 28 Feb 2024 10:03:00 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46AC587E62
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 10:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41S92jlm080611;
 Wed, 28 Feb 2024 03:02:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709110965;
 bh=TrR9wnQIYYPgK0BIdBBfpxRfZvCapahas0/N6/dzRbE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=PToPPrf907SEdam2WfPmAU5JSX5VfboUggkceER95oBvpINACSW8IqePjkmnLjcPp
 zOVKMcNR4uPBY3ikXFiuHAheFuUfFjcMLSh5dCtKGLc+e/KfkdHd15Gc+vFR7alHGk
 f10GfKD2vyg1Je4g/WaiIs7ek7TnDGxSjSyerKNk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41S92jQW121761
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Feb 2024 03:02:45 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 03:02:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 03:02:44 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41S92ex6100119;
 Wed, 28 Feb 2024 03:02:41 -0600
Message-ID: <2ec93e9f-fbe5-4c9f-83d5-bbc820efff0a@ti.com>
Date: Wed, 28 Feb 2024 14:32:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] misc: fs-loader: Use fw_storage_interface instead of
 storage_interface
Content-Language: en-US
To: Sean Anderson <seanga2@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Roger Quadros <rogerq@kernel.org>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>
References: <20240209100829.1079401-1-danishanwar@ti.com>
 <40bd8620-9fad-4c7b-9f28-4ab8a3e0365a@ti.com>
 <04e7a4b8-a264-5d9c-a0b5-c985d5f35cb8@gmail.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <04e7a4b8-a264-5d9c-a0b5-c985d5f35cb8@gmail.com>
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


On 27/02/24 7:33 pm, Sean Anderson wrote:
> Hi Danish,
> 
> On 2/27/24 05:26, MD Danish Anwar wrote:
>> On 09/02/24 3:38 pm, MD Danish Anwar wrote:
>>> The fs-loader driver reads env storage_interface and uses it to load
>>> firmware file into memory using the medium set by env. Update the driver
>>> to use env fw_storage_interface as this variable is only used to load
>>> firmwares. This is to keep all variables used by fs-loader driver with
>>> 'fw_' prefix. All other variables have 'fw_' prefix except for
>>> storage_interface.
>>>
>>> The env storage_interface will act as fallback so that the
>>> existing implementations do not break.
>>>
>>> Also update the FS Loader documentation accordingly.
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>
>> Hi Tom / Sean, can you please pick this patch if there is no pending
>> comments to address.
>>
> 
> Sorry, I forgot to respond to this earlier.
> 
> To be honest, I'm not really convinced. We have plenty of environmental
> variables which are inconsistent (e.g. ethaddr, eth2addr, eth3addr) and it
> doesn't cause any issues. While fixing code has no cost, the environment
> is an ABI which we can't break. So we'd have to support both of these
> variables forever. I'm not really a fan of doing that without good reason,
> and I think aesthetics of the variable name isn't really compelling.
> 

Roger, should I keep the env variable name as it is and don't rename it?
Sean's concern seems valid, can you please comment here.

> --Sean

-- 
Thanks and Regards,
Danish
