Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3DBCA550A
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 08:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09B9386564;
	Wed, 13 Sep 2023 10:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=goldsimon@gmx.de header.b="L2+0LM9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1907386571; Wed, 13 Sep 2023 10:43:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 036BC86545
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 10:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=goldsimon@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694594584; x=1695199384; i=goldsimon@gmx.de;
 bh=GyTtqBBfXFK66i9b9vqDuhLWtoD12wXyg2sas+flGiU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=L2+0LM9rutjxNcS5IFDkryhcGC9KMYTQWheKMxElGEMjxfNfajrcncxAtHoDtimInl+15oCwpjt
 E7aflkdld9wv6r0hWxuYn1gcC1Idvea7ipPDZdMq0ds95e8BiqT7nAeoNWnTRda7kq5LWQ++Kd+T8
 KD1YCDgX48qhOx3PLSrITrz7/TRhDguFI8RBqK5CK8UysG6RY2XGBw+CwhOZ144EOShgHwcrV3YbS
 y6CtQ9jESTv937YmgIpFEHs7R0NW3zpC2EbIZIgVBvpIBiBgQZlpHyB45Z+FKxEPGxshSyEiJJEOw
 sajnXbtYhoNo8Ffd3shtjUJfBC5HIVAS4CBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.88] ([176.199.209.230]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLiCo-1qxsLX3pAW-00HbA2; Wed, 13
 Sep 2023 10:43:03 +0200
Message-ID: <93c9133d-b259-c093-64f4-2acdcedd0dc2@gmx.de>
Date: Wed, 13 Sep 2023 10:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCHv8 00/15] net/lwip: add lwip library for the network stack
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Simon Glass <sjg@google.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, pbrobinson@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135922.GC305624@bill-the-cat>
 <CAD8XO3bWmefyQ7Dx8fn7kc3s8=uCUhG3FcE6J4H6=qFdwa3gmw@mail.gmail.com>
 <CAPnjgZ2Y6FJELJX7RA3_PehnCQ7zaiCeQd-VKJmtj_8nwnv3_w@mail.gmail.com>
 <CAD8XO3Ynafpncs42KPX9sDw-5VQHQpwJq=22SzXDi27Dz6rrEg@mail.gmail.com>
 <CAC_iWjJXHraJ2gEMgUGaRxjQxM1JUwP+jTNUiftngY1ubcEq6Q@mail.gmail.com>
From: Simon Goldschmidt <goldsimon@gmx.de>
In-Reply-To: <CAC_iWjJXHraJ2gEMgUGaRxjQxM1JUwP+jTNUiftngY1ubcEq6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9R148iffvUPqvGQHAoAYMMrLLBb8zW7hEo4+q0DzwcmkhiUGwXe
 tHFDK49henZcosPQr8+6DCHfxjjg+5DorO3S/i4DGAHxm/bXdTX/GbgMmaoIfoQnztvvioN
 0cmT00QW2dyPrL+1HvUxDM1gWQcSCBp/xAINVyZK/nEUbU903UGND0UHyz3QNBahnG8WdE5
 h23Kh+t+qObKCyl4az42w==
UI-OutboundReport: notjunk:1;M01:P0:fUFvI1DTn5U=;4fNAprl6sLyzl0kk6W8COfXXDbJ
 4JLkH36WOpmiYVX8fThh7kktgSmRpwdGfeg9A3/Y8ZgdhDurzUhtGNWE54F2ROEsJ/W5TV6H/
 A+3j8PFmJ219juBPZ3+xqlX3qTVp4GghlpQUl27sp2O8e5aPi7cCWK8SGTUmz7eefukvcCXoT
 zPgxNY26SPAAQE0ofQiCK41Mk1aGGQ4d7Sux3vA9NoBmSXhl3XcIFPpkg+Xe9X4c3DR1vMIg2
 sK1OhHZAI3I0xa3bX7TknZGkuzH6RKnNnVoX/YlWqF4o26zVlDN9bfnbmJSQIk8UhZCUaX3Zh
 NE1U3VsBZnl/rZizprs2G/xJYGIoGALY2S557YmWYKrGlcQqxx20/bkxvVAJhTeF9URmwECmu
 mFLj6yc+rChsA56JZLP/Mnq9U1wzzra7kHejGIrnsD9o+r9uNjyyR0Oyx88+stJpAVg9i+/Bb
 xmwpDJJ4QNfIL7uup/sKSi83YNOD2zuml5WSCp0yDiwt0vTMnBYAednHVtZV2gfCnGqyQ4mdI
 DAx86rstEy2fO9f25TZ50bXVw43Rlr4YeV8kJjjEBJhFpMOXBLr/Ss361pi59eC7pnTQ8m1mu
 vy91waW/ARf4a0W+YalS/fM2m5xpjLHrlYW3o1MyCgsUMMbzh2EDRhQF7wPWXlUopWCmpzTE6
 6yrtHfCsn7WO4BvI2iPGd2JUjF4PNjAn/iKn8ZjOXiD49U1LHQFa9PKToJ1DsEeTltVwFi+nL
 WDZs/kWyl99+ErBKLZcvFNQRi8HtUctK+i+OzyePI5HsG7QaG19QePAmVWJLWC26F0XrDW+pB
 FoF3RI1eGT6cBkEKsSqXooz2owwodymaZwKL04RC0muG97pEjNddyHPgDDIr2H6Os1ZrMrUpv
 iS/dN1APK3VZY0n846ordnbDQSUkC/ejYyBQaeqnqUr1tH/99rquNg1vG45J5Y/06mU3TmLM1
 BQmUZg==
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



On 13.09.2023 09:53, Ilias Apalodimas wrote:
> Hi Maxim,
>
> On Wed, 13 Sept 2023 at 10:32, Maxim Uvarov <maxim.uvarov@linaro.org> wr=
ote:
>>
>>
>>
>> On Wed, 13 Sept 2023 at 01:27, Simon Glass <sjg@google.com> wrote:
>>>
>>> Hi Maxim,
>>>
>>> On Tue, 12 Sept 2023 at 05:42, Maxim Uvarov <maxim.uvarov@linaro.org> =
wrote:
>>>>
>>>> On Fri, 8 Sept 2023 at 19:59, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>>> On Fri, Sep 08, 2023 at 07:53:05PM +0600, Maxim Uvarov wrote:
>>>>>
>>>>>> Before apply these patches it  is needed to create lwIP merge into
>>>>> U-Boot:
>>>>>> git subtree add --prefix net/lwip/lwip-external
>>>>> https://git.savannah.nongnu.org/git/lwip.git master --squash
>>>>>> or
>>>>>> create git submodule, depends how it's more easy to maintain extern=
al
>>>>>> library.
>>>>>
>>>>> So, I think we're going to go with subtree.  Please work out how to
>>>>> integrate the above in to the build process automatically (and such =
that
>>>>> we can maintain it via upgrades moving forward).
>>>>>
>>>>> --
>>>>> Tom
>>>>>
>>>>
>>>> I did not find a good way to friend git format-patch, git am and subt=
ree.
>>>> And now with using subtree I can provide my thoughts, in general I do=
 not
>>>> see any big advantages
>>>> with maintaining subtree code.
>>>>
>>>> Problem is that:
>>>>
>>>> 1. subtree does some root reset. So rebase looks like:
>>>> label onto
>>>>
>>>>
>>>>
>>>> # Branch acbc0469a49de7055141cc730aa9c728e61b6de2-2
>>>>
>>>> reset [new root]
>>>>
>>>> pick acbc0469a4 Squashed 'net/lwip/lwip-external/' content from commi=
t
>>>> 84fde1ebbf
>>>> label acbc0469a49de7055141cc730aa9c728e61b6de2-2
>>>>
>>>>
>>>>
>>>> reset onto
>>>>
>>>> merge -C ec4a128c8d acbc0469a49de7055141cc730aa9c728e61b6de2-2 # Merg=
e
>>>> commit 'acbc0469a49de7055141cc730aa9c728e61b6de2' as
>>>> 'net/lwip/lwip-external'
>>>> pick 739681a6f5 net/lwip: add doc/develop/net_lwip.rst
>>>>
>>>> pick f0ecab85e0 net/lwip: integrate lwIP library
>>>>
>>>> 2. if  --rebase-merges option was not provided to rebase, then rebase=
 will
>>>> omit subtree directory and try to apply rebase patches to root direct=
ory.
>>>> I.e. in current case squashed commit for lwip, will be applied to ubo=
ot
>>>> root directory instead of ./net/lwip/lwip-external.
>>>>
>>>> 3. due to broken rebases without --rebase-merges more likely things l=
ike
>>>> git bisect also will not work.
>>>>
>>>> 4.  change in subtree code ./net/lwip/lwip-external/../something.c wi=
ll
>>>> create a git commit which looks like a standard U-Boot commit. I.e. p=
ath
>>>> starts with ./net/lwip/lwip-external/
>>>
>>> I don't really understand most of the above, but I take it that
>>> subtree has some problems...I did find an article about subtree [1]
>>>
>>>>
>>>> 5. lwip maintains code with a mailing list.  So we don't need to push
>>>> subtree git somewhere to create a pull request.
>>>>
>>>> 6. I rechecked the latest edk2 and they use submodules now. (openssl,
>>>> libfdt, berkeley-softfloat-3 and others).
>>>>
>>>> 7. dynamic download also looks horrible for me. I.e. create subtree i=
n
>>>> Makefile on compilation process. I think maintaining that will give y=
ou a
>>>> bunch of problems. I think we should not touch git structure after cl=
oning.
>>>>
>>>> So what I can here suggest:
>>>> 1.  lwip source code is 9.4M.  If we compare all code it will be 564M=
 in
>>>> total. So just having 1 commit witn copy of lwip library will work he=
re.
>>>
>>> So we add a 9.4MB patch for the code we need? I suppose that is OK,
>>> although it is much larger than net/ today (0.5MB).
>>>
>>> What is the churn on lwip? E.g. would it be easy to add a commit every
>>> few months to bring in upstream changes?
>>>
>>>>
>>>> or
>>>>
>>>> 2. use git submodules. Size of the project will be lower.  Submodule =
will
>>>> not allow you to use local changes. I.e. change needs to be merged in=
to the
>>>> upstream project and then you can update git HEAD for the submodule.
>>>
>>> I really don't want to work with a submodule project. I've just had
>>> too many problems.
>>>
>>>>
>>>> or
>>>>
>>>> 3. inside u-boot.git create branch lib-lwip and clone lwip repo there=
. Then
>>>> use git submoule to connect this branch as a folder to the main U-Boo=
t code.
>>>
>>> It really needs to be properly part of U-Boot.
>>>
>>
>> Ok. Then more likely we don't need all the git history of lwip inside u=
boot.git. Then the option with a single commit is more preferable.
>> Then we can use part 2 of this article, how to  go with standard git co=
mmands:
>>
>> 1.
>> <cmd>
>> git remote add -f lwip https://git.savannah.nongnu.org/git/lwip.git
>> git read-tree --prefix=3Dnet/lwip/lwip-external -u lwip/master
>> git commit -m "lwip merge sha: xxxx"
>> </cmd>
>> this will create a git format-patch friendly commit. Then we send it to=
 the mailing list  and apply.
>> I hope the mailing list will allow us to send a 7.8 MB patch.
>>
>>
>> Then if for development you need  to pull he history of lwip, you can d=
o it with:
>> git pull -s subtree lwip  master --allow-unrelated-histories
>> (but I think nobody will need this.)
>>
>> New update of the lwip net/lwip/lwip-external dir will be done with:
>> git pull -s subtree lwip  master --allow-unrelated-histories --squash
>> Squash commit also has to be git format-patch friendly.
>>
>> If you are ok with that proposal I will send v9 with the first patch cr=
eated with steps above.
>
> We've gone through this before.  The whole purpose of this is not
> having to maintain patches.
> Simon, instead of "I had problems in the past", can you elaborate a bit =
more?
>
> Tom said he is fine with subtrees instead of submodules and I know for
> a fact EDK2 doesn't have too many issues with submodules.
> Their documentation is pretty clear on building and requires
>
> git clone https://github.com/tianocore/edk2.git
> cd edk2
> git submodule update --init
>
> Perhaps the situation has improved since you had issues?

While I don't really care how you solve this technically, I'd *strongly*
be interested for U-Boot to use *unmodified* lwIP sources where an
explicit reference to an lwIP commit is used. I'd rather integrate
bugfixes for U-Boot into lwIP than having the sources drift apart.

Regards,
Simon

>
> Thanks
> /Ilias
>>
>> Thanks,
>> Maxim.
>>
>>
>>
>>
>>
>>
>>>
>>>>
>>>> BR,
>>>> Maxim.
>>>
>>> Regards,
>>> Simon
>>>
>>> [1] https://www.atlassian.com/git/tutorials/git-subtree
