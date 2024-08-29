Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD681C6FD35
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 08:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44BF588B78;
	Thu, 29 Aug 2024 10:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z9GQei4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9AD888B70; Thu, 29 Aug 2024 10:08:58 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F8A688B37
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0F6A8A43C65;
 Thu, 29 Aug 2024 08:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C591BC4CEC6;
 Thu, 29 Aug 2024 08:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724918934;
 bh=e/4vSjP70sPiO5zZCVqsR//nrKQFR9fTKzsnBpqpKU0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z9GQei4/IGAGgNJZ7P4VKOOmK5AY26e45HJ4IBNMu3VePxkKsWVHyfPak2dwfP2LA
 v4wOHDTocAX5/aTFiSvHeyLXvySNjBud0pKBYA7yRJSfCUD7hPudTUwe50VJPTxtZe
 pqD63OWWqaVLthU+BQIuGyDEaMaZi9C6wKE6Y5HMqckNsa5jxu194o3CKcMKYqH6ZT
 uLx86oR++26Vn9+i4afbA4DcKW5IFHl/aEAx1UZY9oGa/sxWMpljHmAc9ggttuw2kt
 37NjOOXiFffddda7Yl9VuB4j/I4zEbmJJ9//kkvzxfcHGvDPkFBwgvK7DmBWkBEmQP
 N4GYvA1QjlFzg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 1/3] arm: mvebu: turris_omnia: Rename variable
 holding EEPROM udevice
Date: Thu, 29 Aug 2024 10:08:47 +0200
Message-ID: <20240829080849.20276-2-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240829080849.20276-1-kabel@kernel.org>
References: <20240829080849.20276-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Rename the variable holding the EEPROM udevice from `chip` to `eeprom`.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 board/CZ.NIC/turris_omnia/turris_omnia.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index 2f29d26edf8..392df53a6d8 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -464,16 +464,16 @@ static bool check_eeprom_crc(const void *buf, size_t size, u32 expected,
 
 static bool omnia_read_eeprom(struct omnia_eeprom *oep)
 {
-	struct udevice *chip;
+	struct udevice *eeprom;
 	int ret;
 
-	chip = omnia_get_i2c_chip("EEPROM", OMNIA_I2C_EEPROM_CHIP_ADDR,
-				  OMNIA_I2C_EEPROM_CHIP_LEN);
+	eeprom = omnia_get_i2c_chip("EEPROM", OMNIA_I2C_EEPROM_CHIP_ADDR,
+				    OMNIA_I2C_EEPROM_CHIP_LEN);
 
-	if (!chip)
+	if (!eeprom)
 		return false;
 
-	ret = dm_i2c_read(chip, 0, (void *)oep, sizeof(*oep));
+	ret = dm_i2c_read(eeprom, 0, (void *)oep, sizeof(*oep));
 	if (ret) {
 		printf("dm_i2c_read failed: %i, cannot read EEPROM\n", ret);
 		return false;
-- 
2.44.2

