Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EBDC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 13:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6063810F4;
	Fri, 28 Feb 2025 14:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WAqec6oK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 796228110C; Fri, 28 Feb 2025 14:29:05 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B81800B6
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 14:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740749334; x=1741354134; i=xypron.glpk@gmx.de;
 bh=UcB7dRu/K1ZxtET5cETGslIfqz/eidKafFF7bXvVllU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WAqec6oKZeQM1XrRcsvkij+lNVniy4qOTKDzhhXpUVl/5l88hxNKgIoGW2CDNMeO
 hfxKWBi/EEbL+LkJJqgbvG8X21SfyEJ6bHla3WGIq9OMLcJemJIpB3f2Mvda33tI5
 SnIwgoOWSxKlDIDAOIXLXUO2mnwq/WC+yjijR/5vnKwQ4X50D55Ui31u/PUAOZ2NV
 yCt1AGpo/4sv2OzKXQzhGMkYaMqKAGVltGFS0bUGZp1+O9x3JKG5Ie/Ut7vNyhn7T
 KZPCshmPwjO8A3iwIDfWs/Wfnzm+v023YjeFcvaXcgeR+jzZapYU6QWFi2wMRuTj6
 NoZXsvnSPwXkO/xW7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QFB-1toptr0Pdl-00EmFs; Fri, 28
 Feb 2025 14:28:54 +0100
Message-ID: <0cd2dd22-e653-481d-b9b7-fafa91059e47@gmx.de>
Date: Fri, 28 Feb 2025 14:28:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] arm: add initjmp()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, u-boot@lists.denx.de
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <bba48e537696016b94faa69a20f998256b060685.1740499185.git.jerome.forissier@linaro.org>
 <2a3e72c0-30d3-4f52-84c2-81d34b2a4286@gmx.de>
 <911a467a-3dbb-4a12-aa49-2aaef2094011@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <911a467a-3dbb-4a12-aa49-2aaef2094011@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sarlmDAEWaK25LUTzPVdDRGfjn8atyMkcyndd6mOSvi641Drlyi
 4+Rx9tmVZ2xPpM8z+WA6msyp3lkPHmp41Rhj406TlnBX5+BTjsQy0/SW3hC/6LP1zH4pHFb
 3MbjVbWFoJKsN/Mbeyo9FBuEW1SUEdB5LKqyoYG2mU4fk2kwAfn/okPUYo1/kG9yQ+0pZhG
 4adDNwEXP7hwvalVR7odQ==
UI-OutboundReport: notjunk:1;M01:P0:JRaZC1XjZKM=;Oi0m6rjn1s/vdoS7uNXto2lc4d/
 StHymQKfZ1p/ZL9tW0EZR6tV9ZfL8dE4sToU2pCyBld7a+i6vFHk9x5AViPY9YW9DjpJWK470
 i4acL6wiTP1edLzRPSl7pmnp6N4ytfGB2vqlBSkwv7u+7SJxzl5eiTAw2rcSa1Psm0t/pFcrA
 Ssh0yIUuCApI/d1X2hjA/rMyxFyWzEoh+5ZvQ/GBNMFyRuPVVdrwZsf17+ioJtlZO5DbUyDq6
 MhoAtDAR7glFYW8U1BJC6vq+Fg7ZBYElXdko87555jixTbPq1PUr7fddfksLrymheMCnZHdGm
 a7J5rmJVk/wjLvqcSBXt+FDveQp6q1oGUUJySwbcpNxDwJnJCzZuKdj7eqEtaYBIQ/IEYMRGe
 qvQXQJPWaQwr36J6gHwzIWPcMfItcUStAk8QY/v8sZq3aeARuxEm8rpyqCZwV0gX2U7LErw3q
 x3IouU0zG8Q3WTifx53KzPNWXv13c7xe9HJPI1C9Gn96uwFz1Ii+71UGT3MLe8fkcIGN/Yi9X
 aMzl2EdGQWAFmIoz4aViXP0Npyp0inR80+M6Z/vPFdXbCJyuBAgRAnrX9WC0vhjHbzLURFTLf
 mcVFhEJFxxfkbhA+n4FB2aepq7Oux9RBBifTqjEU2sDjgBpc7FnRKjjPAC+0zUtuUU2qpz3u/
 29JIrPhUye+LdR1Z+Hy4F7d1J6yBJrtQS+lQ0M2+LA2qms2U4waU/3WJyV4Dzxhzi0tyCx3rm
 91VfDlwvwYQclUJWPjMWAGjw3KCr5B3l4U7qYirFIRLCV+sRaGOGOO5GTNUMhf8AGGRbba1TS
 RjvqD3ycI2fmKU+a3alSQB64yt/afSvbwJIxNJVSoIdvFRIWqc0QcdXBHRVld3U5KwLU27zpf
 hXwfGn7FxJzQoLdNJQNs4W4AglzG1ZsQx5JJh2gE2obfffgjflYNW1BS1IjXHmW3VEp4XmlTf
 D+m4Q0LNnOmKD7jSy+hYBr1HZc6Oe0ZOpTAFXYUaZPiZ/9v3ImCB8QkUovmUkhT2TA49Tqe5x
 IjEAqCzi9YZ9dudeDcGtX+bqbGbuuM7xwgBHjXvBEwnPCynupoFg4LVAVBK4llyfl92pw3tZw
 thoZk3mY6n7lR8+H8rA+ET6fDX+Vd9BjJmui+j5IVe2odt6+8VZWNb3fx4SCWjIFVBNSR52c0
 ujh1B+lFGP1UzLxvmDArwG6b8M9EECT42EgnDw5Vm4dHHeOK69UN5vGxeXfPb3J7baylgaEDV
 BTs8TyKGU8Zu8ZkSSBA9omWLiBaYb/zMZ1uyG0n9vZAWWstQktausuLSHdZqxVORbZg3idITl
 dMxuzWMIca8hyu/P2MTeZ6u9CcUPzMXfxAOWOIh3Jb5J1T4e56FwyfdM4ib3k99u9adHhCl5T
 mwFrP/OjD+j2wcsHqG3bxz4oI85SowwEm09wDvGn06jczSIkQi3tGJw7qe
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

On 28.02.25 14:21, Jerome Forissier wrote:
>
>
> On 2/28/25 14:05, Heinrich Schuchardt wrote:
>> On 25.02.25 17:34, Jerome Forissier wrote:
>>> Implement initjmp() for Arm.
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> ---
>>>  =C2=A0 arch/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>  =C2=A0 arch/arm/include/asm/setjmp.h |=C2=A0 1 +
>>>  =C2=A0 arch/arm/lib/setjmp.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 11 +++++++++++
>>>  =C2=A0 arch/arm/lib/setjmp_aarch64.S |=C2=A0 9 +++++++++
>>>  =C2=A0 4 files changed, 22 insertions(+)
>>>
>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>> index 8d5b54031b3..57695fada8d 100644
>>> --- a/arch/Kconfig
>>> +++ b/arch/Kconfig
>>> @@ -94,6 +94,7 @@ config ARC
>>>  =C2=A0 config ARM
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "ARM architecture"
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_SETJMP
>>> +=C2=A0=C2=A0=C2=A0 select HAVE_INITJMP
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_SUPPORTS_LTO
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CREATE_ARCH_SYMLINK
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_PRIVATE_LIBGCC if !ARM64
>>> diff --git a/arch/arm/include/asm/setjmp.h b/arch/arm/include/asm/setj=
mp.h
>>> index 662bec86321..1ad5b500f2a 100644
>>> --- a/arch/arm/include/asm/setjmp.h
>>> +++ b/arch/arm/include/asm/setjmp.h
>>> @@ -23,5 +23,6 @@ typedef struct jmp_buf_data jmp_buf[1];
>>>
>>>  =C2=A0 int setjmp(jmp_buf jmp);
>>>  =C2=A0 void longjmp(jmp_buf jmp, int ret);
>>> +int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack_t=
op);
>>
>> As this is not a standard function we cannot expect developers to know
>> what it does and how to use it.
>>
>> Please, provide Sphinx style documentation with the necessary informati=
on.
>
> I agree on principle, but if I add documentation here then I should add =
the
> same for all architectures. That being said the prototypes are already
> duplicated so maybe consolidation is a question for another time.  I wil=
l
> add Shpinx style doc to all 3 commits "{arm,riscv,sandbox}: add initjmp(=
)".

Yes, this was not designed correctly:

We should move setjmp.h to include/asm-generic and include an
architecture specific setjmp_bits.h from there.

setjmp_bits.h would provide the struct jmp_buf_data definition.

>
> As for usage, I think the best documentation is test/lib/initjmp.c added
> by "test: lib: add initjmp() test".

Example code is valuable but does not replace documentation.

Best regards

Heinrich
