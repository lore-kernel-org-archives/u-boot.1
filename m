Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1CACCD184
	for <u-boot@archiver.kernel.org>; Sun, 12 Oct 2025 06:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA49B83893;
	Sun, 12 Oct 2025 08:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XytoKvx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14BB68388D; Sun, 12 Oct 2025 08:44:27 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88C8183885
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 08:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-42e2c336adcso12259715ab.1
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 23:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760251462; x=1760856262; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LRjDmGM8lXHMYSUBPa2CwH0Wnuh6PRUdvhRrbwcPm6k=;
 b=XytoKvx0SPrjGGOudrf4pjqyju9tkBWI6gsnE3+howfxWsN/H3LOAjlhkeqrHuK2Tv
 EbqtujEe1Kz0pp1wDkUAWjh5ITHPxFAVhIRY7IyDcBqx3qkpQVs2OtegKhrlaNFGD+5D
 TMgdjn2zBkbCm7FZl6TBfAlGix5nZGB45xvso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760251462; x=1760856262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LRjDmGM8lXHMYSUBPa2CwH0Wnuh6PRUdvhRrbwcPm6k=;
 b=PIcLFBKu2hu48RXzYGITjzfHhQYgwccxm1qH5CMymt+5wd9hulneSrd1UzC81tipLZ
 1FEThqiM8Js2cFtDQI2TwjFsQDn5N856tefxsp8lxEzyR2Y1pMhaH/x/M1wyZi3Q+GfD
 kJbGg+3qv0kAQijzfdj1er4W9eEVY7wR0/aW5v0jENSDHlErmvlUsZsr2P/XVr6GW/zr
 22xQBCnjxq4RYMm9NRlw2sU6UhDfx6lUDsZ7AqRuCNBZRszw1Hk2O8lfsQgWIemoUpPY
 V26fhc62CURBSW+MqgD2m95DSONCcO6JdrthYLc2vdYNcDPHYjqxfKqXeUIbgrPupmpa
 u4/Q==
X-Gm-Message-State: AOJu0YwbuFeP7B3fwcx8vM1/yKcLFh85LvS2wSuSZLsrbROQgLyyDto8
 8kukjE3t9vv0issSg/znWSgZEvbd8Ou+PGbfT4vtPMAxXWax/zXpKwlaX+Mn8AN+BUNu97kliE7
 THmfVOjWrvvc=
X-Gm-Gg: ASbGncs3HO0KneARrAP07Z3E2oFdpEjNP3EEn/zmhAwexcPQwezY4v1p4Cvi1s4l7P0
 CNx5BwdijL84hAgN3yXYKKrtYrOsTbIDnUGaYUqInAl+I+wr1GHfDUfi2TxcZEdtRjj/kfYtCLk
 GR3pwOtGPcyC/bUv1AoTVbU/ZBs59LCaur3le673ps3HlHQyRnmkgw3j3pGpgJWXFNSstc9hanv
 hWZYoK2r+slIx+mvyZMxFCsEMHQY7ABdE5mgbwbfFbJY1gXy+FIu9EFLhT0GC7Qd3CnvsxcAwXf
 +BzczYHxe1MiaT+3iWejIZi5eyFid/Q+oh6O0QtoEZXKYqA9TSLBhNiwJf1d0vUbvt8Qscgvvmj
 mSVbPhlWUKowXranb1Cj3AlMoLJJM77FEVLg=
X-Google-Smtp-Source: AGHT+IFtJXhD6eigAhST6JFxjtUpzsrBi7E7G13ztj0aWkS4eb0L1ahGlEhvhwRhDz7xOmlRlyTI+Q==
X-Received: by 2002:a92:c26b:0:b0:42f:983e:e53a with SMTP id
 e9e14a558f8ab-42f983ee702mr131363955ab.29.1760251462144; 
 Sat, 11 Oct 2025 23:44:22 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42f90343080sm38109625ab.22.2025.10.11.23.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 23:44:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v5 0/4] boot: Precursor series for global bootmeths
Date: Sun, 12 Oct 2025 00:43:52 -0600
Message-ID: <20251012064412.2892979-1-sjg@chromium.org>
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

This series contains a few patches pulled out from the global-bootmeth
series. No functional change is intended.

I left out this one:

   boot: Move showing of bootflows out of the command

since Tom has already said he doesn't want it.

Changes in v5:
- Move 'usb' rename into a separate patch
- Rework commit message

Changes in v4:
- Series pulled out from previous glob-us3 series
- Drop patch 'Add more debugging to iter_incr()'

Changes in v3:
- Drop the spacing changes

Simon Glass (4):
  boot: Improve comments related to global bootmeths
  boot: Move obtaining the label into a common file
  boot: Rename usb to ums
  boot: Move preparing bootdev into a function

 boot/bootflow.c        | 60 ++++++++++++++++++++++++++++++++++--------
 boot/bootmeth-uclass.c |  1 +
 cmd/bootflow.c         |  8 +++---
 include/bootflow.h     | 11 +++++++-
 test/boot/bootflow.c   |  4 +--
 5 files changed, 67 insertions(+), 17 deletions(-)

-- 
2.43.0

base-commit: 48f21e66e360552c75d70a50421d0e0ed1f59e90
branch: glob-us5
