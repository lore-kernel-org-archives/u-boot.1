Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84EF10A1E82
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FEFD81E18;
	Thu, 26 Mar 2026 12:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ISvQGlWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0B4C80517; Thu, 26 Mar 2026 12:51:32 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A820E80517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48702d51cd0so10512855e9.2
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774525889; x=1775130689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ho48seBb8ILW6QLx6YvlTuZM2vDsDZPSDD/nUE+7YGs=;
 b=ISvQGlWTIzwkQECzADPnACtdz9C9LyHdB2JGYYfDUZ3zSEVBhuc4Dj+P3sFXlUTV32
 HMazPa3tqg/WQKgc/Ah2G2r+5KOR/q6H5mM/M3T7FJl00gd0jy89mPv4t91OPAVPWC+C
 NGMAaos09YYu+lYX2bES59DFxBkazYdv6zwuuDr+z0vUpEf+jrZmFZ09JUDHlOVlDiB1
 MWyrG1La3OLxKyP1xeYCefM5sIyEAdMbXc2rcZRQ/7DC4qYjSbjS8R8Bx5NolIIM+DQv
 3XzOIfPivqH53OofWH5ckB3UxoF+WmwSRJ/GcMawrv3jdY9vZAw/skIW41nmTyXbC6eY
 deWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774525889; x=1775130689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ho48seBb8ILW6QLx6YvlTuZM2vDsDZPSDD/nUE+7YGs=;
 b=KVHC+fQhT3U/W6jgtN+Y0IVg9sLl5sV9F3fyU8mOaZar2sWcqfyrUZj3+8XqyyOCDK
 Liwa/Zxz2y4AfJhQyoYUwE2Ou17NjMVnaI9vofGYuitleUSZstgNGt51Nwy9Zpt3JrUG
 GfWOfVsl1c5cwEFMDteigW+EBykF66DbP3I94ff0TSO0nK0Lw6nm0pcB759af/CrxyMw
 mlkUE+LCFGT/d4CoIwbivXIx0M45EESHx+sD8aNR8/BbBVwyViVgeeZepFFMdhJYNvJm
 +mh3X7ZFyTA9X6eNHfSRzW6VagB2MbaqVS7WFZua8dCA++QEeG+wW6w3V2KCFrZkcRG5
 Tkag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrzH8lQh+KpYyaFDVQpoWU2BeyNjJTzVz97/TMpIz8B6ItOH31wLC2TsCQzVyc+gZ+7O5x/GM=@lists.denx.de
X-Gm-Message-State: AOJu0YwgOqr77DEBkfBlzMgbR8GKZ+l5fF594fSurwEUdUEppOFX4bYJ
 yuMzr90d8RwFugJgQ+CpmHe44CWuQDZOF/C/6Z9kl37IrhOz6qqoVZ8Q16gc/fckErY=
X-Gm-Gg: ATEYQzx23an6fEzoMxntTGqX3EZ+h+J67/1QnQBDfl1ByjM/XBxmGoVLldNv03SLQHG
 9xeMcrzox+86ApcQwBGn43wqsTxJryXHQiooZEW7kzevM4k1I+dOURQrmUJNK4QRGDQw1xDfr1z
 IPntaMR2WYMyKKALCTIBgmzYb/Lpwbl/QyLiEi1yYgDB3ukNR8KGgme/4iYPkf4hsNfGXVNjzCX
 zCLW+TBcTiUUkppStoUmC1C/Cy9aWEFZutMvgcBjI8176rKWtxlRV5aKwFPJIhTGmlq3bHPFkTW
 qtrIFV9ass5fmTfZiPiwzDdHKYvIb9gBzQeSGg+jbCKWn8OgESwZ8ubYiDyeo5fIldOQjNkLXQO
 x0j6TuRQ6OLumU9lwakBypEjI1FMNyHjgJkWoIrUTSbeb/9vDfC7jTJO7aWoM39FGigfvWnuQ3W
 l4ulW5CGrt1BM87vZCSUY5gAmkWG6AfWSGb/JEsaDBbQa3cQlwC7l6XPY9MQsTLLKDhkdGs3uE8
 zVmUprVykC6Eduzj+2evVdpBZ1ESzsiJmEHecgLcCQ0FaYWn7b4reE6bEapv2r+6G8JFqzxBVd7
 eHcR30O5J2R9bMLX+Qww4Brsl2/tsHSsqtrfOnqcbLTmjlqPFe7H0WlDGh35OxHqY/ZaM3xncTL
 S1q1rKRZfcTw1vWhPkCKOOt2kWqyUboLOB5UJqZ6cZ8tLaCDobRmjQmE7ATQMCEJCdbDTNFb3JD
 m7KerkbmlynBOgDLYthojEVyLm/CQfqIsDyvcI7AZzwqtvXQMuPo/uP1dwx6MtjIhKxkg6euM=
X-Received: by 2002:a05:600c:3511:b0:485:3ca4:4ef4 with SMTP id
 5b1f17b1804b1-48715fd479amr111341885e9.9.1774525888979; 
 Thu, 26 Mar 2026 04:51:28 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fb3d09dsm25968005e9.0.2026.03.26.04.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:51:28 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: marek.vasut+renesas@mailbox.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/3] Relocate U-Boot in the last bank
Date: Thu, 26 Mar 2026 13:51:06 +0200
Message-ID: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
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

There was a discussion recently on the mailing lists regarding our 
management of memory above ram_top [0]. The tl;dr is that we have two problems.

The first one is that U-Boot always relocates to the top of the first available
bank unless there's special board code to sidestep that. The second is we don't
successfully deal with devices that can only do 32-bit DMA.

This patch series deals with the first problem by adding a Kconfig option
allowing platforms to relocate to the top of the last discovered bank.

It's worth noting that this is easily testable with QEMU

qemu-system-aarch64 -m 8192 -smp 2 -nographic -cpu cortex-a57 \
    -machine virt,secure=off \
    -bios u-boot.bin \
    -device virtio-rng-pci \
    -drive id=os,if=none,file="$image" \
    -device virtio-blk-device,drive=os \
    -object memory-backend-ram,id=ram0,size=4G \
    -object memory-backend-ram,id=ram1,size=4G \
    -numa node,memdev=ram0 \
    -numa node,memdev=ram1

# RELOCATE_LAST_BANK not set
Hit any key to stop autoboot: 0
=> bdinfo
[...]
relocaddr   = 0x000000013f66c000
reloc off   = 0x000000013f66c000
[...]
lmb_dump_all:
 memory.count = 0x1
 memory[0]	[0x40000000-0x23fffffff], 0x200000000 bytes, flags: none
 reserved.count = 0x2
 reserved[0]	[0x13d507000-0x13d509fff], 0x3000 bytes, flags: no-notify, no-overwrite
 reserved[1]	[0x13d50aff0-0x23fffffff], 0x102af5010 bytes, flags: no-overwrite
devicetree  = board
[...]
TLB addr    = 0x000000013ffe0000
irq_sp      = 0x000000013e50aff0
sp start    = 0x000000013e50aff0
Early malloc usage: e88 / 2000
=>

# RELOCATE_LAST_BANK enabled

=> bdinfo
[...]
relocaddr   = 0x000000023f66c000
reloc off   = 0x000000023f66c000
[...]
lmb_dump_all:
 memory.count = 0x1
 memory[0]	[0x40000000-0x23fffffff], 0x200000000 bytes, flags: none
 reserved.count = 0x2
 reserved[0]	[0x23d507000-0x23d509fff], 0x3000 bytes, flags: no-notify, no-overwrite
 reserved[1]	[0x23d50aff0-0x23fffffff], 0x2af5010 bytes, flags: no-overwrite
devicetree  = board
[...]
TLB addr    = 0x000000023ffe0000
irq_sp      = 0x000000023e50aff0
sp start    = 0x000000023e50aff0
Early malloc usage: e88 / 2000
=>

[0] https://lore.kernel.org/u-boot/CAC_iWjKFAzpj3B_MEW7-dnOrcAV-rfkhXXo8Bv0KgLNP2VJxRA@mail.gmail.com/

Ilias Apalodimas (1):
  common: Allow relocations on the top of the last bank

Marek Vasut (2):
  fdtdec: Deduplicate iterator function
  fdtdec: Introduce fdtdec_setup_mem_ram_top() to determine end of
    topmost DRAM bank

 Kconfig          |  7 ++++
 common/board_f.c |  2 ++
 include/fdtdec.h | 16 +++++++++
 lib/fdtdec.c     | 89 +++++++++++++++++++++++++-----------------------
 4 files changed, 71 insertions(+), 43 deletions(-)

-- 
2.51.0

