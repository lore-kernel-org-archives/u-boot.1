Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6EBC54788
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 13:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A82880AD;
	Thu, 22 Feb 2024 14:08:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="x/KRlpAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB00880AC; Thu, 22 Feb 2024 14:08:32 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61FCC880AD
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 14:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MD8HBi043214;
 Thu, 22 Feb 2024 07:08:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708607297;
 bh=x7iRKbwv7LbGn3PMN/Gryx2Q/upC+PiWc7UTOS1UlgA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=x/KRlpAD7WKL0aN/Jlu21AcA2+PAXk5HbO21/ZLgZPsRK42hwbkbDli1dQ0Dq12Mi
 OZkhvsEc4dGzjRD2kJ6LzYl70BaAKJr43Euc7/FnW8YnOQx6Zg1H2p550LW++K7VoF
 7/e+05JWM8N1bW58873YboQ+uRjWcnbaYEQIQr1k=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MD8HWx020611
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Feb 2024 07:08:17 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 07:08:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 07:08:16 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MD8FJm081854;
 Thu, 22 Feb 2024 07:08:16 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>
CC: <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <patrick.delaunay@foss.st.com>, 
 <patrice.chotard@foss.st.com>, <hvilleneuve@dimonoff.com>,
 <michal.simek@amd.com>, <troykiskyboundary@gmail.com>,
 <j-humphreys@ti.com>, <afd@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
 <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH 2/4] video: Assume video to be active if SPL is passing video
 hand-off
Date: Thu, 22 Feb 2024 18:38:09 +0530
Message-ID: <20240222130811.3878567-3-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222130811.3878567-1-devarsht@ti.com>
References: <20240222130811.3878567-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

If SPL is passing video handoff structure to U-boot then it is safe to
assume that SPL has already enabled video and that's why it is passing
video handoff structure to U-boot so that U-boot can preserve the
framebuffer.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 drivers/video/video-uclass.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 3571e62ba2..7b5d1dfbb3 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -404,6 +404,10 @@ bool video_is_active(void)
 {
 	struct udevice *dev;
 
+	/* Assume video to be active if SPL passed video hand-off to U-boot */
+	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL)
+		return true;
+
 	for (uclass_find_first_device(UCLASS_VIDEO, &dev);
 	     dev;
 	     uclass_find_next_device(&dev)) {
-- 
2.34.1

