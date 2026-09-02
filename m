Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF98C624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 15:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4312A606F1;
	Wed,  2 Sep 2026 15:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XlaIm4ISbLGm; Wed,  2 Sep 2026 15:51:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788364261;
	bh=DhBBbMoREafZ3Yb7o7FgakyImHKUfBdNIVma6yCaXdE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A9tm5NB9yu63Av8IWWIktvVObKvdii+Tldb3ZL0AnUHCCWuXRdOSi5zaGqyq65wp7
	 URO4KL5YQyGT9foVqGKAD4jwqoyxDU2F4xZJPtc3pyHV7wCL+aU+Z1Xlxpt53fDAKL
	 aFl9WKKR4h82KFw1liFjVONiEBYPTkl3r0HFDnsxdGmbEHi4dzfxNxEsUi4a9GV6OA
	 hBwJsgCoVI2PXzA8l4g/MO8zrf4qKrJR5ypbuH3k20Gr6kPOb5yKmFsVutIrbJkbK5
	 RJJn8zlCkmmq/4TogkE9KZSybwkQDMTN/dA8O5FUl0/R2JlxtgKef8IRG+DYh1cq28
	 Q0KM1T3uSh8rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23150606C4;
	Wed,  2 Sep 2026 15:51:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C7F161D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C59E940753
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ILQuPWYX6lZz for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 15:50:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Qu6GtXSa
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0AD8C4074A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:50:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 75DC011D5D1; Wed, 02 Sep 2026 17:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1788364251; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=DhBBbMoREafZ3Yb7o7FgakyImHKUfBdNIVma6yCaXdE=;
 b=Qu6GtXSaKrdECjy6LpVIsJ2HNnp4dxNhQahH9ZQn6X4TgFHViu3k90KIEG5gZ+Q6iIy/Le
 FF4sOuXUycJmMsEH1nuBL8zgQJWV2ea5B4aWKgZ5+F8KdFymBCEaPrSrvtBt230U0AyGOI
 kLEAelFDzRrs5mo1+Ca6DXHjGLXHVRAGp39KU1VIGU9iQStoVC7ldBOnHf/k4BnFB71aPJ
 CmuA+4cmHI3p1OZUyBwX0nNthHXmdYLjodgz9VRThqwid/Ek8IKeCaJ3lrGeIYcYJelrDl
 WW91wpxiuzN9arE8FhOCtk8JSnZ55HkkZDmI6X4Kn8wejHywsZO6nYZHzBIu+A==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: imx: Increase malloc area size on Data Modul
 i.MX8M eDM SBC
Date: Wed,  2 Sep 2026 17:50:39 +0200
Message-ID: <20260902155048.801588-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The malloc area size may run out during DFU usage for bootloader update
with "dfu_get_buf: Could not memalign 0x800000 bytes" error message.
Increase the malloc area size to prevent this problem.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 configs/imx8m_data_modul.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/imx8m_data_modul.config b/configs/imx8m_data_modul.config
index 18c7bb536fa..92940ddb947 100644
--- a/configs/imx8m_data_modul.config
+++ b/configs/imx8m_data_modul.config
@@ -196,7 +196,7 @@ CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=20
 CONFIG_SYS_EEPROM_SIZE=16384
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_SYS_MONITOR_LEN=1048576
-- 
2.53.0

