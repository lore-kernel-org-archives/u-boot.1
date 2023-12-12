Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2A0C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 10:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29074877D9;
	Tue, 12 Dec 2023 11:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="sS6kRrZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40539877D9; Tue, 12 Dec 2023 11:25:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 156C587682
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 11:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702376729; x=1702981529; i=xypron.glpk@gmx.de;
 bh=SfRg9Tu239dWiTflYQS4ZDN/14hDJjG3m56/sVUaYjk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=sS6kRrZt+xolKMwKZPwOfQ7MdRgC347dHYFqejy0LMD+6CewCdR0X7ecKuSSyg8g
 eTSsBCst+/FDtOg1shBH2H6YtMOze5hlwpUq39WpRQL7oz+VE2EX8GPcD4uz7Z9Q6
 XtdwUYVKN/uQudv52phJ3rd8ZEpQ/Puqhq85lJDW0S9NK9nYlvsDwxFjzWwJyGl5b
 1cQ70OWu/bPoJMa1S+Hd/KQ0aJeeCRQdNESX/sPO4MHnLHyrKmncSCeOwVQQxDgbP
 g6B1ObmJyq4ncCpm/84zY+VGp2lkdBx+pSf1lWFP0/KG47oJya/XgDTKHohWjdth7
 0mfhxOCF8L5//PhzXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlGq-1rhuv31FYW-00dlPq; Tue, 12
 Dec 2023 11:25:29 +0100
Message-ID: <d8b7fdf8-5ecf-4a0c-bbb2-9d5561cd5c16@gmx.de>
Date: Tue, 12 Dec 2023 11:25:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] doc: printf() codes: Add bitmap format specifier
Content-Language: en-US
To: lukas.funke-oss@weidmueller.com
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke
 <lukas.funke@weidmueller.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 u-boot@lists.denx.de
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
 <20231212085236.2730768-5-lukas.funke-oss@weidmueller.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231212085236.2730768-5-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dDBEllxoQErxpoiK2Q4ToSbL1AG/NH9rBle0W7EM4WF6U8i7zMl
 Osenhwk38rebHJ6UUTuw0Z5JeZtYu118t9g1H2a4RdiCUgZ5i92jzqxN9tVLj4eyoPp2F5s
 Iripmsl+dM3WQC1V7tPBVTEbyhFp5IPeX9h+TKtptgeD6HNmTkGbVrKD+lm+lhCSH5RqNvX
 FU5hHlerQ+2ddwPdeAwxA==
UI-OutboundReport: notjunk:1;M01:P0:eo5Dt4ORwAs=;EiupoDHCoYCIEmUTYXMxzXLrF80
 3qF6fLJThRlG3D2xWh4MHAQfDkMGOA9Yz7OtS/SNTxGtDMtBgITm9CLaajk7UKu3IwC8AY9sl
 jefuynQ3JIrXazvybkWBz6II7xeWZUZR3+RihFX3aj91Cdha9eab2RrPV0IErKKsl1aFjmNBI
 sp13hhZkA+TFKHOEdfECqOk0z3emaJTumY2P+62inMKvbBscdmuROcUUDCaMApoLS4swa93Go
 Z0wjBFtbaZ7NaBM/XhV7Vt8wIwV/WQ8ig6b13WtZqjZN9aeblhb1um3ENs8uzykLQCvnYcBS5
 Je8+DjWyjjDcbl3iAlZnHmHdVRGTYCfRkttUeQp6SwL/VClhpxr1d36eN2H9TMveIGmWpHwaD
 6RmfTf34baBzt4kTTzyCOSS1YOzcn0XfHogA9bg9ijqz2yiyPG0++njK0Cgryp9r20uslO9oW
 I7ZHY+c/YiZOvlWexgfgVPFEq51vv++qF6rHDae4eKODSauYXutaIht0NpqLKEVpuINYRwt3K
 AgOp3XH/NYJtkQ5usWVeq+HfZypHiMCSp6opkSOFae82AHGRWbn/B/6NaT9fQp8XPZvnuAyYG
 /v36va9sWEu0gCmnuIKfFBT9Wmv9ykncs9ygiSUhBF2S2hj9lPCWEbM6iKs7L9URltzpoHzma
 3ZynCkcGcGrC493nn5p4qLkycnlqEcpq1GWWlMqBwS0K/rXvOtbVbCjca5Xp63VpU5+sU72vU
 Wayjufo8hyWq5nXXzBHpxDhYv7kFalixDwzvF0bc5EB1cgWp0nE34Z9gG2WYKPhArdUKjgsLU
 1cSkekgQ51AeOFmJp/zXVJKVF8EkE/8LHqK4KMt6rhSPfw8HyT1ItdO266jHMgHCuT7a4zJvL
 1mgyHnFvTHZtWzWJpvzO1SQ9CSVGv9Zooz3Gqc0H3l+TU+vb5GCpDxM+qyJui3U2Ml4WTpiRk
 Xrma6bQ/mv6fkl5LFVstTysX1uw=
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

On 12.12.23 09:52, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> Add '%*pb[l]' printf format specifier as descriped in [1].
>
> [1] https://www.kernel.org/doc/Documentation/printk-formats.txt
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>
> (no changes since v1)
>
>   doc/develop/printf.rst | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/doc/develop/printf.rst b/doc/develop/printf.rst
> index 99d05061b1..c3537b1796 100644
> --- a/doc/develop/printf.rst
> +++ b/doc/develop/printf.rst
> @@ -165,6 +165,12 @@ Pointers
>   	* phys_size_t
>   	* resource_size_t
>
> +%*pb, %*pbl
> +        prints bitmap and its derivatives such as cpumask and nodemask.
> +        '%*pb' outputs the bitmap with field width as the number of bit=
s
> +        and '%*pbl' outputs the bitmap as range list with field width a=
s
> +        the number of bits.

This looks like '*' has to added as character. I would leave it away as
you can always have %<width>.<precision><format specifier>. '*' is only
needed if you want to path the width as extra parameter.

With the given description I would not have expected an output like
'2,5-6' for the number 0x64. Please, add separate entries for %pb and
%pbl and provide examples.

=3D> setexpr a fmt '%320pb' 100; echo $a
0000555a,00000000,00000000,00000000,00000000,00000080,00007fff,f0094f48,00=
000000,00000064
=3D> setexpr a fmt '%3200pb' 100; echo $a
`%3200pb': invalid format
0000555a,00000000,00000000,00000000,00000000,00000080,00007fff,f0094f48,00=
000000,00000064

Nothing in the documentation makes me assume that width 320 should work
and 3200 should not.

Best regards

Heinrich

> +
>   %pD
>           prints a UEFI device path
>

