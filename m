Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C617D0E3F3
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 19:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F3E88E88;
	Thu, 24 Oct 2024 21:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cMzNx4jw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD81688995; Thu, 24 Oct 2024 16:33:15 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A85F188EE0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 16:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e67d12d04so737002b3a.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1729780390; x=1730385190;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6FK6J2iHCKgfOokyjIayZiTwJWN/793T5anVG2Tlb5Y=;
 b=cMzNx4jwOwzK29cBcjw+sJ4o/30pcZWonEhMPgn7NGrOx17xBXHsKNIfEyhmLxJNU3
 HwkmAgTvCce6mIC0TaQPWwvtK0iRgQQXyHNOMfMTrRZlSsaSFMEEPY7HQHFTSSH+Y2k8
 cYw0t5k6PnhyVTBJs+Su4TlElJSW2ht5gGYNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729780390; x=1730385190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6FK6J2iHCKgfOokyjIayZiTwJWN/793T5anVG2Tlb5Y=;
 b=Tnqqo0VuG0DO0VdNhkBQVtILK/Q/fBBv+AgDdlwDOJutoVIztC7TG/jDqEkA84OlkP
 pregK9YXERkU+b2AysejUX8wTx7iu9cXyYpkXu7Jpfpregz+/lyD8+NEoRYY2vBRdkjK
 udsAEGl9NAyjiw7Np5yeMAWYUhfcll4FrkxiYLW12cQ3y1gV9SQ7RsFGpJ9Aju5nJcjp
 E2nGaqzu2aJnFYUZEhgQBfUGcXftPuyZ3up3TvHfGR2hV09VuYVZFznKDg8qe8fhDtzz
 d90gPnqlIohpzklMrPXaezIXV67OuJYeT0Dl+XKUUsccPfqjXdCA1rQt7PZMtY3ABLJ9
 DL7A==
X-Gm-Message-State: AOJu0YxprBO00M0ocCKz6wpeQMfamZiexPICv5WpjUNOA6Q/AQ4Sbl21
 04FncEoTJkxEkuEuh8JgC6ruKj5J03+1rChFC02hG0lgsiwDG3TYhdDApcYONBs=
X-Google-Smtp-Source: AGHT+IEZuDpU/wHBU/KQhruFLFhYlbdEfrPhOltOxXYdpyJoNXKMu221/jfhW4wymEDkJ58pOzEyfA==
X-Received: by 2002:a05:6a20:d49b:b0:1d9:215c:c63a with SMTP id
 adf61e73a8af0-1d978bb324bmr7572486637.47.1729780389819; 
 Thu, 24 Oct 2024 07:33:09 -0700 (PDT)
Received: from tops-ThinkPad-E14-Gen-5.. ([183.82.41.52])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d755dsm8000909b3a.136.2024.10.24.07.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:33:09 -0700 (PDT)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-spi/master
Date: Thu, 24 Oct 2024 20:03:04 +0530
Message-Id: <20241024143304.383938-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Oct 2024 21:39:34 +0200
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

Hi Tom,

Please pull the below PR.

CI:
https://source.denx.de/u-boot/custodians/u-boot-spi/-/pipelines/22949

thanks,
Jagan.

The following changes since commit 7af813341d5df064aeee764c31ffb50ffcdf4eb6:

  Merge https://source.denx.de/u-boot/custodians/u-boot-watchdog (2024-10-23 08:33:56 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-spi.git master

for you to fetch changes up to a3384940edf3cf2d2e0e0b78af9541f8be3a15ec:

  mtd: spi-nor: Add mt35xu01gbba octal mode SPI NOR flash (2024-10-24 18:10:50 +0530)

----------------------------------------------------------------
Dmitry Dunaev (1):
      mtd: spi-nor-ids: Add Puya Semiconductor chips description

Han Xu (1):
      mtd: spi-nor: Add mt35xu01gbba octal mode SPI NOR flash

 drivers/mtd/spi/Kconfig       |  5 +++++
 drivers/mtd/spi/spi-nor-ids.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
