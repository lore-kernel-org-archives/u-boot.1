Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DF7C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 09:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F07831C6;
	Wed, 16 Jul 2025 11:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="deOTJAH+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18C96831E0; Wed, 16 Jul 2025 11:58:42 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D482831AC
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 11:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-455fdfb5d04so23675095e9.2
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 02:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752659919; x=1753264719; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZiYD4bqejGWOx7mnZkcckcGcsDMvaFG8aXuQrnZbY+U=;
 b=deOTJAH+Mjck5qtFplokuOyqXrBe/QGeyPVTUhPCdSjUxkKnY18yNuPEb9XfuDwfY0
 qNM0PHXT0Fc3Igs/qLdYBfoJpqNxnnXafpMQshlgVir4dKLodb977yFjSDtHCNHHWRnh
 I6boayfeklnO9uRWOQDfoMGxEHjp8XTpUAU90eAgf00QEn7n+ZdVR9Zonb79GO2bA/Wj
 +Zl1zCOqhVs9LIh5T9NWjIqdlzxQXPOEMKFg8FPMzfYwSzh6z0BFV8BrTiloz7GCWXXX
 tvoop3mn1DgIlXIEJ7YZJKnTMduwCTT/MsIFh0gD1DVJHgVqyptMFIBaULZPMWV281js
 z8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752659919; x=1753264719;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZiYD4bqejGWOx7mnZkcckcGcsDMvaFG8aXuQrnZbY+U=;
 b=P96xyEmRpW5TKUpAidsw6qUJLwTr1SNbN1/nimcazBFQ92jgzJvMsIoItzR8XCGt7c
 InDjnCuaeGZQSWGspYyyfiMpbWyu69mDZfEK/oEvSAHrpJH24CGO/GNR4C/7omFJGwiq
 yPY1n9YO3bZMKkt9KTzAVvhklumHgIECSI1O5poWX6EOFMseBB2VcLBqQBhHaFxyPn8/
 xpj/Nqv/4b7+ge7rRfSFoaf10bC5vQAzVsRjiprcMy3r8MUeT+jv2FD1/eXKj6NDSUhw
 5sPzkb6ldoiYhHhyu1f+U6bY0396eExjn1jczYR2tMTnibqEPUt6uxbPD9XpkV1DFrHR
 UOZA==
X-Gm-Message-State: AOJu0Yx5KTmMqVtveexIfPNW6IT2KteiomgBrKQEJ9FRC+8on2rh0/3Y
 ZXpKR+N+wMaduubbKjWWllaSOWspXSvj8rklrGbsSV8c8tsE7ahPap+RPz6hNJKYsZo=
X-Gm-Gg: ASbGncvdh5mxKxyYg7WaomBW8fT+M5pxU2gCuZL3/BjaW3VY6apDi9dny1COlpOTDxp
 /+U+/dsFoJp35ltSkQqB0PI0uOY6bcXBUShVi5buDn02jxbBsrvbck67UQAdhEn4jUeLPlWOyYh
 BoeUlStMaCWesgvX38O3ZwnhuBRY8+mU1+/7T7BCEKoxCBlXdflPbVqrIiEbbbM2nnIyMO9xzi2
 +H2sjMxYWVXBpzr7EDavqHdS7BQ5KIAEb+yWoZmIg/Ly/gijGCU76b6HxRsOooz17rNv42p4Wfa
 pZXCix2J9be9Em6xqlrRo93XZJ4x7jXrSdBWeRnAYoQ10OwYks75rPTLVYsgmhxVd+CQ4TikoNI
 bL0T0xWZG2cQ4ewIqK+HokNvI84NhhA8QaGCE7YkwVKuTlXQ/hQ==
X-Google-Smtp-Source: AGHT+IFTcfUVCGvP7jx2u1JBpLDu5WJgt/quLqmtxr6Yre2MPP5QQ9r4a7nAG0NpmQTb4Vw5x+SWAA==
X-Received: by 2002:a05:600c:5486:b0:456:c3c:d285 with SMTP id
 5b1f17b1804b1-4562dfd8845mr20917055e9.1.1752659918711; 
 Wed, 16 Jul 2025 02:58:38 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:d584:3606:6325:3ecd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc21e7sm17395270f8f.36.2025.07.16.02.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 02:58:38 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v3 0/2] Remove unreachable code and cleanup code with fixed
 return
Date: Wed, 16 Jul 2025 10:58:37 +0100
Message-Id: <20250714-blk-uclass-v3-0-1fc761606df6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM13d2gC/3WNQQ7CIBREr2JY+w1QSqsr72FcAP1tiRUMVKJpe
 nehOxNdvpm8mYVEDBYjOe0WEjDZaL3LUO13xIzKDQi2y0w45TVtmAA93eBpJhUjVEK2wlDWS2p
 IFrSKCDooZ8ai3FWcMZTiEbC3r+3lcs082jj78N5OEyvpz/3EgEHHmeCtqftG8vNknQr+4MNAy
 k7i/10OFJjWrOOI2B7ll7uu6wf2lEya+gAAAA==
To: Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@csgraf.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported unreachable code in blk-uclass.c which led to noticing
that uclass_find_next_device always returned 0 which meant it had no
need of any return value.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v3:
- Address review comments to make more readable and prevent for loop
  testing of a variable that will not change
- Remove those for loops that reduce to being empty
- Link to v2: https://lore.kernel.org/r/20250714-blk-uclass-v2-0-1bb1d2eee896@linaro.org

Changes in v2:
- make uclass_find_next_device a void and update callers
- Link to v1: https://lore.kernel.org/r/20250714-blk-uclass-v1-1-d21428c5f762@linaro.org

---
Andrew Goodbody (2):
      block: Remove unreachable code
      uclass: Cleanup uclass_find_next_device

 board/emulation/qemu-ppce500/qemu-ppce500.c |   4 +-
 boot/bootdev-uclass.c                       |   8 +-
 cmd/regulator.c                             |   8 +-
 drivers/block/blk-uclass.c                  |  14 +--
 drivers/core/uclass.c                       |  16 +---
 drivers/power/regulator/regulator-uclass.c  |  21 ++--
 drivers/remoteproc/rproc-uclass.c           |   9 +-
 include/dm/uclass-internal.h                |   4 +-
 test/dm/core.c                              | 143 +++++++++++-----------------
 9 files changed, 94 insertions(+), 133 deletions(-)
---
base-commit: cd79a2839b01571b6f2915c219f71c05e3c97482
change-id: 20250714-blk-uclass-34684c01f60c

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

