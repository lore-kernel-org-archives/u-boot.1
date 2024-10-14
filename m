Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A664CFC52C
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 10:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E9A08906A;
	Mon, 14 Oct 2024 12:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uQcVVrb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D52589082; Mon, 14 Oct 2024 12:13:50 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F307289041
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c9709c9b0cso1730580a12.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 03:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728900826; x=1729505626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oeQWrnuxneY4Pbb8YbLFLehLvjHu7dmxmyhLXvcPmL4=;
 b=uQcVVrb21MWbNK6vtXG5LtqpfR6mmzTMLGFsLLMXgYI9jhdJGMMKKB4e4yUX/IO0dR
 rD+r1KzUmy3sueA8mP9Hk+3GWvs2JCbB5W3C2VHlYNHaDWmOet5HzBJBCXrKqWecQ0EL
 k+I34cjKYka49LaQ96jxUZaBp5OarleUOvfoemwYiRSnYyZM9HHW9B/pAooVqY2ihSNP
 r91nePd5RzWKGredKS2umTcNyi2l0vsZ7AoqiP2VMz5TSprYjZQN9DERt8Xd7/NunGqC
 NUVWtA1Itc5dRfaBacJLOIqD7XcqwBDtqA0xw0VaU8b2ceoIX+M68Q9qK9+gM0/Z3jBN
 kAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728900826; x=1729505626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oeQWrnuxneY4Pbb8YbLFLehLvjHu7dmxmyhLXvcPmL4=;
 b=aJTwf7Ozs8DVJkZDY56/wO2jC8LyeHae5iyk04ZebJZmu0BmAg7Sb+jl1n03Tx6Mti
 vZLWGBHEFBfx742pw4yI1XY/KJQvr9IqeeDtTrTk9R2CTlD2LviUZudJ3sPxu88O3Cjm
 Agg9+jghWqSZAmCB/N5nn0hgBaaUNUzYpCrj6HBFU1Z//MQczyo2Glp1x13RGRVpEDI2
 IwI3/D5i02IisUO5wKADxVio7s8PypxmYWjFMwZk82h61lCOa8xRYM+32wg2C8fs4PZ9
 D6Dd1o1UQ1w8AONo61FTxQLUZgScWZIEbPc0ldakA9N9kMBhtUtH/1ymef5TIO/nRLQF
 JGTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtT6HNJ3xJp3AGRVz44zXexMgZVoOl6FgOkJobFgKFHSUfsmAfH+O8pScwewgLonIUmuROya4=@lists.denx.de
X-Gm-Message-State: AOJu0YzTtbPyFGzH4i1LYkdLgCILt9iOirLYqcaUERL5UMLlSBnof4Np
 JuFKI5qtRHXZiaLlwfqepJBNkyKry4s0JsQrzZaLJ3CadhOWaeKdjwNLn1rDtggQXqFAYS5X3IL
 KoeYGIzfuyHPONU6+L/RzgLrpsX/bh/YVZ1qE7Q==
X-Google-Smtp-Source: AGHT+IEutWtgIwubSX/oMuVAQCjHAefWPGtNZ1yxMlVQ0niygjMo0tknVN9LnunLSO5qus1UTphFk5ZCNChMUzgJws8=
X-Received: by 2002:a05:6402:2749:b0:5c2:439d:90d4 with SMTP id
 4fb4d7f45d1cf-5c948d76b4amr6906155a12.30.1728900826259; Mon, 14 Oct 2024
 03:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241014094246.2944-1-andyshrk@163.com>
In-Reply-To: <20241014094246.2944-1-andyshrk@163.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 14 Oct 2024 15:43:35 +0530
Message-ID: <CADg8p95OHEmAiVV9HgXeWuqW_CUR0-pvA_WjjCZkT5NFh06sWQ@mail.gmail.com>
Subject: Re: [Regression] rk3588 failed to boot linux
To: Andy Yan <andyshrk@163.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de, kever.yang@rock-chips.com
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

On Mon, 14 Oct 2024 at 15:12, Andy Yan <andyshrk@163.com> wrote:
>
> When test with current main branch on rk3588 based coolpi 4b,
> the board failed to boot linux os[0]:
> I do the same test on another board that is preparing to send
> patches upstream, and it also failed.
>
> The two boards boots fine with v2024.10.
> With some bisect, it seems that this issue is caused by:
>
> commit 360aaddd9cea8c256f50c576794415cadfb61819
> Merge: 2c832abc732 f8ffc6f3cc4
> Author: Tom Rini <trini@konsulko.com>
> Date:   Tue Sep 3 14:09:30 2024 -0600
>
>     Merge patch series "Make LMB memory map global and persistent"
>
>     Sughosh Ganu <sughosh.ganu@linaro.org> says:
>
> My boards boot fine before this merge on u-boot/next, and all failed
> to boot linux after this merge.
>
> I am not familiar with the LMB mechanism, so i don't know how to find
> the root case now.
>
> I dump the bdinfo for both good case[1] and gegression case[2], not sure
> if they are usefull for debug this issue.
>
> [0] Synchronous Abort when starting kernel:
> Scanning bootdev 'mmc@fe2c0000.bootdev':
> Card did not respond to voltage select! : -110
> Scanning bootdev 'mmc@fe2e0000.bootdev':
>   1  script       ready   mmc          1  mmc@fe2e0000.bootdev.part
> /boot/boot.scr
> ** Booting bootflow 'mmc@fe2e0000.bootdev.part_1' with script
> Boot script loaded from mmc 0:1
> 224 bytes read in 7 ms (31.3 KiB/s)
> 26510301 bytes read in 97 ms (260.6 MiB/s)
> 32883200 bytes read in 122 ms (257 MiB/s)
> 148323 bytes read in 30 ms (4.7 MiB/s)
> Working FDT set to 12000000
> Trying kaslrseed command... Info: Unknown command can be safely ignored
> since kaslrseed does not apply to all boards.
> Unknown command 'kaslrseed' - try 'help'
> ## Loading init Ramdisk from Legacy Image at 12180000 ...
>    Image Name:   uInitrd
>    Image Type:   AArch64 Linux RAMDisk Image (gzip compressed)
>    Data Size:    26510237 Bytes = 25.3 MiB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at 12000000
>    Booting using the fdt blob at 0x12000000
> Working FDT set to 12000000
>    Loading Ramdisk to eb58f000, end eced739d ... OK
>    Loading Device Tree to 00000000eb502000, end 00000000eb58efff ... OK
> Working FDT set to eb502000
>
> Starting kernel ...
>
> "Synchronous Abort" handler, esr 0x96000004, far 0x96142b896930b907
> elr: 0000000000a8d3b8 lr : 0000000000a77450 (reloc)
> elr: 00000000effa13b8 lr : 00000000eff8b450
> x0 : 96142b896930b907 x1 : 00000000effab870
> x2 : 0000000000000010 x3 : 00000000edf47310
> x4 : 0000000000000000 x5 : 96142b896930b907
> x6 : 0000000000000007 x7 : 0000000000000004
> x8 : 0000000000000040 x9 : fffffffffffffff0
> x10: 00000000eb526fff x11: 00000000edf3a808
> x12: 0000000000000006 x13: 00000000eb502000
> x14: 00000000ffffffff x15: 00000000ededb588
> x16: 00000000eff68738 x17: 0000000000000000
> x18: 00000000edef4d70 x19: 00000000eceb4040
> x20: 00000000eff14f50 x21: 00000000eceac000
> x22: 00000000effcc000 x23: 0000000000000001
> x24: 0000000000000001 x25: 0000000000200000
> x26: 00000000edf385c0 x27: 00000000eced8000
> x28: 00000000eced9000 x29: 00000000ededb3c0
>
> Code: eb04005f 54000061 52800000 14000006 (386468a3)
> Resetting CPU ...
>
> [1] bdinfo for success boot
> => bdinfo
> boot_params = 0x0000000000000000
> DRAM bank   = 0x0000000000000000
> -> start    = 0x0000000000200000
> -> size     = 0x00000000efe00000
> DRAM bank   = 0x0000000000000001
> -> start    = 0x00000001f0000000
> -> size     = 0x0000000010000000
> flashstart  = 0x0000000000000000
> flashsize   = 0x0000000000000000
> flashoffset = 0x0000000000000000
> baudrate    = 1500000 bps
> relocaddr   = 0x00000000eff14000
> reloc off   = 0x00000000ef514000
> Build       = 64-bit
> current eth = unknown
> eth-1addr   = (not set)
> IP addr     = <NULL>
> fdt_blob    = 0x00000000ededcd80
> new_fdt     = 0x00000000ededcd80
> fdt_size    = 0x0000000000017fa0
> lmb_dump_all:
>  memory.cnt = 0x2 / max = 0x10
>  memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes flags: 0
>  memory[1]      [0x1f0000000-0x1ffffffff], 0x10000000 bytes flags: 0
>  reserved.cnt = 0x2 / max = 0x10
>  reserved[0]    [0xeced8000-0xefffffff], 0x03128000 bytes flags: 0
>  reserved[1]    [0x1f0000000-0x1ffffffff], 0x10000000 bytes flags: 0
> devicetree  = separate
> serial addr = 0x00000000feb50000
>  width      = 0x0000000000000004
>  shift      = 0x0000000000000002
>  offset     = 0x0000000000000000
>  clock      = 0x00000000016e3600
> arch_number = 0x0000000000000000
> TLB addr    = 0x00000000efff0000
> irq_sp      = 0x00000000ededcd70
> sp start    = 0x00000000ededcd70
> Early malloc usage: 2440 / 10000
> =>
>
>
> [2] bdinfo for boot failed case;
> => bdinfo
> boot_params = 0x0000000000000000
> DRAM bank   = 0x0000000000000000
> -> start    = 0x0000000000200000
> -> size     = 0x00000000efe00000
> DRAM bank   = 0x0000000000000001
> -> start    = 0x00000001f0000000
> -> size     = 0x0000000010000000
> flashstart  = 0x0000000000000000
> flashsize   = 0x0000000000000000
> flashoffset = 0x0000000000000000
> baudrate    = 1500000 bps
> relocaddr   = 0x00000000eff14000
> reloc off   = 0x00000000ef514000
> Build       = 64-bit
> current eth = unknown
> eth-1addr   = (not set)
> IP addr     = <NULL>
> fdt_blob    = 0x00000000ededc1b0
> lmb_dump_all:
>  memory.count = 0x1
>  memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes flags: none
>  reserved.count = 0x1
>  reserved[0]    [0xeced81a0-0xefffffff], 0x03127e60 bytes flags:
> no-overwrite
> devicetree  = separate
> serial addr = 0x00000000feb50000
>  width      = 0x0000000000000004
>  shift      = 0x0000000000000002
>  offset     = 0x0000000000000000
>  clock      = 0x00000000016e3600
> arch_number = 0x0000000000000000
> TLB addr    = 0x00000000efff0000
> irq_sp      = 0x00000000ededc1a0
> sp start    = 0x00000000ededc1a0
> Early malloc usage: 2440 / 10000

With the LMB series applied, the memory region covered by the DRAM
Bank 1 is not getting added to the LMB memory map. And I suspect that
the scripts are using addresses in the bank 1 to load and boot the
kernel. Can you confirm this ? This seems to be happening because of
the value of gd->ram_top that is being set for the rockchip boards.
Based on a cursory look at arch/arm/mach-rockchip/sdram.c, the value
of gd->ram_top is capped at 0xf0000000 for the rk3588 boards. Can you
confirm if this is indeed the case ? If so, the second DRAM bank will
not get added to the LMB memory map, and consequently you will not be
able to load images to addresses in this bank. To fix this, the value
of gd->ram_top will have to be changed for the rockchip boards to
reflect the presence of memory above 4GB. Another possible solution is
to use addresses in the bank0 for booting the images.

-sughosh

> 2.34.1
>
