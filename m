Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3411ECDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 14:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FFBA877C3;
	Mon, 23 Oct 2023 16:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tom-fitzhenry.me.uk header.i=@tom-fitzhenry.me.uk header.b="b0ZvLyX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90665877E0; Mon, 23 Oct 2023 16:23:18 +0200 (CEST)
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com
 [IPv6:2a00:1098:0:86:1000:0:2:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55766877C2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 16:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tom-fitzhenry.me.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
 bh=olk3wLdNuXwDF5kgVO9VxialPh4U40jP7y0YNcDahic=; b=b0ZvLyX4wvh4fMOdRmTSabR9R/
 AMYLBoukbV2zE3rR2U1qPamTX2EtGu3m9lPKnj8Vyql84tUcwffNoJ6ixcLEhMPniGCc/jOQas16L
 WDATpumnJ4E+YpJjmn7Jf95f3kHmfLdmw/d/B6SfAWssUzSprg4MxiAD5RSruSkIq+QaJDn01QO0b
 csAhFWLKK2GYhVqtdF9Lzut+n5novM+Ls/dWVlHIV1CvcoYSD7uhhbA3YCXUg6VEcK1rIGaIsGjU4
 xuE5aVBuCjmDVEPaFDaHD6wRRXxC7hbyZJ/ojoDZbK0p5iXeRh3xKLuMy7CCOwGzmIs/3M1Oa8xqa
 jXpoaL6A==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tom@tom-fitzhenry.me.uk>)
 id 1quvpo-00H08D-DI; Mon, 23 Oct 2023 15:23:14 +0100
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: 
Cc: u-boot@lists.denx.de,
	Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH v3 0/2] board: rockchip: add Pine64 QuartzPro64 RK3588 board
Date: Tue, 24 Oct 2023 01:22:20 +1100
Message-ID: <20231023142246.26830-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BlackCat-Spam-Score: 49
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

Changes since v2:
* Rebase on pending DT sync patch.
* Collect r-b tags.

Changes since v1:
* Sync recently added DT from linux-next
* Sync led dt-bindings

Tom Fitzhenry (2):
  dt-bindings: leds: import common led bindings from linux v6.5
  board: rockchip: add Pine64 QuartzPro64 RK3588 board

 arch/arm/dts/Makefile                         |    1 +
 arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi   |   12 +
 arch/arm/dts/rk3588-quartzpro64.dts           | 1137 +++++++++++++++++
 arch/arm/mach-rockchip/rk3588/Kconfig         |    8 +
 board/pine64/quartzpro64-rk3588/Kconfig       |   15 +
 board/pine64/quartzpro64-rk3588/MAINTAINERS   |    8 +
 board/pine64/quartzpro64-rk3588/Makefile      |    3 +
 .../quartzpro64-rk3588/quartzpro64-rk3588.c   |   39 +
 configs/quartzpro64-rk3588_defconfig          |   72 ++
 doc/board/rockchip/rockchip.rst               |    1 +
 include/configs/quartzpro64-rk3588.h          |   14 +
 include/dt-bindings/leds/common.h             |    7 +-
 12 files changed, 1316 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-quartzpro64.dts
 create mode 100644 board/pine64/quartzpro64-rk3588/Kconfig
 create mode 100644 board/pine64/quartzpro64-rk3588/MAINTAINERS
 create mode 100644 board/pine64/quartzpro64-rk3588/Makefile
 create mode 100644 board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
 create mode 100644 configs/quartzpro64-rk3588_defconfig
 create mode 100644 include/configs/quartzpro64-rk3588.h

-- 
2.42.0

