Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C28E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 21:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E38A803A9;
	Fri, 20 Dec 2024 22:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K4/Riz0I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C6A803B5; Fri, 20 Dec 2024 22:42:32 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CFA680079
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 22:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BKLgRaE518538
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 20 Dec 2024 15:42:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734730947;
 bh=WzFa+Ra/vlUyLgxl5BQlLhze15ez48JxfHvKd/acjWA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=K4/Riz0IJg09X5eBaiA3t8Lu/L5dfkN+dvsF5GxdPIq/YGOyzUb/PHWyjwS0sKQa+
 y3+gcQ5T1Y8feDzXw9nZ4wMhXlNNjk7n34SOxE1KiVuu5pAqyO9d7lpj3n2AA4C+AP
 1AJEiApvb1Zs60nmog7dUEEm9ygMstWdK9jJ4K10=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BKLgRKN088918;
 Fri, 20 Dec 2024 15:42:27 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 15:42:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 15:42:27 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BKLgRNU042897;
 Fri, 20 Dec 2024 15:42:27 -0600
Message-ID: <ae018edb-7f79-4b28-a0f4-6c1da369e64e@ti.com>
Date: Fri, 20 Dec 2024 15:42:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/7] Enable MMC UHS modes
To: Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
References: <20241220203704.2076499-1-jm@ti.com>
 <20241220203855.GL1505244@bill-the-cat>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20241220203855.GL1505244@bill-the-cat>
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

On 12/20/24 2:38 PM, Tom Rini wrote:
> On Fri, Dec 20, 2024 at 02:36:57PM -0600, Judith Mendez wrote:
> 
>> This patch series adds config options for Sitara K3 boards
>> to support MMC UHS modes.
>>
>> While testing with SD card boot and eMMC boot,
>> found missing eMMC boot support for am62ax in am62a7_init,
>> patch 1/7, and missing config option to support eMMC boot.
>>
>> While we are here, for am62ax, enable config option to
>> change MMC bus modes and enable r5 SDHCI ADMA for faster boot
>> time.
>>
>> Also for all k3 Sitara boards, cleanup MMC ENV configs that
>> are no longer needed since we no longer load env from MMC
>> device.
>>
>> Changes since v1:
>> - rebase against next
> 
> Normally this would be "v2" and not "RESEND", but I really don't think
> we need v3 just to correct that :) I'll pick this up in due time,
> assuming no changes requested by others.

Understood, thanks for the feedback (:

~ Judith

