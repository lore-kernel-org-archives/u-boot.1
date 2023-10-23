Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D04CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 14:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D5D3877C2;
	Mon, 23 Oct 2023 16:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tom-fitzhenry.me.uk header.i=@tom-fitzhenry.me.uk header.b="lyNliswl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40D33878ED; Mon, 23 Oct 2023 16:23:35 +0200 (CEST)
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com
 [IPv6:2a00:1098:0:86:1000:0:2:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50091878B3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 16:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tom-fitzhenry.me.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
 bh=UjMhGR0ZR0o4rkAfbYhzBwUOA+572k4viMsiXhpiME8=; b=lyNliswlP6fJXQZM0+jkdRGtsA
 rmLbODPMcRSirD/MZ+E9K2pWJFO56a787fvO/uhzUnL6wqaiVplgArEQHYFVg3TjMam7PZIpmPTCE
 2izOkHT9xwlJ6cGhSmK360tXGQY5mKGms3g5UweWdPublfCfW6ubNasNi1Q8+G3+79UquBmWDwbSg
 B00mstbwp2V8TH5bZp8bzjZsl0uHFiiAKbEaFhCyiwOUAp22X1J8LGFcEIUv9H135AE3F1bXrfzm+
 2YnejZE0UCO+NOFe9Vy9nJm6QpuML0QmmlOSCbgq+WdewiElPefBSPOlwsBJvi97qP1Zi72k9nbcW
 b3EWtmOA==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tom@tom-fitzhenry.me.uk>)
 id 1quvq7-00H08D-V1; Mon, 23 Oct 2023 15:23:32 +0100
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: 
Cc: u-boot@lists.denx.de, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH v3 1/2] dt-bindings: leds: import common led bindings from
 linux v6.5
Date: Tue, 24 Oct 2023 01:22:21 +1100
Message-ID: <20231023142246.26830-2-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023142246.26830-1-tom@tom-fitzhenry.me.uk>
References: <20231023142246.26830-1-tom@tom-fitzhenry.me.uk>
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

This brings in more colours, e.g. ORANGE needed for the QuartzPro64 DT.

Linux commits:
472d7b9e8141 ("dt-bindings: leds: Expand LED_COLOR_ID definitions")

Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 include/dt-bindings/leds/common.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index 3be89a7c20a..9a0d33d027f 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -33,7 +33,12 @@
 #define LED_COLOR_ID_MULTI	8	/* For multicolor LEDs */
 #define LED_COLOR_ID_RGB	9	/* For multicolor LEDs that can do arbitrary color,
 					   so this would include RGBW and similar */
-#define LED_COLOR_ID_MAX	10
+#define LED_COLOR_ID_PURPLE	10
+#define LED_COLOR_ID_ORANGE	11
+#define LED_COLOR_ID_PINK	12
+#define LED_COLOR_ID_CYAN	13
+#define LED_COLOR_ID_LIME	14
+#define LED_COLOR_ID_MAX	15
 
 /* Standard LED functions */
 /* Keyboard LEDs, usually it would be input4::capslock etc. */
-- 
2.42.0

