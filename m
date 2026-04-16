Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37DCF8A14D
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 624E5841D5;
	Thu, 16 Apr 2026 11:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="QALtJLiQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F18B88407E; Thu, 16 Apr 2026 11:40:05 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EDB08407E
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so5010798a12.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776332399; x=1776937199; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qv1J6KBQK2gSfxhC4ClXghUC5EaUEbp0BfVXZB3zDF8=;
 b=QALtJLiQLjqUsps2TylSDgFe8ap6iSYyYMys3STuPn7oW2pTBvEmHEiwDms4Gs8unE
 o9eNLOGNaNTvJtQilLLWBYoTBDtWRd83fzCJ0DoOnup+lg2oq6fT71VvSI2jzwbnPfMA
 z7FLW3vH36B6S0WMRsLRPOCe1PtpAhsr9Nscs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776332399; x=1776937199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qv1J6KBQK2gSfxhC4ClXghUC5EaUEbp0BfVXZB3zDF8=;
 b=ccYR8zIHWu9bqdkgMCUcM5MTa2Roj3pfREx4kFX6EDVd9KK2ksi4LIZSjCfEKjbEJD
 F1/M6+ONkr76a75SZSZw/r7ETr+eUuKVdO6fUCrgY39BEMgVxHpgvGanoHsjpdm1mzXg
 HNmhoECZSNgmRDll2ons7v1IdHk4fmssYVjYAPc7GxUgoxFYM/dlouiKB9ryECbf7ZZf
 sKixX2cjsB/NIsPn5Yx7yTrpx3bqzC2ZpkBjR+K21UW8bddkvFd6+mwg+oQH4QGPpCgr
 erV1oeKohdodhsy6W2yt71hcHBK9K+O+BcKSWuw8gp99SPeFmeHVZV9t9FbVr/NK0fTn
 D2zA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6i4RT9K71jMfKNzYBwxFTmYHRz9go34ulRoPxkQ4Qd8hVszpGCtk2PDY7lMjkTHUf0XxN5Yg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4KYG2k9UIRfinoiDfKYuOHU9n1i1uL6Pq93gIe0uf+JTgMXSw
 ClN09sV5rnWZoC3zbPLgbX/MwQAANcWTiDHjfntkDTzY5aPVpny2JeNWIQ4xGIYCenU=
X-Gm-Gg: AeBDiet0exZ/IPx0jaGbzegmQQTlENjtCwd+RejPFhQ/RC8dswropZbzXSfCxKvVYbf
 GOHfK1LpfLR5TOZ/VUrhAk/rWG/OwmjCNDR/RHgQiNvNYW18qBKc9vDQeAcfYU4KCz9fNnvvuIr
 o1nypNuMTdYeMHzvyfLsx9ntJP4C5PMCTR0fNcmYY0+Hbnh0OSm9+dIbIMq4ws3v6leMeeQvOG4
 rkZfetVpdHAA1d+xMqJd/gH42DScoGEdoAs1P0eaeLt37XcO0hmSgNlllnE8NHZSdGBV+Vta+zF
 Fg7fAcqmlUy9SYaxFcDnv/jIb0D5e+w09JuELwFyDtaupb6CKSZDRbrxwYzTGNkwIp0QntcVYzl
 dDIom1xwQX+xQXpAp57vNkoqcm2IwzxU0MHvC/qVITE8KAd8w3AtsaNah8cRHuG04JMx6UXgFut
 IHuLE2iELWBCIcakv8xnr9BLSSB12CkclIt3+j0pNnHh4FOdyE1UbWMOulCX+C005+ouCglS3xd
 bb/kUT7pZwuSw==
X-Received: by 2002:a05:6a20:9151:b0:398:77ae:8d8b with SMTP id
 adf61e73a8af0-39fe3c90fe6mr30766758637.10.1776332399403; 
 Thu, 16 Apr 2026 02:39:59 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1329195-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [114.145.5.195])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c79581a2fc2sm4423568a12.21.2026.04.16.02.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:39:58 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v5 0/8] Add virtio-mmio support to m68k virt machine
Date: Thu, 16 Apr 2026 18:39:19 +0900
Message-ID: <20260416093927.602613-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
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

Lets start making the m68k virt machine support useful.

First we need to fix some m68k endian issues.

Then allow virtio mmio driver instances to be created with
platform data and fix a minor endian issue.

Finally, add the code for the board to create the instances.

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

Daniel Palmer (6):
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
 drivers/sysreset/sysreset_qemu_virt_ctrl.c |  2 +-
 drivers/timer/goldfish_timer.c             |  4 +-
 drivers/virtio/virtio_blk.c                | 11 ++----
 drivers/virtio/virtio_mmio.c               | 27 ++++++++-----
 include/virtio.h                           |  3 ++
 include/virtio_mmio.h                      | 12 ++++++
 11 files changed, 119 insertions(+), 42 deletions(-)
 create mode 100644 include/virtio_mmio.h

-- 
2.51.0

