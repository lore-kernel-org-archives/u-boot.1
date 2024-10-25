Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D0FD10BEA
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 04:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F6268901D;
	Sat, 26 Oct 2024 06:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729916369;
	bh=bVhXU3AoVJ/DbWLNbOhZXOXw5F1UXPLCUP4fIOTn9c0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ty2Jvt8BvejLeS6YNfANilHqJoVx/GJt7XLAa/3FKQU+B7dbO3dJa+SJVUJtsGANs
	 ldzib/tuESmxWBRAoUyHOrktyXA/R7KzvnqK4SKxcmZ1HwrfwykXu+VjZSZ2z86A0x
	 rkEGpizX0gCu/wuR4OLqhGRxG5NZ14P91MY+42fP2q7oxmGdKlLQjZimp6euTCPMLg
	 H58dPOuTw8Wyvrdyz/jxPCWARyxZj0v0cbC/BZsRWhf7xpJ27kdaupsdQ+RcB0d+d1
	 NVGA9Ploi4LAHADpQMyvDwP7wKO9R2AhexkSo+d3UqqZQhFamzrvjvYd0AHWa+bvTS
	 wT0Qxnk1of6wA==
Received: from [127.0.0.1] (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6465488F92;
 Sat, 26 Oct 2024 06:19:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729916367;
 bh=bVhXU3AoVJ/DbWLNbOhZXOXw5F1UXPLCUP4fIOTn9c0=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=pqKEn6RYkIAQ2Ly5KYur49wWirH0oCAP0sCVyB8qsVn3/Nk1weneJJZGbEWGCpK7S
 tQDjCQq6K3TQNnPNH+cTz7+GEJO0XKGZFKe+HoOv3NGVGVc504EYouCm96Rw9XETaA
 kmPOEnUbgqD7RKDBTsjoJzasOVotdCwAstpD+ruXaoHoCW6Rw4n677VSbVC6rLkFoo
 Lws491hZzBtuxt8d1jwfeXmGxe+aHPeQbmsIszNOTNYcXXEtdueP5NtT+UEF4Xp9iC
 ZGeK37uQEDU7JV/BYpMT1RcHzt7pWL2ZLZJRWPfRgPLWxTRCLQefZjGe4GMgSdMG3x
 /t5E7fBxN0puQ==
Message-ID: <462eacaf-4aec-4c53-9a75-274cdfa00cc2@denx.de>
Date: Sat, 26 Oct 2024 01:02:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] imx8m: set sane default value for SPL_LOAD_FIT_ADDRESS
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Tim Harvey <tharvey@gateworks.com>, Heiko Schocher <hs@denx.de>
References: <20241024100145.841964-1-ravi@prevas.dk>
 <58754a24-eb1a-4306-a5de-e990539b1717@denx.de> <87seslprkk.fsf@prevas.dk>
 <5b9d07eb-14f1-4ac8-bc3f-69cdd8b87a73@denx.de>
 <20241024152019.GS4959@bill-the-cat>
 <9cbc17e9-3ed8-4bbe-b5c5-096b8a75747f@denx.de> <878quclglk.fsf@prevas.dk>
Content-Language: en-US
In-Reply-To: <878quclglk.fsf@prevas.dk>
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

On 10/25/24 10:41 AM, Rasmus Villemoes wrote:
> On Thu, Oct 24 2024, Marek Vasut <marex@denx.de> wrote:
> 
>> On 10/24/24 5:20 PM, Tom Rini wrote:
>>> On Thu, Oct 24, 2024 at 04:06:03PM +0200, Marek Vasut wrote:
>>>> On 10/24/24 3:18 PM, Rasmus Villemoes wrote:
>>>>> On Thu, Oct 24 2024, Marek Vasut <marex@denx.de> wrote:
>>>>>
>>>>>> On 10/24/24 12:01 PM, Rasmus Villemoes wrote:
>>>>>>> I enabled IMX_HAB on an imx8mp board, but even though I knew about the
>>>>>>> implementation, I forgot that I had to provide a sane value for
>>>>>>> SPL_LOAD_FIT_ADDRESS. The help text for IMX_HAB doesn't mention this
>>>>>>> implicit requirement, and there's no build-time warning; the default
>>>>>>> 0x0 value just ends up being returned from
>>>>>>> board_spl_fit_buffer_addr(), obviously resulting in a non-booting
>>>>>>> board.
>>>>>>> The existing imx8m* board configs that set a non-zero value
>>>>>>> currently
>>>>>>> all use 0x44000000. The actual value doesn't matter too much, but 0 is
>>>>>>> always wrong for imx8m platforms. So just use 0x44000000 as default
>>>>>>> for those platforms.
>>>>>>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>>>>>>> ---
>>>>>>>      boot/Kconfig | 1 +
>>>>>>>      1 file changed, 1 insertion(+)
>>>>>>> diff --git a/boot/Kconfig b/boot/Kconfig
>>>>>>> index 940389d4882..72d1f69afcd 100644
>>>>>>> --- a/boot/Kconfig
>>>>>>> +++ b/boot/Kconfig
>>>>>>> @@ -231,6 +231,7 @@ config SPL_LOAD_FIT
>>>>>>>      config SPL_LOAD_FIT_ADDRESS
>>>>>>>      	hex "load address of fit image"
>>>>>>>      	depends on SPL_LOAD_FIT
>>>>>>> +	default 0x44000000 if ARCH_IMX8M
>>>>>> This only applies to HAB , for non-HAB the fitImage can be loaded at
>>>>>> arbitrary location, do you need:
>>>>>>
>>>>>> default 0x44000000 if ARCH_IMX8M && IMX_HAB
>>>>>>
>>>>>> right ?
>>>>>
>>>>> On IMX8 without HAB, the value is not used at all AFAICT (otherwise the
>>>>> value of 0x0 would have caused trouble already). I don't see the harm of
>>>>> setting some sane value that's actually within DRAM space independent of
>>>>> HAB.
>>>>>
>>>>> Making the default depend on IMX_HAB has the UX problem that if I do
>>>>> "make imx8mp_evk_defconfig", then go about tweaking stuff, then do "make
>>>>> menuconfig" and enable IMX_HAB, SPL_LOAD_FIT_ADDRESS already has the
>>>>> bogus 0x0 value and nothing forces or asks that to be changed. Making the
>>>>> default depend only on SOC (or SOC family or whatever IMX8M is in this
>>>>> context) makes that problem go away.
>>>> Looking at this closely, common/spl/spl_ram.c does make use of
>>>> CONFIG_SPL_LOAD_FIT_ADDRESS too, so I think yes, we should have a default
>>>> for this.
>>>>
>>>> iMX6 should have 0x14000000
>>>> iMX7 should have 0x84000000
>>>> iMX8M should have 0x44000000
>>> These differ, slightly, from the value used in CONFIG_SYS_LOAD_ADDR.
>>> Could that not be used (and the overall option changed to default
>>> SYS_LOAD_ADDR ?
>> If I recall it right, no ... these addresses are where the fitImage is
>> loaded and where HAB does its authentication stuff on the fitImage,
>> that address has to be fixed and well aligned.
> 
> Yes. Fixed certainly; I'm not aware of any specific aligment
> requirements, but I can't imagine it would need more than 0x1000
> alignment, and we'd never use a fixed address less aligned than that
> anyway.
> 
>> The SYS_LOAD_ADDR is
>> the destination address where the u-boot-nodtb.bin is copied from the
>> fitImage AFTER the fitImage was authenticated.
> 
> No, I don't think so. Isn't u-boot-nodtb.bin just copied to the value of
> the load= property in the FIT, which is CONFIG_TEXT_BASE, aka 0x40200000
> in the imx8mp case.

Ah, right, thanks for keeping an eye on this.

> As for Tom's suggestion to make SPL_LOAD_FIT_ADDRESS simply default to
> SYS_LOAD_ADDR: Perhaps, it would certainly be better than 0x0 which is
> almost always bogus. I think it would work for imx8mp_evk, though
> 0x40200000 and 0x40480000 are only 2.5MiB apart. But I have no idea how
> many boards would be affected by such a change or how many random ad hoc
> other CONFIG_FOO_THIS_OR_THAT exists that might or might not clash or
> overlap. IOW, I'm not signing off on such a patch... But it could be
> interesting to a least let CI chew on that to see if it's a complete
> non-starter.

How about introducing a default set of text bases and load addresses, 
with the right spacing, and then start removing the custom ones from 
board configs ?
