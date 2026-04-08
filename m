Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467F31073CAE
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE8484214;
	Wed,  8 Apr 2026 14:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="S5FT805F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDB6C83F98; Wed,  8 Apr 2026 14:04:57 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B6AD838BB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so6350466a12.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 05:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1775649895; x=1776254695; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yYcnZx1ipki/FCn2q+HhNZKKoKlXT5xWFFNrqrUep1I=;
 b=S5FT805FLTGcfLD6Qx0OIW0zQQbja7MW2CpiLtWXy/W+exAlxJ+KEatyRIKOoASVl3
 jALyH8QZKRlMLsMj5j8qGaeetbVJrcBZWMUzaD4GveJCW5i5mXcJFz1035Rn6Elu1PCe
 bWQ9S0AeQmBdvd46THQy+9C5oRYiVE1Qb1X+9+NY5D5sH8KCm0vdI5ajVyHRsSa8z8J9
 CTqU1VGV1+UA9a1Ox3W+2TosOb3/cU51Q+E3HUncNsr7DOwInHnEaXS8eh8mfUJ0w9ii
 TNhIJSgQz3AnGl6UwruqEwkqFdTwGYC1GFa3pcy8Phqha/kN9hCVHVFchAcAssZPO59Y
 gJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775649895; x=1776254695;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYcnZx1ipki/FCn2q+HhNZKKoKlXT5xWFFNrqrUep1I=;
 b=UxFyUj40euVxfjLSy3sG6viq7iMN/T53epYZYRrhnKzRSxpQONDgtssR39nb9wq6uE
 BB4+n7Jp9iMvGNMZ3EEJQDoO69wS95z+do7OA2FIajPgO6PH0kTo29ovfS+ZHE0LAMNv
 YHrb6car4OyDCphWR6LeXdkMWzko6apQjZW+DG6EUzupMApYAx6V8M3nQJrBNpZXSdFW
 YzVigGj6vw/OlUfdEPEDVl/D5Q9c4rJlFgXMuMkiLeuNCX2X12mx6SOCPuXxfn4PLa74
 tLRKQa9GSRoX1q//17lQPnfUc9txsLLyVEUqB4Cz6JeGBC3NQDphSER3pbPyvRj3nOBS
 eWFA==
X-Gm-Message-State: AOJu0YxHAMFCD8obd0mJlFz8vhlCbx8HhluTM7OtDY6a2R2dWoddomfv
 iHARHQjrkxkX8H8QIXYJ4fhZ4nKpxrwCoVv7Sa9bO1+LNiBxSd4RGUtnfx1vUp8OPZQ=
X-Gm-Gg: AeBDiesMYRW9UG/Q0breSSF/yjHwy6rx697OVjJ3iC2GaBHJOFfU5jTesD+w+dDUFiu
 1YFFUV3plsWOZk4ByOOaBnxK1J3hDivpE86B9jelgcKDsmt2EXXcJOJ4hW9/TNwURwdjEEx4cUg
 +yqP3Tfo4Ye6veiBUa1aIfNuZeyWWXX13QRbP4Qxo/ME5TbymTTFh0FKAh0+KuiNzIbx9loJlC0
 QAmE2h1ezVtbIsijcqxDkUZbI+fC0f31QT7IrIWpj1wfU/1ltt7gyTRbSTUvSlO2yQ2A11wGgoD
 3l4I6Xs4BfKlfAU+SzT8D1Wn5AEpw23erhPUwg1Yqj3d5iIaiWOCc93lp4NMywK9QzpTBpeMVqt
 u3j2N3BlLGiGJIRQzCIw1QMeD6t2JuXDX4Fe8OSc6oRblXXL2s2U54ezfByGCjfEqA0jlU7v8CG
 TJKsMzcKy0QhjCXEaouJjQPjHEOoM9EryEHtNHEzi0SwngpuUckGdQCFRPDneE4/YvffsVjWOPs
 lADtg==
X-Received: by 2002:a05:6402:34d5:b0:66b:f0b3:42a7 with SMTP id
 4fb4d7f45d1cf-66e3f71ddaemr10625569a12.24.1775649895004; 
 Wed, 08 Apr 2026 05:04:55 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66e033a7800sm4964337a12.18.2026.04.08.05.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 05:04:54 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 08 Apr 2026 14:04:28 +0200
Subject: [PATCH v2] video: simplefb: Map framebuffer region on probe on ARM64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-simplefb-map-v2-1-c0a8dd497582@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMywrCMBSE4VcpZ22kp4JUV76HdJHLxBywTUikK
 CXvbuze5T8w30YFWVDo2m2UsUqRuLQYDh3ZoJcHlLjWNPTDuT/xqIrM6Qlv1KyT0sZcnNE94Jj
 aJWV4ee/cfWodpLxi/uz6yr/1D7SyYgUHy8DIzvPNa8kpxAVHG2eaaq1feJGAjawAAAA=
X-Change-ID: 20260318-simplefb-map-abb9dba0eed1
To: u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775649893; l=1585;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=siBuzYSNnikcIv0rt3Qe8E8jAR3q8GaHrCIS2g/DyRI=;
 b=KPSgtAHozY22P66JXu1V850DyrdTaDFdMDS3lkE5zNCf3C7hWniQPZr2IyErluU+zmDDnuWO8
 H2baP9Go7dtDYmFkc32nyc0UymyrpYNytLuQabQ0Fu84deL96AfZxM3
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 08 Apr 2026 14:55:29 +0200
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
Changes in v2:
- Use ALIGN(plat->size, SZ_4K) instead of + 0x1000 (Casey)
- Add log_warning in case framebuffer base is not 4k aligned (Casey)
- Link to v1: https://lore.kernel.org/r/20260318-simplefb-map-v1-1-edec1ee81df1@fairphone.com
---
 drivers/video/simplefb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 8d0772d4e51..4d238b936ac 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -9,6 +9,8 @@
 #include <log.h>
 #include <video.h>
 #include <asm/global_data.h>
+#include <asm/system.h>
+#include <linux/sizes.h>
 
 static int simple_video_probe(struct udevice *dev)
 {
@@ -37,6 +39,13 @@ static int simple_video_probe(struct udevice *dev)
 	plat->base = base;
 	plat->size = size;
 
+#ifdef CONFIG_ARM64
+	/* The framebuffer buffer might not be mapped on some devices */
+	if (plat->base % SZ_4K)
+		log_warning("Framebuffer base %lx is not 4k aligned!\n", plat->base);
+	mmu_map_region((phys_addr_t)plat->base, (phys_addr_t)ALIGN(plat->size, SZ_4K), false);
+#endif
+
 	video_set_flush_dcache(dev, true);
 
 	debug("%s: Query resolution...\n", __func__);

---
base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
change-id: 20260318-simplefb-map-abb9dba0eed1

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

