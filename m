Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F53EDF16E
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 14:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0032183015;
	Fri, 13 Feb 2026 15:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UYP6M2dm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B743483CF2; Fri, 13 Feb 2026 15:44:50 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48D9E83015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 15:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-94ab69af6c8so1779305241.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 06:44:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770993887; cv=none;
 d=google.com; s=arc-20240605;
 b=YQWNhIkD2slyfclAUq9R7JqfoAwv77Axqv7VoXwdQ8rFgQRP4F2h0PhOmJfcvcM4wM
 QLPmvaU0CpSqqH62ZTBtYfNXfRORpsA3IwTGYL4H0cG0Oj8oLPd5HtdnSZXEVBex5iKK
 DGUdsw5bLQb72gDj03iMy0p9LJaztlJ29/+m+f1EY7QgvnkO5ZeDAKsHs8/TuQmgWCjD
 ugQf3NwE4mNm0kMJSiJnAGpDadj6fxKt4BbkJeq/yFUIhVveexxPUdMQyaU/uYHZcery
 YFaX3v7xPKJ6xGWyLbkr/3Dqg+0SUYBalswJrYje9oeIHyU0WBJPGew9vSTh7KrfD05b
 t2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bWpYgvsH5wdou1rMOSgMZ5Edhva0MDo5kR1ablAlTU0=;
 fh=dQ8fckw27v/Ar8us/QsswukMMHSx9c/fSDf3BjBlZKQ=;
 b=PFoTKdd9xmlcDFc99bTGSVNRyk1T7jYYKLl9nYqvjY5eAhcOCJ/UBbRWLh/G7r4dyY
 F/Zd0N7QeHApmTJUPalE5QKzEX111KoSazOijsc8sqKl4dO9BviOZvOKBysEOaKBDdRQ
 C9pHWvW/hZc/KWObngUQC+Gid0mlBY5xvbnwvP7vr8+4xK5v7HPSDw3d83qiUOAIlpBH
 pu0NQe7qrEnJYGlppsulwf5n7ZcTFP13G+15Y8jMbG8SCrDR5nn+3k5VvZb1nj0hd6pf
 M5N/RoK2hwRYtb8g4/Wrxy+fUyTSf32KQtaBhdaLudhqGgPfWRlcy/0rAU47yspWdpwm
 5cpQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770993887; x=1771598687; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWpYgvsH5wdou1rMOSgMZ5Edhva0MDo5kR1ablAlTU0=;
 b=UYP6M2dmui9reXI7OlndJ13F8WQmeamx/vJAVZG0Sp7T9+jBC3MKjlpJtcEDqEgZpl
 qs2BmJw/wm212hk9goAQl0w1e7wy7DL/D/N2mzngCJjLpbUBG/wzQ8bxVCyBsC6ZTFfZ
 MJByxK5tUhMZhcqGwdisk1iXtjy/oAUGp61N6I9liWnEZhOD+JmgfSaV+Gujd919bE32
 IocyIWVu5qo4dGSl25qUthcscMs7BMiqqTtPW4XXx1AZbJUl/A2BgG8GVOL2ykCyqA7j
 GYZpRID51SZgYNeyh/YgrHD36qB2YxPq59nsQpb0+PUOWWSRyrmZ/PZ+9Y1AmuBY1BnY
 kYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770993887; x=1771598687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bWpYgvsH5wdou1rMOSgMZ5Edhva0MDo5kR1ablAlTU0=;
 b=sh/1y47o5dmQ7gQZQPYFTOxtTI105j47t73SlCEJC3h16KZOhwF1KHzzE6K3+os/pQ
 vvABKHGmwIjVFPXqdIyKzY0GgMfHMSwXP3ik/V77hbvJG9La/+uhO03zv8kJHihQnjSE
 UbztONAN60W/82X09BVjMKwe6RLRAfrF4nj6nhFyU2mvzNuJUlN1Scoe1qwCziiWsvGS
 8hLhOe2SiPfL4QNO8mzyhmZ6FFeBm3xYTjnkdL32SIVLXG11k0k8EuxhhOXdRLmBKomd
 YgL8xnryknkHe1hhYxBBb2T+OvQC1XuVprbNVRISkf465oMMvJzKjDs+QjrZTN9o3Fry
 Lkmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSbKnra7x2WuK2hJQJCx/CDwg9HD6HXF7WvgEOY+7T+rIw+7/pR2NAJFUasHRd2NZoIb8aUIA=@lists.denx.de
X-Gm-Message-State: AOJu0YwJ6MvgUQa0wIsKggmAxDNc0XayNztYra1W9ot8kQrRl6TMQ9Hx
 jlY9KVMbO7zpIQDEomRPNPbRQb0eRVUTuHHiTypc1sTV7ivlSWeTP2/LL4sHJ7Dtr7sVMNcU3RQ
 MfqOtOAZz7vXmwPhpPZqDkTyrtE2NnDw=
X-Gm-Gg: AZuq6aJ/uIk3EjcMTqOYHIO4k0Nl760Xp/q7ShUbP7rtgrHyD+gReXQvxJDHu8rkf5s
 JMFKdvlmTSod8jp1Zi5JtHRVcmynWtL3eNfGlj1wjw5sy5yOC0JnSUBGVxFLOe1wBPsjgmDJjeH
 vV5eqqLQsq5CyazetbOZC9zUSpFZ04VFph2kvVxFel8MCj2lr1HElHPl3nbp7CAWeUZIcIGLnuP
 ma1mS7rF1sq1UmRj+mdRy36TXJDFhASbQcWxaIbAz8GbnXnw6us/aowkC1EUMuzFvJbDOVQ2vaG
 TMLC62OB
X-Received: by 2002:a05:6102:3907:b0:5fd:51f5:40a9 with SMTP id
 ada2fe7eead31-5fe272ab312mr208417137.22.1770993886983; Fri, 13 Feb 2026
 06:44:46 -0800 (PST)
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
In-Reply-To: <CAC_iWj+Srf1pLtPnYGrtBq2aLY+dXfhXZnLSytFP=LNa5AgOEw@mail.gmail.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 13 Feb 2026 09:44:35 -0500
X-Gm-Features: AZwV_QihQkl78q6rzlzr_30FbqOPOPMuOzcRSpMJTP9aNisGbKE5TVhMQG9XglQ
Message-ID: <CAMDkj5z3HRp=ygWtuf5XRJhSSpMadvwx1y9A4fDHqUMJPA7Zkg@mail.gmail.com>
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

On Fri, Feb 13, 2026 at 1:45=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 12 Feb 2026 at 16:53, Raymond Mao <raymondmaoca@gmail.com> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, Feb 12, 2026 at 7:45=E2=80=AFAM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > That's weird.
> > >
> > > I tried again on -next and got this
> > > Handle 0x0006, DMI type 9, 24 bytes
> > > System Slot Information
> > > Designation: Not Specified
> > > Type: Unknown
> > > Data Bus Width: Unknown
> > > Current Usage: Unknown
> > > Length: Unknown
> > > Characteristics: Unknown
> > > Bus Address: 0000:00:00.0
> > > Data Bus Width (Base): 0
> > > Peer Devices: 0
> > > Height: Not applicable
> > >
> > > Handle 0x0007, DMI type 16, 23 bytes
> > > Physical Memory Array
> > > Location: Unknown
> > > Use: Unknown
> > > Error Correction Type: Unknown
> > > Maximum Capacity: 0 kB
> > > Error Information Handle: Not Provided
> > > Number Of Devices: 1
> > >
> > > Handle 0x0008, DMI type 17, 104 bytes
> > > Memory Device
> > > Array Handle: 0x0000
> > > Error Information Handle: Not Provided
> > > Total Width: Unknown
> > > Data Width: Unknown
> > > Size: No Module Installed
> > > Form Factor: <OUT OF SPEC>
> > > Set: None
> > > Locator: <BAD INDEX>
> > > Bank Locator: <BAD INDEX>
> > > Type: Unknown
> > > Type Detail: Other Unknown Fast-paged Static Column Pseudo-static
> > > RAMBus Synchronous
> > >
> > > Handle 0x0009, DMI type 19, 31 bytes
> > > Memory Array Mapped Address
> > > Starting Address: 0x00000000000
> > > Ending Address: 0x000000003FF
> > > Range Size: 1 kB
> > > Physical Array Handle: 0x0000
> > > Partition Width: 1
> > >
> > > Handle 0x000A, DMI type 32, 11 bytes
> > > System Boot Information
> > > Status: No errors detected
> > >
> > > I am using a debian unstable with a 6.18 kernel
> > >
> >
> > It looks that your log is not in a correct format, each header should
> > start with:
> > 'Handle <handle_id>, DMI type <type_num>, <size> bytes at <address>'
> > But your one is missing 'at <address>'.
> >
> > How did you test it and get it printed? Are you using 'smbios' cmd in
> > the u-boot console?
>
> No, that's probably the difference. I am booting to linux and test
> with 'dmidecode'
>

I think I know the cause now, your dmidecode tool does not fully
follow the spec DSP0134, or it might be an old version.
Take "Form Factor: <OUT OF SPEC>" for example:
By default, this should be "unknown", and according to the spec
(3.9.0) - "unknown" equals to 2.
In the u-boot console, this is decoded properly with my patch series:
"Form Factor: Unknown", which matches the definition in the code
"#define SMBIOS_MD_FF_UNKNOWN 2".
But dmidecode shows "OUT OF SPEC", which means it does not support
"2", or by an incorrect decoding.

What is your dmidecode version?

Regards,
Raymond


> > Do you mind sharing your remote working branch, so that I can have a
> > cross-check?
>
> I don't but it's really just the -next branch with your patches. I
> think the difference is u-boots tool vs linux
>
> Regards
> /Ilias
> >
> > Regards,
> > Raymond
> >
> >
> > > Cheers
> > > /Ilias
> > >
> > > On Thu, 12 Feb 2026 at 02:24, Raymond Mao <raymondmaoca@gmail.com> wr=
ote:
> > > >
> > > > Hi Ilias
> > > >
> > > > On Wed, Feb 11, 2026 at 10:20=E2=80=AFAM Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > On Wed, 11 Feb 2026 at 16:30, Raymond Mao <raymondmaoca@gmail.com=
> wrote:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Wed, Feb 11, 2026 at 4:32=E2=80=AFAM Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi all,
> > > > > > >
> > > > > > > Apologies for the late reply.
> > > > > > >
> > > > > > > I did test the patches but I see something weird on smbios ty=
pe 17.
> > > > > > >
> > > > > > > Handle 0x0008, DMI type 17, 104 bytes
> > > > > > > Memory Device
> > > > > > >         Array Handle: 0x0000
> > > > > > >         Error Information Handle: Not Provided
> > > > > > >         Total Width: Unknown
> > > > > > >         Data Width: Unknown
> > > > > > >         Size: No Module Installed
> > > > > > >         Form Factor: <OUT OF SPEC>
> > > > > > >         Set: None
> > > > > > >         Locator: <BAD INDEX>
> > > > > > >         Bank Locator: <BAD INDEX>
> > > > > > >         Type: Unknown
> > > > > > >         Type Detail: Other Unknown Fast-paged Static Column
> > > > > > > Pseudo-static RAMBus Synchronous
> > > > > > >         Speed: 512 MT/s
> > > > > > >         Manufacturer: <BAD INDEX>
> > > > > > >         Serial Number: Not Specified
> > > > > > >         Asset Tag: Not Specified
> > > > > > >         Part Number: Not Specified
> > > > > > >         Rank: Unknown
> > > > > > >         Configured Memory Speed: Unknown
> > > > > > >         Minimum Voltage: Unknown
> > > > > > >         Maximum Voltage: Unknown
> > > > > > >         Configured Voltage: Unknown
> > > > > > >         Memory Technology: <OUT OF SPEC>
> > > > > > >         Memory Operating Mode Capability: None
> > > > > > >         Firmware Version: Not Specified
> > > > > > >         Module Manufacturer ID: Bank 3, Hex 0x04
> > > > > > >         Module Product ID: Unknown
> > > > > > >         Memory Subsystem Controller Manufacturer ID: Unknown
> > > > > > >         Memory Subsystem Controller Product ID: Unknown
> > > > > > >         Non-Volatile Size: 16383 PB
> > > > > > >         Volatile Size: Unknown
> > > > > > >         Cache Size: Unknown
> > > > > > >         Logical Size: Unknown
> > > > > > >
> > > > > > > Any idea what <BAD INDEX> and <OUT OF SPEC> represent?
> > > > > > > I tested this in QEMU
> > > > > > >
> > > > > >
> > > > > > I just retested it by below qemu cmd after I rebased it to the =
current master:
> > > > > > qemu-system-aarch64  -bios u-boot.bin -machine virt -cpu cortex=
-a57 -m
> > > > > > 2G  -nographic
> > > > > >
> > > > > > Below is the type17 I got:
> > > > > > ```
> > > > > > Handle 0x0008, DMI type 17, 104 bytes at 0xbe678141
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
> > > > > > If you didn't use smbios_generic.dtsi to insert new nodes, or a=
dd new
> > > > > > 'memory@' / 'memory-controller@' nodes into your DT, you should=
 get
> > > > > > the same result as mine by default.
> > > > > > If you still can not get it, can you give me your build instruc=
tion
> > > > > > and qemu cmd for reproducing?
> > > > >
> > > > > I used qemu_arm64_lwip_defconfig
> > > > >
> > > > > qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> > > > >           -machine virt,secure=3Doff -bios u-boot.bin -chardev
> > > > > socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> > > > >           -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device
> > > > > tpm-tis-device,tpmdev=3Dtpm0 \
> > > > >           -device virtio-rng-pci -drive
> > > > > id=3Dos,if=3Dnone,file=3D../debian.qcow2 -device virtio-blk-devic=
e,drive=3Dos
> > > > >  is the command line
> > > > >
> > > >
> > > > I did these steps with a clean build (exactly the same as your ones=
):
> > > > $ make O=3Dout_lwip qemu_arm64_lwip_defconfig
> > > > $ CROSS_COMPILE=3Daarch64-none-linux-gnu- make O=3Dout_lwip -j4 all
> > > > $ cd out_lwip
> > > > $ killall swtpm
> > > > $ rm -rf /tmp/mytpm1
> > > > $ mkdir -p /tmp/mytpm1
> > > > $ swtpm_setup --tpmstate /tmp/mytpm1 --tpm2 --pcr-banks sha256
> > > > $ swtpm socket --tpmstate dir=3D/tmp/mytpm1 --ctrl
> > > > type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock --log level=3D40 --tpm2=
 -t -d
> > > > $ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> > > > -machine virt,secure=3Doff -bios u-boot.bin -chardev
> > > > socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> > > > -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis-device,=
tpmdev=3Dtpm0 \
> > > > -device virtio-rng-pci -drive id=3Dos,if=3Dnone,file=3D../debian.qc=
ow2
> > > > -device virtio-blk-device,drive=3Dos
> > > >
> > > > SMBIOS type17 shows no difference:
> > > > ```
> > > > Handle 0x0008, DMI type 17, 104 bytes at 0x7e64b141
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
> > > > By the way, I don't think it has any relationship with swtpm and th=
e
> > > > linux distro, so I also simply tried:
> > > > $ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> > > > -machine virt,secure=3Doff -bios u-boot.bin
> > > >
> > > > All works with the same type17 output.
> > > >
> > > > Regards,
> > > > Raymond
> > > >
> > > > > Cheers
> > > > > /Ilias
> > > > >
> > > > >
> > > > > >
> > > > > > Regards,
> > > > > > Raymond
> > > > > >
> > > > > >
> > > > > > > Regards
> > > > > > > /Ilias
> > > > > > >
> > > > > > > On Wed, 4 Feb 2026 at 18:13, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Wed, Feb 04, 2026 at 11:12:42AM -0500, Raymond Mao wrote=
:
> > > > > > > >
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > Anyone have a chance to review this patch set? It is the =
last piece of
> > > > > > > > > work to support all required SMBIOS types in U-Boot.
> > > > > > > >
> > > > > > > > I've been waiting for Ilias or Heinrich to have time to loo=
k at this.
> > > > > > > >
> > > > > > > > --
> > > > > > > > Tom
