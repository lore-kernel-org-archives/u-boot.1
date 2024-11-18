Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BC9D68BD0
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 06:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C751C8940C;
	Mon, 18 Nov 2024 07:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731911263;
	bh=VBNZftrLbLsQX7KiNR7nYWrT1LxxbaJuIQ2xgVG1DFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=USN613uWtAAREt40LAnatCeQlicVoWbzz/txcE9ieCr2VFDKSOFh4H64mQlAQq+3X
	 RBMpIfmM0doUfCWci9Ro19XySdsNHZ2YjQXkTrPMbA8kOvJ0AwgcCyETJG/49uTgLe
	 RiFTQParP07QXAnHsN5Vzxr/xOGZOK5rzPzRdx61/Fla5javHMBE9p8CaZr3y8ZERx
	 DFRwE/ElWmaLccV1/zbw4ZCW333aTB57DqgkiTnQOY/jDhQn4riSeLBqfie/oyIWGe
	 7c4IkF2fDj4/pLUE1fIV+DrYUAaT78Chs/t6K5IZrwIEOvjCV3QlencgutQSKwmtk5
	 fpsq4yvijZh/w==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 945C38943D;
 Mon, 18 Nov 2024 07:27:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731911259;
 bh=VBNZftrLbLsQX7KiNR7nYWrT1LxxbaJuIQ2xgVG1DFY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WLgfg1kAdeolsVQzy1lBejbe+kcwdOynl4NyjU3uj7lm7rWM+tW3+ryLs6md95VKA
 sCyP6fQN/9TdglwsbnLtBdfdjuf4eXYqfASoAKN7DQlPHOZNR8LhRVTiQYEnFdTqg8
 cMSFCCiKLFoU3MlgFzP6Kcal7PgwPa+ukPMUiShOWhCQ5A9YtvH0fqA4Ep+/wkw55G
 zwRSN07CY5zQqk6Xz7cFjk5g9I/wNhogOos9d17NRjjnVCjtjyrk0eMbuL4FgFXPW/
 xw13TRR2xYaAjKn9IzM3+NJnzLiBu9OgCuSTJ+wSYxUUw1GA+n034CUO3w7DARbE36
 y/3nWfLeA9RZQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Alessandro Zini <alessandro.zini@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/20] siemens: capricorn: get module name from eeprom
Date: Mon, 18 Nov 2024 07:27:11 +0100
Message-Id: <20241118062715.32989-18-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241118062715.32989-1-hs@denx.de>
References: <20241118062715.32989-1-hs@denx.de>
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

