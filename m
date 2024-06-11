Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230B4C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 07:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 479598836C;
	Tue, 11 Jun 2024 09:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WeFU8/dW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CABF88839D; Tue, 11 Jun 2024 09:12:24 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A54188365
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 09:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52c84a21c62so2371308e87.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 00:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718089941; x=1718694741; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYaO6/Ab3uqOFRqKEfXzBK5BbFzGn2Ukz+PzQceQHaQ=;
 b=WeFU8/dWgVkIbPipISrKZVFF7PBzEr7qsRvYy0ManMRDntyp07bb7JhGbWMrv/MQin
 OvyG6omm4i6QCOoWNhFdh5wgwTJeXoeVw6ZPFS6fKZBJDfqBFW3bC4XxZ6fC19vdmkhU
 2PqagwHqyoD8XgaTooZP47x5EmdfiOFqa0wGCGK1vOmOSwJy19hNtAiHqfH5ukuJTMbQ
 ArKhX6z8kv/I37//peq81Xep+fxrMqTe0WA9bvXjYWDCvFBUYkhIieunWA0me1Sx4ojH
 kXxDLdqcD8gx72kuxR+5UFL04nqvcbYfEogjiqOv7pbOvl55/dz83zDNqdo9HhDbEBKy
 Ns1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718089941; x=1718694741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYaO6/Ab3uqOFRqKEfXzBK5BbFzGn2Ukz+PzQceQHaQ=;
 b=gmkVDYxC5iKa6D9vI0DKn//z35SoRdgVzdidFPEbDt3z68mh6tNTL/oG6xnbTMq02S
 V4wUkZpOTPEfIvR9lgUgZvl6+ZjsKknVjrBsHWOVJTCcV1BN2suN8xmX/jN4cUnlG0+o
 +1wYsYJUSYlrY1ITwW/QM+G1W/rfNMvI7sHx05pnVLFgDSl9w9jK7MKv3dtbXJo7pPjI
 4hjOEj03d1wHK0KhnWAaPTRKBVCmC5tF1DRT1qmXFY/vUU3a6tp1/SygfAyZskyFIM7M
 oOi0ICBY9VeTZfiC++BJsXnJE4gg+DhWwIwON8cACZVt4Tt2Smma1qF6rvYYacRUF7sw
 B66Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLCsyB2u2cMdGtEYWH14lj7xeZq7F0ieQGkFHjSOeoimxnAKonPI7yBOq6XdhiosM4ai9OqPNQwBNOfKzKZARCFBweFg==
X-Gm-Message-State: AOJu0Yx9Pg/dJ5/nKiOy1gB4CMtLuAdCuX6A1HacIVvahuvgcU77WPcZ
 d+Yt0rJDPNlxi9Myi7RKBFv8Yw06OMiRgcmWdC4tZwTKE4VZgXYE0FhCcvLmP3dWImOLY8u/wbS
 LtqoWdRGEswTf1a3iXWjQzX/IuPg=
X-Google-Smtp-Source: AGHT+IExFM9Q3nUp6PWerqfJ+O4e4pGI3HI6gBaN8t6Hu/vh6wR/0lOZOMBtz34WJ/7fAzvCUOvHmrdGIIehV2WgRrM=
X-Received: by 2002:ac2:4c33:0:b0:52c:8920:875 with SMTP id
 2adb3069b0e04-52c89735017mr2928242e87.20.1718089940666; Tue, 11 Jun 2024
 00:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240523064025.17602-1-seashell11234455@gmail.com>
 <a11e1e72-c274-46f1-bedc-092ae0d9c370@canonical.com>
In-Reply-To: <a11e1e72-c274-46f1-bedc-092ae0d9c370@canonical.com>
From: Kongyang Liu <seashell11234455@gmail.com>
Date: Tue, 11 Jun 2024 15:12:09 +0800
Message-ID: <CAOKwTdoxeYYWeq305hTLfNwprNrpaW3kaSxHY+8osyWZDyiMBg@mail.gmail.com>
Subject: Re: [PATCH] doc: board: sophgo: milkv_duo: Update Milk-V Duo
 documentation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Rick Chen <rick@andestech.com>
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

Heinrich Schuchardt <heinrich.schuchardt@canonical.com> =E4=BA=8E2024=E5=B9=
=B46=E6=9C=888=E6=97=A5=E5=91=A8=E5=85=AD 00:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On 23.05.24 08:40, Kongyang Liu wrote:
> > Add detailed steps for compiling U-Boot and OpenSBI, generating the
> > firmware package with fiptool, and booting the board.
> >
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > ---
> >
> >   doc/board/sophgo/milkv_duo.rst | 41 +++++++++++++++++++++++++--------=
-
> >   1 file changed, 30 insertions(+), 11 deletions(-)
> >
> > diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_du=
o.rst
> > index cb2ed1ad98..a88db5b903 100644
> > --- a/doc/board/sophgo/milkv_duo.rst
> > +++ b/doc/board/sophgo/milkv_duo.rst
> > @@ -20,31 +20,50 @@ Building
> >   .. code-block:: console
>
> There are is a 64 MiB version of the Milk-V Duo with the CF1800B, a 256
> MiB version with the SG2002 and a Milk-V Duo S with the SG2000.
>
> This may confuse U-Boot users. Should we mention explicitly that only
> the CF1800B based board is supported?
>

I have tested the Milk-V Duo based on CV1800B and the Milk-V Duo256M based
on SG2002. The tool works properly on both of these boards. However, I have
not tested the Duo S because I currently don't have the board.

At present, U-Boot mainly supports the Milk-V Duo with 64M memory. For
users with 256M, we have provided a README in the GitHub repository for
building fip.bin.

> >
> >      export CROSS_COMPILE=3D<riscv64 toolchain prefix>
> > +
> > +3. Compile U-Boot
> > +
> > +.. code-block:: console
> > +
> >      cd <U-Boot-dir>
> >      make milkv_duo_defconfig
> >      make
> >
> > -This will generate u-boot-dtb.bin
> > +This will generate u-boot.bin and u-boot.dtb
> >
> > -Booting
> > -~~~~~~~
> > -Currently, we rely on vendor FSBL(First Stage Boot Loader) to initiali=
ze the
> > -clock and load the u-boot image, then bootup from it.
> > +4. Compile OpenSBI
> > +
> > +.. code-block:: console
> >
> > -Alternatively, to run u-boot-dtb.bin on top of FSBL, follow these step=
s:
> > +   cd <OpenSBI-dir>
> > +   make PLATFORM=3Dgeneric FW_FDT_PATH=3D<Your U-Boot Path>/u-boot.dtb
> >
> > -1. Use the vendor-provided tool to create a unified fip.bin file conta=
ining
> > -   FSBL, OpenSBI, and U-Boot.
> > +This will generate fw_dynamic.bin
> >
> > -2. Place the generated fip.bin file into the FAT partition of the SD c=
ard.
> > +4. Generate firmware image package
> >
> > -3. Insert the SD card into the board and power it on.
> > +Fiptool(https://github.com/sophgo/fiptool) is used to generate fip fil=
e.
> > +
> > +.. code-block:: console
> > +
> > +   git clone https://github.com/sophgo/fiptool
> > +   cd fiptool
> > +   ./fiptool \
> > +      --fsbl data/fsbl/cv180x.bin \
>
> Where do we get this file from?
>

This is the precompiled FSBL provided by the vendor. Currently, the FSBL
needs to be placed into the vendor-provided SDK to be compiled. For
convenience, we provide the FSBL for different SoCs and uploaded them to
the GitHub repository.

> > +      --opensbi <OpenSBI-dir>/fw_dynamic.bin \
> > +      --uboot <U-Boot-dir>/u-boot.bin \
> > +
> > +This will generate fip.bin
>
> Should we let binman do this in future?
>

The format of the FIP file is defined by the FSBL. This format may change
as the vendor updates the FSBL. At present, I don't think it's necessary
to adapt binman to this format. If there is a need in the future, we will
address this task.

> > +
> > +Booting
> > +~~~~~~~
> > +1. Place the generated fip.bin file into the FAT partition of the SD c=
ard.
>
> This information is insufficient to set up a new SD-card.
>
> Should the SD card be MBR or GPT partitioned?
>
> On an SD card there are typically are multiple partitions. All of these
> may be FAT partioned. Does the boot ROM use a fixed partition number, a
> partition type, or a start sector to identify the relevant partition?
>
> It is left unclear if fip.bin is to be copied by dd to the partition or
> into a FAT file system on the partition.
>
>
>
> I just downloaded the vendor milkv-duo-v1.1.1-2024-0528.img.zip file.
>
> Here I found an MBR partition table with the following partitions:
>
> Device                          Boot   Start     End Sectors  Size Id Typ=
e
> milkv-duo-v1.1.1-2024-0528.img1 *          1  262144  262144  128M  c
> W95 FAT32 (LBA)
> milkv-duo-v1.1.1-2024-0528.img2       262145 1835008 1572864  768M 83 Lin=
ux
> milkv-duo-v1.1.1-2024-0528.img3      1835009 2359296  524288  256M  0 Emp=
ty
>
> Partition 1 was FAT16 partitioned and contained file fip.bin in the root
> directory. But I still don't know how the relevant partition is identifie=
d.
>

Since I used a SD card that has been already formatted during my testing,
I forgot to mention this step in the documentation. I will add instructions
for this step in the next patch.

Best regards
Kongyang Liu

> Best regards
>
> Heinrich
>
> > +2. Insert the SD card into the board and power it on.
> >
> >   The board will automatically execute the FSBL from the fip.bin file.
> >   Subsequently, it will transition to OpenSBI, and finally, OpenSBI wil=
l invoke
> >   U-Boot.
> >
> > -
> >   Sample boot log from Milk-V Duo board
> >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   .. code-block:: none
>
