Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ECCC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52C7D87DF4;
	Thu, 15 Feb 2024 21:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vTdbk0Nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC58287CC1; Thu, 15 Feb 2024 21:45:12 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F68087DF4
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FKitIK116387;
 Thu, 15 Feb 2024 14:44:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708029895;
 bh=QixPg31xUNdHfJr6bEZQ31/i2cQ5We9LCmohTFk7Dn0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=vTdbk0NhNg2tKyneuct6PZM1A/G74cGkFJ5mgUdlnWgTYNUDd14FKcTL5+Dxzf9eE
 SV9UvXqxBMpHD0k+IGEKNw1/IHI1jqL6+5KhHJlqE183xA6IlJD/NaSuGTOks+8kSR
 JmgCVeccsh1wYBGPv+28Wc5+p7DQ+LCyr7kyTRx8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FKitY9124044
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Feb 2024 14:44:55 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 14:44:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 14:44:54 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FKisWY068378;
 Thu, 15 Feb 2024 14:44:54 -0600
Message-ID: <f33849db-b2f3-42a0-b87a-37f838c2b601@ti.com>
Date: Thu, 15 Feb 2024 14:44:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm: mach-k3: Move DRAM address of ATF for AM62/AM62a
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-7-afd@ti.com> <20240215080653.GA5107@francesco-nb>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240215080653.GA5107@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 2/15/24 2:06 AM, Francesco Dolcini wrote:
> Hello Andrew,
> thanks for this series.
> 
> On Wed, Feb 14, 2024 at 10:30:09AM -0600, Andrew Davis wrote:
>> The current address of TF-A in DRAM is just below the 512MB address line.
>> This means if the DRAM in a system is 512MB then TF-A is right at the
>> end of memory which is often reused, for instance U-Boot relocates itself
>> here. If a system has less than 512MB then that system wouldn't work at
>> all as TF-A would fail to load.
> 
> Do you expect issue with system with exactly 512MB of RAM? We have such
> a board available and this is something that was not on our radar.

The issues with exactly 512MB are much less than the systems with less.
Mostly small software issues like the one you work around below with
U-Boot relocation.

> 
> The way we handle this is with `verdin-am62.c:board_get_usable_ram_top()`
> 

The point of this patch is to avoid the need for workarounds like that in
the first place.

> There is also some other reserved memory just before the 512MB limit,
> not just the TF-A.

This series prepares for also moving OP-TEE at some point (which will be
a bit more involved as it still needs to be made position independent).
The other reserved memory is mostly for remoteproc firmware which should
be made dynamic instead of hard-coding memory carve-outs for their use.

Andrew

> 
> Francesco
> 
