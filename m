Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB96EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 18:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D23487073;
	Mon, 21 Aug 2023 20:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HQRA2+HU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60A3687071; Mon, 21 Aug 2023 20:13:52 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71CD78700F
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe12baec61so36576585e9.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692641629; x=1693246429;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pXaPNIg6b5yBoQ2bCTOI5/mwOwd34zETzKT/PpqRShk=;
 b=HQRA2+HUWmvxO2I7KSL77FOQKj6I1C2i5brcGAnW0kP4vcU1jqkZ8VyUWtdxSp42CE
 g1BSrvmlzKMRjT4V6PyutPLigyMZ5ITZVv3ov4vgY2AwQmhTOZFiwNcwWjFoezG7O6Rq
 8/TDt0+DmC4YAfNlJeQwb1nOXIevBUCbR3b9S0fOdKMgYITqltgUK56DRN/tN6E6/XBn
 lhyosHUuJX6ozLO98mZLYlIydi7XNFntKwWabZH48TXXG5w8zjsn3eq2yGTuxT8bvcxI
 OzK5m7iwdx0ol/6DjK88u0nyGUBGP7necHutF1dGtc46c8psTPSo5ntNX7Sp6ZBhPokS
 05LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692641629; x=1693246429;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pXaPNIg6b5yBoQ2bCTOI5/mwOwd34zETzKT/PpqRShk=;
 b=dPcQA8llKbw21zwVeWcXkbDBGGOMu7TvOaz/Mw36S2Wrr4Ko//oG3ttvB4OTUwDbrB
 kvGjZIwC76rJ6tZ9p1gxPESYh4FEXZIgXK8iW2oJS3X0ai/DK807TxY6PJgM2+ulQlQL
 n04PXYz6pWFS6kb8RlF9ZdzPw9EsDqf8zcxcLKxtc7ftYeLM4HdF5cq8rJvnKWXsE9+K
 74SUVsaGlm5J+PSb3rP8/SasJybsr2YRkaL/+Tt868PBFTRVnMyy2yStMo+iHd7n5MSk
 Oi5x8FoIvrt0aJuMJHN7Kfkx//4794fH41r52N7GYaF586S+lqwoJ6RduWmiMKBmonb5
 TQyQ==
X-Gm-Message-State: AOJu0Yyv3LGT0d27QLsYQSunA74JdOY+S6gzff5Am289WDiYqltj+TnH
 zfk//RSPFKWe4eHDKbg70gDSY0KPNFE=
X-Google-Smtp-Source: AGHT+IFiJgdfWU+m6ChGK6pL1gFFS+tmuHYva1WtRpKIGFkdiW889WPcH8UWliAneKsGdvDeoVFZMw==
X-Received: by 2002:adf:f8c5:0:b0:317:39e3:7c68 with SMTP id
 f5-20020adff8c5000000b0031739e37c68mr5607767wrq.18.1692641628661; 
 Mon, 21 Aug 2023 11:13:48 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 z1-20020adfd0c1000000b003143c9beeaesm13192025wrh.44.2023.08.21.11.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 11:13:48 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH 0/5] sandbox: video: Refactor out of uclass,
 try partial screen updates
Date: Mon, 21 Aug 2023 21:13:34 +0300
Message-Id: <20230821181339.4135800-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
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

While working on the video damage tracking series [1], I noticed the
10Hz limitation on the sandbox screen refresh rate, and thought maybe
applying the damage tracking idea to SDL would make it reasonable to
increase the rate or even remove the limit completely.

Experimenting on that idea resulted in a bit of a refactoring to pull
sandbox out of the video uclass, so I'm sending it as a series in case
some of it could be useful.

As for the partial update idea itself, I found that having the delay
around 1/refresh-rate appears to be the most visually smooth (about
7ms for 144Hz, 16ms for 60Hz etc.), but couldn't exactly evaluate CPU
usage for which the original 10Hz rate limit was set. In any case, the
visual appeal of sandbox doesn't really matter, so I don't exactly care.

Of course, this applies onto the video damage tracking series that I
recently updated and sent [1], but only the "partial updates" patch
is functionally dependent on it.

[1] https://lore.kernel.org/u-boot/20230821135111.3558478-1-alpernebiyasak@gmail.com/


Alper Nebi Yasak (5):
  sandbox: video: Display copy framebuffer if enabled
  video: Allow deferring and retrying driver-specific video sync
  sandbox: video: Move sync rate limit into SDL code
  sandbox: video: Move sandbox video sync to a driver operation
  RFC: sandbox: video: Use partial updates for SDL display

 arch/sandbox/cpu/sdl.c         | 34 ++++++++++++++++++++++++++--------
 arch/sandbox/include/asm/sdl.h | 13 ++++++++++---
 drivers/video/sandbox_sdl.c    | 30 ++++++++++++++++++++++++++++++
 drivers/video/video-uclass.c   | 14 ++------------
 include/video.h                |  3 ++-
 test/dm/video.c                |  2 +-
 6 files changed, 71 insertions(+), 25 deletions(-)


base-commit: 3881c9fbb7fdd98f6eae5cd33f7e9abe9455a585
prerequisite-patch-id: aad206b8942d0e8654ba1b11f28104950baf1518
prerequisite-patch-id: ee3d21bb91062ebbcf0c3a75342d7fa37d5630ce
prerequisite-patch-id: 7fcaec0bb8b5bbb5b3813bda896034c9b98b67b9
prerequisite-patch-id: aa4173ebedc3f6d0f04f72bf49bed642614f42a7
prerequisite-patch-id: 06676907c4d262880f7904fed33de11057e886f0
prerequisite-patch-id: 63bbfd7808bddea8b39120d50bb61ac1c4b3eeb8
prerequisite-patch-id: 8941f56b57f7ece319eed67ce8584e7769a36a3b
prerequisite-patch-id: b89b375a3221ac1f89f3eb15fa20a2140ea5687c
prerequisite-patch-id: 950508eaecbbc01560a2f24778786dd50e7c20e8
prerequisite-patch-id: c30b2a60881bc813e4d8a7e1a99fd99c368957d2
prerequisite-patch-id: 963770b5a43c750bac620788562ce549ac48dacd
prerequisite-patch-id: 500af25e869687516da147ce7c819c6b32a9bc92
prerequisite-patch-id: b064cd6b7db9cd122f10c2ae2573328ac945b3be
-- 
2.40.1

