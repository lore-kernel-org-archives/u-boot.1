Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617F7CDB474
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 01:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5328C86F11;
	Wed, 18 Oct 2023 03:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tom-fitzhenry.me.uk header.i=@tom-fitzhenry.me.uk header.b="jktsCGzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14DA186CB1; Tue, 17 Oct 2023 18:00:48 +0200 (CEST)
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com
 [IPv6:2a00:1098:0:82:1000:0:2:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 793B186CB1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 18:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tom-fitzhenry.me.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
 bh=ZmeiKV9Fyn0ZEctMaTBz/glNQaLb1ZXbbehdRTmfaS0=; b=jktsCGzl8MmaIQSAtUiM5uUhk+
 bo/7pnb7CnJxm5JlZwnVCrIyQjAuEmf0xjZ8HKBsZFhHVPQZ31XYmizxzMmFrZIghl6FVEeStT3G0
 qt6FVe8fIvH32oBI3nj+oyAqzwrMryRkECPXvcMmNJC67q6WjTHBQoZivFR7QiP5FgnWh3KLtalP4
 qC+oBjsSNn9bxRoiOwXg3ZmHPqp4MsmWDZFSMm+AmDdMM/Ij7a8e+LwhfpIWoNRuChXEKIdoW70SL
 Q31lAleXfthGEKZJwCrJmrcwC2HBmhU495WpW1UN0jbjGU1nYn45zqObMxqidLpGMDuyR/J5KIwwZ
 NAtnLnyg==;
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tom@tom-fitzhenry.me.uk>)
 id 1qsmUs-009Vel-4t; Tue, 17 Oct 2023 17:00:42 +0100
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: 
Cc: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/2] dt-bindings: leds: import common led bindings from
 linux v6.5
Date: Wed, 18 Oct 2023 02:59:25 +1100
Message-ID: <20231017155943.127659-2-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017155943.127659-1-tom@tom-fitzhenry.me.uk>
References: <20231017155943.127659-1-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BlackCat-Spam-Score: 49
X-Mailman-Approved-At: Wed, 18 Oct 2023 03:25:10 +0200
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

