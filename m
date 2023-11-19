Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77694C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 14:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD8EC86F44;
	Sun, 19 Nov 2023 15:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kdCmCS3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34C6D8718D; Sun, 19 Nov 2023 15:47:13 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B853A86C89
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7a689bd4928so113172239f.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 06:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700405226; x=1701010026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e/50v6nM+BPZo+qysRRKi+MZO9M5WtRiWsIJbM32VYI=;
 b=kdCmCS3D+aREhzcMSp5rjdRJL9n9SIbqbUhG4oZc1wBL+rT0w1TacoiOqDuMlpE5Y8
 +mB9DSOvxwkithMaNuNaPpXKXI1eBj1SWRYBoXUUQqWG2XyIU+62boSDkSIoicDH55hn
 LEFoW3/l3AiqETF6ELjmq0DcaSRbpsmEVxglE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700405226; x=1701010026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e/50v6nM+BPZo+qysRRKi+MZO9M5WtRiWsIJbM32VYI=;
 b=MG8WbJAH7cc9joY8rqOoh6zuAJjO0qgv32v3sbdMo8xqXNm9USS8j08UMQbkhtVsla
 egk49qJM9VWhCoCGd4Qs876KIrYdu6Fj7AJYY1o4vR+97dTSTr6/iFDD6KnCwUGLQfsw
 Ou10kUMfoI6AJwUq89DZDwqrRu8gFVTeKG5480FvcyoZPOvuwl7r6+a/7+EiC9Q+rVLN
 Z1bRMKZxv5OMzrhELoqTdlcmQbGSFB/SwIeDFMiviK5BRVlB48xazLNgIvHGlkNYT9v2
 vk6FXBCwStytV39vtfnKUQuzE7wqV5vXSMcQ5wfrIg89SpR1EgCH6CDMEsjHfTDH08Cv
 XIEQ==
X-Gm-Message-State: AOJu0Yy58HYc2aMlY4dHjpLYs/if/qdPEmxmpZ2At11kdkXavOtsoy7E
 4TLAYllatZ0ouNayfVSj3RAudOE8ulQsyPbb+aIrww==
X-Google-Smtp-Source: AGHT+IEZEv9LW9O6KhjGz5uBFuFS+JQulmxZYRk3c2u9I2qnJWs5l78Dw+YqNqo/yjSr2TU4CpB0RQ==
X-Received: by 2002:a92:6a0d:0:b0:357:592a:8c4a with SMTP id
 f13-20020a926a0d000000b00357592a8c4amr8984666ilc.12.1700405226160; 
 Sun, 19 Nov 2023 06:47:06 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a023946000000b0043194542229sm1450695jae.52.2023.11.19.06.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 06:47:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: [PATCH 0/5] video: Improve syncing performance with cyclic
Date: Sun, 19 Nov 2023 07:46:38 -0700
Message-ID: <20231119144700.631322-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
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
command line. Some sandbox-specific work-arounds can now be removed and
sandbox video (./u-boot -Dl) is significantly more responsive.

This obviously increases code size, since it enables a subsystem not
normally used by default. However it only applies to boards which have
VIDEO enabled, which are presumably less worried about memory space
since the video code is fairly large.

Also it is possible to disable CMD_CYCLIC and reduce the groth to:

   aarch64: (for 1/1 boards) all +1081.0 rodata +65.0 text +1016.0
       arm: (for 1/1 boards) all +945.0 rodata +65.0 text +880.0

Without that, the increase doubles.

It is of course possible to disable CYCLIC and still use VIDEO but this
reverts to the current behaviour


Simon Glass (5):
  cyclic: Disable in SPL builds
  video: Move last_sync to private data
  video: Use cyclic to handle video sync
  sandbox: Increase cyclic CPU-time limit
  sandbox: Drop video-sync in serial driver

 common/Kconfig               |  1 +
 common/Makefile              |  2 +-
 drivers/serial/sandbox.c     |  2 --
 drivers/video/Kconfig        | 30 +++++++++++++++++++++
 drivers/video/video-uclass.c | 52 +++++++++++++++++++++++++++++-------
 include/cyclic.h             |  6 +++--
 include/video.h              |  2 ++
 7 files changed, 81 insertions(+), 14 deletions(-)

-- 
2.43.0.rc0.421.g78406f8d94-goog

