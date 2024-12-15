Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107EDE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 13:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F308006E;
	Sun, 15 Dec 2024 14:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="liUmlZhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6515C80083; Sun, 15 Dec 2024 05:30:29 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C51268006E
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 05:30:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=effbiae@gmail.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844eac51429so156425539f.2
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 20:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734237025; x=1734841825; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/0zus1kOz/OTx8bVe1KE2e6G/HAoOsMN7XeW0YX6b6o=;
 b=liUmlZhPst4rV0SUBDvA4zJizap+Aa1VI0GmDpSNJ+J5CVbNIIezQBY+5QSjIwxCGF
 yHX7LsezBYVrBNX288ugRaw/clPX2GkPlORJTdSB+vzAZ+j6cPNU0MrhO16RoL7/2Nk1
 9f7z1pBNchWdH+NS7aRlcGr9u1T3OaEgZkipNCDYG4bLO3fjQL2uNHJvTTF8wCt43sXE
 VmKT1eXGcobszgCI//cvPvq8p+YojOoNzPZU8JkmQMWpNAqN5v7rVa1XG4+TL7SvHcPG
 Ma3WwLoD4dp70xxvohMebM7RNrjl1EwA2aKumJB+fIjkapx4iI2NVcAwPgkQbV7CLLRZ
 HzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734237025; x=1734841825;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/0zus1kOz/OTx8bVe1KE2e6G/HAoOsMN7XeW0YX6b6o=;
 b=Kn0owwSpOabCRCXUU+js4cPqPx1CfVfdfvJ+CVSOyH2Dy0uAaFyO4qWm6X6ac66zja
 DE8foWtr9v9RJPAmu97K1s5A8TdZ9ttqDVsRFaPQHZ9jAi5nbf7gUNlE3wU9OESsLLUV
 ByAMc0dHi0e95a2jPAeEuzxX/z1KGOkfe/TZT1OZhdhHhFJayLvaryiAMB9GDYVmJqvG
 2h5GaMQHRVbkHb+4GGpJOqYO3Ai03E04hNIH/Fzbgg48BUm1VLBfRpgp35iN2o+sxseM
 4XlkSMvHWkOZzvFt54iy+nkBqYVybz5ZIOZ2EuIyj/q/rjaivSFthHMoM/dA9iO7TQZS
 8hXQ==
X-Gm-Message-State: AOJu0Yx/gffgrcVReOCzHbE61baLuxcl1Kfd8W5EnNm3eRU2AMBvN5O4
 0F5JtS4ZUvVZCpsKuYP457/oCm3mCvgwWz3rRBV9SNYgeyKcmZ8qVSK2I53hve4R0eg2hGWGnWB
 pOrTszi5qjctnH0m0Kp8OqqKrSlAgx81VTpg=
X-Gm-Gg: ASbGncvIvg11r/xwOgKeG2fZ4sYYVQr0MOiu10aYD6dGvMEBDJvD9uYJNcM1bGmWMwN
 tTY+hMLIaR/7aFnld5v1g8C0G/7mOJcPnjWzalcQ=
X-Google-Smtp-Source: AGHT+IH7j0yFRrY17lFJzW+PHNMZ/Tr6P78ewwPc2MCHOl9qovb2zRYyOjoadyREOUmmBG/K2Np8TUVkqZNKZ9cEP+A=
X-Received: by 2002:a05:6e02:1609:b0:3a7:70a4:6877 with SMTP id
 e9e14a558f8ab-3afee2d0546mr92422535ab.7.1734237024871; Sat, 14 Dec 2024
 20:30:24 -0800 (PST)
MIME-Version: 1.0
From: Jack Andrews <effbiae@gmail.com>
Date: Sun, 15 Dec 2024 15:30:14 +1100
Message-ID: <CAJvHTNwFr4B=aNomxJ+davqz6eWG59E7H2Zh8=UnROsPyu=tuw@mail.gmail.com>
Subject: clang: error: unsupported option '-ffixed-x18' for target
 'arm-linux-gnueabi'
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sun, 15 Dec 2024 14:07:13 +0100
Content-Type: text/plain; charset="UTF-8"
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

thanks for uboot!

i'm trying to build uboot for raspi 4.
these steps produced warnings and a compile error
```
$ git clone https://source.denx.de/u-boot/u-boot.git
$ cd u-boot/
$ make CC=clang rpi_4_defconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
generated_defconfig:19:warning: unexpected data:  # CONFIG_DISPLAY_CPUINFO
is not set
generated_defconfig:20:warning: unexpected data:  #
CONFIG_DISPLAY_BOARDINFO is not set
generated_defconfig:46:warning: unexpected data:  # CONFIG_PINCTRL_GENERIC
is not set
generated_defconfig:49:warning: unexpected data:  #
CONFIG_REQUIRE_SERIAL_CONSOLE is not set
generated_defconfig:64:warning: unexpected data:  # CONFIG_VIDEO_BPP8 is
not set
generated_defconfig:65:warning: unexpected data:  # CONFIG_VIDEO_BPP16 is
not set
generated_defconfig:70:warning: unexpected data:  # CONFIG_HEXDUMP is not
set
#
# configuration written to .config
#
$ make HOSTCC=clang CROSS_COMPILE=arm-linux-gnueabi- CC=clang
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --syncconfig Kconfig
  UPD     include/config.h
  CFG     u-boot.cfg
clang: error: unsupported option '-ffixed-x18' for target
'arm-linux-gnueabi'
make[1]: *** [scripts/Makefile.autoconf:82: u-boot.cfg] Error 1
make: *** No rule to make target 'include/config/auto.conf', needed by
'include/config/uboot.release'.  Stop.
```
```
$ clang -v
Ubuntu clang version 18.1.3 (1ubuntu1)
...
```
