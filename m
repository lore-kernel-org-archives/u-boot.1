Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E551BC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 12:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 849C687E51;
	Thu,  8 Feb 2024 13:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=northern.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=northern.tech header.i=@northern.tech header.b="Hx7a3Mw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C9CD87D16; Thu,  8 Feb 2024 09:37:13 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA72F87D15
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 09:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=northern.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ole.orhagen@northern.tech
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51168addef1so2037608e87.1
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 00:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=northern.tech; s=google; t=1707381429; x=1707986229; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DO2iVrgXjPJzuf5Xk1jljAAZRvYX0tDAieLrgo6tJS4=;
 b=Hx7a3Mw1VCZJ1lfcIIGrz3QTsbNE70WhHgYlWys6ytANJIv+jPkxptvqm/bu/JJdxF
 kNUQqS+kzZ3FhxeuXgEzL7YsnhLrBGeFdvr/GzuPZI7KRvQM9q1E74Uy4dYgQIaFHSCo
 T7mwYWlboRKd5PRQ8eKNfrwVOewfsIC0V6jKA70kmm1kVq/jEFlW8iypufUID8IN735P
 09dOr9KIu8JHXdAmHDcrIL9WEtQimNp0RrLOsUWF6gQ/pVDhwkGd0TE9mQUC9Ts3T+BU
 +ReeuKfBD+D2leW76ZnHzFZhGzMLuBrjiQsXsGQbdnCw4ow4T23MFwgfTjMtP8Pis573
 c7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707381429; x=1707986229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DO2iVrgXjPJzuf5Xk1jljAAZRvYX0tDAieLrgo6tJS4=;
 b=qK1iV7KvWEca60UouGTI+6pmXtJH0qPBtJvrJmqqobub8fi78Ox9jkN+hJBjyL7v0q
 JgOEufZnaVW2w7Y5s2pW0t3kdDGwwoV2+B3JLJnqVUVMF5uFbQ2v2a6EoCWQhjpO3MdM
 ZJcePDJzJOV8pZbVO2I1FVfQo2H5o9PaM/vAC4si7LZQp4IuTa2Ig/XpEnfTXYfty9sg
 J72beG5IfdqoH2z3lrhIOEINi1+8mdVEZQtoz951u3qiM++aLH7K/mg1OYByy1kDe0Hg
 RfI312WDlR2wu49GPIMB30Pz0lJ826pEgXzkPr0MdG1Tth021k+vgATJwxDHb5eIsTr+
 Icog==
X-Gm-Message-State: AOJu0YxwGnfNlVvfxJFngfXQmxFde/IOulVsWKFEKgZwaKeeugqI1SSs
 PpR0gA0UEbTmiQAqDZD84C6YbaJw/9HPkmLnaDAGkgeO3VHNjJ9Vv7oA7HkKZev+cQfpBNt+zIV
 teTHVggv+q5ygjmPuXt+l0up+y81iY3KePZ2TSuOETefbz/IXmHa1IVwwV80RGMfw/dFBXistKl
 /HPXn0VAjYjdMz7xo=
X-Google-Smtp-Source: AGHT+IHSHBvj8kTi/LCiZ12WBWuZtHP5bJXwHydz1SDtxApk+f9XBCJLi7ycfcFSmTZaY2onDQf+qo/vfhS/SOuUhtM=
X-Received: by 2002:a05:6512:3da1:b0:511:691e:100e with SMTP id
 k33-20020a0565123da100b00511691e100emr2306532lfv.18.1707381428924; Thu, 08
 Feb 2024 00:37:08 -0800 (PST)
MIME-Version: 1.0
References: <20240126124801.1164892-1-ole.orhagen@northern.tech>
 <CACRpkdYLizF9Duy3ZCfqRsY-NMoLZJO8+TCyBHbQDqSOWuzonQ@mail.gmail.com>
 <CAD5A3Cuba_EchhDWBfej5HGHsP-T6smgL-L+C6SV_bONf6EqYA@mail.gmail.com>
 <ed02c9b9-5505-4aad-bc92-a2678607ff54@northern.tech>
 <CACRpkdaiYgmzjsX8SPMFOFo=iK19s2y8Uuaysc+46Ba7D1PFBg@mail.gmail.com>
 <CAD5A3Csm_sx4TBHQaADSMFgSqoF=aBZD2jm4_cmzNaonZJqAoQ@mail.gmail.com>
 <CACRpkdbhM6-JoWN6CbLpx_z+vzyx4hBdxqzB=iQ0G9MPa4r5+w@mail.gmail.com>
In-Reply-To: <CACRpkdbhM6-JoWN6CbLpx_z+vzyx4hBdxqzB=iQ0G9MPa4r5+w@mail.gmail.com>
From: Ole Orhagen <ole.orhagen@northern.tech>
Date: Thu, 8 Feb 2024 09:36:57 +0100
Message-ID: <CAD5A3CuB9Mrd-d1Rt_7YWKOm=H9xAi=X3OGwyaOKHdZGAGg9dw@mail.gmail.com>
Subject: Re: [PATCH v1] vexpress_ca9x4: Enable DM_SERIAL
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kristian Amlie <kristian.amlie@northern.tech>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patryk Biel <pbiel7@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailman-Approved-At: Thu, 08 Feb 2024 13:10:31 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Feb 8, 2024 at 9:27=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org>
wrote:

> On Mon, Feb 5, 2024 at 9:18=E2=80=AFAM Ole Orhagen <ole.orhagen@northern.=
tech>
> wrote:
>
>>
>> But I will try to dust it off and test it again.
>>>
>>
>> Did you get any results from the tests?
>>
>
>
> Yes!
>
> It works fine both before and after the patch. Latest log from
> the actual hardware:
>
> Cmd> usb_on
> Enabling debug USB...
>
> (here I copy over the binary to the internal SD-card which is
> presented over USB mass storage)
>
> Cmd> reboot
>
> Powering up system...
> Daughterboard fitted to site 1.
>
> Switching on ATXPSU...
> ATX3V3: ON
> VIOset: 1.8V
> MBtemp: 29 degC
>
> Configuring motherboard (rev D, var A)...
> IOFPGA  config: PASSED
> MUXFPGA config: PASSED
> OSC CLK config: PASSED
> Programming image \SOFTWARE\boot-a9.bin
> Erasing Flash image boot.bin
> ...
> Erasing Flash
> ...
> Writing Flash
> .....
> Updating eeprom with image boot.bin
> Image: boot.bin UPDATED from \SOFTWARE\boot-a9.bin
>
> Testing SMC devices (FPGA build 8)...
> SRAM 32MB test: PASSED
> VRAM  8MB test: PASSED
> LAN9118   test: PASSED
> USB & OTG test: PASSED
> KMI1/KMI2 test: PASSED
> MMC & SD  test: PASSED
> DVI image test: PASSED
> AACI AC97 test: PASSED
> CF card   test: PASSED
> UART port test: PASSED
> MAC addrs test: PASSED
>
> Reading Site 1 Board File \SITE1\HBI0191B\board.txt
> DB1 JTAG configuration complete.
> Setting DB1 OSCCLKS...
> DB1.0 DCC 0 SPI configuration complete.
>
> Writing SCC 0x40610000 with 0xBB8A802A
> Writing SCC 0x40610001 with 0x00001F09
> Writing SCC 0x40610002 with 0x00000000
> DB1.0 DCC 0 SCC configuration complete.
>
> DB SMB clock enabled.
> Waiting for SITE1 CB_READY...
> Testing SMB clock...
> Configuring MUXFPGA for DB1.
> Setting DVI mode for XGA.
> Releasing Daughterboard resets.
> Switching MCC log to UART1.
>
> ARM Versatile Express Boot Monitor
> Version:    V5.2.1
> Build Date: Apr  4 2013
> Daughterboard Site 1: V2P-CA9 Cortex A9
> Daughterboard Site 2: Not Used
> Running boot script from flash - BOOTSCRIPT
>
>
> U-Boot 2024.04-rc1-00101-g0101a2ffe125 (Feb 08 2024 - 09:21:31 +0100)
>
> DRAM:  512 MiB (effective 1 GiB)
> WARNING: Caches not enabled
> Core:  22 devices, 11 uclasses, devicetree: embed
> Flash: 128 MiB
> MMC:   mmci@5000: 0
> Loading Environment from Flash... OK
> In:    uart@9000
> Out:   uart@9000
> Err:   uart@9000
> Net:   eth0: ethernet@3,02000000
> Hit any key to stop autoboot:  0
> smc911x: detected LAN9118 controller
> smc911x: phy initialized
> smc911x: MAC 00:02:f7:00:3c:9d
> Using ethernet@3,02000000 device
> TFTP from server 192.168.1.140; our IP address is 192.168.1.35
> Filename 'zImage'.
> Load address: 0x62000000
> Loading: smc911x: MAC 00:02:f7:00:3c:9d
>
> Yours,
> Linus Walleij
>


Great :)

Thanks for taking the time!

--=20
*Ole P. Orhagen*
Software Engineer | Mender <https://mender.io>
Oslo, Norway
<https://www.linkedin.com/company/northern.tech>
<https://twitter.com/northerntechhq> <https://northern.tech> Northern.tech
<https://northern.tech> | Securing the world's connected devices
