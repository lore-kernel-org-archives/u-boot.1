Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3F0C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 06:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDA5881DE3;
	Thu,  3 Apr 2025 08:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PFWImyBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BC3681E6C; Thu,  3 Apr 2025 08:21:49 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 672368043C
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 08:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5336LekS3468190
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Apr 2025 01:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743661300;
 bh=BgsKd1inl/QO7SKiC8NRD6KhNg/X1/PnDp+vA3y6N2A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=PFWImyBJ81QqYMzYiS5scx9C5N+QSRkIwVcNzIp53M1Ll6K9B7Ao3WtGtXrGgJvPy
 3JvAj26LogXpJ3BRbWBCylvtEMenHokeCh/z6etVIUccuspTQqE+/83ZPZ3rF86aco
 RNDDyK9BQyg0nUH3p8eGiO1Jlpnl5uC756wEWYy8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5336LeF5027804
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 3 Apr 2025 01:21:40 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Apr 2025 01:21:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Apr 2025 01:21:39 -0500
Received: from [172.24.227.136] (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5336LavH021533;
 Thu, 3 Apr 2025 01:21:36 -0500
Message-ID: <3287617e-3b6a-4387-90d4-7bbfc810f9c7@ti.com>
Date: Thu, 3 Apr 2025 11:51:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2 v2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <alpernebiyasak@gmail.com>, 
 <quentin.schulz@cherry.de>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>
References: <20250327080642.2269856-1-m-shah@ti.com>
 <20250327080642.2269856-2-m-shah@ti.com>
 <CAFLszTjB+HuX68tmTrLP=gbbpzt0kJr22137cSLiedx6bh6PVw@mail.gmail.com>
 <3d2c894b-11f1-462c-b9f5-8d3f45dc0b61@ti.com>
 <CAFLszThs5W+=tFpUsCE0Qi5mvuymtsHF57jeLpV9KUQfGXBXnA@mail.gmail.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <CAFLszThs5W+=tFpUsCE0Qi5mvuymtsHF57jeLpV9KUQfGXBXnA@mail.gmail.com>
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

Hey Simon,

On 03/04/25 00:52, Simon Glass wrote:
> Hi Moteen,
>
> On Wed, 2 Apr 2025 at 22:01, Moteen Shah <m-shah@ti.com> wrote:
>> Hey Simon,
>>
>> On 29/03/25 05:17, Simon Glass wrote:
>>> Hi Moteen,
>>>
>>> On Thu, 27 Mar 2025 at 08:06, Moteen Shah <m-shah@ti.com> wrote:
>>>> Add a function to scan through all the nodes in the device-tree
>>>> recusively for bootph-* property. If found, propagate it to all
>>>> of its parent nodes up the hierarchy.
>>>>
>>>> Signed-off-by: Moteen Shah <m-shah@ti.com>
>>>> ---
>>>>    tools/binman/control.py | 35 ++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 34 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/binman/control.py b/tools/binman/control.py
>>>> index e73c598298c..e739949d366 100644
>>>> --- a/tools/binman/control.py
>>>> +++ b/tools/binman/control.py
>>>> @@ -526,6 +526,35 @@ def _RemoveTemplates(parent):
>>>>            if node.name.startswith('template'):
>>>>                node.Delete()
>>>>
>>>> +def prop_bootph_to_parent(node, prop, dtb):
>>> I think the 'prop_' is a bit confusing, since you are dealing with
>>> properties! How about 'add_' as the prefix?
>> 'add_' should be more descriptive, will add that in v3.
>>
>>>> +    """Propagates bootph-* property to all the parent
>>>> +    nodes up the hierarchy
>>> First line should be a summary
>>>
>>> then blank line
>>>
>>> then describe the args...you can see this if you look at a few other functions.
>>
>> Noted, will rectify in v3.
>>
>>>> +    """
>>>> +    parent = node.parent
>>>> +    if parent == None or parent.props.get(prop):
>>> if not parent or ...
>>
>> Noted.
>>
>>
>>>> +       return
>>>> +
>>>> +    while parent:
>>>> +        parent.AddEmptyProp(prop, 0)
>>>> +        parent = parent.parent
>>>> +
>>>> +def scan_and_prop_bootph(node, dtb):
>>>> +    """Scan the device tree and set the bootph-* property if its present
>>>> +    in subnode
>>>> +
>>>> +    This is used to set the bootph-* property in the parent node if a
>>>> +    "bootph-*" property is found in any of the subnodes of the parent
>>>> +    node.
>>> comment style again
>>>
>>>> +    """
>>>> +    bootph_prop = ['bootph-all', 'bootph-some-ram', 'bootph-pre-ram', 'bootph-pre-sram']
>>>   From my understanding the only ones that matter are bootph-all and
>>> bootph-some-ram, since the SPL ones are handled by fdtgrep.
>>
>> Noted.
>>
>>
>>>> +
>>>> +    for props in bootph_prop:
>>> for prop
>>>
>>> (since it is just one)
>>>
>>>> +        if node.props.get(props):
>>>> +            prop_bootph_to_parent(node, props, dtb)
>>>> +
>>>> +    for subnode in node.subnodes:
>>>> +       scan_and_prop_bootph(subnode, dtb)
>>>> +
>>>>    def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
>>>>        """Prepare the images to be processed and select the device tree
>>>>
>>>> @@ -563,7 +592,11 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
>>>>            indir = []
>>>>        dtb_fname = fdt_util.EnsureCompiled(dtb_fname, indir=indir)
>>>>        fname = tools.get_output_filename('u-boot.dtb.out')
>>>> -    tools.write_file(fname, tools.read_file(dtb_fname))
>>>> +    dtb = fdt.FdtScan(dtb_fname)
>>>> +    scan_and_prop_bootph(dtb.GetRoot(), dtb)
>>>> +    dtb.Sync(True)
>>>> +    tools.write_file(dtb_fname, dtb.GetContents())
>>>> +    tools.write_file(fname, dtb.GetContents())
>>> You shouldn't write back to the file created by the build. Do you need this?
>>
>> Had the same thought, but the build fails in non clean builds[0]. Did a
>> workaround[1] but then some essential template nodes ends up getting
>> deleted from u-boot.dtb. Finally, had to write back to the file
>> to resolve the issue.
> Can you push a tree somewhere. This could be a bug that I could fix.

You can use the tree here to recreate the non clean build issue mentioned:
https://github.com/Jamm02/U-Boot-patchwork/tree/bootph-patch-test

>
>>>>        dtb = fdt.FdtScan(fname)
>>>>
>>>>        node = _FindBinmanNode(dtb)
>>>> --
>>>> 2.34.1
>>>>
>>> The code looks fine to me apart from the nits.
>>>
>>> This addition needs a test - see ftest.py for some examples there. But
>>> basically just create a dts that has some props in it, then check that
>>> they got added.
>>
>> Included a test as well in the patchset[3]. Do let me know if there are
>> some changes required in it.
> Somehow I'm not seeing that in patchwork. It looks good but please try
> to keep lines <=80 cols.


Sure, will fix up in v3. Should I push a v3 or wait for you to fix the 
issue discussed above?

>
>
>>> I think testSimpleFitEncryptedData() could be a good example?
>>>
>>> Regards,
>>> Simon
>> References:
>> [0]https://gist.github.com/Jamm02/2478a4f1186f3ba4a8cd7dbf1fb11e2f#file-non-clean-build
>> [1]https://gist.github.com/Jamm02/2478a4f1186f3ba4a8cd7dbf1fb11e2f#file-patch-tools-dtdoc-fdt-py
>> [3]https://lore.kernel.org/u-boot/20250327080642.2269856-3-m-shah@ti.com/
>>
>> Thanks for the review.
> Regards,
> Simon


Regards,
Moteen

