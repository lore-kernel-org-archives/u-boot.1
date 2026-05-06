Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD51FCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 23:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A7684099;
	Thu,  7 May 2026 01:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="aXqnmkRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2900846A1; Thu,  7 May 2026 01:05:46 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 519BC83A91
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 01:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so119687fac.2
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778108743; x=1778713543;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PdIhmmorDifGDWuNZ2wlEGnMdPmTeROATtwnS7a9TEw=;
 b=aXqnmkRPoX1LqgDM0O1T2tPW4xEqT3xZ3ei4AuUWKP48nxpmitjNZSPib1acuQl0z7
 TMkAgxCbVGXEubK0FZmL1ZfwsEXCMbgw5CejmtDY8Ko6LuCuc7INs0/nrB7sl4Si365n
 eNLvm8FMMU8gP1WmvA+mRkG9QaoJUenRb7Wwn397dunaZtRMo25FKOMf2w7vgg8L7Nfu
 XcNK6hIk04SDM+ws1IcRW/XzQqtYURjnefmjarddlwpVca3IgqkGeLSf9OPmU2EKifpM
 4XGwsmcfgOBoC4hydFqXtB8gkQRIFmacuyrabyZxMHyMhIB/v/5Df5EAvsczTrnl7gRs
 nKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778108743; x=1778713543;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdIhmmorDifGDWuNZ2wlEGnMdPmTeROATtwnS7a9TEw=;
 b=lWkfIP85TcNjzoLSYuah+xt6znszzBkOh8kCazk9utNqxryawVxLOwJdtVJ3XBLIvh
 Ozcf3j73Jly25g1I0Fv5DmSYurv27dkGdhyugZn/kWpg/M/k7FbF9hhb5ENYbGTkDmSJ
 VU0GlHmRA/OU1/S175riHBOmq1TDrVYs7IkUeuYPLvyMt2RTaRwTOgdaCddZB+s8v5lR
 6guHVToeK6dzobPOUOMIocNc2jvBRHOxoIVCQqXAjENzTgIlxfHSrX7rBG3ZjaI+TdL/
 sVHiZZNJECG8xtbSG12g0qaXRXuot06Du1fcNI7hPnZo8Mqtohqj8n2XotjsCxz/P/EO
 oIQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BcA1R2CCC6deH0w/vQ8NbNu4HitwCROnCosvtopac93F1J3z6Dbmvaf/SdV6f4j0+MySFA/4=@lists.denx.de
X-Gm-Message-State: AOJu0YwuOjNfv4u2HWGu0c5OTmlgDSYH30A/J+up1Md+GWqfU/SKa+vK
 ycE1EGr4ZytIeMf0qTYKUYPjD50XhGHaVTJkypA6pDQs0niki+P7odH7TGsyuehxdok=
X-Gm-Gg: AeBDies8kHxVJhSLfHCsCNS/2puBU7/0a2qJFd2+y80WkxRBigXHtyN0JmbkHJiNq0R
 qPHBvQvQW8bKx/yhic7t6DPEbpRO1Zu8NbBA7VJ3ELQ6dHApUk+1F8Qz4MPFSiSozC258lx1MnB
 vv3h0f4TfCwAVjRjA3mtRHea5qgTIEnFYZHNBNJ0FTiJ6LrMK/D9cVjUOhdl2keJoyOZkdBHQeQ
 zB48mmQz6wCuA2p3kNvtPYIets5h30xqoosccJKOobLAWXcyr7GdQ/AzldpY5zuPAGp7thoHovN
 CORm+gSi6PrSUYjmJDwSRrYAgz50OS8IcBYZINLdOaXS7FsXlsDUyNJPFTmr081ncsxo8g0AXX1
 8WY7eiMBNer/hV3q1HGnLsUfjeD/LkeJhC1uNsrqSLYQefOMUqWMZLH6XrBMB3tnyoI+uCW67vu
 IKJspd45IreeSXHjL8z7VuMTDr7oYWgfaydc9Sqr8=
X-Received: by 2002:a05:6871:b0d:b0:423:f59:31f4 with SMTP id
 586e51a60fabf-434f6359cc9mr3601888fac.11.1778108742954; 
 Wed, 06 May 2026 16:05:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7374:f02e:e8be:88a5])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-434ca5af84csm8104943fac.12.2026.05.06.16.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 16:05:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 06 May 2026 18:05:31 -0500
Subject: [PATCH] pinctrl: mediatek: use scnprintf() instead of snprintf()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-mtk-pinctrl-fix-scnprintf-v1-1-56b99d5809db@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw7CMAxF0a1UHmMpCWoHbAUxaBIHzMdEdoqQq
 u6dAMMjvXdXMFImg8OwgtKLjZ/S4XcDpMssZ0LO3RBcmNzoJny0G1aW1PSOhd9oSaqytIJxjCX
 7ee8pB+j/qtQHv/bx9Lct8UqpfYOwbR+1SOyufQAAAA==
X-Change-ID: 20260506-mtk-pinctrl-fix-scnprintf-b5bfd1a31ed2
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2651; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=wpW5ErHavG/AsIKKLU0wLdgAu9z4KC4YN6QFbfCQjqw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp+8k84FpY0UIVcfAvYGx/2HBcqI5bU653tu/j6
 IxvA5Y34jOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCafvJPBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AqSEIAJJePECn8WDr4CZLLaSxefywmqb67TVhD7pWH9U
 RYLrWzfQDpj/q7jdfWLka4t4NVUg0Nwbqx1JDnDfwBRDWEqweALZ4K8ryy8FXb6iwR6dsBjeEy6
 XY+DjtKrKxSU5e5BK0w3qOS0sVDbVCMm2YX1551Mksp6NLRdJ8j52jGNWN2h/FcYfXqMbJE+k/g
 kFqhbHNbeBpozhFya3MwjzVDGirUfgbMd+YzmUpA0apuKhenJQ7BMqupc0QVLRtpEt9j1uRhkhY
 qzdEIn1vsp5rWRf/uEgkRTNN9icX3H418VmeY5AXJlgNub9sZwOz2vTLyCTHQte9LqpXjDTzI7s
 egvA=
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

Replace snprintf() with scnprintf() in the MediaTek pinctrl driver.

snprintf() returns the number of characters that _would_ have been
written if the buffer were large enough, while scnprintf() returns the
number of characters actually written to the buffer. Since we use the
return value to advance the buffer pointer, we need to use scnprintf()
to have the correct pointer arithmetic.

Fixes: 76da7482cf39 ("pinctrl: mediatek: print bias info along with pinmux")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index cfffbaeef84..01f67f09407 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -251,7 +251,7 @@ static int mtk_pinconf_get(struct udevice *dev, u32 pin, char *buf, size_t size)
 	if (mtk_get_pin_io_type(dev, pin, &io_type))
 		return 0;
 
-	pos = snprintf(buf, size, " (%s)", io_type.name);
+	pos = scnprintf(buf, size, " (%s)", io_type.name);
 	if (pos >= size)
 		return pos;
 
@@ -306,7 +306,7 @@ static int mtk_get_pin_muxing(struct udevice *dev, unsigned int selector,
 	if (err)
 		return err;
 
-	pos = snprintf(buf, size, "Aux Func.%d", val);
+	pos = scnprintf(buf, size, "Aux Func.%d", val);
 	if (pos >= size)
 		return 0;
 
@@ -721,7 +721,7 @@ int mtk_pinconf_get_pu_pd(struct udevice *dev, u32 pin, char *buf, size_t size)
 	if (err)
 		return err;
 
-	return snprintf(buf, size, " PU:%d PD:%d", pu, pd);
+	return scnprintf(buf, size, " PU:%d PD:%d", pu, pd);
 }
 
 int mtk_pinconf_get_pupd_r1_r0(struct udevice *dev, u32 pin, char *buf, size_t size)
@@ -740,7 +740,7 @@ int mtk_pinconf_get_pupd_r1_r0(struct udevice *dev, u32 pin, char *buf, size_t s
 	if (err)
 		return err;
 
-	return snprintf(buf, size, " PUPD:%d R1:%d R0:%d", pupd, r1, r0);
+	return scnprintf(buf, size, " PUPD:%d R1:%d R0:%d", pupd, r1, r0);
 }
 
 int mtk_pinconf_get_pu_pd_rsel(struct udevice *dev, u32 pin, char *buf, size_t size)
@@ -755,7 +755,7 @@ int mtk_pinconf_get_pu_pd_rsel(struct udevice *dev, u32 pin, char *buf, size_t s
 	if (err)
 		return err;
 
-	return pos + snprintf(buf + pos, size - pos, " RSEL:%d", rsel);
+	return pos + scnprintf(buf + pos, size - pos, " RSEL:%d", rsel);
 }
 #endif
 

---
base-commit: e08877916e24cf97d3afc67aee65ed2204790f48
change-id: 20260506-mtk-pinctrl-fix-scnprintf-b5bfd1a31ed2

Best regards,
--  
David Lechner <dlechner@baylibre.com>

