Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB73E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC10805C5;
	Mon,  6 Jan 2025 15:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jYsWgBrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EADF88056D; Mon,  6 Jan 2025 15:48:05 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82634801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a9caa3726fso52156025ab.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174882; x=1736779682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vZ8pzXxZRxWlktoK80v4vUx4fbUwxbdlhPhwm/LtxUM=;
 b=jYsWgBrvMMsedeRuzDNZDmyc+Ibz6SO1IsaKbusFYDq6LCch/E7rKF3LxdsR+hJVS9
 sjWZy6uQMGdLKLqypTeIckmkmk5nrIMEaisYrs9oodZaajsDsETq8C+EDtm+DWnEcR/K
 BSKGTmXhG3/G6DRFaQItFi+llvwmV7DsFJLLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174882; x=1736779682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vZ8pzXxZRxWlktoK80v4vUx4fbUwxbdlhPhwm/LtxUM=;
 b=nZkvwUYQm3cu6XaQgIgZ2I4QUExk/0fqIf5rymrU3+2a+RmrKNBmckmxxVGOlvckOf
 dfIO+wOUHXDfzA/41+L592PlC0PPD6GGJw4v3MFFjLSyzeYZJAoWm2wSILSWHZi8jt7k
 7z7cssnrDVFbzGH6fmjizMYJQWyKkL8S6zoKsjeDOITGmZfPryoSmllm73DEmiesGA76
 nPo6+7psTO27Bvr/r2WQuEUztmu2xeoliOcU8YTGlQF7BMljnq7dJc5OZ1JO+uQ1IBqU
 6/S/pvyRuJnOvNa03n/4VTumZ8j/BqlWyocNs1VqXP4o58Q78ZKTtpMTqQ/Las3/mLQE
 /cvg==
X-Gm-Message-State: AOJu0YyCsHrjgRt8UofaVTtUmhnDOEhyYANA8qadTGAioJk2Lnx3abNj
 3WToLQ7V2aXMVkYPn1llhKmky8BnfQUvN4KouGEGjGDIPFYgsQffwdKJt/0biABIJQoZQh/QNTo
 =
X-Gm-Gg: ASbGnctruVUosW2UhiBC7UcXCwrYlcDrFKw0oy6fj3q6QjxQ3+ejL1cmst10gFbb+T9
 9ZO4ibw2oJJxDYfv4uIeLxx1YGUtF2peQ+XaeZWsTN1uNnLNU/OybsDyADGbpJ3AcrTytS7bp6y
 0Ea6G1jJLJS0KnPxZYCvMm7Cj4lmtjx+G3pXqvT5L/h4gSC2SlTvYonRswuu1PjyvCr1t70cEDt
 7B/VCeqSq65OidwGS3adTxIqIJCmBs3Fs+UOlzFnFlHlnIrAzdnIuGkH3A8M5r6G3VuMVU5e4Xs
 XONdRa2b3gbvqNl6OQ==
X-Google-Smtp-Source: AGHT+IG4wdw/g/r+6uxBR/dLXmrSQnGC/1b+MxwqCqQGVElekVckVwvzDOsbnmjikZGHhvm+YXXmYg==
X-Received: by 2002:a05:6e02:16c5:b0:3a7:e1c3:11f5 with SMTP id
 e9e14a558f8ab-3c2ff00f349mr497587975ab.6.1736174881682; 
 Mon, 06 Jan 2025 06:48:01 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c37bb139a0sm94081185ab.70.2025.01.06.06.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:47:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
Date: Mon,  6 Jan 2025 07:47:47 -0700
Message-Id: <20250106144755.3054780-1-sjg@chromium.org>
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

This test was hamstrung in code review so this series is an attempt to
complete the intended functionality:

- Check memory allocations look correct
- Check that exit-boot-services removes active-DMA devices
- Check that the bootflow is still present after testapp finishes

The EFI functionality duplicates bootm_announce_and_cleanup() and still
uses the defunct board_quiesce_devices() so a nice cleanup would be to
call the bootm function instead, with suitable modifications. That would
allow bootstage to work too.

This series is based on sjg/master since the EFI logging was rejected so
far.


Simon Glass (8):
  sandbox: Make USB controller as having active DMA
  efi_loader: Fix display of addresses in log
  efi_loader: Return the memory map in pointer format
  efi_loader: Correct bounce-buffer setup
  efi_loader: Check memory allocations in bootflow_efi test()
  efi_loader: Update testapp to get memory map correctly
  efi_loader: Check that the bootflow is not removed by app
  efi_loader: Test that active-DMA devices are removed

 drivers/usb/host/usb-sandbox.c |  1 +
 lib/efi_loader/efi_log.c       |  5 +--
 lib/efi_loader/efi_memory.c    |  9 ++--
 lib/efi_loader/testapp.c       | 37 ++++++++++++++++
 test/boot/bootflow.c           | 78 +++++++++++++++++++++++++++++++++-
 5 files changed, 122 insertions(+), 8 deletions(-)

-- 
2.34.1

