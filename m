Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B25EBFD21
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ED5A84119;
	Mon, 13 Apr 2026 11:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="E8HcVItd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E90E84119; Mon, 13 Apr 2026 11:23:01 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6440B841C2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35d9f68d011so2634890a91.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 02:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776072175; x=1776676975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HucrsL9apWDm0/r1x+9XcS5WeccXhJPC/6hXWQc19cU=;
 b=E8HcVItd0sI+iLaU3lA6CWmvxhMCtq3qiOAotbYwSkKfwzG6YhJrWK6KO3iH4jLi5Y
 h994K0AA3DPt98Y7v0VEEffQmVGt/y7Dzrm8hYIREPyqEZTyRr8FWwgTeluMLOwY/JyV
 L4kf9KaTJugUHYY6nDnqAPz852xGWrSQoSxho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776072175; x=1776676975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HucrsL9apWDm0/r1x+9XcS5WeccXhJPC/6hXWQc19cU=;
 b=kGkQPZe9IK4BR930Gqaj13OIr1QBvwND69CVfKmSwTaP2fca4sKJ6lbaLEdyBRweqd
 HNujlc0UltGa8aZEB4nZpgXvRY5vojCZqcB2POTG7Jr+6SgBvDdiKInpwYOjFD/EvkBd
 9ljqcdYuI5f+M9ubGL3xK9h/WQa+PB9uktvwMBxO2PhlNsYnSRDxOcRaclL8JN8LbFT/
 F6jW/aenpSV7JTrvs23xCIg4K+wyjEDsd9Oo7YWoODgno03qLnRSe6Enr6cCqLMxOI3+
 0hPfH824qnFspw6qRAWmkUEhLxYZEOOWXwcsJ+LMHuU97f24rSUSVXVNoYawYXXbQUSY
 aEOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/V+p/+PG4tu6fjDfAg99D+G/wMTcG9nujx7QItFmDb369GBsfJjGL77K1m47pR4juwYkbSxn0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz46Rl0Wpy4wVrVie6JM1ii9Ts0A39jajlv6kFvkHhdjNjDvP5C
 rUOCTc58Y93n1+CTJDJVhRUjUNiD6t3XhQ+IkTGjkwFR8usuaZZ9BKEhssMz839rjHnH5a3st9O
 mrFG4
X-Gm-Gg: AeBDieuvEK2e7vU0sAa4l5OnXSWhegyRrRyqrYrZvYmruQqthg5ELYn5wHCGlWbKSRG
 Lrlv8XNqQVKvoTOvusV0m9mQ3d3wERQapLfPGGzwNGGib1GZhnaLUkaS1TajLAiKItJiuqggF2J
 BWEBnEIBZyy/RZI2x9/yNL8bh1DdSxkWtenjpOaAnujD9Fpv47icAin/DRHNkKP+OTvmkBW50tB
 G3mOKJqmaF26EpezTg9oy9gw5ZnPjzrGZVwshywADARj2BL15LHAMH729xUq3jo9+q4ICflqA30
 hTKi0y5wIuuvkEdVQ7rAOODN8+FFBIi7q1PXJsfMQstnjhvVbMYemLrCXuZl5kucR9WFNsUdC/+
 75GEeDvMDHhZYebM687tb1+DhGpfwDAv7bopazeAmMWJWppRMlIdXGGZ9LyIIFerIhIDrT2BPkp
 cVc7AX10hRMx7H/A==
X-Received: by 2002:a17:90a:1009:b0:35e:b017:da6a with SMTP id
 98e67ed59e1d1-35eb017e4bbmr3195909a91.0.1776072175541; 
 Mon, 13 Apr 2026 02:22:55 -0700 (PDT)
Received: from kinako ([2400:2200:776:9b18:a191:7a74:9fd8:591b])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35fb617725esm1055930a91.1.2026.04.13.02.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 02:22:55 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v4 0/6] Add virtio-mmio support to m68k virt machine
Date: Mon, 13 Apr 2026 18:22:34 +0900
Message-ID: <20260413092240.3719260-1-daniel@thingy.jp>
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

 arch/m68k/Kconfig                          | 14 ++++---
 arch/m68k/include/asm/io.h                 | 31 +++++++++------
 board/emulation/qemu-m68k/qemu-m68k.c      | 45 ++++++++++++++++++++++
 cmd/Kconfig                                |  4 +-
 drivers/sysreset/sysreset_qemu_virt_ctrl.c |  2 +-
 drivers/virtio/virtio_blk.c                | 11 ++----
 drivers/virtio/virtio_mmio.c               | 27 ++++++++-----
 include/virtio.h                           |  3 ++
 include/virtio_mmio.h                      | 12 ++++++
 9 files changed, 113 insertions(+), 36 deletions(-)
 create mode 100644 include/virtio_mmio.h

-- 
2.51.0

