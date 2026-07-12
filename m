Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC246C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 15:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D335A848A1;
	Sun, 12 Jul 2026 17:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="THlJkkLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264BD8490A; Sun, 12 Jul 2026 17:56:11 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30F6284852
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 17:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69c82519403so116329a12.3
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783871768; x=1784476568; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MYUQAAe59pY7XlJJg/hjmdWXd9sSDiMYaTdNKHhKmO0=;
 b=THlJkkLUt0+YJhdCawgPFklx+w9wia5tTspUKMfg7mQaJerShuZe5pvoii3FMJVSAG
 SGQSAF0Oisyp7kihJIdrPvMRHS5cCFPnOb945bkBH5cRlnXtKTuU25TmIAEN/4oaNNH8
 NM/saYD+ioXWjoK3Jg8o4l7URGwaIWALcvCl70fThDvGMbasQr+W7C8w2SusYu8AICOb
 AkveUR5nvprL+qFeuDWsPgrZcwirdzt0WdFyVNELHBiXK/9Kz3bUbcRzZxWvzfeXSUqf
 UFF1/j8QgfhjGHq6dJG7/dT/DiTd4jPymhOwSnxL9OWRskgsiYHzfpCTviHVRdt5D+9f
 4yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783871768; x=1784476568;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MYUQAAe59pY7XlJJg/hjmdWXd9sSDiMYaTdNKHhKmO0=;
 b=HeUmOCFycjcAmVChHXlyGB5yTPMxMWVlmfiJCU8blZ1DfFkntzcZ4BBktUxT7HwTWG
 //vUbsrnqvpC0UopWvmyOdQEus0VdCzV7a+RlQ6lWeZJWb1b9mK4mEfxtdJiXGuEK8wF
 ieaduXV4V0HOrlX0eXMiSGoWE4RdsAYRN9EnKCftglUa4WujkHgYnULhsjzuyTrvzpoI
 5DdUmzIcjiP2ykkXlSwfPZbENIC76rgMJhWnzDp9woGHYTtKoUMEG8FAFKMICwlqkWsQ
 8WRM6um+aIn+3lI6FgiDIkpjas/vKp+yB5lZjBwJ98NkmW+pkedMdaKzwsgswh9Uykw3
 Z+8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rov4eZ50J66qPM977nF9fwD7ZIcSD+Dgldy6mhY3AfxhrGK/DwR4TOni1Dp7bU2pMJ8ssoq3rk=@lists.denx.de
X-Gm-Message-State: AOJu0YwheLXWMLigPsSUsjMZfR4gLQ8M3s7zhM9+en80bCvZl+addHAF
 BA9DzrQkAsYN034hXyRqVs8X8Xo1nSRwLhDJ+rixx6MlWPFy0uFyt0Xa
X-Gm-Gg: AfdE7ckMnyUh25A2Z8bo1h1Wp3+YdpP0HC4TJSHxkLNR4BarVL4JD4dju70uJmLJSIs
 GLa3LuNz+6GUP0ebirFL2yywnbH6q5e7SBGFCQx4zxb9iGecsEt7hphNrywXuw5S/0AfRrsEfqD
 MlpaooFB29qO444DeYw4OZag/rpQnzZ2aHaHcV4ePObgSGyT3LCiRqilHgbnWwKN47L4g98NZEB
 rTaBBumU7jeJg2riaFtpjWsRBD/LPMdQE2BuUICwpe37dFj2E0Ar5cDE+zcc5Uzrm8ya7gP3+oV
 UBg3cyhpJD0X7bWeybQAe8B8+KpMkEpez5GogEZLWcBc8Qz7wJCr7tTSDB5ZnOJzi/8H2I2MCc4
 ECTm0piIdBKvivM3y4NgrI7+NWXMsT+1RDsbmVWgXVT8SRFB+yGdGEu7UcDtsY76m3/hC8mLAWJ
 xIDgqnAYniLG5WAb2zjyggUM1/1X4sTlQgDEJLxWxcJ3eA7UDLBPU=
X-Received: by 2002:a17:907:728c:b0:c12:6ad8:821f with SMTP id
 a640c23a62f3a-c161f461ccbmr155076466b.7.1783871768395; 
 Sun, 12 Jul 2026 08:56:08 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15cd42b336sm697081766b.38.2026.07.12.08.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2026 08:56:07 -0700 (PDT)
Message-ID: <c386c38c-4abf-4ac6-b9a1-a007438c0c5d@gmail.com>
Date: Sun, 12 Jul 2026 17:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.denx.de
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The Rockchip boot ROM only checks for nand chip 0 and with
reduced ecc strength. Currently only the read page functions
have a condition check added. Fix by adding the same condition
to all read and write page functions.

The NAND_IS_BOOT_MEDIUM option was introduced more recently
then this driver. Use it to behave identical with the Linux
driver.

Fixes: b12dc5d6fa76 ("mtd: nand: NFC drivers for RK3308, RK2928 and others")
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/mtd/nand/raw/rockchip_nfc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
index ea8e67d1a23e..e788fda22a95 100644
--- a/drivers/mtd/nand/raw/rockchip_nfc.c
+++ b/drivers/mtd/nand/raw/rockchip_nfc.c
@@ -440,7 +440,8 @@ static int rk_nfc_write_page_raw(struct mtd_info *mtd,
 	int i, pages_per_blk;
 
 	pages_per_blk = mtd->erasesize / mtd->writesize;
-	if ((page < (pages_per_blk * rknand->boot_blks)) &&
+	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
+	    (page < (pages_per_blk * rknand->boot_blks)) &&
 	    rknand->boot_ecc != ecc->strength) {
 		/*
 		 * There's currently no method to notify the MTD framework that
@@ -560,7 +561,8 @@ static int rk_nfc_write_page_hwecc(struct mtd_info *mtd,
 	 *
 	 * Configure the ECC algorithm supported by the boot ROM.
 	 */
-	if (page < (pages_per_blk * rknand->boot_blks)) {
+	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
+	    (page < (pages_per_blk * rknand->boot_blks))) {
 		boot_rom_mode = 1;
 		if (rknand->boot_ecc != ecc->strength)
 			rk_nfc_hw_ecc_setup(chip, rknand->boot_ecc);
@@ -624,8 +626,8 @@ static int rk_nfc_read_page_raw(struct mtd_info *mtd,
 	int i, pages_per_blk;
 
 	pages_per_blk = mtd->erasesize / mtd->writesize;
-	if ((page < (pages_per_blk * rknand->boot_blks)) &&
-	    nfc->selected_bank == 0 &&
+	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
+	    (page < (pages_per_blk * rknand->boot_blks)) &&
 	    rknand->boot_ecc != ecc->strength) {
 		/*
 		 * There's currently no method to notify the MTD framework that
@@ -700,8 +702,8 @@ static int rk_nfc_read_page_hwecc(struct mtd_info *mtd,
 	 * are used by the boot ROM.
 	 * Configure the ECC algorithm supported by the boot ROM.
 	 */
-	if (page < (pages_per_blk * rknand->boot_blks) &&
-	    nfc->selected_bank == 0) {
+	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
+	    (page < (pages_per_blk * rknand->boot_blks))) {
 		boot_rom_mode = 1;
 		if (rknand->boot_ecc != ecc->strength)
 			rk_nfc_hw_ecc_setup(chip, rknand->boot_ecc);
-- 
2.39.5

