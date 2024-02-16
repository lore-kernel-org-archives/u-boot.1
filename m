Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A2DC48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 04:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 919EA87E1E;
	Fri, 16 Feb 2024 05:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wSGEsOCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DACF87E20; Fri, 16 Feb 2024 05:49:54 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A36408718A
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 05:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sahaj.sarup@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41244cc3d67so1407195e9.2
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 20:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708058990; x=1708663790; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fcclDkln0nSHv5w+OT63xxJZ1DZeybrO4QlHamgqB5I=;
 b=wSGEsOCgfPUwvCJQkdclWHNr1zoe2vK1C2UY3QLISAzdp9oR8CHFY8ETHr4+2uBtSe
 adYMzLcksvJieWKvbOwnS1XIJGmeVMy6EIs1MmWlR44csx7r5MtS4EixAQAQS2ACtwRN
 XnxSHwzA7+LYZ5UglhvcZE4qdbi/Ws7GYKjEH8LQmFMvQ47303pgvJx2vCP1g6Y0k1+S
 F3GDM8e9NDPU0/+tv0PKg1KbUUbvkDrIv9Wflh1wkjsPzWmXVN8947Rg4APcYudqDMw3
 Uo/4tWsW/xEheJnZexRqkBJAwsm3K7jY3f0BTwo8+QunY6HHt0kqLwsXU8aZmP9lXgci
 jjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708058990; x=1708663790;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fcclDkln0nSHv5w+OT63xxJZ1DZeybrO4QlHamgqB5I=;
 b=HWvWZYRRe6F4ikynclRewEK3T/w0jOYtFjIx9RtnadZKKBP1ueTCSWClTCPJCB5cls
 iey06wFrstXBPPwHi95OF+rIDpkZ26Jk0tg9kvpTgzPkJyE+joDfAzNhdpHFI6a/mbln
 v/H8NK7Dve7ut6wEoi3/GRZALN4Wl5XuFeII3rdXd25HqNRFFNk+DRZfvSE3/uKFbLvZ
 Ep9qz3CqK+sdYHoLCirSs8yzjEifxBT3m/4CBxIuPqA9e5k3p5S0ZlW9ULli2OXx5XKU
 nNR8pmDF+2idMpVa1Q/lGVFll+XUMKZYl9EDHZVhR/mq38wZqn8T3v8E647ZC0hIWlF6
 xgBA==
X-Gm-Message-State: AOJu0YzbAXFwcihPvXmOnNNitIERtFOeBE1d67D2ChNoTnEa7C3d6PbI
 7G/3JLapFXT/q9x7BTmNBMpRd5WMnrWMenXpH8qGMtnFV/FC88lEf15NV3vNNDLKEHSdJQxaroE
 bJYklbQucpch1EANPH8j7Zw9ssX2uH8IinZKaJNoWaJd7Ezby2Ok=
X-Google-Smtp-Source: AGHT+IGV5Zfv2An5ZEi1JGrXCqsljx/QXc+YiErjp3WhOGp337Nf6I14aaeQywr1tN56J63WaV7ktMcsETnhdbCVc1o=
X-Received: by 2002:a05:6000:10c1:b0:33d:1d74:f2c7 with SMTP id
 b1-20020a05600010c100b0033d1d74f2c7mr254599wrx.28.1708058989659; Thu, 15 Feb
 2024 20:49:49 -0800 (PST)
MIME-Version: 1.0
From: Sahaj Sarup <sahaj.sarup@linaro.org>
Date: Fri, 16 Feb 2024 10:19:38 +0530
Message-ID: <CAKZ1LvPwQyWadPtmv4LRmANm-6CHQpNZQqgRyzdxM3fvBTT=1A@mail.gmail.com>
Subject: LTO build failure with GCC 13.2.1
To: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi all,

Since commit f8cebb4f789c9950caf55a0b73e88049e7a1c3a3 enabled LTO by
default for imx8m platforms,
I have been having issues building u-boot.
I am primarily working on imx8mp instead of imx8mm platforms so the
bug resolved by that commit doesn't affect me yet.
But I guess it's a generic issue with u-boot's LTO requirements and GCC 13.

Build log:
```
  LTO     u-boot
/usr/bin/aarch64-linux-gnu-ld:
/usr/lib/gcc/aarch64-linux-gnu/13/libgcc.a(lse-init.o): in function
`init_have_lse_atomics':
/builddir/build/BUILD/gcc-13.2.1-20230728/aarch64-linux-gnu/aarch64-linux-gnu/libgcc/../../../gcc-13.2.1-20230728/libgcc/config/aarch64/lse-init.c:46:
undefined reference to `__getauxval'
collect2: fatal error: ld terminated with signal 11 [Segmentation
fault], core dumped
compilation terminated.
make: *** [Makefile:1766: u-boot] Error 1
make: *** Deleting file 'u-boot'
```

GCC Version:
```
$ aarch64-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=/usr/bin/aarch64-linux-gnu-gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/aarch64-linux-gnu/13/lto-wrapper
Target: aarch64-linux-gnu
Configured with: ../gcc-13.2.1-20230728/configure --bindir=/usr/bin
--build=x86_64-redhat-linux-gnu --datadir=/usr/share --disable-
decimal-float --disable-dependency-tracking --disable-gold
--disable-libgcj --disable-libgomp --disable-libmpx
--disable-libquadmat
h --disable-libssp --disable-libunwind-exceptions --disable-shared
--disable-silent-rules --disable-sjlj-exceptions --disable-threa
ds --with-ld=/usr/bin/aarch64-linux-gnu-ld --enable-__cxa_atexit
--enable-checking=release --enable-gnu-unique-object --enable-init
fini-array --enable-languages=c,c++ --enable-linker-build-id
--enable-lto --enable-nls --enable-obsolete --enable-plugin --enable-t
argets=all --exec-prefix=/usr --host=x86_64-redhat-linux-gnu
--includedir=/usr/include --infodir=/usr/share/info --libexecdir=/usr/
libexec --localstatedir=/var --mandir=/usr/share/man --prefix=/usr
--program-prefix=aarch64-linux-gnu- --sbindir=/usr/sbin --shared
statedir=/var/lib --sysconfdir=/etc --target=aarch64-linux-gnu
--with-bugurl=http://bugzilla.redhat.com/bugzilla/ --with-gcc-major-
version-only --with-isl --with-newlib
--with-plugin-ld=/usr/bin/aarch64-linux-gnu-ld
--with-sysroot=/usr/aarch64-linux-gnu/sys-root
--with-system-libunwind --with-system-zlib --without-headers
--enable-gnu-indirect-function --with-linker-hash-style=gnu
Thread model: single
Supported LTO compression algorithms: zlib zstd
gcc version 13.2.1 20230728 (Red Hat Cross 13.2.1-1) (GCC)
```

Thanks,
Sahaj Sarup
