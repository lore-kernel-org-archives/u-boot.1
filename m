Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC79F46C45
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 14:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0DA83936;
	Mon,  6 Apr 2026 16:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="ZarTimqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0712483EC6; Mon,  6 Apr 2026 16:24:32 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D568341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 16:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b2503753efso32330975ad.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 07:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775485466; x=1776090266; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O07v3UUWA5+kYZqsXRX6xkndXVP6XU8diDA9Uwx9Peo=;
 b=ZarTimqnCDmR4Cu7mm5RtfoqjoGAKdWfeRU50MLBEMkotiIhZllb5QXRo4O85N0xJ1
 k+vex3GgggeB9B5bTuBHd7xZ5ViDhPyus9MXXOs281+ZQ/IqFwHwHCVVruJT8aP7bYUD
 djHcEyMjKKiNglC76Y3QifUxoZAbBcqh4fsOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485466; x=1776090266;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O07v3UUWA5+kYZqsXRX6xkndXVP6XU8diDA9Uwx9Peo=;
 b=qYfH89AazWAiPljFTVLm0V4MHjqNsxFntF2Twf7YPYveswQB2clni8jtN4d9/OYJjA
 Kj/27pEd8SU7xLctsz8Jd7K0PZW9n2hgMG66YJGevhU+UA7JgftTvB5+r3msfddAo36g
 uKeFtilQqIk3QugKZ7qM8FVtZaL2ykDu+zRCdCsiUaMxWfF2ZhmzMeSUK77Rlz1bX27d
 /ELkStimhDD6aQGybQPigSaU5n3cION6Bbm7e16L2gRbuRTo9I+Rif1MzvVtsirOTxXs
 PXHYg7XoKYal2sBBFKP0YDy4+dAHBJfi1YPPk1HOR8EvUYRjtFcv0NILr2pljTKtSMZf
 o5/Q==
X-Gm-Message-State: AOJu0YwZ7yBLFLe7Z1Fj8KRIWaHHmG2XaAZhpfv4W83/zdW3IweZ0hyU
 m2DP7YyouyWY5U7+yVoKRtniKfRctB4807m4Ww8/oXzP7McHZBCVtZ4zcNF1S7Ium28=
X-Gm-Gg: AeBDieuDLD5OL7XKUVaxvUVrjP5BDC7NIV/ZxCt/bkqxl86MXMf4IUSiPAhl64cNqJn
 0BQYcRL8MdAlzrse28j8Ytsij7WQWxRbjRyi8poYAGKATI+BhBMELsbzS3jGP1cx/MArOIZByuK
 OiZxCdGN+7Bse0kBBiI6BEG9+JuNcF4xUmPhEpqCCcjFCekueABsdWXf20R9geQxdHaIo6fmzCF
 0VYxkTqig/Z6UjAiMiHCrk05b3EDpWvjowEdvJWgrczoUdt7vd7WrPRcKD6nzI+1Gy/ahldzLh4
 D3nQpq1uZmxSK/2LcL/yUidB4JZnpkQzh6lJpqoahu8+HbLZDJPbq+LZWXF8MOe/Uzc1jIxMgej
 +qtiorAu7qIfu09kZ77/tNeHRx/SiR+k1tneQrooUMluTunypI4QDI1AHbuSlBmCIZ6xXHt3fF/
 L7OaWJwZ//s7winmdvG8jtGXD7Bc/+98D65ZIEmQJltW670TQJtVvIr9Bb9awllcVcPyW+nJXE+
 7ffSgsG0KPov4ympGnkvQ==
X-Received: by 2002:a17:903:3586:b0:2b2:6b58:9317 with SMTP id
 d9443c01a7336-2b28194ec0fmr131379005ad.39.1775485466589; 
 Mon, 06 Apr 2026 07:24:26 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1866070-ipxg00f01sizuokaden.shizuoka.ocn.ne.jp. [180.1.30.70])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156885295ad.29.2026.04.06.07.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:24:25 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v2 0/5] Add virtio-mmio support to m68k virt machine
Date: Mon,  6 Apr 2026 23:24:06 +0900
Message-ID: <20260406142411.2992618-1-daniel@thingy.jp>
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

v2:
  - Added patch to fix readl() etc on m68k, hopefully this
    doesn't break everything. This should match Linux now.
  - Added patch to fix sys reset which is broken by the above
  - Hacks to virtio-mmio are gone because they aren't needed
    anymore, just one minor endian fix now.
  - Removed RFC because it looks good to me*.


* I wouldn' trust me. :)

Daniel Palmer (5):
  sysreset: qemu virt: Use __raw_writel()
  m68k: Fix writew(), writel(), readw(), readl() endianness
  virtio: mmio: Keep vendor id little endian
  virtio: mmio: Allow instantiation via platform data
  board: qemu: m68k: Create virtio mmio instances

 arch/m68k/Kconfig                          | 14 ++++---
 arch/m68k/include/asm/io.h                 | 17 +++-----
 board/emulation/qemu-m68k/qemu-m68k.c      | 47 ++++++++++++++++++++++
 drivers/sysreset/sysreset_qemu_virt_ctrl.c |  2 +-
 drivers/virtio/virtio_mmio.c               | 29 ++++++++-----
 include/virtio_mmio.h                      | 12 ++++++
 6 files changed, 92 insertions(+), 29 deletions(-)
 create mode 100644 include/virtio_mmio.h

-- 
2.51.0

