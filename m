Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFBAD185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA4A84159;
	Thu,  8 Jan 2026 14:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="T+FHzWwE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61172839F1; Thu,  8 Jan 2026 03:16:52 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6313C83A1E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 03:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F354D10B030; Thu,  8 Jan 2026 03:16:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1767838608; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=M4R1rt4JJ0VTT2QVkLIgEj32qluymtWkoZYOJKHSwYM=;
 b=T+FHzWwEz1bX1gvj8dhtoh9auZzh8bnS2QVJcwdusL5kCo3Gpp5m+SQDgJOy0h/Bi+VMZh
 LzIAuvcKnf1Tzm9ZXkasUlvAve3rtUmjm6s8LLwVsxsoibSrB03TYSfaypog9cr94E0Ow/
 6YwyyQ7U0B9gWSg1FjRQx+2bafS6d6xCXOojUeQtEg23B4YKpRk0igbPd0plprjVDQchoZ
 XtwG2wl7SqRZpQXqSDMlPy7fWaFRXtBDbuQM/NkRAcHYDOcZzl0+ZKT/TLwARR/Cvtbmad
 qpmygU6T9C6SGkTYqsnZp3uEgCGrpGucrtSnpDXwZj0dJmhL/idrOfyMPP8EEg==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Antonio Borneo <antonio.borneo@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Use CONFIG_STM32MP15X to discern STM32MP15xx on
 DH STM32MP15xx DHSOM
Date: Thu,  8 Jan 2026 03:16:28 +0100
Message-ID: <20260108021645.518220-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:16 +0100
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

Use plain CONFIG_STM32MP15X to discern code which is specific to
STM32MP15xx in DH STM32MP1 DHSOM board files.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 board/dhelectronics/dh_stm32mp1/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index 55526189d5a..90590d14941 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -314,7 +314,7 @@ int board_stm32mp1_ddr_config_name_match(struct udevice *dev,
 			return 0;
 	}
 
-	if (IS_ENABLED(CONFIG_TARGET_DH_STM32MP15X)) {
+	if (IS_ENABLED(CONFIG_STM32MP15X)) {
 		if (ddr3code == 1 &&
 		    !strcmp(name, "st,ddr3l-dhsom-1066-888-bin-g-2x1gb-533mhz"))
 			return 0;
-- 
2.51.0

