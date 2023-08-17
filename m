Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ADEC3DA4D
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 16:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0305D86B5B;
	Thu, 17 Aug 2023 18:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KtQjVlO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24CF586B5B; Thu, 17 Aug 2023 18:03:10 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id F278886B53
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 18:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from [192.168.1.68] (d172-218-241-181.bchsia.telus.net
 [172.218.241.181])
 by linux.microsoft.com (Postfix) with ESMTPSA id C8B32211F7B5;
 Thu, 17 Aug 2023 09:03:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8B32211F7B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1692288185;
 bh=GPTRKL8kynTWZSqZ2YQNo2JfhG+xPLbYyjP4euwk85A=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=KtQjVlO5sAXLMGtpe5htLfrXI1s95Iznnr7/LFuo+MEW9dObc22aS0BanmYxPbwbP
 fX+ufOlONshnsMmNEQM9IgOwqSoR7g4Kv5og9bmykwAjNWeeusmXx/tn5ttuAv6BIM
 gDRyJAfUujnXFXIlG3lw05bpCcx6Be4k20Mhex44=
Subject: Re: [PATCH 1/3] fdt: common API to populate kaslr seed
From: Sean Edmond <seanedmond@linux.microsoft.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dhananjay Phadke <dphadke@linux.microsoft.com>,
 Chris Morgan <macromorgan@hotmail.com>
References: <20230804233357.65214-1-seanedmond@linux.microsoft.com>
 <20230804233357.65214-2-seanedmond@linux.microsoft.com>
 <CAPnjgZ2fYDcoYw3XOS4roL3yWVrgyVwKBNS9KEXOh_NHOtPhCQ@mail.gmail.com>
 <2e6afa29-53a1-38d4-d376-045669b931cb@linux.microsoft.com>
 <CAPnjgZ1vZKO7OFwnmQaOhm0ivxYC1BzYEv0tnj8asvDchEb-uw@mail.gmail.com>
 <a0e2fd89-accf-78b5-2a9a-4a19b72b976e@linux.microsoft.com>
 <CAPnjgZ33GKr1QosmeFUMPmrFYXE03WgvuHzYrFb2U7se2-6eaw@mail.gmail.com>
 <445eea7b-c9e4-b475-82f5-541d4d7b8fbc@linux.microsoft.com>
 <CAPnjgZ2np6-bo8ZTPUcmbB06N-PKeQ9U5ZG8Mw=nk0pw-barZw@mail.gmail.com>
 <9dbad905-7a72-f7e8-d473-2140a221f102@linux.microsoft.com>
Message-ID: <322e6148-3283-f5dd-4c51-7927b5856b7e@linux.microsoft.com>
Date: Thu, 17 Aug 2023 09:03:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9dbad905-7a72-f7e8-d473-2140a221f102@linux.microsoft.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 2023-08-15 10:46 a.m., Sean Edmond wrote:
>
> On 2023-08-15 7:44 a.m., Simon Glass wrote:
>> Hi Sean,
>>
>> On Mon, 14 Aug 2023 at 13:12, Sean Edmond
>> <seanedmond@linux.microsoft.com> wrote:
>>>
>>> On 2023-08-12 6:09 a.m., Simon Glass wrote:
>>>> Hi Sean,
>>>>
>>>> On Fri, 11 Aug 2023 at 11:14, Sean Edmond 
>>>> <seanedmond@linux.microsoft.com>
>>>> wrote:
>>>>> On 2023-08-09 6:49 p.m., Simon Glass wrote:
>>>>>> Hi Sean,
>>>>>>
>>>>>> On Wed, 9 Aug 2023 at 16:35, Sean Edmond 
>>>>>> <seanedmond@linux.microsoft.com>
>>>> wrote:
>>>>>>> On 2023-08-08 7:03 p.m., Simon Glass wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On Fri, 4 Aug 2023 at 17:34, <seanedmond@linux.microsoft.com> 
>>>>>>>> wrote:
>>>>>>>>> From: Dhananjay Phadke <dphadke@linux.microsoft.com>
>>>>>>>>>
>>>>>>>>> fdt_fixup_kaslr_seed() will update given FDT with random seed 
>>>>>>>>> value.
>>>>>>>>> Source for random seed can be TPM or RNG driver in u-boot or sec
>>>>>>>>> firmware (ARM).
>>>>>>>>>
>>>>>>>>> Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
>>>>>>>>> ---
>>>>>>>>>      arch/arm/cpu/armv8/sec_firmware.c | 32
>>>> +++++++------------------------
>>>>>>>>> common/fdt_support.c              | 31
>>>> ++++++++++++++++++++++++++++++
>>>>>>>>> include/fdt_support.h             |  3 +++
>>>>>>>>>      3 files changed, 41 insertions(+), 25 deletions(-)
>>>>>>>> We need to find a way to use the ofnode API here.
>>>>>>>>
>>>>>>>>> diff --git a/arch/arm/cpu/armv8/sec_firmware.c
>>>> b/arch/arm/cpu/armv8/sec_firmware.c
>>>>>>>>> index c0e8726346..84ba49924e 100644
>>>>>>>>> --- a/arch/arm/cpu/armv8/sec_firmware.c
>>>>>>>>> +++ b/arch/arm/cpu/armv8/sec_firmware.c
>>>>>>>>> @@ -411,46 +411,28 @@ int sec_firmware_init(const void
>>>> *sec_firmware_img,
>>>>>>>>>      /*
>>>>>>>>>       * fdt_fix_kaslr - Add kalsr-seed node in Device tree
>>>>>>>>>       * @fdt:               Device tree
>>>>>>>>> - * @eret:              0 in case of error, 1 for success
>>>>>>>>> + * @eret:              0 for success
>>>>>>>>>       */
>>>>>>>>>      int fdt_fixup_kaslr(void *fdt)
>>>>>>>> You could pass an oftree to this function, e.g. obtained with:
>>>>>>>>
>>>>>>>> oftree_from_fdt(fdt)
>>>>>>> The common API I added is fdt_fixup_kaslr_seed(), which was 
>>>>>>> added to
>>>>>>> "common/fdt_support.c".
>>>>>>>
>>>>>>> There are 3 callers:
>>>>>>> sec_firmware_init()->fdt_fixup_kaslr_seed()
>>>>>>> do_kaslr_seed()->fdt_fixup_kaslr_seed()
>>>>>>> image_setup_libfdt()->fdt_tpm_kaslr_seed->fdt_fixup_kaslr_seed()
>>>>>>>
>>>>>>> I think the ask is to create a common API that uses the ofnode API.
>>>> So,
>>>>>>> instead of fdt_fixup_kaslr_seed() I can create
>>>>>>> ofnode_fixup_kaslr_seed()?  Where should it live?
>>>>>> If you like you could add common/ofnode_support.c ?
>>>>>>
>>>>>> But it is OK to have it in the same file, I think.
>>>>>>
>>>>>>> Are you also wanting
>>>>>>> the callers (eg. fdt_tpm_kaslr_seed, fdt_fixup_kaslr) to take 
>>>>>>> oftree as
>>>>>>> input too?
>>>>>> So far as you can go, yes. Also you may want to pass an ofnode (the
>>>>>> root node) so that things can deal with adding their stuff to any
>>>>>> node.
>>>>>>
>>>>>> Regards,
>>>>>> Simon
>>>>> I re-worked the API to use the ofnode API and tested it on our 
>>>>> board.  I
>>>>> was required to explicitly enable CONFIG_OFNODE_MULTI_TREE in 
>>>>> order for
>>>>> it to work.
>>>>>
>>>>> I have concerns this will create a breaking change for users of the
>>>>> kaslr fdt touch up.  In our case, if CONFIG_OFNODE_MULTI_TREE 
>>>>> isn't set,
>>>>> the control FDT gets touched up, not the kernel FDT as required.
>>>>> Everything runs to completion, but 
>>>>> "/proc/device-tree/chosen/kaslr-seed"
>>>>> isn't present after boot.
>>>>>
>>>>> Am I missing something?  Perhaps there's a way to modify the default
>>>>> value for CONFIG_OFNODE_MULTI_TREE to ensure this works 
>>>>> out-of-the-box?
>>>>>
>>>> Yes, perhaps we should enable this when fixups are used? Is there a 
>>>> way to
>>>> tell?
>>> I don't think there's a way to tell unfortunately.  Fixups are always
>>> called if OF_LIBFDT is enabled, and if an FDT is found during bootm.
>>>
>>> I'm having trouble understanding the intention of the current default
>>> for OFNODE_MULTI_TREE:
>>>       default y if EVENT && !DM_DEV_READ_INLINE && !DM_INLINE_OFNODE
>>> Could we simplify to this?
>>>           default y if !OF_LIVE
>> I don't think it will build if inlining is used, but I can't remember...
> I wasn't able to break this by turning off DM_DEV_READ_INLINE, and 
> enabling OFNODE_MULTI_TREE/SPL_DM_INLINE_OFNODE/TPL_DM_INLINE_OFNODE. 
> Perhaps things have changes since this was created.
>> The EVENT thing is because there is an of-fixup event, which was the
>> original thing using ofnode fixups.
>>
>> I wonder what sort of size increment this will create with !OF_LIVE ?
>
> With default (OFNODE_MULTI_TREE is not set):
>
> textdatabssdechex filename
>
> 9380135536846752 1040133fdf05 u-boot/u-boot/u-boot
>
>
> With !OF_LIVE (OFNODE_MULTI_TREE is set with OFNODE_MULTI_TREE_MAX=4):
>
> seanedmond@ovlvm106:~/code/QEMU/qemu_uboot$ sizeu-boot/u-boot/u-boot
>
> textdatabssdechex filename
>
> 9390165536846752 1041136fe2f0 u-boot/u-boot/u-boot

Sorry about the formatting... let's try that again.

With default (OFNODE_MULTI_TREE is not set):

text: 938013
data: 55368
bss:46752
dec: 1040133
hex: fdf05

With !OF_LIVE (OFNODE_MULTI_TREE is set with OFNODE_MULTI_TREE_MAX=4):

text: 939016
data: 55368
bss: 46752
dec: 1041136
hex: fe2f0

>
>>
>>>> Also, we should make it return an error when attempting to use a tree
>>>> without that option enabled. I would expect oftree_ensure() to 
>>>> provide that?
>>> I'll add a check.
>> OK thanks.
>>
>> Regards,
>> Simon
>>
>>
>
>
