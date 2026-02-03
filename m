Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12F0E8B365
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 21:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F0BE83DA7;
	Tue,  3 Feb 2026 22:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="elYs1Su8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF3DE83DBF; Tue,  3 Feb 2026 22:28:26 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 778B183D9C
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 22:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b885e8c679bso951507566b.1
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 13:28:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770154104; cv=none;
 d=google.com; s=arc-20240605;
 b=cQZnSoK9hk71VEBRxnNbCCQhXMDo8gPOh5lWTLGnIxYCFGAJRf+WMFhsG5OLxJ0EJ0
 2mwsj4wBaNuOjI25EXgc9SS7WHoLYyQiBtFMaqUj4LJyKRKbBHikjOW8fbpMmfEEl0Yy
 mpmuXP5+y9rq7vYY/2h++jr1F8TO7ehhv70lcNwXkjj5a0MR8AzAQQOzBOhS2DW87RyC
 Jvq2ENJBug/NIL0xGUo9gMAbv4GR7GnPRe775zRIwG5qtdKLOPbT4RTXjJvOa482tyPp
 FyCXkoQR6WOxLwjh3wioQztEUWwUD8a56Eh0jjN/u58wEldWY3fk0rRrpMs6n4mDNw9n
 A19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q3MdWVKusWIF8O4uKVbhLBjl58p5gsTQxBqwT8yUb1I=;
 fh=mt6hdikiLjRlkDG5n5V3K+Z/7ENTLphBOIeI1WNZyAE=;
 b=awo9Ek+Rswrah2FPemOwlheOoCeHhVN0V+CXeWHHTaSrcyBCHLwhdv4GMUdGzdlaB7
 HZP+v0wHryeeXSAVdewar9JPrjDojQ/MHJt+uYEaKHTHunPiTH8z9BHexXJPPzWw57t/
 8Z1p9mUJs3Btz+jwQj22+c0pakDdfn8AHNyILcN0Lk7Ne7emOgrYytEUB8MxMysp+5wc
 zfjrKYqLTm/utAjM2Arl1txFq5EmA4wPR/Lz5y6qQKmt16RXibTp9Hm9iPeIuv2YFYoE
 SmbUGCh9/sgFsdO00pv2pOIj5SQKuEuVdlJKaVx7cir6KQntGTuuDA7rRvAYzJcsnRpv
 9GWA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770154104; x=1770758904; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3MdWVKusWIF8O4uKVbhLBjl58p5gsTQxBqwT8yUb1I=;
 b=elYs1Su8c/oUtP8z6YGZ5im/BjJvRyp9zD867lycYFtXvmZKLbyVypD0G/KCkD/t9P
 1ol0wWc6VZj0F2Qd5YJKGVOF5O6jlngFX1fzsSrPD4afNyqF60qWdeAxLB5RNwUca9TN
 cHsPulH0g2N7e7uSVfFaWe/PaHPEjzotVICx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770154104; x=1770758904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3MdWVKusWIF8O4uKVbhLBjl58p5gsTQxBqwT8yUb1I=;
 b=lO8bAyDU60+WlBeuEPMD5MXp/VyiI3iD1ZU7KFJRxJVOXEe4BK2NYNzL3cEwyXdn7x
 y/tvTk8Ur2QlmrmhiesNeFgm0NJ7G5G5BPmoH/lkWAUuS17mx+DiH6rSN6UXNXk5j2gs
 No5TIdOY4l153Btvc6C0mYwCJSkd1j9yHQqbSQjBruHVHPHnmvw6EvZjy7MdrOghGl+b
 zB9We6eWkfBxPYyUpqhSczNXaUKLg8tekcIQdP8ARcrstGzY2xVSNLV7TewgQXgf/XgO
 K4ySCCr2Zkx5eGNM7yiN6h35XX5/3JGBQ89Twk4uziQENDrDl2ILcGu84VKtI41ys8g+
 HCHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNDg8ZbzGL3E/1FM5kkKHQm9g99YG81Cx86mZ+d27uUzz0aUU4qtFXVDXaGJwVjczFvStgtV0=@lists.denx.de
X-Gm-Message-State: AOJu0YxMBCiRw7DExxuMbff+pDdH50bA5sFhvtFE/mKR/BjG3ZibTC7e
 mLxMWCi01lU0IW+7l8hVi9SaCT1Fr5JIwQZ10WWfOR14RJ6rPty0p09ea3JgWNl5nYaMfOftHjs
 n7PYHMK+hIp2d/OfGj7r3c2MGiZwBcriaObnCXJT5
X-Gm-Gg: AZuq6aKJD72Ew3AM8Tozm/D03kDGXlnYP+lAiu4x7QemzYwsOmwFmw6ht7KanHP8Z8e
 6yx49opWrFJASZTiQTF+p2gUKOO/RaiSCoCAiN46yEsjvDh21UUC2aWyCwT70ExRb5B7Bgn22bO
 MQQU6wmwNAx92zM0TSrFUvv+DYiA9+C1MJRdTS4B7vI1fvsbuggyLYPcRgeOllVSCu5kyDn2Zdp
 c3t8wLzxqQBrSNy9pQpYQ9nGyiH5X1f5qCL7IaFBq9R8cnG/V4x7n7gvw/B8SOFRtBTiqY=
X-Received: by 2002:a17:907:72c7:b0:b87:f6fc:aea9 with SMTP id
 a640c23a62f3a-b8e9f04c96fmr55067666b.9.1770154103784; Tue, 03 Feb 2026
 13:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
 <20260203180159.GP2603314@bill-the-cat>
In-Reply-To: <20260203180159.GP2603314@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 10:28:25 +1300
X-Gm-Features: AZwV_QiYnCxDAnGqOLJo9-4YJaCpQ-7f9TcQZlxB7_SoG8lKdfBWu0MH4FvNWB8
Message-ID: <CAFLszTi3dFNi0e4C3mSJAMJyh_+Ev1+NmhTtyAXXnHG0MK9e_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fix x86 baytrail boot flow.
To: Tom Rini <trini@konsulko.com>
Cc: Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 u-boot@lists.denx.de, bmeng.cn@gmail.com
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

Hi,

On Wed, 4 Feb 2026 at 07:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jul 14, 2025 at 04:02:48PM -0500, Eric Schikschneit wrote:
>
> > It was found that on modern versions of GCC the transition from low level
> > assembly into the C function 'fsp_find_header' was no longer valid. A detailed
> > step by step analysis with GDB showed that various registers were not being
> > initialized properly which would result in the hardware to fail to setup the
> > Cache As Ram (CAR) portion. This failure cascades down into later stages of
> > initialization because there is no valid stack, or memory for later functions.
> >
> > The function 'fsp_find_header' has been rewritten in assembly, which should
> > no longer be dependant on a specific version of GCC in order to be usable on
> > actual hardware.
> >
> > Testing was done using GCC 11.4.0 on Ubuntu 22.04.
> > Hardware used for verification: Intel E3845 SoC
> >
> > Patch 1 of 2
> >
> > Upstream-Status: Pending
> >
> > Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
>
> Sorry for the delayed response here.
>
> [snip]
> > diff --git a/common/board_f.c b/common/board_f.c
> > index 442b8349d08..3a9ae741d97 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -860,6 +860,7 @@ __weak int clear_bss(void)
> >  }
> >
> >  static const init_fnc_t init_sequence_f[] = {
> > +     arch_fsp_init,          // FSP on platforms like baytrail MUST be done before memory ops
> >       setup_mon_len,
> >  #ifdef CONFIG_OF_CONTROL
> >       fdtdec_setup,
> > diff --git a/include/init.h b/include/init.h
> > index 9a1951d10a0..21d9cea30f6 100644
> > --- a/include/init.h
> > +++ b/include/init.h
> > @@ -68,6 +68,15 @@ int mach_cpu_init(void);
> >   */
> >  int arch_fsp_init_r(void);
> >
> > +/**
> > + * arch_fsp_init() - perform firmware support package init
> > + *
> > + * Where U-Boot relies on binary blobs to handle part of the system init, this
> > + * function can be used to set up the blobs. This is used on some Intel
> > + * platforms.
> > + */
> > +int arch_fsp_init(void);
> > +
> >  int dram_init(void);
> >
> >  /**
>
> Doing it this way will break other architectures. Can we just call the
> function needed inside of x86 assembly?

Also I wonder what is different here. Is it a bug in gcc or something
else. When I try -next on minnowmax I see some errors, but it does
boot:

$ ub-int minnowmax
Building U-Boot in sourcedir for minnowmax
Bootstrapping U-Boot from dir /tmp/b/minnowmax
Writing U-Boot using method em100
Bloblist at 0 not found (err=-2)
alloc space exhausted ptr 400 limit 0
Bloblist at 0 not found (err=-2)
Bloblist at 0 not found (err=-2)
alloc space exhausted ptr 400 limit 0
Bloblist at 0 not found (err=-2)


U-Boot 2026.01-rc5-00488-g6cdd7597a2fb (Feb 03 2026 - 14:20:37 -0700)

CPU:   Intel(R) Atom(TM) CPU  E3825  @ 1.33GHz
DRAM:  2 GiB (total 1.9 GiB)
Core:  25 devices, 16 uclasses, devicetree: separate
MMC:   pci_mmc: 0, pci_mmc: 1, pci_mmc: 2
Loading Environment from SPIFlash... SF: Detected w25q64dw with page
size 256 Bytes, erase size 4 KiB, total 8 MiB
*** Warning - bad CRC, using default environment

Model: Intel Minnowboard Max
Net:   eth0: eth_rtl8169

Hit any key to stop autoboot: 0
=>

This is with ~/..buildman-toolchains/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-

but I also tried with
~/.buildman-toolchains/gcc-11.1.0-nolibc/i386-linux/bin/i386-linux-
and got the same result.

I wonder if this is a bug in that particular version. Are you using
the embedded toolchain, or just the host compiler? Both should
normally work though...

Regards,
Simon
