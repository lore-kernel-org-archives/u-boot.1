Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C221E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2F9801E8;
	Tue,  7 Jan 2025 16:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gibvUniG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92A57801FD; Tue,  7 Jan 2025 16:47:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7942B801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736264867; x=1736869667; i=xypron.glpk@gmx.de;
 bh=VEYcfoF3OjgrJbun1O6lMLxZf6Nlel9InV2OnbD8EqU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gibvUniGyUZzV7mJ5KKqFhDgyVi4T8jscKgiBzwzVl2lQWjSC1hfdFFOamdm6mVA
 AIv8KSmXngZgj854hZ8fdzCsLeBfRI9+LzFM9fdRdc3p843Vay9+WfnaWCbivKCt9
 CEutMXXEW6UNGHHB5f7Bmbxo+pL11AW5O2XGcQuSoY9BiYhgRTOWxTMG5428jkM4F
 Nx3hVEBtc0yKQ3P/wkeERUl44LAn7fjr7va94NvZ0PcgeP7zEAVITIhuv5Gqka8/w
 Mqr76tSRLAsdPVMYTE+CJSTpYlcXf7A9roqLP1OTwGnlaYrisB8Piqi7cGGX78fjT
 NYyxPX0w1uF6LK01Kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRMs-1t1Rba3bvY-00Ly4n; Tue, 07
 Jan 2025 16:47:46 +0100
Message-ID: <0d35cb20-3509-419b-ad4e-7736a35398f0@gmx.de>
Date: Tue, 7 Jan 2025 16:47:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
To: Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
References: <20250106144755.3054780-1-sjg@chromium.org>
 <51c61e63-82ae-4660-b2c8-987a63c7d091@gmx.de>
 <CAFLszTi5dxQyf_wRpGWRz9S7YsETpeRxA3_YJrhm+Lp0uw7bmw@mail.gmail.com>
 <3b854695-990e-47f3-a9b8-34b1b2790d28@gmx.de>
 <CAFLszTieNX4-JJqQrdNdm+sBhnBHZrAwawvQ+J-D3s118uob2w@mail.gmail.com>
 <20250107151127.GI3476@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250107151127.GI3476@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vrt6z4WTP5xbP+bTXPXbyNgCMPw4ks/H65pKIpqMzD4VUK7sCsB
 +yzkwQqVJMKEOvzh9s5lKSh/BxuUYqLkVp4aV2ZRWoU/4H7UWNCoGpGIiu+TOYm+ylx7itm
 pyVbZvxFQ2E6cw1vTsUmLkoiOw593+iPXn99V1ULVe2xJitQgq2d5uz9KYzruHrNJqVMxTz
 4neGsF2d0oTmIpwgK6yUA==
UI-OutboundReport: notjunk:1;M01:P0:5Ma+QmBKFvM=;M9gIJytDElSeZ5ewxxPyqYjc8VT
 w8g0wnLV5/9aKYZe0z5P+7imwD6WXhdv1m7LVYFOtJrPHUQ4ZvdOy8pg5WCi0fVkcKwsxKTtK
 YnQQw3hB4MYFjNruBIwb0z8M8mjv5g+0Vxu/ab+McMZFT58uL5BUKkgFslo4fblQ/AwH79zEe
 gsQ8dZ7kJjaoTfjUXMbhZHrxUgS5daLr5zoGHAr44sM1Tt8bnaJ2pwxqgxKUutwuNu5J2XLhO
 tw6qOftFx/QRvC2y8OPkFfLRjHADgkPbBD5IgM6J8uogmcWHv1j+jQuvf4BubPupawSczoaEW
 LS2FKcofsTyrd1OfCeO/WpXzFgi9QBD24OfZWLngt4aQqjIcGCc7rhhMNbY11A6Uuu8ztNRoy
 YpRos8LK16NYhrcpC7Kf8i4rX+v/RTf+mquwFj7CUdj9VOrYJd8nqaehNpQuRWAbq8dOLApps
 DUc2QscBn2Wuy82c8TbbC1027DmuYvx6ZC4GJKtiGx8P3BUdqO1//+jnhRjmHu7P8bhI8h2JX
 /0AjVKA99hz69oTwW/FaizRKvQT+VT+9GbZ6EhXHH+HECHyHp+eJKEoZscEdZ+BHS1ZqoUD66
 Cd2I2NP1azNaJ0GjhMX2JfU0ExS9BrE9keD5aEXPlog/dzWNVv4Hldzbu9yjmrRYYl7iSP8zI
 2gtg/svsOKz3bHfKVGc2MMakQekw8MmdAERj3lz+mysNL/CBW8Q1LiejfST/DPPReU30cn+KR
 T2SXr1dyTMbq3ixNU4gQXVCVvTtv/zZEmwlxEOriKm4R6y7IoSF74oxAgUqbQtVfHUsLCYZ6m
 +32w9qKQy9/O4uX+udeRZDxC1v+YOp2c1+7IaWxF1Ej8lF+v88CcX16v7ovdUexCwke4sch/W
 /LeSQMLfpkNLuevkhjcqKrSpJQHTq9zHNL9e9PMugrI5pnfKV+zzwfZc+lJZvcF1/hkOUCESn
 KUIgtrT5eCoKYSEJTs3WQz+KtTrhKF4keP4JMJmRigkDKP7OgMy51D+ZMZ15YiL1PN0jZN4Oh
 z04d6io8uMqGL3+NH5MpMVYTf4KShkvNqMK14wK8HiJ9bPP/dBb32KcAWRtz6628ODR7pDA37
 5BP+CflQ7/rb4roQkzEzNpRNtqb0wk
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

On 07.01.25 16:11, Tom Rini wrote:
> On Tue, Jan 07, 2025 at 06:57:50AM -0700, Simon Glass wrote:
>> Hi Heinrich,
>>
>> On Tue, 7 Jan 2025 at 06:11, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>>
>>> On 07.01.25 13:15, Simon Glass wrote:
>>>> Hi Heinrich,
>>>>
>>>> On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
>>>>>
>>>>> On 06.01.25 15:47, Simon Glass wrote:
>>>>>> This test was hamstrung in code review so this series is an attempt=
 to
>>>>>> complete the intended functionality:
>>>>>>
>>>>>> - Check memory allocations look correct
>>>>>> - Check that exit-boot-services removes active-DMA devices
>>>>>> - Check that the bootflow is still present after testapp finishes
>>>>>>
>>>>>> The EFI functionality duplicates bootm_announce_and_cleanup() and s=
till
>>>>>> uses the defunct board_quiesce_devices() so a nice cleanup would be=
 to
>>>>>> call the bootm function instead, with suitable modifications. That =
would
>>>>>> allow bootstage to work too.
>>>>>>
>>>>>> This series is based on sjg/master since the EFI logging was reject=
ed so
>>>>>> far.
>>>>>
>>>>> Yes, it was rejected because a solution at the lib/log.c level would=
 be
>>>>> more generic.
>>>>
>>>> As I mentioned, that idea isn't suitable for programmatic use.
>>>
>>> What can be done with show_addr("mem", rec->memory); that log_debug()
>>> does not offer or which you could not do with a new log function in
>>> lib/log.c that takes variadic arguments?
>>
>> There are asserts in [1], for example. How do you propose to handle
>> that? See [2] for my previous explanation, quoted here:
>>
>>> CONFIG_LOG with a bloblist option would be a great idea, but it's hard
>>> to programmatically scan text...plus only the external call sites are
>>> actually logged.
>>
>> Also see the discussion on the original patch [3]. There was also your
>> reply at [4], but I think you missed that this is intended for use in
>> unit tests (i.e. with ut_assert()).
>>
>> You also requested that this be generalised, rather than being
>> EFI-loader-specific. I have no objection to that, but don't have a use
>> case for it yet, so have deferred that to later. It's a fairly simple
>> change, if/when needed. If the series was not NAKed, I'd be happy to
>> do it now.
>>
>>>>
>>>>>
>>>>> Tom suggested not to send patches that are for private enjoyment to =
the
>>>>> mailing list.
>>>>
>>>> My contributions to U-Boot are only ever about private enjoyment :-)
>>>>
>>>> Do you have any comments on the patches?
>>
>> Regards,
>> Simon
>>
>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250106144755.305=
4780-6-sjg@chromium.org/
>> [2] https://lore.kernel.org/u-boot/CAFLszTjxOE_037+kR0jgdax80sBombYo_k0=
YgiuVnP=3DKZCOvuA@mail.gmail.com/
>> [3] https://lore.kernel.org/u-boot/CAC_iWjKtaN54B98OKbkoXkC_GmKJ=3Dx+M4=
=3DUY_O6roSOpZaDxag@mail.gmail.com/
>> [4] https://lore.kernel.org/u-boot/D513D326-41A6-425E-B11F-85958065BCD2=
@gmx.de/
>
> Looking at the logging portions of the original series again, especially
> if this was made generic, we probably don't want to print to actual
> console every time we're making a note of some memory allocation for
> example, that would be unreadable outside of a debug context. The point
> of this really seems to be "log things for verifying in tests later".
> Does that end up being useful? I don't know. Heinrich or Ilias, do the
> tests in [1] look generally useful?
>

The tests in [1] are not documented, not even in the commit message. So
the reasoning behind the tests remains Simon's secret.

At first sight the tests in [1] don't make much sense. E.g. that only a
subset of memory types have been used does not tell that the right
memory type has been used for the right object.

Implementing a specific tracing functionality for EFI is definitively
the wrong way forward as it will lead to code duplication.

We already have function _log() which is variadic.

Simon could write a new log driver that parses the `format` parameter
and saves the binary data in an appropriate format for analysis by the
unit tests:

* For %s the driver should save the string and not the address of the
string.
* For %pD the driver should save the device path instead of the pointer.
* ...

Some changes to the log driver interface will be needed to pass the
variadic arguments instead of the formatted message.

Best regards

Heinrich
