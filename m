Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92BFE7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 10:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B395189473;
	Sun,  8 Dec 2024 11:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SoKkbY5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A316893BF; Sun,  8 Dec 2024 11:52:42 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4035D89473
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 11:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa51bf95ce1so309821866b.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 02:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733655159; x=1734259959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DGqaZtKot5DdaOWponm3/Xm0ThoYrHMe5gk5fHKfcAo=;
 b=SoKkbY5u9+lxgZbLO0n2gBs3mB4U1fkDjANGbxEWYzc1ppeZpyOX8UbBAbD2HHzfkP
 tdzdUwWjF9pJr4wXqKcYL3hPImm7EsAUVJzr5VZ1raXXFrjgq/2IasrPikyuSDTA1I0q
 RJGeip2dh64q24r9MvpYo1/ndFnEijkIGsy5QULkYafPG7kUaRll5QLxC4L4IvD350z3
 xlnl4O+0QSK5UjKR+S1g5opLWZ5DZ86kAg3xzw1nIM8WWQ6q2HBFyiC8rcj/buGlHvNl
 s8C5tY7mABJkUmlb6l9xpH4FlfH90UkKsB2BwVisCK84VvW6SSp2QcOfn5zbiXr5/T6C
 553Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733655159; x=1734259959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DGqaZtKot5DdaOWponm3/Xm0ThoYrHMe5gk5fHKfcAo=;
 b=BCXOYo47LTKZMivXJARG0cACd0DL5w1XJvmUXxN5l4JhnZyqO+gJz2bSJp88hVq2Gx
 /seMq+OLKXYmH6sTKfJCkDWUprN4LCtXgIvPBY0YrcUND4lgPNpgJR9qKbzx4IF4vpEG
 zXZ8e6yygvI4ynItr+li8tGL7gbjrdomc28J2pb1+FRkIA4WDYCqH7d6E7VZUwygDdwo
 Coc9xnoSoGatOrA45jzka3JztWRyCB42li4FXlGR3VKwGs7FBiMIv86JgpS3u4B2bZyY
 jk3D8GkxFXEcnfilQX5ooeNecW/uk8ft81rTp/TEr+3+/1p3F5hbjnmvgnnEtBCFJMiL
 zE/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcxxl52RaV+ybjC4ZL/NmsDuPD5j6p/VW9tVwCXG22CTmorAkOFvhwhiJn1BGDvzoe6clFkFg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2rIova4MwJ7TaIuzzCe98TwGpawqy258t8N2agcCmTZUJX3Wo
 nU+xa25pk85YUrd4aT7PI6wMU77LxDJoQfe9a2anHDTzw1WrXZf6aTlWWwfol2Y=
X-Gm-Gg: ASbGncvC11067Hiq24X7eH46xX8Ek3WMFSsjlHa+XCFDujDD3yymkP8rVh9mXWmMRKl
 hhphWzwBv15AJt01zXdYFCq8Wc+CfLNFc6Q4K9UeFwj61KHIjdzXMdMe5t5jDcyepTwgZB/AXno
 BGyys5BNRgpuZmgNwtsuMFHzLYSnJAgfBh3AVSBISgJoSmX7lLo/bCKADh16L1WEg2iJP3x9sHM
 hZ3fZeYjhWO8v5T270oVG/AnUBdCGVm6Ej6qUZC/XpA7/sG661HFOSoDlwGsrV0fzc3ELv/R5e/
 UG35nOsYqRLH3kpJDHbTib3rgmg=
X-Google-Smtp-Source: AGHT+IF7J3MpcoQhHvUM533ViJHO8XPAshRXLDnHOj6xSgIo/d4rovUzkARIqO+muRJrqCNqVDKNxQ==
X-Received: by 2002:a17:907:774a:b0:aa6:7737:199c with SMTP id
 a640c23a62f3a-aa677373eccmr170688566b.15.1733655158514; 
 Sun, 08 Dec 2024 02:52:38 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e92fe3sm517768566b.51.2024.12.08.02.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 02:52:38 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Janne Grunau <j@jannau.net>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
Subject: [RFC PATCH 0/7] Cleanup the LMB subsystem
Date: Sun,  8 Dec 2024 12:52:03 +0200
Message-ID: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The LMB subsystem was used opportunistically for a number of years.
A while back Sughosh merged it with the EFI subsystem in order to have a
common allocator and avoid subsystems overwriting memory they shouldn't.

This is an initial cleanup of all the crud we gathered over the years.
There's no functional change expected from the patches as they just cleanup
some abstraction functions and rename a few variables to make more
sense.

This has to be rebased on top of Sam's [0] changes but that should be
trivial.

I plan to make even bigger changes -- e.g I don't see the point of
having *_alloc() and *_reserve() versions of the functions since they mostly
do the same thing and just cause confusion. lmb_alloc_addr_flags()
returning the base address on success makes little sense since we
already *request* the address on the function arguments, etc.
But since this patchset grew enough already, I'd like to get it in
before more refactoring happens.

It's worth noting that although some patches slightly increase the code
size due to an extra flags argument being carried around, the final
result is eventually smaller.

add/remove: 2/5 grow/shrink: 17/3 up/down: 479/-524 (-45)
Function                                     old     new   delta
lmb_alloc_base_flags                           -     299    +299
lmb_alloc_addr_flags                           -      90     +90
test_alloc_addr                             2933    2963     +30
lib_test_lmb_overlapping_reserve            1018    1030     +12
test_multi_alloc.constprop                  3034    3042      +8
test_get_unreserved_size                    1032    1038      +6
boot_relocate_fdt                            599     605      +6
lmb_alloc                                      4       9      +5
wget_handler                                1530    1533      +3
tftp_handler                                1190    1192      +2
test_noreserved                             1207    1209      +2
test_bigblock                                911     913      +2
load_serial                                  946     948      +2
lib_test_lmb_flags                          2101    2103      +2
do_spi_flash                                3150    3152      +2
do_bootz                                     526     528      +2
do_bootm_linux                              2067    2069      +2
bootm_run_states                            5275    5277      +2
_fs_read.lto_priv                            331     333      +2
lmb_reserve                                    4       -      -4
lmb_alloc_addr                                 4       -      -4
lmb_overlaps_region                           62      52     -10
lmb_add_region_flags                         600     568     -32
lmb_alloc_base                                48       -     -48
efi_allocate_pages.part                      303     249     -54
_lmb_alloc_addr.lto_priv                      92       -     -92
_lmb_alloc_base.lto_priv                     280       -    -280
Total: Before=2492742, After=2492697, chg -0.00%

[0] https://lore.kernel.org/u-boot/20241208002121.31887-1-semen.protsenko@linaro.org/


Ilias Apalodimas (7):
  lmb: Replace lmb_reserve() with lmb_reserve_flags()
  lmb: Simplify lmb_addrs_overlap()
  lmb: Rename free_mem to available_mem
  lmb: Remove lmb_add_region()
  lmb: Replace lmb_alloc_addr() with lmb_alloc_addr_flags()
  lmb: Replace lmb_alloc_base() with lmb_alloc_base_flags()
  lmb: Rename _lmb_alloc_addr_flags()

 arch/powerpc/cpu/mpc85xx/mp.c |   2 +-
 arch/powerpc/lib/misc.c       |   2 +-
 boot/bootm.c                  |   3 +-
 boot/image-board.c            |  24 +++++---
 boot/image-fdt.c              |  11 ++--
 cmd/booti.c                   |   2 +-
 cmd/bootz.c                   |   2 +-
 cmd/load.c                    |   2 +-
 fs/fs.c                       |   2 +-
 include/lmb.h                 |  11 ++--
 lib/lmb.c                     | 111 +++++++++++-----------------------
 test/cmd/bdinfo.c             |   2 +-
 test/lib/lmb.c                |  68 +++++++++++----------
 13 files changed, 105 insertions(+), 137 deletions(-)

--
2.45.2

