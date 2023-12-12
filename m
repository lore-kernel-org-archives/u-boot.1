Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318A2C4167B
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 12:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 028E1877BF;
	Tue, 12 Dec 2023 13:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dxSO2PVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3892877E0; Tue, 12 Dec 2023 13:28:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E94287732
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 13:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mzamazal@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702384097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbElN8UoiOkrUot9bqUPc5hhh/VIi3f9LBVbETNjoZ8=;
 b=dxSO2PVk0Nzd9FGZdskA7TbEfqjQBYk6WNU7ROCBQyfhHspk8W67El5R6d/SYtPlvA577B
 AmVhfXptPf4pcX39vBavJ5so1ApkDe/DDsoCjo8AreglO0uBMuMTPnbxCITw1sxmb/THvj
 lwC0DCw1Ikws5IZqBVnU9+EIuB19vGU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-AxzPYFGROyO2eA7vokRajQ-1; Tue, 12 Dec 2023 07:28:16 -0500
X-MC-Unique: AxzPYFGROyO2eA7vokRajQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ca0cf837d5so43516211fa.3
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 04:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384093; x=1702988893;
 h=content-transfer-encoding:mime-version:user-agent:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OVWilocc9B5EY2bjLc36sr8LhdkRVa9vE9Fbopq3yU0=;
 b=qF/VvGngkNVcGNxwY+HiwlUwwh+V8sdroXvOSXMWbAgH3bhQVUzJMT579pBlzY+nz+
 C2j8vrJwUzElSMYpk4wMJS2UAX/KTKCUD4r+8sJKr3pkNrUQO/tdQk1kiQZlyKldiWC4
 osSosENCZYo9+Ifwu49l860fLssk9ffzJa6H2F6X8wGQ++VIdAC15CdfW2s9TLvFY/HF
 qsKHLnpnIwqT8BwjV4XaoZu0j+I2JXbB+G2uBvFvZrqp37GHfAQGaBQRR01XRnK+WBHw
 qiYblUghflBqQ9NCr32/AnqNwp3iRhGVvfnZ8Kclxt4kG5r5aJ9cMOqwg8WZRR8Q8eC6
 1plA==
X-Gm-Message-State: AOJu0YxxIBpqaOBi3AmKQns1Jr7YKjH6P0lM4nujstoQkxmk9y99Gtg+
 XxbGWipCidQzPtz3HD8s++wzPHllJ8HAqDrv84K2438RR18aj0al/iJhu4TaD2w0A0a8EY6hFy/
 7FeEOp2KHCBXC2HqzvdT8Sx1wk+w8hvIEHUvulDtOurIv2iT5Kb5yaWj8dm51cc5mr5oKLSEKZw
 ==
X-Received: by 2002:a2e:a783:0:b0:2cb:2b39:8646 with SMTP id
 c3-20020a2ea783000000b002cb2b398646mr2758658ljf.16.1702384093668; 
 Tue, 12 Dec 2023 04:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX4TQ698gDTFRFGU3JpCtqol1Nz+NA4PlCsTWpee/+BngI7aTSpHtfOUPOpv+llBpmiKaKQQ==
X-Received: by 2002:a2e:a783:0:b0:2cb:2b39:8646 with SMTP id
 c3-20020a2ea783000000b002cb2b398646mr2758643ljf.16.1702384093187; 
 Tue, 12 Dec 2023 04:28:13 -0800 (PST)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a056402090600b0054c9211021csm4564427edz.69.2023.12.12.04.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 04:28:12 -0800 (PST)
From: Milan Zamazal <mzamazal@redhat.com>
To: Gilles Talis <gilles.talis@gmail.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, uboot-imx@nxp.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] imx: imx8mp: Add support for Polyhex Debix Model A SBC
In-Reply-To: <CAKcgs2x1FdvW0afXN=GGRc5nb8rhZtm70xzkURFeworcmTHPpg@mail.gmail.com>
 (Gilles Talis's message of "Mon, 11 Dec 2023 20:35:22 -0400")
References: <20230523192155.33222-1-gilles.talis@gmail.com>
 <58a07085-3926-b942-fb8c-58f1f5eac421@oss.nxp.com>
 <877clq6odx.fsf@redhat.com>
 <CAKcgs2x1FdvW0afXN=GGRc5nb8rhZtm70xzkURFeworcmTHPpg@mail.gmail.com>
Date: Tue, 12 Dec 2023 13:28:11 +0100
Message-ID: <87bkavbo6c.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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

Gilles Talis <gilles.talis@gmail.com> writes:

> Hi Milan,
>
> Le jeu. 7 d=C3=A9c. 2023 =C3=A0 11:09, Milan Zamazal <mzamazal@redhat.com=
> a =C3=A9crit :
>
>> Peng Fan <peng.fan@oss.nxp.com> writes:
>>
>> > On 5/24/2023 3:21 AM, Gilles Talis wrote:
>> >> Add support for the Polyhex Debix Model A SBC board.
>> >> It is an industrial grade single board computer based on
>> >> NXP's i.MX 8M Plus.
>> >> Currently supported interfaces are:
>> >> - Serial console
>> >> - Micro SD
>> >> - eQOS and FEC Ethernet
>> >> imx8mp-debix-model-a.dts is taken from Linux 6.3.
>> >> Signed-off-by: Gilles Talis<gilles.talis@gmail.com>
>> >
>> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
>>
>> Do you know why the patch has been left (as far as I can see) without
>> further action?
>>
> I don't know. I assume the maintainer is very busy or has missed it. I wa=
s
> planning to do a resend in the next few weeks.
>
>
>>
>> BTW, I applied it to current master, compiled approximately following
>> https://docs.u-boot.org/en/latest/board/nxp/imx8mp_evk.html and tried to
>> use it on Debix Model A.  U-Boot starts but cannot find the partition
>> table on the SD card:
>>
>>   U-Boot SPL 2024.01-rc3-07226-g43f2873fa9-dirty (Jan 01 1980 - 00:00:00
>> +0000)
>>   Normal Boot
>>   WDT: Started watchdog@30280000 with servicing every 1000ms (60s
>> timeout)
>>   Trying to boot from BOOTROM
>>   Boot Stage: Primary boot
>>   image offset 0x8000, pagesize 0x200, ivt offset 0x0
>>   NOTICE: BL31: v2.2(release):rel_imx_5.4.70_2.3.6-0-g15e8ff164-dirty
>>   NOTICE:  BL31: Built : 00:00:00, Jan  1 1980
>>
>>
>>   U-Boot 2024.01-rc3-07226-g43f2873fa9-dirty (Jan 01 1980 - 00:00:00 +00=
00)
>>
>>   CPU:   Freescale i.MX8MP[8] rev1.1 at 1200 MHz
>>   Reset cause: POR
>>   Model: Polyhex Debix Model A i.MX8MPlus board
>>   DRAM:  2 GiB
>>   Core: 83 devices, 22 uclasses, devicetree: separate
>>   WDT: Started watchdog@30280000 with servicing every 1000ms (60s
>> timeout)
>>   MMC:   FSL_SDHC: 1, FSL_SDHC: 2
>>   Loading Environment from MMC... *** Warning - bad CRC, using default
>> environment
>>
>>   In:    serial@30890000
>>   Out:   serial@30890000
>>   Err:   serial@30890000
>>   Net:   eth1: ethernet@30bf0000 [PRIME]
>>   Hit any key to stop autoboot: 2 <0x08><0x08><0x08> 1 <0x08><0x08><0x08=
>
>> 0
>>   switch to partitions #0, OK
>>   mmc1 is current device
>>   Scanning mmc 1:1...
>>   ,** No partition table - mmc 1 **
>>   Couldn't find partition mmc 1:1
>>   ,** No partition table - mmc 1 **
>>   Couldn't find partition mmc 1:1
>>   ,** No partition table - mmc 1 **
>>   Couldn't find partition mmc 1:1
>>   ,** No partition table - mmc 1 **
>>   Couldn't find partition mmc 1:1
>>   ,** No partition table - mmc 1 **
>>   Couldn't find partition mmc 1:1
>>   ,** No partition table - mmc 1 **
>>   Couldn't find partition mmc 1:1
>>   ,** No partition table - mmc 1 **
>>   Couldn't find partition mmc 1:1
>>   <0x1b>7<0x1b>[r<0x1b>[999;999H<0x1b>[6n<0x1b>8Card did not respond to
>> voltage select! : -110
>>   No EFI system partition
>>   No EFI system partition
>>   Failed to persist EFI variables
>>   Remove /soc@0/bus@30800000/ethernet@30be0000:phy-reset-gpios
>>   BootOrder not defined
>>   EFI boot manager: Cannot load any image
>>   ,** No partition table - mmc 1 **
>>   Couldn't find partition mmc 1:1
>>   Card did not respond to voltage select! : -110
>>   u-boot=3D>
>>
>> When I use an old U-Boot blob provided by Debix, it boots fine from the
>> same SD card.  The SD card contains a Fedora aarch64 image with a msdos
>> partition table.
>>
>> Do you know what could be wrong?
>>
> Interesting. I don't have a clue yet,. but let me give it a try and come
> back to you. Where can I download the Fedora aarch64 image you mentioned
> above?

I flashed the image freshly, to another SD card, and it boots happily.
So I can confirm your patch works. :-)

I don't know what's wrong with the partition table on the original SD
card.  I manipulated with the partitions and their properties a bit
before but parted or the other versions of U-Boot I tried don't report
any problem.  Maybe the U-Boot version from master that I happened to
compile does something differently.  Anyway, it's unlikely to be related
to this patch as it boots fine on a freshly flashed SD card.

Thank you for the patch, hopefully it'll get merged.

Regards,
Milan

