Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E1606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Uz32e5bK;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=kHKWOPuv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6127180D99;
	Wed,  4 Nov 2026 05:25:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5zooqS2LRZI; Wed,  4 Nov 2026 05:25:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4DFC180BEA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793769958;
	b=kkpszA9SYsXmXkHop7Ms/ZGQ7vp2WVo+szCQeAtmAziYf7rhoTa3390+IiDCq3c8Ek80
	 EvU5qj3bz7gZAb5TF/J74WNY9Nhe6WWqturGW62j2UcfOV/BicW7qVbiPC17k08WMyWQ/
	 PmxY0PozM1/9XIMjMK01LBMMSdNvMcqSgZYS621y761yZAvlJwuXO6Xui3kh2hgxgCaO8
	 5nTGRSOA/GBagQEyZBqY2a2NYPyifsCjHq1edTqDLRZgotHs08bVSn8YZgA5947EOO/iW
	 7x4Yx0qSbYgfLUdnUyhE5JgxmQLfOhuyyP1rgJXP1148NuKiTZt272V5tXlRUkvljlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793769958;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eU1KaEjs+hwKK4im5b39JdDhbEtbebqoRLeeG65ySpk=;
	b=OSH1TtyCy7vgj+tCgqhYLCDabrzVOaldjtXtPmmfs8c7+gcHdoRX4DgZzD+UkITI9Zzi
	 zFOg13HcVEMicomtWrPtTzwtClc01CzV8/OA3QYpgzTEyHMldksbrgbGVoWTkXm6uHNQq
	 bBCRD+hcLP5ymPmbh2I7NfzzVC7rYptqiKRRoK2/YPj2RQp/u8VjpGRWvlHJPNwUXKirY
	 8z2bA9knRF7m3N95u0d06LtQ3tIk51X7alyrZXMRKTDE8Mr3OzaFgNzIMq4509eUT1YCI
	 hFnnG1qjAOU2SMJdaARkUBMrntwr7KEV13aEyNRNl5KMuxRpPPBVYHHwBDQsa5G48Fg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793769958;
	bh=eU1KaEjs+hwKK4im5b39JdDhbEtbebqoRLeeG65ySpk=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Uz32e5bK9ZRKYGwgHVrxdQayRtMJnmlI/YxVYYYj5DYpQIGGIGPzY9+ATZF5eB/L5
	 UNzXq1ThAy1a7xawrSRezcdSOrPR9YlXCCiRxgVqHwnHcj3oFelcJPMm9VDwfg4lsG
	 v/50rH26iZjJIjq2zmgUTK3GD8j6LC4/xlErLM6uXyPxXKZceKSm9hz6Z1t206c9IM
	 a7aunj0ZFBesrxlO+z5V9mIPEPlZyVEwvrDYCMxl/A7g9FZOqgTmonhQ9ScepykZls
	 RdNrS+pKxjdEHvAAHi7WKfCttY47LLznXa2gw4X2XqwNiady+N0ZOrD7NKwG7DnKtS
	 of1lvlAvCKJbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DFC180BEA;
	Wed,  4 Nov 2026 05:25:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 163B9341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF26860698
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:25:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xFM1Mb2uSKrW for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 05:25:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 830A06067D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793769956;
 b=bppsQZn99IHQXdWCGo5XroxxextwVRLpv8SfDlv47pv0q9ddJF6dySK8rDkFrcVjJfXx
 BoO1bGWTecTPxB5LXdn+B0Oo4mjzuSgmohFt7HqObcfamqX7fdBzqceYHH0KZBRoORKcy
 e91tWE40Ar63SHKTBu+f1jNQtbExa1stfKsXyqU2CcSm2kv6fksG9ppnLovSHumzl3RpY
 EC9AvhKgk6znsiI5WZwIgq8JKIipWgrtQCLIdK5bYXSAS9pzIbPDAHBP5Wso18X4ac+us
 I0lAGH9T66ejYdZsv+jJKppab5spwa6UircnbLt3j32APVzajSvRGUnHW3qwdCanPxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793769956;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
 bh=eU1KaEjs+hwKK4im5b39JdDhbEtbebqoRLeeG65ySpk=;
 b=mqZvmynImcb7+Oz5Q3Y7w97X+j6D4okn12bNScpOMlIkih8wMYZFDtJswGMKUWShwkd7
 Pmon4MMQMIrw/bKy0Z5wAG8Oq2ykbB2qYVc81ArM+3kYjrn0BMtcHhc8KMrOaxPFHp97R
 1m9Znmao9LccTBhb3O3gGgJ/t+IQa2vKm+WF7/kF5uNc8xo8RyCBT+3wXNBahHIcYYqL6
 j2I92eTZFwPSqolTo7I3ef9pI7aWtEBVKub7RcUHAHWxIdV+WqdMy7GyFT1kUn/zTSw/q
 xsYjF8Ap5dPBXDGmbuCKFc2OMwS27D0ocqDObL8ps8AN8VJ+qXJTzhUta5tVOSIBe5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=kHKWOPuv; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=kHKWOPuv
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 830A06067D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:25:54 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3b07db03f41so224719a91.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 21:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793769954; x=1794374754;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eU1KaEjs+hwKK4im5b39JdDhbEtbebqoRLeeG65ySpk=;
 b=kHKWOPuvcpxB+FHI4WBxhf6s/jbO76daZCCcqF0j/aqhnfKClb5Tnw1goLF7lFWgTe
 GQwHfetMsO1zw5UPGcqt/QlBZ/g0pnc7xFAvutdT8JXt1KlaqVxCjEadF4iR6KS8CKvE
 R0j278kvaDz3GTQ/mfhavEWuzhTYMSWgxth4Ow7GPuD39elbW/eQXsVWiPJbNXI5sxvx
 t5byQG+akg0vssxpODOOKl/Ir3Chz1GfXGZ+vlNuSxiJ1DNusQcf9LiK9ALMhh4xPRA/
 N10c1o7kb95R1hawrMhs2v72RjKLxlda11r7kmIW9i1xe+gWJUmkp8jwNo8R4sLVZRil
 elvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793769954; x=1794374754;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eU1KaEjs+hwKK4im5b39JdDhbEtbebqoRLeeG65ySpk=;
 b=fi8hkKmkY6FHgRV8CckCtwkajqKPIzTLHi4bnuPFhF+w/F4OTPBspja+Y5tDKWFih+
 Ndj+djVuAW8+QPe/m+v7AmEAPHwB6vJ3EGnf/cKLCyHiJQPAFX40QEr6w21QjY/tWHVr
 4wWvKLCFAR0BnNq8gWjwP7J93f0YM77DJjQtjEH0mK9gr//soCVRT4zQWLMVVbYytmS4
 zlvaCW7BnWy0yXnM+E3eRUX+pfSmnnzKE2ujNVAzKzuzcIMmea+pSwel7psNZEVQ3jlc
 ChIu1mdfR96H6y1Viub/c2RWuYVI7eYDioVwGcHdqake98q7SPQP6RqNsVQxyph3q+XE
 D8Uw==
X-Gm-Message-State: APuU4Z/BHPhXr3Fjxm8Su3SIVSSaIQ2fnkppi/IY76EW2k6QyPm3hrVS
 wQOpqvAJ9nltLcvLuwOHXkG6RPzfiOaQJR5PkO7eC5Fg8OmmmqKrvyoOiJqOAadAS9A=
X-Gm-Gg: AYBFou3HB8oACJz/6OZF1eQK3aarjWGPyH5QioqXrHklhRcbTYIOsfSb0q51YyAhbCb
 b4SH8Zrvg+/kvsGawwiqLNUvxT5IeswVo7wnlK2hN5O570AsBJ1uOVDmOyyK662JTHV9QcDNzwZ
 Iy6DKbMOLWTpR+TqJG0ezn0A1XkFoYqfLKLvJjpFZUz2ebAncn/MW/O+xaX5HmwVY2aJIcWPfff
 kY2EX5yqjZJRpWRnoVoOkLIVXJheSApjbEOUfANh4XemBasNCM77LWahctKwyfgcu/OJ81gGuFu
 3WgKcgpN2CzCtd3k/xRDKXzmpAjQ/s9+b9laos+wdHOnfKZGmKCUh5eC4wVLWydUtLnJ5dmD3ff
 tCeihmzF3j9lrTH++zbH7R+ovczOVXgHlzNdcikS0jQVQaes5gxizaJ7MBjjBRQ1653BtIyOLg4
 mvBrOhF8n/Gc9coaanlzRe0cdIAtpkBNgHjAddt7xozCEYlpe1IEZaU7LRdZhXUy8FOA2O2BL7j
 M9wZ2b30UD3ojRs8gIxMM8FBksgVDGcXR2OL3CSNmus5B03Vv14R3k3/J8EKGMkQ7aevRf7Mn8m
 s4rpvfVWqhWmwCqg2BKa+R4I2MfkufdDq/zxbpygLa/O
X-Received: by 2002:a17:90b:4a83:b0:3ad:b86d:dbad with SMTP id
 98e67ed59e1d1-3ae89747e27mr12102122a91.30.1793769954174; 
 Tue, 03 Nov 2026 21:25:54 -0800 (PST)
Received: from lliang-1876.localdomain ([136.226.240.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b093c499a5sm2344440a91.2.2026.11.03.21.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 21:25:53 -0800 (PST)
Date: Wed, 4 Nov 2026 13:25:47 +0800
From: Leo Liang <leo.liang@sifive.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, tim609@andestech.com,
 alan.tseng.cs@gmail.com, e@freeshell.de, randolph@andestech.com,
 junhui.liu@pigmoral.tech, zhuxu_ran@zohomail.com,
 hfranco@baylibre.com, DaveWK225@protonmail.com,
 bin.meng@processmission.com, anton@espressif.com,
 asrinivasan@oss.tenstorrent.com
Subject: [GIT PULL] u-boot-riscv/main
Message-ID: <aurB2zRSuOllUiRw@lliang-1876.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

The following changes since commit ab4dc5aacf957835c295b59ef2dd28281839cb20:

  Merge patch series "Misc Fixes for VGA BIOS Emulation" (2026-11-02 14:12:57 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git main

for you to fetch changes up to e6308cc144db417258e608b6102e3190aa9ab505:

  spacemit: k1: drop the CS1 DRAM map on single-rank boards (2026-11-03 18:23:12 -0800)

CI result shows no issue: https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv/-/pipelines/1832
----------------------------------------------------------------
- Features:
  - iommu: Add RISC-V IOMMU driver
  - configs: starfive: enable mtdparts on visionfive2
  - board: sophgo: milkv_duo: enable standard boot
  - riscv: andes: add L2 cache flush support
  - riscv: qemu: Boot a kernel passed with -kernel
  - rtc: cv1800b: Use the RTC node for time and system reset
- Fixes:
  - riscv: restore ILP32 size types on RV32
  - board: microchip: mpfs_generic: Allow serial number read failures
  - riscv: spacemit: handle overlapping DDR firmware relocation
  - board: sophgo: milkv_duo_256m: fix fdtfile quoting
  - configs: k1: enable GigaDevice SPI NOR flash support
  - configs: spacemit_k1: Enable onboard USB hub support
  - spacemit: k1: drop the CS1 DRAM map on single-rank boards
  - bootm: Relocate RISC-V Linux Images before booting
----------------------------------------------------------------
Anirudh Srinivasan (1):
      iommu: Add RISC-V IOMMU driver

Anton Maklakov (1):
      riscv: restore ILP32 size types on RV32

Bin Meng (1):
      board: microchip: mpfs_generic: Allow serial number read failures

Dave Klotz (1):
      riscv: spacemit: handle overlapping DDR firmware relocation

E Shattow (1):
      configs: starfive: enable mtdparts on visionfive2

Hiago De Franco (4):
      board: sophgo: milkv_duo_256m: fix fdtfile quoting
      board: sophgo: milkv_duo: add environment for standard boot
      configs: milkv_duo: enable BOOTSTD_DEFAULTS
      configs: milkv_duo: reduce CONFIG_STACK_SIZE to 1MB

Hung-Chun Tseng (7):
      cmd: Enable qfw by default on QEMU RISC-V
      riscv: qemu: Do not disable initrd relocation
      riscv: qemu: Switch to standard boot
      doc: qemu-riscv: Describe booting a kernel through fw_cfg
      configs: k1: enable GigaDevice SPI NOR flash support
      spacemit: k1: initialise the EEPROM index in read_ddr_info()
      spacemit: k1: drop the CS1 DRAM map on single-rank boards

Junhui Liu (1):
      bootm: Relocate RISC-V Linux Images before booting

Randolph Lin (4):
      dm: cache: Add flush_all operation
      cache: andes-l2: implement flush_all
      riscv: andes: flush the L2 cache in flush_dcache_all()
      riscv: andes: probe the L2 cache device in U-Boot proper

Zhuxu Ran (3):
      rtc: cv1800b: Add seconds counter support
      riscv: sophgo: Enable RTC-backed system reset
      sysreset: cv1800b: Use the RTC device node for register access

 arch/riscv/cpu/andes/cache.c                   |  19 +++++
 arch/riscv/include/asm/posix_types.h           |   9 +-
 board/emulation/qemu-riscv/qemu-riscv.env      |  15 ++++
 board/microchip/mpfs_generic/mpfs_generic.c    |  11 ++-
 board/sophgo/milkv_duo/board.c                 |   5 --
 board/sophgo/milkv_duo/milkv_duo.env           |   8 ++
 board/sophgo/milkv_duo_256m/milkv_duo_256m.env |   2 +-
 board/spacemit/k1/spl.c                        |  12 ++-
 boot/bootm.c                                   |   6 +-
 cmd/Kconfig                                    |   2 +-
 configs/milkv_duo_256m_defconfig               |   2 +
 configs/milkv_duo_defconfig                    |  14 ++--
 configs/qemu-riscv32_defconfig                 |   2 +-
 configs/qemu-riscv32_smode_defconfig           |   2 +-
 configs/qemu-riscv32_spl_defconfig             |   3 +-
 configs/qemu-riscv64_defconfig                 |   2 +-
 configs/qemu-riscv64_smode_defconfig           |   2 +-
 configs/qemu-riscv64_spl_defconfig             |   3 +-
 configs/sipeed_licheerv_nano_defconfig         |   2 +
 configs/spacemit_k1_defconfig                  |   1 +
 configs/starfive_visionfive2_defconfig         |   4 +
 doc/board/emulation/qemu-riscv.rst             |  12 +++
 drivers/cache/cache-andes-l2.c                 |  16 +++-
 drivers/cache/cache-uclass.c                   |  10 +++
 drivers/iommu/Kconfig                          |   8 ++
 drivers/iommu/Makefile                         |   1 +
 drivers/iommu/riscv_iommu.c                    |  82 ++++++++++++++++++
 drivers/rtc/Kconfig                            |   9 ++
 drivers/rtc/Makefile                           |   1 +
 drivers/rtc/cv1800b.c                          | 110 +++++++++++++++++++++++++
 drivers/sysreset/Kconfig                       |   6 +-
 drivers/sysreset/sysreset_cv1800b.c            |  72 +++++++++-------
 include/cache.h                                |  16 ++++
 include/configs/qemu-riscv.h                   |  27 ------
 34 files changed, 407 insertions(+), 89 deletions(-)
 create mode 100644 board/emulation/qemu-riscv/qemu-riscv.env
 create mode 100644 board/sophgo/milkv_duo/milkv_duo.env
 create mode 100644 drivers/iommu/riscv_iommu.c
 create mode 100644 drivers/rtc/cv1800b.c

 Best regards,
 Leo
