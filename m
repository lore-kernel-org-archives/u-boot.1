Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087D9CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 21:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B80908467F;
	Wed, 13 May 2026 23:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="hb8llVtv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A6F8469F; Wed, 13 May 2026 20:22:50 +0200 (CEST)
Received: from mxd-3-706.seznam.cz (mxd-3-706.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 099FC84659
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 20:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-85fb448c55-l247v
 (smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
 id 180f9f904301cbf919a653ce; Wed, 13 May 2026 20:22:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778696565; bh=gzhdNYZHWq9/bwrFZ+HfxtwAzdgWl0iu1yDJeXP3LfY=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=hb8llVtvQ1/+Sl6abNRwqiCn7egQ73fbHlP/OhCjO3u+x+s4SBrchBAna0AEoUTWN
 HsC6Y935HYMPu9XXEDTjQ7DbUh38zZfLpX8hVECizC5thouAQIRG1N8PPM84cLV5a6
 NlJ6ZYRA0Nou0pck1qi8W1NBod0XwDxQS6977SnFiqhdSRke8iJSCgkBpBvde+rXK1
 iZzYmty6gIbSExxvwDA/DyBRw8ZbZdThhGlBkLM90znpUbjoL6achSwp+TVMdceVa8
 c0UpLvk0hE3ygxo93yNNAQyslGCT6JAr2UwH4B+tcj9RNOu52U6+atLzcQWmk4dRgz
 CRguHTQ/k44gQ==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-697b6bbd6b-pfjd2 (szn-email-smtpd/2.0.72) with ESMTPA
 id 944d11ff-3c63-4935-ae1d-80cfddc9e6f9;
 Wed, 13 May 2026 20:22:14 +0200
Message-ID: <fbd17827-d9b9-4e6c-91e7-67ec41580182@seznam.cz>
Date: Wed, 13 May 2026 20:22:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] misc: qcom_geni: Add minicore support
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260416053928.2834699-5-varadarajan.narayanan@oss.qualcomm.com>
 <37198853-5546-405f-90e3-54ee98e15744@seznam.cz>
 <agShZibHyuPCI8JA@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <agShZibHyuPCI8JA@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 13 May 2026 23:36:45 +0200
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

Hi,

On 5/13/26 18:05, Varadarajan Narayanan wrote:
>>> +static u8 cfg_reg_idx[] = {
>>> +	/* 0 to 18 */
>>> +	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
>>> +	/* 64 to 113 */
>>> +	64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
>>> +	81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
>>> +	98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
>>> +	112, 113,
>>> +};
>> This [1] says "Configure GENI primitive table.", and I have a sneaky suspicion
>> that only the first part is actually that (iirc the Linux driver even errors
>> out on writes to anything >256? I don't see any bound checking in u-boot,
>> which is worrying...).
> I see that the same loop is used both in U-Boot [1] and Linux [2].
Hm, must have misremembered...
>> Also, these are registers with names.
> For some reason, this space is arranged as 2 blocks.
> 	1.  0 -  18 regs, from base to base+0x4c
> 	2. 64 - 113 regs, from base+0x200 to base+0x2c4
>
> These registers have the name GENI_CFG_REG_n with 'n' ranging
> from 0 to max as aliases and that has been used. Since we are
> dumping the content to these registers don't think names are
> needed here. If the registers were in a single block instead of
> the above arrangment it is just a memcpy_toio().
I guess it's possible that the register names are weird like that,
but the word "primitives" has to come from somewhere... Maybe the
bitfields are named but the registers are not for some reason?

Ideally the whole design would be less opaque, but that's not really
feasible with having to support the existing firmware format :/

I suppose even if that wasn't the case, it would be wasteful
to assemble the bitfields at runtime, compared to just or-ing
them together at compile time maybe with some macros.
So other than the weird index-value indirection, and magic
hex values instead of defines or'd together (and/or macro'd),
I guess this design isn't as wild as it originally seemed to me.
>
>> Since the firmware format can't be changed and this just mimics it, I'd say
>> it would make sense to improve that comment to explain what it's actually
>> doing (since it's setting more than just primitives, whatever that means),
> We are not privy to the information that is held in this array.
> We just get this code from the hardware block owners.
Yeah, that's a very downstream approach that I'd prefer to see less off
in Qualcomm's upstream efforts... Not sure if it would help here
to be fair, but neither the person writing the drivers nor
the reviewer having access to hardware documentation has led
to unfortunate outcomes in the past and I really hoped
that this wouldn't be an issue with first party upstream work.

To be clear, I'm sure this is just me, the maintainers are probably
fine with magic values (at least in this context), though if
the bitfield names are available to you maybe constructing the array
using defines and macros wouldn't be the worst idea... then again,
I'm sure there's a point at which the maintainers will prefer lower
verbosity even if the alternative would get rid of magic values.
>
>> and if these indices are going to be in this array anyway, why not replace
>> them with defines of the register names? Or are those SoC-specific,
>> seems that whatever ones the driver is accessing by name are pretty
>> stable at least.
> Registers accessed by name are not part of this block.
>
> [1] https://github.com/u-boot/u-boot/blob/master/drivers/misc/qcom_geni.c#L204
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/qcom/qcom-geni-se.c#n1251
>
> Thanks
> Varada
>
>> [ . . . ]
