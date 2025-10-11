Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E50CCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 19:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE4AA83AEC;
	Sat, 11 Oct 2025 21:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="pARW54cL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5DE683A2B; Sat, 11 Oct 2025 21:11:27 +0200 (CEST)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A238083AB8
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 21:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=igor.belwon@mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256;
 b=pARW54cLryPTXPitzXQqemH8PUoWhbt1sx0zLcTd862CJXY0hijSNogdGp3Ip/U2ql5o07K4mEad7LZ3uTbwa7oWkuXSrV0xIl+s/ECIiqqr9G8o47TL/QdN4niU101487Kt+iyLvG2emjO+LJffLdblpgaHHgXSGIr9uWN2HLmBvCW5/I9h/3KyIyc8s+AOVUPSZCeWhMIbmvjEWkL4zOu7ASGA7o9nNuh7DE/JWh2iUCL6iOwRBMlYFbxDCRFkiBkVsSVtR9oI00WEbILKmenHkQwud9mk0hJJchTGQZT7/Zv+briDYMP/UAmfSPGcu+GNZqQwk7Rq0Ztk4rSUPg==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=H9Dk56u1g95MqxMPmFfb462Pz8jhJutA6M9Z2dgCoQk=;
 h=Feedback-ID:Received:From:Date:Subject:To; 
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1058243981; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 11 Oct 2025 19:10:59 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Date: Sat, 11 Oct 2025 21:10:05 +0200
Subject: [PATCH 2/4] ufs: unipro: Add PA_SCRAMBLING property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-mtk-ufs-uboot-v1-2-a05f991ee150@mentallysanemainliners.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760209846; l=752;
 i=igor.belwon@mentallysanemainliners.org; s=20250908;
 h=from:subject:message-id; bh=H9Dk56u1g95MqxMPmFfb462Pz8jhJutA6M9Z2dgCoQk=;
 b=JX+/q3yZaTSw6QBOCCWwTj9DxaqA4/AnQGVgh2zMrfIaXB+9Zg5FIf05/TMF+2gm57Th2s5rN
 QKm0BMTt1PjDX4PIxBI8dzas1DCdGhix6kjHvEsAh/5hMapAI7M2w+w
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

This property is required for proper I/O access on the MediaTek MT6878
UFS controller, and is part of UniPro specifications.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 drivers/ufs/unipro.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/unipro.h b/drivers/ufs/unipro.h
index 56833602b77abbfa4abff5f2b57461986fe815dc..bde1490397cdc043d37e118eb98a1baff04021f2 100644
--- a/drivers/ufs/unipro.h
+++ b/drivers/ufs/unipro.h
@@ -125,6 +125,7 @@
 #define PA_RXPWRSTATUS		0x1582
 #define PA_RXGEAR		0x1583
 #define PA_RXTERMINATION	0x1584
+#define PA_SCRAMBLING           0x1585
 #define PA_MAXRXPWMGEAR		0x1586
 #define PA_MAXRXHSGEAR		0x1587
 #define PA_PACPREQTIMEOUT	0x1590

-- 
2.51.0

