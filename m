Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654E9C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 22:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F1DB87842;
	Mon, 29 Jan 2024 23:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SVgCuJCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EAAA87C68; Mon, 29 Jan 2024 23:16:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BAF387796
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 23:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mzamazal@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706566579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9P7lnDrKbDCLTCgO/pF5i8sMMnXkOX1V9c4xR+UKKE=;
 b=SVgCuJCbybqslCH8R941O1/TMDlhiNpCfwyNZcsuUoPCWl15hHlMOhNTew1VLyhWPMmswi
 dF1pn+QwHOvsB/O6kk1UjY7ZqBOTUasaSPJLG0Ik7UZII9uVOkpkQH4iMqdZaCSMKLsaT6
 B89X/ZP0RJCwWxZ6q/0OPbe03rhBSHQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-GLn2bZMzNEWZIgO2ejaw8Q-1; Mon, 29 Jan 2024 17:16:17 -0500
X-MC-Unique: GLn2bZMzNEWZIgO2ejaw8Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a357c92f241so96057266b.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 14:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706566574; x=1707171374;
 h=content-transfer-encoding:mime-version:user-agent:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+s2ChLdnCUbsO3v1kTScfR1JUkjOCZXNH79vJtZI5Zo=;
 b=U8oDTb0OlKjJWnWWikWqz/G+si7AJE52WUW2HReCP5i8E/1pvHyLLlnTlyBTt0dppA
 ftUVlzwp6mtzQbbJ9rqOgFS2wXZ8OjnXNb1jW92t5r5omYr76vdB2IGZ4dHJ6l3NRW9l
 FVi4pYhPhAuVuxbLqNKSExYr3cF1UKk44SsutgO5k9d06aDMpgm3dNxJPDVp5sX1Np3U
 TRKaYyxnhpKITzFXp0mk9UsTIYKVzDvY/ow+sMhmxVpVX7ava1mDpZKuLLq7w8mli++h
 KgMI4rkDkljj6ABOzOSUv+sipBbqqTdDvWm972LbupcvRC0/ivUYEVx3Xly7rLX5hdq5
 N4Rg==
X-Gm-Message-State: AOJu0YxyoamSMYddWiSCrrEAV1+Yx8NuJTej7UOxzQtB6uA5duqKQO8e
 oRpMIj2l7CLVMvjp10GSPeXkpVaK76ze4xQRJvGsovjdGYOORdLyQPpoLSyLetE0SJyUqxg5MM/
 wtjYEWNZXk6YGWftt4UcfgkEQEVZKxLZ0ItP8WG3QLUkBWQPfcd42O5gwiqSmSQ3feMD9BYhpm8
 EOIPjPsCIKG01iRROwyS8Dq43YaNQeduTr2pY=
X-Received: by 2002:a17:906:1453:b0:a2d:5d73:8fb5 with SMTP id
 q19-20020a170906145300b00a2d5d738fb5mr5952697ejc.59.1706566574339; 
 Mon, 29 Jan 2024 14:16:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf9b3kezvJDzQKZEsMUu7rP5FcSq67Dq97I792m3DmqdD+BbKX1KgKFI3oVlpmGPpXpak0Gw==
X-Received: by 2002:a17:906:1453:b0:a2d:5d73:8fb5 with SMTP id
 q19-20020a170906145300b00a2d5d738fb5mr5952686ejc.59.1706566573898; 
 Mon, 29 Jan 2024 14:16:13 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUuCJYbazIRe/gdfUyO2gF4YjuhndEwf3eDexmTj63KXkOkMpdOKiqejx40x2uhi4+ED4/rMASPP3ZXPwuOM6b4uoQj4H9uOibXOqjlD2od9eEGfeeA3Pc=
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 dq5-20020a170907734500b00a26f1f36708sm4366024ejc.78.2024.01.29.14.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 14:16:13 -0800 (PST)
From: Milan Zamazal <mzamazal@redhat.com>
To: Gilles Talis <gilles.talis@gmail.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, uboot-imx@nxp.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] imx: imx8mp: Add support for Polyhex Debix Model A SBC
In-Reply-To: <87bkavbo6c.fsf@redhat.com> (Milan Zamazal's message of "Tue, 12
 Dec 2023 13:28:11 +0100")
References: <20230523192155.33222-1-gilles.talis@gmail.com>
 <58a07085-3926-b942-fb8c-58f1f5eac421@oss.nxp.com>
 <877clq6odx.fsf@redhat.com>
 <CAKcgs2x1FdvW0afXN=GGRc5nb8rhZtm70xzkURFeworcmTHPpg@mail.gmail.com>
 <87bkavbo6c.fsf@redhat.com>
Date: Mon, 29 Jan 2024 23:16:12 +0100
Message-ID: <877cjrss43.fsf@redhat.com>
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

Milan Zamazal <mzamazal@redhat.com> writes:

> Gilles Talis <gilles.talis@gmail.com> writes:
>
>> Hi Milan,
>>
>> Le jeu. 7 d=C3=A9c. 2023 =C3=A0 11:09, Milan Zamazal <mzamazal@redhat.co=
m> a =C3=A9crit :
>>
>>> Peng Fan <peng.fan@oss.nxp.com> writes:
>>>
>>> > On 5/24/2023 3:21 AM, Gilles Talis wrote:
>>> >> Add support for the Polyhex Debix Model A SBC board.
>>> >> It is an industrial grade single board computer based on
>>> >> NXP's i.MX 8M Plus.
>>> >> Currently supported interfaces are:
>>> >> - Serial console
>>> >> - Micro SD
>>> >> - eQOS and FEC Ethernet
>>> >> imx8mp-debix-model-a.dts is taken from Linux 6.3.
>>> >> Signed-off-by: Gilles Talis<gilles.talis@gmail.com>
>>> >
>>> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
>>>
>>> Do you know why the patch has been left (as far as I can see) without
>>> further action?
>>>
>> I don't know. I assume the maintainer is very busy or has missed it. I w=
as
>> planning to do a resend in the next few weeks.
>>
>>
>>>
>>> BTW, I applied it to current master, compiled approximately following
>>> https://docs.u-boot.org/en/latest/board/nxp/imx8mp_evk.html and tried t=
o
>>> use it on Debix Model A.  U-Boot starts but cannot find the partition
>>> table on the SD card:
>>>
>>>   U-Boot SPL 2024.01-rc3-07226-g43f2873fa9-dirty (Jan 01 1980 - 00:00:0=
0
>>> +0000)
>>>   Normal Boot
>>>   WDT: Started watchdog@30280000 with servicing every 1000ms (60s
>>> timeout)
>>>   Trying to boot from BOOTROM
>>>   Boot Stage: Primary boot
>>>   image offset 0x8000, pagesize 0x200, ivt offset 0x0
>>>   NOTICE: BL31: v2.2(release):rel_imx_5.4.70_2.3.6-0-g15e8ff164-dirty
>>>   NOTICE:  BL31: Built : 00:00:00, Jan  1 1980
>>>
>>>
>>>   U-Boot 2024.01-rc3-07226-g43f2873fa9-dirty (Jan 01 1980 - 00:00:00 +0=
000)
>>>
>>>   CPU:   Freescale i.MX8MP[8] rev1.1 at 1200 MHz
>>>   Reset cause: POR
>>>   Model: Polyhex Debix Model A i.MX8MPlus board
>>>   DRAM:  2 GiB
>>>   Core: 83 devices, 22 uclasses, devicetree: separate
>>>   WDT: Started watchdog@30280000 with servicing every 1000ms (60s
>>> timeout)
>>>   MMC:   FSL_SDHC: 1, FSL_SDHC: 2
>>>   Loading Environment from MMC... *** Warning - bad CRC, using default
>>> environment
>>>
>>>   In:    serial@30890000
>>>   Out:   serial@30890000
>>>   Err:   serial@30890000
>>>   Net:   eth1: ethernet@30bf0000 [PRIME]
>>>   Hit any key to stop autoboot: 2 <0x08><0x08><0x08> 1 <0x08><0x08><0x0=
8>
>>> 0
>>>   switch to partitions #0, OK
>>>   mmc1 is current device
>>>   Scanning mmc 1:1...
>>>   ,** No partition table - mmc 1 **
>>>   Couldn't find partition mmc 1:1
>>>   ,** No partition table - mmc 1 **
>>>   Couldn't find partition mmc 1:1
>>>   ,** No partition table - mmc 1 **
>>>   Couldn't find partition mmc 1:1
>>>   ,** No partition table - mmc 1 **
>>>   Couldn't find partition mmc 1:1
>>>   ,** No partition table - mmc 1 **
>>>   Couldn't find partition mmc 1:1
>>>   ,** No partition table - mmc 1 **
>>>   Couldn't find partition mmc 1:1
>>>   ,** No partition table - mmc 1 **
>>>   Couldn't find partition mmc 1:1
>>>   <0x1b>7<0x1b>[r<0x1b>[999;999H<0x1b>[6n<0x1b>8Card did not respond to
>>> voltage select! : -110
>>>   No EFI system partition
>>>   No EFI system partition
>>>   Failed to persist EFI variables
>>>   Remove /soc@0/bus@30800000/ethernet@30be0000:phy-reset-gpios
>>>   BootOrder not defined
>>>   EFI boot manager: Cannot load any image
>>>   ,** No partition table - mmc 1 **
>>>   Couldn't find partition mmc 1:1
>>>   Card did not respond to voltage select! : -110
>>>   u-boot=3D>
>>>
>>> When I use an old U-Boot blob provided by Debix, it boots fine from the
>>> same SD card.  The SD card contains a Fedora aarch64 image with a msdos
>>> partition table.
>>>
>>> Do you know what could be wrong?
>>>
>> Interesting. I don't have a clue yet,. but let me give it a try and come
>> back to you. Where can I download the Fedora aarch64 image you mentioned
>> above?
>
> I flashed the image freshly, to another SD card, and it boots happily.
> So I can confirm your patch works. :-)
>
> I don't know what's wrong with the partition table on the original SD
> card. =20

Well, after trying both the SD cards again with fresh reinstallations, it w=
orks
with a 32 GB card and I get the error above with a 64 GB card.  Is it possi=
ble
that there is something wrong with SDXC cards?

Regards,
Milan

> I manipulated with the partitions and their properties a bit before but p=
arted
> or the other versions of U-Boot I tried don't report any problem.  Maybe =
the
> U-Boot version from master that I happened to compile does something
> differently.  Anyway, it's unlikely to be related to this patch as it boo=
ts
> fine on a freshly flashed SD card.
>
> Thank you for the patch, hopefully it'll get merged.
>
> Regards,
> Milan

