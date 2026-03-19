Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3B81091915
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A8678405B;
	Thu, 19 Mar 2026 21:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DC9SRDH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66C9483FE9; Thu, 19 Mar 2026 21:02:17 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F4A083FDC
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-67bb3fe55a5so372424eaf.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950531; x=1774555331;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A27fg/irbLwjcxFSgS3KWeUKaNPocA8Ex/lSWZXTTI4=;
 b=DC9SRDH6Qd3NBt0EJmZ7Qrd3wexbCvUo2TCcXl6/8tRIzfo92CtdxY4tpIf+vPp/v/
 kLnkE2d+XGB6KukIdyuCcu43DDWCWp6My1wIXN8Ylj4W50H+4JFE+XNJG3XdK/7dTsy/
 bzNC0M3itzo+e97SSjr+xpmjrHYy34XsVwVPORgieCiPu6krNRuhPH9EAS+Lj4cbpWWv
 qbWGRJwEXecoDonwFoADyMqPOhbgtGqnllUhfG63jIJsx8MAvk/Y2cVbXZllnPfxq030
 oDKkLmm13GVUCedCWpZYa6XP3p0JDLtFr4KXvvt7VrhB8kDCbsLmaOqy1yn5+rOFcvf8
 9RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950531; x=1774555331;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A27fg/irbLwjcxFSgS3KWeUKaNPocA8Ex/lSWZXTTI4=;
 b=a/3HXlaKZbfS5Ij5Js0hOv5UlQKfk0IOZrfOeJoXXM/zZM/26zRnGUc7ndlN+T8E9m
 35PQjjQId8rS9d6mOlE6d0Hh3WMK+0+HxMmPGsX96jbImHKTroguA4Z1bMfs3GnyHqSy
 QApmXrtyZPr+KXujEc7sc7rdPB7XFVWyBIgRYId0hO4cltGdwNcUIZpjDsXWJgavMB3p
 hGkVWPKI9VrHh6sUi2hKtHIChEadrrzjgtMFERGW9T2p7qv8D+IZylFDVFlermh/Ix5V
 9OeAVKeRoGwWH6Xvs09eli0oDiMOEHL3T/L1H5zi/cj3IVQwj2aJKK8BQoGCwOl1Ujoh
 LjgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsfyBOO3hBUPB/w8+1lRkLvNXx09ItXrOsBrx1I3f8fyhrHno4N692gGLsFKTCageC72K8HPM=@lists.denx.de
X-Gm-Message-State: AOJu0YzTaP96LXnMqBU7Q7+nNiofjdVCGIblRj91YjdpM/YkHFvsHR/G
 q8lUXRwXpVkeQjo+o7lbnOqlJkTLplNJvHqXcfpL21FzxYVYlNIq0wg5dxkAuSRTq70QBFcpido
 kdd++
X-Gm-Gg: ATEYQzxYTfHLX7ERamZSoOiWaSFUp2FoZX6MRS9qoQEpyM1AXPi5HDHi3Vw6HZMbYWZ
 rEX85E4WXcPQDW664rca7iz10scRml98zhrzXnkh57wBmpMPQIODIW5+fqzBS9JlljsTKpe/sMX
 JzL2C6ioxYDGB+iTedpx0P9xvXNC5tY038Yah8UB8SBjWpSAf8B0cGIdYG/U25Dbd7aDbA8JDGG
 4BDuy4FWpskUyePYiebtHmdzYRAnMB07lDt+Jh/glpWsGCh8gc2PaDj+HqdE9mHTCbw90jWw+cU
 ca/VBal1TlNpbemXd7Bt4JllQW1QLa0P1ftkp2FqPgCZWnSgx83dJtvMWqY6A+nA98YYNo5HNO7
 1nExxV1oWiQzxGd2katpimecgO5Zaua7ZCeio6PC8eBobN7aNLV6rpeaDnTYL1eFqed8rG4DXoP
 QWPWPZpAFRunrSC9CemVCzGr5eBWSb
X-Received: by 2002:a05:6820:20d:b0:67c:2111:e35a with SMTP id
 006d021491bc7-67c22fd09c2mr524208eaf.60.1773950530883; 
 Thu, 19 Mar 2026 13:02:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:06 -0500
Subject: [PATCH 03/17] arm: mediatek: mt8183: drop dram_init_banksize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-3-6171ec141f40@baylibre.com>
References: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
In-Reply-To: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=bETzkV73TZBaR19AZOW3c2P19KkB0IqOFxAhHmg78pI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFXbr27RT5iOk/yjxJ1+mgaedCrR1y+y4WIEV
 yXr7aza12mJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxV2xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ACw0H/3aBxJ2MuOXpyIp/dLJvSs+vn1ZS62ZhRNx00hb
 ZseKNth4G4ob8chkxfWy+MU1LRwkThQFGAsxRBsLVnR0rzsZwIeLCX+F3bJLlroapuogjBQf4cN
 4434e7QRykLknGo70y/Uj3J+WoeTzLBTIMRh1GbvW+obWX4iCPjenW8FbjC4hs71oj+4pOx7QSV
 rmJ/DAa0mxG6tIHgmin6A2/szJRmMsWX3VnM54TDdYuxm6MyBp2GIGdoJoB90veC7MY36SSttBb
 h6GlQe6y/DveTHn7bBYS7cTPQrMjCSMivE/NdzIn7G/PSmMxR8aTeuPirwuVYKjlZhxpF5v0ubM
 2lAY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Drop override of dram_init_banksize() weak function for mt8183. This is
effectively the same as the default implementation, so we do not need
to override it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8183/init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8183/init.c b/arch/arm/mach-mediatek/mt8183/init.c
index 8dbf9c3df7e..5c3c96e126b 100644
--- a/arch/arm/mach-mediatek/mt8183/init.c
+++ b/arch/arm/mach-mediatek/mt8183/init.c
@@ -29,14 +29,6 @@ int dram_init(void)
 	return fdtdec_setup_mem_size_base();
 }
 
-int dram_init_banksize(void)
-{
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
-
-	return 0;
-}
-
 void reset_cpu(void)
 {
 	psci_system_reset();

-- 
2.43.0

