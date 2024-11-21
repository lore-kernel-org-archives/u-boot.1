Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DB7D75BB9
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7B64896D1;
	Thu, 21 Nov 2024 06:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166785;
	bh=VBNZftrLbLsQX7KiNR7nYWrT1LxxbaJuIQ2xgVG1DFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dCPEGu6d1J8mxdl9s3SHuQmUHtJB/+k0c9MLU8PLAM3uv5uYwVIsVLwzdWk2t0nab
	 m5SEaD4pIKCIc8KJo2TUxRpD2YOqSq09jck6JNMKkh/0TgV1UWwo+di6OrLiWKdsfi
	 O2na1orpWl8+zKrpRXfl9OLvguLsSEuUF+DcvEIn93kpVzzwFhdyac2uNun10VIerL
	 Q8tz8kszeAcj3uKbXDP6snpSGm1m2Ql5AX7VqNcgWSFGBQZl/FhUHk5s+5UaXe1iH0
	 Mdg2gTC592hajWmfB8b8/ZnRu1p2YrsKg0I8ZoL1Wk9rCmt84vHAWEVUgd7siLKOJ1
	 0yApg1gJ+KEHg==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8D9B0896AC;
 Thu, 21 Nov 2024 06:26:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166784;
 bh=VBNZftrLbLsQX7KiNR7nYWrT1LxxbaJuIQ2xgVG1DFY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LnKUwgo1edRrjHtQibOMUpvNHoEl73en/bWSUg+XU1REKLAcDwnmNQqjCj/2VZ0b7
 hbj/2SdXUJxUEnhogqd/x18L1jMqtjGJHM5pzso8tzafhfKe5H8TdLqJ5WxrGelHWk
 6plSIz469aWEJvgbHYv8vfFk1Fy3rU47PIvh20gzJIC7d5CnVL3NUp7f7B14oBWoCw
 VOAbcrmL1YYUUcU36XIiiwyMiz1fqAPzt28KwGnDepKUTMLnF4hdsguEhXIHA3PMeq
 Vcd7fMbNJUlREKINMd5RFQzyXpEoglz+iHkkmzEFAAkIhu5Q3aYY0t2uuMAOjF4hPj
 u65FIvfT2yTRA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Alessandro Zini <alessandro.zini@siemens.com>,
 Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 17/20] siemens: capricorn: get module name from eeprom
Date: Thu, 21 Nov 2024 06:25:58 +0100
Message-Id: <20241121052601.72880-18-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
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

From: Enrico Leto <enrico.leto@siemens.com>

The eeprom contains the information on which module
we are running, so read it from the eeprom and print
it on the console.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

(no changes since v1)

 board/siemens/capricorn/board.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index 484e2707183..390a7b0d841 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -314,6 +314,7 @@ int checkboard(void)
 int board_init(void)
 {
 	struct chip_data eeprom_data = {};
+	char module_name[16];
 	int ret;
 
 	ret = siemens_ee_setup();
@@ -322,6 +323,11 @@ int board_init(void)
 		goto skip;
 	}
 
+	/* Get module name from EEPROM */
+	siemens_ee_read_data(SIEMENS_EE_ADDR_DDR3, module_name,
+			     sizeof(module_name));
+	printf("CPU module: %s\n", module_name);
+
 	ret = siemens_ee_read_data(SIEMENS_EE_ADDR_CHIP,
 				   (uchar *)&eeprom_data,
 				   sizeof(eeprom_data));
-- 
2.20.1

