Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF802C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 08:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3534C86FFE;
	Fri, 17 Nov 2023 09:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700209049;
	bh=3stlUCyOKBXH8lCuYZhQJ0Afh4bTVCuxYISQVpDcC2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ejj8kmfoKrP+dvMfj6MNKXGXnFckJ2WwjVcuWL3DVwrn3NSOChOwT+lJHYSRvUlKM
	 9N1Kx3zHQh1Vgyv2uFtuQ80Lntt2eomcefni4DR1+1G/oLpVMjPek1pZQY2VQdQEAT
	 WLqXDqTbEYMPFkW4rhWvtyXl6nTpAbi1+aftEhNLQCF+wzYknCo9I/fD+/2RahWmJa
	 eLFZb2c1hgjpB5xbTZePZLrgADr5MYIp1IDMqqNnlDgOvE7WzYHDqUoAg97+5Y1lB/
	 vgkfGhN19M2V3VONWbc2dxt9Y2Wz9++v74QLbrncrTpr4xWoLAWXCPsPwy4h6qekOF
	 XIG9VpvUNSH9Q==
Received: from [IPV6:2001:a61:6115:df01:cb0c:1603:a432:5b7e] (unknown
 [IPv6:2001:a61:6115:df01:cb0c:1603:a432:5b7e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: sbabic@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1D39686EEE;
 Fri, 17 Nov 2023 09:17:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700209048;
 bh=3stlUCyOKBXH8lCuYZhQJ0Afh4bTVCuxYISQVpDcC2M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SArupE8HJXVXUxuwaGbsJAVmPWXLe1AKGTYqqIJja1IMmkSSKBSseG55E5QbHgKQX
 OQ/HeEDwrLSRkkgn9lTYAgWeh6pddQwXjLK8mwaXk52yAX0NgQ3IAL+22cfcyy3Sra
 GQZ/yAAWiGgDnnk4UmC0le48BDYfShWU/f+B8yVIGSL1IJUO7z9DTe77e9l1oa35Ih
 PfN007rScSbiLTtbPDQVM+MeQkDhR2G7x/9gxhd4m66vmVtgc85BG6l6oX+Nm8QbhV
 c3+4i9iIiaMBBKux1mxus+Trmu17B7klivRPK0yUJE4SY3NkzQwC9Z8ohrDMaIVXyQ
 WiB63xmpLHgRw==
Message-ID: <91c3d742-a87a-458a-ab6f-6a56706bb78c@denx.de>
Date: Fri, 17 Nov 2023 09:17:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
To: Tom Rini <trini@konsulko.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "festevam@gmail.com" <festevam@gmail.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-3-marcel@ziswiler.com>
 <f9ce2b20-1fa1-408c-9ae6-4dd382c9c999@prevas.dk>
 <6ab14ae1-7044-4663-98e4-919b9d1757b9@denx.de>
 <899b50aa96b802275035f9ee40f46b461f8bfb46.camel@toradex.com>
 <86ddb623945da5a507fb4632375f7cb70361ac58.camel@toradex.com>
 <20231116184226.GF170968@bill-the-cat>
Content-Language: de-DE
From: Stefano Babic <sbabic@denx.de>
In-Reply-To: <20231116184226.GF170968@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom, Marcel,

On 16.11.23 19:42, Tom Rini wrote:
> On Thu, Nov 16, 2023 at 10:57:27AM +0000, Marcel Ziswiler wrote:
>> Hi Tom
>>
>> On Thu, 2023-11-02 at 08:09 +0100, Marcel Ziswiler wrote:
>>> Hi Stefano
>>>
>>> On Thu, 2023-10-26 at 10:36 +0200, Stefano Babic wrote:
>>>> On 26.10.23 10:29, Rasmus Villemoes wrote:
>>>>> On 26/10/2023 09.32, Marcel Ziswiler wrote:
>>>>>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>>>>
>>>>>> This fixes a regression in the eMMC fast boot mode case where the buffer
>>>>>> was missing 464 bytes.
>>>>>>
>>>>>> The code figures out how many bytes must at least be fetched to honor
>>>>>> the current read, rounds that up to the ss->pagesize [which is a no-op
>>>>>> in the USB download case because that has ->pagesize==1], fetches that
>>>>>> many bytes, but then recorded the original upper bound as the new end of
>>>>>> the valid data. However, this did not take into account the rounding up
>>>>>> to the ss->pagesize. Fix this by recording the actual bytes downloaded.
>>>>>>
>>>>>> Fixes: 4b4472438f5a ("imx: spl_imx_romapi: avoid tricky use of spl_load_simple_fit() to get full FIT
>>>>>> size")
>>>>>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>>>>
>>>>>
>>>>> Thanks for reporting and fixing this, and sorry for the trouble.
>>>>>
>>>>> Acked-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>>>>
>>>>
>>>> And thanks for all your work - I will apply this fix soon.
>>>
>>> Any news on applying this fix? Note that master still stays broken as of today.
>>
>> And two weeks later still broken!
> 
> I've put this in my not to forget queue for the next -rc.
> 
>> Anyway, I feel i.MX maintainership seems rather stalled at times most of the time. I don't want to criticise
>> anybody knowing how busy our trade can get. However, if it helps the cause Toradex would be ready to step up.
>> Let me know what you think. Thanks!
> 
> I would be happy to see an additional custodian for the imx tree, if
> that's agreeable with Stefano.

I have rather less time for U-Boot and it won't be better in the near 
future. Fabio is co-maintainer and he has accepted to take over the 
repository and go on maintaining u-boot-imx. Just let him some time to 
be confident with patchwork and CI.

Thanks,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================

