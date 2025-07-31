Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011B3C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 16:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5412283909;
	Thu, 31 Jul 2025 18:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cDK1SoKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4371683914; Thu, 31 Jul 2025 18:21:43 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 038E583900
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 18:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so11285845e9.1
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753978893; x=1754583693; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dx58BJ13MJqjNDNU+vzWTBzst3+eKGHsRl4zF7KsKWI=;
 b=cDK1SoKcY+bPk9p0hDCZeYD5R6vQdc9NbnQQ858UseL3B34BCq+i2W7Hd0MC58xUwj
 QRhjpBsenpCahGwmotLfFl3bUJHqtS8O+1umds5b+OXHI9sHNmVOLPVPTiEi45k5RSW4
 /jwKB97NeFmASziKZOe6j557MKX/bBMmzapci8+htDI3/MD79RrUMC0R7sh6BXE5nxL/
 wxGLY3U/x/i8iIMmoK3x2Mo5lBSz17JJFFqcp4z+8H1vBPdXMhs/XNLrbcQRx56KGwIP
 1O64dTUcDT950BT2lVDYMjULFWaO2lE2r/0MA5ypKjCkO7zbLHm6BWw7WqaJPnFdEbHj
 T9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753978893; x=1754583693;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dx58BJ13MJqjNDNU+vzWTBzst3+eKGHsRl4zF7KsKWI=;
 b=G5IAcJcM6RT5Lov6RUx+ipcCGeiJeRN2C8CC3E6N0LQs6Le+KzlKPsweeMc1EhOFFo
 Q6OVErZpGC16abXf7wxtkJZsvyDF/s/VCX0XJvfw+eaC4LcXQ1EznD31WW+BjSf/BTWg
 EwAgtQppVSVxk5oNLbbeQGI6xFh+ETLwO5VDYVlDweC0KwOMcsVMao/mRcgYp07JSAfj
 1bzF2SbsCzEevrHwn/TDX1D0sSd4/Vgnk02LYiVJ2s0DdoGNfivJh2n5vhMD5Sq9Zu8e
 JHUJZCcpbJMnXU2Y2gvLBCzfVTcgdyHpsCMrR1iajEBomCI99yZUpNV3bIEv1H5J9XJH
 oaDg==
X-Gm-Message-State: AOJu0YyMkq5xH3RMLuFYM7lfxeHMjDzR/K+TrAq36JWYfHVs9VRl/pAx
 zfbX5W8HPwKh6egW0rV8Ew9bGWNpo9DwgziFxmqW/2c6IqUSwaY4pgLssLExGKEp3YBCmZBYgNs
 BD8PS
X-Gm-Gg: ASbGncv+JdrKumYSfkNaMRl3hlpoocLvJVBECV5JQYMItVWlyPsNXacewoMNrWvQFJy
 kP2GauMRXNiAyogS81C3sUVwWVjCmfE45xTbXRID/Jv+4dAxjonyacI47zMwZ9N3u8byawe3cqc
 zHl4m1n1c2tHM8fJwl8RPX20KaV1CJ8G5Pv0rRx/bnqo/kbZzGMziRj18dB3jxSXfkbOxjBJ1ci
 dEWHf1tG2wvKaTievCEzXcAhbGtD93ma/13/SKB4h15zvEhI8isQNM0D9sHVuk5P9i7P5Z3Liwg
 sKT8evpKuMAHbXF0LwQpc3oCt1ERJIwaTOfcK8tD/beQi2WbwL9oW51dyorjOVoMMzExNoguf0U
 +dK1YRGy726ekzX9k3uwksOaR0ctirC42+Sj45Hck2qaNZedAgw==
X-Google-Smtp-Source: AGHT+IEoIY/SQ35JARPT3oBh1kQ62SoLrdu6pxOHkaLrrguaiDQBMApRq27z0v0Wdh4yBEZEXvhIpQ==
X-Received: by 2002:a05:600c:638f:b0:453:59c2:e4f8 with SMTP id
 5b1f17b1804b1-4589eeb25e2mr32624645e9.1.1753978893361; 
 Thu, 31 Jul 2025 09:21:33 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:14a5:dbc6:afe:7138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589edf56e0sm32653375e9.1.2025.07.31.09.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 09:21:32 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 31 Jul 2025 17:21:32 +0100
Subject: [PATCH] mtd: nand: Do not dereference before NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-nand_core-v1-1-b4d16bc29169@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAuYi2gC/x2N0QrCMBAEf6Xcs4E0JUr8FRG5pqu9B69yJyKU/
 rupj8POMis5TOB07lYyfMRl0Qb9oaM6sz4QZGpMKaYcT0MflHW61cUQhlJyysdYUDM1f2RHGI2
 1zvvjyf6G7cPLcJfvP3K5btsPOsSRk3QAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In nanddev_init mtd and memorg are assigned values that dereference nand
but this happens before a NULL check for nand. Move the assignments
after the NULL check.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mtd/nand/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
index 472ad0bdefb..01ff6e3befa 100644
--- a/drivers/mtd/nand/core.c
+++ b/drivers/mtd/nand/core.c
@@ -201,8 +201,8 @@ EXPORT_SYMBOL_GPL(nanddev_mtd_erase);
 int nanddev_init(struct nand_device *nand, const struct nand_ops *ops,
 		 struct module *owner)
 {
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	struct nand_memory_organization *memorg = nanddev_get_memorg(nand);
+	struct mtd_info *mtd;
+	struct nand_memory_organization *memorg;
 
 	if (!nand || !ops)
 		return -EINVAL;
@@ -210,6 +210,9 @@ int nanddev_init(struct nand_device *nand, const struct nand_ops *ops,
 	if (!ops->erase || !ops->markbad || !ops->isbad)
 		return -EINVAL;
 
+	mtd = nanddev_to_mtd(nand);
+	memorg = nanddev_get_memorg(nand);
+
 	if (!memorg->bits_per_cell || !memorg->pagesize ||
 	    !memorg->pages_per_eraseblock || !memorg->eraseblocks_per_lun ||
 	    !memorg->planes_per_lun || !memorg->luns_per_target ||

---
base-commit: 79f3e77133bd7248e4579827effc13f97a32a8a8
change-id: 20250731-nand_core-399525609ec5

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

