Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1475FD2D91
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 14:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA0A83FE9;
	Tue, 10 Mar 2026 15:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="mo12Sde9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A48683FEE; Tue, 10 Mar 2026 15:01:20 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9588C83FDE
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-359a5d8b3f8so4369811a91.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1773151275; x=1773756075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YNc2pYXVms8YUwuLBwCyplUHoWgGcOO5IOXshFMxB1o=;
 b=mo12Sde9cNd3KnEF+OYGN38JZ18+GJppDGk8QqpQMJ8AVJ/vbRujpSZqTGEyb5H7jt
 LQSGnUQ5Tk1O3Pai0DJL6OYeHQrqV+2gQwT55ccAx5+qIciNmWciTEmsktKnMCAwAQYU
 2aeTwrtEfvS6ewy4p8aERVy0XwbJQ8h5GkY0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773151275; x=1773756075;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNc2pYXVms8YUwuLBwCyplUHoWgGcOO5IOXshFMxB1o=;
 b=CCSex6YyIUE27aon1X9A6hO2V7uuufwv/YY2ItDg3BxitnkKejI6cXSHnZ9DzOiGgP
 R+p7jJhabs505Mh11X23gjxxsp4tg3nGZSmmH08NVpjikXYzhyzj6B2s7xzeCvKs5l90
 aXU4svR2pe6O/bi60uDQUeJXXzrVODvvTWjWuJldN6Nn65X54bPffgk+zdy+pWj5ZNgI
 KnYklNxqWbylGxMklP1BKFXKC5hs6bUlP/HikXAh65X1usTscJbCtCRAKSBt1nv83BdH
 H2FI0DsMo7Mzux2X3XqGq7ctho1ZNTNHqd4Zj8Eix8reQSU7E9LWDgPI0IwUEg3dhRmz
 N7yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOud1BdRiC2jwfNYWdGguq3vVXE62qd6ElQ3WLTnTPj1cFj/NJo4dlVB+6BeIB8Dv9lo4G7bA=@lists.denx.de
X-Gm-Message-State: AOJu0YxDiPA1nPvibsv7p8GODNVR++Ran9Sw0SmpR7uSh8qqQ8XLvAgB
 ASxls2QHuzlW7nmHBaPkQwI8IfwtD7z/Ymk3JoOXP0bGoMFLE13MEpXUT2ThdnbmRaU=
X-Gm-Gg: ATEYQzyhXPewKkyPPQn/SehifryR0m6cGBHORoY/DlATuHMkUbUJpJV4Ir8oInsFSzA
 tgt4HVB6XGbT3uxB7EjBmDUYIOx3XNIUbE9BuGi8BAvw30j9OLSXU/MJHm8vo9rzGhoW3gr2mU4
 J2nxgG6ahc9RucplVXxKj2rRKiyq2Hd93nbh54ZrYUU3GesnY+VnJJH49SZgssRhQhpl4tgEv9M
 DICm35qtvQWUSEz6k8VEqL8mwH8M33WAzJoXR50HO35qsyUBEsobccKMSmP6V5ThKBnK/W1vcWv
 JNdxeEPX0cJvq5OT/fBit7sQBXjTSQjCXSR42P/w4TzJHPoARp9J5N+rnDNa9wS5jmpdIdNVs/j
 lQ2PmJzEaUZhhV+7v2sq/Cbp2nOjsH8n172h16gs92mkqvgP6CJffiZ2HSa1vRFsVSIUrQAFuV8
 LWbM+tFwM+kK3DPAAq72LeyRccQH6Gc8MEEbl7UVi1RTSLMnc3PoENW3LWvtAKoMiCSopBuxYPL
 G1QnwWG8oCW6tef
X-Received: by 2002:a17:90b:2884:b0:354:a57c:65ec with SMTP id
 98e67ed59e1d1-359be3075femr12712545a91.20.1773151272080; 
 Tue, 10 Mar 2026 07:01:12 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1766150-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.167.218.150])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359bc9bd61fsm7863531a91.3.2026.03.10.07.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 07:01:11 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: laurent@vivier.eu, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH 0/3] Add virtio-mmio support to m68k virt machine
Date: Tue, 10 Mar 2026 22:59:37 +0900
Message-ID: <20260310135940.1756141-1-daniel@thingy.jp>
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

This allows the virtio mmio driver instances to be created with
platform data, fixes (for some value of fix) the endian issues in
virtio mmio and then adds the code for the board to create the
instances.

This is very rough. I'm not sure how to fix the endian issues or
if there are even any issues and I missed something. I got my
version of the m68k virt machine working back in 2024 and can't
remember everything.

Daniel Palmer (3):
  virtio: mmio: Allow instantiation via platform data
  virtio: mmio: endian *fixes* *HACK*
  board: qemu: m68k: Create virtio mmio instances

 arch/m68k/Kconfig                     |  14 +--
 board/emulation/qemu-m68k/qemu-m68k.c |  46 +++++++++
 drivers/virtio/virtio_mmio.c          | 141 ++++++++++++++++----------
 include/virtio_mmio.h                 |  12 +++
 4 files changed, 152 insertions(+), 61 deletions(-)
 create mode 100644 include/virtio_mmio.h

-- 
2.51.0

