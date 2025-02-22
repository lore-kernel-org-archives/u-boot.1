Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2ADC021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 08:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE6E380548;
	Sat, 22 Feb 2025 09:27:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740212831;
	bh=DQW+dxdX35TtghGNtQxOQo8GtUhIG9YKgeMoGIMG3KU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=FuF0//cI6kkh7k9h2sJxdizppitruOnYWMgI3HjkXGsYs26JUMeCB6PCd+ukRzs0e
	 RepMOg/aYl6JmQWX8S6fhPatEwMuyxdYlTQiAgUa1ibA9tVoO5aSHq4hFJwYAR2pnj
	 qLDZFoZ0YsDJuBQ+4xr670BdLJYwHI7vNz6xKPqkcQRVdyMvsixmULOqff8dohbe6x
	 VwxETL+Hiop4heU992gBjPxCUzT9tUgjCyO+BojF4AjFYP4ose3HbRARVPVB2/6saA
	 CogPM4xRsUQ0BEejE3FEBDcDLI1GiGJ6lE8bmG61ZmyKgN8NEmbUT7V+Rm4IzGE19t
	 AQEHtB82B/NKg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5FF68056B; Sat, 22 Feb 2025 09:27:09 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F764801B0
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 09:27:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="MntjOJMi"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 709FB10382D37; Sat, 22 Feb 2025 09:27:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740212825; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DQW+dxdX35TtghGNtQxOQo8GtUhIG9YKgeMoGIMG3KU=;
 b=MntjOJMi5GdQb66FZlbd2ismxz0JaUlIJ6qQlqgtWY9RTAULOrgrTo0Hcl/SQJmR/0v/NW
 YhQNCXP3wVnLETDOn/BHAlYmuhaShN3YCxMN89FrSlabXZCYot8NE6nDmP/TTZi9QURVZy
 Uag30jT0ulFo838nGchLquewRJEOXTF5O6F8KeWBCROnVMo8ZpQ0K7IpBaUOJ2dnW9njec
 Wmklj9Twg2osot2mdh0ncw2qecdzbzpSkEFfj1lGxvqnXV5iFSmqGoQ8vniAuBIAsJoR52
 PFejB9VYvJNxB8I7YLlq8JaMg+BwmWnbu5vVpApbSn56TdXfyITBO/fAwrYoTA==
Message-ID: <94424641-471b-7b9b-1c5d-e4cb94bc6fce@denx.de>
Date: Sat, 22 Feb 2025 09:27:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-29-sjg@chromium.org>
 <20250217175210.GR1233568@bill-the-cat>
 <CAFLszThPi2PuEP0osj895nRANNAUrCF+C-k6B319phs0Jf7xMg@mail.gmail.com>
 <20250218151145.GD1233568@bill-the-cat>
 <CAFLszTibOj_P4CiSP5wHjGzM+iaOr7e8XnLw-bR5wXpu8xxZrA@mail.gmail.com>
 <20250219005515.GR1233568@bill-the-cat>
 <CAFLszTjmAeAFwajpB1ee85=8_AF3c2_ttm0Rj1wcMxN-OrXdeg@mail.gmail.com>
 <20250220145311.GY1233568@bill-the-cat>
 <CAFLszTjdBD3Do=E14dPspWRXS6UYrAHWopWETMSWXE_UEm0D0Q@mail.gmail.com>
 <20250221160628.GJ1233568@bill-the-cat>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250221160628.GJ1233568@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Tom,

On 21.02.25 17:06, Tom Rini wrote:
> On Fri, Feb 21, 2025 at 06:57:34AM -0700, Simon Glass wrote:
>> Hi Tom,
>>
>> On Thu, 20 Feb 2025 at 07:53, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Thu, Feb 20, 2025 at 06:49:49AM -0700, Simon Glass wrote:
>>>> Hi Tom,
>>>>
>>>> On Tue, 18 Feb 2025 at 17:55, Tom Rini <trini@konsulko.com> wrote:
>>>>>
>>>>> On Tue, Feb 18, 2025 at 05:01:40PM -0700, Simon Glass wrote:
>>>>>> Hi Tom,
>>>>>>
>>>>>> On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@konsulko.com> wrote:
>>>>>>>
>>>>>>> On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon Glass wrote:
>>>>>>>> Hi Tom,
>>>>>>>>
>>>>>>>> On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
>>>>>>>>>
>>>>>>>>> On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Glass wrote:
>>>>>>>>>> Now that U-Boot can boot this quickly, using kvm, add a test that the
>>>>>>>>>> installer starts up correctly.
>>>>>>>>>>
>>>>>>>>>> Use the qemu-x86_64 board in the SJG lab.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> Changes in v2:
>>>>>>>>>> - Add more patches to support booting with kvm
>>>>>>>>>> - Add new patch with a test for booting Ubuntu 24.04
>>>>>>>>>>
>>>>>>>>>>   .gitlab-ci.yml               |  5 ++++
>>>>>>>>>>   test/py/tests/test_distro.py | 53 ++++++++++++++++++++++++++++++++++++
>>>>>>>>>>   2 files changed, 58 insertions(+)
>>>>>>>>>>   create mode 100644 test/py/tests/test_distro.py
>>>>>>>>>>
>>>>>>>>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>>>>>>>>> index 8c49d5b0a79..ec799e97c10 100644
>>>>>>>>>> --- a/.gitlab-ci.yml
>>>>>>>>>> +++ b/.gitlab-ci.yml
>>>>>>>>>> @@ -745,3 +745,8 @@ zybo:
>>>>>>>>>>     variables:
>>>>>>>>>>       ROLE: zybo
>>>>>>>>>>     <<: *lab_dfn
>>>>>>>>>> +
>>>>>>>>>> +qemu-x86_64:
>>>>>>>>>> +  variables:
>>>>>>>>>> +    ROLE: qemu-x86_64
>>>>>>>>>> +  <<: *lab_dfn
>>>>>>>>>
>>>>>>>>> I'm not sure why this is in your lab stanza, rather than the normal
>>>>>>>>> test.py QEMU stanza.
>>>>>>>>
>>>>>>>> Are you wanting to add the Ubuntu image into CI? It is quite large.
>>>>>>>
>>>>>>> If we're going to be able to run it on N platforms, yes, we need to
>>>>>>> think of a good way to cache the download. There's not a particular
>>>>>>> reason we can't run the stock Ubuntu RISC-V image on the two sifive
>>>>>>> targets and also qemu-riscv64, is there?
>>>>>>
>>>>>> Yes, we can do that. It is pretty simple to set up in Labgrid and it
>>>>>> doesn't require all the runners to download a much larger image, etc.
>>>>>
>>>>> I don't quite understand why it's under "labgrid". These are generic CI
>>>>> tests. Now maybe we need to, in both Gitlab and Azure, add some logic so
>>>>> that certain longer or possibly destructive tests are only run on tagged
>>>>> releases or as requested rather than every time, as it will take longer.
>>>>> But pretty much every platform under the qemu target list should be able
>>>>> to Just Boot an off the shelf OS distribution is my point.
>>>>
>>>> Sure, and I'm not suggesting we shouldn't do that as well.
>>>>
>>>>>
>>>>>>>>>> diff --git a/test/py/tests/test_distro.py b/test/py/tests/test_distro.py
>>>>>>>>>> new file mode 100644
>>>>>>>>>> index 00000000000..51eec45cecc
>>>>>>>>>> --- /dev/null
>>>>>>>>>> +++ b/test/py/tests/test_distro.py
>>>>>>>>>> @@ -0,0 +1,53 @@
>>>>>>>>>> +# SPDX-License-Identifier: GPL-2.0+
>>>>>>>>>> +# Copyright 2025 Canonical Ltd.
>>>>>>>>>> +# Written by Simon Glass <simon.glass@canonical.com>
>>>>>>>>>> +
>>>>>>>>>> +import pytest
>>>>>>>>>> +
>>>>>>>>>> +DOWN = '\x1b\x5b\x42\x0d'
>>>>>>>>>> +
>>>>>>>>>> +# Enable early console so that the test can see if something goes wrong
>>>>>>>>>> +CONSOLE = 'earlycon=uart8250,io,0x3f8 console=uart8250,io,0x3f8'
>>>>>>>>>> +
>>>>>>>>>> +@pytest.mark.boardspec('qemu-x86_64')
>>>>>>>>>> +@pytest.mark.role('qemu-x86_64')
>>>>>>>>>> +def test_distro(ubman):
>>>>>>>>>> +    """Test that of-platdata can be generated and used in sandbox"""
>>>>>>>>>> +    with ubman.log.section('boot'):
>>>>>>>>>> +        ubman.run_command('boot', wait_for_prompt=False)
>>>>>>>>>> +
>>>>>>>>>> +    with ubman.log.section('Grub'):
>>>>>>>>>> +        # Wait for grub to come up and offset a menu
>>>>>>>>>> +        ubman.p.expect(['Try or Install Ubuntu'])
>>>>>>>>>> +
>>>>>>>>>> +        # Press 'e' to edit the command line
>>>>>>>>>> +        ubman.run_command('e', wait_for_prompt=False, send_nl=False)
>>>>>>>>>> +
>>>>>>>>>> +        # Wait until we see the editor appear
>>>>>>>>>> +        ubman.p.expect(['/casper/initrd'])
>>>>>>>>>> +
>>>>>>>>>> +        # Go down to the 'linux' line
>>>>>>>>>> +        ubman.send(DOWN * 3)
>>>>>>>>>> +
>>>>>>>>>> +        # Go to end of line
>>>>>>>>>> +        ubman.ctrl('E')
>>>>>>>>>> +
>>>>>>>>>> +        # Backspace to remove 'quiet splash'
>>>>>>>>>> +        ubman.send('\b' * len('quiet splash'))
>>>>>>>>>> +
>>>>>>>>>> +        # Send our noisy console
>>>>>>>>>> +        ubman.send(CONSOLE)
>>>>>>>>>> +
>>>>>>>>>> +        # Tell grub to boot
>>>>>>>>>> +        ubman.ctrl('X')
>>>>>>>>>> +        ubman.p.expect(['Booting a command list'])
>>>>>>>>>> +
>>>>>>>>>> +    with ubman.log.section('Linux'):
>>>>>>>>>> +        # Linux should start immediately
>>>>>>>>>> +        ubman.p.expect(['Linux version'])
>>>>>>>>>> +
>>>>>>>>>> +    with ubman.log.section('Ubuntu'):
>>>>>>>>>> +        # Shortly later, we should see this banner
>>>>>>>>>> +        ubman.p.expect(['Welcome to .*Ubuntu 24.04.1 LTS.*!'])
>>>>>>>>>> +
>>>>>>>>>> +    ubman.restart_uboot()
>>>>>>>>>
>>>>>>>>> And this seems very inflexible. Please see
>>>>>>>>> test/py/tests/test_net_boot.py for an example of how to have this be
>>>>>>>>> configurable and work on arbitrary platforms. What I assume is tricky is
>>>>>>>>> that the "role" part here is where you have a special disk image being
>>>>>>>>> passed. That too could be dealt with in u-boot-test-hooks in a few ways,
>>>>>>>>> and the images pre-fetched to the CI container. And if this was
>>>>>>>>> configurable similar to the example I noted above, it could check real
>>>>>>>>> hardware too.

Ah, and now I got the trick, when looking into test/py/tests/test_net_boot.py
how to configure more tests (I think)!

>>>>>>>>
>>>>>>>> That wasn't the reaction I expected.
>>>>>>>>
>>>>>>>> Yes, it is inflexible, but it is a starting point. Isn't it better
>>>>>>>> than what we have today?
>>>>>>>
>>>>>>> Is your inflexible boot an OS test better than the flexible boot an OS
>>>>>>> test that we have today? No, it's not.
>>>>>>
>>>>>> I didn't even know about it, or perhaps I forgot.
>>>>>
>>>>> I believe I mentioned it every time you've said we should have an OS
>>>>> test, so yes, I guess you forgot.
>>>>
>>>> Well it was only added in May last year and it relies on board config
>>>> which I don't have...although I see that you have now posted yours.
>>>
>>> Yes, it was added not quite a year ago, and is documented within the
>>> test, like most tests that rely on the real platform.
>>>
>>> And do we need better documentation for test? Yes.
>>
>> +1
>>
>> I'll note that I did my bit!
>>
>>>
>>>>>> Perhaps this relates to getting the labgrid config published and
>>>>>> figuring out how to pass info from Labgrid to tests.
>>>>>>
>>>>>>>
>>>>>>>> I would like to generalise this test to work on at least one real
>>>>>>>> board, preferably one that doesn't use grub.
>>>>>>>
>>>>>>> OK. The test we have today does that, if you check for the "Welcome to
>>>>>>> ..." string instead of the kernel has booted string. It also does
>>>>>>> netboot rather than run default bootcmd. But that's an easy enough test
>>>>>>> to write up. The only thing stopping me from doing that right now is I
>>>>>>> need to find a board in the lab where we installed an OS to eMMC and not
>>>>>>> SD card (some lab sd-mux issues).
>>>>>>
>>>>>> OK. Labgrid has a 'features' thing which you can attach to targets, so
>>>>>> I should be able to use that to indicate that Ubuntu, Debian, Armbian,
>>>>>> etc. are available.
>>>>>
>>>>> OK, but that sounds like the opposite direction. These are generic tests
>>>>> that can run in any / all of the labs, not just your labgrid
>>>>> configuration. AMD has been contributing tests that run on hardware for
>>>>> example.
>>>>
>>>> That's great, the more tests we have the better. But those tests can't
>>>> and don't run in CI, whereas mine can and do.
>>>
>>> AFAICT they're running on AMD's CI. They run on my CI. They don't run on
>>> *your* lab because you took things, intentionally, in a direction to
>>> minimize using u-boot-test-hooks and our existing per-board
>>> configuration infrastructure.
>>
>> When I look at CI all I see is my lab. Which CI are you referring to
>> and how can I access it?
> 
> I'll point you at the notes for the first call we had recently:
> https://lore.kernel.org/u-boot/20250128171923.GQ1233568@bill-the-cat/
> and note that there are many labs doing testing on / with U-Boot.
> 
>> Here I would like to make a case for moving to using Labgrid across
>> the board, but unfortunately the project struggles to review PRs, so
>> it's probably not a good idea.
> 
> It would also be counter to the feedback from the U-Boot community about
> making it easier to contribute testing results from additional labs.

I had years ago a nightly U-Boot build/install/test tbot setup for some
boards I had access to, and collected while the test run data with tbot,
and pushed that data to a DB ... and had a "blog" based webpage which
showed the data from that DB (I am soory, not up and running currently)

(IIRC, I collected, base commit, boardname, resulting binary sizes,
  used toolchain, testresult good/bad,...)

May we should discuss first which data we are interested in, and than define
where and how we store this data. Than we should define an API for adding
results... easiest way could be simple txt emails to ML (generated with tbot
or at least a shell script), so we get the results in a well defined format
and than we can write a script which extracts the info from such an EMail
and pushes it into a DB. So it should be easy for people to create such
a test reoport email, and easy for us to parse this email...

And based on such a DB we can make a small webpage which shows the results...
(May add queries like binary size over the last 100 builds and make a nice
  image, which shows the size growth ... which I had in my old approach)

>>>> We need an 'all of the above' strategy here.
>>>
>>> Sure. But I still want to see things as reusable as possible. What you
>>> have above is *extremely* board and OS specific and non-configurable.
>>
>> Yes, agreed.
>>
>>> I
>>> also don't quite see why it's not a test of autoboot with the
>>> pre-requisite of an OS being installed.
>>
>> Ah OK, my test is just for the installer itself. Both are useful, but
>> I hope eventually to have the installer run to completion and then
>> reboot to check all is well.
> 
> In the spirit of "yes, and.."'ing tests, sure. Ilias pointed me at some
> testing Linaro has going now that automates I believe it was current
> Yocto and current U-Boot (+ the pmb patches that've been posted) doing a
> full install via network in CI. So yes, a Canonical lab might also find
> it useful to end to end test installing Ubuntu. My own personal dream is
> that at least some of the existing kernelci labs see the utility in
> adding "current U-Boot" as one of the matrix variables they test and not
> just "U-Boot as delivered by vendor" as a static part of the testing.

Yep, that would be nice.

>>>> BTW, having thought about how test/py works a bit, instead of the
>>>> env__net_tftp_bootable_file stuff, we should have code or data which
>>>> sets up the required test files (on a suitable server) before running
>>>> the test. That way, all the test code is in one Python file and we
>>>> don't have to spend ages trying to divine what each test needs.
>>>
>>> That seems like a lot more work than documenting more what we have
>>> today, and I'm not sure of the benefit. Given the contents of the pxe
>>> test, yes, just having those files available to 'cp' in place would be
>>> helpful. But that's not the case for booting a kernel (the FIT match
>>> stuff doesn't work on the TI platforms atm). And if you look at the
>>> config I posted it also includes bootstage configuration. It also won't
>>> work well for the SPI tests, which I'm talking with Love about in
>>> another thread.
>>
>> Yes, perhaps, but having self-contained tests would be a win.
> 
> With it's own set of technical and legal challenges / obligations and
> difficulties depending on what you even mean by "self contained". And
> how often what's run where, and all sorts of other challenges too.
> 
> Given the extreme depth that testing can go to, this is why I'm of the
> position that we need to document things more and worry less about
> prepackaged things. For example, making the documentation for the
> current net based OS boot means that for bringing up a new board the
> developer can just drop something in. Whereas if the tests expect a
> functional OS image that has to also be messed with and is its own
> challenge.

Just my 1 cent.. without to much knwoledge about current situation/problem,
or test/py at all, hope I write not too big nonsense ... just from a tbot
point of view.

In tbot you request/enter an U-Boot machine, and than tbot for example setups
Environment variables defined for this board/machine.

Example:
https://github.com/hsdenx/u-boot-test/blob/tbottesting/tbottesting/tbotconfig-hs/hs/cxg3.ini#L37

So we can define for each board the Environment which fits for the
tests we want to call (tbot setup should now it!)

So lets, say, we want to boot different linux images, from different
sources with different mounts of rootfs (nfs, emmc,...) we can define
different linux bootcommands (U-Boot environment variables at the end),
like:

tftp_fit_nfs (load fitimage from tftp and boot with nfs rootfs)
tftp_raw_nfs (load raw kernel image with tftp and boot with nfs as rootfs)
emmc_fit_emmc (load fit iamge from emmc and boot with rootfs on emmc)
<your fancy command> ...
[...]

Than we can select in tbot which command we run when we request the
linux machine. May dependend (means not implemented yet) on what specifc
test/py test needs!

When entered linux commandline, you can search strings in the linux
bootlog, you can access with machine.bootlog, or call linux commands
and analyse the output... but I think, that is not to much interesting
in U-Boot tests... but I can think for example of a i2c RTC test, which
sets a date in U-Boot, than enters linux, check the date, set in linux
another date, power off/on (or reboot) to enter U-Boot and check again
the date... no problem with tbot...

So I think, we should define in test/py "stuff we need for a test"
which than lab implementations can parse and provide/setup dependend
on the specific board. test/py may can request such a "feature" from
the lab and if not availiable skip the test?

As I now (after reading this Email often, and look around in test/py)
it seems to me, we already have such "request feature" in test/py by
defining env__xyz variables? Is this correct?

If so, it seems no problem to me, to create that stuff from within tbot,
before it calls test/py!...  as tbot (see below) creates this u-boot hook
scripts already *before* starting test/py! It would be good to have an
overview which variables should be set for which test... do we have such
a doc?

Think about that there are boards in labs where we can do a specific test
but in other labs, the same board skips this test, because missing images
for this tests in that lab! ... may some lab has can or rs485 testing
hardware, the other lab misses this feature ... and tbot "knows the lab/board"
combination and can generate the specifc env__xyz variables (or not) in
hook files...

so as much flexible as possible approach I think ...

 From my side, yes, test/py can use u-boot hook scripts and depend
only on them and a lab integration simply should create that files
before starting test/py and we are fine for both worlds... or?

>>> In other words, the majority of py/<host>/u_boot_boardenv_ content is
>>> configuration details, specific to both the platform / SoC first, some
>>> lab specific details second and drop-in existing 3rd party files a
>>> distant third.
>>
>> I think the u-boot-test-hooks was an amazing solution 9 years ago, but
>> we have outgrown it. We want people to be able to connect their lab to
>> CI (meaning gitlab), so testing is more automated.
> 
> More and more public testing would be great. The notes I linked above
> explain one of the first problems there being that most companies will
> not or can not hook a lab to a public CI instance. The next problem, as
> both of our personal labs show, is that just maintaining the physical
> lab takes time and resources. I've added Heiko here because I've been
> talking with him off-list about expanding tbot coverage and plumbing
> that in to gitlab.

And yes, as above mentioned, I had this stuff up and running >5 years ago,
but when you test, you find bugs, boards break, you have to fix, you need
time... customers do not want to pay, so it is all done in free time at
the end...

BTW: I added in that old setup that I downloaded the patches from my patchwork
  ToDo list, run checkpatch and apply them to current HEAD, and run the tests
  (which means build/install/test) on the boards... so I only had to look in
  the morning on my webpage, and if all is green, all patches in my patchwork
  todo list are fine... so that makes maintainers work a lot easier...

  May I find time to reactivate this setup again (of course with the new tbot,
  not my old crap...) if people are interested... but yes, we should define
  how to report testresults... (speculating without knowledge ... may we can
  use kernelCI code and start an u-bootCI server?)

  heh,  found a video on youtube from me... 8 years ago! ... wow time is
  running...

  https://www.youtube.com/watch?v=PhaYfqOrQOg

  It also shows a complete git bisect session to find out which patch
  on my patchwork todo list breaks U-Boot ... fully automated...
  (But yes, use the fast forward button, as looking at logs is not that
   interesting, but you can see, that it really worked)

YFI:
My current approach for integrating tbot into gitlab Tom mentioned above:
(Attention: still WIP!)

https://source.denx.de/u-boot/custodians/u-boot-i2c/-/pipelines

unfortunately test/py does not work yet on gitlab:

https://source.denx.de/u-boot/custodians/u-boot-i2c/-/jobs/1032932#L2105

but this is some problem with python module versions, hope I can soon fix it.

*same* tbottesting code works on github fine with test/py

https://github.com/hsdenx/u-boot-test/actions/runs/13412895540
https://github.com/hsdenx/u-boot-test/actions/runs/13412895540/job/37467281787#step:6:2122

(I see a lot of skipped tests... how can I activate them? It seems now
  to me, that I need such u-boot hook files with env__xyz variables in, is
  this correct?)

In short, tbot runs on gitlab or github, board is in my lab in hungary. It is
the imx8qxp based capricorn board, test fetches from lab host the binary blobs,
needed for getting a working flash.bin and get some downstream patches from
lab host and applies them), build, copy the resutling binary flash.bin to the
lab host.

Than set bootmode "USB SDP" and load the flash.bin with the uuu tool, when reached
U-Boots shell, install with U-Boots fastboot mode the flash.bin onto the emmc again
with uuu tool. Set bootmode emmc, powercylce and U-Boot boots from emmc (I check
here that the correct bootmode is in U-Boots bootlog!)

Than I do a small ping test and call ut command, and as Tom requested,
start test/py... more I hopefully can add.

work still on a README for it:

https://source.denx.de/u-boot/custodians/u-boot-i2c/-/blob/tbottesting/tbottesting/README.md?ref_type=heads

The good thing is, I can use the same tbot commands/code during my
daily work... so setting up CI is not that hard or a seperated task.
This is the main goal from tbot, to automate daily developers work,
setting up a CI is than easy... I should have called tbot preferably "abot"
(automation bot ... as it automates machines and interaction between them)

>> We should move away from relying on maintainers getting around to
>> testing patches months after they are sent, when they have time, but
>> they don't. Things need to be more automated and I'd encourage you to
>> push this as well.
> 
> I have been, and the results I've gotten are that companies are testing
> things internally but there's not any good way to publish results, and
> that's the kind of framework we're entirely missing.

Indeed.

> Which is another part of why I keep pushing against having U-Boot
> configuration stuff inside of Labgrid as it makes it harder for any lab
> that's not using labgrid to see how to configure things.

I must admit, that I currently have to learn how to setup test/py
stuff, to get rid of a lot of skipped tests! But first I want to
get it up and running @gitlab.

Hmm.. I also have the complete config in tbot setup... see above, but
I generate the u-boot hooks from within tbot, example:

https://github.com/hsdenx/u-boot-test/actions/runs/13412895540/job/37467281787#step:6:1878

with:
https://tbot.tools/contrib/uboot.html#tbot-contrib-uboot

So, have the test/py config seperated in u-boot-hook scripts is good!
and no showstopper for lab integrations... simply the lab integration
should generate the hook scripts with the correct settings for the
lab and board combination before calling test/py...

I have to admit, that I must dig deeper into test/py as I had the last
years not that much time for it ... hope I wrote not to much nonsense
(sorry in advance if so...)

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
