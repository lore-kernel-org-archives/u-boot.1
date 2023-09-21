Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959CFE7106D
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 13:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D06B8655E;
	Thu, 21 Sep 2023 15:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jT1Sooxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C0058655E; Thu, 21 Sep 2023 15:37:57 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033BC86380
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 15:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79545e141c7so24089039f.0
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695303473; x=1695908273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KE48hH8WVgsd1bETkPjLJVoXHX9OnAPNe2rWgJeAdo8=;
 b=jT1Sooxh/vwRQv84ufyRRvjw2GRg8zRz+d90CPmHd95WRV1akwNRJzoaYJV7kgx2op
 SMHIO/AB3kT0e2BfECs/KzIRpcwsM1WjlU/cpt4ToGleygJguINktPB9U9md9wv/cQGi
 fua8KQCnV6f0JdSmEMMeokwcnR8CGmG8hpC1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695303473; x=1695908273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KE48hH8WVgsd1bETkPjLJVoXHX9OnAPNe2rWgJeAdo8=;
 b=aiZhfA5VTmX1BQ92f3sQDEE9euvBe5coi2zqTX/IVaGn9C5w9dhMxKWhosqiOXvx45
 cpJX5yGYAud3LYGty6ZxuqREQSZTStDo46zCHmB8xwUbaP01E8cFPIM31awgXzguPeBX
 FUg+1Vu4D7mQ55aqUAnbg8ca5mqC/0+OQmY7dd5GeRhIJd/z7IZ6z7hyCekZWiaQtv9Q
 cfi/kgvi5xayaIiOjA3bxEhdJRxti8vsxeG+N6pqyAy+xJCwf2o/v6773ymeugQGrTSk
 dYV+KfIaklEEHXKxIoIbP/GrvjRtWOIf9wBgExB6Miicc4GdldWip3WkCujnz0w43cS/
 g9bA==
X-Gm-Message-State: AOJu0Yyj6ejaLMhq2qpAxrpy1r7sjnjgy7557zUJGxpnRggIsgVmfyKP
 RafKa7SkNsJeSHttDjGdNnxSzj0+wyiBaNBDBuk=
X-Google-Smtp-Source: AGHT+IEKQBVY0Ab7KNpK37SRflm66vbQ+jATyks4YOfWl1nlLf430D5YZxbFZ1bYUTX0HpX391FX/w==
X-Received: by 2002:a05:6602:34a:b0:790:b44f:b9ee with SMTP id
 w10-20020a056602034a00b00790b44fb9eemr4667782iou.10.1695303473367; 
 Thu, 21 Sep 2023 06:37:53 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 w17-20020a5ed611000000b007835686237asm389786iom.27.2023.09.21.06.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 06:37:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 0/3] x86: efi: Fixes and improvements for coreboot
Date: Thu, 21 Sep 2023 07:37:42 -0600
Message-ID: <20230921133748.1543007-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
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

This little series fixes various bugs and annoyances in coreboot and
coreboot64.

With this both coreboot and coreboot64 start up and work reasonably well
on Brya (x86 Chromebook) and U-Boot can boot common Linux distros.

- Make coreboot64 debug UART start reliably
- Avoid the long USB-init delay on startup
- Correct the timer speed on coreboo64
- Fix a bootstd cros bug (will likely be squashed into another patch)
- Fix the terribly slow console scrolling

With v2 I have also brought in some lost x86 patches so they are all in
one series.

Changes in v7:
- Add new fixup patch to move python control earlier in Makefile
- Add docs about how USB keyboard works on coreboot
- Drop patches previously applied
- Rebase to x86/next

Changes in v5:
- Make use of the uSE_PREBOOT mechanism

Changes in v2:
- Add new patch
- Add new patch

Simon Glass (3):
  fixup: Move python control earlier in Makefile
  x86: coreboot: Drop USB init on startup
  x86: doc: Update summaries and add links

 Makefile                         | 17 +++++++++--------
 arch/x86/cpu/coreboot/Kconfig    |  1 +
 arch/x86/cpu/coreboot/coreboot.c |  4 ----
 doc/arch/x86/x86.rst             | 17 ++++++++++-------
 doc/board/coreboot/coreboot.rst  |  7 +++++++
 5 files changed, 27 insertions(+), 19 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog

