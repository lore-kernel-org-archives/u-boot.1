Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEB4F483D7
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91A92841D5;
	Mon, 23 Mar 2026 20:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AdLHbxFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3BC841D2; Mon, 23 Mar 2026 20:52:59 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9C3F841D2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-417571c6083so284601fac.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295573; x=1774900373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TXK8HPRlBs64Xd5OY+lvQfI3kmYfUsLAiKjN4fR94go=;
 b=AdLHbxFfh2mCH2gwmEWT6wVk+MZ2RF5mJ0hTSc83rUbfyfbGeEe9mb6cVVgne+iZSN
 WAf8mlSq7JU2nwtc7I57s0tLqr5uxtXpzKJmHTzszkLjZS3t1+mC6LLyPE8JQsKo/m2A
 VFTIifYskjBaqGw0A2AFJtbjUYogRRlcjXQjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295573; x=1774900373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXK8HPRlBs64Xd5OY+lvQfI3kmYfUsLAiKjN4fR94go=;
 b=fCdPEsVZ7Y3lXfc/kMe01bU/7rJdZl13gcXAlydRqDIYw0BK4imzra1zGQn5A4xtQQ
 fvebir7DPyaV296fPx6hoHnY9XTJ3ku3e5NN7+MgrjtRlYPKmhqBmBI/pWqiHmEfc3eL
 iX2SSLCK0ANOxXBtLJuouv9Aji7WqegkxbBvptCdWJWbt8VibAuuU/NNCXzOzWKNsutZ
 4s5jE1pelTnwrBoYubsqXZCjK2QR4CjlQT8VokE/fvRc70A7loeLW5xYuMK7zS7iDIw8
 7bMZkldypaZnWF+W/yJW4bRzfgOF9TMV9uIyMRO8gDrC7Rar+eC0uMOOP6OHYGWVOnAL
 Z8rw==
X-Gm-Message-State: AOJu0YyoNoWsyS0LT7EuVCw7TCXWB2zaxJ0KSseMnksUvh5EfD8ThA4w
 9WDynrFy93Qwpssh9DDc4ZQ3YTFjedklyBCVB48M/tKpyo5uPCFOZWGuJGWNM1HflZB0bkOhIBI
 Lfd+zpIE=
X-Gm-Gg: ATEYQzw6YMSVBqik7Ts6F/zJeHZmQADGFelYXC12h6dzetxVT5dqUAF854E49b1Xl4D
 38R6dlp3fpYXEzfhQzHY0HLXG1WC2kiNfsFVnm3u/ZbdMhvx6+iQ3AAUVI1on9zYWiuT5wDUh+5
 gMjXiWbMi6yKNnclu3KNywHorwym69KXbX0jYJ778qN7KBBRQMJowEuK0TTYz0C07h58muw6xyK
 BTOAFfMRdOs/ydtlTgg+mgLl8Rr1Te1y9H7/V9AkiB1s94vdUV71c7HLOqi7EZcVdbuA3DrA3YN
 Gxqcuex3VfxcAcKe3a289jjVyzbCenasFWNp834oN80yTKJJmSbxvA0jzJUGrg2pYpVi4uIDs0U
 d5V9c5NFBnBc68nFTBSA3gOIpF6o9jt9/efDtQQU36OopqaoDYg7t5FSlCiL0vLxfB8rXoqHpKK
 GeS/JZPpmbBi7OPJftw9VO/DvKsv87ExwlI3O8UMoWKmltU4xxNqs5RHv2P15SzQij/FcwtuxLa
 ooES3kuRcgg05Vst3uFKN6/gMZuQ/61U8aCEXUPxESRxuLNJww=
X-Received: by 2002:a05:6808:2293:b0:467:1c9e:213d with SMTP id
 5614622812f47-467e5d285femr6559438b6e.10.1774295573193; 
 Mon, 23 Mar 2026 12:52:53 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7ecb194sm7471357b6e.12.2026.03.23.12.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:52:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] w1: Correct dependencies for CMD_W1
Date: Mon, 23 Mar 2026 13:52:51 -0600
Message-ID: <20260323195251.2363468-1-trini@konsulko.com>
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

The CMD_W1 functionality can only work with both W1 and W1_EEPROM
enabled, so express this dependency in Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Peng Fan <peng.fan@nxp.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 7712cb9f3afe..a90102b8cd73 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1395,7 +1395,7 @@ config CMD_I3C
 	  and perform read and write on the connected i3c devices.
 
 config CMD_W1
-	depends on W1
+	depends on W1 && W1_EEPROM
 	default y if W1
 	bool "w1 - Support for Dallas 1-Wire protocol"
 	help
-- 
2.43.0

