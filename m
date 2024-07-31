Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D67C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E1A988A98;
	Wed, 31 Jul 2024 16:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y1tOPlOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF958897A; Wed, 31 Jul 2024 16:44:22 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B48688A56
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-396675b83afso31981655ab.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437059; x=1723041859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NuroqqdJh+fy4leY+ILW9txcWdqQsJOEZUb6Wahd6zo=;
 b=Y1tOPlOj+i4HDVcrBXWSKJLT6k3RxLs9k0FTHFs+pd0qkGAzhMwPoO9rLQMbQG6Lg8
 r+8PdWVD606F9ocxvJqnOdeZpxXYHnEUu80rNazULG19g77KZPGV2m3XuL91mxAyn+qn
 A4bKfVXXFmrIZg6jLTnDbKzglNu5pZxORgfEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437059; x=1723041859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NuroqqdJh+fy4leY+ILW9txcWdqQsJOEZUb6Wahd6zo=;
 b=QF4K4gHj3csqCZtwB9ZeFQxrDuq6bkWr4cu18mgXCkDPM/yB9Nc9QSGI5IWQX/G4et
 /GGoI/GxLPSESM+wZqqGiMT5cOxl+zkJAIPW9jJLwatwc33ngBBQ92KW2WrrLDlejP3U
 Ro09YtGZWZhylO5qMtOkuMlTIWikuO0dV3LqCDZY2RL7BTT1t7CTVVITbx+qvX3Lbl6S
 +LluwR6mxhT6Fo3i98TMbiyhJnn3lEhom9lu6cVD3tZK/j4qO0WoZx8mm8m4n0L5nnQh
 Dcp0voc7ioRN+PgdWbnpZ1WZQG4Zd4gsNi5mw+vFhqHSb+XabXjaFMAZHs55G5Y4M9/7
 c5KQ==
X-Gm-Message-State: AOJu0YxSE3D4KECMJGuxoSxNqDIE+Z4bdG1kUVERBg6z9rgkMpyJYUNk
 SSMPx2g/MRwI6HaxbTVX9CqZAuTB4v+qM345vapaiTjUCALkEb/yHoW/ybrdjnMwLtQWhO4xrkE
 =
X-Google-Smtp-Source: AGHT+IGwhfRxJy6YeQ5ntKVW3EYlC62h5mRTAwuf9LsmS6arIS0DN1RH4UwcJw19g4db96aLC0eYtw==
X-Received: by 2002:a92:c56e:0:b0:398:623a:2f49 with SMTP id
 e9e14a558f8ab-39aec41a2b5mr164586915ab.27.1722437058816; 
 Wed, 31 Jul 2024 07:44:18 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a22e7e4f9sm55575845ab.2.2024.07.31.07.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:44:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 0/5] video: Improve syncing performance with cyclic
Date: Wed, 31 Jul 2024 08:44:07 -0600
Message-Id: <20240731144412.790317-1-sjg@chromium.org>
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

