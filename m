Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC14CEDDA3
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 00:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C16088D8F;
	Thu, 10 Oct 2024 02:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h7+iQNP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 783BE88E3F; Thu, 10 Oct 2024 02:29:16 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3142088AE4
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 02:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-716a601d931so220217a34.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 17:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728520153; x=1729124953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QuwizizE/7SMhQLJ742Hu273XqnodQlIBYFp794LedE=;
 b=h7+iQNP25jSwEGRK7vn7Skbk/sXpkBXPjFjDqDiXhkxuWmF0O9Ina0ct7MtogablKM
 UeRQVdZqoI9CzXv5JFPGv4jlWq8UOmjydfGNVx4B7V/hkZjhbb160VNeZeT9PoKEqWV7
 xM1Snb3zFy8WI1xO3EpUdNbJrsfIqE0eMAkDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728520153; x=1729124953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QuwizizE/7SMhQLJ742Hu273XqnodQlIBYFp794LedE=;
 b=MR2fRo9CVYmZjdaq/Dhwpd0FtSrLmUd9oithSnNLz0cKqg4PWGyEpUFhKarb8/ueVO
 eDKnVe4E2COxNpUnaknl/ivuvqgo5MwMmofqjEeWclpWUWWu80qyXr48LkIY00HO/FzO
 /kWWhfMjsgmnCAX0CqtTUL7BwSPoUyduD2LLtcdg4upMlSZMKgeTUYBnvuAbF0YCnc6i
 y3J0rkLoaMmZyesl+Fg6HWxL78HQq1QBp14jftNqyUECOTHzccl7oT4Wg6WwWBt8yWky
 GR4hLk8VQmBI90WAA1ziCnqFJqRNkOQEyjrR5pUHKOmTm29T3NqnMjl082ecTWtxTB8H
 Rlrg==
X-Gm-Message-State: AOJu0YwHXCwCEo0Fz1eexwhEoCO43aZVbYy7ap2HCx8cL3UZ6HzCn9lh
 wZMPWW0UeJagl4an2ESUnO+YB6AlfxtkbWWeRZmupyeiLQkHPcrSQfxjt+RStlmUK7qUx4V1OvD
 fjQ==
X-Google-Smtp-Source: AGHT+IFtlozOxHL+fpPsF7Z3p40EYB19KmlDSkLKhyiTYHeEt8l5QArxVryfw4jrfg1jgBWoZkir8Q==
X-Received: by 2002:a05:6830:b84:b0:710:9f33:a37 with SMTP id
 46e09a7af769-716a41dc42fmr3307377a34.18.1728520152755; 
 Wed, 09 Oct 2024 17:29:12 -0700 (PDT)
Received: from chromium.org (c-73-153-3-119.hsd1.co.comcast.net.
 [73.153.3.119]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-717cfed7536sm9073a34.2.2024.10.09.17.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 17:29:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 0/8] test: Minor fixes to test.py
Date: Wed,  9 Oct 2024 18:28:57 -0600
Message-ID: <20241010002907.19383-1-sjg@chromium.org>
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

This series collects together the patches from the Labgrid series which
are not related to Labgrid, or at least can be applied independently of
using Labgrid to run the lab.

Changes in v7:
- Fix 'board' typo
- Split out from earlier series
- Rebase on -master

Changes in v4:
- Expand the commit message

Simon Glass (8):
  test: Use a constant for the test timeout
  test: Avoid failing skipped tests
  test: Create a common function to get the config
  test: Move the receive code into a function
  test: Separate out the exception handling
  test: Detect dead connections
  test: Tidy up remaining exceptions
  test: Fix mulptiplex_log typo

 test/py/conftest.py            | 60 +++++++++++++++++------
 test/py/u_boot_console_base.py | 39 ++++++++-------
 test/py/u_boot_spawn.py        | 88 +++++++++++++++++++++++++++++-----
 test/test-main.c               | 16 +++++--
 4 files changed, 154 insertions(+), 49 deletions(-)

-- 
2.43.0

