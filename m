Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8628FC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 15:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D69C187F3D;
	Mon, 19 Feb 2024 16:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QY8ZgAPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7818087876; Mon, 19 Feb 2024 16:33:57 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84F6987DA4
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 16:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C71FD60DE6;
 Mon, 19 Feb 2024 15:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C49C433F1;
 Mon, 19 Feb 2024 15:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708356821;
 bh=br0ZNdeHtYJZk6ro9zQglGkmOmtdMAmeQ+MhYIkhyA0=;
 h=From:Subject:Date:To:Cc:From;
 b=QY8ZgAPRZfQfxONijXk/1aL+MDrL6seKfcVY329x8eOeY6m4lAn/ju1k7KkICgVJ6
 Sj1RLGVx41PydEOxnGn9OIXM0c7Xq4DWKSKZyulYysoFbKYyUNLKo5kqVlYrRq7iIi
 1pPAvqu7DcPsSPVcag346SlT5jbA9tyhLrkBKFKN3pj55ALrFoU2ZR665W0aVkIq3c
 dtfd7KbNMCbL7HwCGo2tQqVu0h9yZwxHewKSLcWKq+gQI9cLKMTIScgWwuySuPvzFi
 ak5JIPg9UDPYT2y9nBiaXwwyejGZqE7UTnjv5f14kG97n8UIMjsssRovAmnJaJGaou
 joCDZXbHbYWFQ==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/2] net: ti: am65-cpsw / cpsw-mdio: Switch to DM MDIO
Date: Mon, 19 Feb 2024 17:33:27 +0200
Message-Id: <20240219-for-2024-07-am65-cpsw-mdio-v1-0-afe9aaba5801@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMd002UC/x3MQQ5AMBAAwK/Inm3SriJ8RRyqFnug0iZIxN+V4
 1zmhshBOEKb3RD4kCh+S9B5Bm6x28woYzKQIqNIVzj5gB9Q1WjXqkS3xxPXUTxy4XQ5UFMbQ5C
 CPfAk1593/fO8Q8jVx2wAAAA=
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 nm@ti.com
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, mripard@kernel.org, 
 dannenberg@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com, 
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=br0ZNdeHtYJZk6ro9zQglGkmOmtdMAmeQ+MhYIkhyA0=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl03TS3b9w3tBWFADA+Am3h9XTtu9pf0aRPByU/
 abGY33F43+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZdN00gAKCRDSWmvTvnYw
 k+veD/9ezPHsYJ7ycxziy2f9ICq7NpNr+PCxSn/LHSjUJ59Wv8ABUzjpEQVZXKK7dXyYtDMdGZO
 HVm1QeIpWmrMVIfQSPxCwTL4gpirr97LdAXYrVtDkgW6Ns+DiyhRaJiIQ90dOzP1AdJoS3JpJfd
 9XHf1GB/Y17d1GJLlQqDf1V9YMb9h7Mkj86RsMahuog4JAxDrbcMSZsftPflMlX/M+jEwCg8ptg
 /WuPWhCfnD9P59pHQm6ia43SZguCNuf4U+rclrzpHmQhY0mH9Ay1Ac29Rt7riMKiGl9S9+1KZOe
 9pt/mNyiKHk+XVa9vuEFZuVo22lToWyuKqP1Zc3ZPwqvsCutq9VaOgtfgz5ZPZmgjv8Y/DJDdvM
 Ev/WCIXTrgz4k02dGgf+kSeTIOqylvOA7e9taX+TnfWYz0YJQmuctHVvpD3hvRh9RHyHI6zYKG2
 tf8Bys2hsRFbhzxQJq6CFJWMB6UaVZaQv3je1rKY/bwHU+2r2Hkv2Z2FTuTVOgxRJwE4QL18f/N
 +ApJeHiCZg9+Pb+4oYRFWm74d9/9lWaXhqait096G2wOhqANQS0GFQ8v8/IeFI0MoXdwca45Fs1
 uD3+4J+zXCQ/P6L/yWgjzvtEuhLP5kYUwUDKriYlvy3TDE6zd2Ma5SAwuE/uuT1oO0D7Q2x+4TZ
 tLTsrcUZzoX8jVQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

Hi,

This converts cpsw-mdio into a proper Driver Model
driver and introduces the new Config symbol CONFIG_MDIO_TI_CPSW.

It also cleans up the am65-cpsw driver so it porperly uses
the DM PHY interface.

It does not convert the legacy cpsw and keystone-net drivers.

Tested on AM64-EVM and AM335x BeagleBone.
AM64-EVM network doesn't work at 1G but only at 100M. This
limitation exists prior to this patch.

CI tests: https://github.com/u-boot/u-boot/pull/491

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Roger Quadros (2):
      net: mdio: Handle bus level GPIO Reset
      net: am65-cpsw: cpsw_mdio: Switch to proper DM_MDIO framework

 drivers/net/ti/Kconfig          |   8 ++
 drivers/net/ti/Makefile         |   3 +-
 drivers/net/ti/am65-cpsw-nuss.c | 190 ++------------------------------------
 drivers/net/ti/cpsw_mdio.c      | 198 +++++++++++++++++++++++++++++++++++-----
 drivers/net/ti/cpsw_mdio.h      |   2 +
 include/phy.h                   |   7 ++
 net/mdio-uclass.c               |  37 +++++++-
 7 files changed, 239 insertions(+), 206 deletions(-)
---
base-commit: e4013bcb10f604ec1dfe955634d57e1fc336b15f
change-id: 20240216-for-2024-07-am65-cpsw-mdio-e3c15b297442

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>

