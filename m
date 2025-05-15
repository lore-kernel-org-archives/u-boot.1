Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893B5C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 09:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE49982B19;
	Thu, 15 May 2025 11:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V4LPPffD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CC8C82B27; Thu, 15 May 2025 11:01:22 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B2AB82AC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 11:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54F91DMG3658687
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 04:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747299673;
 bh=FdOFolahslAzHnC5X0HMszSCT51Cnw1QBhq9LE/b1TI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=V4LPPffDSPkK814NPEPr7C/xbZ9BTY8mPWthtzeF4LDg3U1WGQ3XvFcPBK+x0kLda
 LCNTIRFrIm5fborZ1G7G1Nff6xtc8cKtuRPwJDHEti1hIkSwZDKjyaJ4MJGVp5zRZV
 t2276QNlC4t7IiSfqOaDndf8HEd4tF/W6mVVvom8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54F91DFN051092
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 May 2025 04:01:13 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 May 2025 04:01:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 May 2025 04:01:12 -0500
Received: from [172.24.227.136] (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54F91960084876;
 Thu, 15 May 2025 04:01:10 -0500
Message-ID: <2eadc7f4-e314-4540-9740-9baf5dc9f61a@ti.com>
Date: Thu, 15 May 2025 14:31:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Quentin Schulz <quentin.schulz@cherry.de>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>
References: <20250512115028.1783305-1-m-shah@ti.com>
 <20250512115028.1783305-2-m-shah@ti.com>
 <a3940636-92c2-4b7e-abe2-8357580c9f48@cherry.de>
 <f25f3091-43f1-45e0-b5b3-6c35989554cd@ti.com>
 <b95911a4-bb5e-4b36-ba6d-0f57dc0a06e3@cherry.de>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <b95911a4-bb5e-4b36-ba6d-0f57dc0a06e3@cherry.de>
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

Hey Quentin,

On 14/05/25 21:42, Quentin Schulz wrote:
> Hi Moteen,
>
> On 5/14/25 8:05 AM, Moteen Shah wrote:
>> Hey Quentin,
>> Thanks for the review.
>>
>> On 13/05/25 16:10, Quentin Schulz wrote:
>>> Hi Moteen,
>>>
>>> On 5/12/25 1:50 PM, Moteen Shah wrote:
>>>> Add a function to scan through all the nodes in the device-tree
>>>> for bootph-* property. If found, propagate it to all of its parent
>>>
>>> It's not scanning for bootph-* properties. It's scanning for two 
>>> specific bootph properties, so try to update the commit log and 
>>> comments so it's not misleading.
>>>
>>
>> I will update the commit message in the revision.
>>
>>> The commit log is lacking information as to why we need to do this, 
>>> what this helps with and why this is specific to bootph-all and 
>>> bootph-some-ram.
>>
>>  > Why this is specific to bootph-all and bootph-some-ram
>>
>> The other ones are handled by fdtgrep as those are for the SPL stage.
>>
>
> Yup, the issue is that the non-proper stages do not actually read the 
> bootph nodes as they are stripped by fdtgrep. The DTB for the stage is 
> of everything relevant to the stage, without the bootph nodes. This is 
> done to save precious space (instead of having a full DTB with 
> appropriate bootph nodes, we only keep the bootph nodes and we strip 
> the bootph properties from them as they are now implied). However, the 
> proper stage (and specifically the pre-relocation part of the proper 
> stage) uses the full DTB, with bootph properties. So we need to 
> propagate them so that pre-relocation works as expected since it'll 
> check whether bootph-all/bootph-some-ram property is part of the node 
> before probing the device.
>
> [...]
>
>>>> +    Args:
>>>> +        node (fdt.Node): Node to propagate the property to
>>>
>>> Specify that all its parents (recursively) will have this property 
>>> propagated to.
>>
>> It is iterative not recursive. How about: "Node and all its parent 
>> nodes above it to propagate the property to iteratively"
>>
>
> Mmmm, true, I had in mind that recursive also works for defining 
> "parent of parent" and "parent of parent of parent", etc, but it 
> really seems the term is specific to recursion, which we don't use here.
>
> Can suggest something like:
>
> Node to propagate the property to. Its parents (and their parents, and 
> so on until the root node) are also propagated the property.
>
> [...]
>
>>>> +    changed = False
>>>> +    for prop in bootph_prop:
>>>> +        if prop in node.props:
>>>> +            changed |= propagate_bootph(node.parent, prop)
>>>> +
>>>> +    for subnode in node.subnodes:
>>>> +        changed |= scan_and_prop_bootph(subnode)
>>>> +    return changed
>>>> +
>>>
>>> I have a gut feeling this is suboptimal, though simple and easy to 
>>> maintain.
>>> We currently go up to the root node for each and every found bootph- 
>>> {all,some-ram} property. We could simply divide this by half (or 
>>> more if there are more properties to propagate in the future) by 
>>> passing the props to propagate instead of just one. We can keep 
>>> track of which node has propagated the property already and, for its 
>>> children, stop the propagation at that level instead of going up to 
>>> the root node all the time. I'm not sure typical Device Trees are 
>>> deep enough for us to care about that kind of optimization for now, 
>>> especially since it'll be running at build time only?
>>>
>>
>>  > passing the props to propagate instead of just one
>>
>> Since we are only concerned with the post SPL stage with this patch 
>> since the SPL stages are handled by fdtgrep, I am not sure if adding 
>> this optimization would result in gains assuming that bootph-all is 
>> the superset of all bootph-* properties(this patch concerns only with 
>> some- ram and all) and adding anything with bootph-all in the same 
>> node will be redundant?
>>
>
> Something like: (not tested)
>
> def propagate_bootph(node, props):
>     changed = False
>     while node:
>         to_write = props - set(node.props)
>         for prop in to_write:
>             node.AddEmptyProp(prop, 0)
>             changed = True
>         node = node.parent
>     return changed
>
> def scan_and_prop_bootph(node):
>     bootph_prop = {'bootph-all', 'bootph-some-ram'}
>
>     changed = False
>     to_propagate = bootph_prop & set(node.props)
>     if to_propagate:
>         changed |= propagate_bootph(node.parent, to_propagate)
> [...]

Thanks for the pseudo code, question on this again, can a node have 
bootph-all and bootph-some-ram together which we would require to 
propagate together. In my understanding having both of these property in 
the same node present will be a redundancy, and searching in current 
tree as well, I found no such examples of both the properties being used 
in the same node. If in future we are planning to add more bootph* 
properties in the proper stage(pre-relocation) this change does makes 
sense. Let me know if I should add this in my next revision.

Regards,
Moteen


>
>>
>>  > stop the propagation at that level instead of going up to the root 
>> node all the time
>>
>> This optimization will surely result in gains of about few 
>> microseconds I would assume, since we are running this on host PC.
>> I am not sure if we require such optimizations in build time. It would 
>
> require? No :)
>
> We can optimize later on if it really becomes annoying for build time 
> but I'm sure there are other places in code where optimizing would be 
> more beneficial :)
>
> So no worries about the optimization ;) (also not sure it is 
> necessarily more optimized what I'm suggesting, just a gut feeling).
>
> Cheers,
> Quentin
