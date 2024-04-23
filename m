Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E96C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 07:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A30CA8889D;
	Tue, 23 Apr 2024 09:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CvS/4swz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF6F889D7; Tue, 23 Apr 2024 09:22:27 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A96EF88573
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 09:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-22e6b61d652so1758888fac.0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 00:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713856944; x=1714461744; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+mpNebzz0T0Lu8JkzjNFKJnyHVQ1QBLmrdgV4rebYM8=;
 b=CvS/4swza2hwqiIVxMqh/An56u6b1pBhPT3EVRsVrO+4lJwNUYfhYUWJqLHVgz/vwv
 7n8kV8kHLbMb5foW1bDjrQezhCRdKg9MoRFzyGXhKZCkWOa2rY2Eo8d0vXwa9kW1I7CG
 dp2glM+Cci9lmEcm+i7rfjxptHKo/93Y7r9xcc5lpl0fLRS4xasguOBLFRG3TOtfaCnY
 kMc/IHbst6Ev6QX4xA5ABOTziyLTBKACL3tB4c8+vXFGyy7135PuDAT6rbIrPf80rZQ6
 I0vBfm5zjMvx5Q/r97UHJBCRTuSJiUnfTv45FERff2R5jN154GWxQLe7JqOdtVnRAy/d
 rW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713856944; x=1714461744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+mpNebzz0T0Lu8JkzjNFKJnyHVQ1QBLmrdgV4rebYM8=;
 b=Bb/y1qIxXpaD5YtpC8CtqVJwvnuQx2Nn4PtLbjGr3EjvQcn6LHYvFxu7Ze10p0tVwi
 ZuCQ9Xmo00wnUGLbDCFYDQtJBQdwDH6W48xR/AulBgXWzsQ2Becm/phQhqip5/Pl5yZx
 pHx7/OnsRUwHnuNDcBW9rBwCOa5GAGMxKfLn2xqg1fw0WDSCMT7W9uC50d9aZDv9ozVU
 q39tE5yjBBv20Ln5/Fcxu5CHZ2dS4aghiMUJ9L+DzP5mbLKSm71DgQ3V7Hrl5+dr4qSG
 /Ux+SKTwJm5Nf6gtMeYHFh+r0efYUIz0YcwpUF0QGL1ghmiHBHBh3sxrTFtQoFuazcwf
 Ts2A==
X-Gm-Message-State: AOJu0Yz1hw0MWPYDpYfM78e0G52+TITQDiTvFtKe2ztzs150qBtMNf8G
 rIYeVNCkwSA1X7ejEmNeSKnoOYjS7ixGAlzBhj+WuXZ5fiFZUMj7
X-Google-Smtp-Source: AGHT+IERSci6Y2fHrqh7PGq8IyBPDaVCqTP0h6zcNNYcNS6K1BVhsUnfL9qwhb08KyCFlg412uLt+A==
X-Received: by 2002:a05:6870:d0d1:b0:229:7d01:7e03 with SMTP id
 k17-20020a056870d0d100b002297d017e03mr13637176oaa.43.1713856944307; 
 Tue, 23 Apr 2024 00:22:24 -0700 (PDT)
Received: from localhost.localdomain ([180.217.143.235])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a634c11000000b005f0793db2ebsm8746695pga.74.2024.04.23.00.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 00:22:23 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: YSCHU@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 KWLIU@nuvoton.com, JJLIU0@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/3] Arm: npcm: modify npcm mem and boot issue
Date: Tue, 23 Apr 2024 15:22:07 +0800
Message-Id: <20240423072210.1926141-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

1. Modify npcm memory setting
2. Fix boot error

Jim Liu (3):
  Arm: npcm: fix npcm7xx boot to kernel error
  configs: arbel: increase u-boot mapping size
  board: arbel: Limit the dram effective size to bank0 maximal size

 board/nuvoton/arbel_evb/arbel_evb.c | 14 +++++++++-----
 board/nuvoton/poleg_evb/poleg_evb.c | 27 ++++++++++++++++++++-------
 include/configs/arbel.h             |  2 +-
 include/configs/poleg.h             |  4 ++--
 4 files changed, 32 insertions(+), 15 deletions(-)

-- 
2.25.1

