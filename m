Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B6CC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A7688A6C;
	Wed, 31 Jul 2024 16:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S8CicCVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A3B588A1C; Wed, 31 Jul 2024 16:41:20 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1371C889AB
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-816d9285ebdso238848239f.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436876; x=1723041676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NuroqqdJh+fy4leY+ILW9txcWdqQsJOEZUb6Wahd6zo=;
 b=S8CicCVhpjBdUGVhcn0Xb/KjB+eVPaTIcqe7puiE31oOWmUgGhav8hCzKgZ6Dgadnb
 hufsH2TLmnycdF7QlXMITB0xn/iFUzdI3F7KBcn3Af/WD773YX4q+aChcZ9VhGs/W9YJ
 qe/4lKLoPU+evHgNRaRRhw7o2SS9JYduVSy6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436876; x=1723041676;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NuroqqdJh+fy4leY+ILW9txcWdqQsJOEZUb6Wahd6zo=;
 b=FVpTXwAdcU6esnGEUDlHVNc7VogCGlstXat9BEzkya0tfGdcPE46/BHnnpg73EI3Vj
 4Nf8THPFJnHcYpSDUmrHkP/vUV6CDd+oeSh7ICFp56uNV00vAXQLQCtG67Iyf73d9I1n
 V9TcogbgDAxtVbMG/o57x6Y2rAwvZlJd5ysP6UfcClSD/yk3favsOLxi6On9eMPs4AvJ
 xU3UOuXa4rPNZgcnn0wb3GIS+9zDH6PIs3hlQdiKRVn2D2sjBtz7VE7otD/7g7dMBBRo
 h0dF6Ei2NWlzQidXsTYwGu78wmRROy+9MLtZTOhYQiI2wASFvaSGoVREXPCoJsPR2926
 7xvQ==
X-Gm-Message-State: AOJu0YwF+5UAW4mJR4znB6bEGYbnlXhz5Q0mOieEfej+78xi1napCkBV
 iXWmzFv2sbZRTnahRt8yqiCf4U8FMkNjXoZx9jNqcAO5vaO2/ubmrhnCadJpBc/w+cqZNgVrOjo
 =
X-Google-Smtp-Source: AGHT+IHn30nGH08IdRXV0JD2nwgOJiXgOTxvUgZUVqn1kVKJjXkKDpXkfBOMVVjYaITjtUPRhii1NA==
X-Received: by 2002:a05:6602:2dcf:b0:806:f495:3b34 with SMTP id
 ca18e2360f4ac-81f95a411f7mr1668349039f.2.1722436876611; 
 Wed, 31 Jul 2024 07:41:16 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fc0a569sm3209770173.126.2024.07.31.07.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:41:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 0/5] video: Improve syncing performance with cyclic
Date: Wed, 31 Jul 2024 08:41:07 -0600
Message-Id: <20240731144112.787509-1-sjg@chromium.org>
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

Now that U-Boot has a background-processing feature, it is possible to
reduce the amount of 'foreground' syncing of the display. At present
this happens quite often.

Foreground syncing blocks all other processing, sometimes for 10ms or
more. When pasting commands into U-Boot over the UART, this typically
result in characters being dropped. For example, on rpi_4 it isn't
possible to paste in more than 35 characters before things fail. This
makes updating the environment or entering long commands very painful
over the console, since text must be pasted in chunks, or the
vidconsole device must be dropped from stdout.

This series introduces background syncing, enabled by default for
boards which use video. The sync rates for foreground and background
are configurable.

With this series it is possible to paste in any amount of text to the
command line. Some sandbox-specific workarounds can now be removed and
sandbox video (./u-boot -Dl) is significantly more responsive.

This obviously increases code size, since it enables a subsystem not
normally used by default. However it only applies to boards which have
VIDEO enabled, which are presumably less worried about memory space
since the video code is fairly large.

Also it is possible to disable CMD_CYCLIC and reduce the growth to:

   aarch64: (for 1/1 boards) all +1081.0 rodata +65.0 text +1016.0
       arm: (for 1/1 boards) all +945.0 rodata +65.0 text +880.0

Without that, the increase doubles.

It is of course possible to disable CYCLIC and still use VIDEO but this
reverts to the current behaviour

Changes in v4:
- Imply SPL_CYCLIC if WATCHDOG is enabled

Changes in v3:
- Drop inclusion of kconfig.h in cyclic.h
- Adapt to new cyclic API

Changes in v2:
- Add an SPL_CYCLIC symbol
- Add a lot more explanation about the header files
- Expand help for CONFIG_VIDEO
- Fix 'groth' and 'work-around' typos in cover letter

Simon Glass (5):
  cyclic: Add a symbol for SPL
  video: Move last_sync to private data
  video: Use cyclic to handle video sync
  sandbox: Increase cyclic CPU-time limit
  sandbox: Drop video-sync in serial driver

 common/Kconfig                    |  9 ++++++
 common/Makefile                   |  2 +-
 drivers/serial/sandbox.c          |  2 --
 drivers/video/Kconfig             | 35 +++++++++++++++++++++
 drivers/video/video-uclass.c      | 52 +++++++++++++++++++++++++------
 drivers/watchdog/Kconfig          |  2 ++
 include/asm-generic/global_data.h |  2 +-
 include/cyclic.h                  |  5 +--
 include/video.h                   |  2 ++
 9 files changed, 96 insertions(+), 15 deletions(-)

-- 
2.34.1

