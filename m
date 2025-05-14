Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EB7C3ABC5
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 06:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2ED08129F;
	Wed, 14 May 2025 08:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xwkxOj1f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1890182162; Wed, 14 May 2025 08:06:13 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C9980107
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 08:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54E663Gm3317782
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 01:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747202763;
 bh=XSrURt/+5dip/FFPfRNMw/ShEzOlfolyTMF/5c3Lt9o=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=xwkxOj1fVKbfXyQjuFYlJGZlDgjcPp1gR4k3uY4cTuHtr381+tpERzeGkExt17qVH
 7hXhKgJHmriwoKpOKfWNL1pkwvDfa+/njB6iHCJwGKitUwGmG4d5ur8OMvqvJ0Mosh
 sNsZyEPU3jFqaMD8miT7yTG2YQ/KBV+a2uMtq5CU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54E663I0104561
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 May 2025 01:06:03 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 May 2025 01:06:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 May 2025 01:06:03 -0500
Received: from [172.24.227.136] (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54E65xBX007909;
 Wed, 14 May 2025 01:06:00 -0500
Message-ID: <f25f3091-43f1-45e0-b5b3-6c35989554cd@ti.com>
Date: Wed, 14 May 2025 11:35:59 +0530
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
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <a3940636-92c2-4b7e-abe2-8357580c9f48@cherry.de>
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
Thanks for the review.

On 13/05/25 16:10, Quentin Schulz wrote:
> Hi Moteen,
>
> On 5/12/25 1:50 PM, Moteen Shah wrote:
>> Add a function to scan through all the nodes in the device-tree
>> for bootph-* property. If found, propagate it to all of its parent
>
> It's not scanning for bootph-* properties. It's scanning for two 
> specific bootph properties, so try to update the commit log and 
> comments so it's not misleading.
>

I will update the commit message in the revision.

> The commit log is lacking information as to why we need to do this, 
> what this helps with and why this is specific to bootph-all and 
> bootph-some-ram.

 > Why this is specific to bootph-all and bootph-some-ram

The other ones are handled by fdtgrep as those are for the SPL stage.

>
> We need to be able to look at this patch in 5 years and have a clue of 
> why this was required.

Noted.

>
>> nodes up the hierarchy.
>>
>> Signed-off-by: Moteen Shah <m-shah@ti.com>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>   tools/binman/control.py | 51 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/tools/binman/control.py b/tools/binman/control.py
>> index 81f61e3e152..ccf081cb686 100644
>> --- a/tools/binman/control.py
>> +++ b/tools/binman/control.py
>> @@ -530,6 +530,54 @@ def _RemoveTemplates(parent):
>>       for node in del_nodes:
>>           node.Delete()
>>   +def propagate_bootph(node, prop):
>> +    """Propagate bootph-* property to all the parent nodes up the 
>> hierarchy
>> +
>
> Misleading, it's not propagating bootph properties, it's propagating 
> the prop passed as an argument to the function, so rename to something 
> like propagate_prop and update the comment.

Okay, will rename this to propagate_prop.

>
> Be clear also that this is expected to be a boolean property (because 
> of AddEmptyProp).

Noted.

>
>> +    Args:
>> +        node (fdt.Node): Node to propagate the property to
>
> Specify that all its parents (recursively) will have this property 
> propagated to.

It is iterative not recursive. How about: "Node and all its parent nodes 
above it to propagate the property to iteratively"

>
>> +        prop (str): Property to propagate
>> +
>> +    Return:
>> +        True if any change was made, else False
>> +    """
>> +    changed = False
>> +    while node:
>> +        if prop not in node.props:
>> +            node.AddEmptyProp(prop, 0)
>> +            changed = True
>> +        node = node.parent
>> +    return changed
>> +
>> +def scan_and_prop_bootph(node):
>> +    """Propagate bootph properties from children to parents
>> +
>> +    The bootph schema indicates that bootph nodes in children should 
>> be implied
>
> s/nodes/properties/

Will change in the revision

>
>> +    in their parents, all the way up the hierarchy. This is 
>> expensive to
>> +    implement in U-Boot before relocation, so this function explicitly
>
> I think the point here is "at runtime" which is missing.
>

Noted.

>> +    propagates these bootph properties upwards.
>
> at build time :)
>

Noted.

>> +
>> +    This is used to set the bootph-* property in the parent node if a
>> +    "bootph-*" property is found in any of the parent's subnodes.
>> +
>
> This is all misleading, we aren't propagating all bootph properties
>
>> +    Args:
>> +        node (fdt.Node): Node to propagate the property to
>
> Same remarks as for the propagate_bootph method above.
>
>> +        prop (str): Property name to propagate
>> +
>> +    Return:
>> +        True if any change was made, else False
>> +
>> +    """
>> +    bootph_prop = ['bootph-all', 'bootph-some-ram']
>> +
>
> Please explain why those only.

Answered above.

>
>> +    changed = False
>> +    for prop in bootph_prop:
>> +        if prop in node.props:
>> +            changed |= propagate_bootph(node.parent, prop)
>> +
>> +    for subnode in node.subnodes:
>> +        changed |= scan_and_prop_bootph(subnode)
>> +    return changed
>> +
>
> I have a gut feeling this is suboptimal, though simple and easy to 
> maintain.
> We currently go up to the root node for each and every found 
> bootph-{all,some-ram} property. We could simply divide this by half 
> (or more if there are more properties to propagate in the future) by 
> passing the props to propagate instead of just one. We can keep track 
> of which node has propagated the property already and, for its 
> children, stop the propagation at that level instead of going up to 
> the root node all the time. I'm not sure typical Device Trees are deep 
> enough for us to care about that kind of optimization for now, 
> especially since it'll be running at build time only?
>

 > passing the props to propagate instead of just one

Since we are only concerned with the post SPL stage with this patch 
since the SPL stages are handled by fdtgrep, I am not sure if adding 
this optimization would result in gains assuming that bootph-all is the 
superset of all bootph-* properties(this patch concerns only with 
some-ram and all) and adding anything with bootph-all in the same node 
will be redundant?


 > stop the propagation at that level instead of going up to the root 
node all the time

This optimization will surely result in gains of about few microseconds 
I would assume, since we are running this on host PC.
I am not sure if we require such optimizations in build time. It would 
be great if I can get some more opinions on this. I am not able to 
profile the time delta in build time with this patch since every build 
is having differences of few seconds between them on the same tree. I 
tried using pythons cprofiler on the function[0], didn't find any timing 
overheads as expected since we are running things on host PC which is 
way faster than the SoC's.

[1]https://gist.github.com/Jamm02/6ce3e4eb1fd2442ad5e01ff89ead6e6e

Regards,
Moteen

> Cheers,
> Quentin
