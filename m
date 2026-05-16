Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE53CD4F25
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 07:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B723A845E3;
	Sat, 16 May 2026 09:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="m4MwF5PR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 919BE84609; Sat, 16 May 2026 09:40:38 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B45083EF9
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 09:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-365eecc5885so639850a91.0
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1778917233; x=1779522033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KkYZddDvKQu4f5MYrqXRlf6WyNY97FIgWwFFbnDjnrY=;
 b=m4MwF5PRgF+3chAGC+f/YrnXW3JK9ZVRUNecrxrFY4+VFZKZbiTSEz1oZCWWq8nVdu
 feDW/QiTvOzpD1hLAnpZWcfSJMKu/dugAy57464LKYX3VlsswJxmq9bOkHdmQrJkQlRX
 Shc84G/8LhFE6dUyqPAVNLfhbCfxxeXt0YO4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778917233; x=1779522033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkYZddDvKQu4f5MYrqXRlf6WyNY97FIgWwFFbnDjnrY=;
 b=GJQ/gRRQe8OH5+hYU+yWOUZ1BgPjPgYRlf7ir6bPq8eeWEV1S2K9mxf261OsSSzl4q
 uINQevSE5HqSGalzptrAb7RRnSbBJWZxkGeKbtk3T3Zpml1CnbelKReNedeJx+juhj0R
 IlTh3NxZvTbBRg2yTODTA7FzzilevTowfeLK67XZnIrHMlyBzAiX4FC4mEAnbthuZ5zG
 9L8v+yVfVTMg14fgu7SwC3wV40HYbwp/kGvtR/LDLcR3ae+2utBkz0mHAl0tG5LLLhUq
 9Duamq9WViKA395GXXepfipA4+ho4yFaXV70ENQEaMeCf8rproFhNdF2GUfpY8UAYmx4
 hONQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9foBlKvB/39Jv6/2bhdZDUyaWX2fedFkDMW21d4JBiR3UFkUmLd3JjMI8C8ZXXt2wMgSs3LkU=@lists.denx.de
X-Gm-Message-State: AOJu0YwuJbmespyEhkB62Nng84wpAxSmbWYrgtHcoAR+1Eu6pE1cTSk2
 KNahZ324jCOc/qzx3nKWa9bHr6qgllLNk2WvT0NGifg8FCGC6scQrbYT2mskpOxpje8=
X-Gm-Gg: Acq92OFOr286zp1CE+wxgmWYq771aYZLcZL/LcMiTiCw3VE6wFJL3M04Bqh/xu5pB/z
 PnEV1DG9MuiNFL86U13nxn8WS62ofK2A4IXXrWFV0GL1soq/HQPrmlFZBwCjq1kwO8JjLRrwVxB
 J7abCbhX2w9JQL4i8ehFeFyQTr4lzMLJNILRsbkI0Sj+wDaAnTINVeachi71jqUNnBxDgihu8WB
 yL2GmNgtUFN7U4prWYnu/OWGOzGZBqkmqtkDcmY33w92JBzKf+MhkXmYPzMt1KpzXqB/5Hz3kjS
 fQ1gE6lFPvw6yZZPHr78uis8DL1AUhVg1DCrsXWkktlBcVX0vamxh7e9L1StqxySg5lXaLjztE8
 ++jGHGTm4GSg3NXu69agolBK6XcRvLcO3xxYlzo/zWzpm+0h0ktbKEhuVMneU1Jm3lPEbN3kD8g
 LME3KxGX/8B0E78YoWgO4rjl7dzon4DOEOPVwxqHFDFK+HLGpkCVHC6NnBH97oR1AqzQ5lhntfG
 CDOodGfEJBRKg==
X-Received: by 2002:a17:90a:501:b0:369:7421:75c3 with SMTP id
 98e67ed59e1d1-3697421c76amr908733a91.16.1778917233225; 
 Sat, 16 May 2026 00:40:33 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1620034-ipxg00d01sizuokaden.shizuoka.ocn.ne.jp. [122.29.136.34])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-369514361b6sm4702672a91.12.2026.05.16.00.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 00:40:32 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: 
Cc: Daniel Palmer <daniel@thingy.jp>, trini@konsulko.com, visitorckw@gmail.com,
 angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: [PATCH v7 0/9] Add virtio-mmio support to m68k virt machine
Date: Sat, 16 May 2026 16:39:52 +0900
Message-ID: <20260516074016.885146-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Lets start making the m68k virt machine support useful.

First we need to fix some m68k endian issues.

Then allow virtio mmio driver instances to be created with
platform data and fix a minor endian issue.

Finally, add the code for the board to create the instances.

v7:
 - An extra patch is added before changing the qemu sysreset driver
   to use __raw_writel() to fix issues with versions of writel()/__raw_writel()
   that don't cast the address to a pointer.
 - Hopefully this fixes all of the CI issues. I have tested locally by building
   a few different targets with allyesconfig. A github pipeline passed with this
   patch and its running again now since I rebase and force pushed.

v6:
  - Remove an extra signed-of-by that go added by b4 or me somehow.
  - Fix the warning about a phys_addr_t being cast to a pointer of different
    size if phys_addr_t is 32bits but the target cpu is 64bits.

  CC      drivers/virtio/virtio_mmio.o
drivers/virtio/virtio_mmio.c: In function ‘virtio_mmio_probe’:
drivers/virtio/virtio_mmio.c:359:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  359 |         priv->base = (void __iomem *)plat->base;
      |

v5:
  - Add Kuan-Wei's fixes for the two other goldfish endian issues
    I hadn't spotted. Should be good to go!

v4:
  - Small changes to "board: qemu: m68k: Create virtio mmio instances"
    requested by Simon.
  - Add another patch to make the virtio cmd depend on CONFIG_VIRTIO_BLK
    as the build breaks if it isn't selected.

v3:
  - Fix the bug with the vendor string in virtio-blk properly,
    this removes the last endian hack in virtio-mmio
  - Leave the current behaviour for readl() for coldfire as it
    breaks thing.

v2:
  - Added patch to fix readl() etc on m68k, hopefully this
    doesn't break everything. This should match Linux now.
  - Added patch to fix sys reset which is broken by the above
  - Hacks to virtio-mmio are gone because they aren't needed
    anymore, just one minor endian fix now.
  - Removed RFC because it looks good to me*.


* I wouldn't trust me. :)

Daniel Palmer (7):
  sysreset: qemu virt: Use map_sysmem()
  sysreset: qemu virt: Use __raw_writel()
  m68k: Fix writew(), writel(), readw(), readl() endianness for classic
    m68k
  virtio: mmio: Allow instantiation via platform data
  virtio: cmd: Depend on VIRTIO_BLK
  virtio: blk: Fix converting the vendor id to a string
  board: qemu: m68k: Create virtio mmio instances

Kuan-Wei Chiu (2):
  rtc: goldfish: Use __raw_readl() and __raw_writel()
  timer: goldfish: Use __raw_readl()

 arch/m68k/Kconfig                          | 14 ++++---
 arch/m68k/include/asm/io.h                 | 31 +++++++++------
 board/emulation/qemu-m68k/qemu-m68k.c      | 45 ++++++++++++++++++++++
 cmd/Kconfig                                |  4 +-
 drivers/rtc/goldfish_rtc.c                 |  8 ++--
 drivers/sysreset/sysreset_qemu_virt_ctrl.c |  4 +-
 drivers/timer/goldfish_timer.c             |  4 +-
 drivers/virtio/virtio_blk.c                | 11 ++----
 drivers/virtio/virtio_mmio.c               | 27 ++++++++-----
 include/virtio.h                           |  3 ++
 include/virtio_mmio.h                      | 12 ++++++
 11 files changed, 121 insertions(+), 42 deletions(-)
 create mode 100644 include/virtio_mmio.h

-- 
2.53.0

