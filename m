Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1492AC27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 10:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF5B880FB;
	Sun, 16 Jun 2024 12:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rZB52eVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 592FD88113; Sun, 16 Jun 2024 12:37:48 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D27F880F8
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 12:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718534262; x=1719139062; i=xypron.glpk@gmx.de;
 bh=C9I1SheDwYIA6DuJoVR9O3m4gu3hTltYLrjl6LATXdE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rZB52eViGtK8J9LviY1pLYh3CwEwmCg7800G3dBB5WKUil8IIJt5UsrINLqyAKgw
 jgT3rBtIv8WV/xfbRdiCQKP5+wVhnhdE5kDE6xpawQwUv4jpzPcqR+uWKPHuppULV
 0K863CG8NL3IYlkaeYMVHQZjvRAf0elceRvGiYt7K+XUkq2WVfhytjSpv44s4H4+p
 loRS2cbv9wl5XFQx9DUFwgSRugxysv9dH1rX22CBsPJt2gCyxDyUErccJEXqInxUM
 PmBnAkx0QTYf+tEzTIvwhBakBmd66wzctnORI6OoXJ5GPH/82zut2dTuH/WFvmMZ6
 fixJ55nNjjKx1llbrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KUT-1sTvHr0RR3-00spfx; Sun, 16
 Jun 2024 12:37:42 +0200
Message-ID: <8b5e1968-89d8-4141-bb45-7f2a5d859db2@gmx.de>
Date: Sun, 16 Jun 2024 12:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] image: Define IH_ARCH_LOONGARCH
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-5-1407e0b69678@flygoat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240522-loongarch-v1-5-1407e0b69678@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LhQ5eoSYrvlKkAE/0JsDCLqkaDNcK6PWaeQl943PRL6ii5yDgmu
 9Dd1+fQBK0WOcoqF916Xk3wFri5Q0SMwXyps60d85QopaNzW16PyTXFLUbXeY+tzGwsBnYs
 vlSQ02b4VRl/aKKFJ1vZbG+c0zIUxPoRLn+vlRqI49YDcqJelGBsA3qrgLTdp3cZeNWeavd
 JNBrhBK7S01rOe1rSboMQ==
UI-OutboundReport: notjunk:1;M01:P0:ADRXdvKWc9I=;PxUFcWks3Hij9qWNuRLneQgBjGo
 L8IcwkL9iRrXgfladHI41q2BASjyoMI0k9ikS8xDLhtVjavEFgAISdGUm/ODaNAXahzAYeaD2
 RqhvdQaM9BR72aKXNzQukOOy1X+wh+QAe+ohv/82oOiIJtZJIH+eEJJZjgY0UUtMrApdx31Hc
 kUvFkHZ/6FMGcWK3dLV7FKI/HWfs+HZ8GguXl8/RjdfRrOnK0NFt1WZYHFM/H3Cu7kPyldiTt
 CCBH/VFCgU5Y4teyImN0NdMWMJbLqV9C/AAfprwlG+rszWFIK7MLeGvaJU2q/9ZtCbyhJWqsw
 c8cpXQJ4dSgn0FZDFpAxRprJEat2tyIX6xqLJ/dEl9daL06lwwc/0Z//JYyhy6pHc/hEmugHY
 K8rKI5jfaG1+Lo3UvbkSMGoMYQn27ck5i9hNv6Sc5oE48MT8IOxT+0nXNmVEMKnVmRp/8UGEL
 T9H2lJf/t1c/Sfygu5wIs4DsgxdjlLrlDn6VZBRfMmlR1lM7Nu7o1emvlfteiprgRmzMWeoGS
 66/y5C4Hetxsff5Arhov2winJtLubWuhhfynnwjAFwqkGi5axxlvqnzLij4OfCjrLGBBh71QL
 kce8qQdcg/1dpuggGbcnbbwc5gL3IPqG2h38nkPKfb+FoHzz8pK/ACn4uLzbkQM6d1qAQq+oD
 6GpEu3YESr+kDHJUmRNlFW/c8RsGyYFQDzhxiKA5Ecn6k/mqUerqeaFDSQWOE90Ic06KxIt69
 BTIJ4DdB4fWpNPSvl//YCUaWsBdC3VGiqIkxWKUwIoPFbYThXIXiV301i46JM/9Wni/xNqFSe
 oLOyw42V6FKtGxPsHzfJattUhuh/D08kBItmI9OgKwRUU=
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

On 5/22/24 17:34, Jiaxun Yang wrote:
> Allocate the next value to IH_ARCH_LOONGARCH.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   boot/image.c    | 1 +
>   include/image.h | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/boot/image.c b/boot/image.c
> index 073931cd7a3f..8955a095713d 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -96,6 +96,7 @@ static const table_entry_t uimage_arch[] =3D {
>   	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
>   	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
>   	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
> +	{	IH_ARCH_LOONGARCH,	"loongarch",	"LoongArch",	},
>   	{	-1,			"",		"",		},
>   };
>
> diff --git a/include/image.h b/include/image.h
> index a2bfc7bb19a3..1dd6dfb82437 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -139,6 +139,7 @@ enum {
>   	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
>   	IH_ARCH_XTENSA,			/* Xtensa	*/
>   	IH_ARCH_RISCV,			/* RISC-V */
> +	IH_ARCH_LOONGARCH,		/* Loongson LoongArch */
>
>   	IH_ARCH_COUNT,
>   };
>

