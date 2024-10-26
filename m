Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B79DD10C03
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 20:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C7A88D1C;
	Sat, 26 Oct 2024 22:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729973706;
	bh=AI8Z014tMWdqdq5ib257MCtobCF9uwRX2P2abazBa4A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XGfEvXo78Wa7gXfJ2gHMRsH1FOtWjd6k454MnvMeDwYMDjottGWk18WPEGbD5rq7I
	 Dntmc7SoxihzGUZk/DCIY+FYwEH4H3yiJrqUA6SS8w8Blkzbj7SOm2ujY2uHLyF330
	 YHDhZFBUM0d3fwJQz22U2Jlucmmh2xC/hDtxNYJSasJgx7FawEqPvikYqDDtfszhfA
	 o58E6THrhmxnyPV0uT0IkaJ8WS4jSYXYPkag32w2G3FfJrbAd3XblXeb0OWz9h/0cl
	 a877Ft97gLC1MCQRCBpktPUDMJWTXJRidu4ZMghJ0QI5XollGeLO0ZUL75o2RiuIpQ
	 LGVWfxyhZtflw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CBC7288717;
 Sat, 26 Oct 2024 22:15:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729973706;
 bh=AI8Z014tMWdqdq5ib257MCtobCF9uwRX2P2abazBa4A=;
 h=From:To:Cc:Subject:Date:From;
 b=L718xy0Yugvku9Dwj+2hJU5C3WLROmqLgbv4R0+NvydUgHGhxPl3+YwhMKAE8GJdO
 6yuL5kXRS/jMepFlJgbZPx65JZ7VrbLW0KXLzG/AIuTSTuzsIrLvxSwq2kbZS9DI04
 F6pYFoWkAPRgJ28Fsn3spm1liniImYeOP2Qjk+bi+l+ywHRRxqCQhbiWaTiiJL3e4g
 oQE5hVWenVCXN1pR0olBpwIAanrutg3gEJLzhUgwMib3sQCni2UDCU/2bsmx7zWGWY
 9edGpmkjxa17poBY+0a42hT6MNHiDOiRvJwv2vwTz84ZA8bvU0/AF2mhENDgxl5hB5
 8JBjYmfDLV/iA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: imx: Fix 0Xnn to 0xnn
Date: Sat, 26 Oct 2024 22:14:42 +0200
Message-ID: <20241026201455.171001-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Use lowercase 0x prefix for hexadecimal number to be consistent
No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/arch-imx8m/imx-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx8m/imx-regs.h b/arch/arm/include/asm/arch-imx8m/imx-regs.h
index f1b7526ac77..95a8cc1c637 100644
--- a/arch/arm/include/asm/arch-imx8m/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx8m/imx-regs.h
@@ -15,7 +15,7 @@
 
 #define MCU_BOOTROM_BASE_ADDR   0x007E0000
 
-#define GPIO1_BASE_ADDR		0X30200000
+#define GPIO1_BASE_ADDR		0x30200000
 #define GPIO2_BASE_ADDR		0x30210000
 #define GPIO3_BASE_ADDR		0x30220000
 #define GPIO4_BASE_ADDR		0x30230000
-- 
2.45.2

