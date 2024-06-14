Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1272BC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 01:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F218896B;
	Fri, 14 Jun 2024 03:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718329038;
	bh=luV3MsfuhQqublYI366/0YoMw33rUbwPL3nnFb2Ycto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FCh9TVa5DsrQWq4KnHVGUunPRa/QH/HPp6IDRyaP6Dy90DafYxOT7l7Ii0QUOeV5z
	 8ms41N1QA4gH1H2Af6BT7/i9FwlkkROokR0MCYLihqoVqX36J31KpGS1WTaXfc7r6w
	 jHO44Cn5QOO0QBvwoBCT/g+j3YJGwFs6IYnCFfN3RIg6XROatNlhk1/XB/ftJbvIIU
	 N2aHS+Su/KUMMKdp8/E/JtLKR3Oy26TcU/FuAVyMsEvNnUD00lAybhRdqZfv7sRYj5
	 Tp7ZF4KFuLQ7SWKsPj6f6NH9WJZYbAbn/3WQsnhWx8pewc5wVdgmzx1kmP1/qSxWTU
	 bSmSvP1uz1hXQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 26E7387EED;
 Fri, 14 Jun 2024 03:37:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718329036;
 bh=luV3MsfuhQqublYI366/0YoMw33rUbwPL3nnFb2Ycto=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CQV6REFOaTCb5D1q3m3gpO2QVQsbt6L9HantfUY+/d6m6FHqwxVNVM2AghwbyNOCI
 sBjsd/6YN3fxNTFN1IprBs0xMdROOSNSHj6gNIaQp7d3KRJ2jvTHYwEg2dXN6e3dgm
 sEJr3Glfkopj4VYPdG5UL1KSkCWed5+ekpHkbFRpsLvkZJ7ztcwc5Dpoh0LwWZZX34
 mPpTnIFkDGcN5jar93ppTqfY1SrcuBqGicD1dQEXWX1nMLrxmFe0GhXFTYJ74Km5yK
 pjla7JJf1dGW0PxpPX1dgsDkuqlpMaY/rUq3CRIdFEYSZycH8ywnjz3cYpZ4eXC0e/
 IuMbCgzbg29nw==
Message-ID: <9b4e1e28-bb9b-4b6d-a0d8-b8fe161acff4@denx.de>
Date: Fri, 14 Jun 2024 02:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Shutting down of the git-daemon (git protocol, https and ssh
 still remain)
To: Claudius Heine <ch@denx.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Stefano Babic <sbabic@denx.de>
References: <323dbb9c-42bd-4664-b660-0ba24c819bec@denx.de>
 <94d1e571-6051-4a1a-b15a-ab5147ada833@cherry.de>
 <814d2716-bc77-494a-871e-1bf3ee466d6b@denx.de>
 <ea1f5d07-aaba-42a6-96f7-e90b370ff4ae@denx.de>
 <da7fac68-6684-4932-89c1-594913832fb9@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <da7fac68-6684-4932-89c1-594913832fb9@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/13/24 4:13 PM, Claudius Heine wrote:

Hi,

>> I suspect the following patch to oe-core (or local.conf equivalent) 
>> might also entirely mitigate the issue by providing https fallback 
>> automatically, without the need to modify the legacy layer/recipe ?
>>
>> If so, maybe this could be added to OE LTS releases at least ?
>>
>> "
>> diff --git a/meta/classes-global/mirrors.bbclass 
>> b/meta/classes-global/mirrors.bbclass
>> index 862648eec5..50a14c5881 100644
>> --- a/meta/classes-global/mirrors.bbclass
>> +++ b/meta/classes-global/mirrors.bbclass
>> @@ -77,6 +77,7 @@ https?://downloads.yoctoproject.org/mirror/sources/ 
>> https://mirrors.kernel.org/y
>>
>>   MIRRORS += "\
>>   git://salsa.debian.org/.* git://salsa.debian.org/PATH;protocol=https \
>> +git://git.denx.de/.*          git://git.denx.de/PATH;protocol=https \
> 
> Well the path will change a bit as well:
> 
> git://git.denx.de/u-boot.git -> https://source.denx.de/u-boot/u-boot.git
> git://git.denx.de/u-boot-efi.git -> 
> https://source.denx.de/u-boot/custodians/u-boot-efi.git

Better avoid custodian trees in OE builds unless this is a test build.

> git://git.denx.de/xenomai.git -> https://source.denx.de/xenomai/xenomai.git
> git://git.denx.de/mxssb.git -> https://source.denx.de/denx/mxssb.git

mxssb is I think long superseded by U-Boot mkimage integration, so this 
can also be dropped.

The remaining two, u-boot and xenomai, yeah, those would likely need to 
be separate.

> If we want to make it perfect, it will be more difficult than that.
> 
>>   git://git.gnome.org/.* 
>> git://gitlab.gnome.org/GNOME/PATH;protocol=https \
>>   git://git.infradead.org/.* git://git.infraroot.at/PATH;protocol=https \
>>   git://.*/.*                   git://HOST/PATH;protocol=https \
>> "
>>
>>> Anyway, I fixed it yesterday, and it doesn't make much sense to stop 
>>> it now. So I will leave it in place until it breaks again, then I 
>>> just remove it.
>>
>> Do you know how long it was actually broken ? (i.e. how long nobody 
>> noticed and complained about it?)
> 
> So since 3rd of June, so about 5-8 days or so until someone noticed.

Hum, since it works now again, I think we can wrap this discussion up.

However, maybe this can serve as a wake up call for people to switch to 
https cloning ?
