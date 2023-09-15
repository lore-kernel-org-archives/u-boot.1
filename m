Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A41EED60B
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 16:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6312786489;
	Fri, 15 Sep 2023 18:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dIekaIZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C638653C; Fri, 15 Sep 2023 18:01:40 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C093E86484
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 18:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbrunet@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31fa666000dso2112745f8f.2
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694793698; x=1695398498;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hEH2qRPm7cUqKOozcqg9ml8nNAxJIAf5SSGrqWvKrKY=;
 b=dIekaIZ+AcZ2KuYDiMRJGgIYCMUb/mXkstIVEx6GLO5H7mXzBkQU3VCN28m3oH17xC
 AU1jw+5IuXUEoFP/7myaDJhVAA12FCl8xUHd3+hEnW1PE1QxKQQ+4uPgPrCN0yHCaMOw
 PcGTt26bQGmKNKLr++7sM5b5MtvczCCoadgE6uKJ8KgOgbpwaD9fshWEApnRcmPusgF0
 QOvTT+RIlKopXaozh/F5k0ihHJ3gnCcBxKFZmUIjf8qj07IDcF03FTXbY3HXEDxHDxI7
 Z83QXSOmXTyfhtOJlWYzgL2swjn5F4einK54iAJhHznWeYnbokNub6Rc8BKB3oQ6GS7Q
 QnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694793698; x=1695398498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hEH2qRPm7cUqKOozcqg9ml8nNAxJIAf5SSGrqWvKrKY=;
 b=cSLW3SLcNbv2oWdNbq3QUWmeUPLPXmOQF4MHJV1x8tctvAUwpEARpNdQ0m6bvVgRCt
 zpNfnBwVckyLVSiVQyJVlULOldEoQ595AkKXI5owNiX9o71NXcOvbjbh5M90GgXLIR0L
 bleYdnEuZxkuwvVYTQdQ5wyZ60cI+a7vbsCD2C9ymRkWki1VRZvzCjimHZ7ZBkOFYwQ4
 p0crjNjqXKuJ++MEBhk31Yc/iLGHKi8mQOatykyFbeHU+itE7fmt4K3bk7Qfs0tqByS+
 7aJ0GMMqyBZOt52mfIAMP1q2BgqQMg25pNAXX4Jygx5O9DkbHmsbgZGRxNPJKoG03yqq
 VvFQ==
X-Gm-Message-State: AOJu0YzTzRCV+0CDkQq2YoMfDZeechyJ6puRbnWM/r0cA9sWUWep13/t
 wesABy2E7JKc9ULj0icoidyOyQ==
X-Google-Smtp-Source: AGHT+IE0/wEciXtiOpa9Hc87LqCQZZd9hyxKgGIQSCJfJo+66uXBgULHJcNGKgjNCqGvNmZ41SQyNg==
X-Received: by 2002:a5d:480d:0:b0:317:c9ad:e96c with SMTP id
 l13-20020a5d480d000000b00317c9ade96cmr2137743wrq.15.1694793697233; 
 Fri, 15 Sep 2023 09:01:37 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:cc7c:a70f:b3d:d73b])
 by smtp.googlemail.com with ESMTPSA id
 p7-20020a056000018700b003176aa612b1sm4761766wrx.38.2023.09.15.09.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:01:36 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Subject: [RFT PATCH 0/2] mmc: meson-gx: improve MMC reliabilty
Date: Fri, 15 Sep 2023 18:01:28 +0200
Message-Id: <20230915160130.352099-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
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

Amlogic MMC on the GX (and later) SoCs has been problematic for years,
especially with u-boot.

Linux has been fairly stable for a few years. It is using a fixed phase
setting with Core = 180, Tx = 0 and Rx = 0 (the latter cannot be set
starting from the v3 MMC IPs)

Still the results were not good with those settings with u-boot, on some
sm1 based platforms. U-boot then started using a 270 core phase for sm1
only.  This worked for most sm1 platforms but problems persist on others.

The proposal with this patchset is to use 270 for the ID phase, 180
otherwise.  This works well on the platforms I have tested (Libretech's
boards and VIM3L)

It would be great if others could test this and report whether this work
for them or not.

If the results are good, this might be ported to Linux as well (... but the
situation is less critical there)

Jerome Brunet (2):
  mmc: meson-gx: clean up and align on Linux settings
  mmc: meson-gx: set 270 core phase during the identification

 drivers/mmc/meson_gx_mmc.c | 50 ++++++++++++++++++--------------------
 drivers/mmc/meson_gx_mmc.h |  9 +++++--
 2 files changed, 31 insertions(+), 28 deletions(-)

-- 
2.40.1

