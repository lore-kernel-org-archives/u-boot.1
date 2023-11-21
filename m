Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B091BC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB8D875A1;
	Tue, 21 Nov 2023 03:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dIxGRQe0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B245875C6; Tue, 21 Nov 2023 03:09:41 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1F2E87584
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6d31f3e8ca8so3085005a34.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700532575; x=1701137375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aABA81EXDdllEfHt5IKn28N5dynTsWEaK5lCsTLcsgE=;
 b=dIxGRQe0qWuninoafO+SmNYioMZVKQREALsQi1HYxqTzX75hkL8XmeXBNGdmyZuelK
 UEVwb59CuLd2v18aZcwZi/E1ucl42KAWNDL2oxFPdLOhpewMkQqGN5AaZ0shfDloZvtv
 QVxs0ele9J2vP5qbAZ2/vxkbVqbaPXCkzC0Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700532575; x=1701137375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aABA81EXDdllEfHt5IKn28N5dynTsWEaK5lCsTLcsgE=;
 b=QJz4Gy0Lcg+A2ub7X2FVdISG4bfjRE4z74iQMjjpoXTH1uCCrSxBHz21GyQ0PpUZ1i
 03AT1ssBqYADgZjGyV+Wv+q8QYit/a+BNi865/x/kkFfI6ClltVMrZDdfj4H0cIup6pe
 ESJmx6QxF6nNKnF5PspEvApBd1Mqr1AjcevwpuPkdeE8hjQZLpVs5RupPwjZEzDOlK8h
 OY6g+szzzDf7nZK9FWlozbD+jbJACOxyI9B3cenTVsX19/IxzQRIi2e0k7rHgE/GFN+7
 24BgLGc4YMmfAss2fkDTQCdVpHx2vRmEjaBAs85ravWlvNAEKMPo2efMmHEsnvoZetqx
 xC3A==
X-Gm-Message-State: AOJu0YwcXjvPsR+XWr/7Q/f+mQSF48lBQySyu4TOFa5AVVAKCZ3pUfKq
 17ynLRTabmD/T9xbfku+qJ5s3PutjcuqZ55IT+3ouQ==
X-Google-Smtp-Source: AGHT+IEv7Ylc+QWIsb4k0mTkk1nFE5zpXElr8gYuk1ArDuqmKrvqCdZJxcKYLg35IsGuOV5LPKsZlw==
X-Received: by 2002:a05:6870:6b0a:b0:1f4:be52:b129 with SMTP id
 mt10-20020a0568706b0a00b001f4be52b129mr11566438oab.56.1700532575460; 
 Mon, 20 Nov 2023 18:09:35 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 du20-20020a0568716e1400b001e12f685592sm1542693oac.13.2023.11.20.18.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 18:09:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng@tinylab.org>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v2 0/5] video: Improve syncing performance with cyclic
Date: Mon, 20 Nov 2023 19:09:24 -0700
Message-ID: <20231121020932.733405-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
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
 drivers/watchdog/Kconfig          |  1 +
 include/asm-generic/global_data.h |  2 +-
 include/cyclic.h                  |  6 ++--
 include/video.h                   |  2 ++
 9 files changed, 96 insertions(+), 15 deletions(-)

-- 
2.43.0.rc1.413.gea7ed67945-goog

