Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85962CCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 04:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E58B283B22;
	Thu,  6 Nov 2025 05:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HDtzQ196";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED6A583B24; Thu,  6 Nov 2025 05:03:26 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1EE83B0E
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 05:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5A643F172530301;
 Wed, 5 Nov 2025 22:03:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1762401795;
 bh=8KKXvqs70iIaTx2mDDTaPABOnxj22VLl1BrLW6fC3yw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=HDtzQ196UtbIfGJWJBtkFF+0OZ4Ivn+BfQ5udeNjC/eUounzuA4MFp2dgSkJlXz1Z
 7ec3JXV+oZaXVr9eGVCek82v0NiB/0r+MyOwS/5AvVUsqPsHRcreylEB7UCQcj8T8G
 BoauyensGlV8BZ2ns/b2nhJaqRf3BDQTP3g7ESj0=
Received: from DFLE213.ent.ti.com (dfle213.ent.ti.com [10.64.6.71])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5A643FOj3016825
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Nov 2025 22:03:15 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 22:03:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 22:03:15 -0600
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A643A7U615339;
 Wed, 5 Nov 2025 22:03:10 -0600
Message-ID: <8a2830fd-ac05-4172-acfc-704a103d68b8@ti.com>
Date: Thu, 6 Nov 2025 09:33:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 1/2] drivers: video: tidss: Refactor tidss_drv
To: Tom Rini <trini@konsulko.com>
CC: <devarsht@ti.com>, <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <jd@denx.de>, <tl@denx.de>,
 <agust@denx.de>, <vigneshr@ti.com>, <praneeth@ti.com>,
 <h-shenoy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
References: <20251105163040.4086273-1-s-jain1@ti.com>
 <20251105163040.4086273-2-s-jain1@ti.com>
 <20251105164114.GQ6688@bill-the-cat>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20251105164114.GQ6688@bill-the-cat>
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

On 11/5/25 22:11, Tom Rini wrote:
> On Wed, Nov 05, 2025 at 10:00:39PM +0530, Swamil Jain wrote:
> 
>> - Refactor tidss_drv to improve modularity, enabling support for more
>>    display interfaces beyond OLDI in the future
>> - Add detection and initialization of active OLDI panels using the DT
>> - Port tidss_oldi.c from the upstream Linux kernel oldi series[0] and
>>    derive several APIs from it to determine the dual link pixel order
>> - Add tidss_oldi_init() and helper routines to handle OLDI-specific
>>    setup and move related helper routines to tidss_oldi.c
>>
>> [0]: https://lore.kernel.org/all/20250528122544.817829-1-aradhya.bhatia@linux.dev/
>>
>> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
>> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>> ---
>>   drivers/video/tidss/Makefile     |   2 +-
>>   drivers/video/tidss/tidss_drv.c  | 235 +++++++++++++-------
>>   drivers/video/tidss/tidss_drv.h  |  40 ++--
>>   drivers/video/tidss/tidss_oldi.c | 364 +++++++++++++++++++++++++++++++
>>   drivers/video/tidss/tidss_oldi.h |  72 ++++++
>>   drivers/video/tidss/tidss_regs.h |  21 --
>>   6 files changed, 612 insertions(+), 122 deletions(-)
>>   create mode 100644 drivers/video/tidss/tidss_oldi.c
>>   create mode 100644 drivers/video/tidss/tidss_oldi.h
> 
> You didn't include my feedback about making sure this either builds on
> sandbox or updates the Kconfig to have appropriate dependencies.


 From our previous conversation, I wasn't able to get the exact point.
Thanks for elaborating the issue.


  I
> checked the build failure more, and we fail to build this on sandbox
> (and so allyesconfig) because <asm/utils.h> doesn't exist on sandbox,
> but also isn't needed here. It really is only needed in two files
> because it only defines what should be generic math header functions.
> So, here's my request. In a follow up patch, please do either of:
> - Remove <asm/utils.h> from everything that doesn't call
>    log_2_n_round_{up,down}.
> - Remove arch/arm/include/asm/utils.h and replace the calls of
>    log_2_n_round_(up,down} with what must be the common linux kernel
>    equivalent that's been added in the last 15 years.
> 
> Thanks.
> 

Thanks, will do the required changes and re-spin the series.

Regards,
Swamil

