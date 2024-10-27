Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F106DD1356A
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 21:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC1F88F0A;
	Sun, 27 Oct 2024 22:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730062978;
	bh=lEqUjs7undS7UftpUtPSdU3z228rDJDSWpSxruU8BzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qAz4kSdEsEB+R2CdKvDsOKnS0MTKINRv2FMywT1yctIVv/zrgM1LFc1sUpAmTZBMg
	 NzgkCtA1Tf/5rQj7po5zcSaBTL3uMgONEKqkAunig9Fe/hNokvbbbv/p7h4+wv1Haf
	 p045/kngJV1z4m+LBGu2Cm+RlFEuC/6sb6u4g1+WKaHF8R/DSI06WMfU6ORB5dl1kQ
	 kDabsEb6xh2hFY/OkVWXjcnU0GDzR3iU+A4ovkxvZu69J/D4f4Pd3rmwiu6wOptlx5
	 q2U4mj9HUWPFVvZvKbBrvmy6WhLvfdV0IjkZpLKBvNvuugzO16rwqAtY0Ae6rsrlpo
	 XXIqnF63d+cbg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D3E5F881A5;
 Sun, 27 Oct 2024 22:02:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730062977;
 bh=lEqUjs7undS7UftpUtPSdU3z228rDJDSWpSxruU8BzY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fotZY7mVFS4t0hIKSc4fUmDbTnaHDl5wn9f7+KhfPMT+DjC1wVUonny8+00ZNNHdJ
 WnVpnkXe4RbC6tCaF/RRp0xm2CEIAiF4Vk6J8vxqPNqm+X6mKfyL59krOPvY5aHGcX
 /MhRxS1QCT2/uAA3woB/dqdM9kgLZ6ZZ2ZhLKAiZGoM5JkWQFOsdwsONSyM/5pmnfr
 fN1Jk/M+H6EWAgScxCjdgkKC0qOcUz2xl92yMRVGUMU7K7r8xUC+0H04BWX3ceZvzk
 qWwCKmHVM+sIDsLYpONjfNknDFd7o55ZX6uDtVa4S2JEPzo3HjmvyUkQFo5ePI7g3E
 wKcl/d3fAeaCQ==
Message-ID: <f5ff176d-14f3-4ace-85db-33419512d42b@denx.de>
Date: Sun, 27 Oct 2024 22:02:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>,
 Fabio Estevam <festevam@denx.de>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20241024122735.893319-1-ravi@prevas.dk>
 <3fa7049d-4657-4cae-9ccf-fac1c62ce529@denx.de> <87o738psig.fsf@prevas.dk>
 <e2d45889-33b1-438e-8872-f03a4c050c18@denx.de> <874j4xl7cj.fsf@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <874j4xl7cj.fsf@prevas.dk>
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

On 10/27/24 7:38 PM, Rasmus Villemoes wrote:
> On Fri, Oct 25 2024, Marek Vasut <marex@denx.de> wrote:
> 
>> On 10/25/24 9:10 AM, Rasmus Villemoes wrote:
>>> On Thu, Oct 24 2024, Marek Vasut <marex@denx.de> wrote:
>>>
>>>> On 10/24/24 2:27 PM, Rasmus Villemoes wrote:
>>>>> Loading flash.bin using uuu fails when flash.bin does not have the
>>>>> right size.
>>>>> When flash.bin is loaded from some storage medium (sd card/emmc),
>>>>> SPL
>>>>> just loads some random garbage bytes from beyond what has been
>>>>> populated when flash.bin was written, but when loaded via uuu, SPL
>>>>> hangs waiting for the host to send the expected number of bytes. Which
>>>>> is (size of FIT image aligned to 0x1000)+CONFIG_CSF_SIZE. The
>>>>> alignment to 0x1000 is already done and is necessary in all cases
>>>>> because that's the exact expected location of the 32 byte IVT
>>>>> header. But the IVT+CSF blob tacked onto the end must be a total of
>>>>> CONFIG_CSF_SIZE.
>>>>> This is exactly the same fix as 89f19f45d650, except that this time
>>>>> around I don't know how to cleanly get CONFIG_CSF_SIZE.
>>>>> Fixes: bc6beae7c55f (binman: Add nxp_imx8mcst etype for i.MX8M
>>>>> flash.bin signing)
>>>>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>>>>> ---
>>>>> Heiko, can you check if this works for you?
>>>>> And if somebody wants to pick this up and knows how to get at
>>>>> CONFIG_
>>>>> values, feel free to fix up and take authorship. But perhaps it's not
>>>>> really configurable at all; imx8mimage.c has the value 0x2000
>>>>> hard-coded, so I don't think anything good could ever come from
>>>>> modifying CONFIG_CSF_SIZE. If so, the right fix is probably just to
>>>>> make that knob non-settable.
>>>>>     tools/binman/etype/nxp_imx8mcst.py | 2 ++
>>>>>     1 file changed, 2 insertions(+)
>>>>> diff --git a/tools/binman/etype/nxp_imx8mcst.py
>>>>> b/tools/binman/etype/nxp_imx8mcst.py
>>>>> index 8221517b0c4..9a1974cc522 100644
>>>>> --- a/tools/binman/etype/nxp_imx8mcst.py
>>>>> +++ b/tools/binman/etype/nxp_imx8mcst.py
>>>>> @@ -137,6 +137,8 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>>>>>             args = ['-i', cfg_fname, '-o', output_fname]
>>>>>             if self.cst.run_cmd(*args) is not None:
>>>>>                 outdata = tools.read_file(output_fname)
>>>>> +            # fixme: 0x2000 should be CONFIG_CSF_SIZE
>>>>> +            outdata += tools.get_bytes(0, 0x2000 - 0x20 - len(outdata))
>>>>>                 return data + outdata
>>>>>             else:
>>>>>                 # Bintool is missing; just use the input data as the output
>>>>
>>>> I have to admit, I never really figured out this binman stuff, but
>>>> shouldn't the fix be also in tools/binman/etype/nxp_imx8mimage.py ?
>>> No, why? That logic is all about generating the imx-specific header
>>> in
>>> front of SPL.bin, there's no CSF being generated.
>>
>> This patch is modifying tools/binman/etype/nxp_imx8mcst.py which is
>> the Code-Signing-Tool binman etype, the thing used for generating
>> SIGNED images during HAB use.
>>
>> Shouldn't this patch modify tools/binman/etype/nxp_imx8mimage.py which
>> is the etype used when generating flash.bin itself ?
> 
> No, because this is not about flash.bin per se, but about the (u-boot
> FIT+IVT+CSF) blob that forms part of flash.bin, in the IMX_HAB case.
> 
>> My understanding was that the problem Heiko reported was alignment of
>> flash.bin , independently of it being signed or not ?
> 
> Read the thread again. Heiko's problem was very much related to IMX_HAB
> being enabled. I've already explained what the problem actually is
> and why this fixes it. Not only once, but as I said, this is equivalent
> to a fix I sent for the shell script implementation, so to answer a
> question you asked elsewhere: Yes, this is missing in the binman
> implementation.
> 
> Extending the size of flash.bin in the !IMX_HAB case will have the
> opposite problem (as will adding the wrong amount of padding bytes in
> the IMX_HAB case), namely that the board will boot, but uuu on the host
> will "hang" waiting for the target to consume the remaining bytes.
Oh, I see, all right then. Thanks for clarifying.
