Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFF2C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 09:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2263B88096;
	Tue, 21 May 2024 11:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MY3amWd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96DB7880A1; Tue, 21 May 2024 11:02:03 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C5BA87F65
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 11:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44L91mRG067216;
 Tue, 21 May 2024 04:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716282108;
 bh=3dH5gvOdN+F+tKkOw8BgvikpoESNb630/0sVvj0cAuw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=MY3amWd76lEz0M0v990xT7oFbK3cjWM0BCZQUFYQYWRBDIhLU/s+BGQNNYP2omoq7
 S/4ao9Vq7RE9Q4ni0ZkBvU1b8h+0ALMSV7XvafOoTzWd+tlhqXutj2i5qIIvaDjRKf
 nZOsbSJTSl+fQL0d1d9mFFmO/Wof+azYH5kQrFcs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44L91meM084989
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 21 May 2024 04:01:48 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 04:01:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 04:01:48 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44L91j2b129156;
 Tue, 21 May 2024 04:01:46 -0500
Message-ID: <26c9c7f5-1544-46b2-a3fd-3a4d01c2d813@ti.com>
Date: Tue, 21 May 2024 14:31:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add AM64x Support to PRUSS and PRU_RPROC driver
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
 Roger Quadros <rogerq@kernel.org>
References: <20240430104633.1445311-1-danishanwar@ti.com>
 <171536955294.3410219.3302090701043655645.b4-ty@konsulko.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <171536955294.3410219.3302090701043655645.b4-ty@konsulko.com>
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

Hi Tom,

On 11/05/24 1:02 am, Tom Rini wrote:
> On Tue, 30 Apr 2024 16:16:31 +0530, MD Danish Anwar wrote:
> 
>> This series adds AM64x related compatibles to PRUSS and PRU_RPROC drivers.
>> This series is a prerequisite for ICSSG Ethernet driver.
>>
>> Once Support for AM64x is added to PRUSS and PRU_RPROC driver, I'll send
>> another series to enable ICSSG Ethernet driver for AM64x as well.
>>
>> MD Danish Anwar (2):
>>   remoteproc: pru: Add support for AM64x PRU / RTU cores
>>   soc: ti: pruss: Add support for AM64x
>>
>> [...]
> 
> Applied to u-boot/next, thanks!
> 

I was working on the latest u-boot/next (d4781422d1 (origin/next) "Merge
tag 'v2024.07-rc3' into next") and I don't see this series being part of
u-boot/next.

I checked the git logs, you had merged this series but on 18th may you
committed [1] ("Revert "Merge patch series "arm: dts: am62-beagleplay:
Fix Beagleplay Ethernet""") which reverts bunch of changes and as part
of this commit, this series was also reverted.

Now when I am trying to verify ICSSG, it doesn't work as this series is
not part of u-boot/next anymore.

Can you please pull / merge this series again to u-boot/next? Or do I
need to send these patches for merge again?

Please let me know.

[1]
https://source.denx.de/u-boot/u-boot/-/commit/d678a59d2d719da9e807495b4b021501f2836ca5


-- 
Thanks and Regards,
Danish
