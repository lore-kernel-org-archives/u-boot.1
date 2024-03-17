Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82640C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 17:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF85187DD8;
	Sun, 17 Mar 2024 18:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="S/gpmgdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88C1A87DD8; Sun, 17 Mar 2024 18:18:32 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BCE987FC2
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 18:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710695902; x=1711300702; i=xypron.glpk@gmx.de;
 bh=Qs5MSJxn8i2MOP1+x+q2hf7uctlfGpAYFw358XdjPy8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=S/gpmgdyGRm/2AiH/h2TwcLZn9/c+/qHDFQonQnHR0gP42WHAV4z21rKXkHZ45rU
 dDIF+p0Aenyq5SB28NpqSfvVm8gunPg39NpREShTR0m1R2S02PZatwyk0jJBFtX4s
 4jVxoA921Ki95O+gM4DL6YjqOTYnYJa8Qynwji2JpW+LaYr1MUcPLH844xZOFFHKE
 nZjKsNnOTSCyyhZ3z7ZoEjVcn5nu6o035E5uN3zs2yC+BZ88oJNyRLCBN3qXJ4EPc
 uRU+K3eMquQT9txnMPWzCTfkg5to3yY/AjCeN487hWkW+S3RxT+nz6t1aSxRmb7t3
 O9lLfBjy/6v3/NcZcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUj2-1qulX20gCo-00rWDH; Sun, 17
 Mar 2024 18:18:22 +0100
Message-ID: <132c9613-1c58-48de-99bd-4a42178eeba6@gmx.de>
Date: Sun, 17 Mar 2024 18:18:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] boot: fdt: Change type of env_get_bootm_low() to
 phys_addr_t
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
 <680c7c9d-5f34-4646-b624-490f934f4a1f@gmx.de>
 <f60355b8-e18c-42b3-a76d-b9a2530a186d@mailbox.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <f60355b8-e18c-42b3-a76d-b9a2530a186d@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UFRKf22ISN8nvePT2Iz68tJc/3UU69axPE7wYptLo09ejgP+tLv
 CzIE8Y2Tkn2a/juKplBTzizxYDmU+3GO/te3Pt4IXXm22rxm5isszvJDQ/lmvbRV+PFZTJ0
 XAaG1tzYB/UESzcf04SSdnNw9av/vGi9zVpSIuiaSJFaAXlggD7FjHIyI1JQcLdIEgV9L+7
 /bqiWOIWmpm5oN05M+V0g==
UI-OutboundReport: notjunk:1;M01:P0:1IUFQnm09pc=;2aPZtlBWDvWV92BXSMMOQsv6saM
 6Ao/2pANNe7h90xDPjnOCmt5IydhXIyvIq923qcxkHeLXD1jR6RweSkMlnVMhg/MRClL/Vzfc
 2JDCyiLJTk6VtbhCDv6j7m9+czAhRBTkbnCigu35dvBQFNWh7US7lj7YMpmaFLEW5EBobm+nD
 gp4yxJ8iQi0vH9dtnRKNZ9kqMc5Q1JVxLWThl1SeiHHr6kJzu88X9SZpTpz0A+E3N9t28ZmEU
 CvgJAewKIDmigerLsQ0efIr02mFoUZLvTWxEkSmGYcT/hfQ8NLjZ3bpcj5yFYPOYYs0rjJC13
 l0lP6cd233uKLGDGBvc5ifLcm4vF2OGbQVKW44e5X3isf/+7pEg2JHBbLuqYgiH2/gXhCcykr
 9NPX65R8qoT/PGYQPyb58+BovQ3fRVbMQhvlR0JWJZqe9tKeW4oWSvVPqFf1EGKC1uPpZs1Ju
 zdnQEcIzZiu4tM1tAfS7RX1jj7YO3FHbKLImeeiL6czupDS20UrCxJMAqpLz38yyzQVBYXJF2
 plNr9vYIEsqMNhoRXuMCWh1tL1BswLdjiJ7D83mc7iMkGKRB4fxMsI6c/N7ZLuP1U8G51cEOX
 Jeus8LewL7kxLNAsf1cskccZwce40xVXMqCm0ZL7/jfBQ8jB3WV8ANqD0fIG6oQtDpBOiTlK2
 oaI5BDmi/WW7fXYy28H2l3TvQOv6sFJiprt1FaYgEcasj5sPZeXeYhESZWTBKr+NosdDX9cba
 lsGl+fdC1wXNZXbf9YZplFOzWJvWfAvgPzqNvonWmtbthV+D4sjZpTW5sHQQpK64np/nu3jeb
 pozUMF+2czYAIXtS1RkZD94yFvpDIUNEaxu+WrXfxTY4g=
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

On 17.03.24 17:58, Marek Vasut wrote:
> On 3/17/24 10:08 AM, Heinrich Schuchardt wrote:
>> On 3/17/24 07:16, Marek Vasut wrote:
>>> Change type of ulong env_get_bootm_low() to phys_addr_t
>>> env_get_bootm_low().
>>> The PPC/LS systems already treat env_get_bootm_low() result as
>>> phys_addr_t,
>>> while the function itself still returns ulong. This is potentially
>>> dangerous
>>> on 64bit systems, where ulong might not be large enough to hold the
>>> content
>>
>> Isn't long always 64bit when building with gcc or llvm?
>
> C99 spec says:
>
> 5.2.4.2.1 Sizes of integer types <limits.h>
> ...
> - maximum value for an object of type unsigned long int
> ULONG_MAX 4294967295 // 2^32 - 1
> ...
>
> Simpler table:
> https://en.wikipedia.org/wiki/C_data_types
>
> So, to answer the question, it might, but we cannot rely on that.
>
> Also, phys_addr_t represents physical addresses, which this is.
>
> [...]
>
>>> @@ -553,8 +554,8 @@ int boot_ramdisk_high(struct lmb *lmb, ulong
>>> rd_data, ulong rd_len,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initrd_high =3D=
 env_get_bootm_mapsize() + env_get_bootm_low();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0 debug("## initrd_high =3D 0x%08lx, copy_to_ram =3D=
 %d\n",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initrd_high, i=
nitrd_copy_to_ram);
>>> +=C2=A0=C2=A0=C2=A0 debug("## initrd_high =3D 0x%p, copy_to_ram =3D %d=
\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void *)(uintp=
tr_t)initrd_high, initrd_copy_to_ram);
>>
>> Void * may be narrower than phys_addr_t.
>
> When would that happen, on PAE systems ?
>
>> Shouldn't we convert to unsigned long long for printing.
>
> Printing phys_addr_t always confuses me. I was under the impression that
> turning the value into uintptr_t (platform pointer type represented as
> integer) and then actually using that as a pointer for printing should
> not suffer from any type width problems. Does it ?

As you already remarked on LPAE this may happen.

Though you may not be able load initrd outside the address range of
void* the variables might exceed it.

Best regards

Heinrich

>
> Since this is a debug print, I can just upcast it to u64.

