Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A15FCCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 19:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92BA583AD5;
	Sat, 11 Oct 2025 21:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="EuHYtM59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8056783A5F; Sat, 11 Oct 2025 21:11:27 +0200 (CEST)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6483883AC5
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 21:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=igor.belwon@mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256;
 b=EuHYtM59EY3afq0whc4o/W6Ya6EDNhY6rvzNOWZPt7RUyBb9CaR3bwGkTwFa+5ENPPcQNFgDTf645qRpVV2NqO/VPxZTJ5Bs72gvB0uLKf3Bi+oFe30pB4ohreJVsPP4d4xWQtSFFKFPMhELAdojadmedB2aKjCI80Yq5MKIrnaAGBfv4MChjNNgM+lPirDTDkXvACabfcro4PgcD7YAhu0XNUI8u+9937aHjG6/IXkTfuBAl9QkR2aHcf+YnAYMOO2qi53z6Pu8H32z1BqzYVctYdq8vN/4mL3hxRPDs+tCYgaDbrcBFM2KxcSGGqcl54l0Vp+YilpZUrIWOx8D9A==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=P1EAMr477SrwKD1E9zPIneBqVwRCi2ESwj8rb4HPKlk=;
 h=Feedback-ID:Received:From:Date:Subject:To; 
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1058243981; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 11 Oct 2025 19:11:08 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Date: Sat, 11 Oct 2025 21:10:07 +0200
Subject: [PATCH 4/4] MAINTAINERS: Add UFS to MediaTek section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-mtk-ufs-uboot-v1-4-a05f991ee150@mentallysanemainliners.org>
References: <20251011-mtk-ufs-uboot-v1-0-a05f991ee150@mentallysanemainliners.org>
In-Reply-To: <20251011-mtk-ufs-uboot-v1-0-a05f991ee150@mentallysanemainliners.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760209846; l=1012;
 i=igor.belwon@mentallysanemainliners.org; s=20250908;
 h=from:subject:message-id; bh=P1EAMr477SrwKD1E9zPIneBqVwRCi2ESwj8rb4HPKlk=;
 b=2yBPMGqPqyyThxA+5tm1Ac7QHyjePmeSaCGVeHx4/Uoz3DiQR8MAtWl6y8ekjHKNh2jgpgKcL
 OLD2SfYkxKAA1drC5knV/XRxQRwqtpT9TI6aDdKJnQyLvVoQqicIcNd
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

Add the UFS driver files to the ARM MediaTek section in MAINTAINERS.
Add myself as its maintainer.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1db1070d5f8d2fb74836bc8e55ca13fe6b292d93..30b2b602d2f3edeb6dc54f9d65211a372de9b896 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -410,6 +410,7 @@ ARM MEDIATEK
 M:	Ryder Lee <ryder.lee@mediatek.com>
 M:	Weijie Gao <weijie.gao@mediatek.com>
 M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
+M:	Igor Belwon <igor.belwon@mentallysanemainliners.org>
 R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
 S:	Maintained
 F:	arch/arm/mach-mediatek/
@@ -433,6 +434,7 @@ F:	drivers/spi/mtk_snfi_spi.c
 F:	drivers/spi/mtk_spim.c
 F:	drivers/spi/mtk_snor.c
 F:	drivers/timer/mtk_timer.c
+F:	drivers/ufs/ufs-mediatek*
 F:	drivers/usb/host/xhci-mtk.c
 F:	drivers/usb/mtu3/
 F:	drivers/watchdog/mtk_wdt.c

-- 
2.51.0

