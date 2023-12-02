Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A2EC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 15:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F5998761B;
	Sat,  2 Dec 2023 16:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J0njS2OV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1EEB87616; Sat,  2 Dec 2023 16:34:16 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E885E87623
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 16:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d04c097e34so11518825ad.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 07:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701531251; x=1702136051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5sBpdDeTxnXfhdyMMFWCYiZ3d6WbHZS5J43WIzrq3qI=;
 b=J0njS2OVe6wC2Q14YLoOJlnG9m9MW8sbfaO2gzxJRWHAjWaJ6SGFTYxtMRNZCj0inn
 yPYEJFV5PfswqybfcGNJ+ZNmmnJlJRRxuGK6PaS6p8t3hDbrGNNHHFeIMKwGWGLnNTOa
 mBs7WSUUyBiEGn4DcrTCQSOrWKZomtSfNooq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701531251; x=1702136051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5sBpdDeTxnXfhdyMMFWCYiZ3d6WbHZS5J43WIzrq3qI=;
 b=FIU3yJ0bbCAWNAG9rHCiuZPP5BT6yBRO7TI7tdKvVx8Hymq2y94BhBdzp6QMUvoAEA
 TCxZEzvaPAH0qWnMLQK0dTEXl0vA4ZQdOyzPonUg4HrVjR8CpvCjVRCHipyJy9NpomVg
 WlTHnxv6JXENG51vx97iru0Xjb8JXSuSa3Vf0UoQD+F0okhd7JYpZDGpdNoYYHYrV/Gx
 1FhciubUTnmmFm6SHpwdG4Q0mlJF55nyRpx2iDILhtPz3eqeEHUSyptXm1on9F3R1LNB
 xFIGGwkuIwItJ5V3am527Fy4I9cyBeCzqHXvA+EeIiM02f8f4l+1lVy5vLe2Vqa8ZYN9
 BIPg==
X-Gm-Message-State: AOJu0Yw+YBfch4xKU4pMFkiR3oN6xHMqBKuSFKh5Ne2vnwbJgZ3NtSWA
 0q8ViCmk+o3cHao+ZKVyKeyJl4eR7VZF302vXvliOg==
X-Google-Smtp-Source: AGHT+IH77dTN/fxd74ta4L2rwli62sLpmsPB7VRr8Vk1d6K4v4fuPLc8r71GLLP/6MGbHonqTJV7vw==
X-Received: by 2002:a17:903:11ce:b0:1d0:700b:3f7b with SMTP id
 q14-20020a17090311ce00b001d0700b3f7bmr1535399plh.53.1701531251096; 
 Sat, 02 Dec 2023 07:34:11 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d30500b001cf8546335fsm2869217plc.5.2023.12.02.07.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Dec 2023 07:34:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v2 0/5] video: Improve syncing performance with cyclic
Date: Sat,  2 Dec 2023 08:33:47 -0700
Message-ID: <20231202153400.537050-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
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
2.43.0.rc2.451.g8631bc7472-goog

