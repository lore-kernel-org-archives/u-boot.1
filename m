Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59F5CD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 07:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2C86846DB;
	Tue,  5 May 2026 09:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="oOfmlcSn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1186846D5; Tue,  5 May 2026 09:49:59 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80D75846A1
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 09:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3651fa24c6bso1800690a91.2
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1777967395; x=1778572195; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U66IVnLXbKnhbblpWKascSPkMx/qulfbi9Se/xyiifU=;
 b=oOfmlcSng3Tw8VvSc2b+Sg/hwnfkTRiMdBoSgr/F8AsdQfYkt+M82qGtnkRSfd2lFD
 MKVfy0rywc1rCsjLnLky0WMHn1m6cO/hBmQ/Z/daWaG5fdwTKhKuhMcB0iUmVSUngNxX
 2WoGXHd+z4E5NUXyombZlJ1X9DGGz973QCeRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777967395; x=1778572195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U66IVnLXbKnhbblpWKascSPkMx/qulfbi9Se/xyiifU=;
 b=KIFbAhHkJd8Ar97n1eTz0i6871xMIBziIua7cz2yK1tNgntDWSogAa4LfQ3k9FOBob
 S0kYlcDIVoe9wsl6F5OkiZGpcnt4rUDG4KZ/vQPiC2WSRlPxLYskcvjh6GDkcaOOZx0A
 +9rKwDcmXX9Xcfk3UmOEAgyCGFJJ6x63oj8N0fPTIC+F0IAVzPNGyiUMggXgEiaVm1jb
 iPLtY7iPp2B39MAqfN5vTaybKkiFGw7rtWQEZic6pgp6Pys7k7DqnJFXR/uQWUrp8HDD
 y1Z71aIOUMiyaTlx/1Bels5+VqyBE5J77kRnBS5mAkIHgxsqc9w5mEynah+SsgDeIIPw
 L9RA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lZZPLAu9Hp+VhTyFSjuhn0h4tPniJp0UDOXl5tRc08ipcCR9xPfYR6jS+rG7tTtSWysHJqQI=@lists.denx.de
X-Gm-Message-State: AOJu0YybeuaXm5TTz5pETIyEDcMqnaVysQNpP29MlnJl93OU4TsqoAGO
 OI1gVIu9vAAZGey8MAZAjYG00dUC0ssX0x9E2i1RYB5MDowS1s5hYXJ57JNJx/q+zK3KiAulZIs
 sSQ9LkjA=
X-Gm-Gg: AeBDievkoQ+XgDa22GIvKElaUji9anNiI/3fz1aPVIavX5t6+8Xsmm6E9fMf4lA/N/S
 b27+v0fz3J5WtCCsAclwXKQF5H4cDBkY/tn4VgL01OFFuAG5v4rqSV5da5yGTYsXnugDwL/L6L1
 TlDwgmhDjsoj/IaGtxlBs5kSEGTFvPobdB16/uzH6c4/X9HEulxjy4Ta53Fr8jPyV6MoNoW2qqA
 3vgEHOeZ10ty1w/V/KGk7gpUaqy7CcjjO7lRRHJbGU2Fiu8kRo/2UlIwC3mzhz9AUbSA0+oY6R0
 kRHBCq0e+aCJTurmYFHhrIHYoQl+24XH32yJmwCDaE0qLw1o47VxvY6ApT65UG8nfKHbvQUPP6h
 tZmdJAUM1v0GxMVtMrhSIjelHT3RRiLK2ttqY6swtAIu1XVxv9tmNns+C1Me2N2bptVrWM42pwQ
 BEvuJzoNC/NmyVtQVL8TsFN+f2lzullh85SskDqwP6cqR87vgv+uDVvmFOQE3mtDuT3m2Hj+oev
 J6gvdCFFCAW3nDEFRDrNf577+E=
X-Received: by 2002:a17:902:e74b:b0:2b9:e82b:bcbe with SMTP id
 d9443c01a7336-2ba537727d0mr18253895ad.24.1777967394948; 
 Tue, 05 May 2026 00:49:54 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1387170-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.221.239.170])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ba038ae95csm89160495ad.46.2026.05.05.00.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 00:49:54 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v6 0/8] Add virtio-mmio support to m68k virt machine
Date: Tue,  5 May 2026 16:49:33 +0900
Message-ID: <20260505074948.2603870-1-daniel@thingy.jp>
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
2.53.0

