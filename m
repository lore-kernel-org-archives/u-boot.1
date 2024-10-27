Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B52D1356F
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 062D789058;
	Sun, 27 Oct 2024 17:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730045373;
	bh=M4AXlrkuHEfQGn04cfPPFmX5QxXztKAIsGzIHCdDwDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UrgcmCLPHZQXmiP1MsojF4Asf0cSpTy6ORQDjrhyR9wuBrBXP7FC52bKZ4qskx6Y4
	 GVP77gqlyEdTydWlJB7fEyKkEhIkwZKtjZXPdLslV2WSrPx2CyPvYxq9xpL6TeIvOF
	 qWBWHCYg5rneJqDs/qH7HmvIusXDC0zauHWBrHx+YMDLqf4O9QrWUCJgQc7wcTfEkG
	 6PK9rD1GHVJQfV2ejPexpM+kQ0uz8ZHg6eXMifMR2nn+MmFwkGLeUazVKQbDDRlW1W
	 YOblv4FKKyyvHslaoNYAOR4FsP9xfr3TSzpYi1JRUB+uQjhgLJfjV8Pg8SOu3SXzg7
	 1s9XQRE9mFCmQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BB46E881A5;
 Sun, 27 Oct 2024 17:09:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730045371;
 bh=M4AXlrkuHEfQGn04cfPPFmX5QxXztKAIsGzIHCdDwDk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ig7JLMuzUolg2L8LpuXje0OUJOkvkUG+lyCHHiW2G2m03Gn9N9UhxJLkh2G5I8n94
 V46yDiib/O9NvoAgwAmReujxb0fjWk1JmWU283Egl+29jHMZp8hZPyzxwjwoul9zvK
 u7RSa3cP8EoUMwg/JTa6/fceqBbtBbeAN09bDYI5rqSQNe9diyhR/hKnDigFiQt26T
 ztVBm4u0YkFRnZdy1v8ThCRC0/zafcv8C7b+mn6cA9jbHIEH6wxTmOE5deSgDO72is
 fgDBYNfroVW6Ok2qU9uXSqfi80lg2MtmOduU6OQFtFZ44TKg/7LDgEx9a54+hgQ35M
 kZ+TidDWNtc0w==
Message-ID: <8404049c-85df-4c72-bf3c-bf83d143b8b9@denx.de>
Date: Sun, 27 Oct 2024 16:25:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] ARM: socfpga: add Mercury+ AA1 SoM support
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 michal.simek@amd.com, jit.loon.lim@intel.com, barnas@google.com
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
 <20241013143232.2090645-3-l.rubusch@gmail.com>
 <ce29c957-4198-4947-b7de-7e10ed385eab@denx.de>
 <CAFXKEHZLwbU=w4LH4iiZeo4ycwOKjgi5YZesHHgxzy6Ac+TOUA@mail.gmail.com>
 <5ba375a1-cf1d-463c-8590-3ddf46c47f3e@denx.de>
 <CAFXKEHZ4+zPw7LuNYK2QZYOQj4v=1UMuf29CSGAEibSOWU48SQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFXKEHZ4+zPw7LuNYK2QZYOQj4v=1UMuf29CSGAEibSOWU48SQ@mail.gmail.com>
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

On 10/23/24 10:10 PM, Lothar Rubusch wrote:

Hi,

sorry for the late reply.

>>>> Can this be generated using binman instead ?
>>>
>>> This would a oportunity for me to learn the binman tool. Great idea! I
>>> need to read a bit more on binman to get a better understanding. I'll
>>> give it a try and let you know. Thank you.
>>
>> This commit might help:
>>
>> 5fccc2891e28 ("ARM: dts: stm32: Generate u-boot.itb using binman on DH
>> STM32 DHSOM")
>>
> 
> I face a problem here. First, to apply binman stances in the .dtsi and
> integrating it as -u-boot.dtsi is very interesting and I actually like
> the solution to bind everything togerther in this way.
> 
> But, I face the situation where the very design specific bitstream(s)
> for the FPGA are actually not supposed to be upstreamed. Having u-boot
> binaries and bitstream as .itb separate, allows to build the u-boot
> part even w/o the bitstream, i.e. the u-boot setup can be quite
> generic, can be tested and verified building. Is this still possible
> if binman requires it as binary blob?

I believe so, U-Boot CI does use binman to build e.g. imx8m targets 
which do require extra firmware, but during the CI build that extra 
firmware is replaced by blank empty files by binman. It does print some 
sort of warning that the files are missing ... try e.g. 'make 
imx8mp_dhcom_pdk3_defconfig ; make' and you should see the behavior 
locally too.

> On the otherhand it allows to
> wrap the FPGA logic and exchange the .itb separately when developing a
> design w/o the need to modify the bootloader.
> 
> So, I'd like to hear your opinion on that. Would the .itb appraoch be
> acceptable in this case? Is there still a better way? Does it make
> sense to make a separate binman setup instead?

The SPL .its handling was dropped now that the last user was switched to 
the binman method, but I hope the above will let you switch to the 
binman method too ?

8efc954fc77e ("Makefile: Drop SPL_FIT_SOURCE support")
