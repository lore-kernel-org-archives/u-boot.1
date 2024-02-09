Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8336C4829C
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 09:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D4B787E51;
	Fri,  9 Feb 2024 10:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FhQSd7x3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1453C87E50; Fri,  9 Feb 2024 10:17:45 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B124287E51
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 10:17:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4199HR2d100590;
 Fri, 9 Feb 2024 03:17:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707470247;
 bh=843pL2iGeMArzcsrHL6aXY93XhDx63G//+ksLsW9PNI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=FhQSd7x3vfYP6sD3L0qfRLXOeLAlwalkAwwcslC5xBiGtwIbG0yHfkEOClfyBfgLd
 Hp0sCDNL10nQGvYs/zJf99nOTYW41QpuRqWNkNqFfLNYRdAnDbQ+MUrDf4DmyqtFHv
 p3u/iZLs9LGRXIbb2ExBYxt5u3HXOv+qALCHOtq4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4199HRZT010305
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 9 Feb 2024 03:17:27 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 03:17:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 03:17:26 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4199FwUM124725;
 Fri, 9 Feb 2024 03:17:21 -0600
Message-ID: <bfeffacb-3fc6-42c7-9b17-1b4a1db774d2@ti.com>
Date: Fri, 9 Feb 2024 14:47:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] misc: fs-loader: Use fw_storage_interface instead of
 storage_interface
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Sean Anderson <seanga2@gmail.com>, Qu
 Wenruo <wqu@suse.com>, Michal Simek <michal.simek@amd.com>, Simon Glass
 <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>
References: <20240130062627.2344282-1-danishanwar@ti.com>
 <bcbcf89e-f417-849d-ce2c-bcae8dc772fe@gmail.com>
 <0cf2369d-4d18-4cab-a28b-dc72d42ec136@ti.com>
 <e72baacd-2af7-4e35-9e89-083a580125dc@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <e72baacd-2af7-4e35-9e89-083a580125dc@kernel.org>
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



On 08/02/24 5:28 pm, Roger Quadros wrote:
> 
> 
> On 08/02/2024 07:19, MD Danish Anwar wrote:
>> Hi Sean,
>>
>> On 07/02/24 11:14 pm, Sean Anderson wrote:
>>> On 1/30/24 01:26, MD Danish Anwar wrote:
>>>> The fs-loader driver reads env storage_interface and uses it to load
>>>> firmware file into memory using the medium set by env. Update the driver
>>>> to use env fw_storage_interface as this variable is only used to load
>>>> firmwares. The env storage_interface will act as fallback so that the
>>>> existing implementations do not break.
>>>>
>>>> Also update the FS Loader documentation accordingly.
>>>
>>> So why do you want to do this? I don't see what the point of renaming the
>>> variable is, since you are not e.g. adding any new functionality, and we
>>> have to pay for the rename in code size.
>>>
>>
>> I am upstreaming TI's ICSSG driver for u-boot and during code review
>> Roger Quadros <rogerq@kernel.org> commented asking to rename this
>> variable [1]. I think the motive here was to keep all variables used by
>> fs-loader driver with 'fw_' prefix. All other variables had 'fw_' prefix
>> except for storage_interface.
> 
> Can you please mention this motive in the Commit message?
> 

Sure Roger, I will resend the patch after updating commit message.

>>
>> [1]
>> https://lore.kernel.org/all/4721f3b9-f823-47f3-b4f3-ed40002af31b@kernel.org/
>>
>>> --Sean
>>
> 

-- 
Thanks and Regards,
Danish
