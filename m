Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE85D0BB56
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 15:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FEE589030;
	Fri, 25 Oct 2024 17:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729869026;
	bh=ndzeqRyiX7Rslx1SxtxTCmbFPOqL3fa7upeL+zW3BLI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OWxeVEeDO/dzzUVxQRbtgLxe5P0RDPsBt1OoJduHgwe53nfBfTNlkkJO2rnfouxfW
	 tiFZtMw+kfe8wn4ohMcnj8FlP0XH87ooyIRxAjvpTd9hCJkEktncrkPoM+nv+ZftLi
	 iuyFtJ7Cp59qFeqUSvvqleta+HnEn5qVxEYgqEr0AG3EH+uKBZkmUAAr7RL4tixVDL
	 4TT+bQCy8+thvaediaQU7gtG6gs0sDPRWy4D0EbgZIaE3OKIVJtit3krLwfS1zPmb+
	 /PCVCORbqrs598+Q3wUsMn1iL/3Rfu3evimcId775ByI80hG0QCte3fIxIjSM3A427
	 ochCxe3tehnEA==
Received: from [127.0.0.1] (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D2DAE8902D;
 Fri, 25 Oct 2024 17:10:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729869025;
 bh=ndzeqRyiX7Rslx1SxtxTCmbFPOqL3fa7upeL+zW3BLI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RxJ2+g1RwjkTY4LLcJPQyCSwJgwi26ARnMOTPQ6t2jp4GMM5xsiH1hcC6p9b0fvVc
 8evF5QQgZotpJSE8dLyz/KfSkw6lYReSFebN9Tir5OjCrpuIOnFj4Yk0b2rOnHTPTA
 iSa1D58LpaLRG6Sfwdo4FNCTEN2yXocLihb5cqubFVNEgYIyK5GOaYgMcMUjikWTfK
 paIeazwv/Z7aDuhpyp2rCfO8DAIN5qLeVLgWUWywoKK536zOfAKOQdRG5YjDtXzSgF
 FUSni12wGHKZ72HpK+XXX/bnXlpRf1zbmkCGPhjok0pDBbvycjuuiMkwlxZ//VkvAU
 OMbpQncgyxhWw==
Message-ID: <e2d45889-33b1-438e-8872-f03a4c050c18@denx.de>
Date: Fri, 25 Oct 2024 17:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>,
 Fabio Estevam <festevam@denx.de>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20241024122735.893319-1-ravi@prevas.dk>
 <3fa7049d-4657-4cae-9ccf-fac1c62ce529@denx.de> <87o738psig.fsf@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87o738psig.fsf@prevas.dk>
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

On 10/25/24 9:10 AM, Rasmus Villemoes wrote:
> On Thu, Oct 24 2024, Marek Vasut <marex@denx.de> wrote:
> 
>> On 10/24/24 2:27 PM, Rasmus Villemoes wrote:
>>> Loading flash.bin using uuu fails when flash.bin does not have the
>>> right size.
>>> When flash.bin is loaded from some storage medium (sd card/emmc),
>>> SPL
>>> just loads some random garbage bytes from beyond what has been
>>> populated when flash.bin was written, but when loaded via uuu, SPL
>>> hangs waiting for the host to send the expected number of bytes. Which
>>> is (size of FIT image aligned to 0x1000)+CONFIG_CSF_SIZE. The
>>> alignment to 0x1000 is already done and is necessary in all cases
>>> because that's the exact expected location of the 32 byte IVT
>>> header. But the IVT+CSF blob tacked onto the end must be a total of
>>> CONFIG_CSF_SIZE.
>>> This is exactly the same fix as 89f19f45d650, except that this time
>>> around I don't know how to cleanly get CONFIG_CSF_SIZE.
>>> Fixes: bc6beae7c55f (binman: Add nxp_imx8mcst etype for i.MX8M
>>> flash.bin signing)
>>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>>> ---
>>> Heiko, can you check if this works for you?
>>> And if somebody wants to pick this up and knows how to get at
>>> CONFIG_
>>> values, feel free to fix up and take authorship. But perhaps it's not
>>> really configurable at all; imx8mimage.c has the value 0x2000
>>> hard-coded, so I don't think anything good could ever come from
>>> modifying CONFIG_CSF_SIZE. If so, the right fix is probably just to
>>> make that knob non-settable.
>>>    tools/binman/etype/nxp_imx8mcst.py | 2 ++
>>>    1 file changed, 2 insertions(+)
>>> diff --git a/tools/binman/etype/nxp_imx8mcst.py
>>> b/tools/binman/etype/nxp_imx8mcst.py
>>> index 8221517b0c4..9a1974cc522 100644
>>> --- a/tools/binman/etype/nxp_imx8mcst.py
>>> +++ b/tools/binman/etype/nxp_imx8mcst.py
>>> @@ -137,6 +137,8 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>>>            args = ['-i', cfg_fname, '-o', output_fname]
>>>            if self.cst.run_cmd(*args) is not None:
>>>                outdata = tools.read_file(output_fname)
>>> +            # fixme: 0x2000 should be CONFIG_CSF_SIZE
>>> +            outdata += tools.get_bytes(0, 0x2000 - 0x20 - len(outdata))
>>>                return data + outdata
>>>            else:
>>>                # Bintool is missing; just use the input data as the output
>>
>> I have to admit, I never really figured out this binman stuff, but
>> shouldn't the fix be also in tools/binman/etype/nxp_imx8mimage.py ?
> 
> No, why? That logic is all about generating the imx-specific header in
> front of SPL.bin, there's no CSF being generated.

This patch is modifying tools/binman/etype/nxp_imx8mcst.py which is the 
Code-Signing-Tool binman etype, the thing used for generating SIGNED 
images during HAB use.

Shouldn't this patch modify tools/binman/etype/nxp_imx8mimage.py which 
is the etype used when generating flash.bin itself ?

My understanding was that the problem Heiko reported was alignment of 
flash.bin , independently of it being signed or not ?

> Or maybe mkimage tacks
> on some dummy bytes, but then that's explicitly ignored by the signing
> step, I think that's what the
> 
>              signbase -= 0x40
>              signsize = struct.unpack('<I', data[24:28])[0] - signbase
>              # Remove mkimage generated padding from the end of data
>              data = data[:signsize]
> 
> is about, so the signing step generates a new IVT and a new (real) CSF
> for the SPL. And none of that matters for the size of the final
> flash.bin, because the FIT image is located far ahead at a fixed 0x58000
> position.
> 
>> And ... shouldn't it somehow use SetImagePos() ?
> 
> Again, why? I'm padding a blob (in this case the CSF data) to a required
> size before tacking it on. Exactly as the existing code does
> 
>              # Align fitImage to 4k
>              signsize = tools.align(len(data), 0x1000)
>              data += tools.get_bytes(0, signsize - len(data))
> 
> before writing out the (padded FIT image + 32 byte IVT) for cst to chew
> on and generate the CSF data.
> 
> This is all about ensuring that the FIT+IVT+CSF blob has (exactly) the size
> computed by board_spl_fit_size_align, which is
> 
>          size = ALIGN(size, 0x1000);
>          size += CONFIG_CSF_SIZE;
> 
> The 0x1000 part is done in the existing code, I'm just making sure that
> the data we append after that is exactly CONFIG_CSF_SIZE. The CSF blob
> itself is what is originally in outdata, and because the IVT must be
> included in the data which is signed, the IVT has already been appended
> after the 0x1000 padded FIT image; that's why the computation of the
> extra bytes ends up being a little complicated. [If we just appended a
> full CONFIG_CSF_SIZE bytes, the board would boot, but then uuu would be
> hanging while waiting to deliver the remaining part of the file, so the
> size should match exactly.]
> 
> I also don't grok the binman stuff, but there's really no separate image
> to set a "position" for, the csf blob (or ivt+csf blob) is not
> represented as its own image in the binman description.
It is probably best to let Simon comment on this.
