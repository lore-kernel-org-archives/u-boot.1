Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C794E6ADE3
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 16:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CFCB8944D;
	Sat, 23 Nov 2024 17:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732380811;
	bh=VBNZftrLbLsQX7KiNR7nYWrT1LxxbaJuIQ2xgVG1DFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N1EjlxZceGCWwdf1ii6njDx0c+nrkNVCuHxNj2qc4uraIXOtUWXXaLJmFo5VH/RTH
	 wVyVLaOwA48TlNdL01H2pM9xrcI34Sd7n42jELn/ZK5aIJoPhumcbJBDGl5rm0HMNa
	 At1b0POdW8m1DEh1PHrgPABjiUlvk76tbAXL3QUXOFMC8werUkoAr0Xa3yxPQwEeVH
	 3bBLt/X0I4ghMTvBbeblKKiHNrBWVp1erPIgemK0dD/A5J2p/EJjKB6W5oZ1m4jDSk
	 zO55t0/MxFhPJiSieGuHqSNT39wrmW9WS7h1pimoqePjKGlv1hDGTSSWdtOfJ+n7mX
	 vkev25M21EuUg==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 327EE89430;
 Sat, 23 Nov 2024 17:53:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732380806;
 bh=VBNZftrLbLsQX7KiNR7nYWrT1LxxbaJuIQ2xgVG1DFY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JDKB7VJG/CGBatiwgc/fwpf7mU9iaIG2Zi24rNrig1etX0ODftivfnJ5bZ9XmnK6w
 x6J2kLaVBifjU9VfWaagAmdPmdDq8jXrqLw2ZhL+iawa3sdW/jtdf0D2JgrG07lzwy
 qj4GoSq1WXbOSIqSHBzRRhh6h+h/BL326s6HOqHMxM+tSUYDeBKWR1TBBW1DrcZOWt
 l2ICaCgXcGzqwKcUsGZlMDX6SmotHzj2vaQWFvCkSUoTdPLbNOrGD47CmBntB4PgV3
 c40LNYYedMZiJqvCrsGxtJq1vA7HAXL3CfPQycT2kjYUYRd2SNYkIuMYQfkrwUq0vo
 Q/SHcQCD0WVSA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Alessandro Zini <alessandro.zini@siemens.com>,
 Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 17/20] siemens: capricorn: get module name from eeprom
Date: Sat, 23 Nov 2024 17:53:01 +0100
Message-Id: <20241123165304.100538-18-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241123165304.100538-1-hs@denx.de>
References: <20241123165304.100538-1-hs@denx.de>
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

