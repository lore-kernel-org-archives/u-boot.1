Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E84CCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 19:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BCA983A25;
	Sat, 11 Oct 2025 21:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="rIbe49e2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B4458393E; Sat, 11 Oct 2025 21:11:23 +0200 (CEST)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3DCD8393E
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 21:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=igor.belwon@mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256;
 b=rIbe49e2gEZCC3X76rxMmU9MKKVgkQdcJIkD5vePPLLeMW+uTgd0FykylMrmvXbVSHKTxvg6sBMWiagJNvPyDSl4jwzaOpNNS3qVmv30KckOPXUh7roKjH6H5zXot0boJh83RQBT/8pAMpRNzNQI5gbooPOGM09hOL1EGCb/ooZXpXxFlmXTkXjCBC+n2JtQSFr1uquz2s+20XNnA6plXtTnPsEE+QtVSGhos/QYEldtV7nb3kTCvgdyKL6mdGGD4pH0wHXzt3ZkWAtG4SnJGnlLlulKTTRPwg3klvbxSkgcxfoGm6+6yff86h9mY0LO8tPTH6mi/YIM+HOu92Aayw==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=3ETksPgJkznLmjYIS4+xTYygZNs70iajA4elmqcPsEU=;
 h=Feedback-ID:Received:From:Subject:Date:To; 
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1058243981; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 11 Oct 2025 19:10:50 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Subject: [PATCH 0/4] ufs: Add support for MediaTek hosts
Date: Sat, 11 Oct 2025 21:10:03 +0200
Message-Id: <20251011-mtk-ufs-uboot-v1-0-a05f991ee150@mentallysanemainliners.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIur6mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0ND3dySbN3StGLd0qT8/BJdM2NLo6RU8zQDc5MkJaCegqLUtMwKsHn
 RsbW1AOmiDO9fAAAA
X-Change-ID: 20251011-mtk-ufs-uboot-6392be7f074b
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, Tim Harvey <tharvey@gateworks.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, Simon Glass <sjg@chromium.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 ~postmarketos/upstreaming@lists.sr.ht
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760209845; l=1697;
 i=igor.belwon@mentallysanemainliners.org; s=20250908;
 h=from:subject:message-id; bh=3ETksPgJkznLmjYIS4+xTYygZNs70iajA4elmqcPsEU=;
 b=aTaIeBYsl0FqMiugRb9+92v67DIa/69j1V21tpKU0GmN3dgFfO409MfNehhSfuVuCopkAMRbs
 EiBzU7/mHTtBdgb3F9y0Ayn8czcZ6qUXVqBh+eOCJEcIlpUzAh4qJig
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=t9Kz6B3jEwJD7YAKcp8XftfEz7SUSlGbrsfFlbrrFwA=
X-Mailman-Approved-At: Sat, 11 Oct 2025 21:17:18 +0200
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

Hi all,
This patchset includes basic support for UFS PHY and UFS for MediaTek
platforms.

It's part of my MT6878 upstreaming work (more to come soon), and is
fairly basic. It does successfully grab a link and allow I/O over UFS
with no spotted regressions, however features like clocks are yet to
come. The peripheral however works, due to the clocks being set up by
the previous bootloader.

Most of the work here was based on the Linux drivers for MT8xxx series
SoCs, adapted to U-Boot and this mobile SoC. I could only test this
work on MT6878, as such, the compatibles on the drivers were changed.

NOTE: The M-PHY driver was not substantially changed, as such, the 
Linux compatible was kept.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
Igor Belwon (4):
      phy: Add MediaTek UFS PHY Driver
      ufs: unipro: Add PA_SCRAMBLING property
      ufs: Add MediaTek UFS driver
      MAINTAINERS: Add UFS to MediaTek section

 MAINTAINERS                    |   2 +
 drivers/phy/Kconfig            |  10 +
 drivers/phy/Makefile           |   1 +
 drivers/phy/phy-mtk-ufs.c      | 190 +++++++++++++++++++
 drivers/ufs/Kconfig            |  14 ++
 drivers/ufs/Makefile           |   1 +
 drivers/ufs/ufs-mediatek-sip.h |  56 ++++++
 drivers/ufs/ufs-mediatek.c     | 403 +++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-mediatek.h     | 210 +++++++++++++++++++++
 drivers/ufs/unipro.h           |   1 +
 10 files changed, 888 insertions(+)
---
base-commit: e50b1e8715011def8aff1588081a2649a2c6cd47
change-id: 20251011-mtk-ufs-uboot-6392be7f074b

Best regards,
-- 
Igor Belwon <igor.belwon@mentallysanemainliners.org>

