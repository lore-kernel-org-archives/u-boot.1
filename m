Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF11C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 01:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF5BE846DF;
	Sat, 27 Jun 2026 03:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CT6kdh1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D49183FEE; Sat, 27 Jun 2026 03:39:02 +0200 (CEST)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6580683FEE
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 03:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-30c9c8c2697so1719614eec.1
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 18:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782524338; x=1783129138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jwAsJ+hMeq6SWObIHlPY3u8a4KD78J3298g1jdp9250=;
 b=CT6kdh1LQohWP7FofhZERS2H+xsk/VMtrN9u5tou4SzvjyKPKv1HeuoJj3MB0mKpc8
 tHa/GacE8bwjLnmHIC9RPE3hoK7cDSuznBqoBBHkb9ybT+hlUqowgeAlv+bcvFea+cg+
 pynZKATQqeaxU4OngcHpnJSnPpdl+FkTZiw5NcaijOgO7+DITxNOHb6pWdrOJUFzek6q
 /Gz3W0VhqQ74pDRtuQBVjZc4DZOJFXdbTmfRYI1JtGsqS7Bv8j+zusvyyQqlKR7/Y+pF
 jCvVtQXX7h8+7KixyLFw3JFJNkzqfKSjpnzzPwtRapCBYc76nIrv3xVKWl/gOTz4/Kyt
 bwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782524338; x=1783129138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwAsJ+hMeq6SWObIHlPY3u8a4KD78J3298g1jdp9250=;
 b=WQFxbb8jPTxJB7VEmnkSvK4hnTzjXXp25hK3+RJ4ew17kpX54ixS9qitHJkKLO9SGg
 AMlDA8VJVAtP9+Zt7YJgJz4d+s0zidKX+qwFUzvkRG8ueIWF2vnyEpPOi1bFo6/2Sne9
 6Z6i4a5PyC1nj2pPDN4ObjTIc0hXjP9v0hm3u856Bgr2MVk7erEKM9lFriaHxAdvfPYu
 1m1Z+NcDSFybJXDC9/O5nxdR1Q6BEsMNKGeEMvBU7iIn9E69CxWs22V08pLGZf3FWt+y
 8LpDJCQrNNEPuTdLh18TlMUEflLbEUM19vq8t/8dnbJ2MeChU2lYAHZdDINy6++btc4r
 eDRA==
X-Gm-Message-State: AOJu0Yzee69oZ1c0STMZ5K9Mly6ZboEo15SOmMeaj38cNTbOfrQ2s4/p
 UMNlq25dWN6kg9pOR/FCU7tt3lW4/Prvn/L+pLJEYZ6rQdRD5V2KzR0k
X-Gm-Gg: AfdE7cmAU3+hVsLoXqrdGUhPVuhRREtU83CJI26onH/1miKM1nSV3NNHmwjyvHOw4Ob
 NxszVC2FbQ3EIES5DvabNisZiwcX3E31OYpERJABDTqznLIl22CzxtLxJSINBPnI5BX00MnFYuu
 pP89Rt9XfarfgN1XQMC8hZKkVlM4Wc4WpWjcEnBNsCG+D8py419rgNZL+sFO66m75R6DP5hrHd/
 OnYGlb1VKJi2uKkEzjiIrmUQP0/EamNpBY0glcJ1ZUXZP2D2r0tfQz5zS8cYvL04pZwHil8BO5M
 P/kyGznQy7iiBCYEfH0vBQn4wTSDwHNk+PBFIGZHhI1Ng5o+c0JvARo375ZD2MdEPG+jvLjIboM
 HuileVcazQmcToyFDtphVtMM6MVVH1fLvO6XiWgVAEF8XoFlmlcB4VnIuQQDE2nr83fjRZuuqkk
 wIu8cHlCuYWFV/PZmvD9uZw4RFw/RxBg2KRp6vdzCnqAIm6/x1PcANOWDdNNnGVqQs5wah0A==
X-Received: by 2002:a05:7300:7245:b0:304:d92a:e60a with SMTP id
 5a478bee46e88-30c84e0249emr9259154eec.31.1782524337412; 
 Fri, 26 Jun 2026 18:38:57 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:24b8:381f:62d1:5cfb:ac63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ab6sm35997678eec.15.2026.06.26.18.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 18:38:56 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, alice.guo@nxp.com, ye.li@oss.nxp.com,
 peng.fan@oss.nxp.com, marex@nabladev.com
Subject: [GIT PULL] Please pull u-boot-imx-master-20260626
Date: Fri, 26 Jun 2026 22:38:51 -0300
Message-ID: <20260627013852.3002838-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit 6902fb4c17faa375003124c451c2550deab5463d:

  Merge branch 'master' of git://source.denx.de/u-boot-usb (2026-06-25 12:32:18 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20260626

for you to fetch changes up to 151e7c6e7c2c33b980030aba782e056d5719c998:

  clk: imx: imx8mq: Fix iMX8MQ PLL issue (2026-06-26 20:12:22 -0300)

u-boot-imx-master-20260626
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/30543

- Fix MAC address representation on i.MX9
- Fix i.MX6 DDR initialization
- Fix iMX8MQ PLL
- Fix SPL trampoline buffer for 1GB DDR on i.MX9
----------------------------------------------------------------
Alice Guo (1):
      imx9: scmi: use 48-bit MAC add instead of incrementing mac[5]

Marek Vasut (1):
      mx6: ddr: Subtract half a cycle instead of three quarters of a cycle after DQS gating calibration

Peng Fan (1):
      imx9: scmi: Correct shutdown checking

Ye Li (2):
      imx9: scmi: Fix SPL trampoline buffer for 1GB DDR
      clk: imx: imx8mq: Fix iMX8MQ PLL issue

 arch/arm/mach-imx/imx9/scmi/soc.c |  75 ++++++++++----
 arch/arm/mach-imx/mx6/ddr.c       |   4 +-
 drivers/clk/imx/Makefile          |   2 +-
 drivers/clk/imx/clk-frac-pll.c    | 199 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx8mq.c      |  55 +++++++----
 drivers/clk/imx/clk.h             |   3 +
 6 files changed, 294 insertions(+), 44 deletions(-)
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
