Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708DDC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 17:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D505B88865;
	Thu, 13 Jun 2024 19:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ds28wJYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD89E88939; Thu, 13 Jun 2024 19:27:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C0AA8892B
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 19:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718299649; x=1718904449; i=xypron.glpk@gmx.de;
 bh=j1/PleMQtq2U2RiAD7u72J8Ae3yo410//nEQkz5Q4hM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ds28wJYknfK25xDIH4yVVTvL2gZnHA215WS3+dvGk/WWWY942OFzbfba5nAHMQAx
 Tx6d/NEC39dnHTTuLObrDENu/x5LRaAutS9Q8CGh2WjzWPNMFRoQn5Ja/NhGwhhIp
 zaQFm+k95DZAgS89CyqhfqTFcRFUj2D5smQD/yRhpjncDg5qDg1c+ANXI9JQEwf8a
 1RlTv9oHTDzwTYejGebCPxF8p/L2w15eF9uXD8kPrS66ycL7MK5lx9LmQfnecShxS
 vPCdPUpVxfUpdzE9dkdXjfm43+Xlmmabvil+7aDbZuJzTkcHGPyYJsdnLzXbsD/Vd
 T4/j2zEwojWDOgH9Pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCKC-1s5nAD0Lrg-00QHQ4; Thu, 13
 Jun 2024 19:27:29 +0200
Message-ID: <1604c2a7-d72e-491f-806f-da29d14f0a17@gmx.de>
Date: Thu, 13 Jun 2024 19:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
 <20240611210145.GM68077@bill-the-cat>
 <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
 <20240611225554.GO68077@bill-the-cat>
 <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
 <20240612172244.GG68077@bill-the-cat>
 <CAFLszThj1wmF4zOLDjSjHX1cg8RfiHMGgpbRccJ-VJu2dtihNw@mail.gmail.com>
 <20240612214001.GI68077@bill-the-cat>
 <CAFLszTiZSu+aN53kAPd2GXosXv09Ams+jFDi2xGU0wh+faO=dg@mail.gmail.com>
 <20240613154206.GO68077@bill-the-cat>
 <CAFLszThvhYKpxLhJOgXOkW244Cj6Au=+LqhzHTtYHtri_+tmEg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszThvhYKpxLhJOgXOkW244Cj6Au=+LqhzHTtYHtri_+tmEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D70R84e/rM13ug7gfcFPzL8CjOGhL1mChw1crG23GOLieP2fxuj
 xE48XZMr1icMzcylPKjwfYmcvm25gxxleX/HIpuFSCPZ58Kykr3s9qYTIxcokteewfuVunt
 RYTTGj90JAGE3pESW6PjkXJ5mOEw4OuPxEs2tKPIFM9S6W/tr4oZAohnz9rpiYK3noNG2Qg
 UsqZX8WWsfwlioVJt04tw==
UI-OutboundReport: notjunk:1;M01:P0:EOT7f3UUJao=;DHFcsoozHRT/4NgV6K7aqfFaU4Y
 /qY7VS0ML+GN9gSwJQMM41FcVBn+bXGrB91cu+x01oQhbjs6IFst9oYAD7S1lxQuJ9f5F5yse
 en9vwi1Qvi1UXwkHGjvUHcBQHY1cygSrur13LhdxWvqeQPQZaxHAQikIjL71Hh9VHMXEusvuo
 CRZzkLYlW/weeqjMDyonU51KY+mNEyHAVjsGya4MFKp/ZaUVmhyGVInu0AZbrdX3BSMJ6ryHJ
 ijyP3rDBnoAf3LByCG3Cusg4SLL7r76KyzJFnde74auQg9NHM5lMRisfXabJC4xVyfpOq+jkr
 XlosAdRRRf1E6/QrBxPb6aCgiBhSWxwelrKa/3zVu+/SzP9K5XZaavh95yBLzWSjiQSuB5uAZ
 2qr5dXiLrSmVBcygHB/yrOXkhuEBoSSTLXsIawGsz6TqW6BZ4opJNty0UsJEg1eOgNxxnzssi
 BkOdeupXXo1O4LsLP+Ofcq4dCrl1elKNu5Vc+VbjCvSgCMO2ZSvIPPGaNstUsK3/M5KfqPsbW
 3lmhRCcDA2fpt+jo6IR2Qj9jM2mF5OGvvX91W53Cl1RqgFQiSH5uZbiG6p81FleNp1bwQuZRL
 uJDyrvDmG5nB9vz5DB47jB+LNGcwcgnCwVb29llJwNy6fNdez15BhRa2T69vZScNdyk3IaCep
 rbZRE0+gSGLydD2L39lo+1AZvuwGjdmx7ia6SPM70tjqH/YhKY7NjHigWCkACzr75YBtFUGO7
 lppNc2PFYGpnZE5PgmtQm2dKgozw1F3Kw/YHiPZbp93XvUNRHMzyivtp04JPpJO9hfyuOQ1U5
 mnQK0+Z2AJ6qrbQ+wrywtcvoWpZYUVPuB5C9mwrG8Y8IE=
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

On 13.06.24 18:59, Simon Glass wrote:
> Hi Tom,
>
> On Thu, 13 Jun 2024 at 09:42, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Thu, Jun 13, 2024 at 09:22:15AM -0600, Simon Glass wrote:
>>> Hi Tom,
>>>
>>> On Wed, 12 Jun 2024 at 15:40, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Wed, Jun 12, 2024 at 02:24:25PM -0600, Simon Glass wrote:
>>>>> Hi Tom,
>>>>>
>>>>> On Wed, 12 Jun 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
>>>>>>
>>>>>> On Tue, Jun 11, 2024 at 08:41:39PM -0600, Simon Glass wrote:
>>>>>>
>>>>>> [snip]
>>>>>>> Also IMO there is only really one LMB list today. We create it at =
the
>>>>>>> start of bootm and then it is done when we boot. The file-loading
>>>>>>> stuff is what makes all this confusing...and with bootstd that is
>>>>>>> under control as well.
>>>>>>>
>>>>>>> At lot of this effort seems to be about dealing with random script=
s
>>>>>>> which load things. We want to make sure we complain if something
>>>>>>> overlaps. But we should be making the bootstd case work nicely and
>>>>>>> doing things within that framework. Also EFI sort-of has its own
>>>>>>> thing, which it is very-much in control of.
>>>>>>>
>>>>>>> Overall I think this is a bit more subtle that just combining allo=
cators.
>>>>>>
>>>>>> I think this gets to the main misunderstanding. The problem isn't
>>>>>> handling bootstd, or EFI boot, or even assorted scripts. Those are =
all
>>>>>> cases where things are otherwise (sufficiently) well-defined. The
>>>>>> problem is "security" and that a "carefully crafted payload" could =
do
>>>>>> something malicious. That's why we have to do all of this stuff soo=
ner
>>>>>> rather than later in our boot process.
>>>>>
>>>>> That's the first I have heard of this, actually, but a bit more deta=
il
>>>>> would help. How does the payload get loaded? I'm just not sure about
>>>>> the overall goals. It seems that everyone else is already familiar -
>>>>> can someone please take the time to point me to the details?
>>>>
>>>> Well, the short version I believe of the first CVE we got (and so
>>>> started abusing LMB) was along the lines of "load an image near where
>>>> the U-Boot stack is, smash things for fun and exploits".
>>>
>>> OK. I am surprised that LMB does not catch that. It is supposed to add
>>> the stack and various other things right at the start before loading
>>> any file. So even if it clears the LMB each time, it should not be
>>> able to do that. Having said this, the code may be buggy as I don't
>>> think we have tests for U-Boot's overall functional behaviour in these
>>> situations.
>>
>> Right, LMB does catch the example I gave (because we made all of the
>> load from storage/network functions init an lmb and we always make sure
>> a new lmb gets U-Boot stack/etc). The next thing we didn't catch was
>> "what if EFI does the loading?" and we've kludged around that, and in
>> turn had some of the thorny questions. Some of that is what I think
>> you're asking about in this part of the thread, to which the answer is
>> "EFI spec says you need to place X in memory", so we just need to
>> reserve it when it's asked for, so that something else can't come along
>> and smash it maliciously.
>
> OK I see. Of course it isn't just EFI that has this issue. I believe
> the answer (for small blocks) is to use malloc(), which I think we do
> with a few exceptions which Ilias pointed out. For things like the TPM
> log and ACPI tables we should probably use a bloblist, as we do on
> x86. For large things (like loading a kernel) we should use LMB. I've
> been thinking about how best to tie this to boot, as opposed to random
> allocations in U-Boot itself, which would lead to fragmentation and
> strange behaviour. I think bootstd is a great place to have a
> persistent LMB. It can be attached to bootstd_priv.
>
> My hope is that EFI is just another boot method, where
> already-allocating things are presented to the OS. Apart from the
> Ilias exceptions, I believe this is how it works today.
>
> Where I think this heads in the wrong direction is using
> EFI-allocation functions before we are booting an EFI image. EFI has
> no concept of what is 'in empty space' so it leads to the lmb
> conflict, the subject of this discussion.

EFI binaries can return to the command line interface.
EFI binaries may be drivers that stay resident and run in the background
after returning to the command line interface. They might for instance
provide block devices.

Device-paths must be created from EFI pool memory as they may be freed
via FreePool() according to the EFI specification. And these we create
whenever a block-device is probed.

We should not make any assumptions that conflict with the UEFI
specification.

In our initial discussion with Ilias one idea was to merge LMB and EFI
memory management. This merged system would have to consider the
requirements of the UEFI specifications like a finer grained memory type
system and page boundaries.

Best regards

Heinrich

>
> This is all quite subtle and probably worthy of a VC discussion.
>
>>
>> But that also raised the more general problem, and why we need a
>> persistent reservation list, of allowing boards/SoCs to say they want t=
o
>> reserve a block of memory for whatever, and have that obeyed, for real.
>> For example, the mach-apple logic of "just pick some memory locations t=
o
>> use for kernel/dtb/initrd" isn't really as safe as it should be since
>> those reservations aren't really seen anywhere once the function
>> returns, it's just setting some environment variables.
>
> Yes, that part of it I understand. Somehow I either didn't see or
> forgot that board_late_init() code. With the script-based boot it
> makes some sort of sense, but with bootstd we should have allocation
> of addresses dealt with there. I have held off on retiring
> kernel_addr_r etc. as the scripts are still in use. But perhaps it
> would be a good time to convert bootstd to use lmb instead?
>
> Regards,
> Simon

