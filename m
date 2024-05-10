Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C863C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 14:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA2648800D;
	Fri, 10 May 2024 16:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Y011FeXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E363687FFB; Fri, 10 May 2024 16:28:52 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE2D8800D
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 16:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59b58fe083so506512466b.0
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1715351330; x=1715956130;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tysr5sSTJ+eXuknS2RyvMu0zSLviBH/8z2Owr1FsPxk=;
 b=Y011FeXEs4jt1sSFTDEfqttPbwj7k1SWLjS0m89OPxbBcqviFvC5A9YAT1BrfNdw76
 Tmbro8Btirh2vcONCFNu8K5UV366vngPb9a7/z74D4AQOQN9fddPfJ0ClZ4QO69HrmX9
 aKbApKaqPbful1vpGkwPNiqQnTtAdL1pe8V1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715351330; x=1715956130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tysr5sSTJ+eXuknS2RyvMu0zSLviBH/8z2Owr1FsPxk=;
 b=sXLlhWkh8B/oy95MtV2h3o2CoC9wEq7DgBj54wQrKVeWDI6l02NHYVePmtXofvFzNe
 z/5YfUtEbKB5utPFcyITaNSWTQWc+RWvzEOmCA2q6gNjK4hZm42G5p4XmiYZzBq3NCH2
 n5XD63TIIJT2K3Payk18OqtAofJqsEByFNrU9YXsGgw4LUZRxqyBlbg5gq983ijrhbn5
 CHhX4xR/hP2QK5KiA5Ne+kPZUJjvvC3DfjezYBToRju6BNqMS4z7fIPS9IN82O0ErlbH
 0ki16975tWYImQffkTZCqqjfHC9YCveKYzDnn8Aq26ddS+eNaEsUd08hBoXuzeCs3g0G
 kh/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcLR80gZT52r2hLuU4oDTx4l2UQgUViJzlR7cvklD4cie5+/swKRoKQ/O0rR0xpsubFIUTueGTMmEfeMTRR9KZs3DOuQ==
X-Gm-Message-State: AOJu0YwzQNxTckGiXTIRERijP+Ix5xE9s7GZZxZIuOs9r1JUZYEToJGg
 T5XPLBUWBIfHG6Iq+wwbGJDNtANqCqxrM+py4hznQMCNzsLAKyoJOLslpAu1afNdMCwFCAIW26d
 nZRX5k8/R7VSuMW+v+Sru2k4YVNgY0crqZgVZQxV5wD+WVw6YdVi3UQ==
X-Google-Smtp-Source: AGHT+IFipl17a3I6jdpy3MenHGYDZ+h+7AsgG1Jvz/XtLHi7fJr6ICI4T5n5LIh1WDvDHZ47iwNGUA4kk6ZUdhWnU0U=
X-Received: by 2002:a50:9353:0:b0:568:1248:9f49 with SMTP id
 4fb4d7f45d1cf-5734d5bfbf9mr1815629a12.18.1715351330031; Fri, 10 May 2024
 07:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5AnweEsKk_LXVLRmC5=6L2x-Oo+rdngsAs_hcrSHFH91Q@mail.gmail.com>
In-Reply-To: <CAOMZO5AnweEsKk_LXVLRmC5=6L2x-Oo+rdngsAs_hcrSHFH91Q@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 10 May 2024 16:28:39 +0200
Message-ID: <CAOf5uw=2tob+MQfgGTfhXQqJK8vBjOPNPSD1CFkR70yXyEgAZg@mail.gmail.com>
Subject: Re: imx8mp: Flashing U-Boot into eMMC hardware partition via UUU
To: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <frank.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, Tim Harvey <tharvey@gateworks.com>, 
 Adam Ford <aford173@gmail.com>, Heiko Schocher <hs@denx.de>
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

On Fri, May 10, 2024 at 4:19=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi,
>
> I am using an imx8mp-evk board and I can flash the U-Boot into the
> eMMC hardware partition 0 by running:
>
>    =3D> tftpboot $loadaddr flash.bin
>    =3D> setexpr blkcnt $filesize + 0x1ff && setexpr blkcnt $blkcnt / 0x20=
0
>    =3D> mmc dev 2 1
>    =3D> mmc write $loadaddr 0 $blkcnt
>
> Now I want to do the same via UUU.
>
> I tried to create a script called emmc_flash:
>
> uuu_version 1.5.21
>
> SDPS: boot -f flash.bin
> SDPS: done
> FB: ucmd setenv fastboot_dev mmc
> FB: ucmd mmc dev 2 1
> FB: flash bootloader flash.bin
> FB: Done
>
> Then on the PC: uuu emmc_flash
>
> U-Boot is loaded to RAM, but the eMMC hardware partition is not programme=
d.
>
> What is the correct script for doing this?
>
> Any suggestions?

Create an lst file

Hi Fabio

Top posting

# @_flash.bin            | bootloader
# @_image   [_flash.bin] | image burn to nand, default is the same as bootl=
oader
# @_filesystem           | filesystem to burn
# @_kernel               | kernel image
# @_dtb                  | dtb image

# This command will be run when ROM support stream mode
# i.MX8QXP, i.MX8QM
SDPS: boot -f _flash.bin

FB: ucmd setenv fastboot_buffer ${loadaddr}
FB: download -f _image
# Burn image to nandfit partition if needed
FB: ucmd if env exists nandfit_part; then nand erase.part nandfit;
nand write ${fastboot_buffer} nandfit ${filesize}; else true; fi;
FB: ucmd nandbcb init ${fastboot_buffer} nandboot ${filesize}

FB[-t 10000]: ucmd ubi part nandrootfs
FB[-t 10000]: ucmd ubi create root -
FB: download -f _filesystem
FB[-t 60000]: ucmd ubi write ${loadaddr} root ${filesize}

FB: download -f _kernel
FB[-t 10000]: ucmd nand write ${loadaddr} nandkernel ${filesize}

FB: download -f _dtb
FB[-t 8000]: ucmd nand write ${loadaddr} nanddtb ${filesize}

FB: reboot
FB: done

You can just change as you want. We have this file in buildroot, uuu
can run command on the device
using FB command. Example how call it

${OUTPUT_DIR}/host/bin/uuu -v -b ${IMAGES_DIR}/nand-full.lst \
  ${IMAGES_DIR}/flash.bin \
  ${IMAGES_DIR}/flash.bin \
  ${IMAGES_DIR}/rootfs.ubifs \
  ${IMAGES_DIR}/Image \
  ${IMAGES_DIR}/freescale/imx8mn-bsh-smm-s2.dtb


Michael

>
> Thanks



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
