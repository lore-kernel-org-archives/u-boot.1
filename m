Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8969D66B86
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 22:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F538895F0;
	Tue, 26 Nov 2024 23:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="OZsLAACJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC6B896DA; Tue, 26 Nov 2024 23:50:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9274489335
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 23:50:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732661446; x=1733266246; i=xypron.glpk@gmx.de;
 bh=4mt2sqBBLZBJHaFl/YJoi6rRwdVLFiHKJ31gOSRYOy0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OZsLAACJiKEqug91IlTvBXSIjdMtReYlbCKaDJEPi16qzZwjWFLQKwg3tusyfchC
 Dvla35zQjlD1R2Ku1gDtX9htXcuLifZngdBtmQcYDIrW1CWLTUBbVBCe9HT8FFv6t
 svijLEyuQoFHKpPUqeEbwiJftfOvF2MVs92IfT5lFeh9J6chtTMdxmrNTqBDvkE9T
 wtsCaV7PuePiwyI4vbREbRS0Hib4nyzlV8/KAVmwJNt8mXYiOX+nu6fTxQ7YP4LgP
 PLzToC9KaEk9mhPeMGlzpbdbLHq88lFOcGOYpDBBnowNin4x7MS3yvH9vkY04N0B/
 QbFhnR5yq4Mx6SPWrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.104.206]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbox-1t4imT23YZ-00W5Hh; Tue, 26
 Nov 2024 23:50:46 +0100
Message-ID: <aa7134ee-97dc-4fcc-b739-0f97e57817fd@gmx.de>
Date: Tue, 26 Nov 2024 23:50:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] efi_loader: Move some memory-function comments to
 header
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-6-sjg@chromium.org>
 <d415c887-bb0c-47e8-bfd4-d0049f596367@gmx.de>
 <CAFLszTiOp56JkV1u5qOdJUYH2vJ5YHWwpBUmhb8WWiNs2S0B+w@mail.gmail.com>
 <20241126155508.GR3600562@bill-the-cat>
 <CAFLszThjgZtYrc707w8D+PZULJQB8qpNxgDYnAV+UoNebaPm8g@mail.gmail.com>
 <20241126223332.GV3600562@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241126223332.GV3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nR8X9yIVHOuzSPOuxfCrAg5PDJEZc8Khn9df6e9YrZWviIucKgB
 qUQlHsD/lhkYZxgUqT7Ir05/2LlPFC+ooJqESBKOAM7QR4StMD/8gtWRlzDQEV9tH2eCiih
 939d6DDRyu9RwT0bEipOx5ZUxJVj/OREWKnC4Nai2smRLaQoyA2Pb1hdO81tNug3vyShdZi
 ngOfQc5pWNBKuirmXbQFQ==
UI-OutboundReport: notjunk:1;M01:P0:p1/w2AjA0Bw=;CNwZg8XkB1RAsLyW0Uhqp6mHKLW
 Vxdyj08AeNZCSxkExiOaIceHw6CLDiZ5k30wd3qPHhi75WN4tYs6P0y91S6JQoJ8m2JgTmw36
 mFkZ+i9P0VNp9RHYnnDli7WMdBFfqko9A+C14W8J0hbrOzfDSMOyj3m7LUxmRWVPF6zEvtrm6
 vYv34RrKR/Wip1JcbgSFvI3F1ITn66JRSUSH5b1aXKQq5SW+p58X4Q3MZELkCtNFZlQ01iHva
 mbQbmbIACwsMZF4HoM6KifO2SpFW4kM3lrwipY9IOSLD8GzyKobdhGKdX8tWY6YaISvhETUJo
 PuzjljEOeEt4vmqGXsgX3AtWKXwQydk0ho4K2lNbO4oRygJXe+Vqa5J6oQcs5LcJNAAhwxq4n
 unNtVnhoGX/8AMWrC0wmfVwIJJCBzH2eV+A7XmDy0fMXJpdHTbcsxGFPSzG+1f3nBrID8kGdC
 5HPjgv/e0LeDN4Qck8EzmT/PgVgVPHcXR2MKjqmdknUpl0JN1z/i7UASJn28lEKHurOBhCdCL
 orNk8TXGaGVD9NwofA5Bv7iHZO75WL4uA0Y2Mbhsz3WHjFboxWqSaeYKfmac8SseEWC2fTHs6
 AlX+jlCAc86UPl5Z3pEjOIK1mCVb6pq/xNFLwWSesLeQP2znnXiKtdI2qk1W2c0DfUQK2Yqqe
 8X8Jg09tAXyRs73H4CxKH6wYKObmXzD6Zc0SPdRpLapncXNoyegAKs+mMy0YCM8dy5uFhg55/
 97qBObv1Mu0AObwwlza2glu3VKwCBkR+hAgX7+UE8TQ3ey9zd0RsHyMHD1A6w4zGFryWbHZfI
 hAe/mzOGi7WXZA0R5o9j1SJxpoqPPxFz9tbQr/XirKwySzee+fL1/Bxjn3WsC+XBj20tqosZ5
 +LPGmHz2mpfJU852Pa/radoZayLL7SPU0c6QaaWJBlGT+2buwcvnx7K+h
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

On 11/26/24 23:33, Tom Rini wrote:
> On Tue, Nov 26, 2024 at 01:04:25PM -0700, Simon Glass wrote:
>> Hi Tom,
>>
>> On Tue, 26 Nov 2024 at 08:55, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Tue, Nov 26, 2024 at 08:37:33AM -0700, Simon Glass wrote:
>>>> Hi Heinrich,
>>>>
>>>> On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
>>>>>
>>>>> On 25.11.24 21:44, Simon Glass wrote:
>>>>>> Exported functions should be documented in the header file, not the
>>>>>> implementation. We tend to make such updates on a piecemeal basis t=
o
>>>>>> avoid a 'flag day'. Move some comments related to memory allocation=
 to
>>>>>> follow the convention.
>>>>>>
>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>>
>>>>> Please, have a look at this line in doc/
>>>>>
>>>>> doc/api/efi.rst:78:
>>>>> .. kernel-doc:: lib/efi_loader/efi_memory.c
>>>>
>>>> Hmm, we should not add C files as then we end up with all sorts of
>>>> internal functions, like checksum(). The help is a bit of a mess on
>>>> that page IMO and it could use an index at the top or side.
>>>
>>> Why? Looking at the linux kernel (where we borrow this framework from
>>> and lots of developers expect to follow that style) it's extremely
>>> common to kernel-doc C files. I don't see why documenting internal
>>> functions (which should be clear as being internal) is a problem.
>>
>> It depends what you mean by docs. U-Boot puts the documentation for
>> exported functions in header files.
>
> I'm sorry, that's a circular definition. And no, there is not a hard and
> fast rule that we only put kernel-doc style comments in header files
> (which are consumed by other files and tooling to generate
> documentation).
>
>> Putting docs in C files clutters the docs with internal
>> implementations, when most people just want to see the API. The way
>> U-Boot does things, it is easy to see the internal (implementation)
>> docs by looking at the C code and the external functions by looking at
>> the header files.
>
> Or it makes things harder to understand because the human readable
> documentation for a given function is separate from the file the
> implements the function. This is possibly why in the linux kernel, where
> we borrow "kernel-doc" from, documentation is frequently in the C file
> which is then included in Documentation files (the type you objected to
> in the start of this patch) which include additional human-readable
> explanation of the intention and usage of the API in question.
>

For static functions we will continue to have function documentation in
the C files and not in the headers. I personally never looked up the API
documentation in the HTML docs but always in the source.

I am not opposed against moving the EFI function documentation into the
header files. But we should update doc/develop/efi.rst accordingly in
the same patch series. This is missing here.

Best regards

Heinrich
