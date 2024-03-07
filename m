Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC85C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 04:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928FB87DE2;
	Thu,  7 Mar 2024 05:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lBzRu3DE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC2187DCF; Thu,  7 Mar 2024 05:04:41 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 775A087DA1
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 05:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42744bWW050343;
 Wed, 6 Mar 2024 22:04:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709784277;
 bh=Q/UE2iDRl5m0eEHoxyUAefMKrwW2mxRv5xWmnUl+MKQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=lBzRu3DEr7r0X1xReoN5LxaRtNtogCE7b0Om9TgdARiOXpoUbq1Zn3WYYvYIwAE38
 h/LSWdvV/mzXFXhhiYg0r6qPHgVbhkWnL/5GbhENgJBLCTT9pVec5UtwcH9kwbkoUi
 cJcbOcRCJL9nVJOoiOH2T9pBroEaXLzmrt8iEMRo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42744b5Z008144
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Mar 2024 22:04:37 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 22:04:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 22:04:37 -0600
Received: from [172.24.22.63] (lt5cg1457vgj.dhcp.ti.com [172.24.22.63])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42744Yqp090009;
 Wed, 6 Mar 2024 22:04:35 -0600
Message-ID: <bdd6862b-e902-443b-b410-cd3b45feeddd@ti.com>
Date: Thu, 7 Mar 2024 09:34:34 +0530
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 1/2] arm: mach-k3: am625: copy bootindex to OCRAM for main
 domain SPL
To: Wadim Egorov <w.egorov@phytec.de>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <upstream@lists.phytec.de>, <bb@ti.com>
References: <20240226133006.3279993-1-w.egorov@phytec.de>
 <20240226133006.3279993-2-w.egorov@phytec.de>
 <eeda9c00-d7c6-444b-ba77-f70b2f19eb2a@ti.com>
 <68235312-4121-4ffa-a735-6558fe5a3794@phytec.de>
Content-Language: en-US
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <68235312-4121-4ffa-a735-6558fe5a3794@phytec.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On 3/6/2024 7:14 PM, Wadim Egorov wrote:
> Hi Vignesh,
> 
> Am 04.03.24 um 06:06 schrieb Vignesh Raghavendra:
>> Hi Wadim,
>>
>> On 26/02/24 19:00, Wadim Egorov wrote:
>>> Texas Instruments has begun enabling security settings on the SoCs it
>>> produces to instruct ROM and TIFS to begin protecting the Security
>>> Management Subsystem (SMS) from other binaries we load into the chip by
>>> default.
>>>
>>> One way ROM and TIFS do this is by enabling firewalls to protect the
>>> OCSRAM and HSM RAM regions they're using during bootup.
>>>
>>> The HSM RAM the wakeup SPL is in is firewalled by TIFS to protect
>>> itself from the main domain applications. This means the 'bootindex'
>>> value in HSM RAM, left by ROM to indicate if we're using the primary
>>> or secondary boot-method, must be moved to OCSRAM (that TIFS has open
>>> for us) before we make the jump to the main domain so the main domain's
>>> bootloaders can keep access to this information.
>>>
>>> Based on commit
>>>    b672e8581070 ("arm: mach-k3: copy bootindex to OCRAM for main
>>> domain SPL")
>>>
>> FYI, this is mostly a problem in non SPL flow (TI prosperity SBL for
>> example) where HSM RAM would be used by HSM firmware. This should be a
>> issue in R5 SPL flow.  Do you see any issues today? If so, whats the
>> TIFS firmware being used?
> 
> I remember I was losing the bootindex using ti/downstream u-boot.
> But can't figure out the exact version anymore.
> Just did a bit of testing and I can not see the Issue with the current
> u-boot.
> Boot index in 0x43c3f290 stays intact.
> 
> Would it be okay to drop this patch and keep only the 2nd patch that
> factors out into get_boot_device()?
> 

yeah... 2/2 is still relevant irrespective of this patch.

[...]
