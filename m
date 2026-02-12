Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DD1EE368C
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 14:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEBB98388D;
	Thu, 12 Feb 2026 15:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Or3kX1k8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35BF683AAB; Thu, 12 Feb 2026 15:53:25 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D27FF83015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 15:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-94ac7f22d23so1332518241.3
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 06:53:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770908001; cv=none;
 d=google.com; s=arc-20240605;
 b=L7FpQQ0ShQiB50x3tY6i3Jg3wqpZcJ9YyNcC50XV2IEP8sVOLpayJzHREd7oQHk4Ml
 nC8Ap5cnkhCaYfPFMmAQDSduYB3q79PnPDjGe1kTvEgzAzX1d4IrylUgmX+N+LsoFWDr
 zUQ8j84hU+Bd8RbYrxgap4XB5lzwe+wv3ASraYEbyevRzeGulNHArI4V4EmO8pRzRlNh
 9irYEb49D6WqBQY2uQot6zoIxftHD0jA1pdAnaBMTjY+i/fWEkxpy5N5LawimPcq3UWd
 IHSp9uwzOKEHo9T+i5abwKmv+J5pDOnlcTksrYYR+afC7t7N94VJNeWuJuaFCS2fu/d2
 DO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DDY+/cXzNuQH1PhMlzRyY1RKWNtZOjWeJCuI4+2zjm4=;
 fh=TNJRmsUkv8hNBZ9KkMS0LNQBpPVrLuAPYuHClDTdLmo=;
 b=lTHZOPMWYoo2f3yG6NIxajKqJDwI9/p9z83q7vYmgkreYlbJh9yFKfjplKfkEcQtvS
 orr10zGqdghvToKirYPW34HPcfQ2pn0ujecwBj9/JXuGsl1H2BViEk3fTV1j+ijXnL+L
 Olxuwfl+cwsCMd2gYTeF6UZQHNKE8F0JebGZgajSQ72zxvEAUasEZPregV47u6eTe/r+
 Iblpfzo/ZRFpI0ZnazHUoMFTZx9qL1Rm9iuCJ7kGhL6Gv3ZrGzlqh8WQn1BHsA43WTN9
 IeVI8YAHA5A60GWI5h/IihVIagXsJC6mpLdGyaLmWoIGIFujFEe4JQNpHtRzBUnMcJgU
 xdtA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770908001; x=1771512801; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDY+/cXzNuQH1PhMlzRyY1RKWNtZOjWeJCuI4+2zjm4=;
 b=Or3kX1k81/Thvw+e5D1LlC+CFwd7oJl0p6ZJJjOajwfEcRTJMbuLig1E6dzCoEqOId
 lW6/6pJ2w6w3uJQye83e+rYsYxtl8asTIkmleCgDVbgLT1MMN6SvtQJkvY/akxvtEa9F
 ieWCwU09A+oprdlzd8ONUWYBpgSk0d/blQfWZntyAIAe7AnQ4Kch0py1c654xbP3/dhc
 HjJmTHHO9mDBwfp7bbKB23q6qcE0z3v6civnNUBT+HhbI/gigbTR7DwC48B0mFJW+N8o
 3u8oBieSXhan4JE4jMqtp/1pq5v5579OBo9XYVBapxmlAHif9VyqoMUS31UDxuGyMcq2
 M8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770908001; x=1771512801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DDY+/cXzNuQH1PhMlzRyY1RKWNtZOjWeJCuI4+2zjm4=;
 b=qDcwkQk9SOoC/TY4vbhrQb0gWebz0IPw2A27bIkC8mKAc+A2X23Xluo2lhDvM89kfU
 PTnSEZCxNo0Z5eBb/npRd4E6FnUDT6nbPceadZpOfDXLQELpooBTcK2xCe6qy/LWrU5U
 YaOR4sJEycuRPwXkrdCkagOpttNPC/UPSTdxjmcLWuqIv5GWl4Esr42THhyrsUA+DvjC
 CZFgQmrSjiQHdAKov3pXS8S0YcnlxTokG/ymOs6a7l0iQ/zJR4Q/XRTCbYFJgdsixR8D
 50TKuhyPDISpQHZJNqQW623cZFYaQmTIjRvruxVdIKh6V2roYZpbvpjn79nc4jbURIf+
 +5Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfc5cGA/2RszmgUbycSfx1F8mjE7UobXu5bLmSSXSUtc6MlpXqm8Ei5GPFe/lyiSYVFH5ZsvA=@lists.denx.de
X-Gm-Message-State: AOJu0YxmlSic6YMmwM0ZldQJTxj4CauLv7lASFh3y6BNRjhuWh1jD4Oi
 1kr1PQ4WNb0FTtF3uooDxwizIcwluDLnXFRBZ6MwJbf2gKhScjYeoiTdHjSJXSZTP866O6ViTj+
 anCbdmPYKFGD/3KUSoSIrcdRxzKvJkAw=
X-Gm-Gg: AZuq6aJqR8gdYXmURBJKgGlbMTvnhd79e9gONk2DYGCH8CN9C6DkS27/WTWM16IFizz
 JGIf4KoqRrfM5RWORr93aJC0Qoqnex+oPhXVXUc2DN2Yo08rU3pkbUcK9l8TiBG7nbhN8su3c4Q
 LyjU3suykh3pNFcRLbVU7uZmSg5cofh+rsFdVoV4yO18LEzERXYs32NqBRVFuqOUuvbQJDhalFL
 0MiDKjIZI7zfrvYFmSjlBSI1ogz/Ksycd/TaHNuqNdvHeGhgsJVor7gOYliV8cu8ogtQqBslw5i
 bNjIRbRB
X-Received: by 2002:a05:6102:3713:b0:5f5:421a:fc8f with SMTP id
 ada2fe7eead31-5fdfb9be600mr905370137.14.1770908001447; Thu, 12 Feb 2026
 06:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20251128163535.2301653-1-raymondmaoca@gmail.com>
 <CAMDkj5zb1qhAR-uf=trSsGEwXmx5TiXc=agX5w5GnjMrP_Nqyg@mail.gmail.com>
 <20260204161345.GY2603314@bill-the-cat>
 <CAC_iWj+qEmxNeGVBcLcrzNM=BkVj0QW2VYW6ZNGTKD6BeRTNHA@mail.gmail.com>
 <CAMDkj5yg24MwQz4G8Y62S7mB_6D=p+0Qrooe77RKQ+C4CPwA1Q@mail.gmail.com>
 <CAC_iWjKUqkjOFsk7+dj+7tn_hrbngoq4CyjCxg0xLbU=-X+GXA@mail.gmail.com>
 <CAMDkj5z0UuUi0qPfaykEVF=MmbEqXUup4GejaLAyJmg3PGByMg@mail.gmail.com>
 <CAC_iWjLqTObHeujWD_6Uix8i_6PZtPTJekVu6DShSwH2Kvobng@mail.gmail.com>
In-Reply-To: <CAC_iWjLqTObHeujWD_6Uix8i_6PZtPTJekVu6DShSwH2Kvobng@mail.gmail.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 12 Feb 2026 09:53:10 -0500
X-Gm-Features: AZwV_Qgi0f5WcQWcWQPp0cXq6LeEqVJXdaC1y9ngmkvsjdR0XWTB0JIZnpfGDd0
Message-ID: <CAMDkj5xGZoE52dYqWt9r93r9rsc6jB=3N8JkPOeS8nyNG796wA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement all missing SMBIOS types required by
 distro tooling
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Ilias,

On Thu, Feb 12, 2026 at 7:45=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> That's weird.
>
> I tried again on -next and got this
> Handle 0x0006, DMI type 9, 24 bytes
> System Slot Information
> Designation: Not Specified
> Type: Unknown
> Data Bus Width: Unknown
> Current Usage: Unknown
> Length: Unknown
> Characteristics: Unknown
> Bus Address: 0000:00:00.0
> Data Bus Width (Base): 0
> Peer Devices: 0
> Height: Not applicable
>
> Handle 0x0007, DMI type 16, 23 bytes
> Physical Memory Array
> Location: Unknown
> Use: Unknown
> Error Correction Type: Unknown
> Maximum Capacity: 0 kB
> Error Information Handle: Not Provided
> Number Of Devices: 1
>
> Handle 0x0008, DMI type 17, 104 bytes
> Memory Device
> Array Handle: 0x0000
> Error Information Handle: Not Provided
> Total Width: Unknown
> Data Width: Unknown
> Size: No Module Installed
> Form Factor: <OUT OF SPEC>
> Set: None
> Locator: <BAD INDEX>
> Bank Locator: <BAD INDEX>
> Type: Unknown
> Type Detail: Other Unknown Fast-paged Static Column Pseudo-static
> RAMBus Synchronous
>
> Handle 0x0009, DMI type 19, 31 bytes
> Memory Array Mapped Address
> Starting Address: 0x00000000000
> Ending Address: 0x000000003FF
> Range Size: 1 kB
> Physical Array Handle: 0x0000
> Partition Width: 1
>
> Handle 0x000A, DMI type 32, 11 bytes
> System Boot Information
> Status: No errors detected
>
> I am using a debian unstable with a 6.18 kernel
>

It looks that your log is not in a correct format, each header should
start with:
'Handle <handle_id>, DMI type <type_num>, <size> bytes at <address>'
But your one is missing 'at <address>'.

How did you test it and get it printed? Are you using 'smbios' cmd in
the u-boot console?
Do you mind sharing your remote working branch, so that I can have a
cross-check?

Regards,
Raymond


> Cheers
> /Ilias
>
> On Thu, 12 Feb 2026 at 02:24, Raymond Mao <raymondmaoca@gmail.com> wrote:
> >
> > Hi Ilias
> >
> > On Wed, Feb 11, 2026 at 10:20=E2=80=AFAM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Wed, 11 Feb 2026 at 16:30, Raymond Mao <raymondmaoca@gmail.com> wr=
ote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Wed, Feb 11, 2026 at 4:32=E2=80=AFAM Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > Apologies for the late reply.
> > > > >
> > > > > I did test the patches but I see something weird on smbios type 1=
7.
> > > > >
> > > > > Handle 0x0008, DMI type 17, 104 bytes
> > > > > Memory Device
> > > > >         Array Handle: 0x0000
> > > > >         Error Information Handle: Not Provided
> > > > >         Total Width: Unknown
> > > > >         Data Width: Unknown
> > > > >         Size: No Module Installed
> > > > >         Form Factor: <OUT OF SPEC>
> > > > >         Set: None
> > > > >         Locator: <BAD INDEX>
> > > > >         Bank Locator: <BAD INDEX>
> > > > >         Type: Unknown
> > > > >         Type Detail: Other Unknown Fast-paged Static Column
> > > > > Pseudo-static RAMBus Synchronous
> > > > >         Speed: 512 MT/s
> > > > >         Manufacturer: <BAD INDEX>
> > > > >         Serial Number: Not Specified
> > > > >         Asset Tag: Not Specified
> > > > >         Part Number: Not Specified
> > > > >         Rank: Unknown
> > > > >         Configured Memory Speed: Unknown
> > > > >         Minimum Voltage: Unknown
> > > > >         Maximum Voltage: Unknown
> > > > >         Configured Voltage: Unknown
> > > > >         Memory Technology: <OUT OF SPEC>
> > > > >         Memory Operating Mode Capability: None
> > > > >         Firmware Version: Not Specified
> > > > >         Module Manufacturer ID: Bank 3, Hex 0x04
> > > > >         Module Product ID: Unknown
> > > > >         Memory Subsystem Controller Manufacturer ID: Unknown
> > > > >         Memory Subsystem Controller Product ID: Unknown
> > > > >         Non-Volatile Size: 16383 PB
> > > > >         Volatile Size: Unknown
> > > > >         Cache Size: Unknown
> > > > >         Logical Size: Unknown
> > > > >
> > > > > Any idea what <BAD INDEX> and <OUT OF SPEC> represent?
> > > > > I tested this in QEMU
> > > > >
> > > >
> > > > I just retested it by below qemu cmd after I rebased it to the curr=
ent master:
> > > > qemu-system-aarch64  -bios u-boot.bin -machine virt -cpu cortex-a57=
 -m
> > > > 2G  -nographic
> > > >
> > > > Below is the type17 I got:
> > > > ```
> > > > Handle 0x0008, DMI type 17, 104 bytes at 0xbe678141
> > > > Memory Device:
> > > > Physical Memory Array Handle: 0x0000
> > > > Memory Error Information Handle: 0xfffe
> > > > Total Width: 0x0000
> > > > Data Width: 0x0000
> > > > Size: 0xffff
> > > > Form Factor: Unknown
> > > > Device Set: 0x00ff
> > > > Device Locator:
> > > > Bank Locator:
> > > > Memory Type: Unknown
> > > > Type Detail: 0x0004
> > > > Speed: 0x0000
> > > > Manufacturer:
> > > > Serial Number:
> > > > Asset Tag:
> > > > Part Number:
> > > > Attributes: 0x0000
> > > > Extended Size: 0x00000000
> > > > Configured Memory Speed: 0x0000
> > > > Minimum voltage: 0x0000
> > > > Maximum voltage: 0x0000
> > > > Configured voltage: 0x0000
> > > > Memory Technology: Unknown
> > > > Memory Operating Mode Capability: 0x0004
> > > > Firmware Version:
> > > > Module Manufacturer ID: 0x0000
> > > > Module Product ID: 0x0000
> > > > Memory Subsystem Controller Manufacturer ID: 0x0000
> > > > Memory Subsystem Controller Product ID: 0x0000
> > > > Non-volatile Size: 0xffffffffffffffff
> > > > Volatile Size: 0xffffffffffffffff
> > > > Cache Size: 0xffffffffffffffff
> > > > Logical Size: 0xffffffffffffffff
> > > > Extended Speed: 0x0000
> > > > Extended Configured Memory Speed: 0x0000
> > > > PMIC0 Manufacturer ID: 0x0000
> > > > PMIC0 Revision Number: 0x0000
> > > > RCD Manufacturer ID: 0x0000
> > > > RCD Revision Number: 0x0000
> > > > ```
> > > >
> > > > If you didn't use smbios_generic.dtsi to insert new nodes, or add n=
ew
> > > > 'memory@' / 'memory-controller@' nodes into your DT, you should get
> > > > the same result as mine by default.
> > > > If you still can not get it, can you give me your build instruction
> > > > and qemu cmd for reproducing?
> > >
> > > I used qemu_arm64_lwip_defconfig
> > >
> > > qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> > >           -machine virt,secure=3Doff -bios u-boot.bin -chardev
> > > socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> > >           -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device
> > > tpm-tis-device,tpmdev=3Dtpm0 \
> > >           -device virtio-rng-pci -drive
> > > id=3Dos,if=3Dnone,file=3D../debian.qcow2 -device virtio-blk-device,dr=
ive=3Dos
> > >  is the command line
> > >
> >
> > I did these steps with a clean build (exactly the same as your ones):
> > $ make O=3Dout_lwip qemu_arm64_lwip_defconfig
> > $ CROSS_COMPILE=3Daarch64-none-linux-gnu- make O=3Dout_lwip -j4 all
> > $ cd out_lwip
> > $ killall swtpm
> > $ rm -rf /tmp/mytpm1
> > $ mkdir -p /tmp/mytpm1
> > $ swtpm_setup --tpmstate /tmp/mytpm1 --tpm2 --pcr-banks sha256
> > $ swtpm socket --tpmstate dir=3D/tmp/mytpm1 --ctrl
> > type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock --log level=3D40 --tpm2 -t =
-d
> > $ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> > -machine virt,secure=3Doff -bios u-boot.bin -chardev
> > socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> > -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis-device,tpmd=
ev=3Dtpm0 \
> > -device virtio-rng-pci -drive id=3Dos,if=3Dnone,file=3D../debian.qcow2
> > -device virtio-blk-device,drive=3Dos
> >
> > SMBIOS type17 shows no difference:
> > ```
> > Handle 0x0008, DMI type 17, 104 bytes at 0x7e64b141
> > Memory Device:
> > Physical Memory Array Handle: 0x0000
> > Memory Error Information Handle: 0xfffe
> > Total Width: 0x0000
> > Data Width: 0x0000
> > Size: 0xffff
> > Form Factor: Unknown
> > Device Set: 0x00ff
> > Device Locator:
> > Bank Locator:
> > Memory Type: Unknown
> > Type Detail: 0x0004
> > Speed: 0x0000
> > Manufacturer:
> > Serial Number:
> > Asset Tag:
> > Part Number:
> > Attributes: 0x0000
> > Extended Size: 0x00000000
> > Configured Memory Speed: 0x0000
> > Minimum voltage: 0x0000
> > Maximum voltage: 0x0000
> > Configured voltage: 0x0000
> > Memory Technology: Unknown
> > Memory Operating Mode Capability: 0x0004
> > Firmware Version:
> > Module Manufacturer ID: 0x0000
> > Module Product ID: 0x0000
> > Memory Subsystem Controller Manufacturer ID: 0x0000
> > Memory Subsystem Controller Product ID: 0x0000
> > Non-volatile Size: 0xffffffffffffffff
> > Volatile Size: 0xffffffffffffffff
> > Cache Size: 0xffffffffffffffff
> > Logical Size: 0xffffffffffffffff
> > Extended Speed: 0x0000
> > Extended Configured Memory Speed: 0x0000
> > PMIC0 Manufacturer ID: 0x0000
> > PMIC0 Revision Number: 0x0000
> > RCD Manufacturer ID: 0x0000
> > RCD Revision Number: 0x0000
> > ```
> >
> > By the way, I don't think it has any relationship with swtpm and the
> > linux distro, so I also simply tried:
> > $ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> > -machine virt,secure=3Doff -bios u-boot.bin
> >
> > All works with the same type17 output.
> >
> > Regards,
> > Raymond
> >
> > > Cheers
> > > /Ilias
> > >
> > >
> > > >
> > > > Regards,
> > > > Raymond
> > > >
> > > >
> > > > > Regards
> > > > > /Ilias
> > > > >
> > > > > On Wed, 4 Feb 2026 at 18:13, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Feb 04, 2026 at 11:12:42AM -0500, Raymond Mao wrote:
> > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > Anyone have a chance to review this patch set? It is the last=
 piece of
> > > > > > > work to support all required SMBIOS types in U-Boot.
> > > > > >
> > > > > > I've been waiting for Ilias or Heinrich to have time to look at=
 this.
> > > > > >
> > > > > > --
> > > > > > Tom
