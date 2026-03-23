Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F186F483D7
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB00D84242;
	Mon, 23 Mar 2026 20:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EwjX65lT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12AA6841FA; Mon, 23 Mar 2026 20:53:06 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DB38420C
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d7e565c877so1792429a34.3
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295582; x=1774900382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SOrEQabpXLglfPI+cvSSCjZBxUujruBSy5tFX/otJnc=;
 b=EwjX65lThassIObCesEtoDLtfHXjZJzFnKIa0LUG9k35H1QAuqc8WETRSY+Gvp8zC1
 QAV4DpgvMVM7WTUECl2huuKOOLisu4Rzu9k221MPXkqd/LQS2aakbPtg9v3XOReeJPpG
 JMjXa61gJ3GPWFqvTiI3eRXiEAiK7RJvlcoJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295582; x=1774900382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SOrEQabpXLglfPI+cvSSCjZBxUujruBSy5tFX/otJnc=;
 b=nseYs6DHv1FPcwLCIoURgv2ugDKH4oObPgXQm/EXaKrP1goDA3A+SF1amzMHbG56Ea
 g8qI2glSqoNv6YiBCawT21QUDUwXdLjGAz97QIZ+ci1MwqXl2Xed0bgqcHEHSYtMmOj8
 Gty7KLS+U/KvjcN5Nqf4ws31nu4IElP6St3+QBxRiNCeeDLLzI0I/HvpI6VfsWBbr1PG
 wKQv6+JZDcs4/om2RPkloBBmg75NdshDIl/7JV5Czxd2MuAotRSbltFQAmX5TAQgxQuu
 fwv7OzbXOz5f+f6Gy8lc+L9ufZqnwkL+IAZlAPb2WCtXTFJ9oTToHG+HVrNRQk3YT5O2
 y2KA==
X-Gm-Message-State: AOJu0YycCREaKTs0X5nLYgQYM+x1wgcuiV9VpUUYuHi2zAc5KBI513G/
 txlZOPCINbwA3xso2FYFG2iyCMJkboa+qArkaalyKxPZ5EFYh7KNQSo/0zG2yTyOPsj1EPPFGlV
 YhS3FWCs=
X-Gm-Gg: ATEYQzwDO7OykHUk8umhFRDmoTH6ZhA23pb7ee1OxYtYxykAgC1xipPZ/iOzjEUuse/
 glQMhXaSg5pW/N/bWxbkO/MwV0ETl5+mZLXSYFVTb3O/u67CxKzk3Kz5cy2rhYUXLZBJYKq0ej7
 jH5vCzy1gcSCj1lT+uXwxmz8d8pw6scoamFS1hl1YPj2JLeo97dYoxOr7wfo2x/HHj+JWKpqcid
 ONAKXqvuVE4DoLThyTO2mREv+41hAujxUvgYOZJQG+d8/eSHB8/7Fi5eLKwtJa+yPdjpXJ3mmXw
 dyGcpqAQV9gIfB9d8g/JeLcjg18w+MYEgLg00qAwg2lIZFWXGKgp1VImOHh1hL7ojQomvRnSgc+
 6GII1x8O3cqJXf4KKjaW3oIqPs/r7nHqJkh8Ojrm6FRTDNdBj5a9TTxV5J0FETyFqLPgK4Zlcys
 Nv3YBIhXs90I+0gTAOhet1trQ9XSnA5aaj13fy9CKsfuBMGNGi8Taaci6KUs5IqZ2AGB+D9UmaI
 Upfpj4RSRaVgA6cE90m3TXWRiyt658Y2aeCawr3cSFeyU64+eI=
X-Received: by 2002:a05:6830:4989:b0:7d9:b4dd:c34a with SMTP id
 46e09a7af769-7d9b4ddcca4mr3437191a34.7.1774295582509; 
 Mon, 23 Mar 2026 12:53:02 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eabe6248sm10108130a34.2.2026.03.23.12.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:53:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>
Subject: [PATCH] net: Correct dependencies for HIFEMAC_ETH
Date: Mon, 23 Mar 2026 13:53:00 -0600
Message-ID: <20260323195300.2363561-1-trini@konsulko.com>
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

The HIFEMAC_ETH functionality can only work with both DM_ETH_PHY and
DM_MDIO enabled (it calls one of the functions that requires both), so
express this dependency in Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jerome Forissier <jerome.forissier@arm.com>
---
 drivers/net/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9d4e9f069701..ed07e286676c 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -983,6 +983,8 @@ config HIFEMAC_ETH
 	depends on DM && OF_CONTROL
 	select CLK
 	select DM_CLK
+	select DM_ETH_PHY
+	select DM_MDIO
 	select DM_RESET
 	select PHYLIB
 	help
-- 
2.43.0

