Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8FED49C90
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 09:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88CA18426E;
	Fri, 30 Jan 2026 10:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SL5JlXQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32117842E0; Fri, 30 Jan 2026 10:36:01 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ACC18421E
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 10:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregory.b.dev@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso19962825e9.2
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 01:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769765759; x=1770370559; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IEmCF3VRwyjVDxkaWlOOLYEeInzf0LYtmam4+6JjUSk=;
 b=SL5JlXQjUi0cLtHpKUlIemopqo9h/qn7+V9V/HFT3HXYTKWN/4lVCSj774e9cpaCWq
 Y7Up6c10WqVaScGH8a6cbAza/qYrrvzqaXyOdS7z05m78c3Ip1D4plD/3uR5Rd1YopAv
 ncRyLJq53DVfYyUBphpsLhrRsWN/PEFae3u9cSwklKsdyY1Hcahv8iJdXWDzyl7mUDTi
 oGZ/mhHiIfpPsXODzZ+365f3zp9+QIY62+C7AZ/gHH2ONWnOyv/WTxtjhwA5ohiXO2DB
 nyZy02AXpYPk6X6mVVPsxjr8Uj16xE24aF9Z1v/s/NtBoOwA5ooIqEiznnkdM8/yWuqV
 450A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769765759; x=1770370559;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEmCF3VRwyjVDxkaWlOOLYEeInzf0LYtmam4+6JjUSk=;
 b=xGSe8kN8q8wRsoJ1GitNSCcHBnxMk+8/pBF0b+KY4zLqZYYgM5T9FF+6WisvJO51qZ
 Wge2HAMKmB0tq8+iEwTYoVgHB6QL8IcgoETrsX1dT3VlAsxW5//vxoQmAvu3BOnOYHxD
 EO3u3KfjnzbsmUzc4UrNKQ54O4Dst663U7J7EE5GK7FBCZ93F1strEYnR3KnibWtkwAZ
 gNc5yPerQvaD5CZsqpVDMobSGDm7li2Uonj8xwkJ7ppbHareE0EwFzT3MacgJH6kpLv/
 IvEHNBHi9KVABR451eZQyBrgHgGA7UyHW7mNWtTrem7JD5ER5ai6TZoZcvCUtLRINiEQ
 mkkw==
X-Gm-Message-State: AOJu0YynZ+CJIQSQW/3Igj6dJv8ZZVMSKSrTxu5fhsgVpBHRuMVqLjO3
 Wp4naCxWJ01lVq1Wju4PYsUEh8F2se1efdtRe+rA4VcA3kqMdEiSAUYeQoFCBg==
X-Gm-Gg: AZuq6aJh+V8W7xgDnr4P2klqkEc6rlueHFsB6mDJDWohxyhSEOxK31J4u6RI+EIirBn
 Tj4hMo/zdk8mxbKPOOWHSNUTyJyWlh2rDuUdT5MHeaz2wJef6nJTgFpNZC+wXqfbDzz+i27z8LB
 b2Fr8rGmuXuLmIXU2wOx+ksMSO3e5GOru31LOaZr65GX1Gz19z12PN62dnck5Jr5YXsTebo12hk
 cjN8xflExEvTJyrL3HE3lADUn4TksAQcsMyX4Xm/0WjNgENp2zhx6XOr7uH06/5mb9wSPG8fCAR
 3qQn+3Tsge7YzQ2xF6mUzS+EMZ0v6XRyUIUGbJOaxnBkj+qwP24k/1jmHeRb4FYUxH9te++m1ws
 fiJHRHgas+gCMLoQh78aqT+tSLZzDGTfrqo+NuaL9qMwY2KwokiEOXeZX5zpMvSKJGrJeP76IQe
 ChZL2ELgnvxxSkn1EsW3imbdnuqVafaa0IZLJoE7WC74BHotN5y+oLWDnK/DS4LuHXoQWVqQ==
X-Received: by 2002:a05:600c:6298:b0:480:5951:fc1e with SMTP id
 5b1f17b1804b1-482db45fbf4mr23480665e9.11.1769765758530; 
 Fri, 30 Jan 2026 01:35:58 -0800 (PST)
Received: from localhost.localdomain (175.178-64-87.adsl-dyn.isp.belgacom.be.
 [87.64.178.175]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce4c3c6sm186207955e9.10.2026.01.30.01.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 01:35:58 -0800 (PST)
From: Gregory Baudet <gregory.b.dev@gmail.com>
X-Google-Original-From: Gregory Baudet <Gregory.B.dev@gmail.com>
To: u-boot@lists.denx.de
Cc: Gregory Baudet <Gregory.B.dev@gmail.com>, Peng Fang <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: add support for JESD84-B51B with CSD_REV 9
Date: Fri, 30 Jan 2026 10:35:39 +0100
Message-ID: <20260130093539.10167-1-Gregory.B.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
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

This patch allows correct version detection for newer eMMC devices
following the 5.1B version of the standard. This new version of the
standard introduces CSD revision 9, and a new decoding rule of the MDT
field in CID register.

Signed-off-by: Gregory Baudet <Gregory.B.dev@gmail.com>
Cc: Peng Fang <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/mmc.c | 3 ++-
 include/mmc.h     | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 7dadff27abe..d9e6860bc74 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2343,7 +2343,8 @@ static int mmc_startup_v4(struct mmc *mmc)
 		MMC_VERSION_4_41,
 		MMC_VERSION_4_5,
 		MMC_VERSION_5_0,
-		MMC_VERSION_5_1
+		MMC_VERSION_5_1,
+		MMC_VERSION_5_1B
 	};
 
 #if CONFIG_IS_ENABLED(MMC_TINY)
diff --git a/include/mmc.h b/include/mmc.h
index 51d3f2f8dd5..47b0f11877d 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -54,6 +54,7 @@ struct bd_info;
 #define MMC_VERSION_4_5		MAKE_MMC_VERSION(4, 5, 0)
 #define MMC_VERSION_5_0		MAKE_MMC_VERSION(5, 0, 0)
 #define MMC_VERSION_5_1		MAKE_MMC_VERSION(5, 1, 0)
+#define MMC_VERSION_5_1B	MAKE_MMC_VERSION(5, 1, 1)
 
 #define MMC_CAP(mode)		(1 << mode)
 #define MMC_MODE_HS		(MMC_CAP(MMC_HS) | MMC_CAP(SD_HS))
-- 
2.51.0

