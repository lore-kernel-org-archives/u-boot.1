Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DFAC0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 13:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746A0807FE;
	Fri, 24 Jan 2025 14:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1D0F807FE; Fri, 24 Jan 2025 07:05:58 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C29803B5
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 07:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=yt@radxa.com
X-QQ-mid: bizesmtpip2t1737698729tn48m30
X-QQ-Originating-IP: uMcjJVxhU5bm/dmG71KsBQODW69yN6rHUROohlmjNFY=
Received: from [IPV6:240e:3b7:3243:720::3fc] ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 24 Jan 2025 14:05:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15178379872724816623
Message-ID: <8823CB36AD9BEA6D+3c5f1842-bbaf-4dfa-96a6-d6d53b61ed10@radxa.com>
Date: Fri, 24 Jan 2025 14:05:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git commit failed with mbedtls/framework
To: Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
 <CAEfUkUJOd03fc5VERRPY18LWMomEbYFRnkHSJcFLcdnPq4=8jA@mail.gmail.com>
 <CAJaLiFw134mzZk7TkJMgAppx11Xv3qZsbU-Y78XimX8jNbJtMA@mail.gmail.com>
 <CAEfUkUKp9wWhgBW2XFubhoccSGeU-CW3Y+FY+iJhfw7eVLZv_g@mail.gmail.com>
 <CAJaLiFzTjHWCw+ioPZv660yQ0XLM6+SMJh3NV=NYivbtE1Uf_Q@mail.gmail.com>
 <CAEfUkULhPuH15fDENXubhNPOQvbAjBv5f_yoeH7gjC4rhczxtA@mail.gmail.com>
 <20241118153742.GO3600562@bill-the-cat>
 <CAEfUkUJNOTCsh19VbKsHw9wWO1nn8o-OhRrAB46uhpKHO-Owsw@mail.gmail.com>
 <20241118164122.GQ3600562@bill-the-cat>
 <CAEfUkUJmSL8-XR6LUAKX=xW-mYQWNHzanRKvAVFaB2A9nA4W1A@mail.gmail.com>
 <20241118171811.GR3600562@bill-the-cat>
Content-Language: en-US
From: ZHANG Yuntian <yt@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <20241118171811.GR3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mom5ezI3X1cDL63Pt+0Wio1EP2o7nuq8uxtvOgMTCMHFRcCE1sLovxu4
 jJzSewwe4HcMFoCShY97c9IKwnf7fawtDgU285+62lwqtRqYh1+Dxz0zTuQlV4uMniO5jmG
 ZoWwGrlsyc0EfaTVkMVJ7x9DXfttxn5LB5wpXdfKhFbsaGcjF2Q3LDK5DaZXKULuh9tkzV0
 WZgoGGewai594xsQpcEZtMbJDLbsrzdkxiZxEc+Tj6gK3niCoNvnT3YknGXx/QVwCXL0uGY
 r0hjC+jW3+a/NPfVx5jhd9S6xcZVLff4si5Qpk+mAOR461WX9DD7baD8lZNRNfORzfnq4NO
 ktzGzna1uPLqE40ZRO5eCcU5hXmO/93Kg06YJWrt+xy6isHY0CUUBTc1oKASHzY9xlq+ETn
 1Mq42AIpu7rxesQlCzmuYuPcsNv6Oo1iZ4uZjhGKLyaNJS2wAbgUjKxnUCjhWnGIuM49s2g
 HqrzLYoWvFjRKmVoK7YTDpaoYO1bajkrtopdNlor63ANnRbfel5JoeL/SaGyH4h9+S0V7u+
 RnhXek4z34deoAoZdNjzbXyfat+s90457p9Rka3Yy/KqithK4BEeSz0Er0BjD03Nk445wtA
 XbqiLChHQEvKTKMoM3doBaHathxyJ/3v9oJOGzjjNgS2LXKG/hhRdlhYXkB+XevZLjZ8gbq
 UBfeu8Cnn3Pf3FqoC84cuhy4VJcbT9jyrxuWrw4d1r0y8AYcWUvRCWY4LnOhFKBOYcM/UD2
 FQfY4Z1JwrnEDjPsuM3hXb9zY7hLRREPx0tMpq6dbXeSg7QkYmIkyy46PugP7swYmN3LHQ9
 6LWMAuQ6J0hyoTYRgkUBxxHb4xnqWkSLl+WHa/iEUgAtQ1vXCWpi/ux1Jyjlf8yUbnhydsM
 wRjZEqbacU6VNGOmCO7YxuswgVjvWEHLevHb6ya1+kqlPxdSosKVVWkuBI6cHEDhldN6tmN
 SmDA=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Fri, 24 Jan 2025 14:01:57 +0100
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

On 2024/11/19 01:18, Tom Rini wrote:
> On Mon, Nov 18, 2024 at 12:16:18PM -0500, Raymond Mao wrote:
>> Hi Tom,
>>
>> On Mon, 18 Nov 2024 at 11:41, Tom Rini <trini@konsulko.com> wrote:
>>
>>> On Mon, Nov 18, 2024 at 11:27:06AM -0500, Raymond Mao wrote:
>>>> Hi Tom,
>>>>
>>>> On Mon, 18 Nov 2024 at 10:37, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>>> On Mon, Nov 18, 2024 at 10:24:32AM -0500, Raymond Mao wrote:
>>>>>> Hi Tony,
>>>>>>
>>>>>> On Sat, 16 Nov 2024 at 02:39, Tony Dinh <mibodhi@gmail.com> wrote:
>>>>>>
>>>>>>> Hi Raymond,
>>>>>>>
>>>>>>> On Fri, Nov 15, 2024 at 1:55 PM Raymond Mao <
>>> raymond.mao@linaro.org>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> Hi Tony and Tom,
>>>>>>>>
>>>>>>>> On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@gmail.com>
>>> wrote:
>>>>>>>>>
>>>>>>>>> Hi Tom,
>>>>>>>>> Hi Raymond,
>>>>>>>>>
>>>>>>>>> On Fri, Nov 15, 2024 at 1:09 PM Raymond Mao <
>>> raymond.mao@linaro.org
>>>>>>
>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Tony
>>>>>>>>>>
>>>>>>>>>> On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@gmail.com>
>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Hi Tom,
>>>>>>>>>>>
>>>>>>>>>>> On Fri, Nov 15, 2024 at 11:27 AM Tony Dinh <
>>> mibodhi@gmail.com>
>>>>>>> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi Tom,
>>>>>>>>>>>>
>>>>>>>>>>>> On Fri, Nov 15, 2024 at 6:17 AM Tom Rini <
>>> trini@konsulko.com>
>>>>>>> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh
>>> wrote:
>>>>>>>>>>>>>> Hi Tom,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I am on 2025.01-rc2, and I am trying to commit some
>>> files.
>>>>> The
>>>>>>> error
>>>>>>>>>>>>>> seems to indicate this framework directory might need
>>> some
>>>>>>>>>>>>>> modification. Did I miss something?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> error: 'lib/mbedtls/external/mbedtls/framework' does
>>> not
>>>>> have
>>>>>>> a commit
>>>>>>>>>>>>>> checked out
>>>>>>>>>>>>>> fatal: updating files failed
>>>>>>>>>>>>>
>>>>>>>>>>>>> That's odd. You didn't happen to try out some of the
>>> previous
>>>>>>> lwIP
>>>>>>>>>>>>> iterations on that tree did you?
>>>>>>>>>>>>
>>>>>>>>>>>> No, I did not. The tree is clean with "make mrproper" and
>>> on
>>>>> the
>>>>>>>>>>>> master branch. I just did a git pull and worked on it.
>>>>>>>>>>>>
>>>>>>>>>>>> I went and looked at
>>> https://github.com/Mbed-TLS/mbedtls.git.
>>>>> The
>>>>>>>>>>>> framework directory is pointing to a specific commit.
>>>>>>>>>>>> framework @ 3867faa
>>>>>>>>>>>>
>>>>>>>>>>>> I'll stash and repeat it on another clean tree.
>>>>>>>>>>>
>>>>>>>>>>> I have the same commit error on a brand new tree.
>>>>>>>>>>>
>>>>>>>>>> I think you are talking about the test framework of MbedTLS's
>>>>>>> original testsuite,
>>>>>>>>>> am I right?
>>>>>>>>>> MbedTLS was ported into U-Boot as a git subtree and that
>>>>> framework is
>>>>>>> a git
>>>>>>>>>> submodule of original MbedTLS repo which was not included in
>>> the
>>>>>>> porting
>>>>>>>>>> of U-Boot since U-Boot has its own testsuite.
>>>>>>>>>
>>>>>>>>> Here is what I found.
>>>>>>>>>
>>>>>>>>> git clone https://github.com/u-boot/u-boot.git
>>> u-boot-master-test
>>>>>>>>> cd /usr/src/u-boot-master-test/
>>>>>>>>> patch -p1 <
>>>>> ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.patch
>>>>>>>>> git add .
>>>>>>>>> git commit . -m "arm: kirkwood: Enable bootstd and remove jffs2
>>> for
>>>>>>>>> Sheevaplug board" -e
>>>>>>>>>
>>>>>>>>> The git commit above gave out this error:
>>>>>>>>>
>>>>>>>>> error: 'lib/mbedtls/external/mbedtls/framework' does not have a
>>>>> commit
>>>>>>>>> checked out
>>>>>>>>> fatal: updating files failed
>>>>>>>>>
>>>>>>>>> So I tried to commit only the specific files, and it works OK.
>>>>>>>>>
>>>>>>>>> git commit configs/sheevaplug_defconfig
>>> include/configs/sheevaplug.h
>>>>>>>>> -m "arm: kirkwood: Enable bootstd and remove jffs2 for
>>> Sheevaplug
>>>>>>>>> board" -e
>>>>>>>>> [master 47de8cff2d] arm: kirkwood: Enable bootstd and remove
>>> jffs2
>>>>> for
>>>>>>>>> Sheevaplug board
>>>>>>>>>   2 files changed, 17 insertions(+), 19 deletions(-)
>>>>>>>>>
>>>>>>>>> I think it must be what Raymond said above. So perhaps during
>>> Tom's
>>>>> PR
>>>>>>>>> pull, the framework directory was created. But "git commit ."
>>> does
>>>>> not
>>>>>>>>> like the empty lib/mbedtls/external/mbedtls/framework directory.
>>>>>>>>>
>>>>>>>> Under the native MbedTLS git repo, by default it has a
>>> "framework"
>>>>>>> pointing to
>>>>>>>> its git submodule.
>>>>>>>> Maybe we should mark it in the gitignore.
>>>>>>>
>>>>>>> I've tried .gitignore but could not make it work (my Gitfu is
>>> pretty
>>>>>>> lousy). Can you suggest how that should be done?
>>>>>>>
>>>>>>> You can use the command without the '.' : git commit -m
>>> "<commit_msg>",
>>>>>> this
>>>>>> should work.
>>>>>>
>>>>>> @Tom Rini <trini@konsulko.com> Shall we remove both
>>>>>> "lib/mbedtls/external/mbedtls/.gitmodules" and
>>>>>> "lib/mbedtls/external/mbedtls/framework"? I can submit a patch if you
>>>>> agree.
>>>>>
>>>>> Can we do that and not make a problem for the next resync?
>>>>>
>>>>> Hmmm, no, this cannot be pulled back to the MbedTLS upstream so still a
>>>> problem
>>>> when resync.
>>>> Another option is to include that git submodule into the U-Boot project,
>>>> this needs
>>>> to revert the commit of introducing the library and redo the git subtree
>>>> after the
>>>> submodule is updated, but it does not seem to be a good choice as we
>>> don't
>>>> use
>>>> that test framework in U-Boot at all.
>>>> Right now I don't have a perfect solution, maybe we can accept using git
>>>> commit
>>>> without the '.'?
>>>
>>> Hmm. Maybe we just delete the .gitmodules / directory and it shouldn't
>>> be too hard to deal with on updates. I have to do some small fixups with
>>> the device tree ones anyhow sometimes.
>>>
>>> How about checking and deleting this in the subtree update script?
>> Then we can skip manually doing this each time.
>> I can make a patch for it if you feel fine.
> 
> Lets worry about that if it's a problem when we resync next.

I'm currently working with Jonas Karlman's Rockchip fork[1] which is 
based on a416d9e680718de1c76c4196e1db77e3ca07662f. The fork is included 
as a git submodule so we can provide distro packaging[2] that are 
unrelated to U-Boot. We build our package with GitHub Action, and this 
issue currently blocks us from checking out the code at all with the 
following workflow snippet:

       - name: Checkout
         uses: actions/checkout@v4
         with:
           submodules: recursive

Related error logs are here:

|> Fetching submodules
   /usr/bin/git submodule sync --recursive
   /usr/bin/git -c protocol.version=2 submodule update --init --force 
--recursive
   Submodule 'src/rkbin' (https://github.com/rockchip-linux/rkbin.git) 
registered for path 'src/rkbin'
   Submodule 'src/u-boot' 
(https://github.com/Kwiboo/u-boot-rockchip.git) registered for path 
'src/u-boot'
   Cloning into '/home/runner/work/u-boot-kwiboo/u-boot-kwiboo/src/rkbin'...
   Cloning into 
'/home/runner/work/u-boot-kwiboo/u-boot-kwiboo/src/u-boot'...
   Submodule path 'src/rkbin': checked out 
'0f8ac860f0479da56a1decae207ddc99e289f2e2'
   Submodule path 'src/u-boot': checked out 
'f3231571f4f9c3f72dcb6458aaa2de2462c605df'
   Error: fatal: No url found for submodule path 
'src/u-boot/lib/mbedtls/external/mbedtls/framework' in .gitmodules
   Error: fatal: Failed to recurse into submodule path 'src/u-boot'
   Error: The process '/usr/bin/git' failed with exit code 128

This issue potentially breaks all projects who include the recent U-Boot 
as a git submodule in their GitHub Workflow.

1: https://github.com/Kwiboo/u-boot-rockchip/tree/rk3528-2025.04-wip
2: https://github.com/radxa-pkg/u-boot-kwiboo/actions

> 

-- 
Best regards,

ZHANG, Yuntian

Operating System Developer
Radxa Computer (Shenzhen) Co., Ltd
Shenzhen, China

