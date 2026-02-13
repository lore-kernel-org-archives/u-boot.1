Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81C2EF48CC
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 06:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03BDD82BF2;
	Fri, 13 Feb 2026 07:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UGsjvZoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE9783015; Fri, 13 Feb 2026 07:45:05 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A733C80FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 07:45:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79627af6349so7576307b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 22:45:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770965101; cv=none;
 d=google.com; s=arc-20240605;
 b=Vn0Agu8p7Txtddrjl/GGl/wQbi3+RP7sRsypuu60ogF5DJZW+4vyZBt7ohIepeleyX
 2h1nBI5rIdZ3wZQnXqP7A/EJ41QsIuy3w6J8FRB49b/c3ZW111bALDtY3jc/u0T1Z/xf
 cinSMvnFFFXIQPxwETJfQLi9TengLt2WRlj/bWcpjyfQVcXFEDy0mL1kDN/SCKPEJwnI
 NrmzBluokTxXQH/UQT2H53/MMxSMgOqaDvoJzdFGShB+eMfHlzRfy9+/ON8vuFqQey23
 3ofow9Eo4SFq351pLW0lYvIKBhVx3AeuRM6z7eOx+M/YHTpbgNrKgHch1b8a8lxMSlRe
 2vSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QK9+RaXYPrIU+/rQKDuX0JMLzhr37hRHcsIPViYEtEI=;
 fh=917ItwvSEoWin1hKhxvMvb+7mVMiy0NwvNteedPUieI=;
 b=jR4bNyalvBkYq796T8PPMfm/AlrBVPjq0uXmzAS0kpDVe07glAVdPYiH76rjLyIgVM
 RjFNqlpN3KiFUhStmQk56OgjULo0e/masx0pXS6TANmB5/8v91q8iEBCooXuy1jtRsJJ
 C0D4HB7qozFMZpJqcLEPVPLeLjWUe6sSbbTpV7g94db+Zl6WsSXCv+Xi5RpbLSkqMjuq
 XJIUcd8R/pwsItbV6bHr66lP5SCRyIkITx0thCo72F7QjVVo6aBsbho2f3LpZjNI+lQM
 O7yNEu5pfCHklU7R8Jjf5Z2nzn0fhAhn11GLQXH3fBqSJ/ZtRvE+5vAUA2IObEPNR5S9
 CoeA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770965101; x=1771569901; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QK9+RaXYPrIU+/rQKDuX0JMLzhr37hRHcsIPViYEtEI=;
 b=UGsjvZoe2WBzGPPoEuZAxjxeSMxOsv0dP0Max4d7F0gecCHXVQyfhhsYs1Zy7/aH3K
 fQN7ri+0cSYE8lgtOTyT2MKMlT5eiOadQyScB9o2g1D5/nFCaXigKckfp06Du2ELT+Hy
 6fpvqEhn7kCErBexyDmZVJE5nMptXgPT9VymPgj50LYtMejWpRF7MozRYqCihp7xptkp
 zJuyNfXs5WpJQcHPwl+XeP2bHd6mVbg1uqmuuLToptGwrT69C9gRh18l1lcSrIQY/pyC
 O7btKk3t22ek2KPDvd04xqF1i+t4eYs86vRne81SBTDISY6clu1dY/UJRy0Kt0h8Dr6I
 c19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770965101; x=1771569901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QK9+RaXYPrIU+/rQKDuX0JMLzhr37hRHcsIPViYEtEI=;
 b=xB83h8tjNornChnpFief5lOoo8Y38MkjSOx4NyClqmiHqg6lFG9EEkMeNNZDMDC2P0
 WnZ8pndouyyD18V1O1XsWIWNLA1vH+/7LQBgudwPxYKtb/ogxSQt4/f0fO8EJKRN3PDo
 ZE9ZpnyDMpkFa8saC9O17CNVWSvRy5mujRk4Z7Ar3SnGiZv22Ts4qhFCCFdRBviwsmDy
 w+t2u7PoK6IjpM2uyQ3hgs/leYKqSobh3/3604GHxwz9H5mEF9132wnHuLdsee3zuxK+
 284pbK/oJSU9n8wzFNQQjpLnlzVxXq/kfmybO8fTfJjYnZvQQnScgzDdRPMyEvqAlsf2
 5VOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyIXymG8YexuVndLxUGMosuznKEKuRaLE4O84mDQfbLg4wLx7QycfnzH8/ogpc8oszg0WXdvs=@lists.denx.de
X-Gm-Message-State: AOJu0Yyq7aFMN058J8kmn7MQJU59zoJ0ZVF0K+6GduvdDHEjJ9Sd1E9B
 jm2OzZeAF8b3gELEByU2q8LSOLyh/0V2K96dpHAbuejuTWfkeY9GgFujBh3CrbG+3dJbT1puoxy
 b9J6viRx9SlhEVydR2YMcmREVTl3y7fH3rldDJAdTzA==
X-Gm-Gg: AZuq6aLSA9q59xWjDz3TWQLXM6OPTe5EKJaD57QZ5LwHQ1Dp6DNsPHulYCVuN4kgSJZ
 ic/siLH86n6mkCtrBa0dHnKlRURnF2jgT2HtM8pRcjtcOWqU63NlL1YPuz1t/bs3X913hpZf1pr
 /AjBOdBsi9AzjQhZog5FetUQfZ9vkjrnvBoQBIJgfswHir4RdKPPpZoSws39p3TQf5wzkR8RKkn
 +GUyA/LMP9we/wkfeAiyRksH8VOoTSZ5BZlVIWsK0OX4a7biF4Cry8Bj+bW1eT8DAFFbz99t4dt
 DGDA6rgokUxtsS1ZvGdOn5Z7IC86Gv3qf3vpEkbZtIIi8fXA85JvlrTzdB4AUpN92ucKfmeofhJ
 wN2QoNyMydm6bjVLWvYUniBswaCpl6Jc98nb6c23GmCohZMPZDaxxnYdv7rMS7dP7OY/o6dRTU/
 Nul0pJyw0xAubgBZI+ECRnX0U9yu56WlIXxXXPFCyNZbRG3kLCrd6j6Yl5Pfj+KKKmkDoC4YM9q
 jVutZYMkNRMKVhM6/BST+H0bET5/zqyLxwI13zAcqgq9rfBLhjhFFXT/4gsJnhm5pa9uP9lqEaD
 h+pEoGT3m8lr0Lbjq+dWnAc5v2EI0IZV2CX2cX7gQbaTW7KHO6At19s=
X-Received: by 2002:a05:690c:2613:b0:794:f36a:c8f with SMTP id
 00721157ae682-797a0cacb29mr12935347b3.32.1770965100706; Thu, 12 Feb 2026
 22:45:00 -0800 (PST)
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
In-Reply-To: <CAMDkj5xGZoE52dYqWt9r93r9rsc6jB=3N8JkPOeS8nyNG796wA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 08:44:24 +0200
X-Gm-Features: AZwV_Qhu6f17I2ZaMPAp4Ire8M0MndYjQLalvajGTEHBhx0yNE6zDeZHcv1y7LY
Message-ID: <CAC_iWj+Srf1pLtPnYGrtBq2aLY+dXfhXZnLSytFP=LNa5AgOEw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement all missing SMBIOS types required by
 distro tooling
To: Raymond Mao <raymondmaoca@gmail.com>
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

On Thu, 12 Feb 2026 at 16:53, Raymond Mao <raymondmaoca@gmail.com> wrote:
>
> Hi Ilias,
>
> On Thu, Feb 12, 2026 at 7:45=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > That's weird.
> >
> > I tried again on -next and got this
> > Handle 0x0006, DMI type 9, 24 bytes
> > System Slot Information
> > Designation: Not Specified
> > Type: Unknown
> > Data Bus Width: Unknown
> > Current Usage: Unknown
> > Length: Unknown
> > Characteristics: Unknown
> > Bus Address: 0000:00:00.0
> > Data Bus Width (Base): 0
> > Peer Devices: 0
> > Height: Not applicable
> >
> > Handle 0x0007, DMI type 16, 23 bytes
> > Physical Memory Array
> > Location: Unknown
> > Use: Unknown
> > Error Correction Type: Unknown
> > Maximum Capacity: 0 kB
> > Error Information Handle: Not Provided
> > Number Of Devices: 1
> >
> > Handle 0x0008, DMI type 17, 104 bytes
> > Memory Device
> > Array Handle: 0x0000
> > Error Information Handle: Not Provided
> > Total Width: Unknown
> > Data Width: Unknown
> > Size: No Module Installed
> > Form Factor: <OUT OF SPEC>
> > Set: None
> > Locator: <BAD INDEX>
> > Bank Locator: <BAD INDEX>
> > Type: Unknown
> > Type Detail: Other Unknown Fast-paged Static Column Pseudo-static
> > RAMBus Synchronous
> >
> > Handle 0x0009, DMI type 19, 31 bytes
> > Memory Array Mapped Address
> > Starting Address: 0x00000000000
> > Ending Address: 0x000000003FF
> > Range Size: 1 kB
> > Physical Array Handle: 0x0000
> > Partition Width: 1
> >
> > Handle 0x000A, DMI type 32, 11 bytes
> > System Boot Information
> > Status: No errors detected
> >
> > I am using a debian unstable with a 6.18 kernel
> >
>
> It looks that your log is not in a correct format, each header should
> start with:
> 'Handle <handle_id>, DMI type <type_num>, <size> bytes at <address>'
> But your one is missing 'at <address>'.
>
> How did you test it and get it printed? Are you using 'smbios' cmd in
> the u-boot console?

No, that's probably the difference. I am booting to linux and test
with 'dmidecode'

> Do you mind sharing your remote working branch, so that I can have a
> cross-check?

I don't but it's really just the -next branch with your patches. I
think the difference is u-boots tool vs linux

Regards
/Ilias
>
> Regards,
> Raymond
>
>
> > Cheers
> > /Ilias
> >
> > On Thu, 12 Feb 2026 at 02:24, Raymond Mao <raymondmaoca@gmail.com> wrot=
e:
> > >
> > > Hi Ilias
> > >
> > > On Wed, Feb 11, 2026 at 10:20=E2=80=AFAM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Wed, 11 Feb 2026 at 16:30, Raymond Mao <raymondmaoca@gmail.com> =
wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Wed, Feb 11, 2026 at 4:32=E2=80=AFAM Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi all,
> > > > > >
> > > > > > Apologies for the late reply.
> > > > > >
> > > > > > I did test the patches but I see something weird on smbios type=
 17.
> > > > > >
> > > > > > Handle 0x0008, DMI type 17, 104 bytes
> > > > > > Memory Device
> > > > > >         Array Handle: 0x0000
> > > > > >         Error Information Handle: Not Provided
> > > > > >         Total Width: Unknown
> > > > > >         Data Width: Unknown
> > > > > >         Size: No Module Installed
> > > > > >         Form Factor: <OUT OF SPEC>
> > > > > >         Set: None
> > > > > >         Locator: <BAD INDEX>
> > > > > >         Bank Locator: <BAD INDEX>
> > > > > >         Type: Unknown
> > > > > >         Type Detail: Other Unknown Fast-paged Static Column
> > > > > > Pseudo-static RAMBus Synchronous
> > > > > >         Speed: 512 MT/s
> > > > > >         Manufacturer: <BAD INDEX>
> > > > > >         Serial Number: Not Specified
> > > > > >         Asset Tag: Not Specified
> > > > > >         Part Number: Not Specified
> > > > > >         Rank: Unknown
> > > > > >         Configured Memory Speed: Unknown
> > > > > >         Minimum Voltage: Unknown
> > > > > >         Maximum Voltage: Unknown
> > > > > >         Configured Voltage: Unknown
> > > > > >         Memory Technology: <OUT OF SPEC>
> > > > > >         Memory Operating Mode Capability: None
> > > > > >         Firmware Version: Not Specified
> > > > > >         Module Manufacturer ID: Bank 3, Hex 0x04
> > > > > >         Module Product ID: Unknown
> > > > > >         Memory Subsystem Controller Manufacturer ID: Unknown
> > > > > >         Memory Subsystem Controller Product ID: Unknown
> > > > > >         Non-Volatile Size: 16383 PB
> > > > > >         Volatile Size: Unknown
> > > > > >         Cache Size: Unknown
> > > > > >         Logical Size: Unknown
> > > > > >
> > > > > > Any idea what <BAD INDEX> and <OUT OF SPEC> represent?
> > > > > > I tested this in QEMU
> > > > > >
> > > > >
> > > > > I just retested it by below qemu cmd after I rebased it to the cu=
rrent master:
> > > > > qemu-system-aarch64  -bios u-boot.bin -machine virt -cpu cortex-a=
57 -m
> > > > > 2G  -nographic
> > > > >
> > > > > Below is the type17 I got:
> > > > > ```
> > > > > Handle 0x0008, DMI type 17, 104 bytes at 0xbe678141
> > > > > Memory Device:
> > > > > Physical Memory Array Handle: 0x0000
> > > > > Memory Error Information Handle: 0xfffe
> > > > > Total Width: 0x0000
> > > > > Data Width: 0x0000
> > > > > Size: 0xffff
> > > > > Form Factor: Unknown
> > > > > Device Set: 0x00ff
> > > > > Device Locator:
> > > > > Bank Locator:
> > > > > Memory Type: Unknown
> > > > > Type Detail: 0x0004
> > > > > Speed: 0x0000
> > > > > Manufacturer:
> > > > > Serial Number:
> > > > > Asset Tag:
> > > > > Part Number:
> > > > > Attributes: 0x0000
> > > > > Extended Size: 0x00000000
> > > > > Configured Memory Speed: 0x0000
> > > > > Minimum voltage: 0x0000
> > > > > Maximum voltage: 0x0000
> > > > > Configured voltage: 0x0000
> > > > > Memory Technology: Unknown
> > > > > Memory Operating Mode Capability: 0x0004
> > > > > Firmware Version:
> > > > > Module Manufacturer ID: 0x0000
> > > > > Module Product ID: 0x0000
> > > > > Memory Subsystem Controller Manufacturer ID: 0x0000
> > > > > Memory Subsystem Controller Product ID: 0x0000
> > > > > Non-volatile Size: 0xffffffffffffffff
> > > > > Volatile Size: 0xffffffffffffffff
> > > > > Cache Size: 0xffffffffffffffff
> > > > > Logical Size: 0xffffffffffffffff
> > > > > Extended Speed: 0x0000
> > > > > Extended Configured Memory Speed: 0x0000
> > > > > PMIC0 Manufacturer ID: 0x0000
> > > > > PMIC0 Revision Number: 0x0000
> > > > > RCD Manufacturer ID: 0x0000
> > > > > RCD Revision Number: 0x0000
> > > > > ```
> > > > >
> > > > > If you didn't use smbios_generic.dtsi to insert new nodes, or add=
 new
> > > > > 'memory@' / 'memory-controller@' nodes into your DT, you should g=
et
> > > > > the same result as mine by default.
> > > > > If you still can not get it, can you give me your build instructi=
on
> > > > > and qemu cmd for reproducing?
> > > >
> > > > I used qemu_arm64_lwip_defconfig
> > > >
> > > > qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> > > >           -machine virt,secure=3Doff -bios u-boot.bin -chardev
> > > > socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> > > >           -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device
> > > > tpm-tis-device,tpmdev=3Dtpm0 \
> > > >           -device virtio-rng-pci -drive
> > > > id=3Dos,if=3Dnone,file=3D../debian.qcow2 -device virtio-blk-device,=
drive=3Dos
> > > >  is the command line
> > > >
> > >
> > > I did these steps with a clean build (exactly the same as your ones):
> > > $ make O=3Dout_lwip qemu_arm64_lwip_defconfig
> > > $ CROSS_COMPILE=3Daarch64-none-linux-gnu- make O=3Dout_lwip -j4 all
> > > $ cd out_lwip
> > > $ killall swtpm
> > > $ rm -rf /tmp/mytpm1
> > > $ mkdir -p /tmp/mytpm1
> > > $ swtpm_setup --tpmstate /tmp/mytpm1 --tpm2 --pcr-banks sha256
> > > $ swtpm socket --tpmstate dir=3D/tmp/mytpm1 --ctrl
> > > type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock --log level=3D40 --tpm2 -=
t -d
> > > $ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> > > -machine virt,secure=3Doff -bios u-boot.bin -chardev
> > > socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> > > -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis-device,tp=
mdev=3Dtpm0 \
> > > -device virtio-rng-pci -drive id=3Dos,if=3Dnone,file=3D../debian.qcow=
2
> > > -device virtio-blk-device,drive=3Dos
> > >
> > > SMBIOS type17 shows no difference:
> > > ```
> > > Handle 0x0008, DMI type 17, 104 bytes at 0x7e64b141
> > > Memory Device:
> > > Physical Memory Array Handle: 0x0000
> > > Memory Error Information Handle: 0xfffe
> > > Total Width: 0x0000
> > > Data Width: 0x0000
> > > Size: 0xffff
> > > Form Factor: Unknown
> > > Device Set: 0x00ff
> > > Device Locator:
> > > Bank Locator:
> > > Memory Type: Unknown
> > > Type Detail: 0x0004
> > > Speed: 0x0000
> > > Manufacturer:
> > > Serial Number:
> > > Asset Tag:
> > > Part Number:
> > > Attributes: 0x0000
> > > Extended Size: 0x00000000
> > > Configured Memory Speed: 0x0000
> > > Minimum voltage: 0x0000
> > > Maximum voltage: 0x0000
> > > Configured voltage: 0x0000
> > > Memory Technology: Unknown
> > > Memory Operating Mode Capability: 0x0004
> > > Firmware Version:
> > > Module Manufacturer ID: 0x0000
> > > Module Product ID: 0x0000
> > > Memory Subsystem Controller Manufacturer ID: 0x0000
> > > Memory Subsystem Controller Product ID: 0x0000
> > > Non-volatile Size: 0xffffffffffffffff
> > > Volatile Size: 0xffffffffffffffff
> > > Cache Size: 0xffffffffffffffff
> > > Logical Size: 0xffffffffffffffff
> > > Extended Speed: 0x0000
> > > Extended Configured Memory Speed: 0x0000
> > > PMIC0 Manufacturer ID: 0x0000
> > > PMIC0 Revision Number: 0x0000
> > > RCD Manufacturer ID: 0x0000
> > > RCD Revision Number: 0x0000
> > > ```
> > >
> > > By the way, I don't think it has any relationship with swtpm and the
> > > linux distro, so I also simply tried:
> > > $ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> > > -machine virt,secure=3Doff -bios u-boot.bin
> > >
> > > All works with the same type17 output.
> > >
> > > Regards,
> > > Raymond
> > >
> > > > Cheers
> > > > /Ilias
> > > >
> > > >
> > > > >
> > > > > Regards,
> > > > > Raymond
> > > > >
> > > > >
> > > > > > Regards
> > > > > > /Ilias
> > > > > >
> > > > > > On Wed, 4 Feb 2026 at 18:13, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > > >
> > > > > > > On Wed, Feb 04, 2026 at 11:12:42AM -0500, Raymond Mao wrote:
> > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > Anyone have a chance to review this patch set? It is the la=
st piece of
> > > > > > > > work to support all required SMBIOS types in U-Boot.
> > > > > > >
> > > > > > > I've been waiting for Ilias or Heinrich to have time to look =
at this.
> > > > > > >
> > > > > > > --
> > > > > > > Tom
