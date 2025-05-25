Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371D3C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 22:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C8D82C4C;
	Mon, 26 May 2025 00:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1748213408;
	bh=NWGB6ai+e0MRgQqkdpbtvlRDF+sWb3E4KRhksKQ8hI0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DCR/xGGuuqLwMWIWKKJXRq8OmKVSlGPUUiS0ScLQTafILaj7UXVOgaq+kwuBzZ61B
	 Z1RH8Ph2N01Y/HtgXWNaiRVkldDGGG6PaWCzY6Wxs5MOF++4+FFAb15wVBC5htqhxP
	 wPYciizSgMLgdoH0F+E8yd6x0OdkpZZh/jXf0zuzHTTwZ2uUxT3a8ZChhq9PegXm38
	 DTo9gP+m40oapW+sg2z/680YgJx1WU1Flk0vgxFPpiliDH5vpC3kjGQzKPv5lTW3y1
	 cmFIEAfCH2oM29rHtDoXdCE+Br5rvqdBKugJDmFDeFYJf2oMuGO71ZBnns8ALf4asf
	 h8bySgLOx6rwg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B42282C96; Mon, 26 May 2025 00:50:07 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D12982AFC
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 00:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="TPtVIhXh"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CA2541039728C; 
 Mon, 26 May 2025 00:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1748213404; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=NWGB6ai+e0MRgQqkdpbtvlRDF+sWb3E4KRhksKQ8hI0=;
 b=TPtVIhXhB6pXM8c1w9SEhg65lA4pfI5Lx6WETx86160Kks6c/Tlw3spvVdSqVOWB0Qsk6d
 pIjUbuaweNisdGuqqmGJyeGarA2R8C/RXI3noQ8UOdulm2xQw1LjVq6jgMR+NrC5AE/7ug
 3Ksz2NZOZ1XDMnRJFDdQF2Sxkz+QIlPuWRgNU/9xTKmCd3ILPla4TZ0ygnGX96LHU2xoT5
 iFkYC56PD7sCiQGqTzKibrBAkWe6D92zz22gdrC1YIKBkcbAXuFkYAOAt2lM0ggZgFLuBy
 GKmtSfNoFbFrYQn83BM6L4mQCm1xVyVC6sfAus4+X6WkyP5byQ+stFWTSHpmXA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PULL] u-boot-usb/master
Date: Mon, 26 May 2025 00:49:32 +0200
Message-ID: <20250525224949.176427-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The following changes since commit df2ed552f0b05591090369a7fe7ddc92439dea5c:

  ext4fs: Fix: Read outside partition error (2025-05-23 10:42:49 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 831a38483cf21b395bb0d9d7a34fb9b430e9bb86:

  usb: ulpi: Clean up how we enable support (2025-05-25 15:44:13 +0200)

----------------------------------------------------------------
Tom Rini (2):
      usb: ulpi: Remove unused omap-ulpi-viewport driver
      usb: ulpi: Clean up how we enable support

Varadarajan Narayanan (1):
      usb: dwc3: core: Fix timeout check

 README                                | 12 ------
 doc/README.omap-ulpi-viewport         | 27 -------------
 drivers/usb/dwc3/core.c               | 14 +++----
 drivers/usb/host/Kconfig              |  7 +++-
 drivers/usb/host/ehci-tegra.c         |  7 ----
 drivers/usb/ulpi/Kconfig              | 28 ++++++--------
 drivers/usb/ulpi/Makefile             |  1 -
 drivers/usb/ulpi/omap-ulpi-viewport.c | 71 -----------------------------------
 8 files changed, 22 insertions(+), 145 deletions(-)
 delete mode 100644 doc/README.omap-ulpi-viewport
 delete mode 100644 drivers/usb/ulpi/omap-ulpi-viewport.c
