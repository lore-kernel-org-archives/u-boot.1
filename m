Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AEAC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 05:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ECD78081A;
	Wed, 26 Feb 2025 06:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J/9pUWRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A5480977; Wed, 26 Feb 2025 06:57:46 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74BA4807EE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 06:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q5vc3W2005075
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2025 23:57:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740549458;
 bh=9CYtd77d8X5AOqOhso1/9SZyLoAgt2Bzesr5pd49z94=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=J/9pUWREQ7ITvjIT6QQCleKQO0BWqtmLq2921UXBjg61Mbgmh6yGuLDPhpl16/fDY
 Le4+uYQoDBFZuTLhmnN8Omi7Og5vH1zbYryqg6odowRjVBkqorNB5JdWZghQHRfsBU
 fOpxNoBtA/TSULZFnXZGNr+AOAXneWf7YT9bsLBQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q5vc2l041194
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 25 Feb 2025 23:57:38 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Feb 2025 23:57:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Feb 2025 23:57:37 -0600
Received: from [172.24.227.136] (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51Q5vYHF128194;
 Tue, 25 Feb 2025 23:57:35 -0600
Message-ID: <5ea8ee8e-1643-4b4b-974c-627f1958edd8@ti.com>
Date: Wed, 26 Feb 2025 11:27:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2 v1] Propagate bootph* property to all parent nodes
To: Quentin Schulz <quentin.schulz@cherry.de>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>
References: <20250212091820.213895-1-m-shah@ti.com>
 <445f7dd4-d445-41a2-ad0b-f0c2002f3f1a@cherry.de>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <445f7dd4-d445-41a2-ad0b-f0c2002f3f1a@cherry.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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


On 17/02/25 20:32, Quentin Schulz wrote:
> Hi Moteen,
>
> On 2/12/25 10:18 AM, Moteen Shah wrote:
>> [You don't often get email from m-shah@ti.com. Learn why this is 
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> In the U-Boot pre-relocation stage, if the parent node lacks bootph*
>> property and the driver lacks a pre-reloc flag, all of its subsequent
>> subnodes gets skipped over from driver binding—even if they have a
>> bootph* property.
>>
>> This series addresses the issue by scanning through all the subnodes
>> of the current node for the bootph* property and propagate it to all
>> of its supernodes, ensuring that all of the applicable drivers are
>> bound and probed prior to relocation. This series implements one of
>> the solutions mentioned in [0].
>>
>> Since, all the nodes which are not having any bootph* property will
>> also be traversed, we will have to incur some overheads in boot time,
>> hence protecting the feature under a config.
>>
>> Boot time overheads:
>>      Baseline: Upstream u-boot
>>
>>      Patch test: Baseline + remove all bootph-all properties from
>>      *-u-boot.dtsi except the ones which are supposed to be probed
>>      but have no bootph in any of its subnode.
>>
>>      J7200 delta from baseline  : ~100ms
>>      J784S4 delta from baseline : ~350ms
>>
>
> Pfew, that's a lot of time. Can you tell us what's the delta in 
> percentage from baseline? Because if your system is usually booting in 
> one minute, 100ms isn't too bad :)
>

Our system's boot time is about 2.2s (J7200) and that of J784s4 is 2.7s 
(owing to a larger DT).


> FYI, I believe we've been hit by this issue on Rockchip but cannot 
> find the thread or patch right now.
>
> For TPL and SPL, the Device Tree is parsed and looked for appropriate 
> bootph properties. Any node which doesn't have a bootph property and 
> doesn't have any children with a bootph property is removed from the 
> tree. However, the bootph property (if only present in a children 
> node) isn't propagated (meaning the node doesn't get the property). 
> This is done by fdtgrep.
>
> The issue is that for U-Boot proper pre-relocation, the whole DT is 
> taken and only nodes with the appropriate bootph property is probed 
> and children nodes do NOT count as opposed to the TPL/SPL case.
>
> My idea was that maybe we should rather propagate the property, at the 
> very least in U-Boot proper pre-relocation. This does mean we will 
> increase (by which amount?) the size of the DT in U-Boot proper 
> because we would add this property recursively up the tree from a node 
> that has the bootph property for U-Boot proper pre-relocation. This 
> **could** be an issue as the DT could be passed between stages and we 
> would then hit the size limit. Sadly, I didn't take the time to look 
> into adding support for that in fdtgrep nor will I have the time to do 
> it, so take this as me sharing my wish list with you.
>

Thanks for sharing this, the size increase this patch introduces for 48 
such bootph-* tags is about 1.5KB's, we can go ahead and bind the super 
parent to bypass the part of adding the tag, but for the next parent we 
will have to traverse again down the DT adding in unnecessary 
traversals(considering a case that we are 4-5 levels deep in the DT).

> I would really like to avoid having it guarded by a knob though 
> because I really think this is an issue that should simply be fixed 
> unconditionally for every platform with DT support.
>

Agreed. This fix should be for all platforms, the knob is for preventing 
boot time performance issues.


> Cheers,
> Quentin


Regards,
Moteen

