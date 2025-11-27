Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEC3CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 12:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F9658439C;
	Thu, 27 Nov 2025 13:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YPTM62iW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5AB7843A9; Thu, 27 Nov 2025 13:51:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82C0D8438A
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 13:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1764247861; x=1764852661; i=xypron.glpk@gmx.de;
 bh=dK54P6186oD1ZL+ih+I74VwrL+Dx1SeXDBNRp7mK4ok=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YPTM62iWZ0wRmkOcTU2h40HuypZJKbjYXjKKf6IILD0JXrcUt54MBHPc6Ut0mZFn
 a/GRcplxZbUF/k2uy7wWtb3lAQV+E9K5xPBj1JkIXzuMdmbukIl4lbZnrVFSMID+c
 SEk+eU1lu6C+5XYorlcPvQ84q1I2ErAWEHhB3DI8p/+PtbvaoBaHY9T1NSGWa/axK
 6qePfVNgpOSTRJhvg4+d3dpgG4kwRs8lXJko2xwqzBAYqgGmaW3OyZ44HLG45qUPZ
 4MoNy8TdFg0M3re6iXOvKA+L5acLfh24P7+drvcd5H/YcIgvZAFDpMHF491nIO6gY
 XGica6DJtyhetLcZBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.120] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2E1M-1w69UY3twU-011XiM; Thu, 27
 Nov 2025 13:51:01 +0100
Message-ID: <3413832c-3682-48bf-afb9-ca1c6ac9f372@gmx.de>
Date: Thu, 27 Nov 2025 13:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>,
 Heiko Stuebner <heiko@sntech.de>, Alex Bee <knaerzche@gmail.com>
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6+S3atRAuBTg8es/gA4yGOtbrC/oP6j/HJLZE5mvMDf+GNJ2CV0
 MhprjDHEX50pqwquairiJjGJM96qrWpNOmg5gE+mJxRr7oGCInisC8QhbHhJfK23I9mPiQ5
 +3wQY8yOuELJQV59eDr/EpMIvrfZvI2Fs1E9TMnlaGIEhni4XblslsNAc5TiCamx+Gruen9
 DdR2Flx8unmVSeSt0EnQw==
UI-OutboundReport: notjunk:1;M01:P0:9wbzlVXPpq0=;OIgLClgLRJJv2Z/zWL3B6sPIhYF
 Jgvhc2hpiv40idLcQMnXQ0wujqZQxHb9Mf/yZlvDc6l4yWInRWz22bEvWI1e9s8k4ym+H2um0
 nUSVob4DJR3C7F4lCEu421WSe0zFnePuRQnKBFAkGmPk8gqKfBl9eBdhlk9x0G3n3jTNYFqLo
 1xxDyLpW3hRy12UvWzyjJr0Q+/BM5blWzShLb0Kvf8RSIqeiTZgmqb95Y7Jg4aoLQReRD8Qxl
 U8KxQaXvCvk5pQxx+3dyskEda38HljfUwDkAqMih2dxPBz1WGrKbMIItSOotL2isBOsoewm5R
 d1NJP7MQXwU7E6pE9jrORByDu2Yarxqi4DX0e0gL/+gG3Xs/qK64NEOIACPnstXyontV7IADE
 U0jNl9cqXzmULMCvR9/PnOQ3p2CiMo/a1sg3ei0+KZyamBtUviFG0bJYGYmbq+kHYfWzQlhlw
 1V7lSM4grqnPcRyAoDajUhZn0hW6ylAdjshDmcJdx1H+8rwrGucfk22jYJxsttLoZ142VK8Sb
 cdvg6EE+Xx+QoT8ggrtPGqxTIxED+Uj+9rQ6MMUkeE/jAxZZpMpm3FSfJVKm7wR6ThKCSWQZI
 lsaFcoalVFrJ0hRuUqje4RA4jerI2ZJUDgnqeG8n8qBy4diFcSwqH/18KEEM0SsEbebArZ/nL
 peAZQLDlU0Xl2dXlNhcb5CCea6TygK9tCd2EpFvrFlrKblyhs7L+/GysirYENTmqmhh62MQpj
 usd2cgHZnJf49Xjf1712IX0mwQcpEHwOfkAKUZpbSyXIt+o91eOYUfeR6EM+aloLAI2Mn5Ihp
 pOqElObg4dEbJd713N51U7w0A/5huDdiV0AKWRBUcQgrgSyi+fpiCNz8/om2q+WgMtUnPGo/Q
 k05GNAoZ8HP6aLJQlg2rTd38eWl8XGHOIgf/WVcN/xWOV5MSxuAvtGmscEqiFairEMsPVrGJh
 xF6EKIorWOCyPmtDBw2p1bri1qoe6xv90AoTgBf2pFEOqRxe/ix2z420jacV7wKApZjMTu9t+
 s+jFlCV5IO+RPvdDMviOtU7Ew35Ge5w+xkMrTVBI41O3Ukl3gGjY6hNubqo2nIHTGI2dedmlv
 LSydFAEhKWQ2vZKmNnekArThnMQPw+PaV//WzPrj71u3dFRxRgI+Vp3Kp+UuYPFSCtpy14E1F
 RFFaF0CY4udFurSg0UtwJfRyghfAhfceGWpxRlurbUrdJFby/lxvOHHrVGn3zdok8sLgDhURa
 Hdcl5Prz8iP/tnTodGlPYTW7n3wzjKue1FeNoRzYsXRqr4k9R367CZbOo0SAtZipBXQ8HZ1I0
 S6q1HBPFVdzO4EkmCdfDixMnxo9sq5qpZ2/yOOIltlSh1u577cT90YYUe4YypRlMFkFFODUfw
 UB+G1i0hVjsvZ4jILdf8sGJm5ExdBwsq1kjbnvy4CjBqP+XTv14i9TTYLkf5Bfw27rgB0DeUi
 Sk5PWmpETNsUFL3puA8UYWeTXbG0/KycxEU03MdzOXea9tZqAFaHt7aMKcJFi4V8UN7+ApWhN
 Qkxdwtoyyohu5YyjEB34A8QmF7yp8nqYqfQMYi40/dvIDOJOD4TXSW67sZ4TL2Y4SSR/moZvA
 CYjBAKJeDqEQdulR4o2MH5NXBOpJdbf5qqqYbpy0KXqWopPKQbsZcJtLjD4P3npoIBQJvHbB5
 DPKtULMBwHtxjTXPWXTW4XK3EY19RWndbxo4ug4C9yAxyVEkhloT4KYmcqsfdxb06fwGEHeTK
 hp2dvlu88NEHP9vRQ/tdDzO0JYwQ7XIB8L3Hezz2HdYB45XZtj9v8YpOLJDq8lnnJN/uGQZvv
 oh2x99xXHih16TbG5oSwrHiEriExA8OJkyCTlA/hLzixJG3uy8fphzOBZXjqmi5JhSjihzA4f
 8jXs/daMULHaYm9hiy7AP4zFIY8vk8t0lHF6dejagI1FcqdLynZW8/JXcXlGFN+3hwdkLzrwB
 MFtOV5LZCwWOlqKR3qBythp/yV3u27cArIL/4lmDXnYtt6SPYuyHFwYBCxX/Und+dHyZYoG1g
 ZngQewaYSpXYwloZhjm62lHugYFdE81ItdO7sBYyzCYuuo2eImQqu5XlaT4XS5G97VpWXr15M
 GIrxRcVA85Py/I1tWgLIAkL2qXNZKEOoeiQNaPqpRW77xDNi8rTMEYjVg1DMaPrHIRCYwdnva
 UMMWLovvky+oie3ZpVzafntozhRYJ8+ahwArXFjT+B3nII/Awboa4TpF3MuffyfJ28BR1P/ER
 GbsoEwCNJ4UdcLNyYHJ/A+kbQ5A05nk3ToQBN8eKnfvB2jt42qksxXyG0y+zGAbr/jftDZz72
 hh0oEDT7pA07wrM8TrXKb2KRnB4o2iYF48sddkol0NQkv/7SD/BfsOsY/FmIBxn+WymcF8fa3
 WjnKP1/Kp03Yf9oZEDBaij98fLjI2APDakepbOmMpA08ae+p+EG2AdYmydKnGpCjNPX+YTJ9M
 lfFDf3KgHYL64+HlLHd7XPFtODXpbkPUvzvdGU27yZ2+8nbhr1eI/XQ7oX/XbrjuPXaQ/eVPg
 gLAha0SE5aY6Ro3nVsnZxRD2yev4rQrj2ntQFQpnOdFuEH6fvnMFwa4pF2JKsv+LtWyT3ii7f
 /Ho1mYjlMKeHpEKlwYIYUbYSoU85888NSfBVRPKrP0jFf6ksIpLA+wQroW0MG9icyJqSB5lx5
 ksxSYdlrL4SVKi/bbPHt5IvLKRp0LXpNZbvL6J4RtuhEiHFTdiF4RMkA59S65YOyAI3O9fShb
 QilR4/osbvFofZlgJXUBBBzNBXbSeP4NIVw11su3Ro2QAoBso3Jeb4BFaOF8ZbX61AKuyiiRp
 rlQ5ikICbIUDWjuWq/4gAevs/sFkcS9Q90YnHSIISArg1ALPo7hrUBxn7iYEUcagP+dKkAXyX
 RAAQB1nLv9lIhY28nrDkLClYub0O1WqwBDtiYNoSvsIpFbbkV7sk03iXwH0SD98iHh7wLrD/c
 IIQ0/91jSvBWpUFxjbHabYHPErJZLthUiYC9KGoN10V5MRHd5U181JvUAtCRJjzMubvg9rCd6
 kX7ZcMh/cE07/XF24FPHKx7OafeLw7kdR7F9G0laT4oONWIOAr7j1qi7ekpzRKb8oKqu8A//t
 cT4BTr4ZIyukkvMDhOlAsaH/RREZzDaAoYRlVV6jHYbG6a71NfYyf+ud/mIYnCejufh+ILJVT
 qch09yXLwM9cqgE4TmnSH+H+qvmbE/VvvZg1gsoZfqWmUds3XW7gsfQFO5ZBmvggZ1cT1zAJr
 U+eJIAlFAoLAL62DlXDWMGvCttm9XQ7kG+D1slh36sZmI0/bmsQMBG5MCfhuwtH3qOHl+LW99
 Yid3DHNpp2TCkZLE2AsGhUOM2bRA3wS5RFUiN+yi1fjV/2lQPnrUPbfox7emZcmrCHBb+UWjK
 qI2XXLvoPDI5+oE+V7QFsvxALn/CzI43spO23Euzc/qSHz8Vcr+to3RYm7Fa9Wc9AEm/N5PMp
 PufxYGK1YQL0FQix8Gw1rB2CrACwitPSAPLnrHycu7I7CD3dxLp9aSdNt8zc+LwCe8It2ZL4C
 0FAGMj2fHS1JMKhhyLpsVD79hthrZvwFFfdu6zd55DeyRHEqnTK8d/13cKMzIooHX0ChIiIxt
 6C1o48ZkOowAZMhBKOrk1qz796pjot5N+KfWQmm2Wh4D4+2tUnvhQWFj9l0gDSxtU0Lez420f
 KKNAtiFMiBN52wtFsZzlrbuzETgK3wYxMS845EftbMZD06SS4k+hHYshEIlbdCUniFFmt8Qh8
 XApyYTpu3Y+FLQHNRMi5UIsRbmqjFnaDU+UdPqgik7RIbP0Wzo7OUpQdvv5n7XlidcYR4RduS
 7GpflvcAWtqmb0NvyWebszwGDEHdAgFxTi+mQ2c37AJjVbvIiInG/7T5wzA9hM5jtUtY8e+W5
 sWRJaOUAsTb1OyfhSBsWC3PYMxBoUChcNnPS0I7Ajm/KshM2Jty8jS5KTf80oXABCWRMb1Xze
 ZOtYQ+AAJSB4ZxTWorgpRofB+XkuMOaPB+cyL+KMNzArCtKEnf7rLlZ+Ny3XjBS2UKSCDJXqY
 tK7Fu9JNEX0lK+B+rJuD8QS9BG4OGLmPfOEsLoeBm94+h9qL0WBRFNrhhZbm1APltYU0TrQ+9
 fmwFznelJbDVmyjYH5iuyWZ7lUkb9KmrWjofghQreHZNvbsBJf8IwmJm8YZl8UvloboC0Qszb
 jeU4n7Y80DDEtutxKy6Jh4pXHfiFM3wwcoDme6HqkptKxO9bsdAD/OcoLeV1xR35ZxzZYw0ej
 XiKPWw4dYoRg+tXw/oanDxC4Li2WZ7z1E//hoNve/SbeliCKwls4PIgOLMdSt8/0zq6FHp5up
 ycK0SB/65vVnmARpdUxHffHQ6i+It/FW3QEXFy2DUGoCqf5Msa/0IKV9kISVCLvKJ6g5KdBQI
 YXqEoBNk2ZCtus+SDWBG5sOtwphCs3kcNL7wxB4eEZrTYu6wbDYcHlsoWl+Z+Gyt0SNDfMm+j
 lIuJ/zN7L9QExSYg6oE5bPJ3Xy0ZxqNFlwO1w1UyHZbYFwqeNbfAhYB2PdKoPnzjaVwJHxrDN
 rc+ISMT6/84sulkLta2hBEcfDq69Ms4u9ViOD1JI32ADDeIZ09BQYhZeidZkZXh04zHkMcLZ6
 xsq6Y0TlOVNagBpHuh0K0PIWPTzF+YM6GDgXdP8Tl8G7ouaOxn7vj4HoEeW6BzCbJnBA3FhJI
 foeEvmCqqcUhYD0lcwFevQu6oU2/2QAJxqBJG2Ooc/SnBV1HjSIJLSS+sDVQKgoYovpWdRYTi
 mtzGvzOqPtd+jZUnjWWraTahYU/FIE0+c1sYA6ClqJefqQF7JMjM9EI6cUt3oMAahnQRzAmk2
 0mRo4sBfDKvr0xXyUcmjeWMF9vURt2RDw6dwZiO2ylQrg2UskIEQTkbNh0VDXuwLxJhraD++E
 cWCh4eTywb/UiQ0sdG1bR8aVbnrjPDDfSct1UEYEqF9YrgiJxPtve7QVTPZ5n/RrXmFuMeaDe
 cEJPt0RL6eZc68+K5kMABBzFd8KxZ/EvdF4qmNjoKCqc0gkER0qmSVk0iTOKmHE6Tupq17MTH
 nNtfM9gaEVyWXO5AbcTcdjsd55lh8zGiXvvQq89uUl5Mz9BMt2UsTNcBNLkPD92YTIPTMOs3c
 JuljXcGjWQbi80Hct++UQWkM4A815lSsc9dYa/NqHE9olg/LIlKKl4NvtFqO/lre+v2egiOOx
 NggiaLp5vg4TbKSb+i0jhIsRyjH3L
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

On 11/27/25 11:45, Quentin Schulz wrote:
> On 11/27/25 11:35 AM, Quentin Schulz wrote:
>> Hi Heinrich,
>>
>> On 11/26/25 5:46 PM, Heinrich Schuchardt wrote:
>>> On 11/26/25 16:00, Quentin Schulz wrote:
>>>> Hi Heinrich,
>>>>
>>>> On 11/25/25 7:02 PM, Heinrich Schuchardt wrote:
>>>>> Hello Jagan, hello Heiko,
>>>>>
>>>>> When testing U-Boot origin/master on my Raxda Rock Pi 4A serial=20
>>>>> console output stops after "PMIC:=C2=A0 RK808". The same can be obse=
rved=20
>>>>> with v2025.01.
>>>>>
>>>>> The serial console works as expected if I disable=20
>>>>> CONFIG_ROCKCHIP_IODOMAIN.
>>>>>
>>>>
>>>> It is I believe implied here but asking for confirmation. The board=
=20
>>>> doesn't actually boot right? It's not that the serial console is=20
>>>> gone, it's that the device is stuck?
>>>
>>> Hello Quentin,
>>>
>>> Thank you for looking into this.
>>>
>>> The device boots I. But the serial console output becomes mute and I=
=20
>>> cannot send keystrokes via the serial console.
>>>
>>
>> Uh. That is *weird*.
>>
>>>>
>>>>> The problem seems to be specifically related to the bt656-supply.=20
>>>>> Removing the line below also fixes serial console output:
>>>>>
>>>>> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/=20
>>>>> rockchip- io-domain.c
>>>>> index a0573c52193..b0d78f2d4b4 100644
>>>>> --- a/drivers/misc/rockchip-io-domain.c
>>>>> +++ b/drivers/misc/rockchip-io-domain.c
>>>>> @@ -239,7 +239,7 @@ static const struct rockchip_iodomain_soc_data=
=20
>>>>> soc_data_rk3328 =3D {
>>>>> =C2=A0=C2=A0static const struct rockchip_iodomain_soc_data soc_data_=
rk3399 =3D {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .grf_offset =3D 0xe=
640,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .supply_names =3D {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "bt656-supply",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* APIO2_VDD */
>>
>> Reading the code and this diff again, this you shouldn't do at all.=20
>> The offset in the array is the bit offset for the IO domain setting in=
=20
>> the GRF at offset 0xe640. So by removing this line, you configured=20
>> APIO2 IO domain with APIO5 settings (audio-supply).
>>
>> It would be better to write NULL instead, so that the others are tried=
=20
>> and we can pinpoint the faulty one.
>>
>>>>>
>>>>
>>>> The UART2 (which I assume is the serial you're using for the=20
>>>> console) isn't on that IO domain. And there doesn't seem to be=20
>>>> anything important to booting on APIO2 domain according to Rock 4A=20
>>>> schematics[1].
>>>>
>>>> bt656-supply also doesn't seem to be anything special. LDO5=20
>>>> (vcc_3v0) on RK808, which is using VCC10 (vcc10-supply) which is a=20
>>>> fixed regulator whose parent supply is also a fixed regulator. So I=
=20
>>>> am not sure what could be going wrong there.
>>>
>>> In the schema LD05 on the RK808 is connected to VCC_1V5.
>>>
>>
>> Sorry, I meant to say LDO8.
>>
>>> With any of the following values I can enter commands via serial=20
>>> console but still get no output. So none of the voltages seems to be=
=20
>>> the correct one.
>>>
>>> diff --git a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi b/=
=20
>>> dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>>> index 046dbe32901..f15b5b63815 100644
>>> --- a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>>> +++ b/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>>> @@ -517,7 +517,7 @@
>>>
>>> =C2=A0=C2=A0&io_domains {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 audio-supply =3D <&vc=
ca1v8_codec>;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt656-supply =3D <&vcc_3v0>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt656-supply =3D <&vcc_1v5>;
>>> or
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt656-supply =3D <&vcc_0v9>;
>>> or
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt656-supply =3D <&vcc_1v8>;
>>>
>>>>
>>>> RK3399 Puma and RockPro64 have APIO2 set to 1.8V vs 3.0V for Radxa=20
>>>> Rock 4A. Puma boots master reaches U-Boot CLI with the IO domain=20
>>>> driver compiled in.
>>>>
>>>> Can you check the error paths (all the ones with a continue;) in=20
>>>> rockchip_iodomain_probe()? Which ones do you enter for which supply?
>>>>
>>>> Not sure where to start debugging tbh.
>>>
>>> I found the driver by setting CONFIG_LOG=3Dy and log level 7.
>>>
>>> Here is how the console output ends. Do you have access to a board or=
=20
>>> do you need further debug output?
>>>
>>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem:=20
>>> regulator-state-mem
>>> regulator-state-mem
>>> ofnode_read_bool: regulator-off-in-suspend: true
>>> ofnode_read_u32_index: regulator-suspend-microvolt:=20
>>> of_read_u32_index: regulator-suspend-microvolt: (not found)
>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index:=20
>>> regulator-min-microvolt: (not found)
>>> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index:=20
>>> regulator-max-microvolt: (not found)
>>> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index:=20
>>> regulator-init-microvolt: (not found)
>>> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index:=20
>>> regulator-min-microamp: (not found)
>>> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index:=20
>>> regulator-max-microamp: (not found)
>>> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index:=20
>>> regulator-ramp-delay: (not found)
>>> ofnode_read_bool: regulator-force-boot-off: false
>>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem:=20
>>> regulator-state-mem
>>> regulator-state-mem
>>> ofnode_read_bool: regulator-off-in-suspend: true
>>> ofnode_read_u32_index: regulator-suspend-microvolt:=20
>>> of_read_u32_index: regulator-suspend-microvolt: (not found)
>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index:=20
>>> regulator-min-microvolt: (not found)
>>> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index:=20
>>> regulator-max-microvolt: (not found)
>>> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index:=20
>>> regulator-init-microvolt: (not found)
>>> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index:=20
>>> regulator-min-microamp: (not found)
>>> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index:=20
>>> regulator-max-microamp: (not found)
>>> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index:=20
>>> regulator-ramp-delay: (not found)
>>> ofnode_read_bool: regulator-force-boot-off: false
>>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem:=20
>>> regulator-state-mem
>>> regulator-state-mem
>>> ofnode_read_bool: regulator-off-in-suspend: true
>>> ofnode_read_u32_index: regulator-suspend-microvolt:=20
>>> of_read_u32_index: regulator-suspend-microvolt: (not found)
>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>> ofnode_read_u32_index: bt656-supply: of_read_u32_index: bt656-supply:=
=20
>>> 0x7a (122)
>>> rockchip_iodomain io-domains: bt656-supply: Regulator LDO_REG8 at=20
>>> 3000000 uV
>>> ofnode_read_u32_index: audio-supply: of_read_u32_index: audio-supply:=
=20
>>> 0x91 (145)
>>> rockchip_iodomain io-domains: audio-supply: Regulator LDO_REG1 at=20
>>> 1800000 uV
>>> ofnode_read_u32_index: sdmmc-supply: of_read_u32_@L@@p0b@HHb```Hp0=20
>>> p0=C2=A0=C2=A0 $
>>>
>>
>> This seems to highlight the issue is rather audio-supply.
>>
>> And indeed, audio-supply should be vcc_3v0 and not vcca1v8_codec.
>>
>=20
> Mmmmmm, upstream kernel has 8240e87f16d1 ("arm64: dts: rockchip: fix=20
> audio-supply for Rock Pi 4"). So it seems it "fixed" something.
>=20
> So before I send a revert to the kernel and start an endless thread, can=
=20
> you test locally that the following indeed fixes it?
>=20
> diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi b/arch/arm/dts/=
=20
> rk3399-rock-pi-4-u-boot.dtsi
> index 4861574636e..dccc469a507 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> @@ -14,6 +14,10 @@
>  =C2=A0=C2=A0=C2=A0=C2=A0 };
>  =C2=A0};
>=20
> +&io_domains {
> +=C2=A0=C2=A0=C2=A0 audio-supply =3D <&vcc_3v0>;
> +};
> +
>  =C2=A0&sdhci {
>  =C2=A0=C2=A0=C2=A0=C2=A0 cap-mmc-highspeed;
>  =C2=A0=C2=A0=C2=A0=C2=A0 mmc-ddr-1_8v;
>=20
>=20
> Cheers,
> Quentin

Hello Quentin,

With the diff applied my U-Boot serial console works.

I checked the u-boot.dtb: audio-supply now points to
LDO_REG8 { regulator-name =3D  "vcc_3v0";}
as expected.

CCing Alex

Best regards

Heinrich
