Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BD4C531FC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 07:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C96A40564;
	Mon, 27 Jul 2026 07:36:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ya0r3_pa6YyX; Mon, 27 Jul 2026 07:36:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A35040588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785137793;
	bh=m3uELYi1CWA5TRRfTQrldM3fHDvnORAM0xZKY8Mc9nc=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=1H8osBrbfNSLrOSc519jhUpGg2JmXsS7G55u70GjZ31YCYpv6EmVwRgjrLQiw3JR/
	 csRsBPnpVBjYlvk0HXE4ze4s1jUBM8e9oJXY1QzWwhM+x5L5wJfuwhZQg8Ex9BFxaA
	 P6rUqNzQByaTVWCwdgkNmAIMkfUFD01nyFlxdTAOdSBQVDPVIBBP+P8BvqqPClF5m0
	 W6PrI4S6lX0VQTQluz0selvgnLNR+epKrPBU1wl0eb6h5ob5xRig4HGnMrv118Ub6u
	 lyI1fDA/q71wSq+TSQ7zvUoV3yewks85HY4Kt2n30zbtT+rgpcZxQ+QLKHURSK1Arm
	 SQVnNwakgtqRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A35040588;
	Mon, 27 Jul 2026 07:36:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 598D42E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 402D2605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f6JqVqyyLJuR for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:36:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B3719605D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3719605D3
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3719605D3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:36:30 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2caced6038eso26037615ad.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 00:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785137790; x=1785742590;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m3uELYi1CWA5TRRfTQrldM3fHDvnORAM0xZKY8Mc9nc=;
 b=rz+MzrImxKnvUfQb2Kv/xkRrwl3bL8QafirAWarRfWiGrzTP2jqzeHf1WA7AJoCios
 QG80cn4qo5wpunZsAuMhixZ2C8CZhq1TJarvhv3D8KJ1D3exLnqJfTQ7QY2SwtjTY7rc
 xqgiCSV+l7E6n7HBtHScuUi6p3/ue6I6eH8iPfwdAK0/RA8lfrBf9IvGpaXkLPedQEsg
 Vo71uhV2vO98MU0DjNtOhWG06MFgmOZAo5F6yVGKTE8nKjJm4ZwE/mwk7lMXwnJBsOQk
 9fUScsP34sAshNh04AZqfo0XP2cz20/mylLuHzGBv1/8ktumVjcqWfkcu546Mwr+rTy3
 4GnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rovmv5PAINOzHxu8OAq67rlz7qoaXXp8a74ylHysFK7zXQv+XztSt4AaslXKuyK9iORkWS/QoY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxJvXBcqag0NDH3w11KixRR8OMSbkyZ/s2JgX9kedA4NtfhqEZ8
 BuovTaq7EpDBw2blQn5LfjufKk2rlwjV3a+h2WLxRWX+H/4tQiCviIl/Lskxxed7oXA=
X-Gm-Gg: AR+sD126UQz5WeubV5U1wPu2zg0gt/n14vlVPV2MF/w0rbCLFswjMGLHuP6myjlCP9j
 m4247fFs/lHM8HkNjG9x61fDm1uTXyoL93qHyG0yYnKVvBtjFo6cOnIwy1ba2mvrs5R50kXx27+
 1tfeg2wP3PZCoE077EisGVeEzwpehikaaoBw9VxZnrEbbVk4EE5fSfEnyNwXz26q2NVX8KVhDc1
 Esb9e71Va4GFKwx6lUGwPwzqjHLSugxg7Dmm2Gthyjlqc98EDtDhAZI4HFGFeXJ8/rZ4RUU2YdO
 6wketr2Nd4qQvIbDLQJNBl//R7FEQm5ijfecaKkS+TIEAvx/wYKriTsCylp23VEy73F9hd3qs8e
 DKhgh0CDgV1s+/GCez5K+oKUim5hOlp78vYeJ+4vyL8l0D5PSnXvV2WrTPz2rpTYbviRYza7rpP
 s/Av4A2QfFkW+D68rWCLKF
X-Received: by 2002:a17:902:d4d1:b0:2ca:d4f:adab with SMTP id
 d9443c01a7336-2cfd71750bdmr84614035ad.19.1785137789890; 
 Mon, 27 Jul 2026 00:36:29 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.196])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde7f419bsm29632645ad.67.2026.07.27.00.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 00:36:29 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:36:24 +0800
To: trini@konsulko.com
Cc: me@ziyao.cc, hfranco@baylibre.com, hal.feng@starfivetech.com,
 michal.simek@amd.com, fberder@outlook.fr,
 charles.perry@microchip.com, naveen.osdev@gmail.com,
 u-boot@lists.u-boot-project.org
Subject: [GIT PULL] u-boot-riscv/main
Message-ID: <amcKeN3QurHxoqsp@lliang-1876.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785137790; x=1785742590;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m3uELYi1CWA5TRRfTQrldM3fHDvnORAM0xZKY8Mc9nc=;
 b=VzmB4T1esDm0pOiRdO6zHyouYCKp8WoHKEFspmx77a+E4xWRN+noaDiydlEo1QdQVd
 FVh9zbPZVMGLnAYX8Bgx1tHMKttfA3ZWuMNHp2fQxoo0y77v9IQAoBn9rStgBbNWPYTG
 ZDfBhRzGfoxmWOsH1oOvupQBFyfe7DcU9AzQ8mJzyEg+xN9ql5OZjSVzQhufbPGK4rHr
 VKWpMzDVJjNl9ohbUhG41WJ8x7RnoOpqt/JNDdjaWQ4FNCk9sHMmboVZPcW4u4tKPGEN
 bU/xauNPN1BSWPKMrsnxzdJ5aG4gxqEsDUxYuFsFzy6B7zSbpWXsGU+FCcVqbfu1UA/S
 R6ew==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=VzmB4T1e
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

The following changes since commit b635d43bca429500cb8ef20aa151cb5773b9a8a5:

  Merge patch series "fs/squashfs: fix symlink load failure on large images" (2026-07-25 07:55:35 -0600)

are available in the Git repository at:

  git@git.u-boot-project.org:u-boot/custodians/u-boot-riscv.git main

for you to fetch changes up to c201051a9cd3a358cb67cbba9b1c5fa717cf1c40:

  serial: sifive: remove busy-loops from getc and putc ops (2026-07-26 21:04:42 -0700)

CI result shows no issue: https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv/-/pipelines/740
----------------------------------------------------------------
- some fixes
- Add Yao Zi as a reviewer
----------------------------------------------------------------
Charles Perry (1):
      riscv: remove log_debug() in enable_caches()

Francois Berder (1):
      rng: jh7110: Fix invalid usage of dev_read_addr

Hal Feng (2):
      configs: visionfive2: Add VisionFive 2 Lite eMMC DT to OF_LIST
      board: starfive: visionfive2: Support VisionFive 2 Lite eMMC

Hiago De Franco (2):
      doc: sophgo: licheerv_nano: fix incorrect step numbering
      riscv: dts: cv18xx: fix spi node name

Michal Simek (3):
      riscv: Skip riscv_cpu_setup() when CPU driver is disabled
      riscv: Make RISCV_ACLINT visible
      riscv: Exclude ACLINT for TARGET_XILINX_MBV

Naveen Kumar Chaudhary (1):
      serial: sifive: remove busy-loops from getc and putc ops

Yao Zi (1):
      MAINTAINERS: riscv: Add myself as a reviewer

 MAINTAINERS                                       |  1 +
 arch/riscv/Kconfig                                |  4 ++--
 arch/riscv/cpu/cpu.c                              |  3 +++
 arch/riscv/dts/cv18xx.dtsi                        |  2 +-
 arch/riscv/lib/cache.c                            |  2 --
 board/starfive/visionfive2/spl.c                  |  7 ++++++-
 board/starfive/visionfive2/starfive_visionfive2.c |  6 +++++-
 configs/starfive_visionfive2_defconfig            |  2 +-
 configs/xilinx_mbv32_defconfig                    |  2 ++
 doc/board/sophgo/licheerv_nano.rst                |  4 ++--
 drivers/rng/jh7110_rng.c                          |  4 ++--
 drivers/serial/serial_sifive.c                    | 11 ++---------
 12 files changed, 27 insertions(+), 21 deletions(-)

 Best regards,
 Leo
