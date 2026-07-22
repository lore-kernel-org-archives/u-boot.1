Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7B8C4453C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 16:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5708160802;
	Wed, 22 Jul 2026 16:24:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FhElT08vsLkr; Wed, 22 Jul 2026 16:24:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68F1C60640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784737459;
	bh=2/A/K4YU+aIFrvG1BkSwxcXPMU2HQvCFwG3lVeTFkfc=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ItXk1wqCylMNuj5UnFr+avKpfEttVhmsq5fgFc+fxFVfUUP8iaAcZiVM7WRBH/oC2
	 jVBERj5Es85c2qpd6+Sr8/YZobvz3zBEcDQvXh+RA6MWaKM7jkkTiJJ5uHDxTs9qXY
	 TaskTt8Y371KgUEL4FrqIshF8P9QCLcHod4WHqWoyG5mZU9c4bXjTAZO4smLhJKWDe
	 kKej1Ul9o7VQX4JIzlzqjQ46r/ctL+YFcq4cpX1/MG/xRAnMNDf1OvIKOgOKnvlTMq
	 XMhOXPPCRVMEvTyqgguNvrsJVFj2V6tamroLFTFGkV53g5RIj4vFHmpCvfERpSaXdP
	 6EGj/zCuAXXqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68F1C60640;
	Wed, 22 Jul 2026 16:24:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A9261093
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F6F880AE6
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:24:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0uK1x7LLj6Wu for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 16:24:17 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BBA8A80F1D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BBA8A80F1D
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBA8A80F1D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:24:16 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE512848BA; Wed, 22 Jul 2026 18:24:14 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3503E8404D
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 18:24:12 +0200 (CEST)
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-9063b380982so98983086d6.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784737451; cv=none;
 d=google.com; s=arc-20260327;
 b=AsHbxw+C86ioqh92URQTZWEm7CB3Ek5ATA+c1oJl3EAxJL5Bcpa+kAI/ol6YUomKBT
 GwsT0G2EgOl/zbisdlWedvWTAsDaMrIc7fekaKdwzlBkqbkQt1fmgbakNfSJGRyUMPoc
 +M1TRLXFSC6lPYQG08kaDR7W9dQiRDshlmanB4W7zTUiMcZF1MRRDLUpiNQr0qzzBwCT
 QJZ5Z37bnFlhOidVj93bRiZ/8Rj3VkTG7e2Msrtsx262w2Trb6smtKMfn0YWs+64tyZE
 rBdaM8a0D7sbzneJI/3QwWYNkzu9dvu9sI5qmsNO1iBPKQ+kSEKvwcUz9+EJq2jwW9M6
 1Ltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2/A/K4YU+aIFrvG1BkSwxcXPMU2HQvCFwG3lVeTFkfc=;
 fh=dm+Q5YBhe1P/a7HZaEDDVaNgvxduJkrcKp9jS5spFdU=;
 b=oeQOxH6EdB4Q07EZDwF54FSu0JZgJce+dUIoqb6Qteiyv4nZnEBukP8mZffFlK0LDs
 rxaoG5MvRpPctAYWc28+Wg6twujdJE6HUcUIfd5cyZO589qxJerg4lxRGPrTNpzIHHit
 C6nod7/VdYvr//8qcxlbm4WH+eOyKvGujc5lqnBoclPDmOEJSk+b/jUemdOHnf/emz8A
 i8wElCnDwOI4Gb3J1dF5SMOeZ58QRV5ujk0u6zK2QNLiDm2+oxF8xc2AZrCPUBeJ2nOn
 tPGFwUOqFAqKU/c7WdhKmUoawqcul5lOM+rNCBdZLW8lqnpu6pOnEggvI8wKfImJOnDP
 eaZQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784737451; x=1785342251;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2/A/K4YU+aIFrvG1BkSwxcXPMU2HQvCFwG3lVeTFkfc=;
 b=Jr8K8zNX/o6A6lI2dYzJs4P2rTuiqJ9jf2YwJ6T6tb+2W6Ig8XQCyLA5LFdEQgumDb
 q4uXEmVHj61gJaI26vQoPxKvLAE+CbK5omdR87XiqSS/DsL49vpD5YdaT9vFhdioJgz2
 GpHaTb26rXKgyKjXja1R7RnOz99BcXW0w4/gaV4fkxSi1iYA+0TVSDaiIU1MOisME+79
 4kG4bcv2niKPJdctf8zB3TI2dIIzGePjTFqpoSI6VZ6u7hLWH4BigR4wJzbxb0GxIena
 2cErXEgiz0EcBFaiS9OFYFTbIU/hy42gOsrQEpGy/bDMpEJlkKrLTba6YMNFWjvSyFOU
 n9dg==
X-Gm-Message-State: AOJu0YySbsxIwNuI8Iy/Q31a2NS38QNqiQgE6Os+R3qgHr3W8w31JOe1
 h0N4FeQb2kj7NJsrETYn+UpTXt7z8BMrNRJnVhhnPtm+Q7+s01h50QDjAoujJcSN2qHdukoQx8y
 9fBlP7pjX0xZDYKgep4EOqMvywdlgf+Y=
X-Gm-Gg: AR+sD13XNLGB1qtkWkzMAsWbxTl8SLqmMsfRSpKNZAyZ6zPxHMBSUkbcCk5B+t7DTBX
 2fzjWLoTBY8/ncRqgICDZkyp+oRdgOhJvV/7fADGWPNwdi0LO3EhdB7copzk/RhQrxxY0nNoJN2
 Sc5d+97YmHrj1Oxf8Z7DIfh2ehAL7rHhTR3ivN/LBcGBAZFeYRbRbQ4taVCmhVpoziIOAqxp0of
 7QU7VP208XYnfHna/ylcck4S/Pfd85H2HUjPoHnHK0TmNYg5d/6AktwIbImd/6Ocpsk2tVus9Rx
 pGiIUDYJRBfLId/gPJyFexF4IqGIFZGI9pOnn+eWOwVx7wregsUBn5r7/qQZa/GtZvwhBr26GbW
 W/9j8UZ+oGZ5YES20shrw8JwJiIEneEUO9kVTK9n+iKbYbWwisrjAgNF4
X-Received: by 2002:a05:6214:d8b:b0:8e5:d7d1:7bf with SMTP id
 6a1803df08f44-907783138c6mr255898496d6.4.1784737450795; Wed, 22 Jul 2026
 09:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <alujuCnNh13eRfdA@vicb.net>
In-Reply-To: <alujuCnNh13eRfdA@vicb.net>
Date: Wed, 22 Jul 2026 17:23:58 +0100
X-Gm-Features: AUfX_mwvoh44hXJ_PNTZY8ozaF7ttwa8U2JjxYhd6lK4Tmj0nEt77k3k4vKirgM
Message-ID: <CALeDE9OY18j7hFKW=o2mUA__FApjEVJ73oVV5fWTDTPeLqszGQ@mail.gmail.com>
Subject: Re: RK3399 TF-A hash verification failure for atf-3
To: Vic B <u-boot@vicb.net>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784737451; x=1785342251; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2/A/K4YU+aIFrvG1BkSwxcXPMU2HQvCFwG3lVeTFkfc=;
 b=KKXBFJTNSLFc16vS+V+x2hvwZEKaqNxD80m13pJShqDovYtHckSPkUavlt4MPVeDVP
 6PQsRs0nHFzKdy76Sqio/dSOMHqTvFuMQxNfTv4qngHsgXhZstI3br8wmjnS7Y3eQfOK
 v2ltg0n7L2bHHJHkPhix8i5Z3oF6kRLloZmqNLuVz56jT7vrVA/DmrFeLM12YgP/eWrD
 O9D9Yoop6lphn4hGbzYQqJzYBImqnXsICyvE1u+fTLiPxBh3tQC+V/LFPgPi9i+AqoIf
 dRwx2ITc5SgfnzYXqO0AAWtv9aKd8EP7L/Clg2Eg+2GWneKhQ+FbUOgBFZaX60EqHCym
 SRjA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KKXBFJTN
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=pbrobinson@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KKXBFJTN"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Peter Robinson via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Peter Robinson <pbrobinson@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Vic,

> while trying to compile u-boot v2026.07 (or v2026.04) for RK3399-based
> NanoPi R4S, I run into issues with current mainline TF-A (using 2.14, more
> precisely the lts-v2.14.4 tag). I'm cross-compiling both TF-A and u-boot
> using GCC version 14.2.0 (Debian 14.2.0-19) from Debian Trixie.
>
> First, I encountered TF-A build failure with the
>
>  region `PMUSRAM' overflowed by 3928 bytes
>
> error message, which seems to be a long-term issue know since 2018:
>
>  https://github.com/ARM-software/tf-issues/issues/650
>
> and recently also mentioned in this mailing list:
>
>  https://lists.denx.de/pipermail/u-boot/2026-April/613754.html
>
> Although some discussions suggest that this issue may be compiler or
> toolchain dependent, I've eventually found a solution in Armbian
> sources, which fix this issue by changing PMUSRAM_RSIZE from 8K to 16K:

While changing that setting may allow it to build the PMU's SRAM size
in hardware is fixed, so it will cause real world problems.

The thing to note with the PMU FW is it's built for a Cortex-M0 core
which means you need to build it with a 32 bit compiler. You likely
need to add a M0_CROSS_COMPILE=arm-linux-gnu- variable (substitute
with the string for your armv7 compiler string) to the beginning of
your make command. EG:

M0_CROSS_COMPILE=arm-linux-gnu- make HOSTCC="gcc" CROSS_COMPILE=""
PLAT=rk3399 bl31

It works across numerous rk3399 devices for me with the 2.14.1 build
in Fedora and that firmware is about 5.7K in size.

>  https://github.com/armbian/build/blob/main/patch/atf/atf-rockchip64/v2.14/1002-2.14-rk3399-PMUSRAM_RSIZE-8k-16k.patch
>
> I'm also using two other Armbian RK3399-related patches to TF-A as these
> looked useful to me:
>
>  https://github.com/armbian/build/blob/main/patch/atf/atf-rockchip64/v2.14/1001-2.14-rk3399-m0-LDFLAGS-no-pie.patch
>  https://github.com/armbian/build/blob/main/patch/atf/atf-rockchip64/v2.14/1003-rk3399-fix-pl330-dmac-sgrf-init.patch
>
> With all these patches applied to TF-A lts-v2.14.4, I can successfully
> build TF-A and get bl31.elf with .pmusram segment of 0x2f58 (12120)
> bytes (i.e. 8192 bytes of the original limit plus 3928 bytes which used
> to overflow without the patch):
>
>  $ readelf -l ../trusted-firmware-a/build/rk3399/release/bl31/bl31.elf
>
>  Elf file type is EXEC (Executable file)
>  Entry point 0x40000
>  There are 6 program headers, starting at offset 64
>
>  Program Headers:
>    Type           Offset             VirtAddr           PhysAddr
>                   FileSiz            MemSiz              Flags  Align
>    LOAD           0x0000000000010000 0x0000000000040000 0x0000000000040000
>                   0x0000000000023000 0x0000000000023000  R E    0x10000
>    LOAD           0x0000000000033000 0x0000000000063000 0x0000000000063000
>                   0x0000000000000051 0x0000000000081000  RW     0x1000
>    LOAD           0x0000000000034000 0x00000000ff3b0000 0x00000000ff3b0000
>                   0x0000000000002f58 0x0000000000002f58  RWE    0x1000
>    LOAD           0x0000000000037000 0x00000000ff8c0000 0x00000000ff8c0000
>                   0x0000000000002000 0x0000000000002000  R E    0x1000
>    LOAD           0x0000000000000000 0x00000000ff8c2000 0x00000000ff8c2000
>                   0x0000000000000000 0x0000000000001000  RW     0x1000
>    GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>                   0x0000000000000000 0x0000000000000000  RW     0x10
>
>   Section to Segment mapping:
>    Segment Sections...
>     00     .ro
>     01     .data .stacks .bss .per_cpu .xlat_table .coherent_ram
>     02     .pmusram
>     03     .incbin_sram .text_sram
>     04     .stack_sram
>     05
>
> I can also successfully build u-boot with nanopi-r4s-rk3399_defconfig
> and this bl31.elf, where a 12120 bytes blob goes to atf-3 according to
> mkimage:
>
>  Image 3 (atf-3)
>   Description:  ARM Trusted Firmware
>   Created:      Sat Jul 18 17:02:03 2026
>   Type:         Firmware
>   Compression:  uncompressed
>   Data Size:    12120 Bytes = 11.84 KiB = 0.01 MiB
>   Architecture: AArch64
>   OS:           ARM Trusted Firmware
>   Load Address: 0xff3b0000
>   Hash algo:    sha256
>   Hash value:   bb3956f441de43bdc2b0946e2429f1166b4e54fe67cbca6c9fbfa9371b5ecfc9
>
> Sadly, when I try to boot it from SD card, it fails because of hash
> verification failure for atf-3:
>
>  U-Boot SPL 2026.07 (Jul 17 2026 - 15:40:20 +0200)
>  Trying to boot from MMC2
>  ## Checking hash(es) for config config-1 ... OK
>  ## Checking hash(es) for Image atf-1 ... sha256+ OK
>  ## Checking hash(es) for Image u-boot ... sha256+ OK
>  ## Checking hash(es) for Image fdt-1 ... sha256+ OK
>  ## Checking hash(es) for Image atf-2 ... sha256+ OK
>  ## Checking hash(es) for Image atf-3 ... sha256 error!
>  Bad hash value for 'hash' hash node in 'atf-3' image node
>  spl_load_simple_fit: can't load image loadables index 2 (ret = -1)
>  mmc_load_image_raw_sector: mmc block read error
>
> An easy workaround is to disable FIT verification (SPL_FIT_SIGNATURE
> and CONFIG_SPL_FIT_FULL_CHECK) in the SPL, without these I get a working
> u-boot and smooth running linux-6.18.38 without any signs of trouble:
>
>  U-Boot TPL 2026.07 (Jul 15 2026 - 17:34:15)
>  Trying to boot from BOOTROM
>  Returning to boot ROM...
>
>  U-Boot SPL 2026.07 (Jul 15 2026 - 17:34:15 +0200)
>  Trying to boot from MMC2
>  load_simple_fit: Skip load 'atf-5': image size is 0!
>  NOTICE:  BL31: v2.14.4(release):lts-v2.14.4-3-g4660bf8b7
>  NOTICE:  BL31: Built : 22:54:17, Jul 14 2026
>
>
>  U-Boot 2026.07 (Jul 15 2026 - 17:34:15 +0200)
>
>  SoC: Rockchip rk3399
>  Reset cause: POR
>  Model: FriendlyElec NanoPi R4S
>  DRAM:  4 GiB (total 3.9 GiB)
>  PMIC:  RK808
>  Core:  281 devices, 25 uclasses, devicetree: separate
>  MMC:   mmc@fe320000: 1
>  Loading Environment from <NULL>... OK
>  In:    serial
>  Out:   serial
>  Err:   serial
>  Model: FriendlyElec NanoPi R4S
>  Hit any key to stop autoboot: 0
>  ** Booting bootflow 'mmc@fe320000.bootdev.part_1' with script
>  7211491 bytes read in 310 ms (22.2 MiB/s)
>  62459 bytes read in 5 ms (11.9 MiB/s)
>     Uncompressing Kernel Image to 0
>  ## Flattened Device Tree blob at 12000000
>     Booting using the fdt blob at 0x12000000
>  Working FDT set to 12000000
>     Loading Device Tree to 00000000f4f63000, end 00000000f4f753fa ... OK
>  Working FDT set to f4f63000
>
>  Starting kernel ...
>
> However, the need to disable SPL FIT verifications because of the
> mysterious hash verification failure for atf-3 (which seems to contain
> the PMUSRAM blob whose size I had to change from 8K to 16K to fix the
> TF-A build failure) makes the resulting system considerably less
> trustworthy to me.
>
> I suspect that the PMUSRAM_RSIZE setting in TF-A may have a
> corresponding counterpart in u-boot, which may need to be changed too
> when the TF-A value is raised from 8K to 16K. But I didn't manage to
> find any such setting in u-boot.
>
> Also, I'm also quite confused that despite mainline TF-A failing to
> build for RK3399, there seem to be several people submitting recent
> patches for RK3399 boards to u-boot. As TF-A is required by u-boot for
> RK3399, this makes me wonder what version of TF-A those people use
> and/or how they fix the PMUSRAM region overflow issue.
>
> Any hints or thoughts on what is wrong here will be appreciated.
>
> Vic
