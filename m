Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80ECCD4F57
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54C758667B;
	Fri, 22 Sep 2023 12:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=goldsimon@gmx.de header.b="go9ASZ0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4379686741; Fri, 22 Sep 2023 12:57:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049CB86679
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=goldsimon@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695380216; x=1695985016; i=goldsimon@gmx.de;
 bh=kAOITjjGx90C42azeSRYjX7Y/tKhT2KmmKKm4lbSOpc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=go9ASZ0D0jWuedUbg4uFcKSszcjrToaatGblVC8+aF/tnZctV1s5HMISNvG/Nrc6irVfjU/flS4
 LR5Dvs8LaH5lICqlfntf6kkhSmmXQwd1KJyYzmgnxN3uTJNyDZ/mfimTxFyrOoaHLHH/1fc5mfR25
 ttGBsg+p13LcTJSyBuzbl6gEVMwFYQAAW553IGHL5WYHDSLAQywqDDHU6D8KUVykbVbaDExE1Lt3O
 YjEhjoJ/l0Y3akw7ucxFWv+FNeujBQuZQBRaBL6xrWppT1ld69EJftl9a3gUHZpNDfker9HUweDTH
 0tzrzY+SWQpNAafkTVN8rq762g5Wij8bn/Tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.88] ([176.199.209.230]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQnP-1qtECz2v5p-00Gswx; Fri, 22
 Sep 2023 12:56:56 +0200
Message-ID: <0b714a3e-b46d-b954-e99f-a372d7124780@gmx.de>
Date: Fri, 22 Sep 2023 12:56:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv8 00/15] net/lwip: add lwip library for the network stack
To: Simon Glass <sjg@google.com>, Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 joe.hershberger@ni.com, rfried.dev@gmail.com
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135922.GC305624@bill-the-cat>
 <CAD8XO3bWmefyQ7Dx8fn7kc3s8=uCUhG3FcE6J4H6=qFdwa3gmw@mail.gmail.com>
 <CAPnjgZ2Y6FJELJX7RA3_PehnCQ7zaiCeQd-VKJmtj_8nwnv3_w@mail.gmail.com>
 <CAD8XO3Ynafpncs42KPX9sDw-5VQHQpwJq=22SzXDi27Dz6rrEg@mail.gmail.com>
 <CAC_iWjJXHraJ2gEMgUGaRxjQxM1JUwP+jTNUiftngY1ubcEq6Q@mail.gmail.com>
 <93c9133d-b259-c093-64f4-2acdcedd0dc2@gmx.de>
 <CALeDE9MBUd2_8TZ87PJXx_jF0D6zqGV9FY2vQCSkxG4P2GJ-JQ@mail.gmail.com>
 <20230913131423.GI305624@bill-the-cat>
 <CAD8XO3aq9+KDOUXKtURaL8UwX96RLqqwAhDz=U2924BfUdz9+g@mail.gmail.com>
 <CAPnjgZ0frgZ=i7ED71ifpvWAtv0PG9DbwbKQ3Hzf6PHkfgnraQ@mail.gmail.com>
Content-Language: en-US
From: Simon Goldschmidt <goldsimon@gmx.de>
In-Reply-To: <CAPnjgZ0frgZ=i7ED71ifpvWAtv0PG9DbwbKQ3Hzf6PHkfgnraQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6VkBUXcAOcl4N18EPoMtYgQ/P8zgu584Y2jX/1iONGKbE9X31aH
 jRDXHTVovqboBoc1KnnNi2UW3KE2+e1uAMsm1A9I8vGUN00JFuGqs7gUEHV2kmVPriBuHim
 GQQp9XRakv4Sfmp2tIZSRUn5fa5Ue/CRkbl3wLNXiiB6/OgtFr67yJWsLNk2Y0553u9RaAe
 ytKWTz7PcYCGVVEubTKyg==
UI-OutboundReport: notjunk:1;M01:P0:DLq4rAMYSYM=;U6LQDsyYViWpsCQF+8SOg3zmqJW
 4WWDvlfXOAefmtCMH+wHSxNDYhOpZGJgMiuCCYuvzdJXtmc6LrRM5vsF+L0TXs1MmvzTjvDnw
 CrzaP3rvOsr6+jzbx6LC9Ly2cTHLQQXN/NoihbPfTUU6tcp0iQAlgNSeJzhKWCaERUrDwsQkb
 AVR8sbGhcaBtnR0Yzmn5lgtB3MWVeJeRFzTh37CMN/UEAf8vswxMqAVOqCHPG5ITqSFOkB7Rg
 RQai7bwKweDO4vSDy4OJ2hZ/jiPDZzbAws9ymb3rG+PUtx7K4VusJELv10t1/mVkD1p77o6r2
 gsKmDa0eIOPcHXjr0SVNgfLeK70x4C5IggH4mN1VNXU2aIfXI8bjYQoIO7rRCeSIgrKmlY5mC
 I8hGRyWoH6LuRzZJHTJwKacmcbkdP2fz0Fmdqgoxeb8z1I4Yw3hevF4emBXMKpbqNsVQSEhAL
 s31TQ8e08iBXJwh7xACeN8JeNhm6RwafChs3l5n8CirV0/i2QQoO6eyBaSMZl20VTkTGKfGPM
 6ZVLRzzzKav/nIwQLFTOAAiiW0ttrwGmweNPKKL4/IAVE0pIvYLzasUZje6zFcNpEHwCLS3DN
 zgkjmZi1AWOQN9rY2HMHJW7PxZ9p6hS5gTrQa8PPbjwxRex53j7K2Pqr3zZTO9hDaqJxPVvbN
 g2yFWvK+HUZUEJ0F1LqpqHDoCNNgyPHDfVjyGqt1/zP7Ge2RwGrA+l0H40L3QA7CS7vRSmb2P
 OtuDBhF6G9EVPbeVpSPSAI9w7Th31tkmwJ/jtCLru52b/aKGZ7F0FrwAXcto+XO8ATfClHtOh
 cBv5A9+F45ulSApl3VSyjR0IznRUsX5oZinIk/paxkPh2USCY9bhLmONFKTH1SUA+26FsTtYq
 pTejxNE9HRI//SdV6M4HnDND87CTwjMjUWWw3F6P1sYyd54xHgIkJ6FAPAg9vICkjSM1AX2tM
 GgyXYdEB44Rxoi9ywPKsrBQZt0k=
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



On 21.09.2023 18:29, Simon Glass wrote:
> Hi,
>
> On Wed, 13 Sept 2023 at 07:35, Maxim Uvarov <maxim.uvarov@linaro.org> wr=
ote:
>>
>>
>>
>> On Wed, 13 Sept 2023 at 19:14, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Wed, Sep 13, 2023 at 11:06:13AM +0100, Peter Robinson wrote:
>>>>>>> Then if for development you need  to pull he history of lwip, you =
can do it with:
>>>>>>> git pull -s subtree lwip  master --allow-unrelated-histories
>>>>>>> (but I think nobody will need this.)
>>>>>>>
>>>>>>> New update of the lwip net/lwip/lwip-external dir will be done wit=
h:
>>>>>>> git pull -s subtree lwip  master --allow-unrelated-histories --squ=
ash
>>>>>>> Squash commit also has to be git format-patch friendly.
>>>>>>>
>>>>>>> If you are ok with that proposal I will send v9 with the first pat=
ch created with steps above.
>>>>>>
>>>>>> We've gone through this before.  The whole purpose of this is not
>>>>>> having to maintain patches.
>>>>>> Simon, instead of "I had problems in the past", can you elaborate a=
 bit more?
>>>>>>
>>>>>> Tom said he is fine with subtrees instead of submodules and I know =
for
>>>>>> a fact EDK2 doesn't have too many issues with submodules.
>>>>>> Their documentation is pretty clear on building and requires
>>>>>>
>>>>>> git clone https://github.com/tianocore/edk2.git
>>>>>> cd edk2
>>>>>> git submodule update --init
>>>>>>
>>>>>> Perhaps the situation has improved since you had issues?
>
> Nope.
>
>>>>>
>>>>> While I don't really care how you solve this technically, I'd *stron=
gly*
>>>>> be interested for U-Boot to use *unmodified* lwIP sources where an
>>>>> explicit reference to an lwIP commit is used. I'd rather integrate
>>>>> bugfixes for U-Boot into lwIP than having the sources drift apart.
>>>>
>>>> Strongly agree here, we want to use upstream and all the combined
>>>> development and reviews etc rather than forking off and ending up wit=
h
>>>> yet another slightly different IP stack. The whole advantage of
>>>> adopting LWIP is the advantage of combined security, features and bug=
s
>>>> from a wide range of projects :-)
>>>
>>> Yes, this is what I want as well, and why I'm perhaps more agreeable
>>> with the approaches where it's a lot harder for us to start forking
>>> things unintentionally.  I gather submodule rather than subtree would =
be
>>> better for that case?
>>>
>>> --
>>> Tom
>>
>>
>> Yes, submodule will be a much better solution for us. And I also don't =
think that today
>> there are any issues with submodules. It works well of OE, RPM and DEB =
builds,
>> distributions should not have problems with it.
>
> My particular experience is with coreboot. Some problems I have:
>
> 1. Updating the modules doesn't work and I need to reset, try the
> --init thing, fetch things manually, etc. etc.
> 2. In ChromiumOS coreboot we can't use submodules internally since
> each package has its own build script. E.g. we need to build coreboot
> separately from its blobs, fsp, external libraries, etc. At least
> there we can do this, but if U-Boot adopts a submodule for a core
> feature, this is going to create no end of problems.
> 3. It makes it impossible to patch lwip for any fix we need for a releas=
e
> 4. We still have to 'fast forward' to a new commit every now and then,
> which really is no easier than doing a merge commit for the changes
> since the last sync, is it?
>
> Really, we need a maintainer for the lwip piece, if we are to adopt
> it. Using submodules is not a substitute for that.

As an lwIP maintainer, I cannot step up as a maintainer of lwIP in
U-Boot, however, I can assure you I will do my best to work with you on
integrating fixes into upstream lwIP if required.

Without wanting to promote using submodules: all other examples of lwIP
being copied into another repository have practically never resulted in
bugfixes being sent back to us (ok, that's not 100% true, but we do get
them only once in a while) and being like that, those projects are
facing problems upgrading our stack in turn. I wouldn't want to be a
maintainer of such code, either.

Regards,
Simon
