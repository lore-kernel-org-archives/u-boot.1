Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61696C4829C
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 16:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85CFA8751B;
	Mon, 12 Feb 2024 17:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bW0H7UbL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AE078751B; Mon, 12 Feb 2024 17:52:12 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C44C875FC
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 17:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707756728; x=1708361528; i=xypron.glpk@gmx.de;
 bh=9ZAHXYtzTaMdLzrdicSOulsuYoe4s63XrJbz5SUXkyw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=bW0H7UbLHu0zWda4GRqCyr83o/iVAvKautYd7mavlXDx/+k26DnLtmXJn7WTOGRV
 EXDDcKwKAK/rYPFjr+o3Cs4j4tEX7ZVX7+MeTAIKXSgOoTu+I6cY1epyVlDL2vIAZ
 x3y4oQhdeat1LlrYxNS5xZslQ2MV+iOHkRYgNgx5c2AVTJr9PlonpP9kJEmEqzxEv
 2mhdSP8rdCnA30wHQH2I4a56zzE7bIID/rzvMmOy8Kj3hduzviV21odjkOL+7BoFu
 UhYsIo989u+bYKtGOlEiDIShPjk0EDGVm0hTy+qBGc7qVr1hgRy9FpRnUP+Si8xk8
 ZU2hH6ymZxtlJDvzPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlKy-1r4vc00kK0-00ds3q; Mon, 12
 Feb 2024 17:52:08 +0100
Message-ID: <ca87001b-2713-4fdc-8d93-9bfc7008bb02@gmx.de>
Date: Mon, 12 Feb 2024 17:52:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/develop/codingstyle.rst: Clarify include section
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@gmail.com>
References: <20240209143520.2724221-1-trini@konsulko.com>
 <CAByghJYCzN4Nm0mThc1QXMKk8KSPRZwwL2pp4ucLv7iwJsMSJg@mail.gmail.com>
 <20240212161909.GF3040305@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240212161909.GF3040305@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hVzd/EMUUHtBZ076CNYxpbpOUT1Ady2HrXQq7WeBl2h13O+WrzG
 MSJlt5gZ8ZeFaUav4zN37Mefst5JQKGYG8LEYeVqYsxxKEBslTC7usEoGWYyLx0CEgEk7v7
 oOMZuiaMAm1DvE/mBM+RE/HyGYTesizjBEE2qEIJbnFkmDxXTTGbYT5BzKd6O3x0NYohEKj
 h2wDqFxc6pveG64x4KA3Q==
UI-OutboundReport: notjunk:1;M01:P0:dxKMYCrgxuo=;IXbsSiyaJ2IhrrjR9+6B6vFGq0S
 zxGD/rJ3ETqVHrr024hPwwqyt8XEgUT8ZaAJBPIkph0d4EM+lvftB2IL/kmMS6Lxz1ta5gVpN
 zfQkkH0ZLhvKJKT9TRlzP1qOp1lwBySZh1Be6hKunc1ZJqRQ9STYJvCcRhNgIJSxmQZsEJht0
 +ruTcPUat+otZlgKjrkyuwZYoAHj3UwIwizxkMHL4f6/gFa3cNzjjhgJFjA4EPysSUZ9l2XIr
 Fj9fHiuplj3pXH9uJF0VFGdofkPteFLXnlmiF929ncXQzTwpLG9YkgAl70+4YRDuGYSBSTCoM
 PgQkHCpeWoifcBZ6J+Ts5uqZQtz4h13KNS9TEvCYJd3GS6eb+SULxbiaR01MfyXzZFAqha99/
 8CipAQevfpasT+fv7uhWNt6PkZoIcER0jWqaCJIswjZg+z1g0RCbzHXY/3JsSa7OblZHwYunk
 02CBoFevUZ9eh/XS7u85fh7fMAcugOz6JLqDQOJQ3HdFCdHyzu2C6tgTmvplklmhkeXIYevwX
 bDQFaYswFQ1KlAOcxKGQsiB6xpf0Ao+eikhhvLfW8SMTZMbZGCpWDwY2UlI6QmdYPO3d2P1ub
 6eO7Q5J/zX1fQxa4EmQgpNGJL6GprVR8wwNMA9ZD7XqTJG/bjCvpXN/qvvomhFXk81l5dpWrU
 PMiIvq+XWufRFRTZ1hnM4erJR8BE+nhHkyJhW1O3WaPYQ2VLKnfKvoo5XAS54VrxrqBYZT+LL
 NBRqMGm1HzuM5sFSLBLRkAm09QuZCKJRG/ktpfTLDvV0sFzQIBCCm5EC4mCqJAa3HlSwncm2R
 nyQT2N1s56EllXu7gDUAT58XQTJioXdUBO21L/M5eusL0=
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

On 12.02.24 17:19, Tom Rini wrote:
> On Sun, Feb 11, 2024 at 06:53:47PM +0100, Igor Opaniuk wrote:
>> Hi Tom,
>>
>> On Fri, Feb 9, 2024 at 3:52=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
>>>
>>> Rework the section about includes slightly. We should not be using
>>> common.h anywhere, so remove that from examples and ask people to send
>>> patches removing it when found. Doing this also means we need to rewor=
d
>>> other parts of this section. Be clearer about using alphabetical
>>> ordering.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>>   doc/develop/codingstyle.rst | 23 +++++++++++------------
>>>   1 file changed, 11 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
>>> index b25bfbd271f0..cdf5aedfcbb0 100644
>>> --- a/doc/develop/codingstyle.rst
>>> +++ b/doc/develop/codingstyle.rst
>>> @@ -108,30 +108,29 @@ expected size, or that particular members appear=
 at the right offset.
>>>   Include files
>>>   -------------
>>>
>>> -You should follow this ordering in U-Boot. The common.h header (which=
 is going
>>> -away at some point) should always be first, followed by other headers=
 in order,
>>> -then headers with directories, then local files:
>>> +You should follow this ordering in U-Boot. In all cases, they should =
be listed
>>> +in alphabetical order. First comes headers which are located directly=
 in our
>>> +top-level include diretory. This excludes the common.h header file wh=
ich is to
>>> +be removed. Second are headers within subdirectories, Finally directo=
ry-local
>>> +includes should be listed. See this example:
>>>
>>>   .. code-block:: C
>>>
>>> -   #include <common.h>
>>>      #include <bootstage.h>
>>>      #include <dm.h>
>>>      #include <others.h>
>>>      #include <asm/...>
>>> -   #include <arm/arch/...>
>>> +   #include <asm/arch/...>
>>>      #include <dm/device_compat.h>
>>>      #include <linux/...>
>>>      #include "local.h"
>>>
>>> -Within that order, sort your includes.
>>> -
>>> -It is important to include common.h first since it provides basic fea=
tures used
>>> -by most files, e.g. CONFIG options.
>>> -
>>>   For files that need to be compiled for the host (e.g. tools), you ne=
ed to use
>>> -``#ifndef USE_HOSTCC`` to avoid including common.h since it includes =
a lot of
>>> -internal U-Boot things. See common/image.c for an example.
>>> +``#ifndef USE_HOSTCC`` to avoid including U-Boot specific include fil=
es.  See
>>> +common/image.c for an example.
>>> +
>>> +If you encounter ccode which still uses <common.h> a patch to remove =
that and
>> nitpick: s/ccode/code/g
>
> Whoops, Heinrich can you please fix when applying?
>

Hello Tom,

I am missing here some text about the includes that are automatically
included, e.g.

linux/kconfig.h
include/generated/autoconf.h

Maybe you could describe this in a future patch.

We still have 4107 files including common.h. Should we have a Migration
warning in Makefile?

Best regards

Heinrich

