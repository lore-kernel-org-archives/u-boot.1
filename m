Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06A6E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 09:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D71F0801DB;
	Thu, 12 Dec 2024 10:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rd6ULWzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F15B1801EA; Thu, 12 Dec 2024 10:19:10 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41DBB801DA
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 10:19:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leon.anavi@konsulko.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d3bbb0f09dso587369a12.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 01:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733995147; x=1734599947; darn=lists.denx.de;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1q2tMss4ppFH9/J2ZpE8f/7fqFSHGwO1hBoguhnOZ0=;
 b=Rd6ULWzd3aoMNZ09GcXn2Oiltplpxh8lN8XEfFiEjnPHiazSfIYOdubl7T9B89Jgmy
 5vhquVeWpkMIOEEGrrpl8c48Z/lSjGbl0vlSzOhZxt2+yg3hjsbcOs3auOj9ju3itzHP
 IQ/r1FydVCS8kxRq+S0CPaoOhzMhMx4ubdLbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733995147; x=1734599947;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a1q2tMss4ppFH9/J2ZpE8f/7fqFSHGwO1hBoguhnOZ0=;
 b=fdyHtGmgJOgVQi5KlvK6Ke56ur8pvZdL4ueRfuhMQ1hPWCQs0dWr6wX7lhdKXzQBGw
 JiISXaXQV4OJBdLrxs5yYv4FJdWUrsexjreGrj3lIoqpEBth/R4eBNKztbqlOaCzakgd
 w2vl73efn47GJI+is7NLrPpmTkNMNqqxKSUOwU8m9FzNHnlRJgogHP5e07PKI5oGRJha
 KzaFf/r2/14gp4xhN2RyuYEt9v2V9pH3OlqAlVbm8EE7ROErmextbvXSt1JfMPn11N8P
 2bYUhsXtQB2Q2ZXUJfOhGZ/51WiZI0iWcUMrinCjFP60Bxwpvv18S4rQONZ3ZsJNbtI9
 Id5w==
X-Gm-Message-State: AOJu0YxsPf5L+etqRChNGYRbgqSTIzxjjUWG01SlMlD+tCmtzmSVKlea
 AtMMV6EPc97lWUWmC55UfLIHsZprrbiLz9GVvXK1q5v3Kr03wiRx2Nh8OgYfaRs=
X-Gm-Gg: ASbGncsjRzYTrir9r1u85I3Bex3L0TTZ2HVUiEf7u0hdurcJvtkZK2aaT+0DgS17jFZ
 EhqDe0TgPXuY+/Wtu/4NO3z4AnbSe0tfLfKRmDT4GHS70hPVxelM8JwuNyBrdqH6uvbiMnCK8J9
 lt3QHvLQZGd5wF+zjwLPN0qHzb0JKBaTLV3S0k6B6GaOAZ975WjB244YS0oHZFSkjaWd8aoY12/
 LkGt1cs3nA7392NncS2EQPZIIl9rwALqYZeRCeIwhTmCrrdzY579aRKE+jOR+cT
X-Google-Smtp-Source: AGHT+IEwPychjAUnjQ56CuMOzWWHIxBYpc6Tq0lK1j2ng44jP+NSEsITjXF7fbRb1yx4RyFiyZFpCw==
X-Received: by 2002:a05:6402:5007:b0:5d0:e2c8:dc8d with SMTP id
 4fb4d7f45d1cf-5d4edce2bffmr416582a12.20.1733995147227; 
 Thu, 12 Dec 2024 01:19:07 -0800 (PST)
Received: from [192.168.5.161] ([46.55.231.62])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3e7936581sm7084972a12.56.2024.12.12.01.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 01:19:06 -0800 (PST)
Message-ID: <e77f6b37-7d50-4f3d-9bed-6d3e39effb4c@konsulko.com>
Date: Thu, 12 Dec 2024 11:19:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sunxi: board: simplify early PMIC setup conditions
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, lhristov@gmail.com
References: <CALtQ3O2jF6sEvofpZ+FtJgmgTKZvNRuohnwEtPz4ES0WqtxU5g@mail.gmail.com>
 <20241211215327.26dc369a@minigeek.lan>
Content-Language: en-US
From: Leon Anavi <leon.anavi@konsulko.com>
In-Reply-To: <20241211215327.26dc369a@minigeek.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Andre,

On 11.12.24 г. 23:53 ч., Andre Przywara wrote:
> On Mon, 9 Dec 2024 23:08:19 +0200
> Leon Anavi<leon.anavi@konsulko.com> wrote:
>
> Hi Leon,
>
> thanks for the report!
>
>> Commit ffb0294 from 12 November 2023 that simplifies early PMIC setup
>> conditions causes issues on Cubieboard 4 and Merrii A80 Optimus with
>> Allwinner A80 SoC (sun9i). The commit was introduced with U-Boot 2024.01
>> (rc3) and remains as of today. Because of it both of these boards hang at:
>>
>> Starting kernel ...
> That's odd, how do you boot the kernel, exactly?
> I just tried mainline U-Boot (via FEL), with:
> => setenv bootargs "console=ttyS0,115200n8 earlycon"
> => bootz $kernel_addr_r $ramdisk_addr_r:300000 $fdtcontroladdr
>
> and it booted fine to the prompt, on a Cubieboard 4 (CC-A80 v1.2).
> Kernel was some 6.11-rc6 I just had lying around.
>
> I also compared the code before and after that patch, the only
> difference is the order at which DCDC5 gets programmed: before it's
> after DCDC4, with the patch it's right after DCDC1.
> The rest looked the same.
> Booting ffb0294~1 and ffb0294~0 also worked for me, without issues.
> So can you please describe how you test that, exactly?
I built core-image-base using the Yocto Project and OpenEmbedded as well 
as the meta-sunxi BSP layer. The U-Boot version depends on the Yocto 
release. For Scarthgap it is with U-Boot 2024.01 and for the ongoing 
development in the master branches the U-Boot version is 2024.10. The 
Linux kernel version is 6.6.28. I experienced the same issue with both 
U-Boot versions on Merrii A80 Optimus and Lazar (his email is CC) 
confirmed the same results on Cubieboard 4. The boot sequence for the 
boards in meta-sunxi is through boot.scr generated from the following 
boot.cmd:
https://github.com/linux-sunxi/meta-sunxi/blob/master/recipes-bsp/u-boot/files/arm/boot.cmd

In a nutshell, the issue can be reproduced with the following scenario 
in U-Boot:

setenv bootargs console=ttyS0,115200 console=tty1 root=/dev/mmcblk0p2 
rootwait panic=10
load mmc 0:1 ${fdt_addr_r} ${fdtfile}
load mmc 0:1 ${kernel_addr_r} zImage
bootz ${kernel_addr_r} - ${fdt_addr_r}

Merrii A80 Optimus board boots fine if I revert commit ffb0294. However, 
if commit ffb0294 is present in U-Boot the board hangs. Here is the log: 
U-Boot 2024.10-dirty (Oct 07 2024 - 14:54:35 +0000) Allwinner Technology 
CPU: Allwinner A80 (SUN9I) Model: Merrii A80 Optimus Board DRAM: 2 GiB 
Core: 62 devices, 18 uclasses, devicetree: separate WDT: Not starting 
watchdog@6000ca0 WDT: Not starting watchdog@8001000 MMC: 
sunxi_set_reset: (RST#0) unhandled sunxi_set_reset: (RST#2) unhandled 
sunxi_set_reset: (RST#1) unhandled mmc@1c0f000: 0, mmc@1c10000: 2, 
mmc@1c11000: 1 Loading Environment from FAT... Unable to read 
"uboot.env" from mmc0:1... In: serial@7000000 Out: serial@7000000 Err: 
serial@7000000 Net: No ethernet found. Hit any key to stop autoboot: 0 
=> setenv bootargs console=ttyS0,115200 console=tty1 root=/dev/mmcblk0p2 
rootwait panic=10 => load mmc 0:1 ${fdt_addr_r} ${fdtfile} 24443 bytes 
read in 3 ms (7.8 MiB/s) => load mmc 0:1 ${kernel_addr_r} zImage 5397992 
bytes read in 236 ms (21.8 MiB/s) => bootz ${kernel_addr_r} - 
${fdt_addr_r} Kernel image @ 0x22000000 [ 0x000000 - 0x525de8 ] ## 
Flattened Device Tree blob at 23000000 Booting using the fdt blob at 
0x23000000 Working FDT set to 23000000 Loading Device Tree to 29ff7000, 
end 29ffff7a ... OK Working FDT set to 29ff7000 Starting kernel ... 
Please note that U-Boot is marked with suffix "-dirty" because of the 
patches applied by u-boot_%.bbappend from Yocto/OE layer meta-sunxi but 
these patches are for other boards and don't touch the file 
board/sunxi/board.c. Am I missing something as a configuration that can 
make the board boot the same way without hanging when commit ffb0294 is 
present?Best regards,
Leon

>
> Please also note we fixed d75fa8c80dcfa in U-Boot (DCDC4/5 typo), and
> dd36ad71ad6 in the kernel (DCDC5 constraints in the DT).
>
> Cheers,
> Andre
>
>> Older U-Boot versions without this commit work fine. As a temporary
>> solution I reverted commit ffb0294 and this way the boards boot
>> successfully. I tested this work around on Merrii A80 Optimus with several
>> U-Boot versions, including with U-Boot 2024.10.
>
>> Lazar, a friend who owns Cubieboard 4, also tested and confirmed his board
>> boots with U-Boot 2024.10 if this commit has been reverted.
>>
>> How to fix this? Is there a known configuration that can be added to
>> Merrii_A80_Optimus_defconfig and Cubieboard4_defconfig to avoid hanging
>> with the existing source code from commit ffb0294 ?
>>
>> Best regards,
>> Leon
