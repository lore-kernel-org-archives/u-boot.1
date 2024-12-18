Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E12E77183
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 07:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B078021A;
	Wed, 18 Dec 2024 08:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="baoMvzBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7DDD8021D; Wed, 18 Dec 2024 08:03:00 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C50280214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso3159923f8f.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 23:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734505377; x=1735110177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LF2xCYzmyFX2OXJ+6gebMv1VlRfqiv63i00eut/eOYs=;
 b=baoMvzBdMUMBXBS8FgM6z9dEQgorjtl0KXelopgpvMlEX1JTtF/qZqWtw0jBCJQsxs
 9mWXnsvJ43wzsI042rPFfb57bRuEpP2j3A+4URf/lN3yHV2sZJ1r+gajd/kPcf7SEucm
 +4FhbcIPK4xXyD23bEmT09H6vPlHjMqLa59orj9UwpYnjZEpNzte9DBkb3gUGm+eLkfP
 z62VMFHGdV03OfkF531ZEFZrsvloZ56OfB8HdcLpDRYqyBYFRvLhPmZ0jX8DGRlEsy4h
 jGUzjvgDTZQcIaVWG7UXk7MUY5bp1GOBy5Fv9yjl3NHWU9x5Mlp2CMOioyvKA0QBsX+6
 C40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734505377; x=1735110177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LF2xCYzmyFX2OXJ+6gebMv1VlRfqiv63i00eut/eOYs=;
 b=ISlrbuC4aHUSiLz2mLRE0G64G2uevauyV2W6EARdFCkDe0NRfQEhqyz1ZhV2oVWOks
 HL15MJ/cgsK6MQlG/Luq5kJXrVKsmF1y8jnaWNXcCgkvODV62K2ZdRL0EbBIJUqorO84
 oHbCQFYK7S1mzzGR/MJXKSbsMLWQtPoW+4TtBQE2XsSzbs7ytr3hUhg8gSfJfCe5tp5H
 jgjXbK/sF8IrgtR5qxew3mmnKI2CjCjfzst3F6gF5BZpKNndHpk4g02Ukq0qcwHw6WhZ
 WEmFPOx0MV0yEGoFiFcPAZNhclG8c4FRXFx0ZgqH1WHbmk7UaqdMMpDOFC3Av0eQfrLE
 sLDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYCp9H7duiZ9RadSGDZ1tHd6OG/zb6LUpd1lqcaUJ+0WysEegVRawz6gGQr/rtVh4hy47ssYA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5XTyQ1HTeJkcZlHq8hsKphKgOl+TLvn2nuI921BFfUMkQixWT
 0QuKmvbNVL7CeQYV1uV0apUfcTDbrhr7vOKJ0MNtBG9FTn+9gofSViDEhxlmBOk=
X-Gm-Gg: ASbGncsFw9wwZgn9K+5gVdZwCoRF5wb4nD0Dd6QidneJpYa9DhCNHruEg0HwUFE5w5h
 JmMgP0UMGe3hESA5uwObb4bDbnws2omGOQaYYlXktAXwFuNn9NSV8Vz0yCfDXfbb8lMCy+fRwIB
 EiqGBwYPAJXpdSyLuXyre73N/VgkN3bYPfrYjQYoOKEdvGMAUSWb/kYM8hV7/mYixC5pBfzJJbg
 8L2Tvc5SFEdooTzHfHrwULnIwC/sRmVSBr04rF974pwN9UYeMy9ZYiKx3jBpaUTf0FDuuNlelYx
 XY/GQp58I5N7WYYc+fuycB1wN0wgz1uQAg==
X-Google-Smtp-Source: AGHT+IGCeZt5Wlqgq4wupU2Tm0fSCEBWTlibAhzm/uGbvDvy9sItEFGyiYKFkrV/yE2JVvN/670bTg==
X-Received: by 2002:a05:6000:186f:b0:385:f69a:7e5f with SMTP id
 ffacd0b85a97d-388e4d8df8bmr1281789f8f.38.1734505377334; 
 Tue, 17 Dec 2024 23:02:57 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060592sm12971612f8f.98.2024.12.17.23.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:02:56 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Michael Walle <mwalle@kernel.org>, Peter Korsgaard <peter@korsgaard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Baruch Siach <baruch@tkos.co.il>, Nam Cao <namcao@linutronix.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 0/8] Cleanup the LMB subsystem
Date: Wed, 18 Dec 2024 09:02:29 +0200
Message-ID: <20241218070251.686383-1-ilias.apalodimas@linaro.org>
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

Hi all,

This is v2 of the rfc [0]

The LMB subsystem was used opportunistically for a number of years.
A while back Sughosh merged it with the EFI subsystem in order to have a
common allocator and avoid subsystems overwriting memory they shouldn't.

This is an initial cleanup of all the crud we gathered over the years.
There's no functional change expected from the patches as they just cleanup
some abstraction functions and rename a few variables to make more
sense.

I plan to make even bigger changes -- e.g I don't see the point of
having *_alloc() and *_reserve() versions of the functions since they
do the same thing and just cause confusion. lmb_alloc_addr_flags()
returning the base address on success makes little sense since we
already *request* the address on the function arguments, etc.
Since this patchset grew enough already, I'd like to get it in
before more refactoring happens.

It's worth noting that although some patches slightly increase the code
size due to an extra flags argument being carried around, the final
result is eventually smaller.

# qemu_arm64_lwip_defconfig (version string adds another 20b)
add/remove: 0/5 grow/shrink: 15/1 up/down: 568/-628 (-60)
Function                                     old     new   delta
lmb_alloc_base                                80     324    +244
lmb_alloc_addr                                 8     144    +136
lmb_reserve                                    8      96     +88
version_string                                50      70     +20
boot_relocate_fdt                            488     508     +20
boot_ramdisk_high                            268     284     +16
lmb_add_region_flags                         696     704      +8
boot_fdt_reserve_region                      100     108      +8
load_serial                                  548     552      +4
lmb_alloc                                      8      12      +4
image_setup_libfdt                           368     372      +4
do_load                                      728     732      +4
do_bootz                                     332     336      +4
do_booti                                     520     524      +4
bootm_run_states                            2176    2180      +4
lmb_alloc_addr_flags                           4       -      -4
boot_fdt_add_mem_rsv_regions                 284     280      -4
lmb_alloc_base_flags                          76       -     -76
lmb_reserve_flags                             96       -     -96
_lmb_alloc_addr                              144       -    -144
_lmb_alloc_base                              304       -    -304
Total: Before=1020102, After=1020042, chg -0.01%

# sandbox_defconfig (version string adds another 20b)
add/remove: 0/3 grow/shrink: 24/3 up/down: 523/-501 (22)
Function                                     old     new   delta
lmb_alloc_base                                48     299    +251
lmb_alloc_addr                                 4      92     +88
lmb_reserve                                    4      58     +54
test_alloc_addr                             2933    2963     +30
version_string                                50      70     +20
lib_test_lmb_overlapping_reserve            1018    1030     +12
lmb_add_region_flags                         600     610     +10
test_multi_alloc.constprop                  3034    3042      +8
test_get_unreserved_size                    1032    1038      +6
boot_relocate_fdt                            599     605      +6
boot_fdt_reserve_region                       67      73      +6
lmb_alloc                                      4       9      +5
lmb_free_flags                               190     194      +4
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
lmb_dump_region.lto_priv                     356     353      -3
lmb_add                                       59      52      -7
efi_allocate_pages.part                      303     249     -54
lmb_reserve_flags                             65       -     -65
_lmb_alloc_addr.lto_priv                      92       -     -92
_lmb_alloc_base.lto_priv                     280       -    -280
Total: Before=2492722, After=2492744, chg +0.00%

[0] https://lore.kernel.org/u-boot/20241208105223.2821049-1-ilias.apalodimas@linaro.org/T/#m43927af3f758f8d0be897a8a6c77b4325546afd5

Changes since v1:
- Picked up r-b and t-b tags
- Fixed comments for LMB_NONE etc so doc generation works properly

Changes since RFC:
- Rebased on top of
  https://lore.kernel.org/u-boot/20241211021703.2333-1-semen.protsenko@linaro.org/
  https://lore.kernel.org/u-boot/20241211022550.2995-1-semen.protsenko@linaro.org/
- Converted enum lmb_flags to a u32
- Removed the _flags from all the functions
- Added a patch that removes lmb_align_down()
- Picked up r-b tags. Tom I kept your on patch #3 since I only changed the name
  of the function and assumed you are ok with it.

Ilias Apalodimas (8):
  lmb: Remove lmb_align_down()
  lmb: Move enum lmb_flags to a u32
  lmb: Remove lmb_reserve_flags()
  lmb: Rename free_mem to available_mem
  lmb: Remove lmb_add_region()
  lmb: Remove lmb_alloc_addr_flags()
  lmb: Remove lmb_alloc_base_flags()
  lmb: Rename _lmb_alloc_addr() to lmb_alloc_addr_flags()

 arch/powerpc/cpu/mpc85xx/mp.c |   2 +-
 arch/powerpc/lib/misc.c       |   2 +-
 boot/bootm.c                  |   3 +-
 boot/image-board.c            |  20 +++--
 boot/image-fdt.c              |  15 ++--
 cmd/booti.c                   |   2 +-
 cmd/bootz.c                   |   2 +-
 cmd/load.c                    |   2 +-
 fs/fs.c                       |   2 +-
 include/lmb.h                 |  60 ++++++---------
 lib/efi_loader/efi_memory.c   |   6 +-
 lib/lmb.c                     | 136 +++++++++++-----------------------
 test/cmd/bdinfo.c             |   4 +-
 test/lib/lmb.c                |  92 +++++++++++------------
 14 files changed, 147 insertions(+), 201 deletions(-)

--
2.45.2

