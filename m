Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9C9D5E12D
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 082AE89083;
	Fri,  8 Nov 2024 06:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043331;
	bh=BS0wZ4qWdv5fjWJbX+D6ES86qPNdSUqBbl+VI6cSNHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AO06mD1504DhZ4001FuXMjK0TfOX84zuxLRFaW4mbYQPz5x4UJOwEmQp0yl7rIwzt
	 LDU2EaYymp5wc2tx/7pfN/+Ai1UQBAdS7hzvSPo0rew9peOgwojAGY3qvGO+pVS+DX
	 WoCLmIBlvDUl4Dvt62AVbwv4mw9cj0CgwZYnbqKJyoJTlOQl+k7GDWSiyijnQwmtMI
	 FnUlqE/HTp1OD28sIExFeAIcXcnDf/x+doPxbrRdKTH2W2/60RMPwTrwJsZOhBnLkj
	 PaZZoFwhBx+PBzm3VjQxRZYmhycZFVwnXXP11/+TXlV5T/IPNxcvG0VRy6emURhtfK
	 rv+kjKg+1ieSg==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DAAC4891D7;
 Fri,  8 Nov 2024 06:22:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043329;
 bh=BS0wZ4qWdv5fjWJbX+D6ES86qPNdSUqBbl+VI6cSNHc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NWCJspbDukijB2L7sM40ia+KGAZ4s3DDTf1XNHedaEmK4ON6k5qAK05XvyGmWguuO
 ZKAJkYJUIsJ2dw/q0QUSXFZLXjqFQqkTpdMTwU2JQIZN9rMAzfngfHDoqGzB7APfVB
 dzEBTNx4TX6MbXwee8VuPFnPO9YTDxJUSSNu5eayET8mEQ8kg4bY25c3V0GEHMRx7Y
 HVTcTdSv7t4rP2yGXfDyZtmIPQ6cyCT5+Omu8SjrX8jBP/Hu7vrOBa3pOtDYioVXR6
 YC8yuO/p3Cmc+a/uwIon7AdKKiQxM6IdBNcXRYbi5Z8LycmKiQsz8cwyfWNeYpF3V7
 7ZMyPIttmyDtw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 19/22] siemens: capricorn: get module name from eeprom
Date: Fri,  8 Nov 2024 06:21:40 +0100
Message-Id: <20241108052143.26874-20-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241108052143.26874-1-hs@denx.de>
References: <20241108052143.26874-1-hs@denx.de>
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

 board/siemens/capricorn/board.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index cfec649bae9..0c66dcead46 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -319,6 +319,7 @@ int board_init(void)
 {
 #ifndef CONFIG_XPL_BUILD
 	struct chip_data eeprom_data = {};
+	char module_name[16];
 	int ret;
 
 	ret = siemens_ee_setup();
@@ -327,6 +328,11 @@ int board_init(void)
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

