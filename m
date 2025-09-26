Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0515CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 08:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A8D282998;
	Fri, 26 Sep 2025 10:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="K2dyEDgh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61F0A82A9E; Fri, 26 Sep 2025 10:20:32 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 714498206E
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 10:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b2d92b52149so368622766b.1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 01:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1758874829; x=1759479629; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bAbD+JMBTijbrArTGmtqnWkXrnJ74ASK3w5zzx3GVyc=;
 b=K2dyEDgh9N4USk/o6s4peRWnF3203HuFHqRhzgKjbfykFB2RlpkpsrpjZtGUi6xpNv
 UYkygdI0Tlmx0rILWvaObo/RQXZH6wAkMjpXyluqLG0U2QcPqHFu99sA6kY7MpfL2vbL
 kVhj6HCo0Ms+rOs+W2n3cWAju+9rh3g7VRNPfbSe+mKHyXNPfjW8seyNw3Mpfq+WOvN5
 MDCreoQ1lxQu5n9UjJTeNWRr52P/cZ2Wl88ckcilrZyxo7Je6V9dBgAwqo/0gpKc97T7
 9/wkNozKPvogWM7FPWwkc7sq05dlGIZrSXogXvJOFUhKAUEQnK5xQ1r6WNvkGEg4dAbe
 xmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758874829; x=1759479629;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bAbD+JMBTijbrArTGmtqnWkXrnJ74ASK3w5zzx3GVyc=;
 b=mJT26NRPiPh+xeIYjWUnjzt2Xqb+m6iOlvlEVCr/2zpDaEKvj+6OTx+bI9MuI6Nkwj
 SA70ctZiFv7oOS7Z8oQPapcklxaR8nDeiZZGArFRH9AjSBrJfj+79BQY5CRCpkVWObVt
 avOt07atXo50al3N1Z5ScZh1KGtlhPZDcMIQakrH7OKGPiqaCPcpDeVahMPrhV6YwkuP
 6CzzadE/9fdDZULJgicRxMjqBx/hKx7sx/+cRFgsB/kVD7r0W9657P06ZgIVfq8fyXqP
 n+HhzZGCLeNCro0T2UIF0lYfAS7Al2UlyEIKEWCEUE6QtItsgzf3elcjNazxZjA1ZGKH
 EZCQ==
X-Gm-Message-State: AOJu0YwO0JZv2t2Dtncq5jgw18PZGEa8bmnHkAWjx+d5tEglvG97EVNv
 5NvIObO6PRknFqsuWvuin6aQt4wFCAcDsz+wPQicQLhqZF5+CnD4TolZC5xC0Q==
X-Gm-Gg: ASbGnctPHzT/+ocUZ5xaceNQIkDVHr1Jgzf4PMG1gYIeE1Cr92QHGFW4AlbmA4tBukt
 P1vGBIx2LTXtChThHuDxKUiEoYRxYQrrhp3ezCDVUamyuqaqE1l/dbd7EZwGubVTOmVwVSscAFw
 5EffcgpjHjnLrZmk8GjoFF2EtEkTenPNvciiF+1FF2pa5Uj9G+YUzJQzr12k4xeK2u/Uoym0hCz
 9WpghNTE4IfNW29Ny4rBlpieXfJDC2Nw3q73XPCN12yoZ3iTtmIiYZ22M8lRMyk3AP3hkzqUPaC
 +nYhiTE0YwIiUj1iU3R4ztXS3VSaA4Q8N4xgrhRsB67mlOR7Lw101if0lyKJ+MmDX8C3+9UqlNS
 4010AFplCLoBLdQ1tovChV6OJ4MWYQQbqdL4FXX7QL3GvrlNrLr5nPvsA5rPmD7rUmPoUgqj8cj
 j7Fak=
X-Google-Smtp-Source: AGHT+IG4cJ63AYUl6ay7IKbkaw0IpFws1cfOmd+LkPbOV1vgWox5BOAiIwZcZatPdvMIPn5gtSxoPw==
X-Received: by 2002:a17:907:7f26:b0:b04:75fe:e88 with SMTP id
 a640c23a62f3a-b34bb9e7465mr590106166b.49.1758874828933; 
 Fri, 26 Sep 2025 01:20:28 -0700 (PDT)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3545a98440sm318500466b.101.2025.09.26.01.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 01:20:27 -0700 (PDT)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] arm: baltos: remove obsolete GPMC_NAND_ECC_LP_x8_LAYOUT macro
Date: Fri, 26 Sep 2025 10:20:23 +0200
Message-Id: <20250926082023.460847-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yegor Yefremov <yegorslists@googlemail.com>

This define is obsolete, and bus width is now handled via
CONFIG_SYS_NAND_BUSWIDTH_16BIT option.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 include/configs/baltos.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/configs/baltos.h b/include/configs/baltos.h
index 5e397c1a0c2..e1ee441a223 100644
--- a/include/configs/baltos.h
+++ b/include/configs/baltos.h
@@ -211,9 +211,4 @@
 #endif
 #endif
 
-/* NAND support */
-#ifdef CONFIG_MTD_RAW_NAND
-#define GPMC_NAND_ECC_LP_x8_LAYOUT	1
-#endif
-
 #endif	/* ! __CONFIG_BALTOS_H */
-- 
2.34.1

