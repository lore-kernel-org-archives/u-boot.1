Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA6CC02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 13:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A2480EF4;
	Sun, 26 Jan 2025 14:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7DAF80F56; Sun, 26 Jan 2025 08:14:25 +0100 (CET)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DC780EEF
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 08:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=yt@radxa.com
X-QQ-mid: bizesmtpip4t1737875628tq56f8j
X-QQ-Originating-IP: dSuhspBrpZepodpOAK+WeLWRIOsvgKzp9S08+qmng+c=
Received: from [IPV6:240e:3b7:3243:720::3fc] ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 26 Jan 2025 15:13:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17878363596574148830
Message-ID: <8B2016527B9BCFBA+ca2da5a3-e889-4191-b951-88656d1043ab@radxa.com>
Date: Sun, 26 Jan 2025 15:13:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git commit failed with mbedtls/framework
To: Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAJaLiFw134mzZk7TkJMgAppx11Xv3qZsbU-Y78XimX8jNbJtMA@mail.gmail.com>
 <CAEfUkUKp9wWhgBW2XFubhoccSGeU-CW3Y+FY+iJhfw7eVLZv_g@mail.gmail.com>
 <CAJaLiFzTjHWCw+ioPZv660yQ0XLM6+SMJh3NV=NYivbtE1Uf_Q@mail.gmail.com>
 <CAEfUkULhPuH15fDENXubhNPOQvbAjBv5f_yoeH7gjC4rhczxtA@mail.gmail.com>
 <20241118153742.GO3600562@bill-the-cat>
 <CAEfUkUJNOTCsh19VbKsHw9wWO1nn8o-OhRrAB46uhpKHO-Owsw@mail.gmail.com>
 <20241118164122.GQ3600562@bill-the-cat>
 <CAEfUkUJmSL8-XR6LUAKX=xW-mYQWNHzanRKvAVFaB2A9nA4W1A@mail.gmail.com>
 <20241118171811.GR3600562@bill-the-cat>
 <8823CB36AD9BEA6D+3c5f1842-bbaf-4dfa-96a6-d6d53b61ed10@radxa.com>
 <20250124182330.GQ60249@bill-the-cat>
Content-Language: en-US
From: ZHANG Yuntian <yt@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <20250124182330.GQ60249@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OOkRk9QS7mEBtNjWY+K0ez3aEdoGE5HE7TzbZTye7VqUvVPe49A5Ar+n
 94eJKha8/mVuvS2WFU7g8mvzhT9QJjRk2+DQiKdkjRxjWmR3GdYR4up3tZg3KrEw6g9YMoO
 L+Ef6LkyPy7FXk/14pMhrYfZ0phy6dYtjSom7jz7G7qDc2SI42FWQFkCje3ISlVKeCL/oDg
 nEACtU07kxB49N4pYymhL6Uth4R854Z4dS4MQCf79Z+bxWR1nKQbRVqVizIj9Rwp9iQU7BX
 /pBNuKbMEou+AZk4TbiO/uVtbQjrZfVCX4XOz5zec8i0FQ3HexFhCcxlQNQbcOGYCYxhw/t
 v04d4LCHqGfDx83yYBKtO/xc1Uv/bSATv2O9NpxTGyX/FnZ9J973dtjRr37I9DKt4zx6Tig
 AGoA+Y7CnYBepzccOoHtKnLoXAHszulKC2qzGZB90RYSWo1CLN7aRcJMCF4rla1DBpJ0SN4
 9NQjGzFZyilfLkMJoSIf1g6P+TZfZR0TFzp1gBgRiT8LI4oKiEyj1QrAGYhODluSZhikLbv
 Wt33oJDffiOsmHk7gUPBP5adWRoz6eQJF+kivc+H912v22m499tv2Y4l/LE/+S/8O3qo+RR
 1CbPYoF8EqWOSM4A2Ez8M1a8pobHSnmdJ54VvkMthU4walxRpluaphMTvIp0WD6zNgx6n0U
 5eCHCf/1Ml7vTKu/h+1rXvqua0ZmTHNCmRnfhqjHuwFuDw8/4hDXGIW5r+y+Iee+bHh6ZM4
 ZKqNEOgMWirzgChPleUgWPPQcN0fZHZXg3ahIOzAq1JqYG28zFkBxUlz7pW41GWT52kHXj9
 Iw3LQS6tS/zUzDoKSGPVxobVYBO+iUWUF0d9+yFSol06wh1S0aMk5okAHa0HH1r+tI348/X
 1vpPNUyGZOeA9cXO12mEGvvyv5WBD/7XTcaW3fu5+kRKoqEPCUujycXC9tbXBmc+D4hLk11
 gPpUoQDiE8jqMzMYvg55Jim3XS8GbiFUKF/Q=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Sun, 26 Jan 2025 14:09:21 +0100
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

Hi Tom,

On 2025/1/25 02:23, Tom Rini wrote:
> On Fri, Jan 24, 2025 at 02:05:28PM +0800, ZHANG Yuntian wrote:
>> Hi Tom,
>>
>> On 2024/11/19 01:18, Tom Rini wrote:
>>> On Mon, Nov 18, 2024 at 12:16:18PM -0500, Raymond Mao wrote:
>>>> Hi Tom,
>>>>
>>>> On Mon, 18 Nov 2024 at 11:41, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>>> On Mon, Nov 18, 2024 at 11:27:06AM -0500, Raymond Mao wrote:
>>>>>> Hi Tom,
>>>>>>
>>>>>> On Mon, 18 Nov 2024 at 10:37, Tom Rini <trini@konsulko.com> wrote:
>>>>>>
>>>>>>> On Mon, Nov 18, 2024 at 10:24:32AM -0500, Raymond Mao wrote:
>>>>>>>> Hi Tony,
>>>>>>>>
>>>>>>>> On Sat, 16 Nov 2024 at 02:39, Tony Dinh <mibodhi@gmail.com> wrote:
>>>>>>>>
>>>>>>>>> Hi Raymond,
>>>>>>>>>
>>>>>>>>> On Fri, Nov 15, 2024 at 1:55 PM Raymond Mao <
>>>>> raymond.mao@linaro.org>
>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Tony and Tom,
>>>>>>>>>>
>>>>>>>>>> On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@gmail.com>
>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Hi Tom,
>>>>>>>>>>> Hi Raymond,
>>>>>>>>>>>
>>>>>>>>>>> On Fri, Nov 15, 2024 at 1:09 PM Raymond Mao <
>>>>> raymond.mao@linaro.org
>>>>>>>>
>>>>>>>>> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi Tony
>>>>>>>>>>>>
>>>>>>>>>>>> On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@gmail.com>
>>>>>>> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi Tom,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Fri, Nov 15, 2024 at 11:27 AM Tony Dinh <
>>>>> mibodhi@gmail.com>
>>>>>>>>> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hi Tom,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Fri, Nov 15, 2024 at 6:17 AM Tom Rini <
>>>>> trini@konsulko.com>
>>>>>>>>> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh
>>>>> wrote:
>>>>>>>>>>>>>>>> Hi Tom,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I am on 2025.01-rc2, and I am trying to commit some
>>>>> files.
>>>>>>> The
>>>>>>>>> error
>>>>>>>>>>>>>>>> seems to indicate this framework directory might need
>>>>> some
>>>>>>>>>>>>>>>> modification. Did I miss something?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> error: 'lib/mbedtls/external/mbedtls/framework' does
>>>>> not
>>>>>>> have
>>>>>>>>> a commit
>>>>>>>>>>>>>>>> checked out
>>>>>>>>>>>>>>>> fatal: updating files failed
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> That's odd. You didn't happen to try out some of the
>>>>> previous
>>>>>>>>> lwIP
>>>>>>>>>>>>>>> iterations on that tree did you?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> No, I did not. The tree is clean with "make mrproper" and
>>>>> on
>>>>>>> the
>>>>>>>>>>>>>> master branch. I just did a git pull and worked on it.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I went and looked at
>>>>> https://github.com/Mbed-TLS/mbedtls.git.
>>>>>>> The
>>>>>>>>>>>>>> framework directory is pointing to a specific commit.
>>>>>>>>>>>>>> framework @ 3867faa
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I'll stash and repeat it on another clean tree.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I have the same commit error on a brand new tree.
>>>>>>>>>>>>>
>>>>>>>>>>>> I think you are talking about the test framework of MbedTLS's
>>>>>>>>> original testsuite,
>>>>>>>>>>>> am I right?
>>>>>>>>>>>> MbedTLS was ported into U-Boot as a git subtree and that
>>>>>>> framework is
>>>>>>>>> a git
>>>>>>>>>>>> submodule of original MbedTLS repo which was not included in
>>>>> the
>>>>>>>>> porting
>>>>>>>>>>>> of U-Boot since U-Boot has its own testsuite.
>>>>>>>>>>>
>>>>>>>>>>> Here is what I found.
>>>>>>>>>>>
>>>>>>>>>>> git clone https://github.com/u-boot/u-boot.git
>>>>> u-boot-master-test
>>>>>>>>>>> cd /usr/src/u-boot-master-test/
>>>>>>>>>>> patch -p1 <
>>>>>>> ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.patch
>>>>>>>>>>> git add .
>>>>>>>>>>> git commit . -m "arm: kirkwood: Enable bootstd and remove jffs2
>>>>> for
>>>>>>>>>>> Sheevaplug board" -e
>>>>>>>>>>>
>>>>>>>>>>> The git commit above gave out this error:
>>>>>>>>>>>
>>>>>>>>>>> error: 'lib/mbedtls/external/mbedtls/framework' does not have a
>>>>>>> commit
>>>>>>>>>>> checked out
>>>>>>>>>>> fatal: updating files failed
>>>>>>>>>>>
>>>>>>>>>>> So I tried to commit only the specific files, and it works OK.
>>>>>>>>>>>
>>>>>>>>>>> git commit configs/sheevaplug_defconfig
>>>>> include/configs/sheevaplug.h
>>>>>>>>>>> -m "arm: kirkwood: Enable bootstd and remove jffs2 for
>>>>> Sheevaplug
>>>>>>>>>>> board" -e
>>>>>>>>>>> [master 47de8cff2d] arm: kirkwood: Enable bootstd and remove
>>>>> jffs2
>>>>>>> for
>>>>>>>>>>> Sheevaplug board
>>>>>>>>>>>    2 files changed, 17 insertions(+), 19 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> I think it must be what Raymond said above. So perhaps during
>>>>> Tom's
>>>>>>> PR
>>>>>>>>>>> pull, the framework directory was created. But "git commit ."
>>>>> does
>>>>>>> not
>>>>>>>>>>> like the empty lib/mbedtls/external/mbedtls/framework directory.
>>>>>>>>>>>
>>>>>>>>>> Under the native MbedTLS git repo, by default it has a
>>>>> "framework"
>>>>>>>>> pointing to
>>>>>>>>>> its git submodule.
>>>>>>>>>> Maybe we should mark it in the gitignore.
>>>>>>>>>
>>>>>>>>> I've tried .gitignore but could not make it work (my Gitfu is
>>>>> pretty
>>>>>>>>> lousy). Can you suggest how that should be done?
>>>>>>>>>
>>>>>>>>> You can use the command without the '.' : git commit -m
>>>>> "<commit_msg>",
>>>>>>>> this
>>>>>>>> should work.
>>>>>>>>
>>>>>>>> @Tom Rini <trini@konsulko.com> Shall we remove both
>>>>>>>> "lib/mbedtls/external/mbedtls/.gitmodules" and
>>>>>>>> "lib/mbedtls/external/mbedtls/framework"? I can submit a patch if you
>>>>>>> agree.
>>>>>>>
>>>>>>> Can we do that and not make a problem for the next resync?
>>>>>>>
>>>>>>> Hmmm, no, this cannot be pulled back to the MbedTLS upstream so still a
>>>>>> problem
>>>>>> when resync.
>>>>>> Another option is to include that git submodule into the U-Boot project,
>>>>>> this needs
>>>>>> to revert the commit of introducing the library and redo the git subtree
>>>>>> after the
>>>>>> submodule is updated, but it does not seem to be a good choice as we
>>>>> don't
>>>>>> use
>>>>>> that test framework in U-Boot at all.
>>>>>> Right now I don't have a perfect solution, maybe we can accept using git
>>>>>> commit
>>>>>> without the '.'?
>>>>>
>>>>> Hmm. Maybe we just delete the .gitmodules / directory and it shouldn't
>>>>> be too hard to deal with on updates. I have to do some small fixups with
>>>>> the device tree ones anyhow sometimes.
>>>>>
>>>>> How about checking and deleting this in the subtree update script?
>>>> Then we can skip manually doing this each time.
>>>> I can make a patch for it if you feel fine.
>>>
>>> Lets worry about that if it's a problem when we resync next.
>>
>> I'm currently working with Jonas Karlman's Rockchip fork[1] which is based
>> on a416d9e680718de1c76c4196e1db77e3ca07662f. The fork is included as a git
>> submodule so we can provide distro packaging[2] that are unrelated to
>> U-Boot. We build our package with GitHub Action, and this issue currently
>> blocks us from checking out the code at all with the following workflow
>> snippet:
>>
>>        - name: Checkout
>>          uses: actions/checkout@v4
>>          with:
>>            submodules: recursive
>>
>> Related error logs are here:
>>
>> |> Fetching submodules
>>    /usr/bin/git submodule sync --recursive
>>    /usr/bin/git -c protocol.version=2 submodule update --init --force
>> --recursive
>>    Submodule 'src/rkbin' (https://github.com/rockchip-linux/rkbin.git)
>> registered for path 'src/rkbin'
>>    Submodule 'src/u-boot' (https://github.com/Kwiboo/u-boot-rockchip.git)
>> registered for path 'src/u-boot'
>>    Cloning into '/home/runner/work/u-boot-kwiboo/u-boot-kwiboo/src/rkbin'...
>>    Cloning into '/home/runner/work/u-boot-kwiboo/u-boot-kwiboo/src/u-boot'...
>>    Submodule path 'src/rkbin': checked out
>> '0f8ac860f0479da56a1decae207ddc99e289f2e2'
>>    Submodule path 'src/u-boot': checked out
>> 'f3231571f4f9c3f72dcb6458aaa2de2462c605df'
>>    Error: fatal: No url found for submodule path
>> 'src/u-boot/lib/mbedtls/external/mbedtls/framework' in .gitmodules
>>    Error: fatal: Failed to recurse into submodule path 'src/u-boot'
>>    Error: The process '/usr/bin/git' failed with exit code 128
>>
>> This issue potentially breaks all projects who include the recent U-Boot as
>> a git submodule in their GitHub Workflow.
>>
>> 1: https://github.com/Kwiboo/u-boot-rockchip/tree/rk3528-2025.04-wip
>> 2: https://github.com/radxa-pkg/u-boot-kwiboo/actions
> 
> What if instead of "submodules: recursive" you use a run statement?
> https://github.com/marketplace/actions/checkout-submodules
> 

We can certainly work around it in many different ways. But the point is 
that U-Boot is currently a broken repository in regard to git submodule 
operations, and require special treatments to integrate with existing 
pipelines. This was not the case before.

-- 
Best regards,

ZHANG, Yuntian

Operating System Developer
Radxa Computer (Shenzhen) Co., Ltd
Shenzhen, China

