Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D6DEF99DB
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C3283E40;
	Fri, 13 Feb 2026 21:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="to1HGgRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A434383E0E; Fri, 13 Feb 2026 21:20:21 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22E5B83015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 21:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7950afac0ffso33396907b3.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:20:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771014018; cv=none;
 d=google.com; s=arc-20240605;
 b=kKZ4dmxf5Pi+ghpo/RAaPaiGSCkvGAANtJmfiD04Zrbr3kDajp8+vKLyJrcsCAQdvd
 rd6Z3e7Xob5AjKWo/iJnL2dKd0m2dL1LGAUn0o0KUAnHwlA4GqzNR16unomrRrXfyX43
 rYvqImJLNvuc/otoSMbgW8xckFzh9qNcNEKQQ8UyXM8Wr6mKVyEVxdTExOM5VNOg2mid
 jNxNwjjAG6qQR1YFHjrSHftY83tDvGCjvxz7boWoK96WcIAJ8xWnr/yAl+gqjq5IwYje
 xmdPsFa17tu2A23FUm25vLp1N+TDY+doSpWOxSUPxZiHRbh9jvk1qmvrAX9IdqeAB9GX
 Ew/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JGS6ly1MljUnh+0MaHtCdckIgDMYV6h18BCFSuGkqtc=;
 fh=CULjVhQpEjIsU3c+C55Mt4YiEP8zN48gWQUOe6aCbRA=;
 b=ZG4jufFCeLYYV7/jnEs+0IhW6vQqs9c3UKqux1AX5q+OQaHKs4zgt1tPwu+cApvIwQ
 v9ipc/oY7icdr0Pufzy9bn+RQCaMQcHGm6McvpyrchHQP1nKTxZcRIRZHiFC3cnRbt0a
 vHB+L3De9qfvBANrcr6VINKHeRVw3QX9nLziwsbDdCZyMvy4pK+9XFoC4vrKEUzyo5da
 zevzMHYnjMQcUxkKioi3Tj3D/WAPZTS7AmaGwvf/l/zk2Pte8iBGzVVQ/Xac60CWPMTM
 LGLm+3PgrsLvuzbSP7mn1AqfmOq1RnFY1k+S8Aa6gu/FiL7M2GavaQ4IOEvsFC9qW2nx
 zQhw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771014018; x=1771618818; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGS6ly1MljUnh+0MaHtCdckIgDMYV6h18BCFSuGkqtc=;
 b=to1HGgRXd0mV+8TRIvz8x4H4lFv17pvGYLn8l9TgW/JDXRmtbYMHuFe000hWTwTEM7
 Jq7wGn5T58Qnqk/MfPyHBbrPuRuuvQ80XENLXQFNjYRZL+bVZYG02iVhtLYsIxUd5jdh
 IdT2yZ51A7hY25dtFVwyNCd+U/3IXJJ6Ifb8BdFuv3PpUZ4/Ks7TfS8S6Z79pbDZpCJu
 DrnqKNEC29DgOVHjY2oT0f3euKlogMjMNc690XpIGTDh9l5HS+mD08fq7x6ac2ZTa91s
 6N2kCPrO9OqJxRhELH8zcmRHzaziP1PQoGCdsojdCrCDTYo9KqvhPvn+Z3O5bnbkQHKq
 PaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771014018; x=1771618818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JGS6ly1MljUnh+0MaHtCdckIgDMYV6h18BCFSuGkqtc=;
 b=Dqtl7dh/F/CvbhIui2HqNAMSQwm8ptGfE6lBYKX1b2h8JMb3ddJk7eQJe48b0umDcj
 D8OX6FHKimMF+G93s/JDVq9TivK1pBaSSEr4Cz1VhLFmGApeNFM3aLkTSsqdVpiDGt2R
 jpvLdiLlT5PPYlLSnK+TRnkZOJhNwyNd2LfsWvJWHNyt0gOoX8XFvaP9r/41PRsz6eYk
 ZVuLg1ZIQwCt9xYlwyithaYonyUL38gQl9ejgiyQz30nJaVW7Vb9eMbA1RE96DDDzSRS
 qdt4kLpugkWtQFSEKZnqdOm3ABdBWryRgg/PeSdilLeJ1AqoQwdcCt7+06tRBYLNjzWZ
 iKpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMvuE2D8bpN1WAfcHhX3+xPnfepGES+39SGRqP+PuLMqaT4jFTbmVb/5pxjBOMueFG1B/EmZA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywl5sSsppr/JVtaQyBsO+4LMUrbMvt4PcinZQ0Rlq1Ob5En1nL5
 Z7MKokSYjIP+9lB5ooBLOi+vxIdo+3bW0rWpE5X84isuy65T6n7lEeD6txGOpHxJF3joThYSQG8
 QTNb7JPknSMuhVODVUg8iry++HSmyOQfH5Xpkod+gvA==
X-Gm-Gg: AZuq6aJiGWLRhfKF1L5d/ksX1ivoVx9y9Sp5+q+MvEtTPqF8ZuP/S9s9zWaH3SfZgAW
 PnsJx0jl0CROm9C5TYvRyICeC7MfzOdzDORW3+6fqPpZXKba46Fxfv9EMBldrrS0Ppt3LgMmpE8
 e/Zq4U/HFxCCFsLO1eSVfAG5ukLqsrMpTYVSaFfHqiuSRNCINGl9SNyGmBGKg8Svf0bac2NFI5q
 ZNOFWy3r4AETWflqlheF3FHdwO52wt0UqH5EwAfRuYbg9WqHLZtguVJf19HILERM2MDdRQR9JSq
 KzHrrAy5DIhZ/HalaRJiwmMFlb1x2PxpCJc2VltJJkfTNkMfXFQ/MrH5hUDsgtIlQaEbXj2XKr7
 XJQD3L/rQ0wz38p9Q4awPGvQal9qJgETlc9knZLXRk3miRXftKdeBBphhY4E4OsSAiie7AH1bTk
 8ok3OVbVWW8ODCcJrw0M7GWKu1+g24u0VY1uV7irXQNVtBSsNbp+JJ9BW/U2M52U8562Kq2F/7n
 cjQD55LUXrDt0dYiehN+OFRQV1styk09jBIN1ERB6a9EzuSxoOXWrLQbIllonUZQlZH/RjL2grd
 V32Owqn9NPd5W7uCpfBG18CY7JtmrkQYYPwqlDud0HV4lQ==
X-Received: by 2002:a05:690e:1284:b0:646:9ddf:5f2 with SMTP id
 956f58d0204a3-64c202778d4mr957654d50.31.1771014017629; Fri, 13 Feb 2026
 12:20:17 -0800 (PST)
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
In-Reply-To: <CAMDkj5z3HRp=ygWtuf5XRJhSSpMadvwx1y9A4fDHqUMJPA7Zkg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 22:19:41 +0200
X-Gm-Features: AZwV_QiJaYsEO83jcO1ZiXTB8MPpV6yK9NiUwVlvO-5CW-NVlfKw8VEBYFlHc8U
Message-ID: <CAC_iWj+K8Vx6+qU5dFGyoeaSz976nMx148g86tWVnT=L-U0E3A@mail.gmail.com>
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

[...]

> > > >
> > > > I am using a debian unstable with a 6.18 kernel
> > > >
> > >
> > > It looks that your log is not in a correct format, each header should
> > > start with:
> > > 'Handle <handle_id>, DMI type <type_num>, <size> bytes at <address>'
> > > But your one is missing 'at <address>'.
> > >
> > > How did you test it and get it printed? Are you using 'smbios' cmd in
> > > the u-boot console?
> >
> > No, that's probably the difference. I am booting to linux and test
> > with 'dmidecode'
> >
>
> I think I know the cause now, your dmidecode tool does not fully
> follow the spec DSP0134, or it might be an old version.
> Take "Form Factor: <OUT OF SPEC>" for example:
> By default, this should be "unknown", and according to the spec
> (3.9.0) - "unknown" equals to 2.
> In the u-boot console, this is decoded properly with my patch series:
> "Form Factor: Unknown", which matches the definition in the code
> "#define SMBIOS_MD_FF_UNKNOWN 2".
> But dmidecode shows "OUT OF SPEC", which means it does not support
> "2", or by an incorrect decoding.
>
> What is your dmidecode version?

$ dmidecode --version
3.6

it's the default debian unstable version

Cheers
/Ilias
>
> Regards,
> Raymond
>
>
> > > Do you mind sharing your remote working branch, so that I can have a
> > > cross-check?
> >
> > I don't but it's really just the -next branch with your patches. I
> > think the difference is u-boots tool vs linux
> >
> > Regards
> > /Ilias
> > >
> > > Regards,
> > > Raymond
> > >
> > >
> > > > Cheers
> > > > /Ilias
> > > >
> > > > On Thu, 12 Feb 2026 at 02:24, Raymond Mao <raymondmaoca@gmail.com> =
wrote:
> > > > >
> > > > > Hi Ilias
> > > > >
> > > > > On Wed, Feb 11, 2026 at 10:20=E2=80=AFAM Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > On Wed, 11 Feb 2026 at 16:30, Raymond Mao <raymondmaoca@gmail.c=
om> wrote:
> > > > > > >
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > On Wed, Feb 11, 2026 at 4:32=E2=80=AFAM Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > Apologies for the late reply.
> > > > > > > >
> > > > > > > > I did test the patches but I see something weird on smbios =
type 17.
> > > > > > > >
> > > > > > > > Handle 0x0008, DMI type 17, 104 bytes
> > > > > > > > Memory Device
> > > > > > > >         Array Handle: 0x0000
> > > > > > > >         Error Information Handle: Not Provided
> > > > > > > >         Total Width: Unknown
> > > > > > > >         Data Width: Unknown
> > > > > > > >         Size: No Module Installed
> > > > > > > >         Form Factor: <OUT OF SPEC>
> > > > > > > >         Set: None
> > > > > > > >         Locator: <BAD INDEX>
> > > > > > > >         Bank Locator: <BAD INDEX>
> > > > > > > >         Type: Unknown
> > > > > > > >         Type Detail: Other Unknown Fast-paged Static Column
> > > > > > > > Pseudo-static RAMBus Synchronous
> > > > > > > >         Speed: 512 MT/s
> > > > > > > >         Manufacturer: <BAD INDEX>
> > > > > > > >         Serial Number: Not Specified
> > > > > > > >         Asset Tag: Not Specified
> > > > > > > >         Part Number: Not Specified
> > > > > > > >         Rank: Unknown
> > > > > > > >         Configured Memory Speed: Unknown
> > > > > > > >         Minimum Voltage: Unknown
> > > > > > > >         Maximum Voltage: Unknown
> > > > > > > >         Configured Voltage: Unknown
> > > > > > > >         Memory Technology: <OUT OF SPEC>
> > > > > > > >         Memory Operating Mode Capability: None
> > > > > > > >         Firmware Version: Not Specified
> > > > > > > >         Module Manufacturer ID: Bank 3, Hex 0x04
> > > > > > > >         Module Product ID: Unknown
> > > > > > > >         Memory Subsystem Controller Manufacturer ID: Unknow=
n
> > > > > > > >         Memory Subsystem Controller Product ID: Unknown
> > > > > > > >         Non-Volatile Size: 16383 PB
> > > > > > > >         Volatile Size: Unknown
> > > > > > > >         Cache Size: Unknown
> > > > > > > >         Logical Size: Unknown
> > > > > > > >
> > > > > > > > Any idea what <BAD INDEX> and <OUT OF SPEC> represent?
> > > > > > > > I tested this in QEMU
> > > > > > > >
> > > > > > >
> > > > > > > I just retested it by below qemu cmd after I rebased it to th=
e current master:
> > > > > > > qemu-system-aarch64  -bios u-boot.bin -machine virt -cpu cort=
ex-a57 -m
> > > > > > > 2G  -nographic
> > > > > > >
> > > > > > > Below is the type17 I got:
> > > > > > > ```
> > > > > > > Handle 0x0008, DMI type 17, 104 bytes at 0xbe678141
> > > > > > > Memory Device:
> > > > > > > Physical Memory Array Handle: 0x0000
> > > > > > > Memory Error Information Handle: 0xfffe
> > > > > > > Total Width: 0x0000
> > > > > > > Data Width: 0x0000
> > > > > > > Size: 0xffff
> > > > > > > Form Factor: Unknown
> > > > > > > Device Set: 0x00ff
> > > > > > > Device Locator:
> > > > > > > Bank Locator:
> > > > > > > Memory Type: Unknown
> > > > > > > Type Detail: 0x0004
> > > > > > > Speed: 0x0000
> > > > > > > Manufacturer:
> > > > > > > Serial Number:
> > > > > > > Asset Tag:
> > > > > > > Part Number:
> > > > > > > Attributes: 0x0000
> > > > > > > Extended Size: 0x00000000
> > > > > > > Configured Memory Speed: 0x0000
> > > > > > > Minimum voltage: 0x0000
> > > > > > > Maximum voltage: 0x0000
> > > > > > > Configured voltage: 0x0000
> > > > > > > Memory Technology: Unknown
> > > > > > > Memory Operating Mode Capability: 0x0004
> > > > > > > Firmware Version:
> > > > > > > Module Manufacturer ID: 0x0000
> > > > > > > Module Product ID: 0x0000
> > > > > > > Memory Subsystem Controller Manufacturer ID: 0x0000
> > > > > > > Memory Subsystem Controller Product ID: 0x0000
> > > > > > > Non-volatile Size: 0xffffffffffffffff
> > > > > > > Volatile Size: 0xffffffffffffffff
> > > > > > > Cache Size: 0xffffffffffffffff
> > > > > > > Logical Size: 0xffffffffffffffff
> > > > > > > Extended Speed: 0x0000
> > > > > > > Extended Configured Memory Speed: 0x0000
> > > > > > > PMIC0 Manufacturer ID: 0x0000
> > > > > > > PMIC0 Revision Number: 0x0000
> > > > > > > RCD Manufacturer ID: 0x0000
> > > > > > > RCD Revision Number: 0x0000
> > > > > > > ```
> > > > > > >
> > > > > > > If you didn't use smbios_generic.dtsi to insert new nodes, or=
 add new
> > > > > > > 'memory@' / 'memory-controller@' nodes into your DT, you shou=
ld get
> > > > > > > the same result as mine by default.
> > > > > > > If you still can not get it, can you give me your build instr=
uction
> > > > > > > and qemu cmd for reproducing?
> > > > > >
> > > > > > I used qemu_arm64_lwip_defconfig
> > > > > >
> > > > > > qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> > > > > >           -machine virt,secure=3Doff -bios u-boot.bin -chardev
> > > > > > socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> > > > > >           -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device
> > > > > > tpm-tis-device,tpmdev=3Dtpm0 \
> > > > > >           -device virtio-rng-pci -drive
> > > > > > id=3Dos,if=3Dnone,file=3D../debian.qcow2 -device virtio-blk-dev=
ice,drive=3Dos
> > > > > >  is the command line
> > > > > >
> > > > >
> > > > > I did these steps with a clean build (exactly the same as your on=
es):
> > > > > $ make O=3Dout_lwip qemu_arm64_lwip_defconfig
> > > > > $ CROSS_COMPILE=3Daarch64-none-linux-gnu- make O=3Dout_lwip -j4 a=
ll
> > > > > $ cd out_lwip
> > > > > $ killall swtpm
> > > > > $ rm -rf /tmp/mytpm1
> > > > > $ mkdir -p /tmp/mytpm1
> > > > > $ swtpm_setup --tpmstate /tmp/mytpm1 --tpm2 --pcr-banks sha256
> > > > > $ swtpm socket --tpmstate dir=3D/tmp/mytpm1 --ctrl
> > > > > type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock --log level=3D40 --tp=
m2 -t -d
> > > > > $ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> > > > > -machine virt,secure=3Doff -bios u-boot.bin -chardev
> > > > > socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> > > > > -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis-devic=
e,tpmdev=3Dtpm0 \
> > > > > -device virtio-rng-pci -drive id=3Dos,if=3Dnone,file=3D../debian.=
qcow2
> > > > > -device virtio-blk-device,drive=3Dos
> > > > >
> > > > > SMBIOS type17 shows no difference:
> > > > > ```
> > > > > Handle 0x0008, DMI type 17, 104 bytes at 0x7e64b141
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
> > > > > By the way, I don't think it has any relationship with swtpm and =
the
> > > > > linux distro, so I also simply tried:
> > > > > $ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> > > > > -machine virt,secure=3Doff -bios u-boot.bin
> > > > >
> > > > > All works with the same type17 output.
> > > > >
> > > > > Regards,
> > > > > Raymond
> > > > >
> > > > > > Cheers
> > > > > > /Ilias
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Regards,
> > > > > > > Raymond
> > > > > > >
> > > > > > >
> > > > > > > > Regards
> > > > > > > > /Ilias
> > > > > > > >
> > > > > > > > On Wed, 4 Feb 2026 at 18:13, Tom Rini <trini@konsulko.com> =
wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Feb 04, 2026 at 11:12:42AM -0500, Raymond Mao wro=
te:
> > > > > > > > >
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > Anyone have a chance to review this patch set? It is th=
e last piece of
> > > > > > > > > > work to support all required SMBIOS types in U-Boot.
> > > > > > > > >
> > > > > > > > > I've been waiting for Ilias or Heinrich to have time to l=
ook at this.
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Tom
