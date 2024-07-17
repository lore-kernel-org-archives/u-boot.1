Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022A9C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 01:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EEED88AD6;
	Thu, 18 Jul 2024 03:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YrD5Lj8y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 405A188AA7; Wed, 17 Jul 2024 20:24:14 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 588498879C
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 20:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nyandarknessgirl@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-36796d2e5a9so1282f8f.3
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 11:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721240651; x=1721845451; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p3UnclasR1WieDqgJR4+cCtsumYaL6vdrkUmBPrGMyE=;
 b=YrD5Lj8yKOM4oWxNOtF2O2/uTSffZNiFgi/YIS0w7NqPN+2uErrwyMeJrznXFZC5Rr
 OZnph/tK3VKveIKPQjc7M0SSy6E/3UKUHDVg9SE5sK67P1Z2Ra8SVnZJNTWB45C2/aVO
 OLgogsdsbH4E/2keaVQwDceG137ygw/OXxnj22sVDVUAGHDIn1xS9I5NwJl1iuR3RnT+
 EqRfztXLSlsaQ+IASukdoR1O6eHLHCJ1P6PL1/cIG0ECzrM4nESY9tVZiuoqjKQ79MWP
 P5S6wy1cn5Pl9RGDoL7A17n0T6ulFSqLPeefyYuD7mt3c6FGOTAzXN/nnaIYYWUXz3WQ
 vhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721240651; x=1721845451;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p3UnclasR1WieDqgJR4+cCtsumYaL6vdrkUmBPrGMyE=;
 b=OVun/c1Oq4Nstd0z4kDqh1rDhgRbp4HCbtHBfBv3O+4wHoxONd5HfG/UR4l71jbMcR
 iKOYXyDJEqfdlL5D1sLCu7EM1EqHyV3QaVD2VDWRyFaQKUSRs1m2lLptLVzKDgK08jeq
 s9lUDlsUfZYpqsNjg6agUWj4g2U2u6Nr05PaHDApZXcxoV+XJ/ShDobwDSIqll6eaU3d
 HJmvhEIrc1ZXG8z6iTuKtuySdIHyrMfNN8GO/9jalk8f118ODwabAjjFpspyg2ADnU/O
 QyxqBKMKGxXj4IVKsQDCudwWcfbldR3cpjH8Wj2c9GtuqgCkovJOZpXfcDDHKQoRfqcV
 4Zug==
X-Gm-Message-State: AOJu0YyqjEs4Mcl60n+cGzgDgQY01JjnniakKqWZkYAJdK/LUSsbSysw
 7ImYFjJjv+zbxs6osHakHJ3MCh3w6gnnem607ODXHJxL37Zp9Oywlq2xyxo9k5q08Kiejg1x2Ay
 UJD7oQMUWH9hxkwjRBX4vZZ1bw/ifu4B7mzi+e5/B
X-Google-Smtp-Source: AGHT+IHD7yCS//0MJOzij+uXPGttAzfwhl2D4VoF/CWrJbOiG7rhD03/pOKevEJmtScRCB+mB/ycUkcf1iEz6rHbLLk=
X-Received: by 2002:a5d:6c68:0:b0:368:3895:67d6 with SMTP id
 ffacd0b85a97d-36838956875mr1832564f8f.20.1721240651467; Wed, 17 Jul 2024
 11:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <CA+eeCSMKifhHwf+oYm-vamSyimoAycEN_U5RZj3bCX3Q5qsdwQ@mail.gmail.com>
In-Reply-To: <CA+eeCSMKifhHwf+oYm-vamSyimoAycEN_U5RZj3bCX3Q5qsdwQ@mail.gmail.com>
From: Eva Kurchatova <nyandarknessgirl@gmail.com>
Date: Wed, 17 Jul 2024 21:24:00 +0300
Message-ID: <CA+eeCSMWt4m2E9ynRXr0bXLBfarx_naeUL7GSGmJ3EZ=a=HR1w@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: qemu: Enable booting from NVMe
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 18 Jul 2024 03:52:34 +0200
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

From 2f016333edcf18f520970c5ef02fcaa8d2b1b8f0 Mon Sep 17 00:00:00 2001
From: LekKit <50500857+LekKit@users.noreply.github.com>
Date: Wed, 17 Jul 2024 20:39:09 +0300
Subject: [PATCH 2/3] riscv: qemu: Enable EFI framebuffer

Enable framebuffer for better virtual machine integration.
Some guests need EFI FB to work properly.
---
 board/emulation/qemu-riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/emulation/qemu-riscv/Kconfig
b/board/emulation/qemu-riscv/Kconfig
index 9538c66e..012ac14a 100644
--- a/board/emulation/qemu-riscv/Kconfig
+++ b/board/emulation/qemu-riscv/Kconfig
@@ -58,6 +58,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
  imply E1000
  imply PCI
  imply NVME_PCI
+ imply VIDEO
+ imply VIDEO_SIMPLE
  imply PCIE_ECAM_GENERIC
  imply DM_RNG
  imply DM_RTC
-- 
2.45.2
