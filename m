Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F715C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 13:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9657801BE;
	Thu, 20 Feb 2025 14:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UQdlhawG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4F0D801DE; Thu, 20 Feb 2025 14:47:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C6458007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740059233; x=1740664033; i=xypron.glpk@gmx.de;
 bh=3H/NECE/OjuWHnGTdkP7bf6rCiYb9amwfPYgrK7GxNU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UQdlhawGdaji4e3UCfgUqqSKOHIO5OLOFxFWr4wMIVpy41EzSKp88V2XtDXLhqz+
 7tH72/9totiWJi9/qy3WOZdlbvEjd/JEs1hB1VH6IkOHeeaFdR+nLWLnCfu2irqDr
 5SQ8PUp4FonlrIuGSn6AG7AkH/soTHOFo9cEXftKByrsERY9cBM8vR5uChnWUvEKJ
 2VcRm5SdRXVE3jq72zj3kswQ9pP5gD2mTgM6BgWAl3trgwPWoeX174et5DIsw9CgF
 /oTwvKg0Zs76KqwQAeVhP+QHJ1HRzd8NphMWCuK1WClbGYUQwmuD2xD32kP6S789K
 ASEO7xn1wvoWU0WMKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq2E-1tVvUf0kw4-00ywzL; Thu, 20
 Feb 2025 14:47:13 +0100
Message-ID: <91b3d701-b624-4c32-a17d-72099e8a71d0@gmx.de>
Date: Thu, 20 Feb 2025 14:47:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Make FDT extra space configurable
To: Simon Glass <sjg@chromium.org>
Cc: Pawel Kochanowski <pkochanowski@sii.pl>, u-boot@lists.denx.de,
 Gabriel Nesteruk <gnesteruk@sii.pl>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250210160727.30993-1-pkochanowski@sii.pl>
 <CAC_iWjKLOw9gUxt+KE1iSTVsTawBPDXy40exTH97s7=+Bf3HRQ@mail.gmail.com>
 <6416d1a7-3221-4ea5-a88b-944f26af534f@gmx.de>
 <CAFLszTizFrZnRA49VoGrtgxmWiMSuL7Rip8Yk7tEAZVeNMcpwg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTizFrZnRA49VoGrtgxmWiMSuL7Rip8Yk7tEAZVeNMcpwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zf7oWG9w7M7cIRL1JKtD8q13xDHBoB9Ad2w/9ZlidYr+P5gjXkr
 w4yle0lAuq2LsCfB1qRiqd3snwm7BBIHyOqQr02CT1WlqHs2xGspLepUNn8wmrWPNuVFGXG
 UB49Ib10T6zmw6klwPFuN9usX6iF0hCLEA+SH08jjepPEnbYiTXzLbsvQvV5opruOuXwrTj
 KAD4ocf+4iLNySDNgOIPQ==
UI-OutboundReport: notjunk:1;M01:P0:SDQOr3Z/jYk=;UgHXpwJ+8yFiRnsNw2irCEA+PD5
 TxJWoJsIHPi4uS0uxrHcEOVUcqvD7siTCEJZpUGoHlKQm57lCzevlm0+E8AxLHLXId+wpDmnP
 Vk76tVvWlN9a0I6WEqvDpfYBgpWR6ik7wa6Qb0LKZVYif80j1EFdRX5fpBUStknEVtOW9l6Kj
 Nlnm+kZ0l2mrs6AKgipT0lOgnjUWbD3X1FnMBd/AQZaV4TgtA+G0PSEC5jKkmFDHVfkdRxVrU
 w2NYjs5uiA8P2uncwCd+sT+OfD4XDBWNXewGU42+Bly7GYk31i8SsFquuN+rerVDhZc09dosI
 /ANd6G4UM/lPSGwxP9wFqE8+2iUlOmvjajL0LJoJDUYI1AYuGmwoVGhwi5uiQZTad+0WIqdOJ
 u/Yn8brKDBWgFhpkU5NCY3roGmTOz64TKgctrm9jnIHdPYd6fyTrygFdJ1OMwmCxaLwpHefuW
 ajawxksh84BMtfSl4lS2U65RXyy/bDL9AYrJAyk6tnlB+f7Tf+nqzD2ncqRoisGHGyaDaUkYJ
 6LVjl+nx30dVdeISsLi28DwLZuGwnbuDArHE0txRXniRWQP6GjsnleTY7w+C6fgbqw1txQhNW
 H9OGK+Ol4TAcKe/r6fKdRT6vYpN13e+pDh4j/zao1S/Ry7hNrTp/jnwwPEmG3eNjybGp8kGMm
 EdyQWUCnLq0B2xeepxORiuGAsr3l/9Rf29kPdP7CX7De7GbBGcCSm7Ktlx3YRPPg3QOnp3Opi
 owf54Fqwf0bfMws6z+hWsF7ZfMQ4lXtWKUJrb/xMYSykjfWohX7rIdT8pAbGn8s8Z+1OjTPnf
 kRAvY+gGCa9vSb6Ne/idUXaQI5rdfB+g3vWuPWdjMTathLm0UZFEF1SCh38tTvsErPlMt8QX4
 JiN8cpFkBG4hQ0v0ZZGOEItiwVzmJ09AjH2gFoKBP2l0m5twGBYgydK0Q2XPM6eWZLTSK/MNY
 CEUkRaGMNhbRHfGmcVhflLoNyaSTWSIxzFU2XjTebPSFGVVP8oil7EK+VW5Op40+esn+5BRfn
 ACxOIgrjRopTg1wbYft+kr2Hy3S1ztELpC7EPczvaReT9xYMmBKRaY4Hh+0wexyB4NiLbjmPl
 4L/P2OR4VEqf04BqsPjsFxAQMqWlb8Mml69m8aDcqaXYYToBJ5YqT+C3ZuTDp3F9kyCbDngk2
 RJU7PT9DFK3wV7Uzgp8ikKM15rUiJBlqqugrYi7YeKFLmq2vxU98ey+FnUJDUx92WqpwdN1D0
 csD+MOvqiEkgCsOP2W1GJk6/yRu+y9Mz1WG6Syh2nv0hI6DekilAS9jyvcClxasIPqN+L51Jj
 lKpMa/L6epWe4AfJmMUKQIaQcQ068sse3M8taxZp/vkPAnB6iyRkkF1VXyLZXqYuu5cwIVxR/
 J9Lq2mhy1Vzt7Nhfk7bzuqNThmvEjwN44zRhlOUErCj2Fzdpq6BGv6HyuQeScBYl3Zpv8ejPH
 Lc0LEVyK/F7swVnASybF3M76fKi0ABrziDRx6dPWcFhUIYRFo
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

On 20.02.25 14:31, Simon Glass wrote:
> Hi,
>
> On Thu, 20 Feb 2025 at 01:21, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 2/20/25 07:58, Ilias Apalodimas wrote:
>>> On Mon, 10 Feb 2025 at 18:07, Pawel Kochanowski <pkochanowski@sii.pl> =
wrote:
>>>>
>>>> From: Gabriel Nesteruk <gnesteruk@sii.pl>
>>>>
>>>> U-Boot currently reserves only 0x3000 bytes when copying the FDT
>>>> in `copy_fdt()`, which may not be sufficient if additional nodes
>>>> (such as FMAN firmware) are added later.
>>>>
>>>> This patch introduces a new `CONFIG_FDT_EXTRA_SPACE` Kconfig option
>>>> to allow users to define the amount of extra space reserved for FDT
>>>> expansion. The default remains 0x3000.
>>>>
>>>> This change prevents potential corruption when resizing FDT after
>>>> EFI boot, especially when firmware like FMAN requires additional
>>>> space.
>>>>
>>>> Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
>>>> Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
>>>> ---
>>>>    lib/efi_loader/Kconfig      | 9 +++++++++
>>>>    lib/efi_loader/efi_helper.c | 2 +-
>>>>    2 files changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>>> index d4f6b56afaa..bd2cbe995c9 100644
>>>> --- a/lib/efi_loader/Kconfig
>>>> +++ b/lib/efi_loader/Kconfig
>>>> @@ -586,6 +586,15 @@ config BOOTEFI_TESTAPP_COMPILE
>>>>             No additional space will be required in the resulting U-B=
oot binary
>>>>             when this option is enabled.
>>>>
>>>> +config EFI_FDT_EXTRA_SPACE
>>>> +    hex "Extra space to allocate for FDT expansion"
>>
>> Hello Pawel,
>>
>> Is this problem really EFI specific? Wouldn't you have a similar proble=
m
>> when booting via booti?
>>
>>>> +    default 0x3000
>>>> +    help
>>>> +      Defines additional space (in bytes) reserved for expanding the
>>>> +      Flattened Device Tree (FDT) when passed to the EFI system.
>>>> +      Increase this value if your firmware (e.g., FMAN) needs to add
>>>> +      more data to the device tree after U-Boot relocation.
>>>> +
>>>>    endif
>>>>
>>>>    source "lib/efi/Kconfig"
>>>> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.=
c
>>>> index 04b2efc4a3b..91b2a5b8653 100644
>>>> --- a/lib/efi_loader/efi_helper.c
>>>> +++ b/lib/efi_loader/efi_helper.c
>>>> @@ -477,7 +477,7 @@ static efi_status_t copy_fdt(void **fdtp)
>>>>            * needs to be expanded later.
>>>>            */
>>>>           fdt =3D *fdtp;
>>>> -       fdt_pages =3D efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
>>>> +       fdt_pages =3D efi_size_in_pages(fdt_totalsize(fdt) + CONFIG_E=
FI_FDT_EXTRA_SPACE);
>>
>> This is not the only place where the configuration value needs to be
>> considered:
>>
>> lib/efi_loader/efi_dt_fixup.c:171:
>>                                 0x3000;
>>
>> Could you, please, send a new revision of your patch.
>>
>> Best regards
>>
>> Heinrich
>>
>>>>           fdt_size =3D fdt_pages << EFI_PAGE_SHIFT;
>>>>
>>>>           ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
>>>> --
>>>> 2.43.0
>>>>
>>>
>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>
>
> Let's do this instead, as it is generic:
>
> https://lore.kernel.org/u-boot/20241206131113.2865416-3-sjg@chromium.org=
/
>
> I believe the copy_fdt() function can just be removed, as the FDT is
> already in reserved memory. Putting it in the ACPI_RECLAIM region is
> wrong, too, as it is not an ACPI region.

Hello Simon,

UEFI specification 2.11:

4.6.1.3 Devicetree Tables
The DTB must be contained in memory of type EfiACPIReclaimMemory.

EBBR:

The DTB must be contained in memory of type `EfiACPIReclaimMemory`.
https://github.com/ARM-software/ebbr/blob/75112a58a5eacdfee758ce1b93ef3692=
b225fc36/source/chapter2-uefi.rst?plain=3D1#L396

We need the copy as the original device-tree which may be at
$fdtcontroladdr will not have the required space for expansion.

Best regards

Heinrich
