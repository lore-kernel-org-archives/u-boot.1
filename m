Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F567C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82006815D1;
	Wed, 19 Mar 2025 04:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354925;
	bh=QGUYQhUhHc3Bk3jIkJallS6Cd1BGcM3goZLiHfEiicI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k4dPwV25ZhrhGAHKK0xjwD5Mli3emLUX2NkxmgvcD7DF6+7D/HhOipFm+/G883yqG
	 RClj+hXk0lDcO+4KuWIg6MCL2fzcdfAWQlpuDb/ZjXtqppNV5yMi7D16p9yK4DhP8k
	 DMEE80hCbWtLrCRdTctn6r/5zlleiK6KR9sfnmXjMLNFN89gpC/CGaUBqL8t7cBYOv
	 c5MvF2A892YGBNxpShzLeG4AxhrQW5JyiL5b9inK04pMR8eLkgE4USK7F/ApAmgfBn
	 x+gQsfpkH1NkWo85w0UZ8/OrD/uiIMI3rR//YkcYqOFEez1pVoxfkrLv6/jDSoaWiN
	 ArccUO3vtbblQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C828191C; Wed, 19 Mar 2025 04:28:44 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE2C88141E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="PyokHya/"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E0D55103BB5FD; Wed, 19 Mar 2025 04:28:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354921; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=QGUYQhUhHc3Bk3jIkJallS6Cd1BGcM3goZLiHfEiicI=;
 b=PyokHya/NGCedFKW/JBkXsFNXT8QCri8SB12mzVgZSMY3FOKnEs3zBmnDVzimCVZ4WOXgj
 bKFa7LMiLGns/FDIko0Z+eiilTwUaNen2qonyRkZNQIE8GYcbIfoLBdgrajNDFwjLk+5ha
 xc2un7cTr1GCyRJZ6D++iuPC8aj2J1jRAxLt7vG78JOXBAH+GoGBckI2kq8k2HPNUvFoAX
 OzyP4Afq4dLeuf0rf80aCicDq7wIXZIYdpmoFqpCPHulnARHHF+Ak26Hq5R8cQUEFtLL8C
 NSC38U3xvgwoLArGTklS0bAHSOIzZs6FpBo98AJ5K2S77GhRff3o6wHvY3Pirw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
Subject: [PATCH] arm64: imx8mp: Gracefully handle disabled ENV_IS_IN_SPI_FLASH
Date: Wed, 19 Mar 2025 04:28:27 +0100
Message-ID: <20250319032828.249156-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

In case ENV_IS_IN_SPI_FLASH is disabled, returning ENVL_SPI_FLASH
leads to failure to find environment driver on start up. Fix this
by testing whether ENV_IS_IN_SPI_FLASH is enabled and if not, then
return ENVL_NOWHERE instead.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index 4af3cbe9fe2..4275436b128 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -186,5 +186,7 @@ int board_late_init(void)
 
 enum env_location env_get_location(enum env_operation op, int prio)
 {
-	return prio ? ENVL_UNKNOWN : ENVL_SPI_FLASH;
+	return prio ? ENVL_UNKNOWN : CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH,
+						       (ENVL_SPI_FLASH),
+						       (ENVL_NOWHERE));
 }
-- 
2.47.2

