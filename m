Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B23FC25B7D
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 16:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE4A885D0;
	Thu, 23 May 2024 18:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="RjE6g1Za";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="e3RwbwyY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1986B885D7; Thu, 23 May 2024 18:26:09 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FFDF876D3
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 18:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id 4382618001A2;
 Thu, 23 May 2024 12:26:04 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Thu, 23 May 2024 12:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716481563;
 x=1716567963; bh=IBAfeI47RCiOBqsAHT4tPpI1B2Z5foCp3hdCwwmj0vY=; b=
 RjE6g1ZawF8AvjsEj+XIQgXX7Uye3wxa75TH+F4mh6tWZ8iOlITQi4KUsxSO7w5f
 vpIhlxlKZVgAIZcMcCiQuxPJtxkhuTR/+5atRRf79WeYNuxfNtGo8AkUQCPzHJpK
 gDoiFzp+MVkFBABCACKz3BzqS25vXvFpfkPEKzbU+z34IWsQn3Zja+W2qHoP0EAz
 xoqE2BCYSfE7BzsdmGCWm1bJJ44rl+qj6ROPgjtrU4mIxnAQBf6bz/6y6MunP7Bk
 6f8Vk9w0tWfgg4iDwbHDBPXiZdE2QEP9XV1KL3FqpzRM63t/vL0A2AASfFPhDugl
 pHGLhgy1GWuRLHPzgZQIUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716481563; x=
 1716567963; bh=IBAfeI47RCiOBqsAHT4tPpI1B2Z5foCp3hdCwwmj0vY=; b=e
 3RwbwyYHFH44HkchAzZtjab6dwT3uX/DLOWhw53ZMN9mSCouqtjDILkibEJZIN/8
 DJawLlJmUPIsLv/lh2/o0e1MNBmGyLUOfgr9TyErPQu5omWK3Vnoo8H+rmQj/iNq
 WxLT/V9+Vn/TKyLA8pS+aOAFmOhoQ/qF/oexJUY2JGxssR14EI9QiWYglFVuPlQO
 o38dZAo2G/Uu4cgXy+kWlJiC9l8hhgp4J2IpYUnSqa/MpyBcdLLyX6zGq/JCiWZD
 h+wi/TPUcBhHkE0cjgX+iQapzx586ZGluK7EDugI2hEsqoU2zswvb+zxtUbZh2gX
 EBlOwHsi/jhpK8eyr8W2g==
X-ME-Sender: <xms:G25PZm5x1m3EixbQPQI8CVF1gkjoorB3QZLuVq6G5FKo5BGBsUvfnQ>
 <xme:G25PZv47lavfZnebTjSXlI1l0L2bfSgQBXMgyh2j5xzKwGU5mDiC77MFMrYnhJQo9
 MOoRHqnrYqO9KXkR6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgleelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
 ufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjih
 grgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpefg
 ffetteehtdekhefghfefvdeuveeghfetledvhfduvdejgfelheffkeetffdtgfenucffoh
 hmrghinhepghhithhhuhgsrdhiohdpihgrnhgrrdhorhhgnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomh
X-ME-Proxy: <xmx:G25PZlcX-auGb9FDRmhBY2M3_xxQEr9y3oDT2XIwwpYhTKDkv0BHiA>
 <xmx:G25PZjKGHj9014uWqe71NQ1b7_-RrmkPhL7RdtVRS53JYU8Uy7RqwQ>
 <xmx:G25PZqLT65qyiOxW21oh5JaF6el42n8TOxoSp4rGPGBildvE-cgmig>
 <xmx:G25PZkxEy-wRw0C82R7WNI7qH_OiF8kTjHFNzCPRjKZ14lf25gM-zA>
 <xmx:G25PZvGWrkg5RSVjLk5lomRbfPDEj-qJOKj5V628x3lgdfZux8tOyha1>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 9A95036A0078; Thu, 23 May 2024 12:26:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
MIME-Version: 1.0
Message-Id: <5282715a-c11d-46de-bf95-a7d3044e652e@app.fastmail.com>
In-Reply-To: <304f9e83-45eb-4f8e-98f3-2658aac5c20b@gmx.de>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-15-1407e0b69678@flygoat.com>
 <304f9e83-45eb-4f8e-98f3-2658aac5c20b@gmx.de>
Date: Thu, 23 May 2024 17:25:45 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, "Simon Glass" <sjg@chromium.org>,
 "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 15/16] efi: LoongArch: Define LoongArch bits everywhere
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8823=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=885:14=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
[...]
> Looking at
> https://loongson.github.io/LoongArch-Documentation/LoongArch-toolchain=
-conventions-EN.html:
>
> There the following symbols are mentioned:
>
> __loongarch__
> __loongarch_grlen
>
>
> Table 15.
> C/C++ Built-in Macros Provided for Compatibility with Historical Code
> marks __loongarch64 as deprecated.

Thanks, will use new macros instead.

>
>> +#define BOOTENV_EFI_PXE_ARCH "0x27"
>> +#define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00039:UNDI:003000"
>
> Where are the 32bit defines?

Since we don't have CONFIG_ARCH_LA32 in U-Boot yet I leave 32 bit alone.
Those will need to be added when we get 32-bit ready.

>
> Cf.
> https://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.x=
html
>
> 0x00 0x25 	LoongArch 32-bit UEFI
> 0x00 0x26 	LoongArch 32-bit UEFI boot from http
> 0x00 0x27 	LoongArch 64-bit UEFI
> 0x00 0x28 	LoongArch 64-bit UEFI boot from http
>
[...]
>> +#elif defined(CONFIG_LOONGARCH)
>> +	asm volatile ("break 0xf\n");
>
> Can we use an undefined instruction here as for the other architecture=
s,
> please.

LoongArch have way too many hidden opcodes that is not documented & will
not trigger exception. It's pretty hard for me to identify an opcode that
can trigger exception on all hardware (and including future hardware).

Meanwhile, breakpoint instruction with an invalid hint can always genera=
te
an SIGILL.

Thanks
>
> Best regards
>
> Heinrich
>
>>   #elif defined(CONFIG_SANDBOX)
>>   #if (HOST_ARCH =3D=3D HOST_ARCH_ARM || HOST_ARCH =3D=3D HOST_ARCH_A=
ARCH64)
>>   	asm volatile (".word 0xe7f7defb\n");
>>

--=20
- Jiaxun
