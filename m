Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996C2CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C95836B8;
	Wed,  1 Oct 2025 22:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FGcvOrS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF6A983734; Wed,  1 Oct 2025 22:31:00 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 871E4836D3
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-43f912f9738so109771b6e.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350657; x=1759955457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jlf6BWSlIgTt48r05fpKQJv3Ry0qTTqFWChQKOgyYaA=;
 b=FGcvOrS0Zoq3OQRSpciin1xZdXYiJabAdKH3o2tXr73xgBpJUlUWvBSHcZn2zap26k
 Vi9w3XvTaKU9ZSNBTpnuiqFM1Uj+5IeIUwIw4LGzjZoUe6wnKEmodnTpNK4tMNJwAC6+
 mvz4q6s6ZbLZnSXWE3PoX9bZknhSPgq8JK0LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350657; x=1759955457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jlf6BWSlIgTt48r05fpKQJv3Ry0qTTqFWChQKOgyYaA=;
 b=o3LEZv3zBqqA5AnOvkcFxQLV1Lmr6i5RoyPYd8ygbOnm23WDFMUEcOyi8uynncc0Aj
 nRtrUw+aSoz0LASHWwWtcHi5jm16A+UZb33ZQopv9u8vZzqBq5KLqAkVOe8I80XWW0Tv
 lJXqp039PX93YTo0/SIA7bOoGATfZiI8OFBFVLLxYegqebWDz7ckK59xvhMUJ6kiDLIY
 W5E4GVHzXWA1lkEz+iLS3qA+3K7xwNvEPr60kd/e7qixguOEOIHgsjTxQKhY4b24IrxN
 dySIq6Z8vZ1lJ6wTe3QICknMxSJUNjuqFJuucJYe0exkhuM3Zktn8waK3EIMyFO+Dmu8
 qxYw==
X-Gm-Message-State: AOJu0YxObF3dF0L3N2A4RQT2X/mCnKiV0vadlxc/6v87RJBskQhzUmqj
 YWnRjRJOBb21U/qSPjyVmo1Rq6/Vh/l/WU6lXcnnvD+QGdQrREL2QNeF8QH6vnmgyDlXPSjAT5Y
 yB7QAxeg=
X-Gm-Gg: ASbGncv8rawEkPZOEiWwob5g076L7KIDVETit7HXaeckHkIY93rPN7m/e/fXsZu3Xn3
 QepL7wfBOtysI5KgZ4dLgzvLmwEdCy5qSflO8zuMkW+I4ItqKA2ZNCbkOx9WU1R5uUfiHGekyl8
 Px1i9LfH9bp1HNdkoXjmmRJL2Yjc1eC0vfixM7ChBekTePlNA66apgAqoUImDsZfC0DBBo5JpYS
 9Cu9GIgLpAtf8lzgSbJc07wD36zUC9kjaF9zS53bVO9eTAi8/mpZUVPv7naiU7qCOMmdvBBJb7b
 18HoV/76rXHYK9y1aSLO+QXgLcysYmoxHbhxOksXNgLfRd03EVqaCB3hG5ktGv4/yAqTR9atA03
 oZ775b8ROwn/wL8Rf2oWeEeK54bs0plongoE6MNqUoHTRiMwM/7XNExvlH/msVDj8WbS+q/M9kx
 MsDZFEcCGP8i/nMignAQ==
X-Google-Smtp-Source: AGHT+IHIh6JiNITAsi7TXnBwC26Aa+QsinTwV93HKS4dR+8XI8i46kLpmNP2dp/2ybbIz3PrwHLpEg==
X-Received: by 2002:a05:6808:14c2:b0:43f:58af:39a with SMTP id
 5614622812f47-43fb15bb0c2mr539236b6e.22.1759350657264; 
 Wed, 01 Oct 2025 13:30:57 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43fb25a4c9asm87274b6e.25.2025.10.01.13.30.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] spl: spl_sata: Add __maybe_unused decorator
Date: Wed,  1 Oct 2025 14:30:55 -0600
Message-ID: <20251001203055.2828514-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

It is possible that we will not have enabled the options to call
spl_sata_load_image_raw so use the __maybe_unused decorator to silence
the compiler warning.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/spl/spl_sata.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/common/spl/spl_sata.c b/common/spl/spl_sata.c
index 67fc620d9bea..09f94e662fc2 100644
--- a/common/spl/spl_sata.c
+++ b/common/spl/spl_sata.c
@@ -14,10 +14,12 @@
 #include <errno.h>
 #include <fat.h>
 #include <image.h>
+#include <linux/compiler.h>
 
-static int spl_sata_load_image_raw(struct spl_image_info *spl_image,
-		struct spl_boot_device *bootdev,
-		struct blk_desc *stor_dev, unsigned long sector)
+static int __maybe_unused spl_sata_load_image_raw(struct spl_image_info *spl_image,
+						  struct spl_boot_device *bootdev,
+						  struct blk_desc *stor_dev,
+						  unsigned long sector)
 {
 	struct legacy_img_hdr *header;
 	unsigned long count;
-- 
2.43.0

