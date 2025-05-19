Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BB4C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 09:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEDA681FEE;
	Mon, 19 May 2025 11:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F63ojW8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A6382998; Mon, 19 May 2025 11:34:03 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D5AF81E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 11:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54J9XsY0862353;
 Mon, 19 May 2025 04:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747647234;
 bh=PbH9eQ+1J/eEZQsjjOSKl+YTU4uBIVrGWqpBxkFNsU0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=F63ojW8F+rIIIdBpAkP80qrAf6rXv6BcBM2CKuQtl2zjdceuhOwHlqmR0NoyvcRIZ
 wBZR3+cVodmhvvEeZLUO1owDnHOp4jSGB8DfrJ/SFquNPAva92BmPal48Mn8CNOCSQ
 3zw0bAtLwGcSfld4LNd9Xps+KmQZPn1qyY5knyho=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54J9Xsaf704828
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 19 May 2025 04:33:54 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 May 2025 04:33:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 May 2025 04:33:54 -0500
Received: from [172.24.227.136] (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54J9XolZ041268;
 Mon, 19 May 2025 04:33:51 -0500
Message-ID: <920180ff-f5c9-4454-912d-f1e76a5aa322@ti.com>
Date: Mon, 19 May 2025 15:03:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2 v2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Simon Glass <sjg@chromium.org>, Manorit Chawdhry <m-chawdhry@ti.com>
CC: Quentin Schulz <quentin.schulz@cherry.de>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <alpernebiyasak@gmail.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>
References: <20250327080642.2269856-1-m-shah@ti.com>
 <20250327080642.2269856-2-m-shah@ti.com>
 <ac62affe-7c37-4f35-915b-79d1acdd8ab8@cherry.de>
 <20250401050356.hqcksshomlgjeyno@uda0497581-HP>
 <CAFLszThKdxESi=SCLOy02aau5zyDsF36meyiCMrw4vhM6JDCtQ@mail.gmail.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <CAFLszThKdxESi=SCLOy02aau5zyDsF36meyiCMrw4vhM6JDCtQ@mail.gmail.com>
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

Hey Simon and Quentin,

Should I send one RFC for this for folks not using binman?

Regards,
Moteen

On 01/04/25 21:12, Simon Glass wrote:
> Hi Manorit,
>
> On Tue, 1 Apr 2025 at 18:04, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>> Hi Quentin,
>>
>> On 15:46-20250328, Quentin Schulz wrote:
>>> Hi Moteen,
>>>
>>> On 3/27/25 9:06 AM, Moteen Shah wrote:
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
>>>> +def prop_bootph_to_parent(node, prop, dtb):
>>>> +    """Propagates bootph-* property to all the parent
>>>> +    nodes up the hierarchy
>>>> +    """
>>>> +    parent = node.parent
>>>> +    if parent == None or parent.props.get(prop):
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
>>>> +    """
>>>> +    bootph_prop = ['bootph-all', 'bootph-some-ram', 'bootph-pre-ram', 'bootph-pre-sram']
>>>> +
>>> This should only be done for U-Boot proper DTB I believe, otherwise it'll
>>> cause FDT size increase for TPL/SPL/VPL/whatever where we may be extremely
>>> size-constrained. Furthermore, TPL/SPL/VPL should not need this since they
>>> get a subset of the actual full DTB (see scripts/Makefile.lib and
>>> fdtgrep_props), only containing the DT node that are relevant for the stage
>>> in question. The only exception I can think of right now is if we use
>>> bloblist or any other mechanism having the full DT passed from stage to
>>> stage.
>>>
>>> Maybe the solution is to have it as part of tools/binman/etype/u_boot_dtb.py
>>> only?
>>>
>>> Also, I imagine we want to support this for systems which do not use binman
>>> (yet?)?
>> I think if we really want to unblock platforms that are facing this then
>> maybe the v1 of this patchset along with the v2 can be merged. ( keeping
>> v1 config as disabled by default for now ). This can help the platforms
>> wanting to fix this issue without binman by enabling that config in
>> their defconfig ( ofcourse with a boot time penalty which would force them to
>> migrate to binman ). Though not sure if this is the right way to go
>> about it but just a suggestion.
> Yes that seems like a good idea to me.
>
> Regards,
> Simon
