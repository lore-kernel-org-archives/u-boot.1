Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8EAC48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 05:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18CD387D92;
	Thu,  8 Feb 2024 06:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qfy4pWAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08A4787DBB; Thu,  8 Feb 2024 06:19:46 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A8C87D3B
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 06:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4185JY2Y050977;
 Wed, 7 Feb 2024 23:19:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707369574;
 bh=6cPj5eRoVwIq85RcIiz5SDKc206xwMllP3WkwQUo6mQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=qfy4pWAoFIynLgHPz5ZsrcZh4oNowWSi3kdFkPM+Wocy5VYniuUEqhf1iVAW4hmW3
 FqwbVX8rytP0+BksJWLs7QDDCGBDzFBympVVYacUPhOv1tm/nY2356vCxGYCxTkezx
 Jekx4gSi4uWNkSfdvZYGII98Wm51ofFYxzYTXu6s=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4185JYwC072686
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 Feb 2024 23:19:34 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 23:19:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 23:19:33 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4185JTd2002788;
 Wed, 7 Feb 2024 23:19:30 -0600
Message-ID: <0cf2369d-4d18-4cab-a28b-dc72d42ec136@ti.com>
Date: Thu, 8 Feb 2024 10:49:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] misc: fs-loader: Use fw_storage_interface instead of
 storage_interface
Content-Language: en-US
To: Sean Anderson <seanga2@gmail.com>, Qu Wenruo <wqu@suse.com>, Michal Simek
 <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, Stefan Roese
 <sr@denx.de>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
 Roger Quadros <rogerq@kernel.org>
References: <20240130062627.2344282-1-danishanwar@ti.com>
 <bcbcf89e-f417-849d-ce2c-bcae8dc772fe@gmail.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <bcbcf89e-f417-849d-ce2c-bcae8dc772fe@gmail.com>
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

Hi Sean,

On 07/02/24 11:14 pm, Sean Anderson wrote:
> On 1/30/24 01:26, MD Danish Anwar wrote:
>> The fs-loader driver reads env storage_interface and uses it to load
>> firmware file into memory using the medium set by env. Update the driver
>> to use env fw_storage_interface as this variable is only used to load
>> firmwares. The env storage_interface will act as fallback so that the
>> existing implementations do not break.
>>
>> Also update the FS Loader documentation accordingly.
> 
> So why do you want to do this? I don't see what the point of renaming the
> variable is, since you are not e.g. adding any new functionality, and we
> have to pay for the rename in code size.
> 

I am upstreaming TI's ICSSG driver for u-boot and during code review
Roger Quadros <rogerq@kernel.org> commented asking to rename this
variable [1]. I think the motive here was to keep all variables used by
fs-loader driver with 'fw_' prefix. All other variables had 'fw_' prefix
except for storage_interface.

[1]
https://lore.kernel.org/all/4721f3b9-f823-47f3-b4f3-ed40002af31b@kernel.org/

> --Sean

-- 
Thanks and Regards,
Danish
