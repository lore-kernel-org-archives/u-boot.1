Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78F3C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA83088970;
	Mon,  2 Sep 2024 00:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DIy7YEnV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A7E888C8; Mon,  2 Sep 2024 00:23:07 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581538690D
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-82a3096ae9aso106677239f.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229383; x=1725834183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0s/2NnUwB+0MeyUyVH5fMQGhx0okHuKRo6o0nhrvE8=;
 b=DIy7YEnVH48LGU7Wi1x1cD1vyUMg46lPNqtzLczPJDWCFE/nPmcAuwskUgD2szZl5L
 cdFgtpeBTYbfSiwJV5ct8p78wEVO8wB/LXuczilc3dZZCabpWgr+C7e1qa7HxU2IFLza
 jks4Dcv1z8xp1SdO2ULhtvYybDF4s6ssfr+Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229383; x=1725834183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0s/2NnUwB+0MeyUyVH5fMQGhx0okHuKRo6o0nhrvE8=;
 b=SiVoI9onyHBpd2dbPKMtYq4y0gkz5eMXo30jDDWnj+8OpRJw6yBWYoZMNTZ3p/MRhe
 hCZ2rs8fckHeNnWc9X1Sp0TDiH8cMFYC8AI7hAiXIpT/i7W/Z6qinW+vVK+zX0zLjaIN
 iO0ZrNScnu7UzoxGubCNMB7Zkz2hFsJPT2H3OgqdIhLU2luJIzNlUpx+r2lhRMPDaYP8
 EbiolfOfdirFUz6D5Nj2+6Pdae4Gzs4lYzL65w6fSlcjHF8LPrq2VxQ9Gh/C37oT03RG
 Hh6G0L14FnsJU3dEkdcLW2cJohBOQEF9FcLQWthgs/5ncScNpV35G8A+1bulacVyhpy2
 HVzQ==
X-Gm-Message-State: AOJu0YzGpS4NKRk10P6qAOnCk62jz4+j0ISfMkP5CNPCyrMgNdPcGcY6
 SeCGRa6dp+MMEkrcDKdoWZerf42JmOKZk5swE78VQBdgIRhNYZYI21dJ7i5yTgPg3yMjp7OgdOo
 =
X-Google-Smtp-Source: AGHT+IHmQiJp2mYXmdKPn9i2FDzt1JJskBERtHYCTf+u+FSibvwF5omcZ/JmnLSJ6pAhOQnZnAEe5A==
X-Received: by 2002:a05:6602:2c13:b0:803:cc64:e0bf with SMTP id
 ca18e2360f4ac-82a10e22177mr1555049839f.2.1725229383365; 
 Sun, 01 Sep 2024 15:23:03 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a2f0759sm213887339f.2.2024.09.01.15.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:23:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 0/3] efi: Start tidying up memory management
Date: Sun,  1 Sep 2024 16:22:56 -0600
Message-Id: <20240901222259.456932-1-sjg@chromium.org>
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

Changes in v3:
- Add new patch to drop the memset() from efi_alloc()
- Drop patch to convert device_path allocation to use malloc()

Changes in v2:
- Drop patch 'Show more information in efi index'
- Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
- Add the word 'warning', use log_warning() and show the end address

Simon Glass (3):
  efi: Drop the memset() from efi_alloc()
  efi: Allow use of malloc() for the EFI pool
  efi: Show the location of the bounce buffer

 common/dlmalloc.c            |   7 +++
 include/efi_loader.h         |  29 ++++++++-
 include/malloc.h             |   7 +++
 lib/efi_loader/efi_bootbin.c |  11 ++++
 lib/efi_loader/efi_memory.c  | 119 ++++++++++++++++++++++++-----------
 5 files changed, 136 insertions(+), 37 deletions(-)

-- 
2.34.1

