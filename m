Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDC4CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 08:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C5D86BB8;
	Wed, 18 Oct 2023 10:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kA4T1vlS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B891986BD6; Wed, 18 Oct 2023 10:15:33 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECD1865D0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 10:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0661C3F721
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 08:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697616930;
 bh=L2xe6N1Z9felzZPVfC0OeRiojKpxJF17IZQt8eccXSM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=kA4T1vlSUyDk+TCLEyFgmbJjRsiS6nxj4pNX6eFeCKUyYmj0z0l2WN5/bSi3WHs3u
 o5xpoS2jLybYAyT0rmpqQlv/0A0AQLnif1OPL3agv1PyjHULHCWxmjYbuKuuxuffDq
 mYZYSJ3L/mSCkBL17m55tyWT+K+sMO2i3dsuyVnKI5YEjyTci2qsMdI7t8V7DMqv3b
 /wPKKJPMaS49n6dnaZxXUIsss3SZWx9zEHRowpN20Zvdh+0AeWuBX7AHijfue7knbe
 /OZvF0UjRDTOXqP7QxDILqxOn/Po0p1MieFaUCQTveNmv+gLNT62HUTxDdw3zJTOZd
 C2rxO16Jibg6A==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4053a5c6a59so42337105e9.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 01:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697616928; x=1698221728;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L2xe6N1Z9felzZPVfC0OeRiojKpxJF17IZQt8eccXSM=;
 b=BpMjCKmLlNNj0dCX+jULEFUeES4PKUVfDc/Efy6XTWVd3+dhwbwG29PlVYMGBAa5Wg
 Xr10BLJH+CCDPe61YT8qnjWqqoJ8b1WLT16eikUWuYbLevOSzFcsYNmFsOgME9KzbIXM
 AiVBi5AWhoB2+5lPZiJaInqxfQJJSPE68XtjRYshGDNpGOeI4GpIrvzZ758HG1/g5dm/
 OWbG4rF65MWbGOtwlTBuJnRc1mvUvjgEvk3xBTs3PegtU38jhs1IfBi9hKIQnr2c6Bti
 p42g2qiv5zAM90gdriGAbf15EcWRAUUVcj21DTTeBhaO6B2L9P/T9+qdcq5QnwgOvyxj
 gjxw==
X-Gm-Message-State: AOJu0YzXf7l/FCn4lgn9WBb4k2RjFLzJAJSulj+iimyxiPoVvxyE1uIe
 0cn1ZWR0maIPRyjYs624/rPifAkzeojdUzg0vTdWLh6eY8Dd4bxdYgfMHknp7SvhGiXLfnqLabO
 WoOD3s4hQAJKlrN60lfksHGDO3B1ILZY=
X-Received: by 2002:a05:600c:3511:b0:404:72fe:ed5c with SMTP id
 h17-20020a05600c351100b0040472feed5cmr3816606wmq.29.1697616927791; 
 Wed, 18 Oct 2023 01:15:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTvktXUAVUAR+EJ5iKeVhXbQN5Th5dpImYeqwD39pbXnkVn39lWjRAHbpgBwq9lNxCig7H0g==
X-Received: by 2002:a05:600c:3511:b0:404:72fe:ed5c with SMTP id
 h17-20020a05600c351100b0040472feed5cmr3816583wmq.29.1697616927367; 
 Wed, 18 Oct 2023 01:15:27 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 b12-20020a05600c150c00b0040586360a36sm988277wmg.17.2023.10.18.01.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 01:15:26 -0700 (PDT)
Message-ID: <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
Date: Wed, 18 Oct 2023 10:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
Content-Language: en-US, de-DE
To: Simon Glass <sjg@google.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3fdWAUbZb7kbWfEZvFvuh79LmWpmbOdRhEk=qw2PTbcg@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ3fdWAUbZb7kbWfEZvFvuh79LmWpmbOdRhEk=qw2PTbcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/18/23 05:33, Simon Glass wrote:
> Hi Heinrich,
> 
> On Tue, 17 Oct 2023 at 07:50, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Forward and backward compatibility of Linux kernel device-trees is
>> sometimes missing. One solution approach is to load a kernel specific
>> device-tree. This can either be done via a U-Boot scripts (like the one
>> generated by Debian package flash-kernel or by a boot loader like GRUB.
>> The boot loader approach currently requires to know the device-tree name
>> before first boot which makes it unusable for generic images.
>>
>> Expose the device-tree file name as EFI variable FdtFile.
>> This will allow bootloaders to load a kernel specific device-tree.
>>
>> The variable will not be exposed on ACPI based systems or if the
>> environment variable fdtfile is not defined.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          Use a unique GUID to enable future U-Boot independent
>>          standardization.
>>          Do not try to add the variable on ACPI based systems.
>> ---
>>   include/efi_loader.h       |  5 +++++
>>   lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>>   2 files changed, 35 insertions(+)
> 
> I was too slow to reply to v1.
> 
> Does grub load the DT? I was assuming that U-Boot would pass it on?
> What is the interface between U-Boot and grub?

The device-tree built into U-Boot is often out of date and not usable to 
boot current Linux. A single device-tree can be loaded by U-Boot from 
file and passed on as EFI configuration table. This device-tree may not 
be compatible with all kernel versions exposed by GRUB.

GRUB provides a devicetree command. It is disabled if you use secure 
boot. At least in Debian and Ubuntu GRUB invokes the 
EFI_DT_FIXUP_PROTOCOL exposed by U-Boot to run U-Boot's device-tree 
fix-ups after loading a device-tree.

Vendor scripts for GRUB like Ubuntu's /etc/grub.d/10_linux add 
devicetree commands to the boot options in grub.cfg.

Best regards

Heinrich
