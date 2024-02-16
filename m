Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDEFC48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 15:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93C7887E56;
	Fri, 16 Feb 2024 16:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="myR8jNSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE5EC87E50; Fri, 16 Feb 2024 16:00:41 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93B8B87E46
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 16:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1708095631; x=1708700431; i=xypron.glpk@gmx.de;
 bh=GR6Ou5Wm6CIkDVz1j1YI0atLBiIA+cIaB7eqZjZcHhM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=myR8jNSKONQ4bhe27f+ISXfXA0P4m4/IL3rlO1Wpe+MpDuFx59yoyv1JKHGAzsGA
 qBNCUG6iHOuAgZioO+QDhx1OFpndtGkv7p+Xvi791ctpHSUWZGHt4eursL9Ltn1kX
 yFugGGXuO7Rx7cnfyw8nT0G4Fshr2+sKluxmTiYdZVjlxNek5+2d3Xelz/MDRvjrI
 n0PTPed5uXan+GqGdd+BUvG1UxoTTwSFfG/I4nXSKVGxX4GDlkW3tmvwQFlw+zk9L
 5OqzLiC7AVrSxzbPauf8sd+MRC9puGNdCYi8Tp8s1ljDpM8XaxRDSQuthWEBRv4VN
 qTuaqvAPGMkcfShBHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSt8Q-1rOEwj1WGM-00UIty; Fri, 16
 Feb 2024 16:00:31 +0100
Message-ID: <84c6a0c6-376c-4fed-9f27-bee49c9b659c@gmx.de>
Date: Fri, 16 Feb 2024 16:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: Rework the gcc section to reflect general build
 instructions
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240215211025.690964-1-trini@konsulko.com>
 <20240215211025.690964-2-trini@konsulko.com>
 <45D1EDA6-C570-4F18-B937-57808BBCDFC2@gmx.de>
 <20240215212824.GF3040305@bill-the-cat>
 <6FCE298F-EE98-462E-B27E-EEF0796D0097@gmx.de>
 <20240215220032.GG3040305@bill-the-cat>
 <9B30B785-4711-4343-9402-3CF5DC7F0338@gmx.de>
 <20240216131835.GH3040305@bill-the-cat>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240216131835.GH3040305@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WQmQTUOTkCds5xIK79euOB4F4dskmepedizR5lwRFgaufa0L7E9
 P+Pmw5hIFWK2OJXtR8mqztyLp8ziboaUep7pGBJ3R5694ezZSvHj3JvvOpmwnybsw4vN8WJ
 mVzED2bZqwknxQMOBsuZAunbt6Z2E29uByYC9xb3JlqtbvYgSjbxlE8cgArzf+QrqDv/+lQ
 GPbL1i37mZNX8SLvcsHuw==
UI-OutboundReport: notjunk:1;M01:P0:Ge6LgKii0qs=;ijUJV8H9+Mdam0xmxeimwIhHFgw
 Mk7x1o5Yfh6TWaS+Zwr3UMIGbELunWCuMCAtpIsqlXwugrBk2vP9/vQqY7x4H5UbwapdaF5/e
 UQ0N1bsMZtU/kuVqZvf44sAlAYFNmnVbYpYBYFzC1gC2EjqbmRYyofDb/vJZQxYM9cQFENBXh
 cblG4fHmclm0+Hi/k96hb7CjDw6K56c5CayMReJMGmHgXgfK8I+3H3bCcwVG1QfbmME/K1BCk
 XlECd5knzOzdwGr5U88BZE5+mJp35N/MifWGxP3o6N2BXIzaOYvKp5yti/b5B5s+P775MXmpb
 cgt2G+lZcXUq94eMj0fwP4qSRj6UN8FR5WL+q76pvsBIZ9Vo78WH1yXKdNIQ0M+oPbUFamy1i
 yEWksLq4toXPEfi3rCgJ5gG5ho8EwRftF7+ni9SsrPJ26qPVjntbRCvufSpnbPNkiaffnKGWP
 3MgcVYApbEwo61/sVmKWLRe66HaT+Fztf/RU2YvorYgO9XhSYiXbKxsyvYk3kM6lbpkLKVRkZ
 I4OPs06pHVsABaDpPjdQTVKhVyseZP958FgxJApO3r5N/zT0JwL/8yO+slsZiQvmC3Hq4uwqb
 FL/mIOpDocOpAjvtew35/UbKiyExKSA8jXwbmbOVZ9slO040BdsStTttt6S1lMGf1NVD9ic7d
 C5UqnUF/lvGlLA6Z0hvbE9iSF+mXhTF1LTjqF4wPATEkC2s1ewiOuWj/sc9gYToNB58Mw/A9D
 OngKo9XhG/vqtfqACXyheXwcj4YLtsalbcmNEaaFnOEGgd9GdGxz3rr+1dv/I9Y+Qb1aJIWHl
 Bk1sWfG8za26CG1xnyT6VFbccVjOGFcC2abqn9yD7XccU=
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

On 16.02.24 2:18 PM, Tom Rini wrote:
> On Fri, Feb 16, 2024 at 12:20:14AM +0100, Heinrich Schuchardt wrote:
>>
>>
>> Am 15. Februar 2024 23:00:32 MEZ schrieb Tom Rini <trini@konsulko.com>:
>>> On Thu, Feb 15, 2024 at 10:53:59PM +0100, Heinrich Schuchardt wrote:
>>>>
>>>>
>>>> Am 15. Februar 2024 22:28:24 MEZ schrieb Tom Rini <trini@konsulko.com=
>:
>>>>> On Thu, Feb 15, 2024 at 10:24:40PM +0100, Heinrich Schuchardt wrote:
>>>>>>
>>>>>>
>>>>>> Am 15. Februar 2024 22:10:25 MEZ schrieb Tom Rini <trini@konsulko.c=
om>:
>>>>>>> The first big issue is that the "gcc" file talked a lot about the
>>>>>>> general build requirements as well, but was titled in a gcc-centri=
c
>>>>>>> manner. Solve this by renaming the file to compile.rst and more fu=
lly
>>>>>>> reflecting that it is general build instructions. Next, add a sect=
ion
>>>>>>> about the prebuilt toolchains that are recommended (as they are th=
e ones
>>>>>>> we use in CI), and update a few places to reference these vendor-n=
eutral
>>>>>>> tools.
>>>>>>>
>>>>>>> Next, we can include the reproducible builds section directly in t=
he
>>>>>>> compile instructions rather than as a small standalone file.
>>>>>>>
>>>>>>> Finally, we update the sandbox document to reflect both the name c=
hange
>>>>>>> as well as what is specifically required to build sandbox.
>>>>>>>
>>>>>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>>>>>> ---
>>>>>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>>>>> ---
>>>>>>> doc/arch/sandbox/sandbox.rst       |  5 ++-
>>>>>>> doc/build/{gcc.rst =3D> compile.rst} | 64 ++++++++++++++++++++++++=
=2B+----
>>>>>>> doc/build/index.rst                |  3 +-
>>>>>>> doc/build/reproducible.rst         | 27 -------------
>>>>>>> 4 files changed, 61 insertions(+), 38 deletions(-)
>>>>>>> rename doc/build/{gcc.rst =3D> compile.rst} (73%)
>>>>>>> delete mode 100644 doc/build/reproducible.rst
>>>>>>>
>>>>>>> diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandb=
ox.rst
>>>>>>> index 5f8db126657f..f2ed5a25c115 100644
>>>>>>> --- a/doc/arch/sandbox/sandbox.rst
>>>>>>> +++ b/doc/arch/sandbox/sandbox.rst
>>>>>>> @@ -39,11 +39,12 @@ integers can only be built on 64-bit hosts.
>>>>>>>
>>>>>>> Note that standalone/API support is not available at present.
>>>>>>>
>>>>>>> -
>>>>>>> Prerequisites
>>>>>>> -------------
>>>>>>>
>>>>>>> -Install the dependencies noted in :doc:`../../build/gcc`.
>>>>>>> +In addition to the normal dependencies shows in the :doc:`general=
 build
>>>>>>> +instructions <../../build/compile>` to enable display support SDL=
2 libraries
>>>>>>> +need to be available.
>>>>>>>
>>>>>>>
>>>>>>> Basic Operation
>>>>>>> diff --git a/doc/build/gcc.rst b/doc/build/compile.rst
>>>>>>> similarity index 73%
>>>>>>> rename from doc/build/gcc.rst
>>>>>>> rename to doc/build/compile.rst
>>>>>>> index 3c6465772729..ef9c8545835a 100644
>>>>>>> --- a/doc/build/gcc.rst
>>>>>>> +++ b/doc/build/compile.rst
>>>>>>> @@ -1,11 +1,19 @@
>>>>>>> -Building with GCC
>>>>>>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>> +Building U-Boot
>>>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>
>>>>>>> Dependencies
>>>>>>> ------------
>>>>>>>
>>>>>>> -For building U-Boot you need a GCC compiler for your host platfor=
m. If you
>>>>>>> -are not building on the target platform you further need  a GCC c=
ross compiler.
>>>>>>> +For building U-Boot you need the general build tools such as `mak=
e` and a C
>>>>>>> +compiler for your host platform. Next, if you are not building on=
 the same
>>>>>>> +architecture as the target platform you further need a C cross co=
mpiler.
>>>>>>> +Furthermore, some target platforms require additional host tools =
to be present
>>>>>>> +and their package names may vary slightly dependinng on the namin=
g scheme used
>>>>>>> +by a particular host OS.
>>>>>>> +
>>>>>>> +In general, GCC should be used for both the host and target C com=
piler. Using
>>>>>>> +:doc:`clang <clang>` is supported but please see the documented i=
ssues for it as
>>>>>>> +well.
>>>>>>>
>>>>>>> Debian based
>>>>>>> ~~~~~~~~~~~~
>>>>>>> @@ -69,6 +77,17 @@ Depending on the build target further packages =
may be needed:
>>>>>>> * riscv64 S-mode targets: opensbi
>>>>>>> * some arm64 targets: arm-trusted-firmware
>>>>>>>
>>>>>>> +Prebuilt
>>>>>>> +~~~~~~~~
>>>>>>> +
>>>>>>> +Another option, which the project uses for CI for example, is to =
use a prebuilt
>>>>>>> +toolchain. For the most part, we use the latest `kernel.org`_ pre=
buit binaries,
>>>>>>> +but there are a few architectures that require their own specific=
 toolchains
>>>>>>> +still.
>>>>>>> +
>>>>>>> +In general, examples found within the documentation here refer to=
 the tools
>>>>>>> +found here and exceptions will be noted where relevant.
>>>>>>> +
>>>>>>> Prerequisites
>>>>>>> -------------
>>>>>>>
>>>>>>> @@ -112,11 +131,11 @@ command line or export it beforehand.
>>>>>>>
>>>>>>>      CROSS_COMPILE=3D<compiler-prefix> make
>>>>>>>
>>>>>>> -Assuming cross compiling on Debian for ARMv8 this would be
>>>>>>> +Assuming cross compiling for ARMv8 this would be


Referring to Debian the CROSS_COMPILE value was correct.

After the change we have some value that is wrong for many or even most
distros.

Please, drop this change.

Best regards

Heinrich

>>>>>>>
>>>>>>> .. code-block:: bash
>>>>>>>
>>>>>>> -    CROSS_COMPILE=3Daarch64-linux-gnu- make
>>>>>>> +    CROSS_COMPILE=3Daarch64-linux- make
>>>>>>
>>>>>> GCC uses triples to specify the architecture. With the suggested ch=
ange building will fail on many distros, e.g. in our CI image.
>>>>>>
>>>>>> cf. https://gcc.gnu.org/install/specific.html#aarch64-x-x
>>>>>
>>>>> But this is what the kernel.org compiler is called, and for consiste=
ncy
>>>>> we should reference the reference compiler in our docs. I'm wanting =
to
>>>>> follow up and change everyone to use consistent names.
>>>>>
>>>>
>>>> Please, do not asume that Linux distros will change.
>>>>
>>>> Users will and should use the tools provided by their distros. Side l=
oading foreign binaries is a secutity risc which should be avoided.
>>>>
>>>> I cannot see what is inconsistent about sticking to triples.
>>>
>>> We need to be consistent within our docs, and we aren't today. And
>>> "-gnu" isn't a required suffix for aarch64 linux toolchains as not all
>>> distributions do that. I'd be open to wording suggesting that users
>>> install tools recommended by their vendors, but that still won't give =
us
>>> consistent names due to "aarch64-poky-linux-" being what other vendor
>>> tools will be.
>>>
>>
>> On which operating systems will CROSS_COMPILE=3Daarch64-linux- work for=
 the distro tools?
>>
>> On which will CROSS_COMPILE=3Daarch64-linux-gnu- work?
>
> Should we document what we test? We don't test distribution tools
> because then we would have to test some number of distributions. And
> distro tools can be too old. I guess the biggest problem is that I see
> distro tools as a fall back option and you see kernel.org prebuilt
> toolchains as a fallback option.
>

