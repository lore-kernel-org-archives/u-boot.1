Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A03CEBF61
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 22:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F2A83ABF;
	Sun, 16 Nov 2025 23:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jhZtHRJn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="t/dmkbI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E08F9839B1; Sun, 16 Nov 2025 23:55:49 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0BFC83A3D
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 23:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d8mSM4QX6z9t8t;
 Sun, 16 Nov 2025 23:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763333747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1elrWF4pRbxG4OqUzmdRbj8cqZmjOQluwR0LdY6YmjY=;
 b=jhZtHRJnPnTtxLFSuK9gTIw8kh7T5TM7tVT/atwKaP51L4Mgv00IKQpllWVstBGvCUieoV
 D33zGvsX50LaBJm9VIjYdjzRkYt/caHuN7wxgUEcQnm6DdX0PICe8SIERDbxZRrPBXsWyD
 LrAgo5caVnLfDiL8mYgoYqZDVcAsKn3nRHXENoLUa6rZOwZOGoQWvL/8dD0wNgtw77B0YQ
 OkH/YYNv6N4wbvAK4jrNEm3aCoEFbDLOHWri4cQlKP428i2hVrQKV9pn7fgRPZUdFNFBGJ
 GOQlBwEHlXop88tbdWTYLAxWWytVhIJ6vo0cxIJJAtmPQadtOeZCgndQIIFKWw==
Message-ID: <e619b3ac-d99a-468c-8275-a8db5b406e62@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763333745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1elrWF4pRbxG4OqUzmdRbj8cqZmjOQluwR0LdY6YmjY=;
 b=t/dmkbI2pLwC5dRkSxOaTmnhpHKX0eUYcBQRJ69/GhbEbA2m2crudmDWSzsgOLEj63V3wq
 I0UU20HwpTynWW9/NqmrpIhujmzpuvgaoP0OcoB2+YGssEEu1FiHX0viWz8LFMuwg4c3SP
 XsY6oiDnt0bhh3cJyGKHILC29hH11x63GTn+S83nvdrnbZ2z5J+95J1kgYCgyKiRe3aLDz
 2dHy/iyTeKJp09DezMEJYxkgzRYPEv6rpeI/P8Hmj768zi3N50+xSjtMieb4MIb3+1lHER
 OX1hOQAM6PBZCDO9+Qbm8z8GFlN4H/akUbGDr+DSABwo2dDZqJw6T7DVu+zjMg==
Date: Sun, 16 Nov 2025 22:43:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] boot: Warn users about fdt_high=~0 usage
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20251113142957.1069909-1-marek.vasut+renesas@mailbox.org>
 <20251113154900.GJ6688@bill-the-cat>
 <07424e88-16f8-4332-b93c-f0baeed5758c@mailbox.org>
 <20251116140913.GB2125796@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251116140913.GB2125796@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 07eafeeb792fac98048
X-MBO-RS-META: a511mwyhfs13mfufbuft1moopftheobg
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

On 11/16/25 3:09 PM, Tom Rini wrote:

Hello Tom,

>>>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>>>> index 3f0ac54f76f..e88525a3846 100644
>>>> --- a/boot/image-fdt.c
>>>> +++ b/boot/image-fdt.c
>>>> @@ -189,6 +189,10 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
>>>>    			/* All ones means use fdt in place */
>>>>    			of_start = fdt_blob;
>>>>    			addr = map_to_sysmem(fdt_blob);
>>>> +			if (addr & 7) {
>>>> +				printf("WARNING: The 'fdt_high' environment variable is set to ~0 and DT is at non-8-byte aligned address.\nWARNING: This system will likely fail to boot. Unset 'fdt_high' environment variable and submit fix upstream.\n");
>>>> +			}
>>>> +
>>>>    			err = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
>>>>    					    of_len, LMB_NONE);
>>>>    			if (err) {
>>>
>>> I think we need to yell about it sooner.
>>
>> I don't think so, for two reasons:
>>
>> - If the user uses e.g. bootz to boot their kernel, which on arm32 is still
>> sadly happening, they wouldn't trigger this problem at all and they wouldn't
>> care about whichever way their fdt_high is set.
> 
> Which part of the problem? If the dtb is not 8-byte aligned the kernel
> will fail. All the accessors require 8 byte alignment.

On 64bit systems, yes. On 32bit systems it is not so clear cut, they 
might boot with 4-byte aligned DTs. I might be wrong about this, but if 
I recall it right, bootz is very simplistic and it doesn't handle much 
in terms of DT relocation, and ignores fdt_high, so the users on those 
32bit systems that use bootz to boot also don't care about fdt_high much.

>> - If the user sets 'fdt_high' as part of their boot command, they would not
>> get any warning print if we warn earlier, but they would get one when they
>> boot and trigger this affected code path.
>>
>> Maybe we need warnings in two locations ?
> 
> Maybe? I was thinking it should be around this in boot/image-fdt.c:
>          /* If fdt_high is set use it to select the relocation address */
>          fdt_high = env_get("fdt_high");
>          if (fdt_high) {
>                  ulong high_addr = hextoul(fdt_high, NULL);
> 
>                  if (high_addr == ~0UL) {
>                          /* All ones means use fdt in place */

This is exactly the code that this patch modifies . Where in the above 
do you think this change should be ?

> As that's where all of the code paths end up calling, I think. But if
> it's multiple paths, yes, multiple warnings if we can't abstract it out
> to a common path.
> 
>>> Today (and for quite some
>>> years) if you pass a 4 byte and not 8 byte aligned DT to Linux, it fails
>>> to boot or breaks in loud
>>
>> Worse, not loud, but silent.
> 
> Also true, yes.
> 
>>> and odd ways. This has in turn lead to much
>>> time spent and some of our older threads with the libfdt folks years
>>> ago. So I think we need something earlier in code where we're seeing
>>> that fdt_high is set to ~0 and that's where we say "Stop doing this, it
>>> will be removed soon".
>>
>> We cannot remove this functionality, someone might actually depend on it for
>> whatever reason. It is part of the command line ABI now.
> 
> The valid use case is boot time optimization. It's also a
> micro-optimization (as actually megabyte sized device trees like when
> people wanted to pass FPGA bitstreams in 15+ years ago are not allowed)

( not allowed where exactly ? fitImage is a DT too )

> I think really. I am loath to break ABI like this but I'm not entirely
> sure we have a choice.

We do, we simply warn users and remove the usage and fdt_high=~0 
assignments from the tree. The functionality itself does not have to be 
removed.

> Maybe we detect disabled relocation and
> misaligned device tree and fall back to prompt? Or if it's too late,
> panic with an explanation? Or maybe we just move it 4 bytes higher. The
> device is in a going to fail state anyhow, so trying to recover it might
> be OK, and since the device tree needs to be modified by us it has to be
> in writable memory.
Keep in mind, on arm32 it may not necessarily fail to boot with 4-byte 
aligned DT.
