Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A22C2BD09
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 16:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE2058848D;
	Sat,  6 Jul 2024 18:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HbXadJ05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 771678864F; Sat,  6 Jul 2024 18:13:19 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 989CC88360
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 18:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-367ab50a07aso950847f8f.0
 for <u-boot@lists.denx.de>; Sat, 06 Jul 2024 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720282397; x=1720887197; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bz58fppiV+KGnnU8yNRW1+M8DsWrEz5Vng8b1x+yvfw=;
 b=HbXadJ05x+OGs34+fHQwUc2XPQ0FvZiZ6N0sQu0J86uGf8tcv5AEnmR+F3FesBW+0d
 fZQHt4TByr1FwNt4i7U8FrGhwXp18ok/boKtbXSmpXoztBQR89x7L95D7gXaFpHMX2wU
 eEhyhzpke5NRG0Ml2oMreAwoYkxroqLWqLjIUz/O4tG231YIGgqSVTUdpE6c0MTSPRsP
 pIZF+ZAWLquK9MxYM//ryxDvEUCalTyf3oRR/nvudwmNKloBuXW7ozVG9ieSZ+wmF1nb
 snrwHrYXskJ7CRA5sojEZCWRnbTQ4hcHh3/SJifB0bFpIu9BSN/I3cL7GtOyHALOSHIt
 iC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720282397; x=1720887197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bz58fppiV+KGnnU8yNRW1+M8DsWrEz5Vng8b1x+yvfw=;
 b=cGXdsMTi69ticizJyT5UlQJXgRdYfGRIOKi2z8nqcHEURkmcZWHF8jF5BDNTR1abYg
 MfwlCAbW3QGTPP9h12osifg6yV1KzNDoNdYiaORpT2ZKKk8iAcJ2txQqBKaNLfymqHOZ
 xhk6q0mVoVg/9kvxDbSMuC91o0MpakDS2WQQAJB5r9YjTRypO3a5FxSx+APa30+YP2mK
 9UTrI8M+Gn91m1TW8OTbVeyYEhNI52sRR8WNX+Y6yRhPyWbmFTn1qAkmz+kcw1TaQJiy
 I5Lve85unBVZP+y2VE14DIH4DYHMK6A0IyoGrgD/g8k6dxmdb3bnKM/FYb/eTzMlCBga
 PzLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNE2+hbJ0I5qaIsbqai/Zo0zXHbqSWamiaqQjy3GyTdhgUQC9sVwKF0ycERyCoC2JkBBZJJQZA4WhA+XNplVbyuVcqxA==
X-Gm-Message-State: AOJu0Yww1MfhRc3cFNCdGr+LXJqYAEm6cd2FIm4KdJPhyOV3CGDq1qwv
 7n+fVWILtv3ewVAEQt7o1wLiCRezgQoesJn5rnr3nak6W5ERiYcB
X-Google-Smtp-Source: AGHT+IGe5Mrwb7H8Znxvqcowi8ZWEoG3EKLzW5nW1Rb2jW8319obgVW5VTH1Q1xe3/zwhki3Llle3w==
X-Received: by 2002:a05:6000:1e8e:b0:367:8a87:ada2 with SMTP id
 ffacd0b85a97d-3679dd299edmr5604398f8f.26.1720282396688; 
 Sat, 06 Jul 2024 09:13:16 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3678eb6593bsm10857688f8f.93.2024.07.06.09.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 09:13:16 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] timer: mtk: skip setting parent with dummy fixed-clock
Date: Sat,  6 Jul 2024 18:13:02 +0200
Message-ID: <20240706161303.9110-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Skip setting parent with dummy fixed-clock. Upstream linux might declare
an additional clock for the mtk timer and that additional clock might
also be a fixed-clock defined in DT. Setting parent of a dummy fixed-clock
resulta in error hence mtk timer fails to probe.

Skip setting parent to permit correct probe of the mtk timer.

Fixes: d3c3606c5cc6 ("timer: MediaTek: add timer driver for MediaTek SoCs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/timer/mtk_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/timer/mtk_timer.c b/drivers/timer/mtk_timer.c
index 8216c289837..06deb23eb99 100644
--- a/drivers/timer/mtk_timer.c
+++ b/drivers/timer/mtk_timer.c
@@ -73,7 +73,8 @@ static int mtk_timer_probe(struct udevice *dev)
 		return ret;
 
 	ret = clk_get_by_index(dev, 1, &parent);
-	if (!ret) {
+	/* Skip setting the parent with dummy fixed-clock */
+	if (!ret && parent.dev->driver != DM_DRIVER_GET(fixed_clock)) {
 		ret = clk_set_parent(&clk, &parent);
 		if (ret)
 			return ret;
-- 
2.45.2

