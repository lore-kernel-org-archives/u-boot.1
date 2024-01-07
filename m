Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1409FC47074
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 10:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD3D87A05;
	Sun,  7 Jan 2024 11:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=jan.kiszka@web.de header.b="LuzDMd6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FAEA87A07; Sun,  7 Jan 2024 11:54:29 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8017D87837
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 11:54:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1704624861; x=1705229661; i=jan.kiszka@web.de;
 bh=/YIUvI4XmutSOcJJiIaWD9afOyzHLsZe1On430r8Aik=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=LuzDMd6VUNFoU5OXU+9cjdBoMHfJdV+webXMxQcN+EqKlx1cf8bSAFa0HEkjP1vh
 xGPHPRjIh0wWguXXA8K1CKCc0WIe3AH7OS3Wyr2D3i7zt95qbYmpgSpdR7/uNMffM
 y3bQ7ORPa6+UR7/qVnesmz1rktoqmixSfeb87iduc3bl9RII0dWhgkNlm1YYa2etG
 Hxnro9TgYb2QyWhX9lGcD0tduEszDGq7GJLaMKJNLgNFU7fjXrKAWrCaNVz3FplqD
 THWZsxjfgNasheb4v8VhRPalzYVdosJR2dJni3vGzLwZVnYlVa7GlmwOApcatIGX2
 hm+Zw63OkxcqUaDeDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.10.10] ([46.128.89.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59n6-1rNXFx0m9M-001XU9; Sun, 07
 Jan 2024 11:54:21 +0100
Message-ID: <c9fa0e1e-58e1-4ecb-b6f0-1b868e6d3793@web.de>
Date: Sun, 7 Jan 2024 11:54:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] board: ti: am62x: Add basic initialization for usb
 voltage, 32k crystal, debounce
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>,
 Bryan Brattlof <bb@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Andrew Davis <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Vignesh R <vigneshr@ti.com>, u-boot@lists.denx.de
References: <20230725185253.2123433-1-nm@ti.com>
 <20230725185253.2123433-4-nm@ti.com> <20230725212504.GH3630934@bill-the-cat>
 <20230725213755.kc6qcvmkmt2yzzqz@perfected>
 <20230725214210.GL3630934@bill-the-cat>
 <20230725220328.fruxsldln7o5geil@tassel>
 <ZMBJtRFu4mnGPSja@francesco-nb.int.toradex.com>
 <ZMBOONYlgGWMVK7h@francesco-nb.int.toradex.com>
 <20230726111019.gotprceqsrmpwgyg@stopwatch>
From: Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 xsDhBEq0i8QRBAD2wOxlC9m/8t/vqjm1U9yQCT6OJ2Wbv/qys9DYM0CvcOTDMWQwmV1/VsZj
 KR5YgB5NPt+To7X6x5cjz15AGnx5Fb8Wnrq8EF9ZfHMwb7YMx1LdPYPDnXr37wE3XupFmkHB
 Mes4htyX7Dz8LvKDLnli4IsAmWG+kV1JI6LWKXLpSwCg8JRq4SWoB4VCQxbH3GjntgvwNc8D
 /2q5Dj0urJ7s7sdXhrH0hcFkpSFRmU5Yd6MCwcbFHm2paL5gqVjNNUUwDBKAL9eZaQVIHKwC
 44BvNGO2gcQ26R3AuCHUQ+pZHg34tok1JCNZ6IEZccb+33Qq0qbcDMJJiDYp7ppp6ozifvc4
 YaqJECX48IydxfE9+41oV7T5vNAzA/QL/UMJyTnu5jiOXcyn5iFQw535lXkwKsqeXzCowLho
 HICZ2jITJPdTT/+9pGWwMQqST/SS35Tx4EnS3z2BWsNMCLuXCPkxF1elaMJqMfMJxFD8rAgS
 9GK6zP6fJlsA1wq/UvKSL8v4QPOnTNCVOsyqJVasGV0ZPcDfcj+ClNO4zR5KYW4gS2lzemth
 IDxqYW4ua2lzemthQHdlYi5kZT7CYAQTEQIAIAUCSrSLxAIbIwYLCQgHAwIEFQIIAwQWAgMB
 Ah4BAheAAAoJEIrUrG965ecUhIMAnR6DDCW5cx+cVdYhydbhQXqeief6AJ4p+z4+nrmZLdfU
 7V6nKqKeHeTtj87BTQRKtIvEEAgA2/PlX6oyi7dToH0CJCHq0eKmZaa7CmGaVnxyeepKvIfi
 M8n8Td76AbG64fjREMwgSpb4F/UytF3z/03tj4e49W/zKjbBRB2/wmFRlZBC9crg22Q+bgvM
 OsxnC6uHXaWN8fL+jVei/5OoHOoFqaMsX8EvploitlI/BPj+VgW26jksf3YZyk1hnclsZ/IY
 hXzgRmVJo4RiTW/YLQAkwndwc+fKPa/IYLEDW1Jc4kNLoK0P90b45zju0hpl0C00pVORTOtz
 FK9G5Ha7qOAWJfAVJORHKAkkvwftf3hkpPdLyvZUWRHXvUexmA61fLvDBAFhRxYGD8t5gz88
 SF5Tzq+0ywADBQf/YSkaYrEslPWiCA2wU6EW0yaqBQAobFsOMvsufJ6o2ntq5Ncq37VI3KCT
 67eHPE9x+zPcENoZWsRrC9S9PCf1LOsi7ybZsR13AJqDFlRzJZ4klh9QwgwFZxUBzOdIvttw
 zG1QkzHx06RKZluFYpPF3DRduSMukdIJ2wmWCU+ohB+mYefe65JGjYQfHVs8mgYVFOPxbRea
 9VJACCMuspoZWpj43UdR1lLLyIUFYz+jqcPW7Hd/GTIw4N67pYl0dwPDmFd4ohJ5g4Zpq61t
 oNysBGEuEm5GCcn0VmGtQpSYnR5cVm5b2yPz4bIuFOSuZUo/l7vitdY0iy0/wvKbBC+NK8JJ
 BBgRAgAJBQJKtIvEAhsMAAoJEIrUrG965ecULvAAoKGvxs5T3IhyQT8I8sMsyAvCE4wHAJ46
 S16yab+OxNkvOeoOEX0EnHVHaA==
In-Reply-To: <20230726111019.gotprceqsrmpwgyg@stopwatch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CFjSCyAT/uRpWSR2BbG6x/NDEfrdm41QHRLiSb9+5S1iRHB5oIF
 BWzlqY2SbviYKHtIuP/5bdmM/lvqBLbAgbwn3gUI1dYREDkB5haVkxLTUuvGuheO7LbDD3N
 YRpHdrEcOlcMp30ad2xN7dT70I7tR5/LjAxonyJ1w2avMVI0LxwOYUSjjjx09nGGs6PaC/q
 91IYooyUY3hrJ++slrW/Q==
UI-OutboundReport: notjunk:1;M01:P0:dRfiGKNP0A4=;szH2IbQQtehrK19mwrMd6tV9V9+
 iS0tu+uVDwN6jJd4fTnGGwegGBKk3Bq/7aJi/WE1VUn1ujYV5Ffa8loJrZrzMSmzi3DqXtkuz
 6IQggUd5U6EyJYo8AemiV0yGDVGw7gELMRDV5G0SHX5HRzi07BBqCfAzBjhX5SAxG+8mp1hXj
 P8H2I4FtI4oZ6cduxZv42mgMZ+aCDfricUtsWbSkrg92l9uCT7QeCdD3nKsW0/hCa905M8TAP
 vxVTdbU+O6VScywRr2iA6OTR4IcMm4NlaQ6Hf+Tc5IlQ2eRLbDwP1/EAh7sA2Hi0Tnt1PZ2ob
 lGBw1rXV66Zkm+TM+tJ/DzRGIUWXjCMs4PcFopTu0AF8bXwvKMXVxGTKO/LyRkJUSBkOqutfC
 3E/+oip3ZtND4UwMlanH3Pgy3WRe5UgjoVkATaQizOr5bznv/s0CHTEFYCwmiFp9cVN96+yVw
 z9V8D4m3m46+TqPZRm0619cafbOV14brQTdzoY4bqn8ljmcUsceey9mn1RgMJtUf24HjCRDaS
 O7W4co+g/Nl45cK6Sc9nQYm6/6YEDpC1kwPz7tYNcCUOJLHHch6wtf6zj28vAzTsEVKDkSSmc
 UVEXdnFYdAe+H18/8X6MiMUuXaL0/vJyWazKo3Zx1k3qPBn7YCmNpx3s7mP2iVnG1EdhvOVD0
 g/vK5qli0/LDldDJNqekKKBwA99EO+iyH52cx94yeqpQXT2McyhZSxXM5Oa/cOFLn6uQSwr2V
 GbU5LG+kBZdti16CqEOzoFd+JN/RqnkGV8aHbTomKUTMI1ZgxmAJRZGg9Ld95/E94xpgyJYkQ
 zbOqUtzpcK55TVyIHgDzYX5OKbxOrc3OMMccKHrXj0z8GoDTtOjoxFdijzXm6y3yVrJwyfHM2
 HMMwATty2Z8q9k4u5oapD7vp/ysr/L9WWPvCumg+kbN0JjUR2Afd/D8hgyhKFZfGD0oMKiQI0
 zqynjHgVkB2ZOaSctKFcHYOgZ3E=
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

On 26.07.23 13:10, Nishanth Menon wrote:
> On 00:35-20230726, Francesco Dolcini wrote:
> [...]
>>>>
>>>> At least the ones we have currently (I am not sure about toradex,
>>>> phytech etc), seem to operate the vdd_core at 0.85V .. (which is what
>>>> USB is dependent upon).
>>>
>>> For Toradex, we do have the equivalent code in our board file, see
>>> https://git.toradex.com/cgit/u-boot-toradex.git/tree/board/toradex/ver=
din-am62/verdin-am62.c?h=3Dtoradex_ti-u-boot-2023.04#n92
>>>
>>> The 32kHz configuration is just different for us, we do not re-use the
>>> same you have here.
>
> True, you are hitting the bypass control and not powering on the
> oscillator control since the 32k is incoming from RTC, in my case, since
> I have an actual 32k crystal, I am clearing the powerdown.
>
>
>>>
>>> The debounce conf registers I have no idea what they are about,
>>> something we should have also on our board? Any additional details?
>>
>> So, I got curious and checked on the datasheet/TRM on this debounce. If
>> I understood correctly this is to have debounce on GPIO and/or EQEP.
>
> Typically, yes - input signals more useful for eQEP or GPIO. but the
> implementation is at pin level which, technically could be used for
> other purposes (but I have'nt seen any).
>
>>
>> However to my understanding this would need to have the corresponding
>> DEBOUNCE_SEL register written on the pad configuration, and by default =
it's 0.
>>
>> What's the use case for this debounce configuration you have here?
>
> TRM was a bit of a crap (internal ticket was filed to improve), but long
> story short:
> * bootloader configures delays per index
> * in the pinmux configuration, we pick which index to use for the pin
>
> On Beagleplay, for example, the HDMI hot plug detect GPIO benefited from
> this[1]. Corresponding pinctrl.h macros were posted in [2].
>
> Why do it in the bootloader? since gpio inputs could also used in u-boot
> (e.g. MMC/CD)
>
>
> All said, Tom's question is very valid - we'd rather not modify evm.c
> for these specific configurations (popcorn as they might be), and we
> need to figure out a better option to introduce this kind of variation
> cleanly. For now, I will try dropping this patch.
>
>
> [1] https://git.beagleboard.org/beagleboard/linux/-/blob/v6.1.33-ti-rt-a=
rm64-r6/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts#L311
> [2] https://lore.kernel.org/all/20230619131620.3286650-1-nm@ti.com/
>

What happened to this? I still need something like this patch (a version
that has the CFG register writes correctly ordered) on top of current
master in order to get WIFI on the Beagleplay.

Jan

