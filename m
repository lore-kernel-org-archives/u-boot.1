Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66761CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 17:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC45831A4;
	Tue,  9 Sep 2025 19:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZIJAJW11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 059B1831BE; Tue,  9 Sep 2025 19:08:23 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 718BD8313B
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 19:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589H8Dkk333694;
 Tue, 9 Sep 2025 12:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757437693;
 bh=owrcZlXawSaL+1n8OnUXqLHep9fGH/TJKwth+UhnzKM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZIJAJW11BmepBYXw0SxFzG67L8BB3tOY1ZjOixQJpJbgxGTlTVYbXRjpcILzSZpyF
 5Rr736uOSodE2hQKq6kzpn9UVq/GfRwTwyR/RZ+DRAXvRaKdXW0T9YnnyHkj6+w1gb
 pG0lTCvfhY20fOgLHO11z9Ztx7dUzFWuGxV07Ryo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589H8DL93932667
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 9 Sep 2025 12:08:13 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 12:08:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 12:08:13 -0500
Received: from [10.249.142.58] ([10.249.142.58])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589H8AWe2683406;
 Tue, 9 Sep 2025 12:08:11 -0500
Message-ID: <0efa621a-6cc5-4c1b-a5c9-9ab86f84692f@ti.com>
Date: Tue, 9 Sep 2025 22:38:09 +0530
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] mtd: spi-nor: winbond: Make sure w25q{01,02}jv behave
 correctly
To: Jagan Teki <jagan@amarulasolutions.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Steam Lin <stlin2@winbond.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
References: <20250702092313.970234-1-miquel.raynal@bootlin.com>
 <87a534exwc.fsf@bootlin.com>
 <CAMty3ZDG=MtRbzNPaRs=dz9AUkcTA5cHX+0=wgqyEbMqPhyxrQ@mail.gmail.com>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <CAMty3ZDG=MtRbzNPaRs=dz9AUkcTA5cHX+0=wgqyEbMqPhyxrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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



On 9/9/2025 5:37 PM, Jagan Teki wrote:
> On Tue, Sep 9, 2025 at 3:43 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>>
>> Hello,
>>
>> On 02/07/2025 at 11:23:13 +02, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>>
>>> These chips are internally made of two/four dies with linear addressing
>>> capabilities to make it transparent to the user that two/four dies were
>>> used. There is one drawback however, the read status operation is racy
>>> as the status bit only gives the active die status and not the status of
>>> the other die. For commands affecting the two dies, it means if another
>>> command is sent too fast after the first die has returned a valid
>>> status (deviation can be up to 200us), the chip will get corrupted/in an
>>> unstable state.
>>>
>>> The solution adopted here is to iterate manually over all internal
>>> dies (which takes about 30us per die) until all are ready. This approach
>>> will always be faster than a blind delay which represents the maximum
>>> deviation, while also being totally safe.
>>>
>>> A flash-specific hook for the status register read had to be
>>> implemented. Testing with the flash_speed benchmark in Linux shown no
>>> difference with the existing performances (using the regular status read
>>> core function).
>>>
>>> As the presence of multiple dies is not filled in these chips SFDP
>>> tables (the table containing the crucial information is optional), we
>>> need to manually wire the hook.
>>>
>>> This change is adapted from Linux.
>>>
>>> Link: https://lore.kernel.org/all/20250110-winbond-6-12-rc1-nor-volatile-bit-v3-1-735363f8cc7d@bootlin.com/
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>
>> Same question for this one, no feedback for the past 2 months, I'm not
>> sure who's supposed to take these, Jagan and Vignesh you are marked M:
>> in maintainers, any chances this can get it?
> 
> Unfortunately, I was off quite some-time. Need little bit of time.
> Vighnesh is off for years. 

Thats not true. I dont have access to U-Boot SPI trees. So patches have
been flowing through individual "platfor/SoC" maintainers trees
unfortunately. Tom picks the patches from TI contributors once
me/Nishanth Acks where as AMD/Xlinix bits have been picked up by Michal
Simek and so on...

Happy to help out if you help to manage a merge window every now and
then or just review things. Most of the SPI NOR/NAND follow from linux
where its reviewed by set of maintainers and tested (example this one is
tested on TI board).

> In the meantime, Michael will help in
> review but need help on testing.
> 
> Thanks,
> Jagan.

