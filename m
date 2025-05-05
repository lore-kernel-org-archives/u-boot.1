Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909DDC3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 183A780BAE;
	Mon,  5 May 2025 17:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RxFCsfYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45FAE81F7E; Mon,  5 May 2025 17:43:53 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E29801BE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5fab81d6677so562946a12.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459829; x=1747064629; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZqgYkJuHSrrHiNQbAgnvVhegEon9ef/elZV7G2WAc74=;
 b=RxFCsfYOn6U7CC1YhEpMv7tNMn1x1myF5U8aBzeCsMJCjBupui9Vf10RmbP6vLp4Yo
 AGd4ftn69M48X8hJ73k3r4XL7GwaTtZHBGD/UxaiDQj/W7T9LsxfY/HvfxkPOpw80hP6
 X6MCeT8H9AMEloobgjIrfNw8Ry6IdRBU0UhBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459829; x=1747064629;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZqgYkJuHSrrHiNQbAgnvVhegEon9ef/elZV7G2WAc74=;
 b=g6i8NfbTpIaH0pS6MvlYQiQ8bPQpY8Em+EMbj4C+KMLkqTw/FkqI+jxfGC8ACGb+//
 QooKSa5wIqgNnL5Kq0pWzDG0p+laUGGMZgql/C224MN1qpsPEgroHjaD9k/mYV3gvMz+
 hQG4o8pLOYPwONhm1aGCGcW0R09JC29KrBpebHWsvX2K5J++VQ7v4Ev5BVkAO5JQOPfw
 Miq8wwhnB2pb+snEqX5De/Z2T1lKs2HB66640aC/78gnFPhzaHAlhiSMKk4RD6uL2bvx
 EFZNCaQKenFv8MdEO4kg2ZPejrL3jTypKyxMfm2Q9vlMO2GXolsNTeoXKzG+StEdQHq9
 T/cQ==
X-Gm-Message-State: AOJu0YzuL8Uyoeor7jKvGak7pkNRDm638/a4y5PBgizxaDbUp1hS1K30
 fKpjiNXTryvpvUobgct0fTN4i5D66eWiVEHSqQakaDomdyaryGmAqdHIPUl6DlhkwZo031gFKMv
 ZguAGxOE=
X-Gm-Gg: ASbGnctzuO43q1LqukqoCdWdzia9JMOFA/Xg9+AsYSJmiF38J3LgcrLdy/QryOGwPQj
 t+a9pXT+cZvnDyPvgtAmxrTgDu2TmdtXKc391oYzdT/9mebynvowAQUyNVDWXEk9JZ6BX5mTTZZ
 6UFKXnKpmcfDkvk7WhAcY7gKj/67YRN79nUuqrxYbOGeyyYVdu5nBx3fJ9ijx9BAoRlHUoMGEvw
 aAXrdvPAVo3do1GuwbGC0m+f/+aKKt4msfXPVxI/AusePZHKL/ItbWKUnuVAgzwlXfzxzpBdU7t
 hd/REMJwDAdZaBoxfz7eSWQmbPN4paRU5nn3
X-Google-Smtp-Source: AGHT+IGE9COyFQf6uDRP21/tJTlGj4UbJnHcyCjBAvibDiC6gi/6KXPZyTxzWkTy/ySbkM9A8g9riQ==
X-Received: by 2002:a05:6402:d08:b0:5f8:e6e5:54ac with SMTP id
 4fb4d7f45d1cf-5fab0576506mr6357150a12.14.1746459829159; 
 Mon, 05 May 2025 08:43:49 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:43:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/19] expo: Improve positioning for cedit
Date: Mon,  5 May 2025 17:42:38 +0200
Message-ID: <20250505154308.2911248-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

At present cedits look a little odd when they have both menus and
textlines. This series tidies that up and improves the testing to cover
this situation.

Expos now have 'requested' positions for each object, which are synced
to the actual positions when scene_arrange() is called. This solves a
problem where moving an object or changing and object puts expo into an
inconsistent state briefly, until the scene is next rendered.


Simon Glass (19):
  expo: Comment scene_obj fields which are for internal use
  expo: Use a different logo for the second menu-item
  expo: Create a function to arrange the current scene
  expo: Avoid arranging the scene willy nilly
  expo: Drop the extra parameter to scene_calc_dims()
  expo: Separate out reading the theme from applying it
  expo: Add extra checks for rendering
  expo: Record the pointer position in the menu item
  expo: Arrange cedit after setting dimensions
  expo: Provide a few functions for working with dimensions
  expo: Move menu dims calculations into scene_menu_arrange()
  expo: Check dimensions before arranging a scene
  expo: Simplify scene_textline dimension calculation
  expo: Use a var to arrange horizonal positions in menu
  expo: Allow the menu pointer to be wider
  expo: Drop space from object name in test
  expo: Separate requested bbox from actual
  expo: Honour the textline edit_id when building
  expo: Tidy up insets and improve tests

 arch/sandbox/dts/sandbox.dtsi |   4 +-
 arch/sandbox/dts/test.dts     |   1 +
 boot/bootflow_menu.c          |  16 +--
 boot/cedit.c                  |  16 ++-
 boot/expo.c                   |  67 +++++++----
 boot/expo_build.c             |   6 +-
 boot/scene.c                  | 205 ++++++++++++++++++++++++----------
 boot/scene_internal.h         |  52 ++++++---
 boot/scene_menu.c             | 110 +++++++++++-------
 boot/scene_textline.c         |  49 ++++----
 cmd/bootflow.c                |   3 +
 cmd/cedit.c                   |   2 +-
 doc/develop/expo.rst          |   4 +
 drivers/video/video-uclass.c  |   6 +-
 include/expo.h                |  64 ++++++++++-
 include/video.h               |   3 +-
 test/boot/bootflow.c          |   2 +-
 test/boot/cedit.c             | 152 ++++++++++++++++++++++---
 test/boot/expo.c              |  82 +++++++++-----
 19 files changed, 608 insertions(+), 236 deletions(-)

-- 
2.43.0

base-commit: a15813efc66b624cede0f3c6107ca77abbffe1f2
branch: sche
