Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A5DC3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 05:29:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC2988806;
	Mon,  5 Aug 2024 07:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722835740;
	bh=Dn+GEDW/48iLyYcroH2Z9MGS1gUd12XGlZNqSso0vJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ioOfTUY3n2mGbYmZBzGJP6n9SRoC5cjxCo9M3evI/hdHvfdxWl6HXKOL/Nfia3vp2
	 scjn2DzXoGq3QMP3T6QujYSdVegwjNutln09r6gXWGOZZeHbLvW0O1NiZbzgt9YzHn
	 S0S85060WuIQUb7IzG+oKhFi/8EUy/QUPeZkNyNAaQtOtviKZYSZ3FDFIXdEfiSdBm
	 7AinwYTEw5P0JYhDcyBwxWRGebKcbkXnnHar5gD0W6z+sR5G0+98j6LnAJdX8fXYKi
	 AAO9M0CC9J61UBV1WFWtxPcYfppyP5PRa9Ssa5K/NRXdFpEBJybU65gxWMe/udyPtZ
	 AutlgyX3DkDiQ==
Received: from [192.168.1.107] (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 94DDE87D10;
 Mon,  5 Aug 2024 07:28:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722835739;
 bh=Dn+GEDW/48iLyYcroH2Z9MGS1gUd12XGlZNqSso0vJI=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=o7xxHs54haDNIiLH3a9m1b2ad/O8KoaLVkHpKQ/pm54YErN0R5huVecC8Eag39WVw
 av3pNZwmQguW/gplFKB4Q3YRDuU0Zc/kj7+ixv1RSeOJmSLhmf//p/wd6WXsDS8MkP
 WCnI0NvyTP57zVT447hCQ9aX5YuEomygd60R9ZjrQrtcL02qcliQ4niQEN/x6WhI8o
 aZdG/9nNgWO9pvFWCA2A1WosNUjo1Jiq2aotKJlSdTV3xulkGM8Kcz+mbJGbJQPUU9
 8r08S9h9Dz40zJ8aMtBnhDuLMexuDyU7CYmQ3i2SHgmZgRZ7GE7u+iT6kh/xbrem4k
 wmMyMyc+t6T6w==
Message-ID: <44ca37d8-5d8c-80f7-1151-6a77732433f7@denx.de>
Date: Mon, 5 Aug 2024 07:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [EXTERNAL] Re: [PATCH 0/4] fs: ubifs: Fix crash and add safeguards
Content-Language: en-US
To: Ravi Minnikanti <rminnikanti@marvell.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>, Hans de Goede <hdegoede@redhat.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Kyungmin Park <kmpark@infradead.org>
Cc: Alexey Romanov <avromanov@salutedevices.com>
References: <20240703101258.1670825-1-ada@thorsis.com>
 <8f3a7059-6330-f332-8e9f-729b853e001e@denx.de>
 <20240704-goes-grape-25a9f1d14c24@thorsis.com>
 <20240801-wham-entertain-15505d61f84b@thorsis.com>
 <e0c3e3e2-1c7f-e244-5b1d-0498b5771deb@denx.de>
 <363c73bb-54cf-3800-bb31-9af83fbaf33d@marvell.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <363c73bb-54cf-3800-bb31-9af83fbaf33d@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Ravi,

On 01.08.24 21:39, Ravi Minnikanti wrote:
> Hi Heiko, Alexander,
> 
> On 7/31/24 23:54, Heiko Schocher wrote:
>> Hello Alexander, On 01. 08. 24 08: 50, Alexander Dahl wrote: > Hei, > > Am Thu,
>> Jul 04, 2024 at 10: 18: 55AM +0200 schrieb Alexander Dahl: >> Hello Heiko, >> >>
>> Am Thu, Jul 04, 2024 at 06: 28: 31AM +0200 schrieb Heiko Schocher: 
>>
>>
>> Hello Alexander,
>>
>> On 01.08.24 08:50, Alexander Dahl wrote:
>>> Hei,
>>>
>>> Am Thu, Jul 04, 2024 at 10:18:55AM +0200 schrieb Alexander Dahl:
>>>> Hello Heiko,
>>>>
>>>> Am Thu, Jul 04, 2024 at 06:28:31AM +0200 schrieb Heiko Schocher:
>>>>> Hello Alexander,
>>>>>
>>>>> On 03.07.24 12:12, Alexander Dahl wrote:
>>>>>> Hei hei,
>>>>>>
>>>>>> filesystem handling is different in U-Boot and beyond that UBI/UBIFS is
>>>>>> different from other filesystems in U-Boot.  There's UBI and UBIFS code
>>>>>> ported from Linux (quite old already now, maybe someone wants to update
>>>>>> that?), and there's "glue code" or "wrapper code" to interface with
>>>>>> U-Boot scripts, commands, and filesystem handling.  The fixes and
>>>>>> improvements in this patch series are for this U-Boot specific glue
>>>>>> code.
>>>>>
>>>>> Yes, the linux base is very old ... patches are welcome!
>>>>
>>>> The last sync was back in 2015 from linux v4.2, there were 800+
>>>> changes to ubi/ubifs in Linux since then. :-/
>>>>
>>>>> And for me it is not that easy, as I do not have a hardware with
>>>>> current mainline U-Boot running on it... I want to update a hardware
>>>>> I have to current mainline, but I had no time yet for it...
>>>>
>>>> Besides the custom hardware here, I used Microchip SAM9X60-Curiosity
>>>> lately, which is coming with a raw NAND flash and can boot from it.
>>>>
>>>>>
>>>>>> I'm no filesystem expert, but after days of debugging I'm quite sure the
>>>>>> bug is in U-Boot since UBIFS support was added in 2009, and it was
>>>>>> repeated in 2015 when generic filesystem support for UBIFS was added.
>>>>>> So please review carefully!
>>>>>
>>>>> Which bug?
>>>>
>>>> The memory leak and double free fixed with patch 1 of the series.
>>>>
>>>>>
>>>>>> The crashes were not easily reproducible, only with boards using the old
>>>>>> distroboot _and_ a boot script inspired by (but not equal to) the one
>>>>>> proposed by RAUC [1], which basically boils down to:
>>>>>>
>>>>>>      ubifsmount ubi0:boot (from distroboot)
>>>>>>      test -e (from distroboot)
>>>>>>      ubifsmount ubi0:rootfs1 (this time from the boot script,
>>>>>>                               triggering a ubifs_umount)
>>>>>
>>>>> So, you have a special sequence you execute to trigger the bug, good!
>>>>>
>>>>> In special 2 ubifsmount in a row... may not often needed for booting!
>>>>> (I ask me, why that is needed? Boottime is not good than...)
>>>>
>>>> Using distroboot with a script here.  The script is in a separate UBI
>>>> volume ubi0:boot, kernel is loaded from ubi0:rootfs1 or ubi0:rootfs2
>>>> however.  So there is 'ubifsmount ubi0:boot' from distroboot and in the
>>>> script found, loaded, and run there is 'ubifsmount ubi0:rootfs1' (or
>>>> rootfs2) later.  ubifsmount calls ubifsumount internally if some
>>>> volume is mounted already.
>>>>
>>>>>
>>>>> BTW: Is this really a good bootcmd in [1] as on *every* boot your
>>>>>        Environment is saved? This is not good for lifetime of your
>>>>>        storage device ... why not using bootcounter?
>>>>
>>>> Well, I was not aware of bootcounter, but I had a look and the actual
>>>> counter must be stored somewhere.  Possible are:
>>>>
>>>> - pmic → has no storage possibility on my board
>>>> - rtc → soc internal only, volatile in the end (if battery is empty)
>>>> - i2c eeprom → missing
>>>> - spi flash → missing
>>>> - filesystem → ends up on the flash
>>>> - nvmem → no other nvmems present
>>>> - syscon or some cpu register or sram → volatile
>>>>
>>>> So none of these are possible in my case, I only have a raw NAND as
>>>> storage and thus I have to use U-Boot env, which is stored in UBI here
>>>> btw to not stress the flash too much.
>>>>
>>>> I could investigate if it would be possible to let RAUC use the
>>>> U-Boot bootcounter infrastructure, but currently RAUC depends on
>>>> U-Boot environment variables for tracking boot attempts.
>>>>
>>>> btw: documentation of bootcount is sparse, I only found the very short
>>>> 'doc/README.bootcount' and it's not even migrated to recent U-Boot
>>>> sphinx based docs. ;-)
>>>>
>>>> But from what I understood the concept is the same, U-Boot counts
>>>> something and Linux userspace has to reset it.  The counter must be
>>>> stored somewhere, for example in U-Boot env if no other storage is
>>>> possible.
>>>>
>>>>>
>>>>>> Crashes can be triggered more easily, if patch order is changed and
>>>>>> patch 2 (resetting pointers to NULL after free) comes first, or if patch
>>>>>> 2 is applied on its own only.
>>>>>
>>>>> Hmm...
>>>>>
>>>>>> The fix is in the first patch, and on my boards I see no crashes
>>>>>> anymore.  I also tested all kinds of combinations of calling `ubi part`,
>>>>>> `ubi detach`, `ubifsmount`, `ubifsumount`, `ubifsls`, `ubifsload`, `ls`,
>>>>>> `load`, `size`, and `test -e` and got no crashes anymore after the fix.
>>>>>
>>>>> That sounds good! Hmm.. test -e has nothing to do with ubi/ubifs I think.
>>>>
>>>> Oh it has, 'test -e' calls file_exists() which calls fs_exists() which
>>>> ends up calling ubifs_exists() which is one of the functions causing
>>>> an immediate memory leak, see patch 1.
>>>>
>>>>> On what hardware do you test? Is it in mainline?
>>>>
>>>> Tested on custom hardware, but I'm confident it should be reproducible
>>>> on any board using ubifs, especially after applying patch 2 resetting
>>>> pointers of freed memory to NULL.  This should trigger the bug with
>>>> the simple sequence already described:
>>>>
>>>>     > ubifsmount ubi0:anyvolume
>>>>     > ls ubi ubi0:anyvolume / # (or load, or test -e, or size)
>>>>     > ubifsumount
>>>>
>>>> ubifsumount will call ubifs_umount() which calls
>>>> ubi_close_volume(c->ubi), that pointer is either invalid leading to a
>>>> double free inside of ubi_close_volume() and it will crash only in
>>>> certain conditions or the pointer is NULL after applying patch 2 of
>>>> the series, then ubi_close_volume() crashes right away with a NULL
>>>> pointer exception.
>>>>
>>>> Note: without patch 2 it very much depends on the sequence of
>>>> commands, but after the first ubi_close_volume() triggered by
>>>> ls/load/size/exists the pointer in ubifs_sb is invalid, but accessed later
>>>> by the second ubi_close_volume() triggered by ubifs_umount().  If you
>>>> do something in between those using the freed memory by something else
>>>> again, the second ubi_close_volume() access might get corrupted data
>>>> or access things outside of RAM.  Patch 2 redirects this on a clean
>>>> NULL pointer exception you can easily trigger.
>>>>
>>>> In my case I got a pointer variable actually containing a string
>>>> "ng.." aka 0x2e2e676e which looked suspiciously similar to a valid
>>>> pointer on the platform somewhere in RAM between 0x20000000 and
>>>> 0x28000000 so it took me two days to realize it's not a pointer. ;-)
>>>>
>>>>>
>>>>>> The three additional patches (2 to 4) are more or less safeguards and
>>>>>> improvements for the future, and come from me trying and my debugging
>>>>>> code done on the way, more or less optional, but I think nice to have.
>>>>>
>>>>> I will look at them .. but give me some time, as I am in holidays the
>>>>> next 2 weeks ... Hmm.. and it would be good to get some Tested-by
>>>>> from people with hardware...
>>>>
>>>> Take your time, no need to work in holidays.  Would appreciate a
>>>> Tested-by by anyone else though, maybe some of the raw NAND folks?
>>>
>>> Well, apparently nobody had a look in the month of July, I add the raw
>>> NAND maintainers in Cc, maybe I should have done in the first place.
>>>
>>> Would be happy if someone could have a look at the fix, maybe read the
>>> patches first before the discussion? ;-)
>>
>> I asked Ravi and Alexey (added to cc) if they have time to look it they
>> can reproduce the issue and test your patches...
>>
>> bye,
>> Heiko
> 
> I tried to reproduce with CONFIG_SYS_MALLOC_LEN reduced to 1MB and
> calling ubifsls in a loop, logic below:
> 
> ubi part ubi0:rootfs
> ubifsmount ubi0:rootfs
> setenv i 1
> while test $i -le 200; do
>      ubifsls a/b/test.bin
>      setexpr i $i + 1
>      sleep 1
>      echo "Loop count: $i"
> done

Thanks for testing! But it is not exactly the same sequence Alexander
described ... but you also trigger a bug.

> It crashes with or without patch. With patch it takes 4,5 loops more to crash.
> 
> Log:
> UBIFS error (ubi0:0 pid 0): ubifs_iget: failed to read inode 85, error -12
> "Synchronous Abort" handler, esr 0x96000004

-12 = -ENOMEM

So it seems, we have a memleak...

Yes, ubi/ubifs linux base is very old, but I tend to think that problem is
in U-Boot adaption layer...

bye,
Heiko
> 
> 
> Thanks,
> Ravi
>>>
>>> Greets
>>> Alex
>>>
>>>>
>>>> Greets
>>>> Alex
>>>>
>>>>>
>>>>> bye,
>>>>> Heiko
>>>>>>
>>>>>> Greets
>>>>>> Alex
>>>>>>
>>>>>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_rauc_rauc_blob_master_contrib_uboot.sh&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=3apjoJolwzwH82pd_c1HzSLzzrwfu9x1lSm802edgOg&m=lpy642UhqtTXHV0dd0xnOtQxkQSO5RC6FwcUbzt-FsNwd3QSXZsulfqC6dP9qV7G&s=wbnw_T9_r6taMKIFqJ2-wtj9Zv02OD7mbIy-ZZFRjRE&e=  <https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_rauc_rauc_blob_master_contrib_uboot.sh&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=3apjoJolwzwH82pd_c1HzSLzzrwfu9x1lSm802edgOg&m=lpy642UhqtTXHV0dd0xnOtQxkQSO5RC6FwcUbzt-FsNwd3QSXZsulfqC6dP9qV7G&s=wbnw_T9_r6taMKIFqJ2-wtj9Zv02OD7mbIy-ZZFRjRE&e=>
>>>>>>
>>>>>> Alexander Dahl (4):
>>>>>>      fs: ubifs: Fix memleak and double free in u-boot wrapper functions
>>>>>>      fs: ubifs: Set pointers to NULL after free
>>>>>>      fs: ubifs: Make k(z)alloc/kfree symmetric
>>>>>>      fs: ubifs: Add volume mounted check
>>>>>>
>>>>>>     fs/ubifs/super.c |  8 ++++++--
>>>>>>     fs/ubifs/ubifs.c | 31 +++++++++++++++++++------------
>>>>>>     2 files changed, 25 insertions(+), 14 deletions(-)
>>>>>>
>>>>>>
>>>>>> base-commit: 65fbdab27224ee3943a89496b21862db83c34da2
>>>>>>
>>>>>
>>>>> -- 
>>>>> DENX Software Engineering GmbH,      Managing Director: Erika Unter
>>>>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>>>>> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
>>
>> -- 
>> DENX Software Engineering GmbH,      Managing Director: Erika Unter
>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
>>

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
