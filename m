Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D23CD11DD
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 15:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA1B087D6B;
	Tue, 26 Mar 2024 16:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="glay4vaL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D69B87E47; Tue, 26 Mar 2024 16:18:02 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1403287BD6
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 16:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.gmeiner@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e73e8bdea2so4659352b3a.0
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711466277; x=1712071077; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yq2NE+3S/XHi5r17wvBkwLvKN6aT9ohOvX3WDIAddNg=;
 b=glay4vaLTunJk79RhyPVVFT/TEq1mBd+U6wdPH4B4acHO9AzmMjmGd+vbFGsznlz/v
 LQXzeIMajx8uX1EQgo4PE6LoGa46K28JPIM1SeOVFTwCbxNfyAWvygaWAYn3Lg/z2p5j
 Q07hC+xARE962pwKI2g3mfSaCIKxuoGUmG9OK82F1UQLl8pSJp+iX2Kc3VTU8Kxdxe0z
 Hb3tpDI/fUEkjqn23S1JzeUBDpSKVF9dNlRHsL9MvuGcRVawj6Tk8jgdFno7qri0RzQb
 Cv/VgS0u0Wv8rZKHdG7pAQs3I0QtFOGsQMtafgoDV1RP7BGC1zmtizMLJwsNZ7hMEHQt
 1F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711466277; x=1712071077;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yq2NE+3S/XHi5r17wvBkwLvKN6aT9ohOvX3WDIAddNg=;
 b=L7gO5IPo7iARP1zlF9bDeHuyKWH3S5Ttk9Zabu39SSL016MVwIOYMBk+ICWeAAf1wq
 ve4xB7IhXmx5+Kkdfwnw3cgl9rDSVqMZyMxRfH/lk3qdBKWrnDOKLQH+rZdrUGZCt7ZQ
 sQHZZMOuvGSTmfo8GYAv+4Lsc8fpVrW94OETtLHbCNM+/aQ2KShXuQFHWuyTnuB2rOf7
 eUXCyZjUPKS4fgy0YhD8ba/jFnhZNtHt3b1pGb+/Erom7qYlpmhIgoWoE/oERUndktnW
 Uq+9PwjykDxO0IgDcqUEoAoLwq+pRiHqqB41XozLXhPtgd59nhcFUkIbyVzCeNYqX6Fl
 282Q==
X-Gm-Message-State: AOJu0Yx2aLksHELPX1WJ29wgr73PxxWqMfZyMcgDkvgfnoJERs6WlQEW
 ZLMFLDOx1W6QvfPpbbb+Lw1KFPweau3WVp773a0Ky2voaXsjilTj1sJbhEEra9of7lcxnuJ1ivn
 TuZqZdr7USzyKScRB8NfzxEy+HC5EvHLk1018sQ==
X-Google-Smtp-Source: AGHT+IGCz9EPqt7JkUapFMUcTO9RlM70kaR2cVmoq00AR2ASERw3rjJP5/MLjKcxikwDSt1M1HsHV6xJEn7L8K0KCZc=
X-Received: by 2002:a17:90a:6be2:b0:2a0:8f31:a359 with SMTP id
 w89-20020a17090a6be200b002a08f31a359mr101240pjj.39.1711466276926; Tue, 26 Mar
 2024 08:17:56 -0700 (PDT)
MIME-Version: 1.0
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Tue, 26 Mar 2024 16:17:45 +0100
Message-ID: <CAH9NwWe1qEo5r0UmdRh9CqFxmJYfHRU1YxoW8b8vTQwDB-227A@mail.gmail.com>
Subject: mx6cuboxi: failes to detect model
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: jonas@kwiboo.se, Fabio Estevam <festevam@gmail.com>, josua@solid-run.com, 
 Simon Glass <sjg@chromium.org>
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

I am seeing model detection problems with the current git master.

U-Boot 2024.04-rc5 (Mar 26 2024 - 15:59:22 +0100)

CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
CPU:   Extended Commercial temperature grade (-20C to 105C) at 26C
Reset cause: POR
Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
gpio@20a4000: set_dir_flags: error: gpio GPIO3_8 not reserved
gpio@20a4000: get_value: error: gpio GPIO3_8 not reserved
gpio@20a8000: set_dir_flags: error: gpio GPIO4_4 not reserved
gpio@20a8000: get_value: error: gpio GPIO4_4 not reserved
gpio@20b0000: set_dir_flags: error: gpio GPIO6_9 not reserved
gpio@20b0000: get_value: error: gpio GPIO6_9 not reserved
Board: MX6 HummingBoard
DRAM:  2 GiB
Core:  82 devices, 17 uclasses, devicetree: fit
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... *** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   eth0: ethernet@2188000


I did a git bisect to find the commit that broke model detection:

# good: [4459ed60cb1e0562bc5b40405e2b4b9bbf766d57] Prepare v2023.10
git bisect good 4459ed60cb1e0562bc5b40405e2b4b9bbf766d57
# bad: [873791433602281ed230486606e326983c97a285] Merge
https://source.denx.de/u-boot/custodians/u-boot-riscv
git bisect bad 873791433602281ed230486606e326983c97a285
# bad: [6e0a75d3162a024cb0cdedd871d435e6ee782447] configs: Resync with
savedefconfig
git bisect bad 6e0a75d3162a024cb0cdedd871d435e6ee782447
# good: [99b46477e3495f819f6826d11470d46f12a4f9f7] clk: Dont return
error when assigned-clocks is empty or missing
git bisect good 99b46477e3495f819f6826d11470d46f12a4f9f7
# bad: [50fa67d091b6ffbc1d77d3100d7b31795bf64928] arm: mach-k3:
j721e_init: Move clk_k3 probe before loading TIFS
git bisect bad 50fa67d091b6ffbc1d77d3100d7b31795bf64928
# bad: [827cece3aa550d41e9c08c640b3a73372c8fb14a] pinctrl: renesas:
Synchronize R8A77980 V3H PFC tables with Linux 6.5.3
git bisect bad 827cece3aa550d41e9c08c640b3a73372c8fb14a
# good: [623b3e8f9718a1fbd612b3e42451859e9f98a947] x86: spl: Change
the condition for copying U-Boot to RAM
git bisect good 623b3e8f9718a1fbd612b3e42451859e9f98a947
# good: [ad57b98e212bd15492398cea3a8d4df6297e16fd] x86: doc: Split out
manual booting into its own file
git bisect good ad57b98e212bd15492398cea3a8d4df6297e16fd
# bad: [6d53b50888315252cdd3251551add7a9108a1300] ARM: renesas: Enable
DM_ETH_PHY on 64-bit R-Car boards
git bisect bad 6d53b50888315252cdd3251551add7a9108a1300
# bad: [283dcb63cb7d124fa427938f39aa9362872e02fc] buildman: Show
progress when regenerating the board.cfg file
git bisect bad 283dcb63cb7d124fa427938f39aa9362872e02fc
# bad: [9e644284ab812f2db23f6185af77c0e771b0be73] dm: core: Report
bootph-pre-ram/sram node as pre-reloc after relocation
git bisect bad 9e644284ab812f2db23f6185af77c0e771b0be73
# good: [b05a184379631d13c4a49e423aa1324dc1ae6158] Merge tag
'x86-pull-20230922' of
https://source.denx.de/u-boot/custodians/u-boot-x86 into next
git bisect good b05a184379631d13c4a49e423aa1324dc1ae6158
# first bad commit: [9e644284ab812f2db23f6185af77c0e771b0be73] dm:
core: Report bootph-pre-ram/sram node as pre-reloc after relocation

If I revert 9e644284ab812f2db23f6185af77c0e771b0be73 on top of git
master everything is fine again. As I am not an export in that area I
am seeking
some directions on how to fix this issue.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
