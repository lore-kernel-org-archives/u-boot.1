Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709DBEF99DF
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 23:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B996183AA9;
	Sat, 14 Feb 2026 00:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FnfYxjZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6996083AAB; Sat, 14 Feb 2026 00:00:42 +0100 (CET)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 865AC83015
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 00:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-5fa3f2b8f7fso450079137.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 15:00:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771023638; cv=none;
 d=google.com; s=arc-20240605;
 b=NOQCYHjVOASjr5p0THOeHncSSTNO+WDi//HGiLPSt5tvu3e6BBvPR2rs6qRq2gCfSH
 bK++hdZ38sTvgvIQRB2KXiEp/j0NY7CX9K4hgJOECSVp34UGbPfW9jLrSLN901CwSRXz
 a4COHwc0K4nZm2b2Mrq2UBn+jpQfOkDrtW6FaFd6F+9ZYqlxDccZ/SDS5QSXmGDG0AAx
 lL3sC2sI1VW6y+BqkX8h/o83WwSC80uV5ELUwIejedEIpxxzBIDyLmTZgjUb6HQjQpkT
 l3FIi6jLo5FxiYM5aZIvBqycfkqeh/6awMwmuBgK1MjHo6gaCWz5TK71Iz1GxIj2Tiv4
 MgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q7gUJhu6+60ZO9gpsoJDRMHc/VrNlHkYbG6OXkXNiLE=;
 fh=8YEloSG3eNNAcXhBnll2q3xU/LaKf7I07IlKg515KpU=;
 b=gNubuNbtud91N34aDJUb+kApIgTQ3tqjcuX4MQJrDhD9S2onJ09B9u123u+C09MIOb
 ELJjF3m26mBur6kFTahM6zmkphJt4qwNxB1ARIH1AnFg9/6eXZ1NET9z9/+MAaDbnArs
 VaDSM4JTsYFkZZo1nFmuzIzZKDAGvz130MLPl6KmwO5Z7op6+tSnlkWAH5WvLDksBEws
 vNY1Iu/nq4xD5Tirjk6B/pddBteScU2jrvnNLepETDPedVhw5G+B6ox/X4Zb/BEMx8oD
 wbRIcaD9k2gFkbvnLYGsybVQfV1jLIMfNTkbnzxkOyqozrb2y5meRClmLX3OyZLfdEWI
 Gajw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771023638; x=1771628438; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7gUJhu6+60ZO9gpsoJDRMHc/VrNlHkYbG6OXkXNiLE=;
 b=FnfYxjZIAqlPui0zUKii53S01KjV2IWf774nveuXfspbGUCxdDUiXR374RnJDKeXic
 Aj+PixvkwIl7Q15U9lYDHn5epox/Z6ggubJ0Wajc5THGbrH0dpcYIjEip1LxrV78A1/x
 mbZEfQ6aWDZY28CjVQFZRFg8BcozTjGqi5n93tQDdO2vUgw8yZNN97mhjEimMno3AbJ6
 uZLtJUzWskaUiiJ6H/0rcoSio5qKBgRW4JrekeZ4z1/bjHk1Fg8KN5AiC+0ByT/5OSWA
 6mKuxKjAZPs3JG7W80fsbTgUMvrYyYVHAoTfEFZd5pszIxQ4Cs+Pk3fu1p0F0glF8Vuf
 2gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771023638; x=1771628438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q7gUJhu6+60ZO9gpsoJDRMHc/VrNlHkYbG6OXkXNiLE=;
 b=phmCutLMvuVj0UzpDTNmMUDndPbidzzTzvYsHM0SgxMoJGTHECNJQ2GCC4LBwSx37l
 +ID6DjpvLEeON8FkjJ2MV+zFcQMbwOPDxt7ppaw4xKyiXsIs8MW3DTJdTshC481991mh
 DmZ+dEHpppJKiieWtAtk0R6JRnQjYQXtAk5injBWAxPWzA6Mrr7dm8h+BJynwpbuoTfM
 +KWyeSCBO7HNHKakgw52TotDnCxTSNk099sj0CtfMoiI5gyZdSUUGRCxGyuZd+wrJ6w0
 gTF8K5RJ2dAdkMEcXlE9v0w/XQPQnh1dDUFqTWEWu1ZdiKvXE69ML48kyt94Gu4jW9DJ
 b/Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwzlQjm8VwqfF+be/stsVZqQbVySPXLRiIwdlO50zZ1/UF2+A+MVBTccpAoTLIviwoPLMf4eY=@lists.denx.de
X-Gm-Message-State: AOJu0YyKHlXo5tGaS8BihZVfYv7883imV87ojY2y2c/MO3HHTNARUVlc
 VqKCRKkukBYoA54+z2Q0EDRId7W8TZEUewIYe7hcH46W0+JhRcdMDQeg6sxexdR9hcU4ZlAYYB2
 8i+Xm8+KaWQKUDY/gWnmcJ87XqeiNGWMVX5qgEQ4=
X-Gm-Gg: AZuq6aI6VecAtcY5MQrGHo/ieosk857Xv56pkdw53kZ+v/6pPJ0J61s/yG+SMPFoEtm
 G/jFfHclR1z8UBwlcGahNoxEwDKvuc1CPE08dHPV3c5IOn8JeTJ8KrdH9GYQnbNcNN8yPSGCAN/
 KFwg+zcJxs873rzRzooBbphkcoDfYM1upAK4SxxJ02r86zHSwJbYd0qjLCJAxJD4/AvHubAUo8S
 KDu+/KIu4gp/Xb7GNEM64hsQJPZ6+rxZ36Q1fsE0SPlf1RC/55+BhsAl9GgQho+F557vv0oowiC
 PJr785Ch
X-Received: by 2002:a05:6102:508b:b0:5f5:7791:a1d3 with SMTP id
 ada2fe7eead31-5fe16fabdbamr1293571137.43.1771023637397; Fri, 13 Feb 2026
 15:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20251128163535.2301653-1-raymondmaoca@gmail.com>
 <CAMDkj5zb1qhAR-uf=trSsGEwXmx5TiXc=agX5w5GnjMrP_Nqyg@mail.gmail.com>
 <20260204161345.GY2603314@bill-the-cat>
 <CAC_iWj+qEmxNeGVBcLcrzNM=BkVj0QW2VYW6ZNGTKD6BeRTNHA@mail.gmail.com>
 <CAMDkj5yg24MwQz4G8Y62S7mB_6D=p+0Qrooe77RKQ+C4CPwA1Q@mail.gmail.com>
 <CAC_iWjKUqkjOFsk7+dj+7tn_hrbngoq4CyjCxg0xLbU=-X+GXA@mail.gmail.com>
 <CAMDkj5z0UuUi0qPfaykEVF=MmbEqXUup4GejaLAyJmg3PGByMg@mail.gmail.com>
 <CAC_iWjLqTObHeujWD_6Uix8i_6PZtPTJekVu6DShSwH2Kvobng@mail.gmail.com>
 <CAMDkj5xGZoE52dYqWt9r93r9rsc6jB=3N8JkPOeS8nyNG796wA@mail.gmail.com>
 <CAC_iWj+Srf1pLtPnYGrtBq2aLY+dXfhXZnLSytFP=LNa5AgOEw@mail.gmail.com>
 <CAMDkj5z3HRp=ygWtuf5XRJhSSpMadvwx1y9A4fDHqUMJPA7Zkg@mail.gmail.com>
 <CAC_iWj+K8Vx6+qU5dFGyoeaSz976nMx148g86tWVnT=L-U0E3A@mail.gmail.com>
In-Reply-To: <CAC_iWj+K8Vx6+qU5dFGyoeaSz976nMx148g86tWVnT=L-U0E3A@mail.gmail.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 13 Feb 2026 18:00:23 -0500
X-Gm-Features: AaiRm512nFzhQo0SkmFm0JFLov-hh2jGy1-Rz_uKf4MynvVXVZ2VBVzcq83kSGk
Message-ID: <CAMDkj5xnz8p_d8G48z=N=BQbaY7mXn-Exe6Yh_EhxFBFB0mBNg@mail.gmail.com>
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

On Fri, Feb 13, 2026 at 3:20=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > > > >
> > > > > I am using a debian unstable with a 6.18 kernel
> > > > >
> > > >
> > > > It looks that your log is not in a correct format, each header shou=
ld
> > > > start with:
> > > > 'Handle <handle_id>, DMI type <type_num>, <size> bytes at <address>=
'
> > > > But your one is missing 'at <address>'.
> > > >
> > > > How did you test it and get it printed? Are you using 'smbios' cmd =
in
> > > > the u-boot console?
> > >
> > > No, that's probably the difference. I am booting to linux and test
> > > with 'dmidecode'
> > >
> >
> > I think I know the cause now, your dmidecode tool does not fully
> > follow the spec DSP0134, or it might be an old version.
> > Take "Form Factor: <OUT OF SPEC>" for example:
> > By default, this should be "unknown", and according to the spec
> > (3.9.0) - "unknown" equals to 2.
> > In the u-boot console, this is decoded properly with my patch series:
> > "Form Factor: Unknown", which matches the definition in the code
> > "#define SMBIOS_MD_FF_UNKNOWN 2".
> > But dmidecode shows "OUT OF SPEC", which means it does not support
> > "2", or by an incorrect decoding.
> >
> > What is your dmidecode version?
>
> $ dmidecode --version
> 3.6
>
> it's the default debian unstable version
>

Thanks a lot for the testing and patience through this long debug section.
I am able to reproduce the issue using dmidecode v3.6, and found
type17 structure is mis-aligned.
U-boot console is using its native structure, thus it cannot reproduce
the same problem.
I fixed it and posted v6 at:
https://lore.kernel.org/u-boot/20260213225254.2544596-1-raymondmaoca@gmail.=
com/T/#t
Tested with dmidecode v3.6 under debian and type17 looks fine now.

Thanks and regards,
Raymond

> Cheers
> /Ilias
> >
> > Regards,
> > Raymond
> >
> >
> > > > Do you mind sharing your remote working branch, so that I can have =
a
> > > > cross-check?
> > >
> > > I don't but it's really just the -next branch with your patches. I
> > > think the difference is u-boots tool vs linux
> > >
> > > Regards
> > > /Ilias
> > > >
> > > > Regards,
> > > > Raymond
> > > >
> > > >
> > > > > Cheers
> > > > > /Ilias
> > > > >
> > > > > On Thu, 12 Feb 2026 at 02:24, Raymond Mao <raymondmaoca@gmail.com=
> wrote:
> > > > > >
> > > > > > Hi Ilias
> > > > > >
> > > > > > On Wed, Feb 11, 2026 at 10:20=E2=80=AFAM Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > On Wed, 11 Feb 2026 at 16:30, Raymond Mao <raymondmaoca@gmail=
.com> wrote:
> > > > > > > >
> > > > > > > > Hi Ilias,
> > > > > > > >
> > > > > > > > On Wed, Feb 11, 2026 at 4:32=E2=80=AFAM Ilias Apalodimas
> > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi all,
> > > > > > > > >
> > > > > > > > > Apologies for the late reply.
> > > > > > > > >
> > > > > > > > > I did test the patches but I see something weird on smbio=
s type 17.
> > > > > > > > >
> > > > > > > > > Handle 0x0008, DMI type 17, 104 bytes
> > > > > > > > > Memory Device
> > > > > > > > >         Array Handle: 0x0000
> > > > > > > > >         Error Information Handle: Not Provided
> > > > > > > > >         Total Width: Unknown
> > > > > > > > >         Data Width: Unknown
> > > > > > > > >         Size: No Module Installed
> > > > > > > > >         Form Factor: <OUT OF SPEC>
> > > > > > > > >         Set: None
> > > > > > > > >         Locator: <BAD INDEX>
> > > > > > > > >         Bank Locator: <BAD INDEX>
> > > > > > > > >         Type: Unknown
> > > > > > > > >         Type Detail: Other Unknown Fast-paged Static Colu=
mn
> > > > > > > > > Pseudo-static RAMBus Synchronous
> > > > > > > > >         Speed: 512 MT/s
> > > > > > > > >         Manufacturer: <BAD INDEX>
> > > > > > > > >         Serial Number: Not Specified
> > > > > > > > >         Asset Tag: Not Specified
> > > > > > > > >         Part Number: Not Specified
> > > > > > > > >         Rank: Unknown
> > > > > > > > >         Configured Memory Speed: Unknown
> > > > > > > > >         Minimum Voltage: Unknown
> > > > > > > > >         Maximum Voltage: Unknown
> > > > > > > > >         Configured Voltage: Unknown
> > > > > > > > >         Memory Technology: <OUT OF SPEC>
> > > > > > > > >         Memory Operating Mode Capability: None
> > > > > > > > >         Firmware Version: Not Specified
> > > > > > > > >         Module Manufacturer ID: Bank 3, Hex 0x04
> > > > > > > > >         Module Product ID: Unknown
> > > > > > > > >         Memory Subsystem Controller Manufacturer ID: Unkn=
own
> > > > > > > > >         Memory Subsystem Controller Product ID: Unknown
> > > > > > > > >         Non-Volatile Size: 16383 PB
> > > > > > > > >         Volatile Size: Unknown
> > > > > > > > >         Cache Size: Unknown
> > > > > > > > >         Logical Size: Unknown
> > > > > > > > >
> > > > > > > > > Any idea what <BAD INDEX> and <OUT OF SPEC> represent?
> > > > > > > > > I tested this in QEMU
> > > > > > > > >
> > > > > > > >
> > > > > > > > I just retested it by below qemu cmd after I rebased it to =
the current master:
> > > > > > > > qemu-system-aarch64  -bios u-boot.bin -machine virt -cpu co=
rtex-a57 -m
> > > > > > > > 2G  -nographic
> > > > > > > >
> > > > > > > > Below is the type17 I got:
> > > > > > > > ```
> > > > > > > > Handle 0x0008, DMI type 17, 104 bytes at 0xbe678141
> > > > > > > > Memory Device:
> > > > > > > > Physical Memory Array Handle: 0x0000
> > > > > > > > Memory Error Information Handle: 0xfffe
> > > > > > > > Total Width: 0x0000
> > > > > > > > Data Width: 0x0000
> > > > > > > > Size: 0xffff
> > > > > > > > Form Factor: Unknown
> > > > > > > > Device Set: 0x00ff
> > > > > > > > Device Locator:
> > > > > > > > Bank Locator:
> > > > > > > > Memory Type: Unknown
> > > > > > > > Type Detail: 0x0004
> > > > > > > > Speed: 0x0000
> > > > > > > > Manufacturer:
> > > > > > > > Serial Number:
> > > > > > > > Asset Tag:
> > > > > > > > Part Number:
> > > > > > > > Attributes: 0x0000
> > > > > > > > Extended Size: 0x00000000
> > > > > > > > Configured Memory Speed: 0x0000
> > > > > > > > Minimum voltage: 0x0000
> > > > > > > > Maximum voltage: 0x0000
> > > > > > > > Configured voltage: 0x0000
> > > > > > > > Memory Technology: Unknown
> > > > > > > > Memory Operating Mode Capability: 0x0004
> > > > > > > > Firmware Version:
> > > > > > > > Module Manufacturer ID: 0x0000
> > > > > > > > Module Product ID: 0x0000
> > > > > > > > Memory Subsystem Controller Manufacturer ID: 0x0000
> > > > > > > > Memory Subsystem Controller Product ID: 0x0000
> > > > > > > > Non-volatile Size: 0xffffffffffffffff
> > > > > > > > Volatile Size: 0xffffffffffffffff
> > > > > > > > Cache Size: 0xffffffffffffffff
> > > > > > > > Logical Size: 0xffffffffffffffff
> > > > > > > > Extended Speed: 0x0000
> > > > > > > > Extended Configured Memory Speed: 0x0000
> > > > > > > > PMIC0 Manufacturer ID: 0x0000
> > > > > > > > PMIC0 Revision Number: 0x0000
> > > > > > > > RCD Manufacturer ID: 0x0000
> > > > > > > > RCD Revision Number: 0x0000
> > > > > > > > ```
> > > > > > > >
> > > > > > > > If you didn't use smbios_generic.dtsi to insert new nodes, =
or add new
> > > > > > > > 'memory@' / 'memory-controller@' nodes into your DT, you sh=
ould get
> > > > > > > > the same result as mine by default.
> > > > > > > > If you still can not get it, can you give me your build ins=
truction
> > > > > > > > and qemu cmd for reproducing?
> > > > > > >
> > > > > > > I used qemu_arm64_lwip_defconfig
> > > > > > >
> > > > > > > qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57=
 \
> > > > > > >           -machine virt,secure=3Doff -bios u-boot.bin -charde=
v
> > > > > > > socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> > > > > > >           -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device
> > > > > > > tpm-tis-device,tpmdev=3Dtpm0 \
> > > > > > >           -device virtio-rng-pci -drive
> > > > > > > id=3Dos,if=3Dnone,file=3D../debian.qcow2 -device virtio-blk-d=
evice,drive=3Dos
> > > > > > >  is the command line
> > > > > > >
> > > > > >
> > > > > > I did these steps with a clean build (exactly the same as your =
ones):
> > > > > > $ make O=3Dout_lwip qemu_arm64_lwip_defconfig
> > > > > > $ CROSS_COMPILE=3Daarch64-none-linux-gnu- make O=3Dout_lwip -j4=
 all
> > > > > > $ cd out_lwip
> > > > > > $ killall swtpm
> > > > > > $ rm -rf /tmp/mytpm1
> > > > > > $ mkdir -p /tmp/mytpm1
> > > > > > $ swtpm_setup --tpmstate /tmp/mytpm1 --tpm2 --pcr-banks sha256
> > > > > > $ swtpm socket --tpmstate dir=3D/tmp/mytpm1 --ctrl
> > > > > > type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock --log level=3D40 --=
tpm2 -t -d
> > > > > > $ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57=
 \
> > > > > > -machine virt,secure=3Doff -bios u-boot.bin -chardev
> > > > > > socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> > > > > > -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis-dev=
ice,tpmdev=3Dtpm0 \
> > > > > > -device virtio-rng-pci -drive id=3Dos,if=3Dnone,file=3D../debia=
n.qcow2
> > > > > > -device virtio-blk-device,drive=3Dos
> > > > > >
> > > > > > SMBIOS type17 shows no difference:
> > > > > > ```
> > > > > > Handle 0x0008, DMI type 17, 104 bytes at 0x7e64b141
> > > > > > Memory Device:
> > > > > > Physical Memory Array Handle: 0x0000
> > > > > > Memory Error Information Handle: 0xfffe
> > > > > > Total Width: 0x0000
> > > > > > Data Width: 0x0000
> > > > > > Size: 0xffff
> > > > > > Form Factor: Unknown
> > > > > > Device Set: 0x00ff
> > > > > > Device Locator:
> > > > > > Bank Locator:
> > > > > > Memory Type: Unknown
> > > > > > Type Detail: 0x0004
> > > > > > Speed: 0x0000
> > > > > > Manufacturer:
> > > > > > Serial Number:
> > > > > > Asset Tag:
> > > > > > Part Number:
> > > > > > Attributes: 0x0000
> > > > > > Extended Size: 0x00000000
> > > > > > Configured Memory Speed: 0x0000
> > > > > > Minimum voltage: 0x0000
> > > > > > Maximum voltage: 0x0000
> > > > > > Configured voltage: 0x0000
> > > > > > Memory Technology: Unknown
> > > > > > Memory Operating Mode Capability: 0x0004
> > > > > > Firmware Version:
> > > > > > Module Manufacturer ID: 0x0000
> > > > > > Module Product ID: 0x0000
> > > > > > Memory Subsystem Controller Manufacturer ID: 0x0000
> > > > > > Memory Subsystem Controller Product ID: 0x0000
> > > > > > Non-volatile Size: 0xffffffffffffffff
> > > > > > Volatile Size: 0xffffffffffffffff
> > > > > > Cache Size: 0xffffffffffffffff
> > > > > > Logical Size: 0xffffffffffffffff
> > > > > > Extended Speed: 0x0000
> > > > > > Extended Configured Memory Speed: 0x0000
> > > > > > PMIC0 Manufacturer ID: 0x0000
> > > > > > PMIC0 Revision Number: 0x0000
> > > > > > RCD Manufacturer ID: 0x0000
> > > > > > RCD Revision Number: 0x0000
> > > > > > ```
> > > > > >
> > > > > > By the way, I don't think it has any relationship with swtpm an=
d the
> > > > > > linux distro, so I also simply tried:
> > > > > > $ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57=
 \
> > > > > > -machine virt,secure=3Doff -bios u-boot.bin
> > > > > >
> > > > > > All works with the same type17 output.
> > > > > >
> > > > > > Regards,
> > > > > > Raymond
> > > > > >
> > > > > > > Cheers
> > > > > > > /Ilias
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Regards,
> > > > > > > > Raymond
> > > > > > > >
> > > > > > > >
> > > > > > > > > Regards
> > > > > > > > > /Ilias
> > > > > > > > >
> > > > > > > > > On Wed, 4 Feb 2026 at 18:13, Tom Rini <trini@konsulko.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Feb 04, 2026 at 11:12:42AM -0500, Raymond Mao w=
rote:
> > > > > > > > > >
> > > > > > > > > > > Hi,
> > > > > > > > > > >
> > > > > > > > > > > Anyone have a chance to review this patch set? It is =
the last piece of
> > > > > > > > > > > work to support all required SMBIOS types in U-Boot.
> > > > > > > > > >
> > > > > > > > > > I've been waiting for Ilias or Heinrich to have time to=
 look at this.
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > Tom
