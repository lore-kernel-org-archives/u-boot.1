Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57B0C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 17:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 641B4801BE;
	Fri,  7 Feb 2025 18:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Bdn8ePOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7424801DE; Fri,  7 Feb 2025 18:27:57 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E12F4800B3
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 517HRmNi3043043
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Feb 2025 11:27:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738949268;
 bh=tOedeiyIZeCXzFBPlqp9bpQ80bfQ2jMFFUtC76jAAv8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Bdn8ePOSO4UabALxnNgcY8vTaGzXeBOcOdz2QKBBxoqPF//KxG6HQPjtvKAFR7uOO
 cZsrfBdgdsRzaedg4ZpYoFAfH+zoVSYjh2mLHkHpdwwE7Y+hvMUWLY/OhU0DOwPhWX
 3Q6Vjkv/sWoZ4pQ/Ej8YfCTuRJevyT/ue16fsV08=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 517HRmgY024449
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Feb 2025 11:27:48 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Feb 2025 11:27:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Feb 2025 11:27:48 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 517HRlEl002203;
 Fri, 7 Feb 2025 11:27:47 -0600
Message-ID: <3bb7e185-3969-47c1-9cdd-f0293aa090a5@ti.com>
Date: Fri, 7 Feb 2025 11:27:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/8] arm: dts: k3-j784s4-binman.dtsi: Clean up and
 templatize boot binaries
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
 <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20250106-b4-upstream-j742s2-v2-0-42d6129ce333@ti.com>
 <20250106-b4-upstream-j742s2-v2-2-42d6129ce333@ti.com>
 <e815500f-e4a0-4deb-ae33-f98ca7021503@ti.com>
 <20250204044332.rte6wrki2i54wqpn@uda0497581>
 <4b1a9385-4a98-4c92-9a55-395f1a0fe8b9@ti.com>
 <20250205055045.qeam5kvhdlxhow6y@uda0497581>
 <9cc2f4d3-f8a0-4452-8e9e-df42e4458d5d@ti.com>
 <20250206105247.7lx5etpm3nhwgthx@uda0497581>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250206105247.7lx5etpm3nhwgthx@uda0497581>
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

On 2/6/25 4:52 AM, Manorit Chawdhry wrote:
> Hi Andrew,
> 
> On 09:35-20250205, Andrew Davis wrote:
>> On 2/4/25 11:50 PM, Manorit Chawdhry wrote:
>>> Hi Andrew,
>>>
>>> On 09:43-20250204, Andrew Davis wrote:
>>>> On 2/3/25 10:43 PM, Manorit Chawdhry wrote:
>>>>> Hi Andrew,
>>>>>
>>>>> On 14:44-20250203, Andrew Davis wrote:
>>>>>> On 1/6/25 3:34 AM, Manorit Chawdhry wrote:
>>>>>>> From: Neha Malcom Francis <n-francis@ti.com>
>>>>>>>
>>>>>>> Clean up templatized boot binaries for j784s4 soc. This includes
>>>>>>> modifying the k3-j784s4-binman.dtsi to use SPL_BOARD_DTB,
>>>>>>> BOARD_DESCRIPTION and UBOOT_BOARD_DESCRIPTION from the files that
>>>>>>> include it to further reuse code.
>>>>>>>
>>>>>>> k3-j784s4-binman.dtsi will contain only templates. Only required boot
>>>>>>> binaries can be built from the templates in the boards' respective
>>>>>>> -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allows
>>>>>>> clear distinction between the SoC common stuff vs. what is additionally
>>>>>>> needed to boot up a specific board.
>>>>>>>
>>>>>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>>>>>> [ Do it only for j784s4 ]
>>>>>>> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
>>>>>>> ---
>>>>>>>      arch/arm/dts/k3-am69-sk-u-boot.dtsi    | 123 +++++++++++++++++++++++++++------
>>>>>>>      arch/arm/dts/k3-j784s4-binman.dtsi     | 116 +++++++++----------------------
>>>>>>>      arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  75 ++++++++++++++++++++
>>>>>>>      3 files changed, 206 insertions(+), 108 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
>>>>>>> index 4a82d2fd222669c4b390d4d877bc15329eab8894..adcd89b18ba9df9c72bf2e0fb0600b2bc7d1658c 100644
>>>>>>> --- a/arch/arm/dts/k3-am69-sk-u-boot.dtsi
>>>>>>> +++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
>>>>>>> @@ -1,10 +1,109 @@
>>>>>>>      // SPDX-License-Identifier: GPL-2.0-only
>>>>>>>      /*
>>>>>>> - * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
>>>>>>> + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
>>>>>>>       */
>>>>>>> +#define SPL_BOARD_DTB "spl/dts/ti/k3-am69-sk.dtb"
>>>>>>> +#define BOARD_DESCRIPTION "k3-am69-sk"
>>>>>>> +#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM69 board"
>>>>>>> +
>>>>>>>      #include "k3-j784s4-binman.dtsi"
>>>>>>> +#if defined(CONFIG_CPU_V7R)
>>>>>>> +
>>>>>>> +&binman {
>>>>>>> +	tiboot3-am69-hs {
>>>>>>> +		insert-template = <&tiboot3_j784s4_hs>;
>>>>>>> +		filename = "tiboot3-am69-hs-sk.bin";
>>>>>>
>>>>>> I think there might be some confusion around the name of this file.
>>>>>> The format is tiboot3-<SYSFW name>-<SYSFW board config>.bin.
>>>>>>
>>>>>> <SYSFW name> is the name of the SYSFW binary that is packaged
>>>>>> with this file, so should be "j784s4-hs" as this uses:
>>>>>> "ti-fs-firmware-j784s4-hs-enc.bin".
>>>>>>
>>>>>> <SYSFW board config> is the name of the board configs used.
>>>>>> For both TI EVMs and SK boards there is just one common board config
>>>>>> we use call "evm". Other board vendors can use custom board configs,
>>>>>> take Toradex for example, they have a different board config which they
>>>>>> call "verdin" and they then correctly use that label for their tiboot3
>>>>>> filename[0]. We should follow our own standard, use "evm" here.
>>>>>>
>>>>>> Andrew
>>>>>>
>>>>>> [0] https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
>>>>>
>>>>> The following is not some mistake and an intended change honestly.. we
>>>>> use am69_sk_r5_defconfig as the defconfig name and that giving j784s4 as
>>>>> the binary name is just counterintuitive, the naming should be based on
>>>>> the defconfig IMO to avoid confusions.
>>>>>
>>>>
>>>> The binary name does not need to match the marketing name of the board,
>>>> otherwise we could go name u-boot.img to append a board name too, etc.
>>>>
>>>> tiboot3.bin is different as we can have one build producing the same
>>>> SPL but with different SYSFW blobs appended. To deal with this we
>>>> append the name of the SYSFW blob to the filename. The SYSFW used here
>>>> is named "j784s4-hs", so What happens if we get a new SYSFW blob with the
>>>> name "am69-hs" but you already named this file "tiboot3-am69-hs-sk.bin"
>>>> even though it includes "j784s4-hs" SYSFW not "am69-hs" SYSFW..
>>>>
>>>> This filename is meant to identify the SYSFW name, not the defconfig
>>>> used. It was already correct, no need to change the standard here.
>>>
>>> The standard has existed since we had a single tiboot3.bin packing multiple
>>> DTBs and working on AM69 and J784S4 (And similarly for other devices). At
>>> that time there was no other choice than to use the SYSFW name for
>>> identifying the binary - as what else could we use anyway?
>>>
>>
>> It goes back way further than that, this started back when the SYSFW blob
>> was appended to tiboot3.bin by an external tool[0] (I know you know this
>> but giving context for anyone else trying to follow along here).
>>
>>> But now, the binaries aren't compatible with each other packing different
>>> DTBs, and are not the same. The following should've been done during the
>>> time when the defconfigs' were split itself but at that time templating was
>>> still being sorted out so we could'nt even make HS-FS as the default that
>>> time for AM69 ( which is the default device considering AM69 ) - we don't
>>> even make GP and even that was being built for that - doesn't mean it was
>>> the right thing to do.
>>>
>>
>> The boot binaries produced by different defconfigs are almost never
>> compatible with other devices. Sometimes yes they can be booted
>> across a couple very similar boards but this is rare. So nothing
>> new here.
>>
>>> We should keep the "standard" just because it was historical doesn't
>>> make sense to me. U-boot is an entity and there is no relation
>>> whatsoever to keep the SYSFW name in the tiboot3 when they aren't even
>>> compatible anymore with other changes around - it should rather be based
>>> on what am building "in" U-boot.
>>>
>>
>> We do not name the binaries based on what device they are meant to
>> boot on. This has never been the case, u-boot.img is always just
>> named that, it doesn't change based on board. The name we append
>> to tiboot3.bin is *not* there to let folks know what device it is
>> compatible with nor what defconfig built it. In a perfect world
>> we would not append anything, just produce one "tiboot3.bin" no
>> matter what device/board you build for same as u-boot.img.
>>
>> The reason for appending any name at all is we have a couple different
>> versions of SYSFW that need appended, so we name the resulting files
>> after the name of the SYSFW blob appended to it.
> 
> Ughh.. different defconfig's having some other defconfig's name in
> output is not something am okay with but I get what you are saying as to
> why prefix only SYSFW name onto it. But if that is the argument then even
> keeping the filenames like tiboot3-hs-fs.bin instead of
> tiboot3-j784s4-hs-fs-evm.bin also would've made sense.
> 

This I can agree with. Really the only part that matters anymore
is the "gp" vs "hs-fs" vs "hs-se" part. The SYSFW blob used
for any single defconfig build will always be the same, so no
need to append it to the produced boot artifact filename. Same
is true for the board config, -evm could be dropped if we really
wanted.

> Having a J784S4-based filename when building AM69 defconfig is not
> something am looking forward to but I don't see a way to move to the
> generic filenames that I mentioned. That would end up in a major impact
> than the initial plan of changing the name of all the SK platforms that
> were just introduced in ~1 year timeline.
> 

Right, this is the issue, it will probably cause some churn for older
platforms where the full name is already established in downstream
tooling and distro build systems that consume these.

For new platforms, we don't have GP SYSFW blobs, and the we are
working to combine the HS-FS and HS-SE blobs. So this problem
should go away soon anyway. Even now, 99% of people should just use
"tiboot3.bin" produced by the build as it should be a symlink to
the most commonly used SoC type used on that board.

The only time one would need to use something else is when they are
using one of the rare boards that started out GP then switched to HS-FS
mid-production run, (basically just SK-AM64/SK-AM62 for Sitara IIRC).
Boards like the BeaglePlay are all GP, and all new SK-AM62 are all HS-FS,
and so now that we split their defconfigs, we don't really need to have
mixed SYSFW blobs at all for them like we used to. BeaglePlay could just
produce one file named "tiboot3.bin" and it would always work.

> So the only way I could think about was changing these SK and those
> devices name which got split.
> 
>>> in multiple places and it will have a cascading effect to change it at
>>> this stage but if you are worried about cascading effect; My suggestion
>>> would be to "fix" it now instead as the platforms are getting mature and
>>> then it'd be too late to do it and I don't want seeing
>>> am69_sk_r5_defconfig building tiboot3-j784s4-hs-fs-evm.bin 10 years down
>>> the line...
>>>
>>
>> I'm not saying we keep this standard only for historical reasons, I'm
>> perfectly fine with breaking conventions when it makes sense. Here
>> it breaks downstream projects that pick up these binaries *and* it
>> doesn't make sense.
>>
>>> PS: it's still not too late if you are thinking that given the split for
>>> AM69 happened just a year back and the other such splits have hardly
>>> been there for around 8 months so we haven't even gotten the time to
>>> streamline it.
>>>
>>
>> A cycle or two might not be too late in some cases, but a year is
>> pushing it. This standard has been around for +5 years at least.
> 
> PS: Not that it matters now but the problems started happening after the
> introduction of SKs; so the cycle I would consider for ~1 year only
> instead of the 5 years timeline as this is a new problem now.
> 
>> To break it now would mean changing boards like the the Beagle AI64
>> for instance, since it produces tiboot3-j721e-gp-evm, but it isn't
>> an "evm", nor an "sk", it is a "beaglebone". And it doesn't use
>> the J721e, it uses the TDA4VM SoC, etc..
> 
> Also, having hardcoded -evm at the end also doesn't make sense. That's
> not something that is coming from SYSFW as well. But if you are signing
> up on the names being like this and everyone else is okay as well then
> I'll chuck the following change.
> 
> Just to clarify, wasn't going for the marketing names like TDA4VM. Just
> based on defconfigs.
> 

Sure, I was just making the point that defconfig name doesn't match
SoC either, so a little bit of confusion is going to happen no
matter what we do in that case. No reason to map defconfigs names
into boot artifacts names when the defconfigs are not named well
to begin with.

Andrew

> (j721e_beagpleboneai64_r5_defconfig -> tiboot3-j721e-hs-fs-beagleboneai64.bin)
> (am68_sk_r5_defconfig -> tiboot3-am68-hs-fs-sk.bin)
> 
> Regards,
> Manorit
> 
>>
>> Andrew
>>
>> [0] https://git.ti.com/cgit/k3-image-gen/k3-image-gen
>>
>>> Regards,
>>> Manorit
>>>
>>>>
>>>> Andrew
>>>>
>>>>> Regards,
>>>>> Manorit
