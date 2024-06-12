Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90B1C27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 13:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0582E8859A;
	Wed, 12 Jun 2024 15:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="NCeNyczk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17474884A7; Wed, 12 Jun 2024 15:42:48 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F02B18859A
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 15:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dfecd065b0aso464334276.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 06:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1718199763; x=1718804563;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5OYue7jW2YnRrzS2pbnZFyNafxUJR0gkgArioOz1EU=;
 b=NCeNyczkkQIXad0S2ESr2LBIBiBvXOZrP6buaAc4xmCIBdnGJfzfqQ9ZNe9Jx2IH6D
 j/uerl8xnfCPENYNMNH3yXColDxK8ixlnVksz6ZP4aMVellhTPem3w+VCV/G44c1DkF4
 RKxw0PqsSZVHEu1Rw1iegn/yA5UWw2fj51rWXsH0Ex+EmOTZH0vovswph2YC52rcAmtU
 Th6jsrJXXlJ29W6OT+EQ37LCiiYGOrVvPmvoTERPQ49Tzw5ClMrzdnbphNgIQGfPdHre
 e3+VpcHovJt97iSX0/GVRJ3K2oCAZKwi3Sqv9Yt52W/0kIPyj+AcnGAZ7R6quF5arj58
 DRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718199763; x=1718804563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P5OYue7jW2YnRrzS2pbnZFyNafxUJR0gkgArioOz1EU=;
 b=Yj3T1Qpto18spKfhJqENLmXxUpKb/tg6cDC1PX2sE+8CySHyqBWUYBvZskXWIC+qDZ
 d2CC5wyD1q9QPMT6mo8Un7gHsDBgkMYjJCciXFMugiWZVCiX9yeiidg8pFh0neLea7OO
 0+CKWEgB3pBTJc8mAJqQ5bYYoidYjZwYcr36VJP5Dg5XRuzLJNfKEV1FmcMTsScWzzwe
 hzYrj3i3gQ8AlRUJxCeA1IKzDqro4/69jo+Nvf+6bufO1RZY/1nVrbk9GVif0wQ9Wo8V
 MnL2S5KUSXOKa6shoqh63Fysf93o8+mAWWkp7h6Rhul6HMQbNSmwWhOwq2h8FNonV95k
 yeJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT1VOcLGEyRGkSDMDbhvsI2FOCzFsecNj5V+Q97GW2Kn9v1w4IIqpQfbgsZ/AFav5OffmO6N9xK6a8/r/4r0+6GFTFLA==
X-Gm-Message-State: AOJu0YxEf+c8T3RFMUQ2nL3X0PTYexPuNsrslz2QS7BPXx4UMgnGJApK
 hPRKeeF41EYxuPxiwzYIPJBx3GBJIo8I6g4/r+zurocInpy5PuBSRZpOAzWk+KAClJqfrg9GlQL
 steY+QL+8Jp8Ddpnr32O7m4l5L/R2QFmluNqe
X-Google-Smtp-Source: AGHT+IEKuCRLqspC2N8FxU3C9o67WU4KGQMIKYrfyBgWjA8E1YleiTf1GXxB67ndB0E9Kbw5cN9kE3uKRT9Tq2Lchro=
X-Received: by 2002:a25:8005:0:b0:dfb:10fc:395a with SMTP id
 3f1490d57ef6-dfe67161ddamr1625753276.27.1718199763428; Wed, 12 Jun 2024
 06:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240603164738.437834-1-vassilisamir@gmail.com>
In-Reply-To: <20240603164738.437834-1-vassilisamir@gmail.com>
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 12 Jun 2024 15:42:32 +0200
Message-ID: <CAHTX3d+mD+iqJ-+N4W+y5XVUozVqq-n19-zRBBT5BqDs3BpJAg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] xilinx: Add option to load environment from
 outside of
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: michal.simek@amd.com, trini@konsulko.com, santoshsagar.algapally@amd.com, 
 vasileios.amoiridis@cern.ch, LPolak@arri.de, venkatesh.abbarapu@amd.com, 
 u-boot@lists.denx.de, sr@denx.de
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

Hi Vasileios,

=C3=BAt 4. 6. 2024 v 15:21 odes=C3=ADlatel Vasileios Amoiridis
<vassilisamir@gmail.com> napsal:
>
> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
>
> Changes in v2:
>         - Remove duplication of custom hardcoded env_locations[] code.
>         - Add implementation with general arch_env_get_location(op, prio)
>
> v1: https://lore.kernel.org/u-boot/20240522174738.73522-1-vassilisamir@gm=
ail.com/
>
> Vasileios Amoiridis (1):
>   xilinx: Add option to load environment from outside of boot media
>
>  board/xilinx/versal-net/board.c | 47 ++++++++++++++--------------
>  board/xilinx/versal/board.c     | 47 ++++++++++++++--------------
>  board/xilinx/zynq/board.c       | 49 +++++++++++++++--------------
>  board/xilinx/zynqmp/zynqmp.c    | 55 +++++++++++++++++----------------
>  4 files changed, 101 insertions(+), 97 deletions(-)
>
> --
> 2.34.1
>

I have to remove this patch from my queue because it is actually
breaking current behavior.
CI is reporting an issue with it and I did a closer look and what is
happening is that if one location has no valid
data it goes and looks at another location from the list.

On Zynq it behaves like this.

MMC:   mmc@e0100000: 0
prio 0
Loading Environment from SPIFlash... SF: Detected n25q128a13 with page
size 256 Bytes, erase size 64 KiB, total 16 MiB
*** Warning - bad CRC, using default environment

prio 1
Loading Environment from NAND... *** Error - No Valid Environment Area foun=
d
*** Warning - bad env area, using default environment

prio 2
Loading Environment from SPIFlash... *** Warning - bad CRC, using
default environment

prio 3
Loading Environment from nowhere... OK

prio is my print to show where code is. Qemu boots out in QSPI boot
mode and SPI is tried first and because
this is xilinx_zynq_virt defconfig drivers/env locations for other
devices are present too. That's why it goes over the list
and it always ends in nowhere which never fails.

If this runs on real HW then the same behavior is visible and I don't
think it is right.
I think this solution should be rethought.
In product current behavior from our code is not the best and current
U-Boot implementation is not allowing
flexibility too. We are enabling redundant variables which can be only
on the same device but not that you have
one copy in QSPI and second in EMMC.
That's why I think location should be pretty much read from DT.
There is options/u-boot node where location of variables should be
described and this should replace
env_get_location().
It is a lot of work that's why I think second solution is more
reasonable for you which is simply create new Kconfig symbol
to disable board env_get_location() implementation.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
