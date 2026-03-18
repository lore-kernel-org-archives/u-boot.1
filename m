Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272D9103E197
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 15:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 604FC83981;
	Wed, 18 Mar 2026 16:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="etFiMtrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D99E683981; Wed, 18 Mar 2026 16:07:22 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B735F838FA
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 16:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b97b30fa5e5so619193966b.3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773846440; x=1774451240; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p6o9IrQmE+M9cSnqmQsPhz10Jxi9/+kueG/Z5747lAU=;
 b=etFiMtrSIWtkZFQ0jFvxilSilsuTU5F3M8Bt5+0fd2eM+ZYwFSFkFuwido2cGmg7qZ
 gb+iL0cZgGr+9LIwwJrwWiM4G+1Bjxq1AoY0jtAWrVXw2bIM6zIzI9B0IVV7gt17sElS
 AgXsOezM4WoEzP5g/07WATXRspAi4elOX1HdSm1vMbwt193Sv+MRSdBUTDpharEpltu1
 oQ7R/HaPGZNGfGkEIhyxmRims/gNz5mm6FcG+8cf8NJ5yNThi5ZYkE0KSQknCdIa+RLQ
 CQOMpJ49w1Y5ZKOJIwmZNUyFf+t5CbR3fYUIpYR2UBmSaG1ztX9pg30jdLNzjLWnp34f
 uwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773846440; x=1774451240;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6o9IrQmE+M9cSnqmQsPhz10Jxi9/+kueG/Z5747lAU=;
 b=YRhkDfdNLzlJ8fb9iJXqM7o619zKuGoH0uBRFjje71hxtik5BwQZN8oMGVmlJGyD+9
 7tWZWPmg5eM6fm1xH46MavPZfdzhS0uVDd7VrfiOEtPCY/bxAB/8FEJjOQ/4LnbgtWYz
 fIBDJ0ekQzUPdwBLjkhh14xtZ6xAS40m8iHHxsUkM5SDQ2QlNJ40/ABsJ2cgshTIp3L/
 Hd2yk4M98BsHxeqZ3Ge5ylJvSJO8lz2XxmPm4B5YdMf435/HOKivcJaeqtfrOAa4iVlu
 vQ9kdP1dHVKHkCN4Y8tLPxXIwDZjYJYL13VkQZZc2NyJBFFK9B1qVPmdqgqkdZjoFs7Z
 YpcA==
X-Gm-Message-State: AOJu0Yxjt3bV/C3JTU07c9BuVjDqnZN+mCTTYvWkZDoslmd84oyGesig
 sEgQ6DI1JnwqDXoXt/O6PWtBOtgEbja7OTQWsaL1I98C7+qErjejda27hvdVElJ7XA77SqZr3UW
 KjHWD
X-Gm-Gg: ATEYQzx+jx+50OygHRmKcFX2jHXXe1mYQBDhXFIrW2TURGuSa0Z4iurCTEfkpc1zm7j
 vFjHXwe5I67aLuRkQafIQl2fL00DlbbtpFPeIDHkdMrd/9s3fct7ZIVQii6BmmcTbgPC/jovr5K
 3/J1gfbqEjIG+GStX7NGntyEsD2HKj5PyU9mIkqYmK22cdtvWzLTDpsd0fFNsgCAsB+DsUqQMPj
 UWxtEOAEnPurCM6P2vYsj9NO6oWH5lfJKXPWRieuYTt51xzFYr4c0oyY0MZDePP+xGaEdfGm5dm
 Zq/QSFzyQpNKojLFjMn2iPCy9D2vnX4t/cUVnPbaZRR3g1/A9qW/RcE5vF19/7FzpLeYoIT4UI6
 MWzAkEupCHBv04IgK6eJL5VbCo+CQP1q2nuKrARhUmnP6JGeAeo6V9dG9nd9ZoXcXLYhOm8Xolw
 +cgmM59MVXa35+uJNpDgFMo9lB/x5QqfScYwppDVmz1cJf9iP8VDHsTuwKaN6ASXUs6YFffM0tS
 WPK0A==
X-Received: by 2002:a17:906:2756:b0:b97:a2e9:3c1e with SMTP id
 a640c23a62f3a-b97f48c05d1mr224060666b.8.1773846439751; 
 Wed, 18 Mar 2026 08:07:19 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f173a3e3sm222787466b.61.2026.03.18.08.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 08:07:19 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Mar 2026 16:07:17 +0100
Subject: [PATCH] video: simplefb: Map framebuffer region on probe on ARM64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-simplefb-map-v1-1-edec1ee81df1@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBPUIKqrRIsxxxpIE4UIpLsnL
 d/i/wqFMlOBWVTIdHPhKzboTsB2YNxJsmsGo8ygej3KwiGd5K0MmCRaOzmLishpaEnK5Pn5d8v
 6vh9+YiFGXgAAAA==
X-Change-ID: 20260318-simplefb-map-abb9dba0eed1
To: u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773846438; l=1782;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=jSBVbhXFqcKpt6gzYHG13HcssChKBGYSXYbH74D2bz8=;
 b=Q5RsIDbYYsY1otQ4JsWXWL7TXaI2iTsIarbvaV082nuyXaaZnOKNlUBS/3l9IT5jeeriIHjds
 XzJlsLMZ09dBwo4JbYExaH7dBZJbRpHGpGcsRDBQ9qD3hNf0lI0Vb6A
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Mar 2026 16:20:44 +0100
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

The framebuffer buffer might not be mapped on some devices.

This is #ifdef'ed for ARM64 since mmu_map_region() is not defined for
any other architecture.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Map 0x1000 extra due to unknown reason, but otherwise it's not enough
and we still get a "Synchronous Abort" when drawing at the bottom of the
framebuffer.

For milos-fairphone-fp6 the framebuffer is reg=0xe3940000
size=0xa932c0 (2484*1116*4).

When just calling mmu_map_region with plat->size, then it's crashing at
0xe43d3000 even though everything up to 0xe43d32c0 should be mapped.
With size+0x800 (or less) it was also still crashing, only size+0x1000
then worked.

Possible I just don't know enough about memory mapping things, so
suggestions welcome! :)
---
 drivers/video/simplefb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 8d0772d4e51..e144fde697b 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <video.h>
 #include <asm/global_data.h>
+#include <asm/system.h>
 
 static int simple_video_probe(struct udevice *dev)
 {
@@ -37,6 +38,11 @@ static int simple_video_probe(struct udevice *dev)
 	plat->base = base;
 	plat->size = size;
 
+#ifdef CONFIG_ARM64
+	/* The framebuffer buffer might not be mapped on some devices */
+	mmu_map_region((phys_addr_t)plat->base, (phys_addr_t)plat->size + 0x1000, false);
+#endif
+
 	video_set_flush_dcache(dev, true);
 
 	debug("%s: Query resolution...\n", __func__);

---
base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
change-id: 20260318-simplefb-map-abb9dba0eed1

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

