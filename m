Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F088AC3271F
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69370888F6;
	Thu,  4 Jul 2024 09:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UdEmSgWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB8F888E7; Thu,  4 Jul 2024 09:49:10 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DDD1888BC
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42564316479so1856985e9.2
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 00:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720079346; x=1720684146; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/UY0lMathA9FpcjuFGZP2EwzjpjXOmzI8Ciy5SBPk0=;
 b=UdEmSgWfYUgE+A1hjA0RTeudKGnBnAhwzwK442bbzkmlz5fI6UdZws1G7j2CtaplmH
 kug+o29XnYQtUksZtJTEAR14IZJ3UV4hkt04EDNnu/cdkqWzTOsflC2+7SB1MqJ5fCny
 NpG/h3qLK3zEVfzGomc3UZ4WeF11/ZxzFWSZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720079346; x=1720684146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z/UY0lMathA9FpcjuFGZP2EwzjpjXOmzI8Ciy5SBPk0=;
 b=JZbYf7FkvBfY4+7yqEabeghEbsiDN5g/HyT9tFAIK3exTIQI2az0MjvOu5n9WrujGF
 pb1/fRyVfha1iMcP/And2CGMrSbd+s9YdOLUbJSbEtLg+zy8udrCWJawMyuOi+PLpaH6
 BGEvzIilwhrcb2UMq5k33XCpw57OzZKZk6ZxhZAuzOze0IPqyhVJ/hZFWtx+DJxP1JXk
 wECWPFenKRiDpoa8pvDhZDDEQI/ZS8/TFebwzK/OBVQuHIIvhzS/MX3nSoaiX9isjakw
 rrjT8jks7JFxGtl3DVAIsvWRz8RtewDWF4O2XuCoM1K50GLGpuqA/MEbGP/rmyceaH0Q
 NupA==
X-Gm-Message-State: AOJu0Yz+Ht9K0PodMWjvBLMDgVHVfJlJhdd6m8ynoegxCdTMnujznlEc
 ppKJgb+UfL4+ZJ5Cq9FGtuV7lignbk7GxrNXCNFFer+GDxd+xZuCjhqAczq58H1xhMmhJU95Cs4
 =
X-Google-Smtp-Source: AGHT+IH4bDqu++fhebGh2jbv9gkkfQYhk/MmOpv9p305GR2INtysM8X3K7a++nCrYEN0SW0Bao0uTg==
X-Received: by 2002:a05:600c:56d0:b0:425:5f0e:bb69 with SMTP id
 5b1f17b1804b1-4264a41f897mr7672265e9.38.1720079345569; 
 Thu, 04 Jul 2024 00:49:05 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca5casm12885515e9.32.2024.07.04.00.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 00:49:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, Bin Meng <bmeng@tinylab.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>, Ondrej Jirman <megi@xff.cz>,
 Peter Robinson <pbrobinson@gmail.com>, Randolph <randolph@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Troy Kisky <troykiskyboundary@gmail.com>, Ying Sun <sunying@nj.iscas.ac.cn>
Subject: [PATCH v3 0/5] video: Improve syncing performance with cyclic
Date: Thu,  4 Jul 2024 08:48:54 +0100
Message-Id: <20240704074859.2956745-1-sjg@chromium.org>
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
 drivers/watchdog/Kconfig          |  1 +
 include/asm-generic/global_data.h |  2 +-
 include/cyclic.h                  |  5 +--
 include/video.h                   |  2 ++
 9 files changed, 95 insertions(+), 15 deletions(-)

-- 
2.34.1

