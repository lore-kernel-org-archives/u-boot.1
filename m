Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB80C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 01:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C0CA8460E;
	Sat, 27 Jun 2026 03:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GFNF2J3v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D4E84873; Sat, 27 Jun 2026 03:39:06 +0200 (CEST)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2B548460E
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 03:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-139edc6bfc0so1369634c88.1
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 18:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782524340; x=1783129140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwAsJ+hMeq6SWObIHlPY3u8a4KD78J3298g1jdp9250=;
 b=GFNF2J3vUA2B4YKumV3zY/PF9imkaFXz3KSpiBG4+OZyBMU3HprhLKc59m50wKFLlj
 TTt2xKzxmDoBZaMzrOEzBC5osBhpm8wPCahk2V8Vg8M0nHqSBXelRncMAke7REb4TO3M
 PstVKmxJ867WJtxwODYONYlWbthHPuPg6Koz6kH7bJrHpv8qd9/F8MROLlK+ABoIETZ6
 zS1DN09/X7bXLN8WAOGWS3m2uVorUunnMus8Q0BNv1yb7EBc6acppntL924Y5WVWnSJH
 wmEp0qm30+06WAahbqNh4vCce9M9hrcZN2EY3Ym9n5FGqiJ9q8x2F2UsvrNcEgXvhRyc
 9fLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782524340; x=1783129140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jwAsJ+hMeq6SWObIHlPY3u8a4KD78J3298g1jdp9250=;
 b=MTUe9VNFs/Bmq45NstS2lwuNDZ0X1xNjdzfFuq+RJvUHDTXKapd7m4LBbcceahd73m
 cZqSXkI3jtCt436LBWJfO0SM2FqY96CshPiEXS4NmksCaJCEEamIGepnRlzVGBQfoCre
 1b346ziJqvOFzK3pZXInhbyN2NM/rJe8uowp6sJ3tpUaB7YpJmJ6M+M5MRXzZZbyxUdF
 Xg7qwcriFrQ8+zrMdUw2aM4cRhY4ZXx0ka8lyoRtBEYt4Qo/OH7MTjP6GK8wEFJeSlpj
 +TjhEuDpkNnE0C9svmDokZgCkwXb4UFGtO75CLtiSHjekT/yLSFQNdLy1b0ssW1QRtHz
 DE/Q==
X-Gm-Message-State: AOJu0Yw7/mKpBemJ8c1M9xqpP+m+4067r0F15fseuiG8oW+cZDCtkfWg
 3St8YqRUXqA1oJJzIES7XDbab2Y271OgChpJkm14sS5C2QhY/tZ+vJk2
X-Gm-Gg: AfdE7cn3pNH06PTquOXQa2EtlPRSgg6Y87iSRT6Nx9wCs0WUKsIRb+DCA3rPGT7Ku0a
 jyZHKBWnO7lN6NA2iffPGs25YxZaRehpp2dmxxej26JcdF7Ch98UKhwb+BtHUh+YT6oSP7k+FJ0
 YS0ik79ax/Wd+yse/WBwbOGaKbbwWL2udSzFzIU1Dg/uzFRoq7P0W9BaVtkW9E7TtnY5+71E+Fg
 Q7IDRwBUwujRcdINLwo6nbNL57jJnn6ftBgCHjJAknJ4bPzYtLMLh6r/fYLLQkhdVXxOau8yH4s
 Bq1LbP6TVf9Ia98CR2FHu81TmOY87HTEXpnqOxT+KZyxS674L5/LvO74+OvHsODooQJ33I9SmCl
 MGWXImaJOcmyvY/Faru7xgkwagX+/2VU7FHRnUObAoHYeWnNzx0Ebc8zU35OprV4jndQUPxsTtg
 T+CAHi3E+rPkGVnc2JpDrpipQauSxroIrI7w9DKxTuahwe3hmObyWGoxaYO7YfsMpO43lJwQ==
X-Received: by 2002:a05:7301:1930:b0:30c:25c4:70fb with SMTP id
 5a478bee46e88-30c84ec7fe4mr10183479eec.34.1782524340036; 
 Fri, 26 Jun 2026 18:39:00 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:24b8:381f:62d1:5cfb:ac63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ab6sm35997678eec.15.2026.06.26.18.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 18:38:59 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, alice.guo@nxp.com, ye.li@oss.nxp.com,
 peng.fan@oss.nxp.com, marex@nabladev.com
Subject: [GIT PULL] Please pull u-boot-imx-master-20260626
Date: Fri, 26 Jun 2026 22:38:52 -0300
Message-ID: <20260627013852.3002838-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260627013852.3002838-1-festevam@gmail.com>
References: <20260627013852.3002838-1-festevam@gmail.com>
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
