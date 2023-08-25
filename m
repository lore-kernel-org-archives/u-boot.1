Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B154DC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 14:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 007B986A5A;
	Fri, 25 Aug 2023 16:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RNMTBzeU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C02686A7D; Fri, 25 Aug 2023 16:18:14 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F7D086923
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 16:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PEI1p2053708;
 Fri, 25 Aug 2023 09:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692973081;
 bh=QsfPgi4DTjvtdlkO2vOOKFXRqgBl27akW8DyCUqw7c8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=RNMTBzeUGbCUkXvHd8PyT+c8ku4tb9yg7Ens8svBP8RCCxkjWNKvVeGmcNBb84GOk
 +6AuDTuw3JdqMQWzIP+pM7CDwVUUfynA5tcX+xtYAqjvO+wjAWp6yZ6Y1E0S5nqtnG
 Lzl3zOz06Nk354oCDoLx4rlc++tmQnmY148zMPBo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PEI1Pe027799
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 09:18:01 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 09:18:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 09:18:00 -0500
Received: from [10.249.128.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PEHu7F091308;
 Fri, 25 Aug 2023 09:17:57 -0500
Message-ID: <227d74cf-9e95-4f5f-af96-49d054cde7aa@ti.com>
Date: Fri, 25 Aug 2023 19:47:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
To: Simon Glass <sjg@google.com>, Tom Rini <trini@konsulko.com>
CC: Nishanth Menon <nm@ti.com>, Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, 
 Andrew <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh
 <vigneshr@ti.com>, <u-boot@lists.denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Jan Kiszka <jan.kiszka@siemens.com>, Heinrich
 Schuchardt <heinrich.schuchardt@canonical.com>
References: <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
 <20230823171502.GQ3953269@bill-the-cat>
 <CAPnjgZ2t2aUnreA8Hzg11moQ2Z5hqW1r-16WTF0PRMjK3iXe_A@mail.gmail.com>
 <20230824001848.vgzl7rcphic3gu2n@carnival>
 <CAPnjgZ2qxm0KGFp5dM2Jzzcuib5npXodhYQ6u+dbO3oSBHA55A@mail.gmail.com>
 <20230824032709.phneggflsw2ps2dv@reanalyze>
 <a3af68c4-490d-f3e2-a9ed-acd650ac0452@ti.com>
 <20230824142050.GL3953269@bill-the-cat>
 <CAPnjgZ23_aCG6XqJBwnVkrm3kcuwkz=-geQTX5BbX9rP+w49fA@mail.gmail.com>
 <20230824144358.GO3953269@bill-the-cat>
 <CAPnjgZ3Z=7Mfs+QC-YSU9NNKq4UnY0C-b891TdtDMJRgLdYUpQ@mail.gmail.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <CAPnjgZ3Z=7Mfs+QC-YSU9NNKq4UnY0C-b891TdtDMJRgLdYUpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Simon, Tom

On 24-Aug-23 8:16 PM, Simon Glass wrote:
> Hi Tom,
> 
> On Thu, 24 Aug 2023 at 08:44, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Thu, Aug 24, 2023 at 08:41:23AM -0600, Simon Glass wrote:
>>> Hi,
>>>
>>> On Thu, 24 Aug 2023 at 08:20, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Thu, Aug 24, 2023 at 06:46:57PM +0530, Neha Malcom Francis wrote:
>>>>> Hi Simon, Nishanth
>>>>>
>>>>> On 24/08/23 08:57, Nishanth Menon wrote:
>>>>>> On 21:01-20230823, Simon Glass wrote:
>>>>>>> Hi Nishanth,
>>>>>>>
>>>>>>> On Wed, 23 Aug 2023 at 18:18, Nishanth Menon <nm@ti.com> wrote:
>>>>>>>>
>>>>>>>> On 17:57-20230823, Simon Glass wrote:
>>>>>>>> [...]
>>>>>>>>>> This is how we have a common bit of rST for how to build N boards,
>>>>>>>>>> without having to do a literal copy and paste N times.
>>>>>>>>>
>>>>>>>>> How about using this?
>>>>>>>>>
>>>>>>>>> https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#substitution-definitions
>>>>>>>>
>>>>>>>> I was not able to succeed with complex includes such as:
>>>>>>>> https://github.com/u-boot/u-boot/blob/master/doc/board/ti/am62x_sk.rst?plain=1#L89
>>>>>>>>
>>>>>>>> am62x complete build procedure defined once and reused in other am62x
>>>>>>>> platforms.. But the am62x build procedure itself is reused from common
>>>>>>>> k3 build steps.
>>>>>>>
>>>>>>> I followed through these instructions. I find the env vars quite
>>>>>>> confusing, since I don't really know what it is doing. It feels like a
>>>>>>> script:
>>>>>>>
>>>>>>> do $a $b $c
>>>>>>> do $f $e
>>>>>>>
>>>>>>> it is pretty hard to follow. I think it would be better to write
>>>>>>> everything out in full for each board, like rockchip does.
>>>>>>
>>>>>> Unfortunately, this is a few major steps that is repeated for
>>>>>> (currently):
>>>>>>      AM62x SK
>>>>>>      Toradex Verdin
>>>>>>      (pending: beagleplay - )
>>>>>>      (once all the dust clears up, hopefully phytec)
>>>>>>      SK-LP
>>>>>>      ....
>>>>>>
>>>>>> I have no reasonable way to offer to keep them all in sync.
>>>>>>      https://libera.irclog.whitequark.org/u-boot/2023-07-26#34662854;
>>>>>> is kind of why I went down this path.S
>>>>>>
>>>>>>>
>>>>>>> Some other minor feedback:
>>>>>>>
>>>>>>> - The 'make' lines should really have -j $(nproc) added
>>>>>>
>>>>>> Different styles of shells..
>>>>>>
>>>>>>> - The $ signs at the start of each command in the docs are a pain
>>>>>>> since it stops me copying the commands into the terminal - can you
>>>>>>> remove them?
>>>>>>
>>>>>> hehe.. "dont" let people blindly copy paste without understanding what is
>>>>>> going on argument?
>>>>>>
>>>>>> If folks are OK, I sure can send a different patch series for that.. (or
>>>>>> maybe motivate someone to do that instead of me ;))
>>>>>>
>>>>>>
>>>>>>> - It doesn't build for me:
>>>>>>>
>>>>>>>     BINMAN  .binman_stamp
>>>>>>> Image 'ti-dm' is missing external blobs and is non-functional: blob-ext
>>>>>>>
>>>>>>> /binman/ti-dm/blob-ext (ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f):
>>>>>>>      Missing blob
>>>>>>>
>>>>>>> Some images are invalid
>>>>>>> make[1]: *** [/scratch/sglass/cosarm/src/third_party/u-boot/files/Makefile:1115:
>>>>>>> .binman_stamp] Error 103
>>>>>>> make[1]: Leaving directory '/tmp/b/play'
>>>>>>> make: *** [Makefile:177: sub-make] Error 2
>>>>>>
>>>>>>
>>>>>> ^^ Neha: This is what I was complaining about.
>>>>>>
>>>>>> https://u-boot.readthedocs.io/en/latest/board/ti/am62x_sk.html?highlight=am62#sources
>>>>>>
>>>>>> source: https://git.ti.com/git/processor-firmware/ti-linux-firmware.git
>>>>>> is missing, we never used to break build previously binman converted now does.
>>>>>>
>>>>>> I am wondering if I need to explicitly call out git clone instructions
>>>>>> out..
>>>>>>
>>>>>
>>>>> Right... this does seem to be a complaint that keeps coming up.
>>>>>
>>>>> Simon, my intention at the time of sending out the patch was that anyone
>>>>> building the board should "not NOT" have the DM binary. The way we
>>>>> structured the filename was that it looks at BINMAN_INDIRS to find
>>>>> ti-dm/ipc_echo_testb_mcu1_0_release_strip.xer5f but I guess this is a
>>>>> confusing way to put it across. Maybe we should rework that. Or not throw an
>>>>> error at all when DM isn't found.
>>>>
>>>> Well, is DM required or not? If it's optional, we have flags to mark it
>>>> optional.  If it's required, we have flags for make and buildman to tell
>>>> binman "fake it".  I am wondering if we still have the ability to have a
>>>> more verbose "need it, can't find it" error message, and so that's where
>>>> it should say that you forgot to set BINMAN_INDIRS or clone the firmware
>>>> repository.
>>>
>>> If it is optional, use the 'optional' tag on the entry You will get a
>>> warning but not an error. At the moment it is saying that the image is
>>> non-functional, which is not good.
>>
>> Yes, and I believe these are non-optional firmwares, so do we still have
>> the ability to produce a more specific and verbose error message?
> 
> Yes, see the 'missing-msg' tag and the 'missing-blob-help' file. This
> should work for any external block, whether missing or faked, optional
> or required,
> 

I'll take a future action to clean that up.

> Regards,
> Simon
