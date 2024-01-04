Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F9EC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 16:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E3E88747A;
	Thu,  4 Jan 2024 17:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HAqlPvQ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10C2A87980; Thu,  4 Jan 2024 17:02:53 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14832862DA
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 17:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78160ce40ceso41720985a.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 08:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704384169; x=1704988969; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+ClsfCOorBJH05n8QqRvzHK/Vz8jiCC1LDktsYBoUU=;
 b=HAqlPvQ3mlFGEClDQPqIqVAA/wxtk0XSaJ5FZ8XQoSUwmxbAtvVH9JSbixWhozRwcT
 1KGna11Wk45+bpFEos1VgHEmt0bGD4nloHxhvAijxC0MJx219xR+Dpe4ZbiSlAiFLfuG
 yUxwwow41dPp4+gmdp1iRhCU3DzhXoPNO53ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384169; x=1704988969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+ClsfCOorBJH05n8QqRvzHK/Vz8jiCC1LDktsYBoUU=;
 b=SeCcLeOxZluq7yZ5zyocsk4w1b+ZKWg0UkRTaKHUX7G/zp4ehjFwEypZM/XPT+KFy3
 SMYmXwalCRZh3JAFr5TCQ1/jmhSB004J87ov16VdSZib7E6bJfSd16VtEHoi5cO/fAri
 Z1x7507wTTrqN+uj35Dkhf5ABigCuB6Xymi9LKkvM39L7SSKcC1xvMqUdeaWd/a9ZcY5
 niFYq1eUNA7hD30nrKsBw8y0WvgIyXSmxV5WUfg/hYSInMJNW65vgIm1k2TIU3u6dCfe
 E64zN3g6OksPKENx9kWp8XU+Am7RJptLstX4QeW/u0drIFBF8+bDvLXnKjjfgptUbMnX
 I0Zg==
X-Gm-Message-State: AOJu0Yz5pbl7eYjjFGIFe+zUSFudhdZXxg0TXln0mSrVOpLJBUNKOxf3
 CNbilVDQ38JdakAUF6ZL7zRt3D/DeicgU21pvgG4WA6uqCVZ
X-Google-Smtp-Source: AGHT+IG3WLMo4K9PbBvmyRRe5xYtzwXIpBlfEwe7z2ohqttFXjVMVwicfHFdPbHEDWipklAVKTmu7yDt+dpsK451M6A=
X-Received: by 2002:a05:6214:20c9:b0:67f:cfad:65b7 with SMTP id
 9-20020a05621420c900b0067fcfad65b7mr725955qve.85.1704384168789; Thu, 04 Jan
 2024 08:02:48 -0800 (PST)
MIME-Version: 1.0
References: <CANV2PTOD+cY55ES5HDrSZuGjqee3fvfXKORWg8bJFT64mFdg8A@mail.gmail.com>
In-Reply-To: <CANV2PTOD+cY55ES5HDrSZuGjqee3fvfXKORWg8bJFT64mFdg8A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 4 Jan 2024 09:02:38 -0700
Message-ID: <CAFLszTiEfCDGTRHiVQDzb+9KqpKi-EQuS77bOK-LYThZxTTb4g@mail.gmail.com>
Subject: Re: booti usage offset requirements for compressed kernel and initrd
 with dtb
To: E Shattow <lucent@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi,

On Thu, Jan 4, 2024 at 5:19=E2=80=AFAM E Shattow <lucent@gmail.com> wrote:
>
> Hello,
>
> There is data corruption when using booti on a JH7110 (riscv64) board to
> load (over tftp or ymodem) a compressed kernel, compressed initrd, and
> device tree blob, when the data are too close together (even though not
> overlapping). In the adjustments I have tried it seems to be consistent b=
ut
> not clear "why?" by how much for each adjustment is needed to observe the
> failure versus success.
>
> My question is simple enough, what are the intended offset requirements f=
or
> loading these data into memory for use with booti ?
>
> For example:
>
> setenv ip 192.168.2.216
> setenv loadaddr 0x60000000  # default from Milk-V vendor for Mars CM prod=
uct
> setenv kernel_uncomp_size 24193024  # uncompressed size of
> vmlinuz-5.15.0-gpu117 from file command information
> setenv kernel_comp_addr_r $loadaddr
> setenv kernel_addr_r 0x61712800  # $kernel_comp_addr_r + $kernel_uncomp_s=
ize
> dhcp $kernel_addr_r
> $ip:mars-cm_debian-desktop_sdk-boot/vmlinuz-5.15.0-gpu117
> setenv kernel_comp_size 0x$filesize
> setenv dtb_addr 0x62e25000  # $kernel_addr_r + $kernel_uncomp_size
> dhcp $dtb_addr
> $ip:mars-cm_debian-desktop_sdk-boot/dtbs/starfive/jh7110-visionfive-v2.dt=
b
> setenv initrd_addr 0x62e31d7f  # $dtb_addr + 0x$filesize
> dhcp $initrd_addr $ip:debian-installer-netboot/initrd.gz; setenv
> initrd_size 0x$filesize
> booti $kernel_addr_r $initrd_addr:$initrd_size $dtb_addr
>
> Waiting for root device ...
>
> (and nothing else, this is a failure)
>
> If 0x62e31d7f is replaced by 0x62e31ec6 then the boot is successful and
> dmesg from debian-installer shows the additional information:
>
>  Freeing unused kernel image (initmem) memory: 2196K
>  Run /init as init process
>    with arguments:
>      /init
>    with environment:
>      HOME=3D/
>      TERM=3Dlinux
>
>
> So in this the kernel boots and all works normally. Even if that address =
is
> 0x62e31ec5 one byte earlier it is a failure.
>
> In other attempts I would change the ordering i.e. so the initrd is first
> at $loadaddr and then kernel and DTB, or DTB and kernel. If I learned
> anything it is that compressed initrd must be loaded to a span of memory =
at
> least the size of its uncompressed length, and this is also true of the
> compressed kernel vmlinuz even though booti documentation vaguely infers
> that there is an area of memory specified for decompression - so a
> compressed kernel needs two times its uncompressed size is that correct?
> Also there's no hint anywhere if the device tree blob has special memory
> constraints but if it is not starting on some 16byte aligned address at
> least my superstition from observations in testing is that it is not
> successful... and now, where it ends (in the above example) and initrd
> begins seems arbitrary.
>
> Sure I could pad things out, they tend to work that way, but I would like
> to know "why?"

I don't know why, but I imagine that Linux finds the initrd in one
case and not inthe other...does the kernel log give you any clues?

Also, can you use U-Boot's 'md5sum' command or similar to check that
the initrd and DT are the same in each case?

Also, you could use a FIT [1] rather than booti.

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/usage/fit/index.html
