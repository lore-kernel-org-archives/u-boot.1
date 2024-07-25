Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328ACC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B801787E30;
	Thu, 25 Jul 2024 15:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QgFvN4in";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F7787E3F; Thu, 25 Jul 2024 15:58:43 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3FDD86463
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-39948831566so2294815ab.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721915919; x=1722520719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=shegv2CHqFhk9CZevUaG0CX7Kssw4jRD2XNsFny/ehE=;
 b=QgFvN4inceGJv/5PdhpopZZ3bXS/GYa+uNkYfB5hxfl0JVyLB6Rjbp5W+7IHs462DB
 FLyzcr4bWss7rVZsGGX6hNnyfw0vCDdIv9pcK50ERB2odQ2u4Bgp+lSkR2IVQTx3T9FV
 Ekt9tvBk2ILz24OJLMvu2KZm+RAIJQIsgYHdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721915919; x=1722520719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=shegv2CHqFhk9CZevUaG0CX7Kssw4jRD2XNsFny/ehE=;
 b=qrPx5sW2V3Zl1XlgL4HiuNmooxdgPwgBFqnhmpdsH2+JqNRjFAM3I3UdBinEpWom8S
 KPRYRbohBMb5JsaMdLjZTzeMMHHIfZIH9uVIg15moEj1eJuYdP61OXHkIn3l2bK/DYyy
 0m4QXgZdvplnNVULCon4/R3r3rbl34XTaM0aSdWp5O/btuEBS7xUeFLF1u0K4+DiaB+Z
 gJAzeev5wyWOAlImcq3NUCxbPDBYdhvYSHDfT/ZxggsSHtzhcLy0aCvCRzuMfPnosSBZ
 pxtO8kJ+y1Hhe7+UE6I/RqVDb23IfBNFMq+v2AzeKu/6cQY+y4GI/zFnsxWzf5tG05vX
 s2ow==
X-Gm-Message-State: AOJu0YwQhqKnDB6+pONB9ziw+iqITxWgOu1Hs2PbHvdEJGrxNEMWIYcX
 UNd82FJMj0O/VektIwQBRVcAuD5cIElbBz9Z9YK4nOetiM1fLdHmMYHOya3TpRrd5SxDiLYGSxI
 =
X-Google-Smtp-Source: AGHT+IEZ8Pzua+Cgj2k2jzeUt6CMXbt7s6nA+RWPHnu6Q0KfrzWQhqL/xXv6wS/9vOihLxF2abicPA==
X-Received: by 2002:a05:6e02:20e2:b0:396:5af7:64d1 with SMTP id
 e9e14a558f8ab-39a2400fcd9mr26387975ab.18.1721915919568; 
 Thu, 25 Jul 2024 06:58:39 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a23105f6bsm6015445ab.76.2024.07.25.06.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 06:58:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 0/6] efi: Start tidying up memory management
Date: Thu, 25 Jul 2024 07:56:23 -0600
Message-Id: <20240725135629.3505072-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

We have been discussing the state of EFI memory management for some
years so I thought it might be best to send a short series showing some
of the issues we have talked about.

This one just deals with memory allocation. It provides a way to detect
EFI 'page allocations' when U-Boot' malloc() should be used. It should
help us to clean up this area of U-Boot.

It also updates EFI to use U-Boot memory allocation for the pool. Most
functions use that anyway and it is much more efficient. It also avoids
allocating things 'in space' in conflict with the loaded images.

This series also includes a little patch to show more information in
the index for the EFI pages.

Note that this series is independent from Sugosh's lmb series[1],
although I believe it will point the way to simplifying some of the
later patches in that series.

Overall, some issues which should be resolved are:
- allocation inconsistency, e.g. efi_add_protocol() uses malloc() but
  efi_dp_dup() does not (this series makes a start)
- change efi_bl_init() to register events later, when the devices are
  actually used
- rather than efi_set_bootdev(), provide a bootstd way to take note of
  the device images came from and allow EFI to query that when needed
- EFI_LOADER_BOUNCE_BUFFER - can use U-Boot bounce buffers?

Minor questions on my mind:
- is unaligned access useful? Is there a performance penalty?
- API confusion about whether something is an address or a pointer

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=416441


Simon Glass (6):
  doc: Show more information in efi index
  efi: Convert device_path allocation to use malloc()
  efi: Allow monitoring of page allocations
  efi: Avoid pool allocation in efi_get_memory_map_alloc()
  efi: Use malloc() for the EFI pool
  efi: Show the location of the bounce buffer

 doc/develop/uefi/index.rst               |   2 +-
 include/efi_loader.h                     |  24 ++++
 lib/efi_loader/efi_bootbin.c             |  10 ++
 lib/efi_loader/efi_device_path.c         |  43 ++++---
 lib/efi_loader/efi_device_path_to_text.c |   2 +-
 lib/efi_loader/efi_memory.c              | 148 +++++++++++------------
 lib/efi_loader/efi_setup.c               |   7 ++
 7 files changed, 133 insertions(+), 103 deletions(-)

-- 
2.34.1

