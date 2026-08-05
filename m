Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386BCC55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 18:21:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AD2A607CE;
	Wed,  5 Aug 2026 18:21:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aFR0Dlu780qt; Wed,  5 Aug 2026 18:21:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6436D60786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785954095;
	bh=tgkDdFLzrL2p3/mndvw7B4Zemsgk18mhf5j55zi7MC0=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=aiTUSu9Kk2mTwpmhdsXHwEsuqPKkMHhvmQ5tlLEjgoPrsumw6AlngygG+Xo7r/ghe
	 a44wazLfDhU3dzUPu6dzyFsMrHqswp0xZjannV1K/hC5AqRSHn4OUxiL07R8jHCqbv
	 Mk8uImpEY3bFMriYRALyZu+CNKElD4FhYOji8ll3+1HhfSEBZNW0d7s1DTmfdQ4caZ
	 rm+IKr+Y6EKZ900v474g4nfuyFBA8UtGTM27FfJORvkY28t3yimNbty1AUN8zElp7s
	 T6GAfyj+KMTMmMWdP3wiYHUiyiu8cs1A8YE+ysisY4Tu92PFKAiEvKAm9lFk9ppXY1
	 wJ+wAnbjhbpyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6436D60786;
	Wed,  5 Aug 2026 18:21:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 22C082B6
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 14B6F60786
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QHxe5164x2pk for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 18:21:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 014FC60653
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 014FC60653
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 014FC60653
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:21:32 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cea3004256so16919145ad.0
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 11:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785954092; x=1786558892;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tgkDdFLzrL2p3/mndvw7B4Zemsgk18mhf5j55zi7MC0=;
 b=ARpfe5/kUjpsISIu0axmK+d9qnKFVw9PG8fGf7YUBAr39tGgvz2I343rNpG4ij9CDr
 A8nNbCGK0M5XA6zsrOtTjirhYgbNQc5aHODOpEZgXfB5Z0HJvcR2l6IRCy0sOuUCE4pf
 qR3bLWWPIaLVsv+v9GMewF819zrNn2QbtX94xu/wcAZ4KtkrKko666oIKcnQCQ9cswki
 G7F2aZxjOu0vTpmmCOXQpLgyjQ+7nWSjBQt46ulLaVId7gnpuCanMnD1ebcjBR2PVpzl
 rPug8xPHFqN1fjL6f2C08JsEv9r7clonUPKytL43r2BrQuHKaumMVO7u3u0Hz2s+rB4D
 GWuA==
X-Gm-Message-State: AOJu0Yy5H6iRxqecRcKBsZOyampyDLXYl1Rz/baXyLh61U4xqaeeoKue
 s/td7dsRcsnjAFiPuC2M/U8MJaZjpeDGtjet3aBkjVShQm6H7lb8m/PEPd7cJpkNB10=
X-Gm-Gg: AR+sD125vxF6ui8nNEp+9Xa1Jm0/0s16qYVBVyo4XYNMWGVHM7eHnfKx/06T0TsBolD
 3qSK6I/1IsV8KjSoYPhedFkmYqF72a3RGJ4FHHewYRkt1VE4zpgs0VAXvw7JCgRShgS+kGApGhT
 WwJySAgl63AtDvwdua1B2zKLa8x/2EsyKpr8FjiGLbaZmiRwOi1lcKs4Y2KODrZtM6cPYEWrsUQ
 cMAG4COydUI1F5gCsLG/f0vKkSTsS0ZbOzss4p++i5t/JgrSY8R0VQuJPKHoMB8cU7T76jhS49O
 DSIJowAsf1SibdNZYj9JaHMwtgbmuoHxMLDivtCUm8knZx8gv6vxYI4oZEl8HEoRDhrAmIPRVBR
 D0F/Jt0PrPMZGDTu2t/TeNFPnJ1RpzJ7mHqDasXJj9OjwTKZ37s9oSjB1BqG6maox1eFS2Z7RvI
 DD38GnPuy93FDizVS/R0Eri+mD6qRE3TXXHVe0F+eW7KBPTGiir47myfU4fkmAcOrM5GwnJaaJR
 PbeoQ==
X-Received: by 2002:a17:902:e851:b0:2c9:de53:f84f with SMTP id
 d9443c01a7336-2d0ca9904acmr93747245ad.19.1785954091902; 
 Wed, 05 Aug 2026 11:21:31 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa491747sm19717955ad.39.2026.08.05.11.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 11:21:31 -0700 (PDT)
Date: Thu, 6 Aug 2026 02:21:25 +0800
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, tim609@andestech.com, me@ziyao.cc,
 hfranco@baylibre.com, jamie.gibbons@microchip.com
Subject: [GIT PULL] u-boot-riscv/main
Message-ID: <anN_JWh_JneoPUOa@lliang-1876.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785954092; x=1786558892;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tgkDdFLzrL2p3/mndvw7B4Zemsgk18mhf5j55zi7MC0=;
 b=ZfSIHmuQ7SsUgA40DEFH5lOSDbfRMkHvr0yRkmVGE5lWHLV2nzmsglWQ8i+/3E7dED
 j54R+VPhwPEiZjVyFLS/lf4bVu4d3msQBa6uT0LYS1bwOX+znvpx2ZPkPTjUSflvowPv
 Dx5chJSUL5KHPCNZI8BDgeZMxNEESdYqqymleMqzZjBI61oDqu+btqZGzJmIVXdnNNVx
 /lbIyPO+PahP02dqdwjzC+IOqzlObo1XPjNw5jOV8SEnWrYEfnCzdvhGHl8RLIJjoU1y
 shUwXvls5BChUHedJZL8r69m0UdzrCaCs4vsn/jFg2ilZmb8SFdKLzhSGM/ISYL8qMuL
 FIcA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=ZfSIHmuQ
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:

  Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git main

for you to fetch changes up to 98b59e181daa6c26d49f870fd58df8996b1cd7f1:

  board: sophgo: add support for Milk-V Duo 256M (2026-08-05 11:13:19 -0700)

CI result shows no issue: https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv/-/pipelines/884
----------------------------------------------------------------
- board: MPFS: add hardware RNG support and fix RNG consumers
- board: sophgo: add support for Milk-V Duo 256M
----------------------------------------------------------------
Hiago De Franco (2):
      board: sophgo: move ethernet driver to common directory
      board: sophgo: add support for Milk-V Duo 256M

Jamie Gibbons (6):
      misc: mpfs_syscontroller: add mailbox RX helper for service responses
      misc: mpfs_syscontroller: bind RNG sub-device
      rng: add Microchip PolarFire SoC hardware RNG driver
      configs: microchip_mpfs_generic: enable MPFS RNG support
      mailbox: mpfs-mbox: replace unbounded BUSY polling with bounded waits
      mailbox: mpfs: add bounded wait for BUSY to clear before sending request

 arch/riscv/Kconfig                             |   4 +
 arch/riscv/dts/Makefile                        |   1 +
 arch/riscv/dts/sg2002-milkv-duo256m.dts        |  46 +++++++++++
 board/sophgo/{milkv_duo => common}/ethernet.c  |   0
 board/sophgo/{milkv_duo => common}/ethernet.h  |   0
 board/sophgo/milkv_duo/MAINTAINERS             |   1 +
 board/sophgo/milkv_duo/Makefile                |   2 +-
 board/sophgo/milkv_duo/board.c                 |   2 +-
 board/sophgo/milkv_duo_256m/Kconfig            |  30 ++++++++
 board/sophgo/milkv_duo_256m/MAINTAINERS        |   5 ++
 board/sophgo/milkv_duo_256m/Makefile           |   6 ++
 board/sophgo/milkv_duo_256m/milkv_duo_256m.env |   8 ++
 configs/microchip_mpfs_generic_defconfig       |   3 +
 configs/milkv_duo_256m_defconfig               |  42 ++++++++++
 doc/board/sophgo/index.rst                     |   1 +
 doc/board/sophgo/milkv_duo_256m.rst            |  84 ++++++++++++++++++++
 drivers/mailbox/mpfs-mbox.c                    |  27 +++++--
 drivers/misc/mpfs_syscontroller.c              |  36 ++++++++-
 drivers/rng/Kconfig                            |   7 ++
 drivers/rng/Makefile                           |   1 +
 drivers/rng/mpfs_rng.c                         | 101 +++++++++++++++++++++++++
 include/configs/milkv_duo_256m.h               |  12 +++
 include/mpfs-mailbox.h                         |   2 +
 23 files changed, 407 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/dts/sg2002-milkv-duo256m.dts
 rename board/sophgo/{milkv_duo => common}/ethernet.c (100%)
 rename board/sophgo/{milkv_duo => common}/ethernet.h (100%)
 create mode 100644 board/sophgo/milkv_duo_256m/Kconfig
 create mode 100644 board/sophgo/milkv_duo_256m/MAINTAINERS
 create mode 100644 board/sophgo/milkv_duo_256m/Makefile
 create mode 100644 board/sophgo/milkv_duo_256m/milkv_duo_256m.env
 create mode 100644 configs/milkv_duo_256m_defconfig
 create mode 100644 doc/board/sophgo/milkv_duo_256m.rst
 create mode 100644 drivers/rng/mpfs_rng.c
 create mode 100644 include/configs/milkv_duo_256m.h

 Best regards,
 Leo
