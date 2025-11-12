Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6618FCCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 09:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2BD483A6A;
	Wed, 12 Nov 2025 10:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jm08l5Xa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ACDE83C14; Wed, 12 Nov 2025 10:57:36 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D52583A03
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 10:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6406f3dcc66so1006514a12.3
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 01:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762941454; x=1763546254; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ro74g+muccl7h7tmgvmCdkdBVn5SRU7CLHdeW44xNDg=;
 b=Jm08l5XaUD/+grvS5oMRnOKik4UciSW5BAXqD9ASf6VX8fUaN/fCZj6BYLeR6kDGs5
 LSmOkCRynUCSdg7dIq4P9Uz2LvlHbVh+mxeI1AUDMMcJGKQqcuy63J/92wGZ7dtlOrAZ
 4oKiqW5PUjZfQT9+Y0U24Hn0zXn47hevBlqF7XvzfEaJCZL5YXning7ny5GWRWN1NY3H
 BB5/GRmm/DDqIUt5NZpdm52rGAHO2IVNxOuM4frDfUE1DXCvKjmX9+FMlZxZLtpFSXzY
 xP50LkC6AdpERjWkQ6O8okyOxouXcaVvEFe+vHODhLNbHJZN1NcvbKg5XlwxuTwhwKmo
 ky4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762941454; x=1763546254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ro74g+muccl7h7tmgvmCdkdBVn5SRU7CLHdeW44xNDg=;
 b=wKOu1mkyt9kkMMXFy0Xq2Gu6yCIlfGCuBRg6pni6oMftWDAJrXXsFbIMf6484GeLW4
 SvonSti4geqzzVirI+WcslZeyijSHHL1PT0KPJ88O6BOzokLav4+qriu63uUrNFNBfj0
 ZaBjl5C77UwAHEO1DQ00rwt5oDoMqRwJrt3YcYcIRJdLZle4gkliswWb74++PKhjxdOr
 4kq3fzf2IlKTdskI4oBmKMCPiMzw0WlomL66gPHGzEVYoK5LiBiDdaQvN3buAXD+Wnno
 5X3d/2AAdjZAGEch0NCFjo55Ev++A8c0XsRUZ+F5fya1pJ36mPd8QBPdDjYLEIp5zb9g
 JrUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWsVcL9fqLtFsFzyVobyOw2s+1kJU0rOvu9YqmUex5PUwxv6vrnKow5jDdNsNgDAWfkaSGGXo=@lists.denx.de
X-Gm-Message-State: AOJu0YzzhPBZskjWuBF+j316o2Ot/hHmTYdOvuI0nGjSNOCTPxSiH1CO
 isPklCD6a+9lRFISOtHEs0zLbBzNIoEgub4xcYak6wYd9kJhfV41tY/M
X-Gm-Gg: ASbGnct9SbYRzJDMg/PP7DTvPRYZHnXK6NgMgTTZNxB7I89E7SHyWlcqaN8KRPb6Pwx
 gcpHpbKvWKMFYg+bo/B5GxkKDfqYB+A9aF9zrM0dhfmwAl0TeTlmuFJc2/dauV6/cj5HpErtXEV
 A2KDVt4vNikriFX7ZyX8keWYjYo41LdkgXfqo7qwSwRUvD6Qp75lXpDwCofvaewCbRGG+8F6HKl
 uoPffP9Uy7EGJTow1bOJxFS/3JvTuXIBVz5uV3KlyDWFOVnZ1svKywKtfuUicEPcXM5jllStlb1
 ohriCyKaxsDnFKbOZwWwUP/wyK1WDofdoi1wuu9dIExKA8efcrSdLENAhWSCLYhLB6FrX7yPY0h
 QK1Pn86hti54U05rSqZm+Ks96IFPhW0GM8UH40d6Ufl4f/rIRbwD766RFkVz/WGjc/09bcr2ioH
 ZfoK/X80xW6Pn4f/WF0groKJ/M63+5hLf49T9hNMx1vS0d4X3ONVPfpLFyqw6bp7s1eiFpH4CRY
 oLISZw=
X-Google-Smtp-Source: AGHT+IH/rzjUBNVpfE80/Do96oCQ6wAEabKxXicxzfq1s5+yPfAYBL5S6JC402a64Xt7CqvG9+/iDA==
X-Received: by 2002:a05:6402:50c6:b0:641:2cf3:ec3e with SMTP id
 4fb4d7f45d1cf-6431a4ca1d2mr1998018a12.11.1762941453693; 
 Wed, 12 Nov 2025 01:57:33 -0800 (PST)
Received: from [10.0.1.60]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6411f862bd0sm15700018a12.26.2025.11.12.01.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 01:57:33 -0800 (PST)
Message-ID: <e9c56d66-b2b9-456c-856e-2ef01a009e16@gmail.com>
Date: Wed, 12 Nov 2025 10:57:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: Revert "imx: mx6ull: fix REFTOP_VBGADJ setting" and
 fix comments
To: Ye Li <ye.li@oss.nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: uboot-imx@nxp.com, trini@konsulko.com,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de, u-boot@schwermer.no,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Jacky Bai <ping.bai@nxp.com>
References: <20251027115638.1186252-1-festevam@gmail.com>
 <CAOMZO5B1sxS8Vh1awupGZd8oqqLhZ55abME07Kf5AZ-w9jUKhQ@mail.gmail.com>
 <3ab1b3a6-b9ab-4571-a7c8-8288d4a8d290@gmail.com>
 <CAOMZO5BcMu_94qn4vhDgxmdWVx0N-mCD9wYTvAPbXaK45EUFBA@mail.gmail.com>
 <b6b82482-ec7d-4703-ad93-ccdd7a651b57@oss.nxp.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <b6b82482-ec7d-4703-ad93-ccdd7a651b57@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 12/11/2025 09:16, Ye Li wrote:
> 
> 
> On 11/11/2025 9:47 PM, Fabio Estevam wrote:
>> Hi Emanuele,
>>
>> On Thu, Nov 6, 2025 at 7:22 AM Emanuele Ghidoli
>> <ghidoliemanuele@gmail.com> wrote:
>>
>>> Hi Fabio, Ye,
>>>
>>> At Toradex we have been struggling since quite some time (back to 2018) with
>>
>> Does this problem only affect early i.MX6ULL silicon samples?
> Hi Emanuele,
> 
>     I have same question as Fabio. Are these samples are early? Do you know
> the time of receiving these sample? And could you show the part number printed
> on the chip.
It could take a little to answer to the first two question. I can say that the
SoM I'm using to validate the patch was assembled in September 2021. Let me
know if this information are needed giving that I can report the marking on
the chip:
MCIMX6Y2CVM08AB CTDQ2107 1N70S CHINA QGDQCTA


> 
>>
>>> the temperature readings and the thermal shutdown behavior on i.MX6ULL. The
>>> issue we observed is that the thermal shutdown seems to trigger too early.
>>>
>>> I have investigated the history around this topic and verified some internal
>>> notes in our bug tracker. With this revert applied, and on the devices we have
>>> (all trimmed with value 0), the reported temperature increases by about 10 °C
>>> compared to before the revert. The absolute accuracy of the readout is
>>> questionable: for example, on a device kept at around 20 °C, the temperature
>>> readout was ~19 °C before the revert, and ~31 °C after the revert.
>>>
>>> Consider that for devices with fuse value of 6, there is a -10 degrees offset
>>> after this revert (so, the other way around).
>>>
>>> I understand that for Sven this revert improves stability during large XZ
>>> decompression in userspace for few devices, but for us it means that the
>>> thermal shutdown happens roughly 10 °C earlier, which is a serious issue in
>>> our case.
>>>
>>> I would kindly ask NXP to double-check how these devices were trimmed. My gut
>>> feeling is that there might be an inconsistency, either the trimming scheme is
>>> not backward-compatible (e.g. old and new devices behave differently, and the
>>> code should cope, I don't know how, with this), or this patch must be reverted
>>> (because introduces a regression).
>>
>> Peng/Ye Li,
>>
>> How does NXP suggest we handle this? Were the early i.MX6ULL parts
>> incorrectly fused?
> I need to discuss it internally, will feedback you later.
> 
>>
>> Can the fuse be read and dynamically adjusted?
>>
> The fuse is locked by MEM_TRIM_LOCK. Emanuele, can you help to read it by
> "fuse read 0 0 1".
Colibri iMX6ULL # fuse read 0 0 1
Reading bank 0:

Word 0x00000000: 00320003
Colibri iMX6ULL # fuse read 1 0 1
Reading bank 1:

Word 0x00000000: 00000080

Kind regards,
Emanuele

> 
> Best regards,
> Ye Li
>> Please advise, thanks.
> 

